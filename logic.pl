% After the input is processed correctly, the game logic is made here

/*  INPUT VERIFICATION  */

% choose_piece(+Board, -X, -Y)
% predicate to read input, checks if is available and return
choose_piece(Board, X, Y):-
    read_inputs(10, X, Y),
    validate_choice(Board, X, Y).
choose_piece(Board, _, _):-
    format('~`xt The field you chose is unavailable, try again ~`xt~57|~n', []),
    read_inputs(10, Xread, Yread),
    choose_piece(Board, Xread, Yread).
   
% validate_choice(+Board, +Xread, +Yread)
% check if selected slot is playable
validate_choice(Board, Xread, Yread):-
    value_in_board(Board, Xread, Yread, Value),
    Value == -1.


% value_in_board(+Board, +X, +Y, -Value)
% returns in Value the value [0,1,-1] at (X,Y) from Board
value_in_board(Board, X, Y, Value):-
    nth0(Y, Board, Row),
    nth0(X, Row, Value).

% player_in_board(+Board, +X, +Y, -PlayerS)
% returns in Player a string representing the player or fails if space is empty.
player_in_board(Board, X, Y, PlayerS):-
    value_in_board(Board, X, Y, Value),
    player_piece(PlayerS, Value).
        

% replace_index(+I, +L, +E, -K)
% replaces Element E in List L at Index I, Resulting in List K
replace_index(I, L, E, K) :-
    nth0(I, L, _, R),
    nth0(I, K, E, R).

% replace(+Board, +X, +Y, +Value, -BoardResult)
% replaces a value in the board
replace(Board, X, Y, Value, BoardResult):-
    %usar substitute(+X, +Xlist, +Y, ?Ylist)
    nth0(Y, Board, Row),
    replace_index(X, Row, Value, NewRow),
    replace_index(Y, Board, NewRow, BoardResult).

% move(+GameState, +X, +Y, +A -NewGameState)
%  performs the change in the board, replaces current piece with 0 and empty space with player code
move(GameState, X, Y, A, NewGameState):-
    replace(GameState, X, Y, A, NewGameState).

% check_no_neighbors(+Board, +PlayerS, +X, +Y, +Value, -Return)
% checks if there are directions available, if the list is empty goes to next predicate, else return is 0
check_no_neighbors(Board, PlayerS, X, Y, Value, 0):-
    player_piece(PlayerS, Value),
    available_dirs(Board, X, Y, PlayerS, [_]).
% if list of directions is empty, returns 1
check_no_neighbors(Board, PlayerS, X, Y, Value, 1):-
    player_piece(PlayerS, Value),
    available_dirs(Board, X, Y, PlayerS, []).
% if the player piece is different from the value on the board, no need to check for directions
check_no_neighbors(_, _, _, _, _, 1).
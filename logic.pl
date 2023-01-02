% After the input is processed correctly, the game logic is made here

% directions knowledge
direction(1, 'up').
direction(2, 'right').
direction(3, 'down').
direction(4, 'left').

% direction(+X, +Y, +Direction, -Xr, -Yr)
% get position in direction, doesnt check range, can get out of board
direction(X-Y, 'up', Xr, Yr):-     Xr = X,     Yr is Y-1.
direction(X-Y, 'right', Xr, Yr):-  Xr is X+1,  Yr = Y.
direction(X-Y, 'down', Xr, Yr):-   Xr = X,     Yr is Y+1.
direction(X-Y, 'left', Xr, Yr):-   Xr is X-1,  Yr = Y.

% choose_piece(+Board, -X, -Y)
% predicate to read input, checks if piece belongs to player, gets available directions and return
choose_piece(Board, X, Y):-
    read_inputs(10, X, Y),
    validate_choice(Board, X, Y).
% checks if list os available directions is empty, in that case, calls choose_piece again
check_list(Board, PlayerS, _, _, [], Directions, XFinal, YFinal):-
    format('~`xt No plays available for that piece ~`xt~57|~n', []),
    format('~`*t Chose Another Piece ~`*t~57|~n', []),
    skip_line,
    choose_piece(Board, PlayerS, XFinal, YFinal, Directions).
% if List is not empty
check_list(_,_,X,Y,List,List,X,Y):-
    format('~`-t There are plays available for that spot ~`-t~57|~n', []).
     
% validate_choice(+Board, +Xread, +Yread)
% check if selected piece belongs to player
validate_choice(Board, Xread, Yread):-
    value_in_board(Board, Xread, NumbY, Value),
    code(Value,Z),
    write('\n'),
    write(Z),
    write('\n'),
    Value == 1,
    write('- Can move there\n').
% if the selected piece doesnt belong to the player, asks again
validate_choice(Board, _, _):-
    format('~`xt Unavailable piece, try again ~`xt~57|~n', []),
    skip_line,
    read_inputs(10, Xread, Yread),
    validate_choice(Board, Xread, Yread).

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
        
% available_dirs(+Board, +X, +Y, +PlayerS, -List)
% returns in Lists the numbers of the directions available to go
available_dirs(Board, X, Y, PlayerS, List):-
    %needs to check all 4 directions
    check_dir(Board, X, Y, PlayerS, 'up', ListItem1), append([], ListItem1, PreList1),
    check_dir(Board, X, Y, PlayerS, 'right', ListItem2), append(PreList1, ListItem2, PreList2),
    check_dir(Board, X, Y, PlayerS, 'down', ListItem3), append(PreList2, ListItem3, PreList3),
    check_dir(Board, X, Y, PlayerS, 'left', ListItem4), append(PreList3, ListItem4, List), !.

% check_dir(+Board, +X, +Y, +PlayerS, +Direction, -ResultList)
% Checks if there is an enemy piece on the 'up' direction
check_dir(Board, X, Y, PlayerS, 'up', ['up']):-
    opposed_opponent_code(PlayerS, ExpectedCode),
    Y > 0, Y1 is Y-1, value_in_board(Board, X, Y1, Value), Value==ExpectedCode.
% Checks if there is an enemy piece on the 'right' direction
check_dir(Board, X, Y, PlayerS, 'right', ['right']):-
    size_of_board(Board, Size),
    opposed_opponent_code(PlayerS, ExpectedCode),
    X < Size, X1 is X+1, value_in_board(Board, X1, Y, Value), Value==ExpectedCode.
% Checks if there is an enemy piece on the 'down' direction
check_dir(Board, X, Y, PlayerS, 'down', ['down']):-
    size_of_board(Board, Size),
    opposed_opponent_code(PlayerS, ExpectedCode),
    Y < Size, Y2 is Y+1, value_in_board(Board, X, Y2, Value), Value==ExpectedCode.
% Checks if there is an enemy piece on the 'left' direction
check_dir(Board, X, Y, PlayerS, 'left', ['left']):-
    opposed_opponent_code(PlayerS, ExpectedCode),
    X > 0, X2 is X-1, value_in_board(Board, X2, Y, Value), Value==ExpectedCode.
% returns a empty list in case of a wrong direction
check_dir(_, _, _, _, _, []).

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
%  performs the change in the board, replaces current piece with 0 and enemy piece with player code
move(GameState, X, Y, A, NewGameState):-
    replace(GameState, X, Y, A, NewGameState).

% initial(+Identifier, -Board)
% Initial board 
initial([
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
]).


% index_to_board_size(+Identifier, -Size).
% Gives the Board Size from a Menu Identifier to print out in menu
index_to_board_size(1,6).
index_to_board_size(2,8).
index_to_board_size(3,10).
index_to_board_size(4,3).

% opposed_opponent_code(+PlayerS, -Code)
% Code takes opposed player code
opposed_opponent_code(PlayerS, Code):-
  player_piece(PlayerS, Piece),
  Code is -Piece.

% opposed_opponent_string(+PlayerS, -EnemyS)
% EnemyS returns the string of the enemy of PlayerS
opposed_opponent_string(PlayerS, EnemyS):-
  opposed_opponent_code(PlayerS, Code),
  player_piece(EnemyS, Code).

% Pieces codes for board representation
code(-1, 32).   % ascii code for space
code(0, 216). % Ø - Player 2
code(1, 215).  % × - Player 1
code(9, 181).  % µ - Used for floodFill
% Pieces codes for each player
player_piece('Player 1', 1).
player_piece('Player 2', 0).

% Switch player
player_swap('Player 1', 'Player 2').
player_swap('Player 2', 'Player 1').


/* BOARD PRINTING */

print_board_middle_separator(1):-
  write('|\n').
print_board_middle_separator(X):-
  write('+ - '), X1 is X-1, print_board_middle_separator(X1).

% When the counter reaches 0, it ends
print_matrix([], 8, _).
print_matrix([L|T], N, X) :-
  code(1,P), write(' '), write(N), write(' | '), write(' | '),
  N1 is N + 1,
  print_line(L), nl,
  N < X - 1, write('---+  | - '), print_board_middle_separator(X),
  print_matrix(T, N1, X).
print_matrix(_, _, X):-
  write('---+  *---'),
  print_board_separator(X).

% Prints a line of the board
print_line([]):-
  write(' ').
print_line([C|L]) :-
  code(C, P),put_code(P), write(' | '),
  print_line(L).

print_header_numbers(Inicial, Inicial):-
  write('\n').
print_header_numbers(Inicial, Final):-
  write(' '), write(Inicial), write(' |'), N1 is Inicial + 1, print_header_numbers(N1, Final).

print_separator(0):-
  write('|\n').
print_separator(X):-
  write('+---'), X1 is X-1, print_separator(X1).

print_board_separator(1):-
  write('*\n').
print_board_separator(X):-
  write('+---'), X1 is X-1, print_board_separator(X1).

print_header(P, X):-
  write('      |'),
  print_header_numbers(0, X),
  write('      '),
  print_separator(X),
  write('---+  *---'),
  print_board_separator(X).

% Prints the board according to its state
display_game(Board):- 
  nl, code(0, P),
  print_header(P, 10),
  print_matrix(Board, 0, 10),
  write('         ').

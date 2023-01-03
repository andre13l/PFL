% option_dif(+Code, -Difficulty)
% Gives the Difficulty associated with the code provided as an option
option_dif(1, 'Easy').
option_dif(2, 'Normal').

% clear/0
% Clears the screen, for better user experience (UX)
clear :- write('\33\[2J').

proj_logo :-
  write('######## ########  ######## ######## ########   #######  ##     ##   \n'),
  write('##       ##     ## ##       ##       ##     ## ##     ## ###   ###   \n'),
  write('##       ##     ## ##       ##       ##     ## ##     ## #### ####   \n'),
  write('######   ########  ######   ######   ##     ## ##     ## ## ### ##   \n'),
  write('##       ##   ##   ##       ##       ##     ## ##     ## ##     ##   \n'),
  write('##       ##    ##  ##       ##       ##     ## ##     ## ##     ##   \n'),
  write('##       ##     ## ######## ######## ########   #######  ##     ##   \n').

% menu_header_format(+Header)
% prints the header of a menu (UX)
menu_header_format(Header):-
  format('~n~`*t ~p ~`*t~57|~n', [Header]).

% menu_option_format(+Option, +Details)
% prints the option number and associated details in a menu-like format (UX)
menu_option_format(Option, Details):-
  format('*~t~d~t~15|~t~a~t~40+~t*~57|~n',
        [Option, Details]).

% menu_text_format(+Text)
% Prints a center-aligned text inside a menu (UX)
menu_text_format(Text):-
  format('*~t~a~t*~57|~n', [Text]).

% menu_empty_format/0
% Prints an empty line inside a menu (UX)
menu_empty_format :-
  format('*~t*~57|~n', []).

% menu_sec_header_format(+Label1, +Label2)
% Prints an header with 2 columns for a secundary table (UX)
% This is used for better user readability
menu_sec_header_format(Label1, Label2):-
  format('*~t~a~t~15+~t~a~t~40+~t*~57|~n',
          [Label1, Label2]).

% menu_bottom_format/0
% Prints a row of '*' to end the menu (UX)
menu_bottom_format :-
  format('~`*t~57|~n', []).

% banner(+String)
% Prints a banner with a String inside (UX)
banner(String):-
  format('~n~`*t~57|~n', []),
  format('*~t~a~t*~57|~n', [String]),
  format('~`*t~57|~n', []).

% banner(+String, +BoardSize)
% Prints a banner with info related to board size
% It is used to inform the user whats being selected
banner(String, BoardSize):-
  format('~n~`*t~57|~n', []),
  format('*~t~a - ~dx~d Board~t*~57|~n', [String, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).

% banner(+String, +BoardSize, +Difficulty)
% Prints a banner with info related to board size and Difficulty
% It is used to inform the user whats being selected
banner(String, BoardSize, Difficulty):-
  format('~n~`*t~57|~n', []),
  format('*~t~a (~a) - ~dx~d Board~t*~57|~n', [String, Difficulty, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).

% banner_bot(+BoardSize, +Difficulty)
% Prints a banner with info related to board size and Difficulty but only for PC vs PC
% It is used to inform the user whats being selected
banner_bot(BoardSize, Difficulty):-
  format('~n~`*t~57|~n', []),
  format('*~tComputer (~a) vs Computer - ~dx~d Board~t*~57|~n', [Difficulty, BoardSize, BoardSize]),
  format('~`*t~57|~n', []).

% menu/0
% This is the main menu, with all the options available
menu :-
  menu_header_format('MAIN MENU'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Player vs Player'),
  menu_option_format(2, 'Player vs Computer'),
  menu_option_format(3, 'Game Intructions'),
  menu_option_format(4, 'Information about project'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0, 4, Number),
  menu_option(Number).

% menu_board_size(-Size)
% The user is asked to select a board size on this menu
menu_board_size(Size):-
 menu_header_format('Choose a Board Size'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, '6x6'),
  menu_option_format(2, '8x8'),
  menu_option_format(3, '10x10'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,
  read_number(0, 3, Size).

% menu_option(+Option)
% Sub-Menus related to option selected on the main menu

% Exit Main Menu
menu_option(0):-
  banner('Thank You For Playing'),
  proj_logo.
% Player vs PLayer
menu_option(1):-
  clear,
  initial(GameState),
  start_game(GameState, 'Player', 'Player'),
  menu.
% Player vs Computer, need to choose Board Size
menu_option(2):-
  banner('Player vs Computer'),
  menu_board_size(Size),
  pc_menu_1(Size),
  clear, menu.
% Game Instructions
menu_option(4):-
  clear,
  menu_header_format('INSTRUCTIONS'),
  menu_empty_format,
  format('*~t~s~t~30|~t~c~t~23+~t*~57|~n', ["Player 1", 215]),
  format('*~t~s~t~30|~t~c~t~23+~t*~57|~n', ["Player 2", 216]),
  menu_empty_format,

  menu_text_format('The objective of Freedom is to have more "live"'),
  menu_text_format('stones at the end of the game, than your opponent'),
  menu_text_format('A stone is considered to be "live" if it is a part of'),
  menu_text_format('some horizontal, vertical or diagonal row of exactly'),
  menu_text_format('4 stones of the same symbol'),
  menu_empty_format,
  menu_empty_format,
  menu_text_format('-- GENERAL RULES --'),
  menu_empty_format,
  menu_text_format('The game starts with a square chess-like empty board'),
  menu_text_format('Each player has an allocated symbol: "X" and "O"'),
  menu_text_format('"X" plays first, putting one white stone anywhere'),
  menu_text_format('on the board. After this move players take turns'),
  menu_text_format('placing their stones on empty cells adjacent to the'),
  menu_text_format('last opponents stone. If all cells adjacent to the'),
  menu_text_format('last opponents stone are occupied then the player gets'),
  menu_text_format('the right ("freedom") to place his stone on any empty'),
  menu_text_format('cell of the board. The game ends when the board is'),
  menu_text_format('filled with stones. The last player has the right to'),
  menu_text_format('pass on his last turn (and leave the last cell empty)'),
  menu_text_format('if placing his stone reduces his score.'),
  menu_empty_format,
  menu_bottom_format,

  menu.
% Information about the Project
menu_option(3):-
  menu_bottom_format,
  menu_empty_format,
  menu_text_format('Made By Ana Ramos, Andre Leonor and Guilherme Diogo'),
  menu_empty_format,
  menu_bottom_format,
  menu.

% pp_menu(+Size)
% Menus with information related to games Player vs Player

% Choose to exit game on size screen
pp_menu(0):-
  menu.

  
/*player vs player*/
  

% pc_menu_1(+Size)
% Menus with information related to games Player vs Computer
% Namely, selecting the difficulty to assign the bot with

% Choose to exit game on size screen
pc_menu_1(0).
% Choose a board, needs to choose a difficulty for the bot
pc_menu_1(Size):-
  index_to_board_size(Size,Actual),

  banner('Player vs Computer', Actual),
  menu_header_format('Choose a Difficulty'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Easy (Random)'),
  menu_option_format(2, 'Normal (Greedy)'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,Number),
  pc_menu_2(Size, Number).

% pc_menu_2(?Size, +Difficulty)
% Menus with information related to games Player vs Computer
% Namely, selecting who starts first

% Returning to Main Menu
pc_menu_2(_, 0).
% Choose a board and bot difficulty, needs to choose who plays first
pc_menu_2(Size, Difficulty):-
  index_to_board_size(Size,Actual), option_dif(Difficulty, Diff),

  banner('Player vs Computer', Actual, Diff),
  menu_header_format('Choose a Player'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Player 1 (Plays First)'),
  menu_option_format(2, 'Player 2'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,Number),
  pc_option(Size, Difficulty, Number).

% pc_option(?Size, ?Difficulty, +Number)
% This predicate starts the game for Human vs Computer
% if the number is not 0, meaning EXIT
pc_option(_,_,0).
% Start an Human vs PC game with Human as P1 and PC on Easy and board with BoardSize
pc_option(Size, 1, 1):-
  initial(GameState),
  start_game(GameState, 'Player', 'Easy').
% Start an Human vs PC game with Human as P2 and PC on Easy and board with BoardSize
pc_option(Size, 1, 2):-
  initial(GameState),
  start_game(GameState, 'Easy', 'Player').
% Start an Human vs PC game with Human as P1 and PC on Normal and board with BoardSize
pc_option(Size, 2, 1):-
  initial(GameState),
  start_game(GameState, 'Player', 'Normal').
% Start an Human vs PC game with Human as P2 and PC on Normal and board with BoardSize
pc_option(Size, 2, 2):-
  initial(GameState),
  start_game(GameState, 'Normal', 'Player').

% cc_menu_1(+Size)
% Menus with information related to games Computer vs Computer
% Namely, selecting the difficulty for PC 1

% Returning to Main Menu
cc_menu_1(0).
% Chose a board, needs to choose bot 1 difficulty
cc_menu_1(Size):-
  index_to_board_size(Size,Actual),

  banner('Computer vs Computer - ', Actual),
  menu_header_format('Difficulty Computer 1'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Easy (Random)'),
  menu_option_format(2, 'Normal (Greedy)'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,Number),
  cc_menu_2(Size, Number).

% cc_menu_2(?Size, +Difficulty)
% Menus with information related to games Computer vs Computer
% Namely, selecting the difficulty for PC 2

% Returning to Main Menu
cc_menu_2(_, 0).
% Chose a board and bot 1 difficulty, needs to choose bot 2 difficulty
cc_menu_2(Size, Diff1):-
  index_to_board_size(Size,Actual), option_dif(Diff1, Diff1S),

  banner_bot(Actual, Diff1S),
  menu_header_format('Difficulty Computer 2'),
  menu_empty_format,
  menu_sec_header_format('Option', 'Details'),
  menu_empty_format,
  menu_option_format(1, 'Easy (Random)'),
  menu_option_format(2, 'Normal (Greedy)'),
  menu_empty_format,
  menu_option_format(0, 'EXIT'),
  menu_empty_format,
  menu_bottom_format,

  read_number(0,2,Number),
  cc_option(Size, Diff1, Number).

% cc_option(?Size, ?Diff1, +Diff2)
% This predicate starts the game for Computer vs Computer
% if the number is not 0, meaning EXIT
cc_option(_,_,0).
% Starts a game for PC vs PC with P1 and P2 on Easy and board with BoardSize
cc_option(Size, 1, 1):-
  initial(GameState),
  start_game(GameState, 'Easy', 'Easy').
% Starts a game for PC vs PC with P1 on Easy and P2 on Normal and board with BoardSize
cc_option(Size, 1, 2):-
  initial(GameState),
  start_game(GameState, 'Easy', 'Normal').
% Starts a game for PC vs PC with P1 on Normal and P2 on Easy and board with BoardSize
cc_option(Size, 2, 1):-
  initial(GameState),
  start_game(GameState, 'Normal', 'Easy').
% Starts a game for PC vs PC with P1 on Normal and P2 on Normal and board with BoardSize
cc_option(Size, 2, 2):-
  initial(GameState),
  start_game(GameState, 'Normal', 'Normal').

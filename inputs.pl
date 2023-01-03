% ASCII code and respective decimal number
code_number(48, 0).
code_number(49, 1).
code_number(50, 2).
code_number(51, 3).
code_number(52, 4).
code_number(53, 5).
code_number(54, 6).
code_number(55, 7).
code_number(56, 8).
code_number(57, 9).

% read_inputs(+Size, -X, -Y)
% Reads a Column and Row 
read_inputs(X, Y):-
  read_column(Column),
  check_column(Column, X),
  format(': Column read :  ~d\n', X),
  read_row(Row),
  check_row(Row, Y),
  format(': Row read :     ~w\n', Y).

% read_column(-Column, +Size)
% predicate to read column from user
read_column(Column) :-
  format('| Column (0-~d) - ', 9),
  get_code(Column).

% check_column(+Testing, -CheckedColumn, +Size)
% Checks if input is a valid column
check_column(Testing, Number) :-
  peek_char(Char),
  Char == '\n',
  code_number(Testing, Number),
  Number < 10, Number >= 0, skip_line.
% if not between 0-x then try again
check_column(_, CheckedColumn) :-
  write('~ Invalid column\n| Select again\n'),
  skip_line,
  read_column(Column),
  check_column(Column, CheckedColumn).

% read_row(-Row, +Size)
% predicate to read row from user
read_row(Row) :-
  format('| Row (0-~d) - ', 9),
  get_code(Row).

% check_row(+Testing, -CheckedColumn, +Size)
% checking rows
check_row(Testing, Number) :-
  peek_char(Char),
  Char == '\n',
  code_number(Testing, Number),
  Number < 10, Number >= 0, skip_line.
% if not between A-y then try again
check_row(_, CheckedRow) :-
  write('~ Invalid row\n| Select again\n'),
  skip_line,
  read_row(Row),
  check_row(Row, CheckedRow).
  
% read_number(+LowerBound, +UpperBound, -Number)
% used in menus to read inputs between the Lower and Upper Bounds
read_number(LowerBound, UpperBound, Number):-
  format('| Choose an Option (~d-~d) - ', [LowerBound, UpperBound]),
  get_code(NumberASCII),
  peek_char(Char),
  Char == '\n',
  code_number(NumberASCII, Number),
  Number =< UpperBound, Number >= LowerBound, skip_line.
read_number(LowerBound, UpperBound, Number):-
  write('Not a valid number, try again\n'), skip_line,
  read_number(LowerBound, UpperBound, Number).

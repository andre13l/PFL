% FILE THAT CONTAINS AUXILIARY FUNCTIONS


% WRITES A CERTAIN AMOUNT OF TABS IN THE OUTPUT
% tab(+Number)

:- dynamic tab/1.
tab(0) :- !.
tab(X) :- X \== 0, write(' '), Y is X-1, tab(Y).


% WRITES A CERTAIN AMOUNT OF NEW LINES (nl) IN THE OUTPUT
% nls(+Number)

:- dynamic nls/1.
nls(0) :- !.
nls(X) :- X \== 0, nl, Y is X-1, nls(Y).
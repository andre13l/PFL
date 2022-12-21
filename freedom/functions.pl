% WRITES A CERTAIN AMOUNT OF TABS IN THE output
% tab(+Number)

:- dynamic tab/1.
tab(0) :- !.
tab(X) :- X \== 0, write(' '), Y is X-1, tab(Y).
:- consult('game.pl').
:- consult('functions.pl').
:- use_module(library(lists)).

freedom :-
    intro,
    instructions,
    play.


intro :-
    nls(2),
    tab(12), write('WELCOME!'), nls(3),
    /* POSSIBLY WRITE SOME INTRO FOR THE GAME */
    nl.


/* explanation taken from https://www.iggamecenter.com/en/rules/freedom*/
rules :-
    nls(2),
    tab(2), write('Freedom is a two-player abstract board game played on a square board that was invented by Veljko Cirovic and Nebojsa Sankovic in 2010.'), nls(2),
    tab(2), write('Freedom is played on a 10x10 square board.'), nls(2),
    tab(2), write('The objective of Freedom is to have more "live" stones at the end of the game, than your opponent.'), nls(2),
    tab(2), write('A stone is considered to be "live" if it is a part of some horizontal, vertical or diagonal row of exactly 4 stones of the same color.'), nls(2),
    nl.


instructions :-
    nls(2),
    tab(10), write('INSTRUCTIONS:'),
    nls(2),
    tab(2), write('1. Bla bla bla'), nl,
    tab(2), write('2. Bla bla bla'), nl,
    tab(2), write('3. Bla bla bla'), nl,
    nls(2).
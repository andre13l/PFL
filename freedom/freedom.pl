:- consult('game.pl').
:- consult('functions.pl').
:- use_module(library(lists)).

freedom :-
    intro,
    instructions,
    play.

intro :-
    nl, nl,
    tab(2), write('Welcome to the game Freedom...'),
    /* WRITE SOME INTRO OF WHAT THE GAME IS*/
    nl, nl.

instructions:-
    nl, nl,
    tab(10), write('INSTRUCTIONS:'),
    nl, nl,
    tab(2), write('1. Bla bla bla'), nl,
    tab(2), write('2. Bla bla bla'), nl,
    tab(2), write('2. Bla bla bla'), nl,
    nl, nl.
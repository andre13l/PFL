# PFL 2º Projeto: Freedom

Implementar o jogo [Freedom](https://www.iggamecenter.com/en/rules/freedom) em Prolog.

## Elementos do Grupo

* **Ana Cristina Vilão Ramos** (up201904969) - 33.3%
* **André Moreira Leal Leonor** (up201806860) - 33.3%
* **Luis Guilherme de Melo Félix Diogo** (up201806340) - 33.3%


## Instalação e Execução

### Windows
* Executar `spwin.exe`
* `File` -> `Consult...` -> Selecionar o ficheiro `freedom.pl`
* Na consola do *SICStus*, executar `play.`


### Linux
* Executar `SicStus Prolog`
* `File` -> `Consult...` -> Selecionar o ficheiro `freedom.pl`
* Na consola do *SICStus*, executar `play.`


## Descrição do jogo

Freedom é um jogo de tabuleiro para dois jogadores, que é jogado num tabuleiro de tamanho 10x10 (mas o tamanho pode ser adaptado) e com peças brancas e pretas.

O **objetivo** do jogo é ter mais peças "live" (*tradução: vivas*) do que o oponente no final do jogo. As peças são consideradas "live" se residem em linhas de (exatamente) 4 peças consecutivas da mesma côr (4-em-linha), em todas as direções possíveis (linha, coluna e diagonal). Atenção que se for uma linha de mais do que 4 peças consecutivas já não conta como peças "live".

#### Como jogar?

O jogo começa com o jogador que possui as peças brancas a colocar uma peça em qualquer casa do tabuleiro.

Depois, o oponente só pode colocar uma peça numa casa adjacente à casa onde o último jogador pôs a sua peça. E, assim, se vai repetindo.

Se um jogador não tiver nenhuma casa adjacente vazia para poder jogar, tem a liberdade (**"freedom"**) de voltar a poder escolher qualquer casa vazia.

O jogo termina quando todas as casas forem preenchidas (todas as peças colocadas).

O último jogador a colocar uma peça pode decidir se quer jogar ou não (deixando a última casa vazia por preencher), se isto favorecer a sua pontuação.

#### Pontuação

A pontuação de cada jogador é o número de peças "live" que tem.

Se uma peça estiver em mais do que uma linha de 4 peças consecutivas (4-em-linha), só é contada uma vez.

### Ligações utilizadas:
* https://www.iggamecenter.com/en/rules/freedom
* https://freedomtable.wordpress.com/2010/05/26/3/



## Lógica do Jogo


### Representação interna do estado do jogo


#### Tabuleiro

O tabuleiro é representado com recurso a uma lista de listas, em que cada lista é uma linha *(row)* do tabuleiro. 

Depois são armazenados números nas listas, para designar o estado dessa casa do tabuleiro, sendo que:
- `-1` representa uma casa vazia
- `1` representa uma casa ocupada com uma peça pertencente ao jogador 1 (peças brancas)
- `0` representa uma casa ocupada com uma peça pertencente ao jogador 2 (peças pretas)


**Possíveis estados de jogo:**
```
- Inicial:
[ [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1] ]

- Intermedio:
[ [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [ -1, -1, -1, -1, -1,  1,  0,  0,  1, -1],
  [ -1, -1,  1,  0,  1,  0, -1,  1,  0,  1],
  [ -1,  0,  1,  1,  1,  0,  1,  1,  0, -1],
  [ -1, -1,  1,  0,  0,  1,  0,  0,  0,  1],
  [ -1,  0,  1,  0,  1,  0,  0,  1,  1,  0],
  [ -1, -1,  0,  1,  1,  1,  1, -1,  0,  1],
  [ -1, -1,  0,  1,  0,  0, -1, -1,  0,  1] ]

- Final:
[ [  1,  1,  0,  1,  1,  0,  1,  0,  1,  0],
  [  0,  0,  0,  0,  0, -1,  1,  0,  1,  1],
  [  1,  1,  1,  0,  1,  0,  0,  0,  1,  0],
  [  0,  1,  0,  1,  1,  1,  0,  0,  1,  0],
  [  1,  0,  1,  0,  1,  0,  1,  1,  0,  1],
  [  0,  0,  1,  1,  1,  0,  1,  1,  0,  0],
  [  1,  0,  1,  0,  0,  1,  0,  0,  0,  1],
  [  1,  0,  1,  0,  1,  0,  0,  1,  1,  0],
  [  0,  1,  0,  1,  1,  1,  1,  1,  0,  1],
  [  1,  0,  0,  1,  0,  0,  1,  0,  0,  1] ]

```

Depois, para podermos visualizar o estado do jogo no tabuleiro, com os devidos símbolos, temos de trocar o número do estado do jogo pelo código ASCII que corresponde ao símbolo prentendido, recorrendo, para isso, ao predicado `code/2`:

```prolog
% Pieces codes for board representation
code(-1, 32).    % ascii code for space
code(0, 216).    % Ø - Player 2
code(1, 215).    % × - Player 1
```
Tomando atenção que o símbolo **`×`** vai servir para representar o *Player 1* (peças brancas), e o símbolo **`Ø`** vai representar o *Player 2* (peças pretas).

Para imprimir depois o símbolo na consola do SICStus usamos o predicado [`put_code/1`](https://www.swi-prolog.org/pldoc/man?predicate=put_code/1).


#### Jogador Atual

Numa jogada, nós vamos trocar a string recebida com o jogador atual (`Player 1` ou `Player 2`) para o devido número que vai servir para alterar na array multidimensional que define o estado do jogo, recorrendo ao predicado `player_piece/2`:
```prolog
% Pieces codes for each player
player_piece('Player 1', 1).
player_piece('Player 2', 0).
```



### Visualização do estado de jogo


Foi implementado, como pedido, o predicado de visualização do jogo, `display_game(+GameState)`, que vai receber o estado atual do jogo e imprimir o tabuleiro, preenchendo-o de acordo com o estado do jogo, permitindo, assim, a visualização, em tempo real, do que está a aconter no jogo.

```prolog
% display_game(+GameState)
% Prints the board according to its state
display_game(GameState):- 
  nl, code(-1, P),
  print_header(P, 10),
  print_matrix(GameState, 0, 10),
  write('         '),
  print_line_codes(10, P).
```

#### Menus

Para este jogo, foram desenvolvidos vários menus com o objetivo de criar um leque de opções que o jogador pudesse escolher, sendo depois lido e processado o *input* do jogador.

Logo no ínicio do jogo, temos, então, o menu principal, controlado pelo predicado `menu/0`, que permite ao jogador escolher qual opção quer entre as quais:
* jogar no modo *Jogador contra Jogador*
* jogar no modo *Jogador contra Computador*
* ver as intruções/regras do jogo
* ver informações sobre o projeto em si

```prolog
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
```

#### Formas de validação de entrada

Para validar o input introduzido pelo jogador, nós temos várias funções, mas a principal que trata de verificar se um movimento escolhido por um jogador é um movimento válido, é o predicado `validate_choice/3`:

```prolog
% validate_choice(+Board, +Xread, +Yread)
% check if selected slot is playable
validate_choice(Board, Xread, Yread):-
    value_in_board(Board, Xread, Yread, Value),
    Value == -1.
```

Depois, também há o predicado que vai especificamente verificar o input introduzido, `read_inputs/3`:
```prolog
% read_inputs(+Size, -X, -Y)
% Reads a Column and Row 
read_inputs(Size, X, Y):-
  read_column(Column, Size),
  check_column(Column, X, Size),
  format(': Column read :  ~d\n', X),
  read_row(Row, Size),
  check_row(Row, Y, Size),
  format(': Row read :     ~w\n', Y).
```

### Execução de Jogadas

Para permitir ao jogador executar uma jogada, foi implementado o predicado `move(+GameState, +Move, -NewGameState)`:

```prolog!
% move(+GameState, +X, +Y, +A -NewGameState)
%  performs the change in the board, replaces the current empty space with player code
move(GameState, X, Y, A, NewGameState):-
    replace(GameState, X, Y, A, NewGameState).
```
Este recebe o estado atual do jogo, o movimento que o jogador pretende fazer, e vai devolver o estado do jogo atualizado (após o movimento do jogador).

### Lista de Jogadas Válidas

> `valid_moves(+GameState, +Player, -ListOfMoves)` não foi implementado


### Final do Jogo

> `game_over(+GameState, -Winner)` não foi implementado


### Avaliação do Tabuleiro

> `value(+GameState, +Player, -Value)` não foi implementado

### Jogada do Computador

> `choose_move(+GameState, +Player, +Level, -Move)` não foi implementado


## Conclusões

### Limitações do Trabalho Desenvolvido (known issues)

Neste projeto, houve algumas dificuldades por parte do grupo para finalizar o jogo, seguindo todos os passos pedidos. Nomeadamente, faltaria implementar os modos de jogo de *Jogador contra Computador* pois não se conseguiu implementar as regras do jogo para poder fazer com que o computador jogasse de acordo com as regras. Também não se conseguiu terminar os restantes predicados pedidos relacionados com o final do jogo.

### Possíveis Melhorias Identificadas (roadmap) 

Para melhorar o trabalho, nós identificamos como principais metas:
* implementar o predicado que verfica se o jogo terminou
* implementar o predicado que lista as jogadas possíveis
* implementar o predicado que avalia o tabuleiro
* implementar um adversário que apenas joga aleatóriamente uma jogada válida
* implementar um adversário que consegue prever qual a melhor jogada a se fazer (através de um algoritmo greedy)
* implementar um tamanho de tabuleiro variável
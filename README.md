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

>Indicação de como representam o estado do jogo, incluindo:
>* tabuleiro (tipicamente usando lista de listas com diferentes átomos para as peças) :heavy_check_mark:
>* jogador atual :heavy_check_mark:
>* e eventualmente peças capturadas e/ou ainda por jogar
>* ou outras informações que possam ser necessárias (dependendo do jogo) 
>
>Deve incluir exemplos da representação em Prolog de estados de jogo inicial, intermédio e final, e indicação do significado de cada átomo (ie., como representam as diferentes peças).:heavy_check_mark:

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

>Descrição da implementação do predicado de visualização do estado de jogo.
>Pode incluir informação sobre:
>* o sistema de menus criado,
>* assim como interação com o utilizador, incluindo formas de validação de entrada. 
>
>O predicado de visualização deverá chamar-se display_game(+GameState), recebendo o estado atual do jogo (que inclui o jogador que efetuará a próxima jogada).
> 
>Serão valorizadas visualizações apelativas e intuitivas.
>
>Serão também valorizadas representações de estado de jogo e implementação de predicados de visualização flexíveis, por exemplo, funcionando para qualquer tamanho de tabuleiro, usando um predicado initial_state(+Size, -GameState) que recebe o tamanho do tabuleiro como argumento e devolve o estado inicial do jogo.

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

### Execução de Jogadas

>Validação e execução de uma jogada, obtendo o novo estado do jogo.
>O predicado deve chamar-se move(+GameState, +Move, -NewGameState).


### Lista de Jogadas Válidas

>Obtenção de lista com jogadas possíveis.
>O predicado deve chamar-se valid_moves(+GameState, +Player, -ListOfMoves).


### Final do Jogo

>Verificação do fim do jogo, com identificação do vencedor.
>O predicado deve chamar-se game_over(+GameState, -Winner).


### Avaliação do Tabuleiro

>Forma(s) de avaliação do estado do jogo.
>O predicado deve chamar-se value(+GameState, +Player, -Value).


### Jogada do Computador

>Escolha da jogada a efetuar pelo computador, dependendo do nível de dificuldade.
>
>O predicado deve chamar-se choose_move(+GameState, +Player, +Level, -Move).
>
>O nível 1 deverá devolver uma jogada válida aleatória. O nível 2 deverá devolver a melhor jogada no momento (algoritmo greedy), tendo em conta a avaliação do estado de jogo.


## Conclusões

### Limitações do Trabalho Desenvolvido (known issues)

### Possíveis Melhorias Identificadas (roadmap) 
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
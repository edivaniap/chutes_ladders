programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> tx
	
	const caracter ESCADA_INI = '#'
	const caracter ESCADA_FIM = '"'
	const caracter RAMPA_INI = '@'
	const caracter RAMPA_FIM = '/'
	const inteiro MAX_ESCADA = 9
	const inteiro MAX_RAMPA = 10
	const inteiro DIM_TABULEIRO = 10
	
	//posições das escadas e rampas já predefinidas
	inteiro escadas[MAX_ESCADA][2] = {{5,14},{12,31}, {20,38},{28,84},{36,44},{40,42},{51,67},{71,91},{80,100}}
	inteiro rampas[MAX_RAMPA][2] = {{98,78},{95,75},{92,73},{87,24},{64,60},{62,19},{56,53},{49,11},{47,26},{16,6}}

	funcao inicio()
	{
		inicializar_jogo()
		processo_inicial()
    		esperar_enter()
		imprimir_tabuleiro()
	}
	
	/* Inicializa os dados do jogo
	 */
	funcao vazio inicializar_jogo() {
		//iniciar variaveis para cada partida
		jogador1 = "Jogador 1"
		jogador2 = "Jogador 2"
		representa_j1 = "J1"
		representa_j2 = "J2"
		posicao_j1 = 0;
		posicao_j2 = 0;
		vitoria_j1 = 0;
		vitoria_j2 = 0;
		empates = 0;
		rodada_atual = 0;
	}

	/* 
	 */
	funcao vazio processo_inicial() {
		escreva("Para jogar Chutes and Ladders é necessário 2 jogadores\n\n")
		
		escreva(">> Informe o nome de um dos jogadadores: ")
			leia(jogador1)
			
		escreva(">> Informe o nome do outro jogadador: ")
			leia(jogador2)


		limpa()
		ordem_jogadores()

		//representacao dos jogadores no tabuleiro
		se(tx.obter_caracter(jogador1, 0) == tx.obter_caracter(jogador2, 0)) {
			representa_j1 = tx.obter_caracter(jogador1, 0) + "1"
			representa_j2 = tx.obter_caracter(jogador2, 0) + "2"
		} senao {
			representa_j1 = tx.obter_caracter(jogador1, 0) + " "
			representa_j2 = tx.obter_caracter(jogador2, 0) + " "
		}
		
	}

	funcao vazio ordem_jogadores() {
		logico empate
		
		escreva("Agora, vamos definir a ordem que cada jogador irá jogar\n\n")

		faca {
			inteiro d1, d2
			escreva(">> ", jogador1, ", aperte Enter para jogar o dado.")
			esperar_enter()
			d1 = jogar_dados()
			escreva("Resultado do dado: ", d1, "\n")
			escreva(">> ", jogador2, ", aperte Enter para jogar o dado.")
			esperar_enter()
			d2 = jogar_dados()
			escreva("Resultado do dado: ", d2, "\n")
			
			empate = falso
			
			se(d1 == d2) {
				escreva("Empate! Vamos tentar de novo...\n\n") 
				empate = verdadeiro
			} senao se (d1 < d2) {
				cadeia aux = jogador1
				jogador1 = jogador2
				jogador2 = aux
			}
		} enquanto(empate)

		escreva("\n Assim, a ordem de jogadas será: 1º ", jogador1,", 2º ", jogador2, "\n")
	}

	funcao vazio esperar_enter() {
		cadeia enter
		leia(enter)
	}
	
	/* 
	 */
	funcao vazio processa_rodada() {
		//desenvolver
	}

	/* Verifica se o jogo acabou
	 */
	funcao logico game_over() {
		//Não está completo
		se(posicao_j1 == 100 ou posicao_j2 == 100)
		{
			se(posicao_j1 == 100 e posicao_j2 == 100)
			{
				escreva("Empate!")
				empates++;
			}
			senao se(posicao_j1 == 100)
			{
				escreva("Vitória de " + jogador1 + "!!")
				vitoria_j1++;
			}
			senao
			{
				escreva("Vitória de " + jogador2 + "!!")
				vitoria_j2++;
			}
			retorne verdadeiro
		}
		retorne falso
	}
	
	/* Simula a ação de jogar dados (ou jogar dois dados - decidir), gerando um número aleatório de 1 a 6
	 * - retorno: resultado dos dados
	 */
	funcao inteiro jogar_dados() {
		inteiro dado = 0
		dado = u.sorteia(1, 6)
		retorne dado
	}

	/* Imprime o tabuleiro do jogo de acordo com os dados atuais do jogo
	 * De acordo com as variaveis globais
	 */
	funcao vazio imprimir_tabuleiro(){
		inteiro posicao, aux, sinal = 1
		para(inteiro i = DIM_TABULEIRO - 1; i >= 0; i--) {
			sinal *= -1			
			se (sinal < 0) {
				aux = DIM_TABULEIRO 
			} senao {
				aux = 1
			}

			cadeia linha1 = "", linha2 = ""
			
			para(inteiro j = 0; j < DIM_TABULEIRO; j++) {
				posicao = (DIM_TABULEIRO * i) + aux
				aux += sinal
				
				linha1 += "[" + posicao
				se(posicao <= 9) {
					linha1 += "  ]"
				} senao se(posicao >= 100) {
					linha1 += "]"
				} senao {
					linha1 += " ]"
				}

				linha2 += "[" + preencher_espaco_jogador(posicao) + preencher_espaco_objeto(posicao) + "]"
				
			}
			escreva(linha1, "\n", linha2, "\n")
		}
	}

	/* Funcao para auxiliar a impressão do tabuleiro. Verifica se algum dos jogadores está
	 *  na posicao. Se os dois jogadores estiverem na posicao retorna uma cadeia com as duas
	 *  iniciais do jogador mesmo que sejam iguais. Se não tiver nenhum jogador, retorna uma cadeia
	 *  com dois espaços em branco.
	 * - p: posicao a ser verificada
	 * - retorno: cadeia que vai preencher o espaço do tabuleiro reservado para os jogadores
	 */
	funcao cadeia preencher_espaco_jogador(inteiro p) {	
		se(p == posicao_j1 e p == posicao_j2){
			retorne "" + tx.obter_caracter(representa_j1, 0) + tx.obter_caracter(representa_j2, 0)
		} senao se (p == posicao_j1) {
			retorne representa_j1
		} senao se (p == posicao_j2) {
			retorne representa_j2
		}

		retorne "  "
	}

	/* Funcao para auxiliar a impressão do tabuleiro. Verifica se há 
	 *  inicio ou fim de uma escada ou rampa na posicao.
	 * - p: posicao a ser verificada
	 * - retorno: caracter que vai preencher o espaço do tabuleiro reservado para escadas e rampas
	 */
	funcao caracter preencher_espaco_objeto(inteiro p) {
		para(inteiro i = 0; i < MAX_ESCADA; i++) {
			se(p == escadas[i][0]) {
				retorne ESCADA_INI
			}
			se(p == escadas[i][1]) {
				retorne ESCADA_FIM
			}
		}

		para(inteiro i = 0; i < MAX_RAMPA; i++) {
			se(p == rampas[i][0]) {
				retorne RAMPA_INI
			}
			se(p == rampas[i][1]) {
				retorne RAMPA_FIM
			}
		}
		
		retorne ' '
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1107;
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */

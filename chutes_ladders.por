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

	cadeia jogador1, jogador2, representa_j1, representa_j2
	inteiro posicao_j1, posicao_j2, vitoria_j1, vitoria_j2, empates, rodada_atual, primeiro_a_jogar
	
	funcao inicio()
	{
		inicializar_jogo()
		processo_inicial()
		faca
		{
			inicializar_partida()
			ordem_jogadores()
			processa_rodada()
		}
		enquanto(jogar_novamente())
	}
	
	/* Inicializa os dados do jogo
	 */
	funcao vazio inicializar_jogo() {
		//iniciar variaveis para o jogo

		jogador1 = "Jogador 1"
		jogador2 = "Jogador 2"
		representa_j1 = "J1"
		representa_j2 = "J2"
		vitoria_j1 = 0
		vitoria_j2 = 0
		empates = 0
		
		
	}

	funcao vazio inicializar_partida(){
		//iniciar variaveis para cada partida	
		posicao_j1 = 1
		posicao_j2 = 1
		rodada_atual = 0
		primeiro_a_jogar = 0
	}

	/* 
	 */
	funcao vazio processo_inicial() {
		escreva("Para jogar Chutes and Ladders é necessário 2 jogadores\n\n")
		
		escreva(">> Informe o nome de um dos jogadadores: ")
			leia(jogador1)
			
		escreva(">> Informe o nome do outro jogadador: ")
			leia(jogador2)

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
		inteiro dado1, dado2
		
		limpa()
		escreva("Agora, vamos definir a ordem que cada jogador irá jogar\n\n")
		
		faca {
			escreva(">> ", jogador1, ", aperte Enter para jogar o dado.")
			esperar_enter()
			dado1 = jogar_dados()
			escreva("Resultado do dado: ", dado1, "\n")
			
			escreva(">> ", jogador2, ", aperte Enter para jogar o dado.")
			esperar_enter()
			dado2 = jogar_dados()
			escreva("Resultado do dado: ", dado2, "\n")
			
			empate = falso
			
			se(dado1 == dado2) {
				escreva("Empate! Vamos tentar de novo...\n\n") 
				empate = verdadeiro
			} senao se (dado1 < dado2) {
				primeiro_a_jogar = 2
				escreva("\nAssim, a ordem de jogadas será: 1º ", jogador2,", 2º ", jogador1, "\n")
			} senao { 
				primeiro_a_jogar = 1
				escreva("\nAssim, a ordem de jogadas será: 1º ", jogador1,", 2º ", jogador2, "\n")
			}
		} enquanto(empate)
		
		escreva(">> Aperte Enter para iniciar a partida!")
		esperar_enter()
	}

	funcao vazio esperar_enter() {
		cadeia enter
		leia(enter)
	}
	
	/* 
	 */
	funcao vazio processa_rodada() {
		limpa()
		imprimir_tabuleiro()
		
		faca
		{	
			rodada_atual++;
			
			
			se(primeiro_a_jogar == 1) {
				executar_rodada(posicao_j1, jogador1, jogador2)
				executar_rodada(posicao_j2, jogador2, jogador1)
			} senao se (primeiro_a_jogar == 2){
				executar_rodada(posicao_j2, jogador2, jogador1)
				executar_rodada(posicao_j1, jogador1, jogador2)
			} senao {
				escreva("Erro: falta definir quem começa primeiro")
				ordem_jogadores()
				rodada_atual--
			}
		}
		enquanto(game_over())
	}

	funcao vazio executar_rodada(inteiro & posicao_jogador_atual, cadeia jogador_atual, cadeia proximo_jogador) {
		escreva("\n
		\t=== RODADA ", rodada_atual, " ===\n")
		escreva(">> ", jogador_atual, " (posição: ",posicao_jogador_atual,") aperte Enter para jogar o dado.")
		esperar_enter()
		
		inteiro dado = jogar_dados()
		escreva("Resultado do dado: ", dado, "\n")
		posicao_jogador_atual += dado
		escreva("Nova posição: ", posicao_jogador_atual, "\n")
		posicao_jogador_atual = checar_rampas_escadas(posicao_jogador_atual)
		
		escreva(">> Aperte Enter andar as posições no tabuleiro e passar a vez para ",proximo_jogador,".")
		esperar_enter()
				
		limpa()
		imprimir_tabuleiro()
	}

	/* Verifica se o jogo acabou
	 */
	funcao logico game_over() {
		inteiro tam_tabuleiro = DIM_TABULEIRO * DIM_TABULEIRO
		se(posicao_j1 >= tam_tabuleiro ou posicao_j2 >= tam_tabuleiro)
		{
			se(posicao_j1 >= tam_tabuleiro e posicao_j2 >= tam_tabuleiro)
			{
				escreva("Empate!\n")
				empates++;
			}
			senao se(posicao_j1 >= tam_tabuleiro)
			{
				escreva("Vitória de " + jogador1 + "!!\n")
				vitoria_j1++;
			}
			senao
			{
				escreva("Vitória de " + jogador2 + "!!\n")
				vitoria_j2++;
			}
			escreva(jogador1, " ganhou ", vitoria_j1, " partida(s), ", jogador2, " ganhou ", vitoria_j2, " partida(s) e tiveram ", empates, " empates!!\n")
			retorne falso
		}
		retorne verdadeiro
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

		//legendas
		escreva("\t\t\t*********** Chutes and Ladders ***********\n")
		escreva("\tLegenda: [",ESCADA_INI," Inicio de uma escada] [",ESCADA_FIM," Fim de uma escada]\n")
		escreva("\t\t [",RAMPA_INI," Inicio de uma rampa] [",RAMPA_FIM," Fim de uma rampa]\n")
		escreva("\t\t [",representa_j1," Peça de ",jogador1,"] [",representa_j2," Peça de ",jogador2,"]\n\n")

		//tabuleiro		
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

	funcao logico jogar_novamente()
	{
		caracter resposta
		escreva(">> Deseja jogar novamente?(S/N) ")
		leia(resposta)
		se(resposta == 'S' ou resposta == 's')
		{
			retorne verdadeiro
		}
		senao se(resposta == 'N' ou resposta == 'n')
		{
			retorne falso
		}
		senao
		{
			escreva("Opção inválida...\n")
			retorne jogar_novamente()
		}
	}

	funcao inteiro checar_rampas_escadas(inteiro posicao)
	{
		para(inteiro i = 0; i < MAX_RAMPA; i++)
		{
			se(posicao == rampas[i][0])
			{
				escreva("Eita, você parou numa rampa e escorregou para posição ", rampas[i][1],"\n")
				retorne rampas[i][1];
			}
		}
		para(inteiro j = 0; j < MAX_ESCADA; j++)
		{
			se(posicao == escadas[j][0])
			{
				escreva("Carpe diem! Você parou numa escada e subiu para posição ", escadas[j][1],"\n")
				retorne escadas[j][1]
			}
		}

		retorne posicao;
	}
}

	

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 298; 
 * @DOBRAMENTO-CODIGO = [35, 59, 115, 122, 146, 167, 195, 204, 251, 268, 290, 310];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
programa
{
	inclua biblioteca Util --> u
	
	const caracter ESCADA_INI = '#'
	const caracter ESCADA_FIM = '¨'
	const caracter RAMPA_INI = '/'
	const caracter RAMPA_FIM = '\'
	const caracter J1 = 'A'
	const caracter J2 = 'B'
	const inteiro MAX_ESCADA = 9
	const inteiro MAX_RAMPA = 10
	const inteiro TAM_TABULEIRO = 100
	const inteiro MAX_JOGADORES = 4
	
	//posições das escadas e rampas já predefinidas
	inteiro escadas[MAX_ESCADA][2] = {{5,14},{12,31}, {20,38},{28,84},{36,44},{40,42},{51,67},{71,91},{80,100}}
	inteiro rampas[MAX_RAMPA][2] = {{98,78},{95,75},{92,73},{87,24},{64,60},{62,19},{56,53},{49,11},{47,26},{16,6}}
		
	cadeia jogadores[MAX_JOGADORES]
	inteiro posicao_jogadores[MAX_JOGADORES]
	inteiro n_jogadores, n_dados
	
	inteiro posicao_j1, posicao_j2, rodada_atual, vitorias_j1, vitorias_j2
	
	funcao inicio()
	{
		processo_inicial()
	}

	/*
	 * Cria o tabuleiro
	 */
	funcao vazio iniciar_tabuleiro(){

		
	}
	/* Inicializa os dados do jogo
	 */
	funcao vazio inicializar_jogo() {
		posicao_j1 = 0
		posicao_j2 = 0
		rodada_atual = 0
	}

	/* 
	 */
	funcao vazio processo_inicial() {
		escreva("Para jogar Chutes and Ladders é necessário 2 a ", MAX_JOGADORES," jogadores e 1 ou 2 dados.\n")
		
		faca {
			escreva(">> Informe o número de jogadadores (2 a ", MAX_JOGADORES,"): ")
			leia(n_jogadores)
		} enquanto(n_jogadores < 2 ou n_jogadores > MAX_JOGADORES)
		
		para(inteiro i = 0; i < n_jogadores; i++) {
			escreva(">> Informe o nome do jogadador (", (i+1),"): ")
			leia(jogadores[i])
		}

		faca {
			escreva(">> Informe com quantos dados vocês querem jogar (1 ou 2): ")
			leia(n_dados)
		} enquanto(n_dados < 1 ou n_dados > 2)

		limpa()
		ordem_jogadores()
	}

	funcao vazio ordem_jogadores() {
		escreva("Agora, vamos definir a ordem que cada jogador irá jogar\n")

		inteiro resultado_dados[MAX_JOGADORES]

		//jogando os dados
		para(inteiro i = 0; i < n_jogadores; i++) {
			escreva(">> ", jogadores[i], ", aperte Enter para jogar o(s) dado(s).")
			esperar_enter()
			resultado_dados[i] = u.sorteia(1,3) //substiuir por funcao de jogar dados
			escreva("Resultado do(s) dado(s): ", resultado_dados[i], "\n")

			//compara resultado do jogador atual com os anteriores
			para(inteiro j = i-1; j >= 0; j--) {
				se(resultado_dados[i] == resultado_dados[j]) {
					escreva(jogadores[i], ", você jogará o dado novamente, pois teve resultado igual ao de ", jogadores[j], "!\n")
					i-- // faz jogador atual jogar dados mais uma vez
					j = -1 // interrompe este 'for
				}
			}
		}

		//ordenando os jogadores
		para(inteiro i = 0; i < n_jogadores; i++) {
			para(inteiro j = i+1; j < n_jogadores; j++) {
				se(resultado_dados[i] < resultado_dados[j]) {
					inteiro aux_dado = resultado_dados[i]
					cadeia aux_nome = jogadores[i]
					
					resultado_dados[i] = resultado_dados[j]
					jogadores[i] = jogadores[j]
					
					resultado_dados[j] = aux_dado
					jogadores[j] = aux_nome
				}
			}
		}

		escreva("\n Assim, a ordem de jogadas é:\n")
		para(inteiro i = 0; i < n_jogadores; i++) {
			escreva("* ", (i+1),"º ", jogadores[i],"\n")
		}
	}

	funcao vazio esperar_enter() {
		cadeia enter
		leia(enter)
	}
	
	/* 
	 */
	funcao vazio porcessa_rodada() {
		//desenvolver
	}

	/* Verifica se o jogo acabou
	 */
	funcao logico game_over() {
		//desenvolver
		retorne falso
	}
	
	/* Simula a ação de jogar dados (ou jogar dois dados - decidir), gerando um número aleatório de 1 a 6
	 * - retorno: resultado dos dados
	 */
	funcao inteiro jogar_dados() {
		//desenvolver
		retorne -1
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 317; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
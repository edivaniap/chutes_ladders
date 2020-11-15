programa
{
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
	
	inteiro posicao_j1, posicao_j2, rodada_atual, vitorias_j1, vitorias_j2
	
	funcao inicio()
	{
		//posições das escadas e rampas já predefinidas
		inteiro escadas[MAX_ESCADA][2] = {{5,14},{12,31}, {20,38},{28,84},{36,44},{40,42},{51,67},{71,91},{80,100}}
		inteiro rampas[MAX_RAMPA][2] = {{98,78},{95,75},{92,73},{87,24},{64,60},{62,19},{56,53},{49,11},{47,26},{16,6}}
		
		cadeia jogadores[MAX_JOGADORES]
		inteiro posicao_jogadores[MAX_JOGADORES]
		inteiro n_jogadores = 2
		inteiro n_dados = 1
		
		//leia(jogador1)
		//escreva(jogador1)
	}

	/*
	 * Cria o tabuleiro
	 */
	funcao vazio iniciar_tabuleiro(inteiro &escadas[][], inteiro &rampa[][]){

		
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
	funcao vazio processo_inicial(cadeia &jog[], inteiro &n, inteiro &nd) {
		escreva("Para jogar Chutes and Ladders é necessário 2 a 4 jogadores e 1 ou 2 dados.\n ")
		
		faca {
			escreva("Informe o número de jogadadores (2 a ", MAX_JOGADORES,"): ")
			leia(n)
		} enquanto(n < 2 e n > MAX_JOGADORES)
		
		para(inteiro i = 0; i < n; i++) {
			escreva("Informe o nome do jogadador (", (i+1),"): ")
			leia(jog[i])
		}

		faca {
			escreva("Informe com quantos dados vocês querem jogar (1 ou 2): ")
			leia(nd)
		} enquanto(nd < 1 e nd > 2)

		limpa()

		escreva("Agora, vamos definir a ordem que cada jogador irá jogar\n")
		
		inteiro dados[n]
		para(inteiro i = 0; i < n; i++) {
			escreva(j[i], ", aperte Enter para jogar o(s) dado(s)")
			leia()
			dados[i] = jogar_dados()
			escreva("Resultado do(s) dado(s): ", dados[i])
		}
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
 * @POSICAO-CURSOR = 1523; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
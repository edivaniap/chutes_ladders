programa
{
	const caracter ESCADA_INI = '#'
	const caracter ESCADA_FIM = '¨'
	const caracter RAMPA_INI = '/'
	const caracter RAMPA_FIM = '\'
	const caracter J1 = 'A'
	const caracter J2 = 'B'
	
	const inteiro MAX_ESCADA = 10
	const inteiro MAX_RAMPA = 9
	const inteiro TAM_TABULEIRO = 100
	
	cadeia jogador1, jogador2
	inteiro posicao_j1, posicao_j2, rodada_atual, vitorias_j1, vitorias_j2
	inteiro escadas[2][MAX_ESCADA]
	inteiro rampas[2][MAX_RAMPA]
	
	funcao inicio()
	{
		leia(jogador1)
		escreva(jogador1)
	}

	/* Inicializa os dados do jogo
	 */
	funcao vazio inicializar_jogo() {
		jogador1 = "Jogador 1"
		jogador2 = "Jogador 2"
		posicao_j1 = 0
		posicao_j2 = 0
		rodada_atual = 0
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
 * @POSICAO-CURSOR = 140; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
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

	cadeia jogador1, jogador2
	inteiro posicao_j1, posicao_j2, rodada_atual, vitorias_j1, vitorias_j2
	
	funcao inicio()
	{
		
		inteiro escadas[2][MAX_ESCADA] = {{5,12,20,28,36,40,51,71,80},{14,31,38,84,44,42,67,91,100}}  		
		inteiro rampas[2][MAX_RAMPA] = {{98,95,92,87,64,62,56,49,47,16},{78,75,73,24,60,19,53,11,26,6}}
		
		//iniciar_tabuleiro(escadas,rampas)
		//leia(jogador1)
		//escreva(jogador1)
	}

	/*
	 * Cria o tabuleiro
	 */
	funcao vazio iniciar_tabuleiro(inteiro &escada[][], inteiro &rampa[][]){
		//escada[2][MAX_ESCADA] = {{5,14},{12,31},{20,38},{28,84},{36,44},{40,42},{51,67},{71,91},{80,91}}    
		//escada[2][MAX_ESCADA] = {{5,12,20,28,36,40,51,71,80},{14,31,38,84,44,42,67,91,100}}

		
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
 * @POSICAO-CURSOR = 612; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
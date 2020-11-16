programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> tx
	
	const caracter ESCADA_INI = '#'
	const caracter ESCADA_FIM = '¨'
	const caracter RAMPA_INI = '/'
	const caracter RAMPA_FIM = '\'
	const caracter J1 = 'A'
	const caracter J2 = 'B'
	const inteiro MAX_ESCADA = 9
	const inteiro MAX_RAMPA = 10
	const inteiro TAM_TABULEIRO = 100
	
	//posições das escadas e rampas já predefinidas
	inteiro escadas[MAX_ESCADA][2] = {{5,14},{12,31}, {20,38},{28,84},{36,44},{40,42},{51,67},{71,91},{80,100}}
	inteiro rampas[MAX_RAMPA][2] = {{98,78},{95,75},{92,73},{87,24},{64,60},{62,19},{56,53},{49,11},{47,26},{16,6}}

	cadeia jogador1, jogador2, representa_j1, representa_j2
	inteiro posicao_j1,posicao_j2, vitoria_j1, vitoria_j2, empates, rodada_atual
	
	funcao inicio()
	{
		inicializar_jogo()
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
		escreva("Para jogar Chutes and Ladders é necessário 2 jogadores\n")
		
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
		
		escreva("Agora, vamos definir a ordem que cada jogador irá jogar\n")

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
				escreva("Empate! Vamos tentar de novo...\n") 
				empate = verdadeiro
			} senao se (d1 < d2) {
				cadeia aux = jogador1
				jogador1 = jogador2
				jogador2 = aux
			}
		} enquanto(empate)

		escreva("\n Assim, a ordem de jogadas será: 1º, ", jogador1,", 2º ", jogador2, "\n")
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
programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> tx
	inclua biblioteca Teclado --> t
	inclua biblioteca Arquivos --> arq
	
	const caracter ESCADA_INI = '#'
	const caracter ESCADA_FIM = '"'
	const caracter RAMPA_INI = '@'
	const caracter RAMPA_FIM = '/'
	const inteiro MAX_ESCADA = 9
	const inteiro MAX_RAMPA = 9
	const inteiro DIM_TABULEIRO = 10
	
	//posições das escadas e rampas predefinidas de acordo com a imagem do tabuleiro usada
	inteiro escadas[MAX_ESCADA][2] = {{5,14},{12,31},{20,38},{28,84},{36,44},{40,42}, {51,67},{71,91},{80,100}}
	inteiro rampas[MAX_RAMPA][2] = {{98,78},{95,75},{92,73},{87,24},{64,60},{59,17},{49,11},{47,26},{16,6}}

	cadeia jogador1, jogador2, representa_j1, representa_j2
	inteiro posicao_j1, posicao_j2, vitoria_j1, vitoria_j2, empates, rodada_atual, primeiro_a_jogar
	inteiro vez_do_jogador = 1
	funcao inicio()
	{
		inicializar_jogo()
		processo_inicial()
		
		faca
		{
			inicializar_partida()
			ordem_jogadores()
			imprimir_tabuleiro_grafico()
		}
		enquanto(jogar_novamente())
	}
	
	/* Inicializa variaveis para o jogo
	 */
	funcao vazio inicializar_jogo() {
		jogador1 = "Jogador 1"
		jogador2 = "Jogador 2"
		representa_j1 = "J1"
		representa_j2 = "J2"
		vitoria_j1 = 0
		vitoria_j2 = 0
		empates = 0
	}

	/* Inicializa variaveis para cada partida
	 */
	funcao vazio inicializar_partida() {	
		posicao_j1 = 1
		posicao_j2 = 1
		rodada_atual = 0
		primeiro_a_jogar = 0
	}

	/* Obtem nome dos jogadores e define a representação do jogador no tabuleiro.
	 * A representação será a inicial de cada nome. Caso tenham mesmas iniciais, numera a representação com 1 e 2.
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

	/* Define a ordem de jogada de cada jogador. Os dois jogam o dado, 
	 * quem tirar o maior numero começa primeiro. Em caso de empate, repetir o processo.
	 */
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
		vez_do_jogador = primeiro_a_jogar
		escreva(">> Aperte Enter para iniciar a partida!")
		esperar_enter()
	}

	/* Improviso para esperar o comando do usuário para realizar ações no jogo
	 */
	funcao vazio esperar_enter() {
		cadeia enter
		leia(enter)
	}
	
	/* Processo de cada rodada: mostrar tabuleiro, pedir que os jogadores joguem seus dados 
	 *  respeitando a ordem de jogada, calcula a nova posição, e mostra tabuleiro novamente.
	 */
	/*
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
				escreva("Erro: falta definir quem começa primeiro! Tecle Enter...\n")
				esperar_enter()
				ordem_jogadores()
				rodada_atual-- //volta uma rodada para começar de novo
			}
		}
		enquanto(game_over())
	}
	*/
	
	/* Auxilia processa_rodada(), fazendo a interação com o usuário de cada rodada.
	 * Atualiza o valor da posição do jogador do momento de acordo com o dado jogado e
	 * a checagem de existencia de rampa ou escada. Ao final, sempre reimprime o tabuleiro.
	 * 
	 * - posicao_jogador_atual: ponteiro para a posição do jogador da vez, usado para atualizar o valor da "fonte"
	 * - jogador_atual: nome do atual jogador da rodada
	 * - proximo_jogador: nome do próximo jogador da rodada
	 */
	funcao vazio executar_rodada(inteiro & posicao_jogador_atual, cadeia jogador_atual, cadeia proximo_jogador, inteiro valor) {
		//escreva("\n\t=== RODADA ", rodada_atual, " ===\n")
		//escreva(">> ", jogador_atual, " (posição: ",posicao_jogador_atual,") aperte Enter para jogar o dado.")
		//esperar_enter()
		
		inteiro dado = valor
		//escreva("Resultado do dado: ", dado, "\n")
		posicao_jogador_atual += dado
		
		//escreva("Nova posição: ", posicao_jogador_atual, "\n")
		posicao_jogador_atual = checar_rampas_escadas(posicao_jogador_atual)
		se(posicao_jogador_atual >99){
			posicao_jogador_atual = 100
		}
		//escreva(">> Aperte Enter andar as posições no tabuleiro e passar a vez para ",proximo_jogador,".")
		//esperar_enter()
				
		//limpa()
		//imprimir_tabuleiro()
	}

	/* Verifica se o jogo acabou. Se acabou, conta número de vitórias ou empates.
	 *  
	 * - retorno: Verdadeiro caso o jogo continue, Falso caso o jogo tenha acabado
	 */
	funcao logico game_over() {
		se(vez_do_jogador == primeiro_a_jogar e (posicao_j1 > 99 ou posicao_j2 > 99)) {
			
			inteiro arquivo = arq.abrir_arquivo("./historico.txt", arq.MODO_ACRESCENTAR)

			g.definir_cor(g.COR_BRANCO)
			g.definir_estilo_texto(falso, verdadeiro, falso)
			g.desenhar_texto(220, 230, jogador1 + " vs. " + jogador2 )
			
			se(posicao_j1 > 99 e posicao_j2 > 99){
				arq.escrever_linha(jogador1 + " vs. " + jogador2 + " >>> Empate", arquivo)
				g.definir_cor(g.COR_AMARELO)
				g.desenhar_texto(220, 250, "Houve um empate!!!" )
				escreva("Foi empate")
				empates++
			}senao se(posicao_j1 > 99){
				arq.escrever_linha(jogador1 + " vs. " + jogador2 + " >>> " + jogador1, arquivo)
				g.definir_cor(g.COR_VERDE)
				g.desenhar_texto(220, 250, jogador1 + " venceu!!!  \\o/" )
				escreva("O Jogador: "+ jogador1 +" ganhouu!!!!")
				vitoria_j1++
			}senao se(posicao_j2 > 99){
				arq.escrever_linha(jogador1 + " vs. " + jogador2 + " >>> " + jogador2, arquivo)
				g.definir_cor(g.COR_VERDE)
				g.desenhar_texto(220, 250, jogador2 + " venceu!!!  \\o/" )
				escreva("O Jogador: "+ jogador2 +" ganhouu!!!!")
				vitoria_j2++
			}
			
			arq.fechar_arquivo(arquivo)

			g.renderizar()
			u.aguarde(5000)
			
			retorne verdadeiro
		}
		retorne falso
	}
	
	/* Simula a ação de jogar um dado, gerando um número aleatório de 1 a 6
	 *  
	 * - retorno: resultado dos dados
	 */
	funcao inteiro jogar_dados() {
		inteiro dado = 0
		dado = u.sorteia(1, 6)
		retorne dado
	}

	/* Imprime o tabuleiro do jogo de acordo com os dados atuais do jogo (variaveis globais).
	 * Gera um tabuleiro quadrado, a partir de uma dimensão, com ordem da numeração de cada 
	 * celula no estilo dos tabuleiros deste jogo.
	 * Apresenta título do jogo e legendas.
	 */
	funcao vazio imprimir_tabuleiro() {
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

	/* Questiona de jogadores querem disputar mais uma partida
	 *  
	 * - retorno: Verdadeiro caso sim, Falso caso não
	 */
	funcao logico jogar_novamente()
	{
		//uso de cadeia, pois com caracter se teclar enter sem ter digitado nada causa um erro
		cadeia resposta
		escreva("\n>> Deseja jogar novamente?(S/N) ")
		leia(resposta)
		se(resposta == "S" ou resposta == "s")
		{
			retorne verdadeiro
		}
		senao se(resposta == "N" ou resposta == "n")
		{
			retorne falso
		}
		senao
		{
			escreva("Opção inválida...\n")
			retorne jogar_novamente()
		}
	}

	/* Analisa se há inicio de uma rampa ou uma escada dada a posição do jogador.
	 * Caso sim, mostra mensagem informando se o jagor subiu uma escada ou desceu uma rampa.
	 * 
	 * retorno: mesma posição ou nova posição
	 */
	funcao inteiro checar_rampas_escadas(inteiro posicao)
	{
		para(inteiro i = 0; i < MAX_RAMPA; i++)
		{
			se(posicao == rampas[i][0])
			{
				
				//escreva("Eita, você parou numa rampa e escorregou para posição ", rampas[i][1],"\n")
				retorne rampas[i][1]
			}
		}
		para(inteiro j = 0; j < MAX_ESCADA; j++)
		{
			se(posicao == escadas[j][0])
			{
				
				//escreva("Carpe diem! Você parou numa escada e subiu para posição ", escadas[j][1],"\n")
				retorne escadas[j][1]
			}
		}

		retorne posicao
	}

	/*
	 * Função que roda o jogo de forma grafica
	 */
	funcao vazio imprimir_tabuleiro_grafico(){
		g.definir_cor(g.COR_BRANCO)
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(800, 500)
		g.definir_titulo_janela("Escadas e Rampas")
		g.definir_icone_janela(g.carregar_imagem("./icon.png"))
		inteiro posicao_x = 10
		//Contem os tabuleiros,pinos e dados
		inteiro tabuleiro = g.carregar_imagem("./tabuleiro.png")
		inteiro pino1 = g.carregar_imagem("./pino3.png")
		inteiro pino2 = g.carregar_imagem("./pino2.png")
		inteiro dados[6]
		inteiro dado = 0
		
		//Atribui os 6 lados do dado
		para(inteiro i = 0; i < 6; i++) {
			dados[i] = g.carregar_imagem("./dado" + (i + 1) + ".png")
		}
		faca
		{	
			//Define o tabuleiro com fundo banco pra texto ser inserido na lateral com informações
			g.definir_cor(g.COR_BRANCO)
			g.desenhar_retangulo(0, 0, 800, 500, falso, verdadeiro)
			g.desenhar_imagem(0, 0, tabuleiro)
			//Pega as posições dos jogadores no tabuleiro
			g.desenhar_imagem(calcula_x_jogador(posicao_j1), calcula_y_jogador(posicao_j1), pino1)
			g.desenhar_imagem(calcula_x_jogador(posicao_j2), calcula_y_jogador(posicao_j2)+25, pino2)
			g.definir_cor(g.COR_PRETO)
			g.definir_estilo_texto(falso, verdadeiro, falso)
			//Texto com informações sendo escritos no tabuleiro
			g.desenhar_texto(520, 50, "Para girar dado aperte Enter")
			g.desenhar_texto(520, 70, "Degivice para jogador: "+ jogador1 + " Pos: " + posicao_j1)
			g.desenhar_texto(520, 90, "Pokebola para jogador: "+ jogador2 + " Pos: " + posicao_j2)
			g.desenhar_texto(520, 130, jogador_para_jogar())
			
			/*
			 * Executa a jogada toda vez que aperta enter
			 */
			se(t.tecla_pressionada(t.TECLA_ENTER)){
				dado = jogar_dados()-1
				
				se( vez_do_jogador == 1){
			
					executar_rodada(posicao_j1, jogador1, jogador2,dado+1)
					g.renderizar()
					vez_do_jogador = 2
				}senao{				
					executar_rodada(posicao_j2, jogador2, jogador1,dado+1)
					g.renderizar()
					vez_do_jogador = 1
				}
				u.aguarde(500)
				
			}

			g.desenhar_imagem(600, 400, dados[dado])
			g.renderizar()
			
		}enquanto(nao game_over())

		//mostra tela com historico
		mostrar_historico()
		g.encerrar_modo_grafico()
	}

	funcao vazio mostrar_historico() {
		inteiro arquivo = arq.abrir_arquivo("./historico.txt", arq.MODO_LEITURA)
		g.definir_cor(g.COR_VERDE)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.desenhar_texto(150, 50, "Histórico de partidas: ")
		g.definir_cor(g.COR_BRANCO)

		inteiro i =0
		enquanto(nao arq.fim_arquivo(arquivo)) {
			g.desenhar_texto(200, 80 + (i * 20), arq.ler_linha(arquivo))
			i++
		}
		arq.fechar_arquivo(arquivo)

		g.definir_cor(g.COR_VERMELHO)
		g.desenhar_texto(520, 470, "Tecle ESC para prosseguir")
		g.renderizar()

		//espera tecla esc para poder continuar com execução
		enquanto (nao t.tecla_pressionada(t.TECLA_ESC)) {
			u.aguarde(500)
		}
	}
	
	/*
	 * Retorna uma cadeia com qual jogador vai jogar
	 */
	funcao cadeia jogador_para_jogar(){
		se (vez_do_jogador == 1){
			se(primeiro_a_jogar == 1){
				retorne "Vez do jogador: " + jogador1
			}senao{
				retorne "Vez do jogador: " + jogador2
			}
		}senao{
			se(primeiro_a_jogar == 1){
				retorne "Vez do jogador: " + jogador2
			}senao{
				retorne "Vez do jogador: " + jogador1
			}
		}
	}
	/*
	 * Calcula a posição Y para renderizar o jogador no mapa
	 */
	funcao inteiro calcula_y_jogador(inteiro posicao){
		//Verifica se é um divisor por 10 pois nesse caso ainda continua na linha atual caso contrario
		//Ira para linha da sua unidade da dezena
		se( posicao%10 == 0){
			retorne 450-(posicao-1)/10*50
		}senao{
			retorne 450-posicao/10*50
		}
	}
	/*
	 * Calcula a posição X para renderizar o jogador no mapa
	 */
	funcao inteiro calcula_x_jogador(inteiro posicao){
		//Verifica se é uma linha que soma ou se diminui
		se( posicao/10 == 0 ou posicao/10 == 2 ou posicao/10 == 4 ou posicao/10 == 6 ou posicao/10 == 8){
			//Verifica se é divisor de 10, pois nesse caso retorna para casa da coluna base
			se( posicao%10 == 0 ){
				retorne 0
			}senao{
				retorne ((posicao%10)*50)-25
			}
		}senao{
			//Verifica se é divisor de 10, pois nesse caso retorna para casa da coluna base
			se( posicao%10 == 0){
				retorne 450
			}
			retorne 450-((posicao%10)*50)+50
		}
	
	}
}

	

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 14640; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
DEFINE CLASS VisualizacaoDeConcursos as CUSTOM

	FUNCTION GravarLayoutVisualizacao(toGrid)

		SELECT LayoutVisualizacao
		ZAP IN LayoutVisualizacao
		INSERT INTO LayoutVisualizacao (c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11) ;
		VALUES(	toGrid.colconcurso.Width, 	toGrid.colDataProva.Width,;
				toGrid.colcargo.Width, 		toGrid.colEndereco.Width,;
				toGrid.colCompl.Width, 		toGrid.colHoraProva.Width,;
				toGrid.colSalario.Width, 	toGrid.colHomol.Width,;
				toGrid.colInscricao.Width, 	toGrid.colBanco.Width,;
				toGrid.colBanco.Width)

	ENDFUNC
	
	FUNCTION ConfigurarLarguraDasColunas(toGrid)
	
		IF RECCOUNT('LayoutVisualizacao') > 0
			toGrid.colconcurso.Width = LayoutVisualizacao.c1
			toGrid.colDataProva.Width = LayoutVisualizacao.c2
			toGrid.colcargo.Width = LayoutVisualizacao.c3
			toGrid.colEndereco.Width = LayoutVisualizacao.c4
			toGrid.colCompl.Width = LayoutVisualizacao.c5
			toGrid.colHoraProva.Width = LayoutVisualizacao.c6
			toGrid.colSalario.Width = LayoutVisualizacao.c7
			toGrid.colHomol.Width = LayoutVisualizacao.c8
			toGrid.colInscricao.Width = LayoutVisualizacao.c9
			toGrid.colBanco.Width = LayoutVisualizacao.c10
			toGrid.colBanco.Width = LayoutVisualizacao.c11
		ENDIF	
	
	ENDFUNC
	
	FUNCTION AlimentarVariaveisEstatisticas(tnMaiorSalario, tnMenorSalario, tnSalarioMedio, tnMaiorInscricao, tnMenorInscricao, tnInscricaoMedia, tnNumeroConcursos)

		tnNumeroConcursos = RECCOUNT('INTERMEDIARIO')

		SELECT INTERMEDIARIO
		SCAN
			
			IF INTERMEDIARIO.Salario > tnMaiorSalario
				tnMaiorSalario = INTERMEDIARIO.Salario
			ENDIF
			IF INTERMEDIARIO.Salario > 0 AND INTERMEDIARIO.Salario < tnMenorSalario
				tnMenorSalario = INTERMEDIARIO.Salario
			ENDIF
			
			tnSalarioMedio = tnSalarioMedio + INTERMEDIARIO.Salario
			
			IF INTERMEDIARIO.Inscricao > tnMaiorInscricao
				tnMaiorInscricao = INTERMEDIARIO.Inscricao
			ENDIF
			IF INTERMEDIARIO.Inscricao> 0 AND INTERMEDIARIO.Inscricao < tnMenorInscricao
				tnMenorInscricao = INTERMEDIARIO.Inscricao
			ENDIF	
				
			tnInscricaoMedia = tnInscricaoMedia + INTERMEDIARIO.Inscricao
			
			tnMenorSalario = IIF(tnMenorSalario >= 999999, 0, tnMenorSalario)
			tnMenorInscricao = IIF(tnMenorInscricao>= 999999, 0, tnMenorInscricao)

		ENDSCAN

	ENDFUNC

ENDDEFINE
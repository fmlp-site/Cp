PUBLIC gcVirgula
gcVirgula = ','

PRIVATE poPessoa
poPessoa = NEWOBJECT('ClassePessoa','ClassePessoa.prg')

LOCAL lnRetornoLogIn, llRetornoCadastro
STORE -1 TO lnRetornoLogIn
STORE .F. TO llRetornoCadastro

SET POINT TO gcVirgula
SET DATE BRITISH
SET DELETED ON
SET SAFETY OFF
set status off
set talk off
set status bar off 
set clock status
set century on
on key label esc *
set notify off
SET SEPARATOR TO '.'	&& Separador do Milhar
** Permite a saida pelo X do windowa
on shutdown quit  
 
USE Concursos IN 0
USE LayoutVisualizacao IN 0
USE Usuarios IN 0
USE Tarefas IN 0
USE LayoutVisualizacaoTarefas IN 0

** DEFINIÇÃO DA TELA PRINCIPAL **

_screen.caption = "Sistema de Cadastro de Consursos "
_screen.AutoCenter = .t.
*_screen.Icon = "qualquer_ico.ico"
_screen.AutoCenter = .t.
_screen.backcolor = RGB(255,255,255)	
*_screen.backcolor = RGB(0,128,192)	
*_screen.backcolor = RGB(157,225,211)	
_screen.windowstate = 2

DO while(lnRetornoLogIn != 0)

	DO FORM LogIn TO lnRetornoLogIn

	DO CASE
		CASE lnRetornoLogin = 0
			QUIT()
			
		CASE lnRetornoLogin = 1
			DO FORM CadastroDeUsuario TO llRetornoCadastro
			
			IF llRetornoCadastro
				DO FORM MENU
				READ EVENTS
				lnRetornoLogIn = 0
			ELSE
				lnRetornoLogIn = -1
			ENDIF
				
		OTHERWISE
			DO FORM MENU
			READ EVENTS
			lnRetornoLogIn = 0
	ENDCASE

ENDDO
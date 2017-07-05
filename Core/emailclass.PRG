DEFINE CLASS EmailClass as Custom

	PROTECTED cEmail
	cEmail = ''

	FUNCTION getEmail()
		RETURN this.cEmail
	ENDFUNC
	
	FUNCTION setEmail(tcEmail as String)
		IF THIS.ValidarEmail(tcEmail, .T.)
			this.cEmail = tcEmail
			RETURN .T.
		ELSE
			this.cEmail = ''
			RETURN .F.
		ENDIF
	ENDFUNC
	
	FUNCTION ValidarEmail(tcEmail as String, tlEmitirAlertas as Boolean)

		tcEmail = ALLTRIM(tcEmail)

		LOCAL llRetorno, lcEmailAposArroba
		lcEmailAposArroba = RIGHT(tcEmail,LEN(tcEmail) - ATC('@',tcEmail,1))
		llRetorno = .T.
		
		DO CASE
			CASE EMPTY(tcEmail)
				IF tlEmitirAlertas
					MESSAGEBOX('E-mail é obrigatório!')
				ENDIF
				llRetorno = .F.
			
			CASE 	(LEN(tcEmail)<4) 					; && Não menor que 4 caracteres
					OR (ATC(' ',tcEmail)>0) 			; && Não conter espaços em branco
					OR (ATC('@',tcEmail,1) < 2 			; && Ao menos 1 @, sendo que este não pode ser o 1º caracter da string
					OR ATC('@',tcEmail,2) > 0) 			; && Não conter mais de um @
					OR (ATC('.',lcEmailAposArroba) = 0)	; && Conter ao menos um . após o @
					OR (LEFT(lcEmailAposArroba,1)=='.') ; && . não pode ser o 1º caracter após o @
					OR (RIGHT(lcEmailAposArroba,1)=='.')  && . não pode ser o último caracter da string
				
				IF tlEmitirAlertas
					MESSAGEBOX('E-mail inválido.')
				ENDIF
				llRetorno = .F.

			OTHERWISE
				llRetorno = .T.
			
		ENDCASE
		
		RETURN llRetorno
			
	ENDFUNC && FUNCTION ValidarEmail
	
	FUNCTION EnviarEmail( tcAssunto, tcMensagem, tcAnexo )
		
		LOCAL loConfig, loFlds, loMsg, lnX, loexcecao, loexcecao2
		tcMensagem = '<FONT size=2 face=arial>' + tcMensagem + '</FONT>'
		TRY 
			IF !(EMPTY(this.cEmail))
				loConfig = CREATEOBJECT("CDO.Configuration")
				loFlds	= loConfig.FIELDS
				WITH loFlds
					.ITEM("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
					.ITEM("http://schemas.microsoft.com/cdo/configuration/smtpserver") = 'aspmx.l.google.com'
					.ITEM("http://schemas.microsoft.com/cdo/configuration/nntpauthenticate") = 0
					.ITEM("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
					.UPDATE()
				ENDWITH
				 
				loMsg = CREATEOBJECT("CDO.Message")
				WITH loMsg
					.Configuration	= loConfig
					.TO	= this.cEmail
					.FROM = '<' + this.cEmail + '>'
					.Subject = tcAssunto
					.HTMLBody = tcMensagem
					IF !EMPTY(tcAnexo)
						.AddAttachment(tcAnexo)
					ENDIF
					.SEND()
				ENDWITH
			ENDIF
							
		CATCH TO loexcecao
			SET STEP ON
		ENDTRY 

		RETURN .T.
	ENDFUNC && _EnviarEmail	

ENDDEFINE

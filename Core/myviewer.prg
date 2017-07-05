DEFINE CLASS myViewer AS FORM

	HEIGHT = 400
	WIDTH = 600
	AUTOCENTER = .T.
	CAPTION = 'Visualização de Editais'
	SHOWWINDOW = 1
	WINDOWTYPE = 1
 
	ADD OBJECT htmlViewer AS OLECONTROL WITH HEIGHT = 400, WIDTH = 600, ANCHOR = 15, OLECLASS = 'Shell.Explorer'
    
	PROCEDURE INIT(tcFileName)
		THIS.htmlViewer.Navigate2('file://'+m.tcFileName) 
	ENDPROC
  
	PROCEDURE htmlViewer.REFRESH()
		NODEFAULT
	ENDPROC
  
ENDDEFINE
LATEX=latex
BIBTEX=bibtex
PDFLATEX=pdflatex
RM=rm
CP=cp
MAKEINDEX=makeindex
DVITOPS=dvips
DVIPDF=dvipdf
PSTOPDF=ps2pdf

DEPENDENCIES= *.tex Makefile
MAINFILE=OSCAD

all: $(MAINFILE).pdf

$(MAINFILE).dvi: $(DEPENDENCIES) 
	$(LATEX) $(MAINFILE)
#	$(BIBTEX) $(MAINFILE)
#	$(LATEX) $(MAINFILE)
#	$(LATEX) $(MAINFILE)
#	$(CP) $(MAINFILE).idx $(MAINFILE).ind
#	$(MAKEINDEX) $(MAINFILE).idx
#	$(LATEX) $(MAINFILE).tex

#-Ppdf option 
#Type fonts are scalable and looks good on pdf file
#default is bitmaps which are suitable for printer only not scalable

#$(MAINFILE).ps: $(MAINFILE).dvi
#	$(DVITOPS) -Ppdf -G0 $(MAINFILE).dvi -o $(MAINFILE).ps
#$(MAINFILE).pdf: $(MAINFILE).ps
#	$(PSTOPDF) -sPAPERSIZE=a4 -dMaxSubsetPct=100 -dCompatibilityLevel=1.4 -dSubsetFonts=true -dEmbedAllFonts=true $(MAINFILE).ps
$(MAINFILE).pdf: $(MAINFILE).dvi
	$(DVIPDF) $(MAINFILE).dvi

clean:
	$(RM) -f $(MAINFILE).pdf $(MAINFILE).ps $(MAINFILE).dvi
cleanall:
	$(RM) -f $(MAINFILE).pdf $(MAINFILE).ps $(MAINFILE).dvi *.aux *.log *.ind *.ilg *.idx *.toc

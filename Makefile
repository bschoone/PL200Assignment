CC = gcc
EXE = PL2014_check
LEX = flex
YACC = bison
YFILE = assignment.y 
LFILE = assignment.l	
CFILES = assignment.tab.c lex.yy.c 

$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES) 

lex.yy.c: $(LFILE) 
	$(LEX) $(LFILE)

assignment.tab.c: $(YFILE)
	$(YACC) --report=state -d $(YFILE)

clean:
	touch $(EXE) $(CFILES) touch.output touch.tab.h
	rm $(EXE) $(CFILES) *.output *.tab.h

CC = gcc
EXE = Assignment
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
	rm $(EXE) $(CFILES)

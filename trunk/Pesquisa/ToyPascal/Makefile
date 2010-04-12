LEX=flex
LEXFLAGS=
YACC=bison
YACCFLAGS=-v -t -d
CC=gcc
CFLAGS=-ggdb
LIBS=
PARSER=parser
SCANNER=scanner
OBJS=$(SCANNER).o $(PARSER).o symbol_table.o ast.o base.o typecheck_visitor.o simpleprinter_visitor.o graphprinter_visitor.o c_codegen_visitor.o llvm_codegen_visitor.o
PROGRAM=toypasc

all: $(OBJS)
	$(CC) $(LIBS) $(OBJS) -o $(PROGRAM)

symbol_table.o: symbol_table.c symbol_table.h
	$(CC) $(CFLAGS) symbol_table.c -c

base.o: base.c base.h
	$(CC) $(CFLAGS) base.c -c

ast.o: ast.c ast.h
	$(CC) $(CFLAGS) ast.c -c

typecheck_visitor.o: typecheck_visitor.c typecheck_visitor.h
	$(CC) $(CFLAGS) typecheck_visitor.c -c

graphprinter_visitor.o: graphprinter_visitor.c graphprinter_visitor.h
	$(CC) $(CFLAGS) graphprinter_visitor.c -c

simpleprinter_visitor.o: simpleprinter_visitor.c simpleprinter_visitor.h
	$(CC) $(CFLAGS) simpleprinter_visitor.c -c

llvm_codegen_visitor.o: llvm_codegen_visitor.c llvm_codegen_visitor.h
	$(CC) $(CFLAGS) llvm_codegen_visitor.c -c

c_codegen_visitor.o: c_codegen_visitor.c c_codegen_visitor.h
	$(CC) $(CFLAGS) c_codegen_visitor.c -c

$(PARSER).o: $(PARSER).c $(PARSER).h
	$(CC) $(CFLAGS) $(PARSER).c -c

$(SCANNER).o: $(SCANNER).c $(PARSER).h
	$(CC) $(CFLAGS) $(SCANNER).c -c

$(SCANNER).c: $(SCANNER).l
	$(LEX) $(LEXFLAGS) -o$(SCANNER).c $(SCANNER).l

$(PARSER).h: $(PARSER).y
	$(YACC) $(YACCFLAGS) $(PARSER).y -o $(PARSER).c

clean:
	rm -rf $(SCANNER).c $(PARSER).c $(PARSER).h *.o $(PROGRAM)

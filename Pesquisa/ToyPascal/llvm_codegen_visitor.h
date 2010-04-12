#ifndef LLVM_CODEGEN_VISITOR_H
#define LLVM_CODEGEN_VISITOR_H

#include "ast.h"

#define TAB             "    "
#define PRINT_TYPE(t)   if (t == VOID) printf("void"); \
                        else printf("i%d", _get_type_size(t))

#define PRINT_VALUE(n, i)   if (n->kind == IDENTIFIER && n->parent->kind == PARAMETER) \
                            printf("%%%s", n->symbol->name); \
                            else { \
                            if (i == -1) printf("%d", ast_node_get_value_as_int(n)); \
                            else printf("%%%d", i); \
                            }

static Symbol *symtab;
static Symbol *global_symtab;

Visitor *llvm_codegen_new();

void llvm_codegen_visit_program (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_programdecl (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_procfunc_list (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_procfunc (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_vardecl_list (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_vardecl (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_identifier_list (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_param_list (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_parameter (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_statement_list(struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_printint_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_printchar_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_printbool_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_printline_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_assignment_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_if_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_while_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_for_stmt (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_binary_expr (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_notfactor (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_call (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_callparam_list (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_callparam (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_identifier (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_literal (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_binary_op (struct _Visitor *, struct AstNode *);
void llvm_codegen_visit_not_op (struct _Visitor *, struct AstNode *);

#endif // LLVM_CODEGEN_VISITOR_H

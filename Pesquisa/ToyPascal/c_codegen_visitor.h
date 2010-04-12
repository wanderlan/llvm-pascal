#ifndef C_CODEGEN_VISITOR_H
#define C_CODEGEN_VISITOR_H

#include "ast.h"

#define TAB         "    "

Visitor *c_codegen_new();

void c_codegen_visit_program (struct _Visitor *, struct AstNode *);
void c_codegen_visit_programdecl (struct _Visitor *, struct AstNode *);
void c_codegen_visit_procfunc_list (struct _Visitor *, struct AstNode *);
void c_codegen_visit_procfunc (struct _Visitor *, struct AstNode *);
void c_codegen_visit_vardecl_list (struct _Visitor *, struct AstNode *);
void c_codegen_visit_vardecl (struct _Visitor *, struct AstNode *);
void c_codegen_visit_identifier_list (struct _Visitor *, struct AstNode *);
void c_codegen_visit_param_list (struct _Visitor *, struct AstNode *);
void c_codegen_visit_parameter (struct _Visitor *, struct AstNode *);
void c_codegen_visit_statement_list(struct _Visitor *, struct AstNode *);
void c_codegen_visit_printint_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_printchar_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_printbool_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_printline_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_assignment_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_if_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_while_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_for_stmt (struct _Visitor *, struct AstNode *);
void c_codegen_visit_binary_expr (struct _Visitor *, struct AstNode *);
void c_codegen_visit_notfactor (struct _Visitor *, struct AstNode *);
void c_codegen_visit_call (struct _Visitor *, struct AstNode *);
void c_codegen_visit_callparam_list (struct _Visitor *, struct AstNode *);
void c_codegen_visit_identifier (struct _Visitor *, struct AstNode *);
void c_codegen_visit_literal (struct _Visitor *, struct AstNode *);
void c_codegen_visit_binary_op (struct _Visitor *, struct AstNode *);
void c_codegen_visit_not_op (struct _Visitor *, struct AstNode *);

#endif // C_CODEGEN_VISITOR_H

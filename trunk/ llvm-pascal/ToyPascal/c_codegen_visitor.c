#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "c_codegen_visitor.h"

static char *pf_name;
static int tmp_var = 0;

static void _tab(struct AstNode *node);
static char *_get_type_string(Type type);
static char *_create_temporary();
static void _print_op_symbol(struct AstNode *node);

Visitor *
c_codegen_new()
{
    Visitor *visitor = (Visitor *) malloc (sizeof(Visitor));

    visitor->visit_program = &c_codegen_visit_program;
    visitor->visit_programdecl = &c_codegen_visit_programdecl;
    visitor->visit_vardecl_list = &c_codegen_visit_vardecl_list;
    visitor->visit_vardecl = &c_codegen_visit_vardecl;
    visitor->visit_identifier_list = &c_codegen_visit_identifier_list;
    visitor->visit_procfunc_list = &c_codegen_visit_procfunc_list;
    visitor->visit_procedure = &c_codegen_visit_procfunc;
    visitor->visit_function = &c_codegen_visit_procfunc;
    visitor->visit_param_list = &c_codegen_visit_param_list;
    visitor->visit_parameter = &c_codegen_visit_parameter;
    visitor->visit_statement_list = &c_codegen_visit_statement_list;
    visitor->visit_printint_stmt = &c_codegen_visit_printint_stmt;
    visitor->visit_printchar_stmt = &c_codegen_visit_printchar_stmt;
    visitor->visit_printbool_stmt = &c_codegen_visit_printbool_stmt;
    visitor->visit_printline_stmt = &c_codegen_visit_printline_stmt;
    visitor->visit_assignment_stmt = &c_codegen_visit_assignment_stmt;
    visitor->visit_if_stmt = &c_codegen_visit_if_stmt;
    visitor->visit_while_stmt = &c_codegen_visit_while_stmt;
    visitor->visit_for_stmt = &c_codegen_visit_for_stmt;
    visitor->visit_rel_expr = &c_codegen_visit_binary_expr;
    visitor->visit_add_expr = &c_codegen_visit_binary_expr;
    visitor->visit_mul_expr = &c_codegen_visit_binary_expr;
    visitor->visit_notfactor = &c_codegen_visit_notfactor;
    visitor->visit_call = &c_codegen_visit_call;
    visitor->visit_callparam_list = &c_codegen_visit_callparam_list;
    visitor->visit_callparam = NULL;
    visitor->visit_identifier = &c_codegen_visit_identifier;
    visitor->visit_literal = &c_codegen_visit_literal;
    visitor->visit_add_op = &c_codegen_visit_binary_op;
    visitor->visit_mul_op = &c_codegen_visit_binary_op;
    visitor->visit_rel_op = &c_codegen_visit_binary_op;
    visitor->visit_not_op = &c_codegen_visit_not_op;

    return visitor;
}

void
c_codegen_visit_program(struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    printf("/* Generated with toypasc */\n");
    for (child = node->children;
         child != NULL && child->kind != STATEMENT_LIST;
         child = child->sibling) {
        ast_node_accept(child, visitor);
        printf("\n");
    }

    if (child != NULL) {
        printf("int\nmain(int argc, char **argv)\n{\n");
        ast_node_accept(child, visitor);
        printf("\n"TAB"return 0;\n}\n\n");
    }
}

void
c_codegen_visit_programdecl(struct _Visitor *visitor, struct AstNode *node)
{
    printf("/* program ");
    ast_node_accept(node->children, visitor);
    printf("; */\n\n");
    printf("#include <stdio.h>\n\n");
    printf("#ifndef FALSE\n#define FALSE\t0\n#endif\n\n");
    printf("#ifndef TRUE\n#define TRUE\t1\n#endif\n");
}

void
c_codegen_visit_vardecl_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
    printf("\n");
}

void
c_codegen_visit_identifier_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    for (child = node->children; child != NULL; child = child->sibling) {
        ast_node_accept(child, visitor);
        if (child->sibling != NULL)
            printf(", ");
    }
}

void
c_codegen_visit_procfunc_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
c_codegen_visit_procfunc (struct _Visitor *visitor, struct AstNode *node)
{
    const char *type;
    struct AstNode *child;

    type = _get_type_string(node->type);
    pf_name = _create_temporary();

    printf("%s\n", type);

    child = node->children; // Identifier
    ast_node_accept(child, visitor);

    printf(" (");

    child = child->sibling;
    if (child->kind == PARAM_LIST) {
        ast_node_accept(child, visitor);
        child = child->sibling;
    }

    printf(")\n{\n");

    if (node->kind == FUNCTION)
        printf(TAB"%s %s;\n", type, pf_name);

    if (child->kind == VARDECL_LIST) {
        ast_node_accept(child, visitor);
        child = child->sibling;
    }

    printf("\n");

    ast_node_accept(child, visitor);

    if (node->kind == FUNCTION)
        printf("\n"TAB"return %s;\n", pf_name);
    printf("}\n\n");

    free(pf_name);
}

void
c_codegen_visit_param_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    for (child = node->children; child != NULL; child = child->sibling) {
        printf("%s ", _get_type_string(child->type));
        ast_node_accept(child, visitor);
        if (child->sibling != NULL)
            printf(", ");
    }
}

void
c_codegen_visit_statement_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    for (child = node->children; child != NULL; child = child->sibling) {
        _tab(child);
        ast_node_accept(child, visitor);
        printf("\n");
    }
}

void
c_codegen_visit_binary_expr (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
c_codegen_visit_callparam_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept(node->children, visitor);
}

void
c_codegen_visit_identifier (struct _Visitor *visitor, struct AstNode *node)
{
    printf("%s", node->symbol->name);
}

void
c_codegen_visit_literal (struct _Visitor *visitor, struct AstNode *node)
{
    if (node->type == BOOLEAN) {
        printf("%s", node->value.boolean ? "TRUE" : "FALSE");
    } else
        value_print(stdout, &node->value, node->type);
}

void
c_codegen_visit_vardecl (struct _Visitor *visitor, struct AstNode *node)
{
    const char *type = _get_type_string(node->type);

    printf(TAB"%s ", type);
    ast_node_accept(node->children, visitor);
    printf(";\n");
}

void
c_codegen_visit_parameter (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept(node->children, visitor);
}

void
c_codegen_visit_printint_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    printf("printf(\"%%d\", ");
    ast_node_accept(node->children, visitor);
    printf(");");
}

void
c_codegen_visit_printchar_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    printf("printf(\"%%c\", ");
    ast_node_accept(node->children, visitor);
    printf(");");
}

void
c_codegen_visit_printbool_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    printf("printf(\"%%s\", ");
    ast_node_accept(node->children, visitor);
    printf(");");
}

void
c_codegen_visit_printline_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    printf("printf(\"\\n\");");
}

void
c_codegen_visit_assignment_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept(node->children, visitor);
    printf(" = ");
    ast_node_accept(node->children->sibling, visitor);
    printf(";");
}

void
c_codegen_visit_if_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;
    const char *var;

    printf("if (");
    child = node->children; // Expression
    ast_node_accept(child, visitor);
    printf(") {\n");

    child = child->sibling; // If Statements
    ast_node_accept(child, visitor);

    printf("\n");
    _tab(node);
    printf("}");

    child = child->sibling; // Else Statements

    if (child != NULL) {
        printf(" else {\n");
        ast_node_accept(child, visitor);
        printf("\n");
        _tab(node);
        printf("}");
    }
    printf("\n");
}

void
c_codegen_visit_while_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;
    const char *var;

    printf("while (");
    child = node->children; // Expression
    ast_node_accept(child, visitor);
    printf(") {\n");

    child = child->sibling; // Statements
    ast_node_accept(child, visitor);

    _tab(node);
    printf("}\n");
}

void
c_codegen_visit_for_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;
    const char *var;

    printf("for (");
    child = node->children; // Assignment
    ast_node_accept(child, visitor);

    var = child->children->symbol->name;
    printf(" %s < ", var);

    child = child->sibling; // Stop condition
    ast_node_accept(child, visitor);

    printf("; %s++) {\n", var);

    child = child->sibling; // Statements
    ast_node_accept_children(child, visitor);

    printf("\n");
    _tab(node);
    printf("}\n");
}

void
c_codegen_visit_notfactor (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
c_codegen_visit_call (struct _Visitor *visitor, struct AstNode *node)
{
    printf("%s ();\n", node->symbol->name);
    ast_node_accept(node->children, visitor);
}

void
c_codegen_visit_simplenode (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
c_codegen_visit_binary_op (struct _Visitor *visitor, struct AstNode *node)
{
    _print_op_symbol(node);
}

void
c_codegen_visit_not_op (struct _Visitor *visitor, struct AstNode *node)
{
    printf(" !", node->name);
}

static void
_tab(struct AstNode *node) {
    struct AstNode *parent;
    for (parent = node->parent; parent->parent != NULL; parent = parent->parent)
        printf(TAB);
}

static char
*_get_type_string(Type type)
{
    switch (type) {
        case INTEGER:
        case BOOLEAN:
            return "int";
            break;
        case CHAR:
            return "char";
        default:
            return "void";
    }
}

static char
*_create_temporary()
{
    char *temp;

    if (asprintf (&temp, "tmp%.5d", tmp_var) < 0)
        return NULL;

    tmp_var++;
    return temp;
}

static void
_print_op_symbol(struct AstNode *node)
{
    switch (node->kind) {
        case T_OR:
            printf(" || ");
            break;
        case T_AND:
            printf(" && ");
            break;
        case T_EQUAL:
            printf(" == ");
            break;
        case T_NOTEQUAL:
            printf(" != ");
            break;
        case T_LESSER:
            printf(" < ");
            break;
        case T_GREATER:
            printf(" > ");
            break;
        case T_LESSEREQUAL:
            printf(" <= ");
            break;
        case T_GREATEREQUAL:
            printf(" >= ");
            break;
        case T_PLUS:
        case T_MINUS:
        case T_STAR:
        case T_SLASH:
            printf(" %s ", node->name);
    }
}

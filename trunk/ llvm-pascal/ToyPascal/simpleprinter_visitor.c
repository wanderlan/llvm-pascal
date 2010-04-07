#include <stdlib.h>
#include <stdio.h>
#include "base.h"
#include "simpleprinter_visitor.h"

Visitor *
simpleprinter_new()
{
    Visitor *visitor = (Visitor *) malloc (sizeof(Visitor));

    visitor->visit_program = &simpleprinter_visit;
    visitor->visit_programdecl = &simpleprinter_visit;
    visitor->visit_vardecl_list = &simpleprinter_visit;
    visitor->visit_vardecl = &simpleprinter_visit;
    visitor->visit_identifier_list = &simpleprinter_visit;
    visitor->visit_procfunc_list = &simpleprinter_visit;
    visitor->visit_procedure = &simpleprinter_visit;
    visitor->visit_function = &simpleprinter_visit;
    visitor->visit_param_list = &simpleprinter_visit;
    visitor->visit_parameter = &simpleprinter_visit;
    visitor->visit_statement_list = &simpleprinter_visit;
    visitor->visit_printint_stmt = &simpleprinter_visit;
    visitor->visit_printchar_stmt = &simpleprinter_visit;
    visitor->visit_printbool_stmt = &simpleprinter_visit;
    visitor->visit_printline_stmt = &simpleprinter_visit;
    visitor->visit_assignment_stmt = &simpleprinter_visit;
    visitor->visit_if_stmt = &simpleprinter_visit;
    visitor->visit_while_stmt = &simpleprinter_visit;
    visitor->visit_for_stmt = &simpleprinter_visit;
    visitor->visit_rel_expr = &simpleprinter_visit;
    visitor->visit_add_expr = &simpleprinter_visit;
    visitor->visit_mul_expr = &simpleprinter_visit;
    visitor->visit_notfactor = &simpleprinter_visit;
    visitor->visit_call = &simpleprinter_visit;
    visitor->visit_callparam_list = &simpleprinter_visit;
    visitor->visit_identifier = &simpleprinter_visit;
    visitor->visit_literal = &simpleprinter_visit;
    visitor->visit_add_op = &simpleprinter_visit;
    visitor->visit_mul_op = &simpleprinter_visit;
    visitor->visit_rel_op = &simpleprinter_visit;
    visitor->visit_not_op = &simpleprinter_visit;

    return visitor;
}

void
simpleprinter_visit(struct _Visitor *visitor, struct AstNode *node)
{
    int i;
    struct AstNode *temp;

    if (node == NULL)
        return;

    printf("(AstNode) %x : %s\n", node, node->name);
    printf("kind: %d\n", node->kind);
    printf("type: %d\n", node->type);
    printf("value: ");
    value_print(stdout, &node->value, node->type);
    printf("\nlinenum: %d\n", node->linenum);
    if (node->symbol != NULL)
        printf("symbol: %x (\"%s\")\n", node->symbol, node->symbol->name);

    printf("Parent: (AstNode) %x\n", node->parent);

    if (node->children != NULL) {
        printf("Children\n");
        for (temp = node->children; temp != NULL; temp = temp->sibling) {
            printf("\t(AstNode) %x", temp);
            if (temp->name != NULL)
                printf(" : %s", temp->name);
            printf("\n");
        }
    }
    printf("\n");

    ast_node_accept_children(node->children, visitor);
}

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "llvm_codegen_visitor.h"

static int stack_size = -1;

static void _print_boolean(struct AstNode *node);
static void _print_load(struct AstNode *node, Visitor *visitor);
static int _get_type_size(Type type);
static int _process_expression(struct AstNode *rnode, Visitor *visitor);

Visitor *
llvm_codegen_new()
{
    Visitor *visitor = (Visitor *) malloc (sizeof(Visitor));

    visitor->visit_program = &llvm_codegen_visit_program;
    visitor->visit_programdecl = &llvm_codegen_visit_programdecl;
    visitor->visit_vardecl_list = &llvm_codegen_visit_vardecl_list;
    visitor->visit_vardecl = &llvm_codegen_visit_vardecl;
    visitor->visit_identifier_list = &llvm_codegen_visit_identifier_list;
    visitor->visit_procfunc_list = &llvm_codegen_visit_procfunc_list;
    visitor->visit_procedure = &llvm_codegen_visit_procfunc;
    visitor->visit_function = &llvm_codegen_visit_procfunc;
    visitor->visit_param_list = &llvm_codegen_visit_param_list;
    visitor->visit_parameter = &llvm_codegen_visit_parameter;
    visitor->visit_statement_list = &llvm_codegen_visit_statement_list;
    visitor->visit_printint_stmt = &llvm_codegen_visit_printint_stmt;
    visitor->visit_printchar_stmt = &llvm_codegen_visit_printchar_stmt;
    visitor->visit_printbool_stmt = &llvm_codegen_visit_printbool_stmt;
    visitor->visit_printline_stmt = &llvm_codegen_visit_printline_stmt;
    visitor->visit_assignment_stmt = &llvm_codegen_visit_assignment_stmt;
    visitor->visit_if_stmt = &llvm_codegen_visit_if_stmt;
    visitor->visit_while_stmt = &llvm_codegen_visit_while_stmt;
    visitor->visit_for_stmt = &llvm_codegen_visit_for_stmt;
    visitor->visit_rel_expr = &llvm_codegen_visit_binary_expr;
    visitor->visit_add_expr = &llvm_codegen_visit_binary_expr;
    visitor->visit_mul_expr = &llvm_codegen_visit_binary_expr;
    visitor->visit_notfactor = &llvm_codegen_visit_notfactor;
    visitor->visit_call = &llvm_codegen_visit_call;
    visitor->visit_callparam_list = &llvm_codegen_visit_callparam_list;
    visitor->visit_callparam = &llvm_codegen_visit_callparam;
    visitor->visit_identifier = &llvm_codegen_visit_identifier;
    visitor->visit_literal = &llvm_codegen_visit_literal;
    visitor->visit_add_op = &llvm_codegen_visit_binary_op;
    visitor->visit_mul_op = &llvm_codegen_visit_binary_op;
    visitor->visit_rel_op = &llvm_codegen_visit_binary_op;
    visitor->visit_not_op = &llvm_codegen_visit_not_op;

    return visitor;
}

void
llvm_codegen_visit_program(struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    printf("; Generated with toypasc\n");
    for (child = node->children;
         child != NULL && child->kind != STATEMENT_LIST;
         child = child->sibling) {
        ast_node_accept(child, visitor);
    }

    if (child != NULL) {
        printf("; Definition of main function\n");
        printf("define i32 @main () {\nentry:\n");
        ast_node_accept(child, visitor);
        printf(TAB"ret i32 0\n}\n\n");
    }
}

void
llvm_codegen_visit_programdecl(struct _Visitor *visitor, struct AstNode *node)
{
    printf("; program ");
    ast_node_accept(node->children, visitor);
    printf("\n\n");
    printf("; Declare the string constants as a global constants...\n");
    printf("@bool_str = global [2 x i8*] [ "
           "i8* getelementptr ([6 x i8]* @.false_str, i32 0, i32 0), "
           "i8* getelementptr ([5 x i8]* @.true_str, i32 0, i32 0) ]\n");
    printf("@.false_str = internal constant [6 x i8] c\"false\\00\"\n");
    printf("@.true_str = internal constant [5 x i8] c\"true\\00\"\n");
    printf("@.int_fmt = internal constant [3 x i8] c\"%%d\\00\"\n");
    printf("@.bool_fmt = internal constant [3 x i8] c\"%%s\\00\"\n");

    printf("\n; External declaration of functions\n");
    printf("declare i32 @puts(i8 *)\n");
    printf("declare i32 @putchar(i32)\n");
    printf("declare i32 @printf(i8*, ...)\n\n");
}

void
llvm_codegen_visit_vardecl_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
    if (node->parent->kind == PROGRAM)
        printf("\n");
}

void
llvm_codegen_visit_identifier_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    /* FIXME */ fprintf(stderr, "Never reaches here?\n");
    for (child = node->children; child != NULL; child = child->sibling) {
        ast_node_accept(child, visitor);
        if (child->sibling != NULL)
            printf(", ");
    }
}

void
llvm_codegen_visit_procfunc_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
llvm_codegen_visit_procfunc (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    printf("define ");
    PRINT_TYPE(node->type);
    printf(" ");

    child = node->children; // Identifier
    ast_node_accept(child, visitor);

    printf(" ( ");

    child = child->sibling;
    if (child->kind == PARAM_LIST) {
        ast_node_accept(child, visitor);
        child = child->sibling;
    }

    printf(" ) {\n");
    printf("entry:\n");

    if (child->kind == VARDECL_LIST) {
        ast_node_accept(child, visitor);
        child = child->sibling;
    }

    ast_node_accept(child, visitor);

    printf(TAB"ret ");
    PRINT_TYPE(node->type);
    if (node->kind == FUNCTION) {
        printf(" ");
        PRINT_VALUE(node->children, node->children->symbol->stack_index);
    }

    printf("\n}\n\n");
}

void
llvm_codegen_visit_param_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    for (child = node->children; child != NULL; child = child->sibling) {
        ast_node_accept(child, visitor);
        if (child->sibling != NULL)
            printf(", ");
    }
}

void
llvm_codegen_visit_statement_list (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    stack_size = -1;

    for (child = node->children; child != NULL; child = child->sibling) {
        ast_node_accept(child, visitor);
        printf("\n");
    }
}

void
llvm_codegen_visit_binary_expr (struct _Visitor *visitor, struct AstNode *node)
{
    int lindex = -1;
    int rindex = -1;
    struct AstNode *lnode = node->children;
    struct AstNode *op = lnode->sibling;
    struct AstNode *rnode = op->sibling;

    int __process_binexpr_node(struct AstNode *node) {
        if (node->kind == IDENTIFIER) {
            if (node->symbol->is_global) {
                if (symbol_is_procfunc(node->symbol))
                    return node->symbol->stack_index;

                _print_load(node, visitor);
                return stack_size;
            }

        } else if (!IS_LITERAL(node->kind)) {
            ast_node_accept(node, visitor);
            return stack_size;

        }
        return -1;
    }

    void __print_operand(struct AstNode *node, int index) {
        if (index > -1)
            printf("%%%d", index);
        else if (node->symbol != NULL && symbol_is_procfunc(node->symbol))
            printf("0");
        else
            ast_node_accept(node, visitor);
    }

    /* Construcao mais simples */
    if (IS_LITERAL(lnode->kind) && IS_LITERAL(rnode->kind)) {
        ast_node_accept(op, visitor);
        printf(" ");
        PRINT_TYPE(lnode->type);
        printf(" ");
        ast_node_accept(lnode, visitor);
        printf(", ");
        ast_node_accept(rnode, visitor);
        printf("\n");

    /* Construcoes complexas */
    } else {
        lindex = __process_binexpr_node(lnode);
        rindex = __process_binexpr_node(rnode);

        ast_node_accept(op, visitor);
        printf(" ");
        PRINT_TYPE(lnode->type);
        printf(" ");

        __print_operand(lnode, lindex);
        printf(", ");
        __print_operand(rnode, rindex);

        printf("\n");
    }

    stack_size++;
}

void
llvm_codegen_visit_callparam_list (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept(node->children, visitor);
}

void
llvm_codegen_visit_callparam (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept(node->children, visitor);
}

void
llvm_codegen_visit_identifier (struct _Visitor *visitor, struct AstNode *node)
{
    Symbol *sym = node->symbol;

    if (sym->is_global || node->parent->kind == CALL)
        printf("@%s", sym->name);

    else if (!sym->is_global && node->parent->kind == PARAMETER &&
             sym->stack_index == -1)
        printf("%%%s", sym->name);

    else if (sym->stack_index > -1)
        printf("%%%d", sym->stack_index);

    else
        printf("0");
}

void
llvm_codegen_visit_literal (struct _Visitor *visitor, struct AstNode *node)
{
    printf("%d", node->value.integer);
}

void
llvm_codegen_visit_vardecl (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;

    child = node->children;

    for (child = child->children; child != NULL; child = child->sibling) {
        if (node->parent->parent->kind == PROGRAM) {
            ast_node_accept(child, visitor);
            printf(" = global i%d 0\n", _get_type_size(child->type));
        } else {
            child->symbol->stack_index = -1;
        }
    }
}

void
llvm_codegen_visit_parameter (struct _Visitor *visitor, struct AstNode *node)
{
    PRINT_TYPE(node->type);
    printf(" ");
    ast_node_accept(node->children, visitor);
}

void
llvm_codegen_visit_printint_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int index = -1;
    struct AstNode *child = node->children;

    index = _process_expression(child, visitor);

    printf(TAB"call i32 (i8* noalias , ...)* bitcast (i32 (i8*, ...)* \n");
    printf(TAB TAB"@printf to i32 (i8* noalias, ...)*)\n");
    printf(TAB TAB"( i8* getelementptr ");
    printf("([3 x i8]* @.int_fmt, i32 0, i32 0) noalias ,\n");
    printf(TAB TAB"i32 ");
    PRINT_VALUE(child, index);

    printf(" )\n");
    stack_size++;
}

void
llvm_codegen_visit_printchar_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int index = -1;
    struct AstNode *child = node->children;

    index = _process_expression(child, visitor);

    printf(TAB"call i32 @putchar ( i32 ");
    PRINT_VALUE(child, index);
    printf(" )\n");
    stack_size++;
}

void
llvm_codegen_visit_printbool_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int index = -1;
    struct AstNode *child = node->children;

    index = _process_expression(child, visitor);

    if (index == -1) {
        printf(TAB"load i8** getelementptr ([2 x i8*]* @bool_str, i32 0, i32 %d )"
               ", align 4\n", ast_node_get_value_as_int(child));
    } else {
        printf(TAB"getelementptr [2 x i8*]* @bool_str, i32 0, i32 %%%d\n",
               index);
        stack_size++;
        printf(TAB"load i8** %%%d, align 4\n", stack_size);
    }
    stack_size++;

    printf(TAB"call i32 (i8* noalias , ...)* bitcast (i32 (i8*, ...)* \n");
    printf(TAB TAB"@printf to i32 (i8* noalias , ...)*)\n");
    printf(TAB TAB"( i8* getelementptr ");
    printf("([3 x i8]* @.bool_fmt, i32 0, i32 0) noalias , \n");
    printf(TAB TAB"i8* %%%d )\n", stack_size);
    stack_size++;
}

void
llvm_codegen_visit_printline_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    printf(TAB"call i32 @putchar( i32 10 )\n");
    stack_size++;
}

void
llvm_codegen_visit_assignment_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int rindex = -1;
    struct AstNode *lnode = node->children;
    struct AstNode *rnode = lnode->sibling;

    /* FIXME * */printf("; [Assignment][%s] %s(%d/%d) = %d\n", rnode->name,
                       lnode->symbol->name, lnode->symbol->stack_index,
                       stack_size, ast_node_get_value_as_int(rnode));
    /**/

    /* rnode */
    rindex = _process_expression(rnode, visitor);

    /* lnode */
    if (lnode->symbol->is_global && !symbol_is_procfunc(lnode->symbol)) {
        printf(TAB"store ");
        PRINT_TYPE(lnode->type);
        printf(" ");
        PRINT_VALUE(rnode, rindex);
        printf(", ");
        PRINT_TYPE(lnode->type);
        printf("* ");
        ast_node_accept(lnode, visitor);
        printf(", align 4\n");

    } else if (rindex == -1) {
        /*lnode->symbol->stack_index = -1;
        lnode->symbol->value.integer = rnode->value.integer;
        lnode->value.integer = rnode->value.integer;*/
        printf(TAB"add ");
        PRINT_TYPE(lnode->type);
        printf(" ");
        PRINT_VALUE(rnode, rindex);
        printf(", 0\n");
        stack_size++;
        lnode->symbol->stack_index = stack_size;

    } else
        lnode->symbol->stack_index = rindex;


    /* FIXME */ printf("; [Assignment][%s] %s(%d/%d) = %d\n", rnode->name,
                       lnode->symbol->name, lnode->symbol->stack_index,
                       stack_size, ast_node_get_value_as_int(rnode));
    /**/
}

void
llvm_codegen_visit_if_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int index = -1;
    struct AstNode *expr = node->children;
    struct AstNode *cmd1 = expr->sibling;
    struct AstNode *cmd2 = cmd1->sibling;

    printf("; if evaluation, line %d\n", node->linenum);

    index = _process_expression(expr, visitor);

    printf(TAB"br i1 ");
    PRINT_VALUE(expr, index);
    printf(", label %%cond_true_%x, label ", node);

    if (cmd2 == NULL)
        printf("%%cond_next_%x\n", node);
    else
        printf("%%cond_false_%x\n", node);

    printf("\ncond_true_%x:\n", node);
    ast_node_accept(cmd1, visitor);
    printf(TAB"br label %%cond_next_%x\n", node);

    if (cmd2 != NULL) {
        printf("\ncond_false_%x:\n", node);
        ast_node_accept(cmd2, visitor);
        printf(TAB"br label %%cond_next_%x\n", node);
    }

    printf("\ncond_next_%x:\n", node);
}

void
llvm_codegen_visit_while_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    struct AstNode *child;
    const char *var;

    printf("while (");
    child = node->children; // Expression
    ast_node_accept(child, visitor);
    printf(") {\n");

    child = child->sibling; // Statements
    ast_node_accept(child, visitor);

    printf("}\n");
}

void
llvm_codegen_visit_for_stmt (struct _Visitor *visitor, struct AstNode *node)
{
    int index = -1;
    struct AstNode *asgn = node->children;
    struct AstNode *expr = asgn->sibling;
    struct AstNode *stmt = expr->sibling;

    printf("; for evaluation, line %d\n", node->linenum);

    //%tmp512 = ????
    ast_node_accept(asgn, visitor);

/*
    %tmp714 = icmp sgt i32 %tmp512, 0       ; <i1> [#uses=1]
    br i1 %tmp714, label %bb.preheader, label %bb9
    */
    index = _process_expression(expr, visitor);

    printf(TAB"br i1 ");
    PRINT_VALUE(expr, index);
    printf(", label %%bb_%x.preheader, label %%bb_%x\n", node, node);

/*
bb.preheader:       ; preds = %entry
    %b.promoted = load i32* @b, align 4     ; <i32> [#uses=1]
    br label %bb
    */
    printf("\nbb_%x.preheader:\n", node);


/*
bb:     ; preds = %bb, %bb.preheader
    %ITERADOR.010.0 = phi i32 [ 0, %bb.preheader ], [ %tmp3, %bb ]      ; <i32> [#uses=2]
    %tmp3 = add i32 %ITERADOR.010.0, 1      ; <i32> [#uses=2]
    %tmp7 = icmp slt i32 %tmp3, %tmp512     ; <i1> [#uses=1]
    br i1 %tmp7, label %bb, label %bb9.loopexit
    */

/*
bb9.loopexit:       ; preds = %bb
    %b.tmp.0 = add i32 %ITERADOR.010.0, %b.promoted     ; <i32> [#uses=1]
    %tmp1 = add i32 %b.tmp.0, 1     ; <i32> [#uses=1]
    store i32 %tmp1, i32* @b, align 4
    br label %bb9
*/

/*
bb9:        ; preds = %bb9.loopexit, %entry
*/


    printf("\ncond_true_%x:\n", node);
    ast_node_accept(stmt, visitor);
    printf(TAB"br label %%cond_next_%x\n", node);

    printf("\ncond_next_%x:\n", node);
}

void
llvm_codegen_visit_notfactor (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
llvm_codegen_visit_call (struct _Visitor *visitor, struct AstNode *node)
{
/*
    int index = -1;
    struct AstNode *temp, *child = node->children;

    index = _process_expression(child, visitor);

    temp= child->sibling;
    if (temp != NULL) {
        for (temp = temp->children; temp != NULL; temp = temp->sibling) {
            PRINT_TYPE(child->type);
            printf(" ");
            ast_node_accept(child, visitor);
            if (child->sibling != NULL)
                printf(", ");
        }
    }

    printf(TAB"call ");
    PRINT_TYPE(child->symbol->type);
    printf(" ");
    ast_node_accept(child, visitor);
    printf("( ");

    printf(" )\n");
    stack_size++;
*/
    struct AstNode *child = node->children;

    printf(TAB"call ");
    PRINT_TYPE(child->symbol->type);
    printf(" ");
    ast_node_accept(child, visitor);
    printf("( ");

    child = child->sibling;
    if (child != NULL) {
        for (child = child->children; child != NULL; child = child->sibling) {
            PRINT_TYPE(child->type);
            printf(" ");
            ast_node_accept(child, visitor);
            if (child->sibling != NULL)
                printf(", ");
        }
    }

    printf(" )\n");
    stack_size++;
}

void
llvm_codegen_visit_simplenode (struct _Visitor *visitor, struct AstNode *node)
{
    ast_node_accept_children(node->children, visitor);
}

void
llvm_codegen_visit_binary_op (struct _Visitor *visitor, struct AstNode *node)
{
    /* FIXME *printf("; %%%d = \n", stack_size + 1);*/
    switch (node->kind) {
        case T_OR:
            printf(TAB"or");
            break;
        case T_AND:
            printf(TAB"and");
            break;
        case T_EQUAL:
            printf(TAB"icmp eq");
            break;
        case T_NOTEQUAL:
            printf(TAB"icmp ne");
            break;
        case T_LESSER:
            printf(TAB"icmp slt");
            break;
        case T_GREATER:
            printf(TAB"icmp sgt");
            break;
        case T_LESSEREQUAL:
            printf(TAB"icmp sle");
            break;
        case T_GREATEREQUAL:
            printf(TAB"icmp sge");
            break;
        case T_PLUS:
            printf(TAB"add");
            break;
        case T_MINUS:
            printf(TAB"sub");
            break;
        case T_STAR:
            printf(TAB"mul");
            break;
        /*case T_SLASH:
            printf(" %s ", node->name);*/
    }
}

void
llvm_codegen_visit_not_op (struct _Visitor *visitor, struct AstNode *node)
{
    printf(" !", node->name);
}

static void
_print_boolean(struct AstNode *node)
{
    printf("%bool_str = getelementptr [");
    if (node->value.boolean)
        printf("5 x i8]* @.true");
    else
        printf("6 x i8]* @.false");
    printf("_str, i32 0, i32 0\n");
}

static void
_print_load(struct AstNode *node, Visitor *visitor)
{
    printf(TAB"load ");
    PRINT_TYPE(node->type);
    printf("* ");
    ast_node_accept(node, visitor);
    printf(", align 4\n");
    stack_size++;
}

static int
_get_type_size(Type type)
{
    switch (type) {
        case INTEGER:
            return 32;
        case CHAR:
            return 8;
        case BOOLEAN:
            return 1;
        default:
            return 0;
    }
}

static int
_process_expression(struct AstNode *rnode, Visitor *visitor)
{
    if (!IS_LITERAL(rnode->kind)) {
        if (rnode->kind != IDENTIFIER) {
            ast_node_accept(rnode, visitor);
            return stack_size;

        } else if (rnode->symbol->is_global) {
            _print_load(rnode, visitor);
            return stack_size;

        } else
            return rnode->symbol->stack_index;

    }

    return -1;
}

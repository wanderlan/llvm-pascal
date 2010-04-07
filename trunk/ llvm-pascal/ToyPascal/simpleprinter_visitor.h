#ifndef SIMPLEPRINTER_VISITOR_H
#define SIMPLEPRINTER_VISITOR_H

#include "ast.h"

Visitor *simpleprinter_new();

void simpleprinter_visit (struct _Visitor *,  struct AstNode *);

#endif // SIMPLEPRINTER_VISITOR_H

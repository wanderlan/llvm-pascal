LLVM-Pascal 2010.9.13 Pre-Alpha

Principal implementação deste release: Scanner e Parser

Home: http://llvm-pascal.googlecode.com
Forum: http://groups.google.com/group/llvm-pascal
License: BSD, http://www.opensource.org/licenses/bsd-license.php

- Por enquanto a "compilação" só faz análise léxica e sintática.
- Compilável com qualquer Delphi até versão 2007 e Free Pascal 2.4.
- Fonte extremamente pequeno e simples usando Orientação a Objetos com Object Pascal.
- "Compila" fontes do Delphi até versão 2007, não suporta operator overload no dialeto Delphi.
- "Compila" fontes do Lazarus até a versão 0.9.28.2 e Free Pascal até a versão 2.4, suporta macros, operator overload e literais binários.
- "Compila" ~ 140 klps (mil linhas por segundo) em um Intel E2200 Dual Core II 2.2 GHz com 2 GB de RAM e Windows XP SP3, compilado com Turbo Delphi, com FPC 2.4 ~ 60 klps.
- Essa diferença se refere às funções Pos() e PosEx() que são extensivamente usadas no compilador, que em Delphi são implementadas em Assembly e em FPC são implementadas em Pascal.
- O LLVM-Pascal substitui essas funções, apenas se compilado com FPC, por versões otimizadas em Pascal do site FastCode, o FPC então vai para 110 klps.
- "Compile" seu projeto com LLVM-Pascal e reporte suas questões no fórum: http://groups.google.com/group/llvm-pascal

Para "compilar" use:
LLVM_Pascal *.pas


Are there any languages that target the LLVM that:

    * Are statically typed
    * Use type inference
    * Are functional (i.e. lambda expressions, closures, list primitives, list comprehensions, etc.)
    * Have first class object-oriented features (inheritance, polymorphism, mixins, etc.)
    * Have a sophisticated type system (generics, covariance and contravariance, etc.)

Scala is all of these, but only targets the JVM. F# (and to some extent C#) is most if not all of these, but only targets .NET. What similar language targets the LLVM?
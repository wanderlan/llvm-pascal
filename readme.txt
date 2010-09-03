LLVM-Pascal 2010.9.3 Pre-Alpha

Principal implementação deste release: Scanner e Parser

Home: http://llvm-pascal.googlecode.com
Forum: http://groups.google.com/group/llvm-pascal
License: BSD, http://www.opensource.org/licenses/bsd-license.php

- Por enquanto a "compilação" só faz análise léxica e sintática.
- Compilável com qualquer Delphi até versão 2007 e Free Pascal 2.4.
- Fonte extremamente pequeno e simples usando Orientação a Objetos com Object Pascal.
- "Compila" fontes do Delphi até versão 2007, não suporta operator overload no dialeto Delphi.
- "Compila" fontes do Lazarus até a versão 0.9.28.2 e Free Pascal até a versão 2.4, suporta macros, operator overload e literais binários.
- "Compila" ~ 135 klps (mil linhas por segundo) em um Intel E2200 Dual Core II 2.2 GHz com 2 GB de RAM e Windows XP SP3, compilado com Turbo Delphi, com FPC 2.4 ~ 60 klps.
- Essa diferença provavelmente se refere às funções Pos() e PosEx() que são extensivamente usadas no compilador, que em Delphi são implementadas em Assembly e em FPC são implementadas em Pascal.
- Includes serão suportados no próximo release.
- "Compile" seu projeto com LLVM-Pascal e reporte suas questões no fórum: http://groups.google.com/group/llvm-pascal

Para "compilar" use:
LLVM_Pascal *.pas

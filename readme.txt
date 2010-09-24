LLVM-Pascal 2010.9.21 Pre-Alpha III

Principal implementação deste release: Scanner e Parser

Home: http://llvm-pascal.googlecode.com
Forum: http://groups.google.com/group/llvm-pascal
License: BSD, http://www.opensource.org/licenses/bsd-license.php

- Por enquanto a "compilação" só faz análise léxica e sintática.
- Compilável com qualquer Delphi até versão XE e Free Pascal 2.4.
- Fonte extremamente pequeno e simples usando Orientação a Objetos com Object Pascal.
- "Compila" fontes do dialeto Delphi até a versão XE, não suporta operator overload no dialeto Delphi.
- "Compila" fontes do Lazarus até a versão 0.9.28.2 e Free Pascal até a versão 2.4, 
   suporta macros, generics, operator overload e literais binários.
- "Compila" ~123 klps (mil linhas por segundo) em um Intel E2200 Dual Core II 2.2 GHz com 2 GB de RAM e Windows XP SP3, 
   compilado com Turbo Delphi, com FPC 2.4 ~50 klps.
- Essa diferença se refere às funções Pos() e PosEx() que são extensivamente usadas no compilador, 
  que em Delphi são implementadas em Assembly e em FPC são implementadas em Pascal.
- O LLVM-Pascal substitui essas funções, apenas se compilado com FPC, por versões otimizadas em Pascal do site FastCode, 
  o FPC então vai para ~90 klps e o Turbo Delphi para ~120 klps usando FastCode.
- A performance não é tão boa (~75 klps) em Delphi 2009/2010/XE e as rotinas Pascal do FastCode não funcionam nessas versões do Delphi. 
- A manipulação de strings nas versões Unicode do Delphi parece ter piorado consideravelmente... :(
- "Compile" seu projeto com LLVM-Pascal e reporte suas questões no fórum: http://groups.google.com/group/llvm-pascal

Para "compilar" use:
LLVM_Pascal *.pas


linha de comando para comparação de performance: llvm_pascal"C:\Arquivos de programas\CodeGear\RAD Studio\6.0\source\*.pas" -se1000 -v1
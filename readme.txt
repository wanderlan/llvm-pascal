LLVM-Pascal 2010.9.24 Pre-Alpha IV

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
- "Compila" ~148 klps (mil linhas por segundo) em um Intel E2200 Dual Core II 2.2 GHz com 2 GB de RAM e Windows XP SP3, 
   compilado com Turbo Delphi, com FPC 2.4 ~98 klps.
- Parte dessa diferença se refere às funções Pos, PosEx, UpperCase e LowerCase que são usadas no compilador, 
  que em Delphi são implementadas em Assembly e em FPC são implementadas em Pascal.
- O LLVM-Pascal substitui essas funções, apenas se compilado com FPC, por versões otimizadas em Pascal do site FastCode, 
  o FPC então vai para ~118 klps e o Turbo Delphi para ~147 klps usando FastCode.
- A performance não é tão boa (~95 klps) em Delphi 2009/2010/XE, pois nosso compilador é baseado em AnsiStrings e não em Unicode, gerando muita conversão na VCL. 
- "Compile" seu projeto com LLVM-Pascal e reporte suas questões no fórum: http://groups.google.com/group/llvm-pascal

Para "compilar" use:
LLVM_Pascal *.pas


linha de comando para comparação de performance: LLVM_Pascal "C:\Arquivos de programas\Borland\BDS\4.0\source\*.pas" -fi"C:\Arquivos de programas\Borland\BDS\4.0\source\dunit\contrib\dunitwizard\source\common\" -v1 -vmE130,E139
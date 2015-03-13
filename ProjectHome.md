This is a graduation project to [IESB](http://www.iesb.br), which is scheduled for delivery in July 2012. The supervisor of this project is Professor [Joel Guilherme da Silva Filho](http://lattes.cnpq.br/7746085908957322). One of the authors of this project also created [ExtPascal](http://extpascal.googlecode.com), which allows the development of Web 2.0 applications with Object Pascal.

## Objectives ##

  1. Create an [Object Pascal](http://en.wikipedia.org/wiki/Object_Pascal) compiler following the specifications of the [Free Pascal language reference guide](http://www.freepascal.org/docs-html/ref/ref.html) and [Delphi language guide](http://docwiki.embarcadero.com/RADStudio/en/Delphi_Language_Guide_Index), which corresponds to [Free Pascal 2.6](http://www.freepascal.org) (Delphi mode) and [Delphi XE3](http://www.embarcadero.com/products/delphi).
  1. Use [LLVM (Low Level Virtual Machine)](http://llvm.org) compiler backend (multiplatform code generator and optimizer).
  1. The compiler frontend (scanner and parser) will be [self-hosted](http://en.wikipedia.org/wiki/Self-hosting), in other words, created in the Object Pascal language and compiling itself.
  1. Use and compile Free Pascal [RTL (Runtime Library)](http://lazarus-ccr.sourceforge.net/docs/rtl/index.html) and its [FCL (Free Component Library)](http://lazarus-ccr.sourceforge.net/docs/fcl/index.html).
  1. Use the same [Free Pascal documentation](http://www.freepascal.org/docs.html) with minimal exceptions.
  1. Use [Quest](http://code.google.com/p/quest-tester/) concepts and the Free Pascal [test suite](http://www.freepascal.org/testsuite/cgi-bin/testsuite.cgi) to control its quality.
  1. Compile the [Lazarus](http://lazarus.freepascal.org) IDE for Windows or Linux as a rule passage to reach version 1.0.
  1. Use the [KISS principle](http://en.wikipedia.org/wiki/KISS_principle) (minimalism) to keep the source code as simple, compact and efficient as possible.
  1. Allow average developers understand, document, correct, optimize and develop the compiler frontend.
  1. The techniques used will follow, at first, the [Dragon Book](http://www.amazon.com/Compilers-Principles-Techniques-Tools-2nd/dp/0321486811) 2nd edition.

## Motivation ##

The aim of this work is to produce a compiler that can be used to develop real applications, but at the same time can have its source used for teaching purposes, serving as a case for modern building techniques. The chosen language is Object Pascal, for which there is a large base of applications, libraries, utilities and components, many with open source [[1](http://www.torry.net)]. There are other advantages in choosing Object Pascal for this work described in these links: [[2](http://wiki.freepascal.org/Why_use_Pascal)] and [[3](http://www.at.freepascal.org/advantage.html)]. In 2005 there were over 1.7 million Object Pascal programmers. The Object Pascal dialect which became the de facto standard market was the Object Pascal used by Delphi. Only two compilers currently can build such applications, a commercial (Delphi, which closed source until version XE2 (2011) was developed in C and x86 assembly [[4](https://forums.embarcadero.com/thread.jspa?messageID=252757)]) and another open source (Free Pascal, developed in Pascal). Considering the Free Pascal, why create another open source Object Pascal compiler? The first reason is that there isn't a compiler for LLVM using Object Pascal. But the big driver is the size and complexity of the Free Pascal compiler, which for over 15 years of development and contributions of 55 active developers, today has more than 210,000 lines of code (see http://www.ohloh.net/p/freepascal), which makes it unfeasible to study and very difficult to understand even for experienced programmers. The purpose of LLVM-Pascal is to have a similar functionality with up to 4000 lines of code (52 times smaller). The idea is that the LLVM-Free Pascal is for Pascal/Delphi, what [Minix](http://www.minix3.org) is for Linux/Unix, and also to be able to be used on the same projects where the Free Pascal and Delphi can.

## Limitations ##

Assembly Code (ASM command) directly programmed in Object Pascal source code is not supported. This requires the redevelopment of such functions in Object Pascal or its assembly using external tools with traditional link-editing.

## Syntactic differences ##

LLVM-Pascal tries to follow the same grammar of Delphi Object Pascal. But there are some subtle differences: The LLVM-Pascal finds many syntax errors in source that ship with Delphi, because it has a stricter parser, for example commas and semicolons missing or left. Fixing the sources they will compile correctly on both compilers and also in the FPC. The following syntax, initialization of procedural types with calling convention, is accepted in Delphi:

```
  var
    IdSslCtxSetVerifyDepth : procedure(ctx: PSSL_CTX; depth: Integer); cdecl = nil;
```

In LLVM-Pascal for consistency reasons must be replaced by:


```
  var
    IdSslCtxSetVerifyDepth : procedure(ctx: PSSL_CTX; depth: Integer) cdecl = nil;
```


Without the penultimate semicolon. This syntax, more consistent, it is also accepted by the FPC and Delphi.
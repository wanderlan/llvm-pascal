# Basic steps #
([This summary is based on CRogers' instructions](https://github.com/CRogers/LLVM-Windows-Binaries/blob/master/compiling.md))
## Prepare the Buid ##
  1. Install [Visual Studio 2012+](http://www.microsoft.com/en-us/download/details.aspx?id=34673);
  1. Install [CMake](http://www.cmake.org);
  1. Install [Python 2.7.x](https://www.python.org/);
  1. Download LLVM [sources](http://llvm.org/releases/download.html);
  1. Unzip into **`C:\LLVM-<version>.src`**.
## Configure the Build ##
  1. Run CMake GUI;
  1. Set "source code" to **`C:\LLVM-<version>.src`**;
  1. Set "binaries" to **`C:\LLVM-<version>.bin`**;
  1. Set "Grouped" and "Advanced";
  1. Configure;
  1. Set Generator to **"Visual Studio 11"** (if for VS 2012);
  1. Configure (again);
  1. Generate.
## Build ##
  1. Double-click **`C:\LLVM-<version>.bin\llvm.sln`**;
  1. Change "Debug" to **`MinSizeRel`** or **`Release`**;
  1. Right-click **`ALL-BUILD`** on Solution Explorer;
  1. Build;
  1. Wait...;
  1. The tools will be stored in **`C:\LLVM-<version>.bin\bin\<MinSizeRel or Release>`**;
  1. The libs will be in **`C:\LLVM-<version>.bin\lib\<MinSizeRel or Release>`**;
## Generate the DLL ##
  1. Go to "Start Menu | All Programs | Microsoft Visual Studio 2012 | Visual Studio Tools | VS2012 x86 Native Tools Command Prompt;
  1. Type **> > `cd C:\LLVM-<version>.bin\lib\<MinSizeRel or Release>`**
  1. Type **> > `lib /OUT:big.lib LLVM*.lib`**. This combines all the individual LLVM libs into one big one called big.lib;
  1. Download the **[LibDefExtractor.exe](https://github.com/CRogers/LLVM-Windows-Binaries/blob/master/LibDefExtractor.exe)** tool in this same folder;
  1. Type **> > `LibDefExtractor big.lib LLVM-<version>.def`**. This extracts the non-C++ symbols to a DEF file called `LLVM-<version>.def`;
  1. Download the **[EmptyDllMain.lib](https://github.com/CRogers/LLVM-Windows-Binaries/blob/master/EmptyDllMain.lib)** library in this same folder;
  1. Type **> > `link /DLL /DEF:LLVM-<version>.def /MACHINE:X86 /OUT:LLVM-<version>-X64.dll big.lib EmptyDllMain.lib kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib`**
  1. A DLL of ~12mb should be built, if it is very small something has gone wrong.

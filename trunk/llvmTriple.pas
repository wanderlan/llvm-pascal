(*
    LLVM Triple Class
      > Author: Aleksey A. Naumov [alexey.naumov@gmail.com]
      > License: BSD
*)
unit llvmTriple;

interface

uses
  SysUtils;

type
  TArchType = (
    atUnknownArch,
    atARM,
    atCellSPU,
    atHexagon,
    atMIPS,
    atMIPSel,
    atMIPS64,
    atMIPS64el,
    atMSP430,
    atPPC,
    atPPC64,
    atR600,
    atSparc,
    atSparCV9,
    atTCE,
    atThumb,
    atX86,
    atX86_64,
    atXCore,
    atMBlaze,
    atNVPTX,
    atNVPTX64,
    atLE32,
    atAMDil
  );

  TArchRec = record
    Name: String;
    PBW: Cardinal;
    Alternate: TArchType;
  end;

const
  CArchType: array [TArchType] of TArchRec = (
    (Name: 'UnknownArch';  PBW: 0;    Alternate: atUnknownArch),
    (Name: 'arm';          PBW: 32;   Alternate: atARM),
    (Name: 'cellspu';      PBW: 32;   Alternate: atCellSPU),
    (Name: 'hexagon';      PBW: 32;   Alternate: atHexagon),
    (Name: 'mips';         PBW: 32;   Alternate: atMIPS64),
    (Name: 'mipsel';       PBW: 32;   Alternate: atMIPS64el),
    (Name: 'mips64';       PBW: 64;   Alternate: atMIPS),
    (Name: 'mips64el';     PBW: 64;   Alternate: atMIPSel),
    (Name: 'msp430';       PBW: 16;   Alternate: atUnknownArch),
    (Name: 'ppc';          PBW: 32;   Alternate: atPPC64),
    (Name: 'ppc64';        PBW: 64;   Alternate: atPPC),
    (Name: 'r600';         PBW: 32;   Alternate: atR600),
    (Name: 'sparc';        PBW: 32;   Alternate: atSparcV9),
    (Name: 'sparcv9';      PBW: 64;   Alternate: atSparc),
    (Name: 'tce';          PBW: 32;   Alternate: atTCE),
    (Name: 'thumb';        PBW: 32;   Alternate: atThumb),
    (Name: 'x86';          PBW: 32;   Alternate: atX86_64),
    (Name: 'x86_64';       PBW: 64;   Alternate: atX86),
    (Name: 'xcore';        PBW: 32;   Alternate: atXCore),
    (Name: 'mblaze';       PBW: 32;   Alternate: atMBlaze),
    (Name: 'nvptx';        PBW: 32;   Alternate: atNVPTX64),
    (Name: 'nvptx64';      PBW: 64;   Alternate: atNVPTX),
    (Name: 'le32';         PBW: 32;   Alternate: atLE32),
    (Name: 'amdil';        PBW: 32;   Alternate: atAMDil)
  );

type
  TVendorType = (
    vtUnknownVendor,
    vtApple,
    vtPC,
    vtSCEI,
    vtBGP,
    vtBGQ
  );

const
  CVendorType: array [TVendorType] of String = (
    'UnknownVendor',
    'Apple',
    'PC',
    'SCEI',
    'BGP',
    'BGQ'
  );

type
  TOSType = (
    otUnknownOS,
    otAuroraUX,
    otCygwin,
    otDarwin,
    otDragonFly,
    otFreeBSD,
    otIOS,
    otKFreeBSD,
    otLinux,
    otLv2,
    otMacOSX,
    otMinGW32,
    otNetBSD,
    otOpenBSD,
    otSolaris,
    otWin32,
    otHaiku,
    otMinix,
    otRTEMS,
    otNativeClient,
    otCNK
  );

const
  COSType: array [TOSType] of String = (
    'UnknownOS',
    'AuroraUX',
    'Cygwin',
    'Darwin',
    'DragonFly',
    'FreeBSD',
    'IOS',
    'KFreeBSD',
    'Linux',
    'Lv2',
    'MacOSX',
    'MinGW32',
    'NetBSD',
    'OpenBSD',
    'Solaris',
    'Win32',
    'Haiku',
    'Minix',
    'RTEMS',
    'NativeClient',
    'CNK'
  );

type
  TEnvironmentType = (
    etUnknownEnvironment,
    etGNU,
    etGNUEABI,
    etGNUEABIHF,
    etEABI,
    etMachO,
    etANDROIDEABI
  );

const
  CEnvironmentType: array [TEnvironmentType] of String = (
    'UnknownEnvironment',
    'GNU',
    'GNUEABI',
    'GNUEABIHF',
    'EABI',
    'MachO',
    'ANDROIDEABI'
  );

type
  TLLVMTriple = class
  private
    FArchType: TArchType;
    FVendorType: TVendorType;
    FOSType: TOSType;
    FEnvType: TEnvironmentType;
    FTriple: String;
    procedure BuildTriple;
    procedure ParseTriple;
    procedure SetArchType(const Value: TArchType);
    procedure SetEnvType(const Value: TEnvironmentType);
    procedure SetOSType(const Value: TOSType);
    procedure SetVendorType(const Value: TVendorType);
    procedure SetTriple(const Value: String);
    function GetArchTypeName: String;
    function GetEnvTypeName: String;
    function GetOSTypeName: String;
    function GetVendorTypeName: String;
    function GetArchPointerBitWidth: Cardinal;
  public
    constructor Create; overload;
    constructor Create(const ATriple: String); overload;
    constructor Create(AArchType: TArchType; AVendorType: TVendorType;
      AOSType: TOSType); overload;
    constructor Create(AArchType: TArchType; AVendorType: TVendorType;
      AOSType: TOSType; AEnvType: TEnvironmentType); overload;
    destructor Destroy; override;

    function IsArch16Bit: Boolean;
    function IsArch32Bit: Boolean;
    function IsArch64Bit: Boolean;
    function HasEnvironment: Boolean;

    function Get32BitArchVariant: TArchType;
    function Get64BitArchVariant: TArchType;

    procedure SwitchTo32BitArchVariant;
    procedure SwitchTo64BitArchVariant;
  public
    property Triple: String read FTriple write SetTriple;

    property ArchType: TArchType read FArchType write SetArchType;
    property VendorType: TVendorType read FVendorType write SetVendorType;
    property OSType: TOSType read FOSType write SetOSType;
    property EnvType: TEnvironmentType read FEnvType write SetEnvType;

    property ArchTypeName: String read GetArchTypeName;
    property VendorTypeName: String read GetVendorTypeName;
    property OSTypeName: String read GetOSTypeName;
    property EnvTypeName: String read GetEnvTypeName;

    property ArchPointerBitWidth: Cardinal read GetArchPointerBitWidth;
  end;

implementation

{ TLLVMTriple }

procedure TLLVMTriple.BuildTriple;
begin
  FTriple := GetArchTypeName + '-' +
             GetVendorTypeName + '-' +
             GetOSTypeName;

  if HasEnvironment then
    FTriple := FTriple + '-' + GetEnvTypeName;
end;

constructor TLLVMTriple.Create(AArchType: TArchType; AVendorType: TVendorType;
  AOSType: TOSType);
begin
  FArchType := AArchType;
  FVendorType := AVendorType;
  FOSType := AOSType;
  FEnvType := etUnknownEnvironment;
  FTriple := '';
  BuildTriple;
end;

constructor TLLVMTriple.Create(AArchType: TArchType; AVendorType: TVendorType;
  AOSType: TOSType; AEnvType: TEnvironmentType);
begin
  FArchType := AArchType;
  FVendorType := AVendorType;
  FOSType := AOSType;
  FEnvType := AEnvType;
  FTriple := '';
  BuildTriple;
end;

constructor TLLVMTriple.Create;
begin
  FArchType := atUnknownArch;
  FVendorType := vtUnknownVendor;
  FOSType := otUnknownOS;
  FEnvType := etUnknownEnvironment;
  FTriple := '';
  BuildTriple;
end;

constructor TLLVMTriple.Create(const ATriple: String);
begin
  FArchType := atUnknownArch;
  FVendorType := vtUnknownVendor;
  FOSType := otUnknownOS;
  FEnvType := etUnknownEnvironment;
  FTriple := ATriple;
  ParseTriple;
end;

destructor TLLVMTriple.Destroy;
begin
  inherited;
end;

function TLLVMTriple.Get32BitArchVariant: TArchType;
begin
  Result := FArchType;
  if (CArchType[FArchType].PBW <> 32) then
    Result := CArchType[FArchType].Alternate;
end;

function TLLVMTriple.Get64BitArchVariant: TArchType;
begin
  Result := FArchType;
  if (CArchType[FArchType].PBW <> 64) then
    Result := CArchType[FArchType].Alternate;
end;

function TLLVMTriple.GetArchPointerBitWidth: Cardinal;
begin
  Result := CArchType[FArchType].PBW;
end;

function TLLVMTriple.GetArchTypeName: String;
begin
  Result := CArchType[FArchType].Name;
end;

function TLLVMTriple.GetEnvTypeName: String;
begin
  Result := CEnvironmentType[FEnvType];
end;

function TLLVMTriple.GetOSTypeName: String;
begin
  Result := COSType[FOSType];
end;

function TLLVMTriple.GetVendorTypeName: String;
begin
  Result := CVendorType[FVendorType];
end;

function TLLVMTriple.HasEnvironment: Boolean;
begin
  Result := (FEnvType <> etUnknownEnvironment);
end;

function TLLVMTriple.IsArch16Bit: Boolean;
begin
  Result := (GetArchPointerBitWidth = 16);
end;

function TLLVMTriple.IsArch32Bit: Boolean;
begin
  Result := (GetArchPointerBitWidth = 32);
end;

function TLLVMTriple.IsArch64Bit: Boolean;
begin
  Result := (GetArchPointerBitWidth = 64);
end;

procedure TLLVMTriple.ParseTriple;
begin
  // ToDo: Parse FTriple to Arch/Vendor/OS/Environment
  raise Exception.Create('[ParseTriple] Not ready yet!');
end;

procedure TLLVMTriple.SetArchType(const Value: TArchType);
begin
  if (FArchType <> Value) then
  begin
    FArchType := Value;
    BuildTriple;
  end;
end;

procedure TLLVMTriple.SetEnvType(const Value: TEnvironmentType);
begin
  if (FEnvType <> Value) then
  begin
    FEnvType := Value;
    BuildTriple;
  end;
end;

procedure TLLVMTriple.SetOSType(const Value: TOSType);
begin
  if (FOSType <> Value) then
  begin
    FOSType := Value;
    BuildTriple;
  end;
end;

procedure TLLVMTriple.SetTriple(const Value: String);
begin
  if (FTriple <> Value) then
  begin
    FTriple := Value;
    ParseTriple;
  end;
end;

procedure TLLVMTriple.SetVendorType(const Value: TVendorType);
begin
  if (FVendorType <> Value) then
  begin
    FVendorType := Value;
    BuildTriple;
  end;
end;

procedure TLLVMTriple.SwitchTo32BitArchVariant;
begin
  SetArchType(Get32BitArchVariant);
end;

procedure TLLVMTriple.SwitchTo64BitArchVariant;
begin
  SetArchType(Get64BitArchVariant);
end;

end.

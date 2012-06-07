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

const
  CArchType: array [TArchType] of String = (
    'UnknownArch',
    'arm',
    'cellspu',
    'hexagon',
    'mips',
    'mipsel',
    'mips64',
    'mips64el',
    'msp430',
    'ppc',
    'ppc64',
    'r600',
    'sparc',
    'sparcv9',
    'tce',
    'thumb',
    'x86',
    'x86_64',
    'xcore',
    'mblaze',
    'nvptx',
    'nvptx64',
    'le32',
    'amdil'
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
  public
    constructor Create; overload;
    constructor Create(const ATriple: String); overload;
    constructor Create(AArchType: TArchType; AVendorType: TVendorType;
      AOSType: TOSType); overload;
    constructor Create(AArchType: TArchType; AVendorType: TVendorType;
      AOSType: TOSType; AEnvType: TEnvironmentType); overload;
    destructor Destroy; override;
  public
    function GetArchTypeName: String;
    function GetEnvTypeName: String;
    function GetOSTypeName: String;
    function GetVendorTypeName: String;
    function HasEnvironment: Boolean;
  public
    property ArchType: TArchType read FArchType write SetArchType;
    property ArchTypeName: String read GetArchTypeName;
    property VendorType: TVendorType read FVendorType write SetVendorType;
    property VendorTypeName: String read GetVendorTypeName;
    property OSType: TOSType read FOSType write SetOSType;
    property OSTypeName: String read GetOSTypeName;
    property EnvType: TEnvironmentType read FEnvType write SetEnvType;
    property EnvTypeName: String read GetEnvTypeName;
    property Triple: String read FTriple write SetTriple;
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

function TLLVMTriple.GetArchTypeName: String;
begin
  Result := CArchType[FArchType];
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

end.

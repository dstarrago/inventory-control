unit Kernel;

interface

uses ComCtrls;

const
  MaxBusTypes = 3;
  MaxFloppyTypes = 2;
  MaxPowerSupplyTypes = 2;
  MaxProcessorTypes = 1;

var
  TheBusType: array[1..MaxBusTypes] of string = ('ISA', 'PCI', 'AGP');
  TheFloppyType: array[1..MaxFloppyTypes] of string = ('5 1/4''', '3 1/2''');
  ThePowerSupplyType: array [1..MaxPowerSupplyTypes] of string = ('AT', 'ATX');
  TheProcessorType: array [1..MaxProcessorTypes] of string = ('Procesador');

type
  TInvItem = class(TTreeNode)
  private
    FID: integer;
    FTable: string;
    procedure SetID(const Value: integer);
    function GetDescription: string;
    function GetLocation: integer;
    procedure SetDescription(const Value: string);
    procedure SetLocation(const Value: integer);
    procedure SetTable(const Value: string);
  public
    property ID: integer read FID write SetID;
    property Table: string read FTable write SetTable;
    property Description: string read GetDescription write SetDescription;
    property Location: integer read GetLocation write SetLocation;
    constructor CreateItem(aOwner: TTreeNodes; const anID: integer; const aTable: string);
    procedure ShowProperties(ListItems: TListItems); virtual;
  end;

  TUbication = class(TInvItem)
  private
    procedure SetItemName(const Value: string);
    function GetItemName: string;
  public
    property ItemName: string read GetItemName write SetItemName;
  end;

  TComputer = class(TInvItem)
  private
    function GetNumber: integer;
    function GetPrevNumber: string;
    function GetState: string;
    procedure SetNumber(const Value: integer);
    procedure SetPrevNumber(const Value: string);
    procedure SetState(const Value: string);
  public
    property Number: integer read GetNumber write SetNumber;
    property PrevNumber: string read GetPrevNumber write SetPrevNumber;
    property State: string read GetState write SetState;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TElement = class(TInvItem)
  private
    function GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    function GetState: string;
    procedure SetState(const Value: string);
  public
    property Connected: boolean read GetConnected write SetConnected;
    property State: string read GetState write SetState;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TNetAdapter = class(TElement)
  private
    function GetBus: string;
    function GetOnBoard: boolean;
    procedure SetBus(const Value: string);
    procedure SetOnBoard(const Value: boolean);
    function GetItemName: string;
    procedure SetItemName(const Value: string);
  public
    property Bus: string read GetBus write SetBus;
    property OnBoard: boolean read GetOnBoard write SetOnBoard;
    property ItemName: string read GetItemName write SetItemName;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TVideoAdapter = class(TElement)
  private
    function GetBus: string;
    function GetItemName: string;
    function GetOnBoard: boolean;
    function GetRAM: integer;
    procedure SetBus(const Value: string);
    procedure SetItemName(const Value: string);
    procedure SetOnBoard(const Value: boolean);
    procedure SetRAM(const Value: integer);
  public
    property Bus: string read GetBus write SetBus;
    property OnBoard: boolean read GetOnBoard write SetOnBoard;
    property ItemName: string read GetItemName write SetItemName;
    property RAM: integer read GetRAM write SetRAM;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TCDD = class(TElement)
  private
    function GetSerial: string;
    function GetSpeed: integer;
    procedure SetSerial(const Value: string);
    procedure SetSpeed(const Value: integer);
  public
    property Serial: string read GetSerial write SetSerial;
    property Speed: integer read GetSpeed write SetSpeed;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TFDD = class(TElement)
  private
    function GetFloppyType: string;
    function GetSerial: string;
    procedure SetFloppyType(const Value: string);
    procedure SetSerial(const Value: string);
  public
    property Serial: string read GetSerial write SetSerial;
    property FloppyType: string read GetFloppyType write SetFloppyType;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TPowerSupply = class(TElement)
  private
    function GetPowerSupplyType: string;
    function GetSerial: string;
    procedure SetPowerSupplyType(const Value: string);
    procedure SetSerial(const Value: string);
  public
    property Serial: string read GetSerial write SetSerial;
    property PowerSupplyType: string read GetPowerSupplyType write SetPowerSupplyType;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  THDD = class(TElement)
  private
    function GetCapacity: integer;
    function GetMark: string;
    function GetSerial: string;
    procedure SetCapacity(const Value: integer);
    procedure SetMark(const Value: string);
    procedure SetSerial(const Value: string);
  public
    property Serial: string read GetSerial write SetSerial;
    property Mark: string read GetMark write SetMark;
    property Capacity: integer read GetCapacity write SetCapacity;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TPrinter = class(TElement)
  private
    function GetModel: string;
    procedure SetModel(const Value: string);
  public
    property Model: string read GetModel write SetModel;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TMicroprocessor = class(TElement)
  private
    function GetFrequency: integer;
    function GetItemName: string;
    function GetProcessorType: string;
    procedure SetFrequency(const Value: integer);
    procedure SetItemName(const Value: string);
    procedure SetProcessorType(const Value: string);
  public
    property ItemName: string read GetItemName write SetItemName;
    property ProcessorType: string read GetProcessorType write SetProcessorType;
    property Frequency: integer read GetFrequency write SetFrequency;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TModem = class(TElement)
  private
    function GetItemName: string;
    function GetOnBoard: boolean;
    function GetSpeed: integer;
    procedure SetItemName(const Value: string);
    procedure SetOnBoard(const Value: boolean);
    procedure SetSpeed(const Value: integer);
  public
    property ItemName: string read GetItemName write SetItemName;
    property Speed: integer read GetSpeed write SetSpeed;
    property OnBoard: boolean read GetOnBoard write SetOnBoard;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TDisplay = class(TElement)
  private
    function GetModel: string;
    function GetNumbering: string;
    procedure SetModel(const Value: string);
    procedure SetNumbering(const Value: string);
  public
    property Numbering: string read GetNumbering write SetNumbering;
    property Model: string read GetModel write SetModel;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TMotherBoard = class(TElement)
  private
    function GetBIOS: string;
    function GetBIOSDate: TDateTime;
    function GetBIOSVersion: string;
    function GetModel: string;
    function GetSerial: string;
    procedure SetBIOS(const Value: string);
    procedure SetBIOSDate(const Value: TDateTime);
    procedure SetBIOSVersion(const Value: string);
    procedure SetModel(const Value: string);
    procedure SetSerial(const Value: string);
  public
    property Model: string read GetModel write SetModel;
    property Serial: string read GetSerial write SetSerial;
    property BIOS: string read GetBIOS write SetBIOS;
    property BIOSDate: TDateTime read GetBIOSDate write SetBIOSDate;
    property BIOSVersion: string read GetBIOSVersion write SetBIOSVersion;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TRAM = class(TElement)
  private
    function GetCapacity: integer;
    function GetRAMType: string;
    procedure SetCapacity(const Value: integer);
    procedure SetRAMType(const Value: string);
  public
    property Capacity: integer read GetCapacity write SetCapacity;
    property RAMType: string read GetRAMType write SetRAMType;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TMouse = class(TElement)
  private
    function GetModel: string;
    function GetNumbering: string;
    procedure SetModel(const Value: string);
    procedure SetNumbering(const Value: string);
  public
    property Numbering: string read GetNumbering write SetNumbering;
    property Model: string read GetModel write SetModel;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TKeyBoard = class(TElement)
  private
    function GetModel: string;
    function GetNumbering: string;
    procedure SetModel(const Value: string);
    procedure SetNumbering(const Value: string);
  public
    property Numbering: string read GetNumbering write SetNumbering;
    property Model: string read GetModel write SetModel;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

  TOtherDevice = class(TElement)
  private
    function GetItemName: string;
    procedure SetItemName(const Value: string);
  public
    property ItemName: string read GetItemName write SetItemName;
    procedure ShowProperties(ListItems: TListItems); override;
  end;

implementation

uses DBTables, MainForm, SysUtils;

var
  TheQuery: TQuery;

{ TInvItem }

constructor TInvItem.CreateItem(aOwner: TTreeNodes; const anID: integer;
  const aTable: string);
begin
  inherited Create(aOwner);
  FID := anID;
  FTable := aTable;
end;

function TInvItem.GetDescription: string;
var
  DescripKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Descripcion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  try
    DescripKey := TheQuery.FieldValues['Descripcion'];
    TheQuery.SQL.Clear;
    TheQuery.SQL.Add('select Texto');
    TheQuery.SQL.Add('from Descripciones');
    TheQuery.SQL.Add(Format('where ID = %d', [DescripKey]));
    Result := TheQuery.FieldValues['Texto'];
  except
    Result := '';
  end;
end;

function TInvItem.GetLocation: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Ubicacion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Ubicacion'];
end;

procedure TInvItem.SetDescription(const Value: string);
var
  DescripKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Descripcion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  DescripKey := TheQuery.FieldValues['Descripcion'];
  if DescripKey > 0
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add('update Descripciones');
        TheQuery.SQL.Add(Format('set Texto = %s', [Value]));
        TheQuery.SQL.Add(Format('where ID = %d', [DescripKey]));
      end
    else
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add('insert into Descripciones');
        TheQuery.SQL.Add('(Texto)');
        TheQuery.SQL.Add(Format('Values ("%s")', [Value]));
      end;
  TheQuery.Open;
end;

procedure TInvItem.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TInvItem.SetLocation(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Ubicacion = %d', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TInvItem.SetTable(const Value: string);
begin
  FTable := Value;
end;

procedure TInvItem.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  ListItems.Clear;
  if Description <> ''
    then
      begin
        Item := ListItems.Insert(0);
        Item.Caption := 'Descripcion: ' + Description;
      end;
end;

{ TUbication }

function TUbication.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

procedure TUbication.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

{ TComputer }

function TComputer.GetNumber: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Numeracion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Numeracion'];
end;

function TComputer.GetPrevNumber: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NumeroAnterior');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NumeroAnterior'];
end;

function TComputer.GetState: string;
var
  StateKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Estado');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  try
    StateKey := TheQuery.FieldValues['Estado'];
    TheQuery.SQL.Clear;
    TheQuery.SQL.Add('select Texto');
    TheQuery.SQL.Add('from Estado');
    TheQuery.SQL.Add(Format('where ID = %d', [StateKey]));
    Result := TheQuery.FieldValues['Texto'];
  except
    Result := '';
  end;
end;

procedure TComputer.SetNumber(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Numeracion = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TComputer.SetPrevNumber(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NumeroAnterior = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TComputer.SetState(const Value: string);
var
  StateKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Estado');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  StateKey := TheQuery.FieldValues['Estado'];
  if StateKey > 0
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set Texto = %s', [Value]));
        TheQuery.SQL.Add(Format('where ID = %d', [StateKey]));
      end
    else
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add('insert into Estado');
        TheQuery.SQL.Add('(Texto)');
        TheQuery.SQL.Add(Format('Values ("%s")', [Value]));
      end;
  TheQuery.Open;
end;

procedure TComputer.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  if State <> ''
    then
      begin
        Item := ListItems.Insert(0);
        Item.Caption := 'Estado: ' + State;
      end;
    Item := ListItems.Insert(0);
    Item.Caption := 'Número Anterior: ' + PrevNumber;
    Item := ListItems.Insert(0);
    Item.Caption := 'Numeración: ' + IntToStr(Number);
end;

{ TElement }

function TElement.GetConnected: boolean;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Conectado');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Conectado'];
end;

function TElement.GetState: string;
var
  StateKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Estado');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  try
    StateKey := TheQuery.FieldValues['Estado'];
    TheQuery.SQL.Clear;
    TheQuery.SQL.Add('select Texto');
    TheQuery.SQL.Add('from Estado');
    TheQuery.SQL.Add(Format('where ID = %d', [StateKey]));
    Result := TheQuery.FieldValues['Texto'];
  except
    Result := '';
  end;
end;

procedure TElement.SetConnected(const Value: boolean);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Conectado = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TElement.SetState(const Value: string);
var
  StateKey: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Estado');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  StateKey := TheQuery.FieldValues['Estado'];
  if StateKey > 0
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set Texto = %s', [Value]));
        TheQuery.SQL.Add(Format('where ID = %d', [StateKey]));
      end
    else
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add('insert into Estado');
        TheQuery.SQL.Add('(Texto)');
        TheQuery.SQL.Add(Format('Values ("%s")', [Value]));
      end;
  TheQuery.Open;
end;

procedure TElement.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  if State <> ''
    then
      begin
        Item := ListItems.Insert(0);
        Item.Caption := 'Estado: ' + State;
      end;
  Item := ListItems.Insert(0);
  Item.Caption := 'Conectado: ' + BoolToStr(Connected, true);
end;

{ TNetAdapter }

function TNetAdapter.GetBus: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select BUS');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheBusType[integer(TheQuery.FieldValues['BUS'])];
end;

function TNetAdapter.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

function TNetAdapter.GetOnBoard: boolean;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select OnBoard');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['OnBoard'];
end;

procedure TNetAdapter.SetBus(const Value: string);
var
  i: integer;
begin
  i := 1;
  while (i <= MaxBusTypes) and (TheBusType[i] <> Value)
    do inc(i);
  if TheBusType[i] = Value
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set BUS = %s', [i]));
        TheQuery.SQL.Add(Format('where ID = %d', [ID]));
        TheQuery.Open;
      end;
end;

procedure TNetAdapter.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TNetAdapter.SetOnBoard(const Value: boolean);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set OnBoard = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TNetAdapter.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'OnBoard: ' + BoolToStr(OnBoard, true);
  Item := ListItems.Insert(0);
  Item.Caption := 'BUS: ' + BUS;
  Item := ListItems.Insert(0);
  Item.Caption := 'Nombre: ' + ItemName;
end;

{ TVideoAdapter }

function TVideoAdapter.GetBus: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select BUS');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheBusType[integer(TheQuery.FieldValues['BUS'])];
end;

function TVideoAdapter.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

function TVideoAdapter.GetOnBoard: boolean;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select OnBoard');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['OnBoard'];
end;

function TVideoAdapter.GetRAM: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select RAM');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['RAM'];
end;

procedure TVideoAdapter.SetBus(const Value: string);
var
  i: integer;
begin
  i := 1;
  while (i <= MaxBusTypes) and (TheBusType[i] <> Value)
    do inc(i);
  if TheBusType[i] = Value
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set BUS = %s', [i]));
        TheQuery.SQL.Add(Format('where ID = %d', [ID]));
        TheQuery.Open;
      end;
end;

procedure TVideoAdapter.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TVideoAdapter.SetOnBoard(const Value: boolean);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set OnBoard = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TVideoAdapter.SetRAM(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set RAM = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TVideoAdapter.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Video RAM: ' + IntToStr(RAM);
  Item := ListItems.Insert(0);
  Item.Caption := 'OnBoard: ' + BoolToStr(OnBoard, true);
  Item := ListItems.Insert(0);
  Item.Caption := 'BUS: ' + BUS;
  Item := ListItems.Insert(0);
  Item.Caption := 'Nombre: ' + ItemName;
end;

{ TCDD }

function TCDD.GetSerial: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NoSerie');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NoSerie'];
end;

function TCDD.GetSpeed: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Velocidad');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Velocidad'];
end;

procedure TCDD.SetSerial(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NoSerie = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TCDD.SetSpeed(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Velocidad = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TCDD.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Velocidad: ' + IntToStr(Speed);
  Item := ListItems.Insert(0);
  Item.Caption := 'No. de Serie: ' + Serial;
end;

{ TFDD }

function TFDD.GetFloppyType: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Tipo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  if TheQuery.FieldValues['Tipo'] > 0
    then Result := TheFloppyType[integer(TheQuery.FieldValues['Tipo'])]
    else Result := '';
end;

function TFDD.GetSerial: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NoSerie');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NoSerie'];
end;

procedure TFDD.SetFloppyType(const Value: string);
var
  i: integer;
begin
  i := 1;
  while (i <= MaxFloppyTypes) and (FloppyType[i] <> Value)
    do inc(i);
  if FloppyType[i] = Value
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set Tipo = %s', [i]));
        TheQuery.SQL.Add(Format('where ID = %d', [ID]));
        TheQuery.Open;
      end;
end;

procedure TFDD.SetSerial(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NoSerie = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TFDD.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  if FloppyType <> ''
    then
      begin
        Item := ListItems.Insert(0);
        Item.Caption := 'Tipo: ' + FloppyType;
      end;
  Item := ListItems.Insert(0);
  Item.Caption := 'No. de Serie: ' + Serial;
end;

{ TPowerSupply }

function TPowerSupply.GetPowerSupplyType: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Tipo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  if TheQuery.FieldValues['Tipo'] > 0
    then Result := ThePowerSupplyType[integer(TheQuery.FieldValues['Tipo'])]
    else Result := '';
end;

function TPowerSupply.GetSerial: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NoSerie');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NoSerie'];
end;

procedure TPowerSupply.SetPowerSupplyType(const Value: string);
var
  i: integer;
begin
  i := 1;
  while (i <= MaxPowerSupplyTypes) and (ThePowerSupplyType[i] <> Value)
    do inc(i);
  if ThePowerSupplyType[i] = Value
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set Tipo = %s', [i]));
        TheQuery.SQL.Add(Format('where ID = %d', [ID]));
        TheQuery.Open;
      end;
end;

procedure TPowerSupply.SetSerial(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NoSerie = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TPowerSupply.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  if PowerSupplyType <> ''
    then
      begin
        Item := ListItems.Insert(0);
        Item.Caption := 'Tipo: ' + PowerSupplyType;
      end;
  Item := ListItems.Insert(0);
  Item.Caption := 'No. de Serie: ' + Serial;
end;

{ THDD }

function THDD.GetCapacity: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Capacidad');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Capacidad'];
end;

function THDD.GetMark: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Marca');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Marca'];
end;

function THDD.GetSerial: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NoSerie');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NoSerie'];
end;

procedure THDD.SetCapacity(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Capacidad = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure THDD.SetMark(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Marca = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure THDD.SetSerial(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NoSerie = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure THDD.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'No. de Serie: ' + Serial;
  Item := ListItems.Insert(0);
  Item.Caption := 'Capacidad: ' + IntToStr(Capacity);
  Item := ListItems.Insert(0);
  Item.Caption := 'Marca: ' + Mark;
end;

{ TPrinter }

function TPrinter.GetModel: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Modelo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Modelo'];
end;

procedure TPrinter.SetModel(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Modelo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TPrinter.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Modelo: ' + Model;
end;

{ TMicroprocessor }

function TMicroprocessor.GetFrequency: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Frecuencia');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Frecuencia'];
end;

function TMicroprocessor.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

function TMicroprocessor.GetProcessorType: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Tipo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheProcessorType[integer(TheQuery.FieldValues['Tipo'])];
end;

procedure TMicroprocessor.SetFrequency(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Frecuencia = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMicroprocessor.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMicroprocessor.SetProcessorType(const Value: string);
var
  i: integer;
begin
  i := 1;
  while (i <= MaxProcessorTypes) and (TheProcessorType[i] <> Value)
    do inc(i);
  if TheProcessorType[i] = Value
    then
      begin
        TheQuery.SQL.Clear;
        TheQuery.SQL.Add(Format('update %s', [Table]));
        TheQuery.SQL.Add(Format('set Tipo = %s', [Value]));
        TheQuery.SQL.Add(Format('where ID = %d', [ID]));
        TheQuery.Open;
      end;
end;

procedure TMicroprocessor.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Frecuencia: ' + IntToStr(Frequency);
  Item := ListItems.Insert(0);
  Item.Caption := 'Tipo: ' + ProcessorType;
  Item := ListItems.Insert(0);
  Item.Caption := 'Nombre: ' + ItemName;
end;

{ TModem }

function TModem.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

function TModem.GetOnBoard: boolean;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select OnBoard');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['OnBoard'];
end;

function TModem.GetSpeed: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Velocidad');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Velocidad'];
end;

procedure TModem.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TModem.SetOnBoard(const Value: boolean);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set OnBoard = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TModem.SetSpeed(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Velocidad = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TModem.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'OnBoard: ' + BoolToStr(OnBoard, true);
  Item := ListItems.Insert(0);
  Item.Caption := 'Velocidad: ' + IntToStr(Speed);
  Item := ListItems.Insert(0);
  Item.Caption := 'Nombre: ' + ItemName;
end;

{ TDisplay }

function TDisplay.GetModel: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Modelo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Modelo'];
end;

function TDisplay.GetNumbering: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Numeracion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Numeracion'];
end;

procedure TDisplay.SetModel(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Modelo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TDisplay.SetNumbering(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Numeracion = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TDisplay.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Modelo: ' + Model;
  Item := ListItems.Insert(0);
  Item.Caption := 'Numeracion: ' + Numbering;
end;

{ TMotherBoard }

function TMotherBoard.GetBIOS: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select BIOS');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['BIOS'];
end;

function TMotherBoard.GetBIOSDate: TDateTime;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select FechaBIOS');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['FechaBIOS'];
end;

function TMotherBoard.GetBIOSVersion: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select VersionBIOS');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['VersionBIOS'];
end;

function TMotherBoard.GetModel: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Modelo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Modelo'];
end;

function TMotherBoard.GetSerial: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select NoSerie');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['NoSerie'];
end;

procedure TMotherBoard.SetBIOS(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set BIOS = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMotherBoard.SetBIOSDate(const Value: TDateTime);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set FechaBIOS = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMotherBoard.SetBIOSVersion(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set VersionBIOS = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMotherBoard.SetModel(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Modelo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMotherBoard.SetSerial(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set NoSerie = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMotherBoard.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'No. de Serie: ' + Serial;
  Item := ListItems.Insert(0);
  Item.Caption := 'Fecha del BIOS: ' + DateTimeToStr(BIOSDate);
  Item := ListItems.Insert(0);
  Item.Caption := 'Version del BIOS: ' + BIOSVersion;
  Item := ListItems.Insert(0);
  Item.Caption := 'BIOS: ' + BIOS;
  Item := ListItems.Insert(0);
  Item.Caption := 'Modelo: ' + Model;
end;

{ TRAM }

function TRAM.GetCapacity: integer;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Capacidad');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Capacidad'];
end;

function TRAM.GetRAMType: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Tipo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Tipo'];
end;

procedure TRAM.SetCapacity(const Value: integer);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Capacidad = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TRAM.SetRAMType(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Tipo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TRAM.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Tipo: ' + RAMType;
  Item := ListItems.Insert(0);
  Item.Caption := 'Capacidad: ' + IntToStr(Capacity);
end;

{ TMouse }

function TMouse.GetModel: string; 
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Modelo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Modelo'];
end;

function TMouse.GetNumbering: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Numeracion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Numeracion'];
end;

procedure TMouse.SetModel(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Modelo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMouse.SetNumbering(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Numeracion = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TMouse.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Modelo: ' + Model;
  Item := ListItems.Insert(0);
  Item.Caption := 'Numeracion: ' + Numbering;
end;

{ TKeyBoard }

function TKeyBoard.GetModel: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Modelo');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Modelo'];
end;

function TKeyBoard.GetNumbering: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Numeracion');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Numeracion'];
end;

procedure TKeyBoard.SetModel(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Modelo = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TKeyBoard.SetNumbering(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Numeracion = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TKeyBoard.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Modelo: ' + Model;
  Item := ListItems.Insert(0);
  Item.Caption := 'Numeracion: ' + Numbering;
end;

{ TOtherDevice }

function TOtherDevice.GetItemName: string;
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add('select Nombre');
  TheQuery.SQL.Add(Format('from %s', [Table]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
  Result := TheQuery.FieldValues['Nombre'];
end;

procedure TOtherDevice.SetItemName(const Value: string);
begin
  TheQuery.SQL.Clear;
  TheQuery.SQL.Add(Format('update %s', [Table]));
  TheQuery.SQL.Add(Format('set Nombre = %s', [Value]));
  TheQuery.SQL.Add(Format('where ID = %d', [ID]));
  TheQuery.Open;
end;

procedure TOtherDevice.ShowProperties(ListItems: TListItems);
var
  Item: TListItem;
begin
  inherited;
  Item := ListItems.Insert(0);
  Item.Caption := 'Nombre: ' + ItemName;
end;

initialization

  TheQuery := TQuery.Create(Form1);
  //TheQuery.DataSource := Form1.DataSource1;
  TheQuery.DatabaseName := 'Inventario';
  TheQuery.SessionName := 'Session001';

finalization

  TheQuery.Free;

end.

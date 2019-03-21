unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnMan, ActnList, ActnCtrls, ToolWin,
  ActnMenus, DB, DBTables, StdCtrls, Grids, DBGrids, Menus;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    ListView1: TListView;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    ActionList1: TActionList;
    ActionManager1: TActionManager;
    Query1: TQuery;
    DataSource1: TDataSource;
    Database1: TDatabase;
    Session1: TSession;
    PopupMenu1: TPopupMenu;
    Nuevo1: TMenuItem;
    Cortar1: TMenuItem;
    Copiar1: TMenuItem;
    Eliminar1: TMenuItem;
    CambiarNombre1: TMenuItem;
    Propiedades1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Ubicacion1: TMenuItem;
    N4: TMenuItem;
    Computadora1: TMenuItem;
    N5: TMenuItem;
    AdaptadordeVideo1: TMenuItem;
    AdaptadordeRed1: TMenuItem;
    HDD1: TMenuItem;
    CDD1: TMenuItem;
    FDD1: TMenuItem;
    Fuente1: TMenuItem;
    Raton1: TMenuItem;
    eclado1: TMenuItem;
    Monitor1: TMenuItem;
    RAM1: TMenuItem;
    Modem1: TMenuItem;
    Impresora1: TMenuItem;
    Microprocesador1: TMenuItem;
    MotherBoard1: TMenuItem;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadLocationNode(TreeNode: TTreeNode; const anUbication: integer);
    procedure LoadElements(TreeNode: TTreeNode; const anUbication: integer; const Connected: boolean);
  end;

var
  Form1: TForm1;

implementation

  uses DataModule, Kernel;

{$R *.dfm}

{ TForm1 }

procedure TForm1.LoadLocationNode(TreeNode: TTreeNode; const anUbication: integer);
  var
    i: integer;
    Query: TQuery;
    NewNode: TTreeNode;
  begin
    Query := TQuery.Create(Self);
    Query.DataSource := DataSource1;
    Query.DatabaseName := 'Inventario';
    Query.SessionName := 'Session001';
    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Ubicaciones');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TUbication.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Ubicaciones');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Nombre'], nil, naAddChild);
        LoadLocationNode(NewNode, Query.FieldValues['ID']);
        Query.Next;
      end;
    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Computadoras');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TComputer.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Computadoras');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Computadora ' + IntToStr(Query.FieldValues['Numeracion']), nil, naAddChild);
        LoadElements(NewNode, Query.FieldValues['ID'], True);
        Query.Next;
      end;
    LoadElements(TreeNode, anUbication, False);
    Query.Free;
  end;

procedure TForm1.LoadElements(TreeNode: TTreeNode;
  const anUbication: integer; const Connected: boolean);
  var
    i: integer;
    Query: TQuery;
    NewNode: TTreeNode;
  begin
    Query := TQuery.Create(Self);
    Query.DataSource := DataSource1;
    Query.DatabaseName := 'Inventario';
    Query.SessionName := 'Session001';

    // Impresoras

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Impresoras');
    Query.SQL.Add(Format('where (Ubicacion = %d)', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TPrinter.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Impresoras');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Modelo'], nil, naAddChild);
        Query.Next;
      end;

    // Discos Duros

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from HDD');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := THDD.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'HDD');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Marca'], nil, naAddChild);
        Query.Next;
      end;

    // Discos Floppies

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from FDD');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TFDD.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'FDD');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Floppy ' + Query.FieldValues['NoSerie'], nil, naAddChild);
        Query.Next;
      end;

    // Lectores de Compactos

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from CDD');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TCDD.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'CDD');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'CDD ' + Query.FieldValues['NoSerie'], nil, naAddChild);
        Query.Next;
      end;

    // Adaptadores de Red

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from "Adaptadores de Red"');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TNetAdapter.CreateItem(TreeView1.Items, Query.FieldValues['ID'], '"Adaptadores de Red"');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Nombre'], nil, naAddChild);
        Query.Next;
      end;

    // Adaptadores de Video

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from "Adaptadores de Video"');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TVideoAdapter.CreateItem(TreeView1.Items, Query.FieldValues['ID'], '"Adaptadores de Video"');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Nombre'], nil, naAddChild);
        Query.Next;
      end;

    // Fuentes

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Fuentes');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TPowerSupply.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Fuentes');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Fuente' + Query.FieldValues['NoSerie'], nil, naAddChild);
        Query.Next;
      end;

    // Microprocesadores

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Microprocesadores');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TMicroprocessor.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Microprocesadores');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Nombre'] + ' ' + IntToStr(Query.FieldValues['Frecuencia']), nil, naAddChild);
        Query.Next;
      end;

    // Modems

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Modems');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TModem.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Modems');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Modem ' + Query.FieldValues['Nombre'], nil, naAddChild);
        Query.Next;
      end;

    // Monitores

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Monitores');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TDisplay.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Monitores');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Monitor ' + Query.FieldValues['Modelo'], nil, naAddChild);
        Query.Next;
      end;

    // Mother Boards

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from "Mother Boards"');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TMotherBoard.CreateItem(TreeView1.Items, Query.FieldValues['ID'], '"Mother Boards"');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Mother Board ' + Query.FieldValues['Modelo'], nil, naAddChild);
        Query.Next;
      end;

    // Memoria RAM

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from RAM');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TRAM.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'RAM');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'RAM ' + IntToStr(Query.FieldValues['Capacidad']), nil, naAddChild);
        Query.Next;
      end;

    // Ratones

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Ratones');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TMouse.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Ratones');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Raton' + Query.FieldValues['Modelo'], nil, naAddChild);
        Query.Next;
      end;

    // Teclados

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from Teclados');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TKeyBoard.CreateItem(TreeView1.Items, Query.FieldValues['ID'], 'Teclados');
        TreeView1.Items.AddNode(NewNode, TreeNode, 'Teclado' + Query.FieldValues['NoSerie'], nil, naAddChild);
        Query.Next;
      end;

    // Otros Dispositivos

    Query.SQL.Clear;
    Query.SQL.Add('select *');
    Query.SQL.Add('from "Otros Dispositivos"');
    Query.SQL.Add(Format('where Ubicacion = %d', [anUbication]));
    if Connected
      then Query.SQL.Add('and Conectado = TRUE')
      else Query.SQL.Add('and Conectado = FALSE');
    Query.Open;
    for i := 0 to pred(Query.RecordCount) do
      begin
        NewNode := TOtherDevice.CreateItem(TreeView1.Items, Query.FieldValues['ID'], '"Otros Dispositivos"');
        TreeView1.Items.AddNode(NewNode, TreeNode, Query.FieldValues['Nombre'], nil, naAddChild);
        Query.Next;
      end;

    Query.Free;
end;

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  TInvItem(Node).ShowProperties(ListView1.Items);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadLocationNode(nil, 0);
end;

procedure TForm1.TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
  R1, R2: TPoint;
begin
  if Button = mbRight
    then
      begin
        {R1 := Form1.ClientToScreen(Point(X, Y));
        R2 := TreeView1.ScreenToClient(R1);
        Node := TreeView1.GetNodeAt(R2.X, R2.Y);
        TreeView1.Select(Node, Shift);}
        PopupMenu1.Popup(X, Y);
      end;
end;

end.

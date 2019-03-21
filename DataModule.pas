unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDataModule1 = class(TDataModule)
    AdaptadoresRed: TTable;
    AdaptadoresVideo: TTable;
    CDD: TTable;
    Computadoras: TTable;
    Descripciones: TTable;
    Estado: TTable;
    FDD: TTable;
    Fuentes: TTable;
    HDD: TTable;
    Impresoras: TTable;
    Microprocesadores: TTable;
    Modems: TTable;
    Monitores: TTable;
    MotherBoards: TTable;
    Dispositivos: TTable;
    RAM: TTable;
    Ratones: TTable;
    Teclados: TTable;
    Ubicaciones: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.

object Form1: TForm1
  Left = 204
  Top = 140
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 58
    Width = 4
    Height = 271
    Cursor = crHSplit
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 329
    Width = 536
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 58
    Width = 185
    Height = 271
    Align = alLeft
    Indent = 19
    RightClickSelect = True
    TabOrder = 1
    OnChange = TreeView1Change
    OnMouseUp = TreeView1MouseUp
  end
  object ListView1: TListView
    Left = 189
    Top = 58
    Width = 347
    Height = 271
    Align = alClient
    Columns = <>
    ReadOnly = True
    ShowColumnHeaders = False
    TabOrder = 2
    ViewStyle = vsList
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 29
    Width = 536
    Height = 29
    Caption = 'ActionMainMenuBar1'
    EdgeOuter = esNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 536
    Height = 29
    AllowHiding = True
    Caption = 'ActionToolBar1'
    HorzSeparator = True
    Orientation = boLeftToRight
    PersistentHotKeys = False
    Spacing = 0
  end
  object ActionList1: TActionList
    Left = 504
    Top = 64
  end
  object ActionManager1: TActionManager
    ActionBars.SessionCount = 19
    ActionBars = <>
    LinkedActionLists = <>
    Left = 472
    Top = 64
  end
  object Query1: TQuery
    Active = True
    DatabaseName = 'Inventario'
    SessionName = 'Session001'
    DataSource = DataSource1
    SQL.Strings = (
      'select * from Ubicaciones where Ubicacion = 0')
    Left = 440
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = DataModule1.Ubicaciones
    Left = 408
    Top = 64
  end
  object Database1: TDatabase
    AliasName = 'Inventario'
    DatabaseName = 'Inventario001'
    SessionName = 'Default'
    Left = 376
    Top = 64
  end
  object Session1: TSession
    Active = True
    SessionName = 'Session001'
    Left = 344
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 312
    Top = 64
    object Nuevo1: TMenuItem
      Caption = '&Nuevo'
      object Ubicacion1: TMenuItem
        Caption = 'Ubicacion'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Computadora1: TMenuItem
        Caption = 'Computadora'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object AdaptadordeRed1: TMenuItem
        Caption = 'Adaptador de Red'
      end
      object AdaptadordeVideo1: TMenuItem
        Caption = 'Adaptador de Video'
      end
      object CDD1: TMenuItem
        Caption = 'CDD'
      end
      object FDD1: TMenuItem
        Caption = 'FDD'
      end
      object Fuente1: TMenuItem
        Caption = 'Fuente'
      end
      object HDD1: TMenuItem
        Caption = 'HDD'
      end
      object Impresora1: TMenuItem
        Caption = 'Impresora'
      end
      object Microprocesador1: TMenuItem
        Caption = 'Microprocesador'
      end
      object Modem1: TMenuItem
        Caption = 'Modem'
      end
      object Monitor1: TMenuItem
        Caption = 'Monitor'
      end
      object MotherBoard1: TMenuItem
        Caption = 'Mother Board'
      end
      object RAM1: TMenuItem
        Caption = 'RAM'
      end
      object Raton1: TMenuItem
        Caption = 'Raton'
      end
      object eclado1: TMenuItem
        Caption = 'Teclado'
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Cortar1: TMenuItem
      Caption = 'C&ortar'
    end
    object Copiar1: TMenuItem
      Caption = '&Copiar'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Eliminar1: TMenuItem
      Caption = 'E&liminar'
    end
    object CambiarNombre1: TMenuItem
      Caption = 'Camb&iar Nombre'
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Propiedades1: TMenuItem
      Caption = 'P&ropiedades'
    end
  end
end

object FrmUsrCloudDllDemo: TFrmUsrCloudDllDemo
  Left = 0
  Top = 0
  Caption = 'UsrCloud.dll Demo'
  ClientHeight = 711
  ClientWidth = 1109
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 521
    Top = 0
    Width = 588
    Height = 711
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object RichEdit1: TRichEdit
      Left = 1
      Top = 55
      Width = 586
      Height = 655
      Align = alClient
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        #20351#29992#27969#31243': '
        ''
        '    '#19968#12289#20934#22791
        '        1'#12289#21021#22987#21270' : '#21019#24314#23454#20363
        '        2'#12289#27880#20876#22238#35843#20989#25968' '
        '        2'#12289#36830#25509
        ''
        '    '#20108#12289#36890#35759
        '        '#35746#38405' : '#21578#35785#26381#21153#22120', '#24819#25509#25910#21738#20123#35774#22791#30340#25968#25454
        '        '#25512#36865' : '#21521#35774#22791#21457#36865#25968#25454
        ''
        '    '#19977#12289#32467#26463
        '        '#26029#24320#36830#25509
        '        '#37322#25918#36164#28304
        ''
        #26356#22810#20351#29992#35828#26126', '#21442#35265' http://cloud.usr.cn/sdk/dll/'
        #22914#38656#24110#21161', '#35831#25552#20132#24037#21333' http://h.usr.cn/create/number/cloud-usr-cn'
        ''
        '-----------------------------'
        '')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      Zoom = 100
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 586
      Height = 54
      Align = alTop
      TabOrder = 0
      DesignSize = (
        586
        54)
      object Label5: TLabel
        Left = 408
        Top = 20
        Width = 72
        Height = 13
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #32508#21512#35828#26126#25991#26723
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label5Click
        ExplicitLeft = 311
      end
      object Label6: TLabel
        Left = 505
        Top = 20
        Width = 48
        Height = 13
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #25509#21475#25991#26723
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label6Click
        ExplicitLeft = 408
      end
      object Label1: TLabel
        Left = 296
        Top = 20
        Width = 72
        Height = 13
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #36879#20256#20113#25511#21046#21488
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label1Click
        ExplicitLeft = 253
      end
      object CheckBox1: TCheckBox
        Left = 12
        Top = 17
        Width = 97
        Height = 22
        Caption = #33258#21160#28378#21160
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object Button1: TButton
        Left = 98
        Top = 11
        Width = 107
        Height = 34
        Caption = #28165#31354
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 711
    Align = alLeft
    TabOrder = 0
    object grpInit_Release: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 513
      Height = 96
      Align = alTop
      Caption = #9733' '#21021#22987#21270
      TabOrder = 0
      object Label4: TLabel
        Left = 33
        Top = 43
        Width = 22
        Height = 13
        Caption = 'Host'
      end
      object LabeledEdit_SvrPort: TLabeledEdit
        Left = 61
        Top = 67
        Width = 130
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = #31471#21475
        LabelPosition = lpLeft
        TabOrder = 4
        Text = '1883'
      end
      object btnVer: TButton
        Left = 196
        Top = 5
        Width = 286
        Height = 28
        Caption = #26597#30475'DLL'#29256#26412
        TabOrder = 0
        OnClick = btnVerClick
      end
      object btnInit: TButton
        Left = 197
        Top = 39
        Width = 130
        Height = 49
        Caption = 'USR_Init '#21021#22987#21270
        TabOrder = 1
        OnClick = btnInitClick
      end
      object btnRelease: TButton
        Left = 352
        Top = 39
        Width = 130
        Height = 49
        Caption = 'USR_Release '#37322#25918
        TabOrder = 2
        OnClick = btnReleaseClick
      end
      object cbbHost: TComboBox
        Left = 61
        Top = 40
        Width = 130
        Height = 21
        ItemIndex = 0
        TabOrder = 3
        Text = 'clouddata.usr.cn'
        OnChange = cbbHostChange
        Items.Strings = (
          'clouddata.usr.cn'
          '127.0.0.1'
          '192.168.0.26')
      end
    end
    object grpConn: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 106
      Width = 513
      Height = 74
      Align = alTop
      Caption = #9733' '#36830#25509#21644#26029#24320
      TabOrder = 1
      object LabeledEdit_UserName: TLabeledEdit
        Left = 61
        Top = 18
        Width = 130
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = #29992#25143#21517
        LabelPosition = lpLeft
        TabOrder = 0
        Text = 'sdktest'
      end
      object LabeledEdit_password: TLabeledEdit
        Left = 61
        Top = 45
        Width = 130
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = #23494#30721
        LabelPosition = lpLeft
        TabOrder = 3
        Text = 'sdktest'
      end
      object btnConn: TButton
        Left = 196
        Top = 18
        Width = 130
        Height = 49
        Caption = 'USR_Connect '#36830#25509' '
        TabOrder = 1
        OnClick = btnConnClick
      end
      object btnDisConn: TButton
        Left = 352
        Top = 18
        Width = 130
        Height = 49
        Caption = 'USR_DisConnect '#26029#24320
        TabOrder = 2
        OnClick = btnDisConnClick
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 183
      Width = 519
      Height = 527
      ActivePage = TabSheetParsed
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MultiLine = True
      ParentFont = False
      TabHeight = 40
      TabOrder = 2
      TabWidth = 240
      object TabSheetParsed: TTabSheet
        Caption = '|------------------   '#20113#32452#24577'   ------------------|'
        ImageIndex = 1
        object grpSubParsed: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 505
          Height = 233
          Align = alTop
          Caption = #9733' '#35746#38405
          TabOrder = 0
          object LabeledEdit_SubDevParsed: TLabeledEdit
            Left = 192
            Top = 15
            Width = 286
            Height = 21
            EditLabel.Width = 167
            EditLabel.Height = 13
            EditLabel.Caption = #35774#22791'ID'#65288#22810#20010#29992#33521#25991#36887#21495#38548#24320#65289
            LabelPosition = lpLeft
            TabOrder = 0
            Text = '00007867000000000001'
          end
          object btnSubscribeDevParsed: TButton
            Left = 57
            Top = 42
            Width = 421
            Height = 34
            Caption = 'USR_SubscribeDevParsed    '#35746#38405#35774#22791#35299#26512#21518#30340#25968#25454
            TabOrder = 1
            OnClick = btnSubscribeDevParsedClick
          end
          object btnUnSubscribeDevParsed: TButton
            Left = 57
            Top = 82
            Width = 421
            Height = 34
            Caption = 'USR_UnSubscribeDevParsed    '#21462#28040#35746#38405#35774#22791#35299#26512#21518#30340#25968#25454
            TabOrder = 2
            OnClick = btnUnSubscribeDevParsedClick
          end
          object LabeledEdit_SubUserParsed: TLabeledEdit
            Left = 192
            Top = 125
            Width = 286
            Height = 21
            EditLabel.Width = 168
            EditLabel.Height = 13
            EditLabel.Caption = #29992#25143#21517#65288#22810#20010#29992#33521#25991#36887#21495#38548#24320#65289
            LabelPosition = lpLeft
            TabOrder = 3
            Text = 'sdktest'
          end
          object btnSubscribeUserParsed: TButton
            Left = 57
            Top = 153
            Width = 421
            Height = 34
            Caption = 'USR_SubscribeUserParsed    '#35746#38405#36134#25143#19979#25152#26377#35774#22791#30340#35299#26512#21518#30340#25968#25454
            TabOrder = 4
            OnClick = btnSubscribeUserParsedClick
          end
          object btnUnSubscribeUserParsed: TButton
            Left = 57
            Top = 193
            Width = 421
            Height = 34
            Caption = 'USR_UnSubscribeUserParsed    '#21462#28040#35746#38405#36134#25143#19979#25152#26377#35774#22791#30340#35299#26512#21518#30340#25968#25454
            TabOrder = 5
            OnClick = btnUnSubscribeUserParsedClick
          end
        end
        object grpPubParsed: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 242
          Width = 505
          Height = 232
          Align = alClient
          Caption = #9733' '#25512#36865
          TabOrder = 1
          object lblPubParsedValueQ: TLabel
            Left = 128
            Top = 127
            Width = 60
            Height = 13
            Caption = #26597#35810#21040#30340#20540
          end
          object btnPublishParsedSetDataPoint: TButton
            Left = 57
            Top = 187
            Width = 421
            Height = 34
            Caption = 'USR_PublishParsedSetDataPoint  '#35774#32622#21333#21488#35774#22791#25968#25454#28857#20540
            TabOrder = 1
            OnClick = btnPublishParsedSetDataPointClick
          end
          object btnPublishParsedQueryDataPoint: TButton
            Left = 57
            Top = 78
            Width = 421
            Height = 34
            Caption = 'USR_PublishParsedQueryDataPoint  '#26597#35810#21333#21488#35774#22791#25968#25454#28857#20540
            TabOrder = 0
            OnClick = btnPublishParsedQueryDataPointClick
          end
          object LabeledEdit_PubParsedDev: TLabeledEdit
            Left = 192
            Top = 14
            Width = 286
            Height = 21
            EditLabel.Width = 35
            EditLabel.Height = 13
            EditLabel.Caption = #35774#22791'ID'
            LabelPosition = lpLeft
            TabOrder = 2
            Text = '00007867000000000001'
          end
          object LabeledEdit_PubParsedPoint: TLabeledEdit
            Left = 192
            Top = 46
            Width = 286
            Height = 21
            EditLabel.Width = 47
            EditLabel.Height = 13
            EditLabel.Caption = #25968#25454#28857'ID'
            LabelPosition = lpLeft
            TabOrder = 3
            Text = '432'
          end
          object LabeledEdit_PubParsedValueQ: TLabeledEdit
            Left = 192
            Top = 123
            Width = 286
            Height = 21
            Cursor = crNo
            TabStop = False
            EditLabel.Width = 3
            EditLabel.Height = 13
            EditLabel.Caption = ' '
            Enabled = False
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 4
          end
          object LabeledEdit_PubParsedValueS: TLabeledEdit
            Left = 192
            Top = 155
            Width = 286
            Height = 21
            EditLabel.Width = 60
            EditLabel.Height = 13
            EditLabel.Caption = #35201#35774#32622#30340#20540
            LabelPosition = lpLeft
            TabOrder = 5
            Text = '1234'
          end
        end
      end
      object TabSheetRaw: TTabSheet
        Caption = '|------------------   '#20113#20132#25442#26426'  ------------------|'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object grpSubRaw: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 505
          Height = 233
          Align = alTop
          Caption = #9733' '#35746#38405
          TabOrder = 0
          object LabeledEdit_SubDevRaw: TLabeledEdit
            Left = 192
            Top = 15
            Width = 286
            Height = 21
            EditLabel.Width = 167
            EditLabel.Height = 13
            EditLabel.Caption = #35774#22791'ID'#65288#22810#20010#29992#33521#25991#36887#21495#38548#24320#65289
            LabelPosition = lpLeft
            TabOrder = 0
            Text = '00007867000000000001'
          end
          object btnSubscribeDevRaw: TButton
            Left = 57
            Top = 42
            Width = 421
            Height = 34
            Caption = 'USR_SubscribeDevRaw    '#35746#38405#35774#22791#21407#22987#25968#25454#27969
            TabOrder = 1
            OnClick = btnSubscribeDevRawClick
          end
          object btnUnSubscribeDevRaw: TButton
            Left = 57
            Top = 82
            Width = 421
            Height = 34
            Caption = 'USR_UnSubscribeDevRaw    '#21462#28040#35746#38405#35774#22791#21407#22987#25968#25454#27969
            TabOrder = 2
            OnClick = btnUnSubscribeDevRawClick
          end
          object LabeledEdit_SubUserRaw: TLabeledEdit
            Left = 192
            Top = 125
            Width = 286
            Height = 21
            EditLabel.Width = 168
            EditLabel.Height = 13
            EditLabel.Caption = #29992#25143#21517#65288#22810#20010#29992#33521#25991#36887#21495#38548#24320#65289
            LabelPosition = lpLeft
            TabOrder = 3
            Text = 'sdktest'
          end
          object btnSubscribeUserRaw: TButton
            Left = 57
            Top = 153
            Width = 421
            Height = 34
            Caption = 'USR_SubscribeUserRaw    '#35746#38405#36134#25143#19979#25152#26377#35774#22791#30340#21407#22987#25968#25454#27969
            TabOrder = 4
            OnClick = btnSubscribeUserRawClick
          end
          object btnUnSubscribeUserRaw: TButton
            Left = 57
            Top = 193
            Width = 421
            Height = 34
            Caption = 'USR_UnSubscribeUserRaw    '#21462#28040#35746#38405#36134#25143#19979#25152#26377#35774#22791#30340#21407#22987#25968#25454#27969
            TabOrder = 5
            OnClick = btnUnSubscribeUserRawClick
          end
        end
        object grpPubRaw: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 242
          Width = 505
          Height = 232
          Align = alClient
          Caption = #9733' '#25512#36865
          TabOrder = 1
          object lblPubData: TLabel
            Left = 126
            Top = 14
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = #25512#36865#30340#25968#25454
          end
          object LabeledEdit_PubDevId: TLabeledEdit
            Left = 192
            Top = 94
            Width = 286
            Height = 21
            EditLabel.Width = 130
            EditLabel.Height = 13
            EditLabel.Caption = #35774#22791'ID'#65288#21482#33021#22635#19968#20010'ID'#65289
            LabelPosition = lpLeft
            TabOrder = 2
            Text = '00007867000000000001'
          end
          object RichEdit_PubData: TRichEdit
            Left = 192
            Top = 14
            Width = 286
            Height = 75
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Lines.Strings = (
              '01 03 00 63 00 03 F5 D5 ')
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            Zoom = 100
          end
          object btnPublishRawToDev: TButton
            Left = 57
            Top = 121
            Width = 421
            Height = 34
            Caption = 'USR_PublishRawToDev  '#21521#21333#21488#35774#22791#25512#36865#21407#22987#25968#25454#27969
            TabOrder = 3
            OnClick = btnPublishRawToDevClick
          end
          object CheckBox_Hex: TCheckBox
            Left = 438
            Top = 69
            Width = 36
            Height = 17
            Caption = 'HEX'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object btnPublishRawToUser: TButton
            Left = 57
            Top = 187
            Width = 421
            Height = 34
            Caption = 'USR_PublishRawToUser  '#21521#36134#25143#19979#25152#26377#35774#22791#25512#36865#21407#22987#25968#25454#27969
            TabOrder = 5
            OnClick = btnPublishRawToUserClick
          end
          object LabeledEdit_PubUser: TLabeledEdit
            Left = 192
            Top = 160
            Width = 286
            Height = 21
            EditLabel.Width = 120
            EditLabel.Height = 13
            EditLabel.Caption = #29992#25143#21517#65288#21482#33021#22635#19968#20010#65289
            LabelPosition = lpLeft
            TabOrder = 4
            Text = 'sdktest'
          end
        end
      end
    end
  end
end

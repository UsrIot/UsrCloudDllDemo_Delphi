unit uFrmUsrCloudDllDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, uUsrCloud, Winapi.ShellAPI, System.JSON;

type
  TFrmUsrCloudDllDemo = class(TForm)
    Panel1: TPanel;
    grpInit_Release: TGroupBox;
    btnVer: TButton;
    btnInit: TButton;
    btnRelease: TButton;
    grpConn: TGroupBox;
    LabeledEdit_UserName: TLabeledEdit;
    LabeledEdit_password: TLabeledEdit;
    btnConn: TButton;
    btnDisConn: TButton;
    Panel2: TPanel;
    RichEdit1: TRichEdit;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheetRaw: TTabSheet;
    TabSheetParsed: TTabSheet;
    grpSubRaw: TGroupBox;
    LabeledEdit_SubDevRaw: TLabeledEdit;
    btnSubscribeDevRaw: TButton;
    btnUnSubscribeDevRaw: TButton;
    grpPubRaw: TGroupBox;
    LabeledEdit_PubDevId: TLabeledEdit;
    RichEdit_PubData: TRichEdit;
    btnPublishRawToDev: TButton;
    CheckBox_Hex: TCheckBox;
    LabeledEdit_SubUserRaw: TLabeledEdit;
    btnSubscribeUserRaw: TButton;
    btnUnSubscribeUserRaw: TButton;
    btnPublishRawToUser: TButton;
    LabeledEdit_PubUser: TLabeledEdit;
    grpSubParsed: TGroupBox;
    LabeledEdit_SubDevParsed: TLabeledEdit;
    btnSubscribeDevParsed: TButton;
    btnUnSubscribeDevParsed: TButton;
    LabeledEdit_SubUserParsed: TLabeledEdit;
    btnSubscribeUserParsed: TButton;
    btnUnSubscribeUserParsed: TButton;
    grpPubParsed: TGroupBox;
    btnPublishParsedSetDataPoint: TButton;
    btnPublishParsedQueryDataPoint: TButton;
    LabeledEdit_PubParsedDev: TLabeledEdit;
    LabeledEdit_PubParsedPoint: TLabeledEdit;
    LabeledEdit_PubParsedValueQ: TLabeledEdit;
    LabeledEdit_PubParsedValueS: TLabeledEdit;
    lblPubData: TLabel;
    lblPubParsedValueQ: TLabel;
    Label1: TLabel;
    LabeledEdit_PubParsedSlaveIndex: TLabeledEdit;
    procedure btnVerClick(Sender: TObject);
    procedure btnConnClick(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure btnDisConnClick(Sender: TObject);
    procedure btnSubscribeDevRawClick(Sender: TObject);
    procedure btnUnSubscribeDevRawClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure btnReleaseClick(Sender: TObject);
    procedure btnPublishRawToDevClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure btnSubscribeUserRawClick(Sender: TObject);
    procedure btnUnSubscribeUserRawClick(Sender: TObject);
    procedure btnPublishRawToUserClick(Sender: TObject);
    procedure btnSubscribeDevParsedClick(Sender: TObject);
    procedure btnUnSubscribeDevParsedClick(Sender: TObject);
    procedure btnSubscribeUserParsedClick(Sender: TObject);
    procedure btnUnSubscribeUserParsedClick(Sender: TObject);
    procedure btnPublishParsedQueryDataPointClick(Sender: TObject);
    procedure btnPublishParsedSetDataPointClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    procedure Log(strMsg: string); overload;
    procedure Log(const AsFormat: string; const Args: array of const); overload;

  public

  end;

var
  FrmUsrCloudDllDemo: TFrmUsrCloudDllDemo;
  //

/// <summary>
///   ������Ӧ �ص�����
/// </summary>
procedure ConnAck_CBF(ReturnCode: LongInt; Description: PWideChar); stdcall;
/// <summary>
///   ������ʧ �ص�����
/// </summary>
procedure ConnLost_CBF(); stdcall;
/// <summary>
///   ������Ӧ �ص�����
/// </summary>
procedure PubAck_CBF(MessageID: LongInt); stdcall;
/// <summary>
///   ������Ӧ �ص�����
/// </summary>
procedure SubscribeAck_CBF(MessageID: LongInt;
  SubFunName, SubParam, ReturnCode: PWideChar); stdcall;
/// <summary>
///   ȡ��������Ӧ �ص�����
/// </summary>
procedure UnSubscribeAck_CBF(MessageID: LongInt;
  UnSubFunName, UnSubParam: PWideChar); stdcall;

{ �������ݻص����� }

/// <summary>
///   ���� ���ݵ�ֵ���� �ص�����������̬��
/// </summary>
procedure RcvParsedDataPointPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   ���� �豸���������� �ص�����������̬��
/// </summary>
procedure RcvParsedDevStatusPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   ���� �豸�������� �ص�����������̬��
/// </summary>
procedure RcvParsedDevAlarmPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   ���� ���ݵ����Ӧ�� �ص����� ������̬��
/// </summary>
procedure RcvParsedOptionResponseReturn_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   ���� �豸ԭʼ������ �ص����� ���ƽ�������
/// </summary>
procedure RcvRawFromDev_CBF(MessageID: LongInt; DevId: PWideChar; pData: PByte;
  DataLen: Integer); stdcall;

implementation

{$R *.dfm}

function Pbuf2HexStr(APbuf: PByteArray; AiCount: Integer;
  const AsSeg: string = ' '): string;
var
  i                 : Integer;
begin
  Result := '';
  for i := 0 to AiCount - 1 do
    Result := Result + IntToHex(APbuf^[i], 2) + AsSeg;
end;

function HexStr2Buf(AsHexStr: string): TBytes;
var
  i, viBufLen, viByte: Integer;
begin
  Result := nil;
  AsHexStr := StringReplace(AsHexStr, ' ', '', [rfReplaceAll]);
  AsHexStr := StringReplace(AsHexStr, #13, '', [rfReplaceAll]);
  AsHexStr := StringReplace(AsHexStr, #10, '', [rfReplaceAll]);
  viBufLen := Length(AsHexStr) div 2;
  if viBufLen = 0 then
    Exit;
  SetLength(Result, viBufLen);
  for i := 0 to viBufLen - 1 do
    if TryStrToInt('$' + Copy(AsHexStr, i * 2 + 1, 2), viByte) then
      Result[i] := Byte(viByte)
    else
      Exit(nil);
end;

// ����

procedure TFrmUsrCloudDllDemo.btnConnClick(Sender: TObject);
begin
  if USR_Connect(PWideChar(LabeledEdit_UserName.Text),
    PWideChar(LabeledEdit_password.Text)) then
  begin
    Log('�����ѷ���');
  end;
end;

// �Ͽ�

procedure TFrmUsrCloudDllDemo.btnDisConnClick(Sender: TObject);
begin
  if USR_DisConnect then
    Log('�ѶϿ�');
end;

// ����

//��ѯ���ݵ�ֵ������̬��

procedure TFrmUsrCloudDllDemo.btnPublishParsedQueryDataPointClick
  (Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_PublishParsedQuerySlaveDataPoint
    (PWideChar(LabeledEdit_PubParsedDev.Text),
    PWideChar(LabeledEdit_PubParsedSlaveIndex.Text),
    PWideChar(LabeledEdit_PubParsedPoint.Text));
  if viMsgId > -1 then
    Log('��Ϣ������ MsgId:' + IntToStr(viMsgId))
  else
    Log('��Ϣ����ʧ��');
end;

//�������ݵ�ֵ������̬��

procedure TFrmUsrCloudDllDemo.btnPublishParsedSetDataPointClick
  (Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_PublishParsedSetSlaveDataPoint
    (PWideChar(LabeledEdit_PubParsedDev.Text),
    PWideChar(LabeledEdit_PubParsedSlaveIndex.Text),
    PWideChar(LabeledEdit_PubParsedPoint.Text),
    PWideChar(LabeledEdit_PubParsedValueS.Text));
  if viMsgId > -1 then
    Log('��Ϣ������ MsgId:' + IntToStr(viMsgId))
  else
    Log('��Ϣ����ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnPublishRawToDevClick(Sender: TObject);
var
  viMsgId           : Integer;
  vsData            : string;
  vData             : TBytes;
begin
  vsData := RichEdit_PubData.Text;
  if CheckBox_Hex.Checked then
    vData := HexStr2Buf(vsData)
  else
    vData := TEncoding.UTF8.GetBytes(vsData);

  viMsgId := USR_PublishRawToDev(PWideChar(LabeledEdit_PubDevId.Text),
    @vData[0], Length(vData));
  if viMsgId > -1 then
    Log('��Ϣ������ MsgId:' + IntToStr(viMsgId))
  else
    Log('��Ϣ����ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnPublishRawToUserClick(Sender: TObject);
var
  viMsgId           : Integer;
  vsData            : string;
  vData             : TBytes;
begin
  vsData := RichEdit_PubData.Text;
  if CheckBox_Hex.Checked then
    vData := HexStr2Buf(vsData)
  else
    vData := TEncoding.UTF8.GetBytes(vsData);

  viMsgId := USR_PublishRawToUser(PWideChar(LabeledEdit_PubUser.Text),
    @vData[0], Length(vData));
  if viMsgId > -1 then
    Log('��Ϣ������ MsgId:' + IntToStr(viMsgId))
  else
    Log('��Ϣ����ʧ��');
end;

// �ͷ�

procedure TFrmUsrCloudDllDemo.btnReleaseClick(Sender: TObject);
begin
  if USR_Release then
    Log('���ͷ�');
end;

// ����

procedure TFrmUsrCloudDllDemo.btnSubscribeDevParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeDevParsed(PWideChar(LabeledEdit_SubDevParsed.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeDevParsed �����ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeDevParsed ���ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeDevRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeDevRaw(PWideChar(LabeledEdit_SubDevRaw.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeDevRaw �����ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeDevRaw ���ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeUserParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeUserParsed(PWideChar(LabeledEdit_SubUserParsed.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeUserParsed �����ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeUserParsed ���ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeUserRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeUserRaw(PWideChar(LabeledEdit_SubUserRaw.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeUserRaw �����ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeUserRaw ���ķ���ʧ��');
end;

// ȡ������

procedure TFrmUsrCloudDllDemo.btnUnSubscribeDevParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeDevParsed(PWideChar(LabeledEdit_SubDevParsed.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeDevParsed ȡ�������ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeDevParsed ȡ�����ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeDevRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeDevRaw(PWideChar(LabeledEdit_SubDevRaw.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeDevRaw ȡ�������ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeDevRaw ȡ�����ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeUserParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeUserParsed
    (PWideChar(LabeledEdit_SubUserParsed.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeUserParsed ȡ�������ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeUserParsed ȡ�����ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeUserRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeUserRaw(PWideChar(LabeledEdit_SubUserRaw.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeUserRaw ȡ�������ѷ��� MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeUserRaw ȡ�����ķ���ʧ��');
end;

procedure TFrmUsrCloudDllDemo.Button1Click(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TFrmUsrCloudDllDemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if USR_Release then
    Log('���ͷ�');
end;

// ��汾��

procedure TFrmUsrCloudDllDemo.btnVerClick(Sender: TObject);
begin
  Log('dll�汾��: ' + IntToStr(USR_GetVer));
end;

// ��ʼ��

procedure TFrmUsrCloudDllDemo.btnInitClick(Sender: TObject);
const
  csHost            = 'clouddata.usr.cn'; //͸���Ʒ�������ַ, ����������
  ciPort            = 1883;             //͸���Ʒ������˿�,����������
begin
  if USR_Init(PWideChar(csHost), ciPort, 2) then
  begin
    Log('��ʼ���ɹ�');

    { ע���¼� }
    // ����
    USR_OnConnAck(ConnAck_CBF);
    // ������ʧ
    USR_OnConnLost(ConnLost_CBF);
    // ����
    USR_OnSubscribeAck(SubscribeAck_CBF);
    // ȡ������
    USR_OnUnSubscribeAck(UnSubscribeAck_CBF);
    // ����
    USR_OnPubAck(PubAck_CBF);
    // ���� �豸ԭʼ������
    USR_OnRcvRawFromDev(RcvRawFromDev_CBF);
    // ���� ���ݵ�仯����
    USR_OnRcvParsedDataPointPush(RcvParsedDataPointPush_CBF);
    // ���� �豸����������
    USR_OnRcvParsedDevStatusPush(RcvParsedDevStatusPush_CBF);
    // ���� �豸��������
    USR_OnRcvParsedDevAlarmPush(RcvParsedDevAlarmPush_CBF);
    // ���� ���ݵ����Ӧ��
    USR_OnRcvParsedOptionResponseReturn(RcvParsedOptionResponseReturn_CBF)
  end;
end;

procedure TFrmUsrCloudDllDemo.Log(const AsFormat: string;
  const Args: array of const);
var
  vsMsg             : string;
begin
  vsMsg := Format(AsFormat, Args);
  Log(vsMsg);
end;

procedure TFrmUsrCloudDllDemo.Log(strMsg: string);
begin
  RichEdit1.Lines.Add('------' + FormatDateTime('hh:mm:ss', Now) + '------');
  RichEdit1.Lines.Add(strMsg);
  RichEdit1.Lines.Add('');
  if CheckBox1.Checked then
    PostMessage(RichEdit1.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

/// //////////////////////////////////////////////////////////////////////////////
// =============================================================================//
// �ص�����                                                                     //
// =============================================================================//
/// //////////////////////////////////////////////////////////////////////////////

// ���ӻص�����

procedure ConnAck_CBF(ReturnCode: Integer; Description: PWideChar);
var
  vS                : string;
begin
  vS := Description + #13#10;
  case ReturnCode of
    $00:
      begin
        vS := vS + '���ӳɹ�';
      end;
  else
    vS := vS + '����ʧ��';
  end;
  FrmUsrCloudDllDemo.Log('�������¼���' + #13#10 + ' ReturnCode:' +
    IntToStr(ReturnCode) + ' ;' + vS);
end;

// ������ʧ �ص�����

procedure ConnLost_CBF(); stdcall;
begin
  FrmUsrCloudDllDemo.Log('��������ʧ�¼���' + #13#10 +
    '�쳣�Ͽ�, ���������Ӳ����¶���');
end;

// ���Ļص�����

procedure SubscribeAck_CBF(MessageID: LongInt;
  SubFunName, SubParam, ReturnCode: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('�������¼���'#13#10 + 'MessageID:%d'#13#10 +
    '��������:%s'#13#10
    + '�豸ID(���û���):%s'#13#10 + '����ֱ���:%s',
    [MessageID, WideCharToString(SubFunName), WideCharToString(SubParam),
    WideCharToString(ReturnCode)]);
end;

// ȡ�����Ļص�����

procedure UnSubscribeAck_CBF(MessageID: LongInt;
  UnSubFunName, UnSubParam: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('��ȡ�������¼���'#13#10 + 'MessageID:%d'#13#10 +
    '��������:%s'#13#10 + '�豸ID(���û���):%s',
    [MessageID, WideCharToString(UnSubFunName),
    WideCharToString(UnSubParam)]);
end;

// ���ͻص�����

procedure PubAck_CBF(MessageID: Integer);
begin
  FrmUsrCloudDllDemo.Log('�������¼���' + #13#10 + 'MessageID: ' +
    IntToStr(MessageID));
end;

{ ���������¼� }

(* �����豸ԭʼ������
  ���� : $USR/Dev2App/<UserName>/<DevId> �� $USR/DevTx/<DevId>
*)

procedure RcvRawFromDev_CBF(MessageID: LongInt; DevId: PWideChar; pData:
  PByte;
  DataLen: Integer);
var
  vsHexData         : string;
begin
  vsHexData := Pbuf2HexStr(PByteArray(pData), DataLen);
  FrmUsrCloudDllDemo.Log('�������������¼���' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '�豸ID:%s' + Chr(13) + Chr(10) + '����(HEX):%s',
    [MessageID, WideCharToString(DevId), vsHexData]);
end;

(* ���� ���ݵ�仯����
  ���� : $USR/DevJsonTx/<DevId>
*)

procedure RcvParsedDataPointPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
var
  vJo               : TJSONObject;
  vJv, vJv2         : TJSONValue;
  vJa               : TJSONArray;
  i                 : Integer;
  vsPoindId, vsSlaveIndex, vsValue: UTF8String;
const
  csDataPoints      : string = 'dataPoints';
  csSlaveIndex      : string = 'slaveIndex';
  csPoindId         : string = 'pointId';
  csValue           : string = 'value';
begin
  FrmUsrCloudDllDemo.Log(
    '�����ݵ�ֵ�����¼���' + Chr(13) + Chr(10) +
    'MessageID:%d' + Chr(13) + Chr(10) +
    '�豸ID:%s' + Chr(13) + Chr(10)
    + 'JSON����:%s',
    [MessageID,
    WideCharToString(DevId),
      WideCharToString(JsonStr)]);

  vJo := TJSONObject.ParseJSONValue(WideCharToString(JsonStr)) as TJSONObject;
  if Assigned(vJo) then
  begin
    vJv := vJo.Values[csDataPoints];
    if vJv.ClassType = TJSONArray then
    begin
      vJa := vJv as TJSONArray;
      if vJa.Count > 0 then
        for i := 0 to vJa.Count - 1 do
        begin
          vJv2 := vJa.Items[i];
          if (vJv2.ClassType = TJSONObject) and
            vJv2.TryGetValue(csSlaveIndex, vsSlaveIndex) and
            vJv2.TryGetValue(csPoindId, vsPoindId) and
            vJv2.TryGetValue(csValue, vsValue) then
          begin
            FrmUsrCloudDllDemo.Log(
              '�����ݵ�ֵ�����¼�:���ݽ������ӻ����:%s, ���ݵ�:%s, ֵ:%s',
              [vsSlaveIndex, vsPoindId, vsValue]);
          end;

          with FrmUsrCloudDllDemo do
            if (WideCharToString(DevId) = LabeledEdit_PubParsedDev.Text)
              and
              (vsSlaveIndex = UTF8Encode(LabeledEdit_PubParsedSlaveIndex.Text))
              and
              (vsPoindId = UTF8Encode(LabeledEdit_PubParsedPoint.Text)) then
              LabeledEdit_PubParsedValueQ.Text := UTF8ToString(vsValue);
        end;
    end;
    vJo.Free;
  end;
end;

(* ���� �豸����������
  ����: $USR/JsonTx/<�ʺ�>/<devId>
*)

procedure RcvParsedDevStatusPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('���豸�����������¼���' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '�豸ID:%s' + Chr(13) + Chr(10) + 'JSON����:%s',
    [MessageID, WideCharToString(DevId), WideCharToString(JsonStr)]);
end;

(* ���� �豸��������
  ���� : $USR/JsonTx/<�ʺ�>/+
*)

procedure RcvParsedDevAlarmPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('���豸���������¼���' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '�豸ID:%s' + Chr(13) + Chr(10) + 'JSON����:%s',
    [MessageID, WideCharToString(DevId), WideCharToString(JsonStr)]);
end;

procedure RcvParsedOptionResponseReturn_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('�� ���ݵ����Ӧ�������¼���' + Chr(13) + Chr(10) + 'MessageID:%d'
    + Chr(13) + Chr(10) + '�豸ID:%s' + Chr(13) + Chr(10) + 'JSON����:%s',
    [MessageID, WideCharToString(DevId), WideCharToString(JsonStr)]);
end;

procedure TFrmUsrCloudDllDemo.Label1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://console.usr.cn/', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TFrmUsrCloudDllDemo.Label5Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil,
    'http://cloud.usr.cn/development_instruction.html', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TFrmUsrCloudDllDemo.Label6Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://cloud.usr.cn/sdk/dll/', nil,
    nil, SW_SHOWNORMAL);
end;

end.


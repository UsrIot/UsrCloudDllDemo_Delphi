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
///   连接响应 回调函数
/// </summary>
procedure ConnAck_CBF(ReturnCode: LongInt; Description: PWideChar); stdcall;
/// <summary>
///   连接遗失 回调函数
/// </summary>
procedure ConnLost_CBF(); stdcall;
/// <summary>
///   推送响应 回调函数
/// </summary>
procedure PubAck_CBF(MessageID: LongInt); stdcall;
/// <summary>
///   订阅响应 回调函数
/// </summary>
procedure SubscribeAck_CBF(MessageID: LongInt;
  SubFunName, SubParam, ReturnCode: PWideChar); stdcall;
/// <summary>
///   取消订阅响应 回调函数
/// </summary>
procedure UnSubscribeAck_CBF(MessageID: LongInt;
  UnSubFunName, UnSubParam: PWideChar); stdcall;

{ 接收数据回调函数 }

/// <summary>
///   接收 数据点值推送 回调函数【云组态】
/// </summary>
procedure RcvParsedDataPointPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   接收 设备上下线推送 回调函数【云组态】
/// </summary>
procedure RcvParsedDevStatusPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   接收 设备报警推送 回调函数【云组态】
/// </summary>
procedure RcvParsedDevAlarmPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   接收 数据点操作应答 回调函数 【云组态】
/// </summary>
procedure RcvParsedOptionResponseReturn_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar); stdcall;

/// <summary>
///   接收 设备原始数据流 回调函数 【云交换机】
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

// 连接

procedure TFrmUsrCloudDllDemo.btnConnClick(Sender: TObject);
begin
  if USR_Connect(PWideChar(LabeledEdit_UserName.Text),
    PWideChar(LabeledEdit_password.Text)) then
  begin
    Log('连接已发起');
  end;
end;

// 断开

procedure TFrmUsrCloudDllDemo.btnDisConnClick(Sender: TObject);
begin
  if USR_DisConnect then
    Log('已断开');
end;

// 推送

//查询数据点值【云组态】

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
    Log('消息已推送 MsgId:' + IntToStr(viMsgId))
  else
    Log('消息推送失败');
end;

//设置数据点值【云组态】

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
    Log('消息已推送 MsgId:' + IntToStr(viMsgId))
  else
    Log('消息推送失败');
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
    Log('消息已推送 MsgId:' + IntToStr(viMsgId))
  else
    Log('消息推送失败');
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
    Log('消息已推送 MsgId:' + IntToStr(viMsgId))
  else
    Log('消息推送失败');
end;

// 释放

procedure TFrmUsrCloudDllDemo.btnReleaseClick(Sender: TObject);
begin
  if USR_Release then
    Log('已释放');
end;

// 订阅

procedure TFrmUsrCloudDllDemo.btnSubscribeDevParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeDevParsed(PWideChar(LabeledEdit_SubDevParsed.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeDevParsed 订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeDevParsed 订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeDevRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeDevRaw(PWideChar(LabeledEdit_SubDevRaw.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeDevRaw 订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeDevRaw 订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeUserParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeUserParsed(PWideChar(LabeledEdit_SubUserParsed.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeUserParsed 订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeUserParsed 订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnSubscribeUserRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_SubscribeUserRaw(PWideChar(LabeledEdit_SubUserRaw.Text));
  if viMsgId > -1 then
    Log('USR_SubscribeUserRaw 订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_SubscribeUserRaw 订阅发起失败');
end;

// 取消订阅

procedure TFrmUsrCloudDllDemo.btnUnSubscribeDevParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeDevParsed(PWideChar(LabeledEdit_SubDevParsed.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeDevParsed 取消订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeDevParsed 取消订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeDevRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeDevRaw(PWideChar(LabeledEdit_SubDevRaw.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeDevRaw 取消订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeDevRaw 取消订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeUserParsedClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeUserParsed
    (PWideChar(LabeledEdit_SubUserParsed.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeUserParsed 取消订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeUserParsed 取消订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.btnUnSubscribeUserRawClick(Sender: TObject);
var
  viMsgId           : Integer;
begin
  viMsgId := USR_UnSubscribeUserRaw(PWideChar(LabeledEdit_SubUserRaw.Text));
  if viMsgId > -1 then
    Log('USR_UnSubscribeUserRaw 取消订阅已发起 MsgId:%d', [viMsgId])
  else
    Log('USR_UnSubscribeUserRaw 取消订阅发起失败');
end;

procedure TFrmUsrCloudDllDemo.Button1Click(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TFrmUsrCloudDllDemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if USR_Release then
    Log('已释放');
end;

// 查版本号

procedure TFrmUsrCloudDllDemo.btnVerClick(Sender: TObject);
begin
  Log('dll版本号: ' + IntToStr(USR_GetVer));
end;

// 初始化

procedure TFrmUsrCloudDllDemo.btnInitClick(Sender: TObject);
const
  csHost            = 'clouddata.usr.cn'; //透传云服务器地址, 打死都不变
  ciPort            = 1883;             //透传云服务器端口,打死都不变
begin
  if USR_Init(PWideChar(csHost), ciPort, 2) then
  begin
    Log('初始化成功');

    { 注册事件 }
    // 连接
    USR_OnConnAck(ConnAck_CBF);
    // 连接遗失
    USR_OnConnLost(ConnLost_CBF);
    // 订阅
    USR_OnSubscribeAck(SubscribeAck_CBF);
    // 取消订阅
    USR_OnUnSubscribeAck(UnSubscribeAck_CBF);
    // 推送
    USR_OnPubAck(PubAck_CBF);
    // 接收 设备原始数据流
    USR_OnRcvRawFromDev(RcvRawFromDev_CBF);
    // 接收 数据点变化推送
    USR_OnRcvParsedDataPointPush(RcvParsedDataPointPush_CBF);
    // 接收 设备上下线推送
    USR_OnRcvParsedDevStatusPush(RcvParsedDevStatusPush_CBF);
    // 接收 设备报警推送
    USR_OnRcvParsedDevAlarmPush(RcvParsedDevAlarmPush_CBF);
    // 接收 数据点操作应答
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
// 回调函数                                                                     //
// =============================================================================//
/// //////////////////////////////////////////////////////////////////////////////

// 连接回调函数

procedure ConnAck_CBF(ReturnCode: Integer; Description: PWideChar);
var
  vS                : string;
begin
  vS := Description + #13#10;
  case ReturnCode of
    $00:
      begin
        vS := vS + '连接成功';
      end;
  else
    vS := vS + '连接失败';
  end;
  FrmUsrCloudDllDemo.Log('【连接事件】' + #13#10 + ' ReturnCode:' +
    IntToStr(ReturnCode) + ' ;' + vS);
end;

// 连接遗失 回调函数

procedure ConnLost_CBF(); stdcall;
begin
  FrmUsrCloudDllDemo.Log('【连接遗失事件】' + #13#10 +
    '异常断开, 请重新连接并重新订阅');
end;

// 订阅回调函数

procedure SubscribeAck_CBF(MessageID: LongInt;
  SubFunName, SubParam, ReturnCode: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('【订阅事件】'#13#10 + 'MessageID:%d'#13#10 +
    '函数名称:%s'#13#10
    + '设备ID(或用户名):%s'#13#10 + '结果分别是:%s',
    [MessageID, WideCharToString(SubFunName), WideCharToString(SubParam),
    WideCharToString(ReturnCode)]);
end;

// 取消订阅回调函数

procedure UnSubscribeAck_CBF(MessageID: LongInt;
  UnSubFunName, UnSubParam: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('【取消订阅事件】'#13#10 + 'MessageID:%d'#13#10 +
    '函数名称:%s'#13#10 + '设备ID(或用户名):%s',
    [MessageID, WideCharToString(UnSubFunName),
    WideCharToString(UnSubParam)]);
end;

// 推送回调函数

procedure PubAck_CBF(MessageID: Integer);
begin
  FrmUsrCloudDllDemo.Log('【推送事件】' + #13#10 + 'MessageID: ' +
    IntToStr(MessageID));
end;

{ 接收数据事件 }

(* 接收设备原始数据流
  主题 : $USR/Dev2App/<UserName>/<DevId> 或 $USR/DevTx/<DevId>
*)

procedure RcvRawFromDev_CBF(MessageID: LongInt; DevId: PWideChar; pData:
  PByte;
  DataLen: Integer);
var
  vsHexData         : string;
begin
  vsHexData := Pbuf2HexStr(PByteArray(pData), DataLen);
  FrmUsrCloudDllDemo.Log('【接收数据流事件】' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '设备ID:%s' + Chr(13) + Chr(10) + '内容(HEX):%s',
    [MessageID, WideCharToString(DevId), vsHexData]);
end;

(* 接收 数据点变化推送
  主题 : $USR/DevJsonTx/<DevId>
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
    '【数据点值推送事件】' + Chr(13) + Chr(10) +
    'MessageID:%d' + Chr(13) + Chr(10) +
    '设备ID:%s' + Chr(13) + Chr(10)
    + 'JSON数据:%s',
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
              '【数据点值推送事件:数据解析】从机序号:%s, 数据点:%s, 值:%s',
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

(* 接收 设备上下线推送
  主题: $USR/JsonTx/<帐号>/<devId>
*)

procedure RcvParsedDevStatusPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('【设备上下线推送事件】' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '设备ID:%s' + Chr(13) + Chr(10) + 'JSON数据:%s',
    [MessageID, WideCharToString(DevId), WideCharToString(JsonStr)]);
end;

(* 接收 设备报警推送
  主题 : $USR/JsonTx/<帐号>/+
*)

procedure RcvParsedDevAlarmPush_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('【设备报警推送事件】' + Chr(13) + Chr(10) + 'MessageID:%d' +
    Chr(13) + Chr(10) + '设备ID:%s' + Chr(13) + Chr(10) + 'JSON数据:%s',
    [MessageID, WideCharToString(DevId), WideCharToString(JsonStr)]);
end;

procedure RcvParsedOptionResponseReturn_CBF(MessageID: LongInt;
  DevId, JsonStr: PWideChar);
begin
  FrmUsrCloudDllDemo.Log('【 数据点操作应答推送事件】' + Chr(13) + Chr(10) + 'MessageID:%d'
    + Chr(13) + Chr(10) + '设备ID:%s' + Chr(13) + Chr(10) + 'JSON数据:%s',
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


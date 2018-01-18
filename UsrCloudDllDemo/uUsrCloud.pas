unit uUsrCloud;

interface

const
  csUsrCloudDll     = 'UsrCloud.dll';

type
  // ------------------------------------------------------------------------------
  // 回调函数声明
  // ------------------------------------------------------------------------------

  /// <summary>
  /// 连接响应 事件
  /// </summary>
  /// <remarks>
  /// 执行USR_Connect连接服务器,会触发本事件
  /// ReturnCode 返回码:
  /// <para>0x01	连接已拒绝，不支持的协议版本     </para>
  /// <para>0x02	连接已拒绝，不合格的客户端标识符 </para>
  /// <para>0x03	连接已拒绝，服务端不可用         </para>
  /// <para>0x04	连接已拒绝，无效的用户名或密码   </para>
  /// <para>0x05	连接已拒绝，未授权               </para>
  /// </remarks>

  TUSR_ConnAckEvent = procedure(ReturnCode: LongInt; Description: PWideChar);
  stdcall;

  /// <summary>
  /// 推送响应 事件
  /// </summary>
  /// <remarks>
  /// 执行USR_PublishXXX推送消息,会触发本事件
  /// </remarks>
  TUSR_PubAckEvent = procedure(MessageID: LongInt); stdcall;

  /// <summary>
  /// 订阅响应 事件
  /// </summary>
  /// <remarks>
  /// 执行USR_SubscribeXXX订阅消息,会触发本事件
  /// SubFunName 函数名称
  /// <para>用于判断用户执行的哪个订阅函数, 得到了服务器的回应</para>
  /// SubParam 订阅参数
  /// <para>跟执行的订阅函数有关:</para>
  /// <para>  如果订阅的是"单个设备的消息", 则SubParam为设备ID</para>
  /// <para>  如果订阅的是"用户所有设备的消息", 则SubParam为用户名</para>
  /// ReturnCode 返回码
  /// <para>0, 1, 2 : 订阅成功</para>
  /// <para>128 : 订阅失败</para>
  /// </remarks>
  TUSR_SubscribeAckEvent = procedure(MessageID: LongInt; SubFunName, SubParam,
    ReturnCode: PWideChar); stdcall;

  /// <summary>
  /// 取消订阅响应 事件
  /// </summary>
  /// <remarks>
  /// <para>执行USR_UnSubscribeXXX取消订阅消息,会触发本事件</para>
  /// UnSubFunName 函数名称
  /// <para>用于判断用户执行的哪个取消订阅函数, 得到了服务器的回应</para>
  /// UnSubParam 订阅参数
  /// <para>跟执行的取消订阅函数有关:</para>
  /// <para>  如果取消订阅的是"单个设备的消息", 则UnSubParam为设备ID</para>
  /// <para>  如果取消订阅的是"用户所有设备的消息", 则UnSubParam为用户名</para>
  /// </remarks>
  TUSR_UnSubscribeAckEvent = procedure(MessageID: LongInt; UnSubFunName,
    UnSubParam: PWideChar); stdcall;

  /// <summary>
  /// 接收设备解析后的数据 事件 【云组态】
  /// </summary>
  TUSR_RcvParsedEvent = procedure(MessageID: LongInt; DevId, JsonStr:
    PWideChar); stdcall;

  /// <summary>
  /// 接收数据点值推送 事件 【云组态】
  /// </summary>
  /// <remarks>
  /// 用户需订阅主题:
  //        $USR/DevJsonTx/<DevId>
  /// <para>$USR/DevJsonTx/&lt;DevId&gt;</para>
  /// <para>才能接收数据点值推送</para>
  /// JsonStr 接收到的json格式字符串, 格式为:
  /// <para>   {                                                      </para>
  /// <para>       "dataPoints": [                                    </para>
  /// <para>           {                                              </para>
  /// <para>               "pointId": "123", //数据点 id               </para>
  /// <para>               "value":"42.12" //数据点值(整形/浮点/布尔型)</para>
  /// <para>           },                                             </para>
  /// <para>           {…}                                            </para>
  /// <para>       ],                                                 </para>
  /// <para>       "devName":"123"                                    </para>
  /// <para>   }                                                      </para>
  /// </remarks>
  TUSR_RcvParsedDataPointPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// 接收设备上下线推送 事件 【云组态】
  /// </summary>
  /// <remarks>
  /// 用户需订阅主题:
  //        $USR/JsonTx/<帐号>/+
  /// <para>$USR/JsonTx/&lt;帐号&gt;/+</para>
  /// <para>才能接收设备上下线推送</para>
  /// JsonStr 接收到的json格式字符串, 格式为:
  /// <para>   {                                   </para>
  /// <para>     "devStatus":                      </para>
  /// <para>     {                                 </para>
  /// <para>         "devName":"123",              </para>
  /// <para>         "status":1 //1 上线 0 下线    </para>
  /// <para>     }                                 </para>
  /// <para>   }                                   </para>
  /// </remarks>
  TUSR_RcvParsedDevStatusPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// 接收设备报警推送 事件 【云组态】
  /// </summary>
  /// <remarks>
  /// 用户需订阅主题:
  //        $USR/JsonTx/<帐号>/+
  /// <para>$USR/JsonTx/&lt;帐号&gt;/+</para>
  /// <para>才能接收设备报警推送</para>
  /// JsonStr 接收到的json格式字符串, 格式为:
  /// <para>{                                                   </para>
  /// <para>  "devAlarm": {                                     </para>
  /// <para>      "pointId": "123",       //数据点 id           </para>
  /// <para>      "dataName": "温度",     //数据点名称          </para>
  /// <para>      "value": "12.11",       //触发报警值          </para>
  /// <para>      "alarmValue": "12.00",  //设定的报警值        </para>
  /// <para>      "alarmCondition": "3",  //触发条件：          </para>
  /// <para> //开关ON(0)、开关OFF(1)、数值低于(2)、             </para>
  /// <para> //数值高于(3)、数值介于(4)、数值高于max低于min(5)  </para>
  /// <para>      "devName": "消防报警器",  //设备名称          </para>
  /// <para>      "alarmState": "1"         //报警状态          </para>
  /// <para> //1 触发报警; 0 撤销报警                           </para>
  /// <para>  }                                                 </para>
  /// <para>}                                                   </para>
  /// </remarks>
  TUSR_RcvParsedDevAlarmPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// 接收数据点操作应答 事件 【云组态】
  /// </summary>
  /// <remarks>
  /// 用户需订阅主题:
  //        $USR/JsonTx/<帐号>/+
  /// <para>$USR/JsonTx/&lt;帐号&gt;/&lt;DevId&gt;</para>
  /// <para>才能接收到数据点操作应答</para>
  /// <para>（目前只用于 COAP类型的设备，并且设备作为 modbus 主机）</para>
  /// JsonStr 接收到的json格式字符串, 格式为:
  /// <para>   {                                                             </para>
  /// <para>     "optionResponse": [                                         </para>
  /// <para>         {                                                       </para>
  /// <para>             "result":"1",  //1 操作成功 0 代表不成功            </para>
  /// <para>             "dataId":"100",//数据点,如果是透传那么该字段为空    </para>
  /// <para>             "option":"1"   //1.数据处于待发送状态 2.数据已发送  </para>
  /// <para>         }                                                       </para>
  /// <para>     ],                                                          </para>
  /// <para>     "devName":"123"                                             </para>
  /// <para>   }                                                             </para>
  /// </remarks>

  TUSR_RcvParsedOptionResponseReturnEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// 接收设备原始数据流 事件 【云交换机】
  /// </summary>
  /// <remarks>
  /// 用户需订阅主题:
  //        $USR/Dev2App/<帐号>/<DevId> 或 $USR/DevTx/<DevId>
  /// <para>$USR/Dev2App/&lt;帐号&gt;/&lt;DevId&gt; 或 $USR/DevTx/&lt;DevId&gt;</para>
  /// <para>才能接收到设备原始数据流</para>
  /// </remarks>

  TUSR_RcvRawFromDevEvent = procedure(MessageID: LongInt; DevId: PWideChar;
    pData: PByte; DataLen: Integer); stdcall;

  // ===========================不再推荐使用的事件=========================//

  /// <summary>
  /// 接收设备原始数据流 事件
  /// 【不再推荐使用, 建议用 TUSR_RcvRawFromDevEvent 代替】
  /// </summary>
  TUSR_RcvEvent = procedure(MessageID: LongInt; DevId: PWideChar; pData: PByte;
    DataLen: Integer); stdcall;

  /// <summary>
  /// 订阅响应 事件
  /// 【不再推荐使用, 建议用 TUSR_SubscribeAckEvent 代替】
  /// </summary>
  TUSR_SubAckEvent = procedure(MessageID: LongInt; DevId, ReturnCode:
    PWideChar);
  stdcall;

  /// <summary>
  /// 取消订阅响应 事件
  /// 【不再推荐使用, 建议用 TUSR_UnSubscribeAckEvent 代替】
  /// </summary>
  TUSR_UnSubAckEvent = procedure(MessageID: LongInt; DevId: PWideChar); stdcall;

  // ------------------------------------------------------------------------------
  // 函数接口
  // ------------------------------------------------------------------------------

  // ==============================================================================
  // ==============================================================================
  // 初始化和释放
  // ==============================================================================
  // ==============================================================================

  /// <summary>
  /// 获取dll版本信息
  /// </summary>
function USR_GetVer: LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// 初始化接口
/// </summary>
/// <remarks>
///   Host
///     透传云服务器地址,固定为 clouddata.usr.cn , 打死都不变。
///   Port
///     端口, 固定为1883, 打死都不变。
///   Ver
///     版本号, 为解决日后可能出现的兼容性问题而生。
///     开发者开发时用的dll版本号是多少,这里就填多少。
///     日后,即使新版本的处理规则变了,仍然会保持对旧版本的兼容
/// </remarks>
function USR_Init(Host: PWideChar; Port: Word; Ver: LongInt): Boolean; stdcall;
external csUsrCloudDll;

/// <summary>
/// 释放接口
/// </summary>
function USR_Release(): Boolean; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// 连接和断开
// ==============================================================================
// ==============================================================================

/// <summary>
/// 设置 连接响应 回调函数
/// </summary>
function USR_OnConnAck(OnConnAct: TUSR_ConnAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 连接 USR MQTT 服务器
/// </summary>
function USR_Connect(Username, Password: PWideChar): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 主动断开连接
/// </summary>
function USR_DisConnect(): Boolean; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// 订阅和取消订阅
// ==============================================================================
// ==============================================================================

/// <summary>
/// 设置订阅回调函数
/// </summary>
function USR_OnSubscribeAck(OnSubscribeAck: TUSR_SubscribeAckEvent): Boolean;
stdcall; external csUsrCloudDll;

/// <summary>
/// 设置取消订阅回调函数
/// </summary>
function USR_OnUnSubscribeAck(OnUnSubscribeAck: TUSR_UnSubscribeAckEvent):
  Boolean; stdcall; external csUsrCloudDll;

/// <summary>
/// 订阅单个设备解析后的数据  【云组态】
/// </summary>
function USR_SubscribeDevParsed(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// 订阅账户下所有设备解析后的数据  【云组态】
/// </summary>

function USR_SubscribeUserParsed(Username: PWideChar): LongInt; stdcall;
external csUsrCloudDll;

/// <summary>
/// 取消订阅单个设备解析后的数据  【云组态】
/// </summary>
function USR_UnSubscribeDevParsed(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// 取消订阅账户下所有设备解析后的数据  【云组态】
/// </summary>

function USR_UnSubscribeUserParsed(Username: PWideChar): LongInt; stdcall;
external csUsrCloudDll;

/// <summary>
/// 订阅单个设备原始数据流 【云交换机】
/// </summary>
function USR_SubscribeDevRaw(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// 订阅账户下所有设备原始数据流 【云交换机】
/// </summary>

function USR_SubscribeUserRaw(Username: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// 取消订阅单个设备原始数据流 【云交换机】
/// </summary>
function USR_UnSubscribeDevRaw(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// 取消订阅账户下所有设备原始数据流 【云交换机】
/// </summary>

function USR_UnSubscribeUserRaw(Username: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// 推送数据
// ==============================================================================
// ==============================================================================

/// <summary>
/// 设置 Qos 1 发布响应 回调函数
/// </summary>
function USR_OnPubAck(OnPubAck: TUSR_PubAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 设置数据点值【云组态】
/// </summary>
function USR_PublishParsedSetSlaveDataPoint(DevId, SlaveIndex, PointId, Value:
  PWideChar): LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// 查询数据点值【云组态】
/// </summary>
function USR_PublishParsedQuerySlaveDataPoint(DevId, SlaveIndex, PointId:
  PWideChar): LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// 向单台设备推送原始数据流 【云交换机】
/// </summary>
function USR_PublishRawToDev(DevId: PWideChar; pData: PByte; DataLen: Integer):
  LongInt; stdcall; external csUsrCloudDll;
/// <summary>
/// 向账户下所有设备推送原始数据流 【云交换机】
/// </summary>

function USR_PublishRawToUser(Username: PWideChar; pData: PByte; DataLen:
  Integer): LongInt; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// 接收数据
// ==============================================================================
// ==============================================================================

/// <summary>
/// 设置 接收数据点值推送 回调函数 【云组态】
/// </summary>
function USR_OnRcvParsedDataPointPush(OnRcvParsedDataPointPush:
  TUSR_RcvParsedDataPointPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// 设置 接收设备上下线推送 回调函数 【云组态】
/// </summary>

function USR_OnRcvParsedDevStatusPush(OnRcvParsedDevStatusPush:
  TUSR_RcvParsedDevStatusPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// 设置 接收设备报警推送 回调函数 【云组态】
/// </summary>

function USR_OnRcvParsedDevAlarmPush(OnRcvParsedDevAlarmPush:
  TUSR_RcvParsedDevAlarmPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// 设置 接收数据点操作应答 【云组态】
/// </summary>

function USR_OnRcvParsedOptionResponseReturn(OnRcvParsedOptionResponseReturn:
  TUSR_RcvParsedOptionResponseReturnEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 设置 接收设备原始数据流 回调函数 【云交换机】
/// </summary>
function USR_OnRcvRawFromDev(OnRcvRawFromDev: TUSR_RcvRawFromDevEvent): Boolean;
stdcall; external csUsrCloudDll;

// ===========================不再推荐使用的接口=========================//

/// <summary>
/// 订阅原始数据流 【不再推荐使用】
/// </summary>
/// <remarks>
/// 本函数的缺陷是, 不能订阅子账户, 推荐用 USR_SubscribeDevRaw 和 USR_SubscribeUserRaw代替
/// </remarks>
/// <param name="DevId">
/// 如果要订阅多个设备,请用逗号隔开;
/// 如果要订阅帐号下所有的设备的消息,请传入空。
/// </param>
function USR_Subscribe(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// 设置 订阅响应 回调函数 【不再推荐使用】
/// </summary>
function USR_OnSubAck(OnSubAck: TUSR_SubAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 订阅原始数据流 【不再推荐使用】
/// </summary>
/// <remarks>
/// 本函数的缺陷是, 不能取消订阅子账户, 推荐用 USR_UnSubscribeDevRaw 和 USR_UnSubscribeUserRaw代替
/// </remarks>
function USR_UnSubscribe(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// 设置 取消订阅响应 回调函数 【不再推荐使用】
/// </summary>
function USR_OnUnSubAck(OnUnSubAck: TUSR_UnSubAckEvent): Boolean; stdcall;
external csUsrCloudDll;

/// <summary>
/// 推送原始数据流 【不再推荐使用】
/// </summary>
/// <remarks>
/// 本函数的缺陷是, 不能不能向子账号下的设备推送数据,
/// 推荐用 USR_PublishRawToDev 和 USR_PublishRawToUser 代替
/// </remarks>
/// <param name="DevId">
/// 如果要向帐号下所有的设备推送数据,请传入空。
/// </param>
function USR_Publish(DevId: PWideChar; pData: PByte; DataLen: Integer): LongInt;
stdcall; external csUsrCloudDll;

/// <summary>
/// 设置 接收原始数据流 回调函数 【不再推荐使用】
/// </summary>
/// <remarks>
/// 推荐用 USR_OnRcvRawFromDev 代替, 功能一致, 仅仅为了名称命名规范
/// </remarks>
function USR_OnRcv(OnRcv: TUSR_RcvEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// 设置设备数据点值【云组态】 【不再推荐使用】
/// </summary>
/// <remarks>
///   用 USR_PublishParsedSetSlaveDataPoint 代替
/// </remarks>
function USR_PublishParsedSetDataPoint(DevId, PointId, Value: PWideChar):
  LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// 查询设备数据点值【云组态】 【不再推荐使用】
/// </summary>
/// <remarks>
///   用 USR_PublishParsedSlaveQueryDataPoint 代替
/// </remarks>
function USR_PublishParsedQueryDataPoint(DevId, PointId: PWideChar): LongInt;
stdcall; external csUsrCloudDll;

implementation

end.


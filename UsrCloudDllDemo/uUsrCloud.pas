unit uUsrCloud;

interface

const
  csUsrCloudDll     = 'UsrCloud.dll';

type
  // ------------------------------------------------------------------------------
  // �ص���������
  // ------------------------------------------------------------------------------

  /// <summary>
  /// ������Ӧ �¼�
  /// </summary>
  /// <remarks>
  /// ִ��USR_Connect���ӷ�����,�ᴥ�����¼�
  /// ReturnCode ������:
  /// <para>0x01	�����Ѿܾ�����֧�ֵ�Э��汾     </para>
  /// <para>0x02	�����Ѿܾ������ϸ�Ŀͻ��˱�ʶ�� </para>
  /// <para>0x03	�����Ѿܾ�������˲�����         </para>
  /// <para>0x04	�����Ѿܾ�����Ч���û���������   </para>
  /// <para>0x05	�����Ѿܾ���δ��Ȩ               </para>
  /// </remarks>

  TUSR_ConnAckEvent = procedure(ReturnCode: LongInt; Description: PWideChar);
  stdcall;

  /// <summary>
  /// ������Ӧ �¼�
  /// </summary>
  /// <remarks>
  /// ִ��USR_PublishXXX������Ϣ,�ᴥ�����¼�
  /// </remarks>
  TUSR_PubAckEvent = procedure(MessageID: LongInt); stdcall;

  /// <summary>
  /// ������Ӧ �¼�
  /// </summary>
  /// <remarks>
  /// ִ��USR_SubscribeXXX������Ϣ,�ᴥ�����¼�
  /// SubFunName ��������
  /// <para>�����ж��û�ִ�е��ĸ����ĺ���, �õ��˷������Ļ�Ӧ</para>
  /// SubParam ���Ĳ���
  /// <para>��ִ�еĶ��ĺ����й�:</para>
  /// <para>  ������ĵ���"�����豸����Ϣ", ��SubParamΪ�豸ID</para>
  /// <para>  ������ĵ���"�û������豸����Ϣ", ��SubParamΪ�û���</para>
  /// ReturnCode ������
  /// <para>0, 1, 2 : ���ĳɹ�</para>
  /// <para>128 : ����ʧ��</para>
  /// </remarks>
  TUSR_SubscribeAckEvent = procedure(MessageID: LongInt; SubFunName, SubParam,
    ReturnCode: PWideChar); stdcall;

  /// <summary>
  /// ȡ��������Ӧ �¼�
  /// </summary>
  /// <remarks>
  /// <para>ִ��USR_UnSubscribeXXXȡ��������Ϣ,�ᴥ�����¼�</para>
  /// UnSubFunName ��������
  /// <para>�����ж��û�ִ�е��ĸ�ȡ�����ĺ���, �õ��˷������Ļ�Ӧ</para>
  /// UnSubParam ���Ĳ���
  /// <para>��ִ�е�ȡ�����ĺ����й�:</para>
  /// <para>  ���ȡ�����ĵ���"�����豸����Ϣ", ��UnSubParamΪ�豸ID</para>
  /// <para>  ���ȡ�����ĵ���"�û������豸����Ϣ", ��UnSubParamΪ�û���</para>
  /// </remarks>
  TUSR_UnSubscribeAckEvent = procedure(MessageID: LongInt; UnSubFunName,
    UnSubParam: PWideChar); stdcall;

  /// <summary>
  /// �����豸����������� �¼� ������̬��
  /// </summary>
  TUSR_RcvParsedEvent = procedure(MessageID: LongInt; DevId, JsonStr:
    PWideChar); stdcall;

  /// <summary>
  /// �������ݵ�ֵ���� �¼� ������̬��
  /// </summary>
  /// <remarks>
  /// �û��趩������:
  //        $USR/DevJsonTx/<DevId>
  /// <para>$USR/DevJsonTx/&lt;DevId&gt;</para>
  /// <para>���ܽ������ݵ�ֵ����</para>
  /// JsonStr ���յ���json��ʽ�ַ���, ��ʽΪ:
  /// <para>   {                                                      </para>
  /// <para>       "dataPoints": [                                    </para>
  /// <para>           {                                              </para>
  /// <para>               "pointId": "123", //���ݵ� id               </para>
  /// <para>               "value":"42.12" //���ݵ�ֵ(����/����/������)</para>
  /// <para>           },                                             </para>
  /// <para>           {��}                                            </para>
  /// <para>       ],                                                 </para>
  /// <para>       "devName":"123"                                    </para>
  /// <para>   }                                                      </para>
  /// </remarks>
  TUSR_RcvParsedDataPointPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// �����豸���������� �¼� ������̬��
  /// </summary>
  /// <remarks>
  /// �û��趩������:
  //        $USR/JsonTx/<�ʺ�>/+
  /// <para>$USR/JsonTx/&lt;�ʺ�&gt;/+</para>
  /// <para>���ܽ����豸����������</para>
  /// JsonStr ���յ���json��ʽ�ַ���, ��ʽΪ:
  /// <para>   {                                   </para>
  /// <para>     "devStatus":                      </para>
  /// <para>     {                                 </para>
  /// <para>         "devName":"123",              </para>
  /// <para>         "status":1 //1 ���� 0 ����    </para>
  /// <para>     }                                 </para>
  /// <para>   }                                   </para>
  /// </remarks>
  TUSR_RcvParsedDevStatusPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// �����豸�������� �¼� ������̬��
  /// </summary>
  /// <remarks>
  /// �û��趩������:
  //        $USR/JsonTx/<�ʺ�>/+
  /// <para>$USR/JsonTx/&lt;�ʺ�&gt;/+</para>
  /// <para>���ܽ����豸��������</para>
  /// JsonStr ���յ���json��ʽ�ַ���, ��ʽΪ:
  /// <para>{                                                   </para>
  /// <para>  "devAlarm": {                                     </para>
  /// <para>      "pointId": "123",       //���ݵ� id           </para>
  /// <para>      "dataName": "�¶�",     //���ݵ�����          </para>
  /// <para>      "value": "12.11",       //��������ֵ          </para>
  /// <para>      "alarmValue": "12.00",  //�趨�ı���ֵ        </para>
  /// <para>      "alarmCondition": "3",  //����������          </para>
  /// <para> //����ON(0)������OFF(1)����ֵ����(2)��             </para>
  /// <para> //��ֵ����(3)����ֵ����(4)����ֵ����max����min(5)  </para>
  /// <para>      "devName": "����������",  //�豸����          </para>
  /// <para>      "alarmState": "1"         //����״̬          </para>
  /// <para> //1 ��������; 0 ��������                           </para>
  /// <para>  }                                                 </para>
  /// <para>}                                                   </para>
  /// </remarks>
  TUSR_RcvParsedDevAlarmPushEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// �������ݵ����Ӧ�� �¼� ������̬��
  /// </summary>
  /// <remarks>
  /// �û��趩������:
  //        $USR/JsonTx/<�ʺ�>/+
  /// <para>$USR/JsonTx/&lt;�ʺ�&gt;/&lt;DevId&gt;</para>
  /// <para>���ܽ��յ����ݵ����Ӧ��</para>
  /// <para>��Ŀǰֻ���� COAP���͵��豸�������豸��Ϊ modbus ������</para>
  /// JsonStr ���յ���json��ʽ�ַ���, ��ʽΪ:
  /// <para>   {                                                             </para>
  /// <para>     "optionResponse": [                                         </para>
  /// <para>         {                                                       </para>
  /// <para>             "result":"1",  //1 �����ɹ� 0 �����ɹ�            </para>
  /// <para>             "dataId":"100",//���ݵ�,�����͸����ô���ֶ�Ϊ��    </para>
  /// <para>             "option":"1"   //1.���ݴ��ڴ�����״̬ 2.�����ѷ���  </para>
  /// <para>         }                                                       </para>
  /// <para>     ],                                                          </para>
  /// <para>     "devName":"123"                                             </para>
  /// <para>   }                                                             </para>
  /// </remarks>

  TUSR_RcvParsedOptionResponseReturnEvent = TUSR_RcvParsedEvent;

  /// <summary>
  /// �����豸ԭʼ������ �¼� ���ƽ�������
  /// </summary>
  /// <remarks>
  /// �û��趩������:
  //        $USR/Dev2App/<�ʺ�>/<DevId> �� $USR/DevTx/<DevId>
  /// <para>$USR/Dev2App/&lt;�ʺ�&gt;/&lt;DevId&gt; �� $USR/DevTx/&lt;DevId&gt;</para>
  /// <para>���ܽ��յ��豸ԭʼ������</para>
  /// </remarks>

  TUSR_RcvRawFromDevEvent = procedure(MessageID: LongInt; DevId: PWideChar;
    pData: PByte; DataLen: Integer); stdcall;

  // ===========================�����Ƽ�ʹ�õ��¼�=========================//

  /// <summary>
  /// �����豸ԭʼ������ �¼�
  /// �������Ƽ�ʹ��, ������ TUSR_RcvRawFromDevEvent ���桿
  /// </summary>
  TUSR_RcvEvent = procedure(MessageID: LongInt; DevId: PWideChar; pData: PByte;
    DataLen: Integer); stdcall;

  /// <summary>
  /// ������Ӧ �¼�
  /// �������Ƽ�ʹ��, ������ TUSR_SubscribeAckEvent ���桿
  /// </summary>
  TUSR_SubAckEvent = procedure(MessageID: LongInt; DevId, ReturnCode:
    PWideChar);
  stdcall;

  /// <summary>
  /// ȡ��������Ӧ �¼�
  /// �������Ƽ�ʹ��, ������ TUSR_UnSubscribeAckEvent ���桿
  /// </summary>
  TUSR_UnSubAckEvent = procedure(MessageID: LongInt; DevId: PWideChar); stdcall;

  // ------------------------------------------------------------------------------
  // �����ӿ�
  // ------------------------------------------------------------------------------

  // ==============================================================================
  // ==============================================================================
  // ��ʼ�����ͷ�
  // ==============================================================================
  // ==============================================================================

  /// <summary>
  /// ��ȡdll�汾��Ϣ
  /// </summary>
function USR_GetVer: LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// ��ʼ���ӿ�
/// </summary>
/// <remarks>
///   Host
///     ͸���Ʒ�������ַ,�̶�Ϊ clouddata.usr.cn , ���������䡣
///   Port
///     �˿�, �̶�Ϊ1883, ���������䡣
///   Ver
///     �汾��, Ϊ����պ���ܳ��ֵļ��������������
///     �����߿���ʱ�õ�dll�汾���Ƕ���,���������١�
///     �պ�,��ʹ�°汾�Ĵ���������,��Ȼ�ᱣ�ֶԾɰ汾�ļ���
/// </remarks>
function USR_Init(Host: PWideChar; Port: Word; Ver: LongInt): Boolean; stdcall;
external csUsrCloudDll;

/// <summary>
/// �ͷŽӿ�
/// </summary>
function USR_Release(): Boolean; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// ���ӺͶϿ�
// ==============================================================================
// ==============================================================================

/// <summary>
/// ���� ������Ӧ �ص�����
/// </summary>
function USR_OnConnAck(OnConnAct: TUSR_ConnAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// ���� USR MQTT ������
/// </summary>
function USR_Connect(Username, Password: PWideChar): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// �����Ͽ�����
/// </summary>
function USR_DisConnect(): Boolean; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// ���ĺ�ȡ������
// ==============================================================================
// ==============================================================================

/// <summary>
/// ���ö��Ļص�����
/// </summary>
function USR_OnSubscribeAck(OnSubscribeAck: TUSR_SubscribeAckEvent): Boolean;
stdcall; external csUsrCloudDll;

/// <summary>
/// ����ȡ�����Ļص�����
/// </summary>
function USR_OnUnSubscribeAck(OnUnSubscribeAck: TUSR_UnSubscribeAckEvent):
  Boolean; stdcall; external csUsrCloudDll;

/// <summary>
/// ���ĵ����豸�����������  ������̬��
/// </summary>
function USR_SubscribeDevParsed(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// �����˻��������豸�����������  ������̬��
/// </summary>

function USR_SubscribeUserParsed(Username: PWideChar): LongInt; stdcall;
external csUsrCloudDll;

/// <summary>
/// ȡ�����ĵ����豸�����������  ������̬��
/// </summary>
function USR_UnSubscribeDevParsed(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// ȡ�������˻��������豸�����������  ������̬��
/// </summary>

function USR_UnSubscribeUserParsed(Username: PWideChar): LongInt; stdcall;
external csUsrCloudDll;

/// <summary>
/// ���ĵ����豸ԭʼ������ ���ƽ�������
/// </summary>
function USR_SubscribeDevRaw(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// �����˻��������豸ԭʼ������ ���ƽ�������
/// </summary>

function USR_SubscribeUserRaw(Username: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// ȡ�����ĵ����豸ԭʼ������ ���ƽ�������
/// </summary>
function USR_UnSubscribeDevRaw(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;
/// <summary>
/// ȡ�������˻��������豸ԭʼ������ ���ƽ�������
/// </summary>

function USR_UnSubscribeUserRaw(Username: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// ��������
// ==============================================================================
// ==============================================================================

/// <summary>
/// ���� Qos 1 ������Ӧ �ص�����
/// </summary>
function USR_OnPubAck(OnPubAck: TUSR_PubAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// �������ݵ�ֵ������̬��
/// </summary>
function USR_PublishParsedSetSlaveDataPoint(DevId, SlaveIndex, PointId, Value:
  PWideChar): LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// ��ѯ���ݵ�ֵ������̬��
/// </summary>
function USR_PublishParsedQuerySlaveDataPoint(DevId, SlaveIndex, PointId:
  PWideChar): LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// ��̨�豸����ԭʼ������ ���ƽ�������
/// </summary>
function USR_PublishRawToDev(DevId: PWideChar; pData: PByte; DataLen: Integer):
  LongInt; stdcall; external csUsrCloudDll;
/// <summary>
/// ���˻��������豸����ԭʼ������ ���ƽ�������
/// </summary>

function USR_PublishRawToUser(Username: PWideChar; pData: PByte; DataLen:
  Integer): LongInt; stdcall; external csUsrCloudDll;

// ==============================================================================
// ==============================================================================
// ��������
// ==============================================================================
// ==============================================================================

/// <summary>
/// ���� �������ݵ�ֵ���� �ص����� ������̬��
/// </summary>
function USR_OnRcvParsedDataPointPush(OnRcvParsedDataPointPush:
  TUSR_RcvParsedDataPointPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// ���� �����豸���������� �ص����� ������̬��
/// </summary>

function USR_OnRcvParsedDevStatusPush(OnRcvParsedDevStatusPush:
  TUSR_RcvParsedDevStatusPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// ���� �����豸�������� �ص����� ������̬��
/// </summary>

function USR_OnRcvParsedDevAlarmPush(OnRcvParsedDevAlarmPush:
  TUSR_RcvParsedDevAlarmPushEvent): Boolean; stdcall; external csUsrCloudDll;
/// <summary>
/// ���� �������ݵ����Ӧ�� ������̬��
/// </summary>

function USR_OnRcvParsedOptionResponseReturn(OnRcvParsedOptionResponseReturn:
  TUSR_RcvParsedOptionResponseReturnEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// ���� �����豸ԭʼ������ �ص����� ���ƽ�������
/// </summary>
function USR_OnRcvRawFromDev(OnRcvRawFromDev: TUSR_RcvRawFromDevEvent): Boolean;
stdcall; external csUsrCloudDll;

// ===========================�����Ƽ�ʹ�õĽӿ�=========================//

/// <summary>
/// ����ԭʼ������ �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
/// ��������ȱ����, ���ܶ������˻�, �Ƽ��� USR_SubscribeDevRaw �� USR_SubscribeUserRaw����
/// </remarks>
/// <param name="DevId">
/// ���Ҫ���Ķ���豸,���ö��Ÿ���;
/// ���Ҫ�����ʺ������е��豸����Ϣ,�봫��ա�
/// </param>
function USR_Subscribe(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// ���� ������Ӧ �ص����� �������Ƽ�ʹ�á�
/// </summary>
function USR_OnSubAck(OnSubAck: TUSR_SubAckEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// ����ԭʼ������ �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
/// ��������ȱ����, ����ȡ���������˻�, �Ƽ��� USR_UnSubscribeDevRaw �� USR_UnSubscribeUserRaw����
/// </remarks>
function USR_UnSubscribe(DevId: PWideChar): LongInt; stdcall; external
csUsrCloudDll;

/// <summary>
/// ���� ȡ��������Ӧ �ص����� �������Ƽ�ʹ�á�
/// </summary>
function USR_OnUnSubAck(OnUnSubAck: TUSR_UnSubAckEvent): Boolean; stdcall;
external csUsrCloudDll;

/// <summary>
/// ����ԭʼ������ �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
/// ��������ȱ����, ���ܲ��������˺��µ��豸��������,
/// �Ƽ��� USR_PublishRawToDev �� USR_PublishRawToUser ����
/// </remarks>
/// <param name="DevId">
/// ���Ҫ���ʺ������е��豸��������,�봫��ա�
/// </param>
function USR_Publish(DevId: PWideChar; pData: PByte; DataLen: Integer): LongInt;
stdcall; external csUsrCloudDll;

/// <summary>
/// ���� ����ԭʼ������ �ص����� �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
/// �Ƽ��� USR_OnRcvRawFromDev ����, ����һ��, ����Ϊ�����������淶
/// </remarks>
function USR_OnRcv(OnRcv: TUSR_RcvEvent): Boolean; stdcall; external
csUsrCloudDll;

/// <summary>
/// �����豸���ݵ�ֵ������̬�� �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
///   �� USR_PublishParsedSetSlaveDataPoint ����
/// </remarks>
function USR_PublishParsedSetDataPoint(DevId, PointId, Value: PWideChar):
  LongInt; stdcall; external csUsrCloudDll;

/// <summary>
/// ��ѯ�豸���ݵ�ֵ������̬�� �������Ƽ�ʹ�á�
/// </summary>
/// <remarks>
///   �� USR_PublishParsedSlaveQueryDataPoint ����
/// </remarks>
function USR_PublishParsedQueryDataPoint(DevId, PointId: PWideChar): LongInt;
stdcall; external csUsrCloudDll;

implementation

end.


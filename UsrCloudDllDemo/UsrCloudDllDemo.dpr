program UsrCloudDllDemo;

uses
  Vcl.Forms,
  uFrmUsrCloudDllDemo in 'uFrmUsrCloudDllDemo.pas' {FrmUsrCloudDllDemo},
  uUsrCloud in 'uUsrCloud.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmUsrCloudDllDemo, FrmUsrCloudDllDemo);
  Application.Run;
end.

//unit Model.Connection;
//
//interface
//
//uses
//  FireDAC.DApt, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.UI.Intf,
//  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
//  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
//  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
//
//  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.Classes,
//
//  System.IniFiles, System.SysUtils;
//
//var
//    FConnection : TFDConnection;
//
//function SetupConnection(FConn: TFDConnection): String;
//function Connect : TFDConnection;
//procedure Disconect;
//
//implementation
//
//function SetupConnection(FConn: TFDConnection): string;
//begin
//    try
//        try
//            FConn.Params.Add('DriverID=FB');
//            FConn.Params.Add('Server=localhost');
//            FConn.Params.Add('Database=C:\Users\leo_0\Downloads\qwer\qwer\TREINAMENTO.FB');
//            FConn.Params.Add('User_Name=sysdba');
//            FConn.Params.Add('Password=masterkey');
//            FConn.Params.Add('Port=3050');
//            FConn.Params.Add('Server=localhost');
//
//            Result := 'OK';
//        except on ex:exception do
//            Result := 'Erro ao configurar banco: ' + ex.Message;
//        end;
//
//    finally
//    end;
//end;
//
//function Connect : TFDConnection;
//begin
//    FConnection := TFDConnection.Create(nil);
//    SetupConnection(FConnection);
//    FConnection.Connected := true;
//
//    Result := FConnection;
//end;
//
//procedure Disconect;
//begin
//    if Assigned(FConnection) then
//    begin
//        if FConnection.Connected then
//            FConnection.Connected := false;
//
//        FConnection.Free;
//    end;
//
//end;
//
//
//end.
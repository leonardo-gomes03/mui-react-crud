unit Service.Pessoa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    mTable: TFDMemTable;

  private
    { Private declarations }
  public
    { Public declarations }
    TNome: string;
    TRG: string;
    TCPF: string;
    TSexo: string;
    TData: string;
    procedure GetPessoas;
    procedure ChangePage(page: integer);
    procedure DeletePessoa(sequencia: integer);
    procedure PostPessoa(nome, rg, cpf, sexo, data: string);
    procedure EditPessoa(sequencia: Integer; nome, rg, cpf, sexo, data: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }
uses RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D, DataSet.Serialize;

procedure TDataModule1.ChangePage(page: integer);
var
  LService: IResponse;
begin
  if page < 1 then
    page := 1;

  LService := (TRequest.New.BaseURL('http://localhost:9000/')
    .Resource('pessoas/?limit=10&page=' + page.ToString)
    .AddHeader('x-paginate','true')
    .BasicAuthentication('admin','admin')
    .Get)
    ;

  if page > (LService.JSONValue.P['pages'].AsType<Integer>) then
  begin
    page := (LService.JSONValue.P['pages'].AsType<Integer>);
    exit;
  end;

  mTable.LoadFromJSON(LService.JSONValue.P['docs'].ToString);


end;

procedure TDataModule1.DeletePessoa(sequencia: integer);
var
  LService: IResponse;
begin
  LService := (TRequest.New.BaseURL('http://localhost:9000/')
    .Resource('pessoas/' + sequencia.ToString)
    .BasicAuthentication('admin','admin')
    .Delete);
end;

procedure TDataModule1.EditPessoa(sequencia: Integer; nome, rg, cpf, sexo, data: string);
var
  LService: IResponse;
begin
  LService := (TRequest.New.BaseURL('http://localhost:9000/')
    .Resource('pessoas/' + sequencia.ToString)
    .BasicAuthentication('admin','admin')
    .AddBody('{"nome":"'+nome+'", "rg":"'+rg+'", "cpf":"'+cpf+'", "sexo":"'+sexo+'", "data":"'+data+'"}')
    .Patch);
end;


procedure TDataModule1.GetPessoas;
var
  LService: IResponse;
begin
  LService := (TRequest.New.BaseURL('http://localhost:9000/')
    .Resource('pessoas/?limit=10&page=1')
    .AddHeader('x-paginate','true')
    .BasicAuthentication('admin','admin')
    .Get);
  mTable.LoadFromJSON(LService.JSONValue.P['docs'].ToString);


end;


procedure TDataModule1.PostPessoa(nome, rg, cpf, sexo, data: string);
var
  LService: IResponse;
begin
  LService := (TRequest.New.BaseURL('http://localhost:9000/')
    .Resource('pessoas/')
    .BasicAuthentication('admin','admin')
    .AddBody('{"nome":"'+nome+'", "rg":"'+rg+'", "cpf":"'+cpf+'", "sexo":"'+sexo+'", "data":"'+data+'"}')
    .Post);
end;

end.

unit Controller.Pessoas;

interface

uses  Horse, System.JSON, System.SysUtils, Model.Pessoas,
      FireDAC.Comp.Client, DATA.DB, Dataset.Serialize, Service.Pessoas,
      Vcl.Graphics, Horse.GBSwagger,Horse.GBSwagger.Register, GBSwagger.Path.Attributes, Web.HTTPApp, System.Classes;

type
  [SwagPath('pessoas', 'Pessoas')]
  TPessoaController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;

  public
    [SwagGET('Listar Pessoas', True)]
    [SwagParamHeader('x-paginate','', true)]
    [SwagParamQuery('limit', 'Tamanho da Pagina')]
    [SwagParamQuery('page', 'Pagina')]
    [SwagResponse(200, TPessoaGet, 'Modelo de Resposta', True)]
    procedure ListarPessoas;

    [SwagGET('{sequencia}', 'Encontrar Pessoa')]
    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
    [SwagResponse(200, TPessoaGet)]
    [SwagResponse(404)]
    procedure ListarPessoa;

    [SwagPOST('Inserir Usuário')]
    [SwagParamBody('Dados', TPessoaPost)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    procedure AdicionarPessoa;

    [SwagPatch('{sequencia}', 'Update user')]
    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
    [SwagParamBody('Dados', TPessoaPost)]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    procedure AlterarPessoa;

    [SwagDELETE('{sequencia}', 'Excluir Usuario')]
    [SwagParamPath('sequencia', 'Sequencia do Usuario')]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    procedure DeletarPessoa;

    constructor Create(Req: THorseRequest; Res: THorseResponse);
end;

procedure Registry;

implementation

procedure TPessoaController.ListarPessoas;
var
  erro: string;
  LService: TServicePessoas;
begin
    LService := TServicePessoas.Create(nil);
  try
    FRes.Send(LService.GetPessoas('', erro)).Status(200);
  finally
    LService.Free;
  end;
end;


procedure TPessoaController.ListarPessoa;
var
  erro: string;
  LService: TServicePessoas;
begin
    LService := TServicePessoas.Create(nil);
    LService.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
  try
    FRes.Send(LService.GetPessoas('', erro)).Status(200);
  finally
    LService.Free;
  end;
end;


procedure TPessoaController.DeletarPessoa;
var
  erro: string;
  result: Boolean;
  LService: TServicePessoas;
begin
    LService := TServicePessoas.Create(nil);
    LService.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
  try
    result := LService.DeletePessoa(erro);
    FRes.Send('Pessoa Excluida').Status(THTTPStatus.OK);
  finally
    LService.Free;
  end;
end;

procedure TPessoaController.AdicionarPessoa;
var
  erro: string;
  result: Boolean;
  LService: TServicePessoas;
  body: TJsonValue;
begin
  try
    LService := TServicePessoas.Create(nil);
  except

  end;
  
  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FReq.Body),0) as TJsonValue;
      LService.NOME := body.GetValue<string>('nome', '');
      LService.RG := body.GetValue<string>('rg', '');
      LService.CPF := body.GetValue<string>('cpf', '');
      LService.SEXO := body.GetValue<string>('sexo', '');
      LService.DATANASCIMENTO := body.GetValue<string>('datanascimento', '');
      LService.FOTO := body.GetValue<string>('foto', '');

      LService.PostPessoa(erro);

      body.Free;

      if erro <> '' then
      begin
        raise Exception.Create(erro);
      end
        
    finally

    end;
    FRes.Send('Pessoa Inserida').Status(200);
  finally
    LService.Free;
  end;
end;

procedure TPessoaController.AlterarPessoa;
var
  LService: TServicePessoas;
  erro: string;
  body: TJsonValue;
begin
  try
    LService := TServicePessoas.Create(nil);
  except

  end;

  try
    try
      LService.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FReq.Body),0) as TJsonValue;
      LService.NOME := body.GetValue<string>('nome','');
      LService.RG := body.GetValue<string>('rg','');
      LService.CPF := body.GetValue<string>('cpf','');
      LService.SEXO := body.GetValue<string>('sexo','');
      LService.DATANASCIMENTO := body.GetValue<string>('datanascimento','');
      LService.FOTO := body.GetValue<string>('foto', '');
      LService.PatchPessoa(erro);

      body.Free;

      if erro <> '' then
      begin
        FRes.Send('Informe a sequencia').Status(400);
        raise Exception.Create(erro);
      end
    finally

    end;
    FRes.Send('Pessoa Editada').Status(200);
  finally
  LService.Free;
  end;
end;


procedure Registry;
begin
    THorseGBSwaggerRegister.RegisterPath(TPessoaController);
end;

constructor TPessoaController.Create(Req: THorseRequest;
  Res: THorseResponse);
begin
  FReq := Req;
  FRes := Res;
end;
end.

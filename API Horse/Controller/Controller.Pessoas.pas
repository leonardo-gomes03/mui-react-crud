unit Controller.Pessoas;

interface

uses  Horse, System.JSON, System.SysUtils, Model.Connection, Model.Pessoas,
      FireDAC.Comp.Client, DATA.DB, Dataset.Serialize,
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
    [SwagResponse(200, TPessoa, 'Modelo de Resposta', True)]
    procedure ListarPessoas;

    [SwagGET('{sequencia}', 'Encontrar Pessoa')]
    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
    [SwagResponse(200, TPessoa)]
    [SwagResponse(404)]
    procedure ListarPessoa;

    [SwagPOST('Inserir Usu�rio')]
    [SwagParamBody('Dados', TPessoa)]
    [SwagResponse(201, TPessoa)]
    [SwagResponse(400)]
    procedure AdicionarPessoa;

    [SwagPatch('{sequencia}', 'Update user')]
    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
    [SwagParamBody('Dados', TPessoa)]
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
  pessoa: TPessoa;
  qry: TJSONArray;
  erro: string;
  arrayPessoas: TJSONArray;
begin
  try
    pessoa := TPessoa.Create;
  except

  end;
  try
    qry := pessoa.ListarPessoas('', erro);
    FRes.Send<TJSONArray>(qry).Status(200);
  finally
    FreeAndNil(pessoa)
  end;
end;


procedure TPessoaController.ListarPessoa;
var
  pessoa: TPessoa;
  qry: TJSONArray;
  erro: string;
  arrayPessoa: TJSONArray;
begin
  try
    pessoa := TPessoa.Create;
    pessoa.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
  except

  end;
  try
    qry := pessoa.ListarPessoas('', erro);
    FRes.Send<TJSONArray>(qry).Status(200);
  finally
    FreeAndNil(pessoa)
  end;

end;
procedure TPessoaController.DeletarPessoa;
var
  pessoa: TPessoa;
  qry: Boolean;
  erro: string;
  arrayPessoa: TJSONArray;
begin
  try
    pessoa := TPessoa.Create;
    pessoa.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
  except

  end;
  try
    qry := pessoa.Excluir(erro);
    FRes.Send('Pessoa excluida').Status(200);
  finally
            FreeAndNil(pessoa)
  end;
end;
procedure TPessoaController.AdicionarPessoa;
var
  pessoa: TPessoa;
  erro: string;
  body: TJsonValue;
begin
  try
    pessoa := TPessoa.Create;
  except

  end;
  
  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FReq.Body),0) as TJsonValue;
      pessoa.SEQUENCIA := body.GetValue<Integer>('sequencia');
      pessoa.NOME := body.GetValue<string>('nome', '');
      pessoa.RG := body.GetValue<string>('rg', '');
      pessoa.CPF := body.GetValue<string>('cpf', '');
      pessoa.SEXO := body.GetValue<string>('sexo', '');
      pessoa.DATANASCIMENTO := body.GetValue<string>('datanascimento', '');
      pessoa.FOTO := body.GetValue<string>('foto', '');
      
      pessoa.Inserir(erro);
      
      body.Free;

      if erro <> '' then
      begin
        raise Exception.Create(erro);
      end
        
    finally

    end;
    FRes.Send('Pessoa Inserida').Status(200);
  finally
 FreeAndNil(pessoa)
  end;
end;

procedure TPessoaController.AlterarPessoa;
var
  pessoa: TPessoa;
  erro: string;
  body: TJsonValue;
begin
  try
    pessoa := TPessoa.Create;
  except

  end;
  
  try
    try
      pessoa.SEQUENCIA := FReq.Params['sequencia'].ToInteger;
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FReq.Body),0) as TJsonValue;
      pessoa.NOME := body.GetValue<string>('nome','');
      pessoa.RG := body.GetValue<string>('rg','');
      pessoa.CPF := body.GetValue<string>('cpf','');
      pessoa.SEXO := body.GetValue<string>('sexo','');
      pessoa.DATANASCIMENTO := body.GetValue<string>('datanascimento','');
      pessoa.FOTO := body.GetValue<string>('foto', '');
      pessoa.Editar(erro);
      
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
   FreeAndNil(pessoa)
  end;
end;


procedure Registry;
begin
//     THorse.Get('/pessoas', ListarPessoas);
//     THorse.Get('/pessoas/:sequencia', ListarPessoa);
//     THorse.Delete('/pessoas/:sequencia', DeletarPessoa);
//     THorse.Post('/pessoas', AdicionaPessoa);
//     THorse.Patch('/pessoas/:sequencia', AlteraPessoa);

    THorseGBSwaggerRegister.RegisterPath(TPessoaController);
end;

constructor TPessoaController.Create(Req: THorseRequest;
  Res: THorseResponse);
begin
  FReq := Req;
  FRes := Res;
end;
end.
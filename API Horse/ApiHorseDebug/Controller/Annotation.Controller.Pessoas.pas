//unit Annotation.Controller.Pessoas;
//
//interface
//
//uses
//  Horse,
//  Horse.GBSwagger,
//  GBSwagger.Path.Attributes,
//  GBSwagger.Validator.Interfaces,
//  Annotation.Classes,
//  Controller.Pessoas,
//  Model.Pessoas,
//  System.JSON;
//
//type
//  [SwagPath('pessoas', 'Pessoas')]
//  TPessoaController = class(THorseGBSwagger)
//  private
//    FRequest: THorseRequest;
//    FResponse: THorseResponse;
//
//  public
//    [SwagGET('Listar Pessoas', True)]
//    [SwagParamHeader('x-paginate','', true)]
//    [SwagParamQuery('limit', 'Tamanho da Pagina')]
//    [SwagParamQuery('page', 'Pagina')]
//    [SwagResponse(200, TPessoa, 'Modelo de Resposta', True)]
//    procedure GetUsers;
//
//    [SwagGET('{sequencia}', 'Encontrar Pessoa')]
//    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
//    [SwagResponse(200, TPessoa)]
//    [SwagResponse(404)]
//    procedure FindUser;
//
//    [SwagPOST('Inserir Usuário')]
//    [SwagParamBody('Dados', TPessoa)]
//    [SwagResponse(201, TPessoa)]
//    [SwagResponse(400)]
//    procedure InsertUser;
//
//    [SwagPatch('{sequencia}', 'Update user')]
//    [SwagParamPath('sequencia', 'Sequencia da Pessoa')]
//    [SwagParamBody('Dados', TPessoa)]
//    [SwagResponse(204)]
//    [SwagResponse(400)]
//    [SwagResponse(404)]
//    procedure UpdateUser;
//
//    [SwagDELETE('{sequencia}', 'Excluir Usuario')]
//    [SwagParamPath('sequencia', 'Sequencia do Usuario')]
//    [SwagResponse(204)]
//    [SwagResponse(400)]
//    [SwagResponse(404)]
//    procedure DeleteUser;
//
//    constructor Create(Req: THorseRequest; Res: THorseResponse);
//end;
//
//implementation
//
//{ TUserController }
//
//constructor TPessoaController.create(Req: THorseRequest; Res: THorseResponse);
//begin
//  FRequest := Req;
//  FResponse:= Res;
//end;
//
//procedure TPessoaController.DeleteUser;
//begin
//
//end;
//
////destructor TPessoaController.Destroy;
////begin
////
////  inherited;
////end;
//
//procedure TPessoaController.UpdateUser;
//begin
//
//end;
//
//procedure TPessoaController.FindUser;
//begin
//
//end;
//
//procedure TPessoaController.GetUsers;
//begin
//
//end;
//
//procedure TPessoaController.InsertUser;
//begin
//
//end;
//
//end.

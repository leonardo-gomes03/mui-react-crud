library apiHorseDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.Paginate,
  Horse.CORS,
  Horse.GBSwagger,
  Controller.Pessoas in 'Controller\Controller.Pessoas.pas',
  Model.Pessoas in 'Model\Model.Pessoas.pas' {/  Annotation.Controller.Pessoas in 'Controller\Annotation.Controller.Pessoas.pas',},
  Service.Pessoas in 'Service\Service.Pessoas.pas' {ServicePessoas: TDataModule};

procedure SwaggerConfig;
begin
    Swagger
    .Info
      .Title('Leonardo Treinamento')
      .Description('API Horse')
      .Contact
        .Name('Leonardo')
        .Email('leonardo@proansi.com.br')
      .&End
    .&End
    .AddProtocol(TGBSwaggerProtocol.gbHttp)
    .AddProtocol(TGBSwaggerProtocol.gbHttps)
end;
{$R *.res}

begin
  THorse
    .Use(Jhonson())
    .Use(CORS)
    .Use(Paginate)
    .Use(HorseSwagger)
    .Use(HorseBasicAuthentication(
    function (const AUsername, APassword: string):Boolean
    begin
      Result := AUsername.Equals('admin') and APassword.Equals('admin');
    end))
    ;


    SwaggerConfig;
    Controller.Pessoas.Registry;

    THorse.Listen(9000);
end.

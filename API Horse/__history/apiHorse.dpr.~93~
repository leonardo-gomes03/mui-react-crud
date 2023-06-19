program apiHorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.Paginate,
  Horse.CORS,
  Horse.GBSwagger,
  Controller.Pessoas in 'Controller\Controller.Pessoas.pas',
  Model.Connection in 'Model\Model.Connection.pas',
  Model.Pessoas in 'Model\Model.Pessoas.pas',
  Annotation.Controller.Pessoas in 'Controller\Annotation.Controller.Pessoas.pas',
  Annotation.Classes in 'Controller\Annotation.Classes.pas';


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
begin


//    HorseCORS
//     .AllowedOrigin('*')
//     .AllowedCredentials(true)
//     .AllowedHeaders('*')
//     .AllowedMethods('*')
//     .ExposedHeaders('*');

  THorse
    .Use(Jhonson())
    .Use(CORS)
    .Use(Paginate)
    .Use(HorseSwagger)
//    .Use(HorseBasicAuthentication(
//    function (const AUsername, APassword: string):Boolean
//    begin
//      Result := AUsername.Equals('admin') and APassword.Equals('admin');
//    end))
    ;


    SwaggerConfig;
    Controller.Pessoas.Registry;

    THorse.Listen(9000);
end.

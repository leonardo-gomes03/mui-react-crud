//unit Annotation.Classes;
//
//interface
//
//uses
//  GBSwagger.Model.Attributes;
//
//type
//  TUser = class
//  private
//    Fsequencia: Integer;
//    Fnome: String;
//    FlastName: string;
//    FbirthdayDate: TDateTime;
//    FlastUpdate: TDateTime;
//  public
//    [SwagProp('user id', True)]
//    property sequencia: Integer read Fsequencia write Fsequencia;
//
//    [SwagProp('User Description', True)]
//    property nome: String read Fnome write Fnome;
//
//    [SwagString(100)]
//    property lastName: string read FlastName write FlastName;
//    property birthdayDate: TDateTime read FbirthdayDate write FbirthdayDate;
//
//    [SwagIgnore]
//    property lastUpdate: TDateTime read FlastUpdate write FlastUpdate;
//  end;
//
//  TAPIError = class
//  private
//    Ferror: string;
//  public
//    property error: string read Ferror write Ferror;
//  end;
//
//implementation
//
//end.

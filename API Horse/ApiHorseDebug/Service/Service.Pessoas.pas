unit Service.Pessoas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DataSet.Serialize, System.JSON;

type
  TServicePessoas = class(TDataModule)
    Connection: TFDConnection;
    qryGet: TFDQuery;
    qryGetPessoa: TFDQuery;
    qryGetSEQUENCIA: TIntegerField;
    qryGetNOME: TStringField;
    qryGetRG: TStringField;
    qryGetCPF: TStringField;
    qryGetSEXO: TStringField;
    qryGetDATANASCIMENTO: TDateField;
    qryGetFOTO: TBlobField;
    qryGetPessoaSEQUENCIA: TIntegerField;
    qryGetPessoaNOME: TStringField;
    qryGetPessoaRG: TStringField;
    qryGetPessoaCPF: TStringField;
    qryGetPessoaSEXO: TStringField;
    qryGetPessoaDATANASCIMENTO: TDateField;
    qryGetPessoaFOTO: TBlobField;
    qryDelete: TFDQuery;
  private
    { Private declarations }
    Fsequencia: Integer;
    Fnome: string;
    Frg: string;
    Fcpf: string;
    Fsexo: string;
    Fdatanascimento : string;
    Ffoto: string;

  public
    { Public declarations }
     [SwagProp('sequencia', True)]
     property sequencia : Integer read Fsequencia write Fsequencia;

     [SwagProp('nome', True)]
     property nome : string read Fnome write Fnome;

     [SwagProp('rg', True)]
     property rg : string read Frg write Frg;

     [SwagProp('cpf', True)]
     property cpf : string read Fcpf write Fcpf;

     [SwagProp('sexo', True)]
     property sexo : string read Fsexo write Fsexo;

     [SwagProp('datanascimento', True)]
     property datanascimento : string read Fdatanascimento write Fdatanascimento;

     [SwagProp('foto', True)]
     property foto : string read Ffoto write Ffoto;



    function GetPessoas(order_by: string; out erro: string): TJSONArray;
    function GetPessoa(order_by: string; out erro: string): TJSONObject;
    function DeletePessoa(out erro: string): Boolean;
    function PostPessoa(out erro: string): Boolean;
    function PatchPessoa(out erro: string): Boolean;


  end;

var
  ServicePessoas: TServicePessoas;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}
//constructor TServicePessoas.Create;
//begin
//  inherited Create(nil);
//end;
{ TServicePessoas }

function TServicePessoas.DeletePessoa(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Connection;

        with qry do
        begin
            Active := false;
            SQL.Clear;
            SQL.Add('DELETE FROM PESSOAS WHERE SEQUENCIA=:SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;
            ExecSQL;
        end;

        qry.Free;
        erro := '';
        Result := true;

    except on ex:exception do
        begin
            erro := 'Erro ao excluir pessoa: ' + ex.Message;
            Result := false;
        end;
    end;
end;

function TServicePessoas.GetPessoas(order_by: string;
                                out erro: string): TJSONArray;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Connection;
        qry.Close;

        NOME := Uppercase(Copy(NOME,1,1))+Lowercase(Copy(NOME,2,Length(NOME)));

        with qry do
        begin
            SQL.Clear;
            SQL.Add('SELECT * FROM PESSOAS');
            SQL.Add('WHERE 1 = 1 ');

            if NOME <> '' then
              SQL.Add('AND NOME LIKE ' + QuotedStr('%' + NOME + '%'));

            if SEQUENCIA > 0 then
            begin
                SQL.Add('AND SEQUENCIA = :SEQUENCIA');
                ParamByName('SEQUENCIA').Value := SEQUENCIA;
            end;
            SQL.Add('ORDER BY SEQUENCIA');
        end;

        qry.Open;
        erro := '';
        Result := qry.ToJSONArray();
    except on ex:exception do
        begin
            erro := 'Erro ao consultar pessoas: ' + ex.Message;
            Result := nil;
        end;
    end;
end;


function TServicePessoas.GetPessoa(order_by: string;
                                out erro: string): TJSONObject;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Connection;
        qry.Close;

        with qry do
        begin
            if SEQUENCIA <= 0 then
            begin
              exit
            end;
            SQL.Clear;
            SQL.Add('SELECT * FROM PESSOAS');
            SQL.Add('WHERE SEQUENCIA = :SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;
            SQL.Add('ORDER BY SEQUENCIA');
        end;

        qry.Open;
        erro := '';
        Result := qry.ToJSONObject();
    except on ex:exception do
        begin
            erro := 'Erro ao consultar pessoa: ' + ex.Message;
            Result := nil;
        end;
    end;
end;

function TServicePessoas.PatchPessoa(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Valida
    if SEQUENCIA <= 0 then
    begin
        Result := false;
        erro := 'Sequencia invalida';
        exit;
    end;

    if (NOME + RG + CPF + SEXO + DATANASCIMENTO + FOTO) = '' then
    begin
        Result := false;
        erro := 'Requisi��o vazia';
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Connection;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('UPDATE PESSOAS SET ');


            if NOME <> '' then
            BEGIN
              SQL.Add(' NOME=:NOME, ');
              ParamByName('NOME').Value := NOME;
            END;

            if RG <> '' then
            BEGIN
              SQL.Add(' RG=:RG ,');
              ParamByName('RG').Value := RG;
            END;

            if CPF <> '' then
            BEGIN
              SQL.Add(' CPF=:CPF, ');
              ParamByName('CPF').Value := CPF;
            END;

            if SEXO <> '' then
            BEGIN
              SQL.Add(' SEXO=:SEXO, ');
              ParamByName('SEXO').Value := SEXO;
            END;

            if DATANASCIMENTO <> '' then
            BEGIN
              SQL.Add(' DATANASCIMENTO=:DATANASCIMENTO, ');
              ParamByName('DATANASCIMENTO').Value := DATANASCIMENTO;
            END;

            if FOTO <> '' then
            BEGIN
              SQL.Add(' FOTO=:FOTO, ');
              ParamByName('FOTO').Value := FOTO;
            END;

            SQL.Add(' SEQUENCIA=:SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;

            SQL.Add(' WHERE SEQUENCIA=:SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;

            ExecSQL;
        end;

        qry.Free;
        erro := '';
        result := true;

    except on ex:exception do
        begin
            erro := 'Erro ao alterar pessoa: ' + ex.Message;
            Result := false;
        end;
    end;
end;

function TServicePessoas.PostPessoa(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Validacoes...
    if NOME.IsEmpty then
    begin
        Result := false;
        erro := 'Informe o nome do cliente';
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Connection;

        with qry do
        begin

            SQL.Clear;
            SQL.Add('INSERT INTO PESSOAS(NOME, RG, CPF, SEXO, DATANASCIMENTO, FOTO) ');
            SQL.Add('VALUES(:NOME, :RG, :CPF, :SEXO, :DATANASCIMENTO, :FOTO)');

            ParamByName('NOME').Value := NOME;
            ParamByName('RG').Value := RG;
            ParamByName('CPF').Value := CPF;
            ParamByName('SEXO').Value := SEXO;
            ParamByName('DATANASCIMENTO').Value := DATE;
            ParamByName('FOTO').Value := FOTO;

            ExecSQL;

//            // Busca ID inserido...
//            Params.Clear;
//            SQL.Clear;
//            SQL.Add('SELECT MAX(SEQUENCIA) AS SEQUENCIA FROM PESSOAS');
//            SQL.Add('WHERE SEQUENCIA=:SEQUENCIA');
//            ParamByName('SEQUENCIA').Value := SEQUENCIA;
//            active := true;
//
//            SEQUENCIA := FieldByName('SEQUENCIA').AsInteger;
        end;

        qry.Free;
        erro := '';
        result := true;

    except on ex:exception do
        begin
            erro := 'Erro ao cadastrar pessoa: ' + ex.Message;
            Result := false;
        end;
    end;
end;

end.
unit Model.Pessoas;

interface

uses FireDAC.Comp.Client,System.JSON , DataSet.Serialize,
     Data.DB, System.SysUtils, Model.Connection, GBSwagger.Model.Attributes;

type
    TPessoa = class
    private
        Fsequencia: Integer;
        Fnome: string;
        Frg: string;
        Fcpf: string;
        Fsexo: string;
        Fdatanascimento : string;
        Ffoto: string;
    public
        constructor Create;
        destructor Destroy; override;

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

        function ListarPessoas(order_by: string; out erro: string): TJSONArray;
        function Inserir(out erro: string): Boolean;
        function Excluir(out erro: string): Boolean;
        function Editar(out erro: string): Boolean;
end;

implementation

{ TCliente }

constructor TPessoa.Create;
begin
    Model.Connection.Connect;
end;

destructor TPessoa.Destroy;
begin
    Model.Connection.Disconect;
end;

function TPessoa.Excluir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Model.Connection.FConnection;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('DELETE FROM PESSOAS WHERE SEQUENCIA=:SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;
            ExecSQL;
        end;

        qry.Free;
        erro := '';
        result := true;

    except on ex:exception do
        begin
            erro := 'Erro ao excluir pessoa: ' + ex.Message;
            Result := false;
        end;
    end;
end;

function TPessoa.Editar(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Valida
    if SEQUENCIA <= 0 then
    begin
        Result := false;
        erro := 'Informe a sequencia';
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
        qry.Connection := Model.Connection.FConnection;

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

function TPessoa.Inserir(out erro: string): Boolean;
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
        qry.Connection := Model.Connection.FConnection;

        with qry do
        begin

            SQL.Clear;
            SQL.Add('INSERT INTO PESSOAS(SEQUENCIA, NOME, RG, CPF, SEXO, DATANASCIMENTO, FOTO) ');
            SQL.Add('VALUES(:SEQUENCIA, :NOME, :RG, :CPF, :SEXO, :DATANASCIMENTO, :FOTO)');

            ParamByName('SEQUENCIA').Value := SEQUENCIA;
            ParamByName('NOME').Value := NOME;
            ParamByName('RG').Value := RG;
            ParamByName('CPF').Value := CPF;
            ParamByName('SEXO').Value := SEXO;
            ParamByName('DATANASCIMENTO').Value := DATE;
            ParamByName('FOTO').Value := FOTO;

            ExecSQL;

            // Busca ID inserido...
            Params.Clear;
            SQL.Clear;
            SQL.Add('SELECT MAX(SEQUENCIA) AS SEQUENCIA FROM PESSOAS');
            SQL.Add('WHERE SEQUENCIA=:SEQUENCIA');
            ParamByName('SEQUENCIA').Value := SEQUENCIA;
            active := true;

            SEQUENCIA := FieldByName('SEQUENCIA').AsInteger;
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

function TPessoa.ListarPessoas(order_by: string;
                                out erro: string): TJSONArray;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Model.Connection.FConnection;

        with qry do
        begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM PESSOAS WHERE 1 = 1 ');

            if SEQUENCIA > 0 then
            begin
                SQL.Add('AND SEQUENCIA = :SEQUENCIA');
                ParamByName('SEQUENCIA').Value := SEQUENCIA;
            end;
            SQL.Add('ORDER BY SEQUENCIA');
            Open;
        end;

        erro := '';
        Result := qry.ToJSONArray();
    except on ex:exception do
        begin
            erro := 'Erro ao consultar pessoas: ' + ex.Message;
            Result := nil;
        end;
    end;
end;

end.
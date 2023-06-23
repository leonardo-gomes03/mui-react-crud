unit Model.Pessoas;

interface

uses FireDAC.Comp.Client,System.JSON , DataSet.Serialize,
     Data.DB, System.SysUtils, GBSwagger.Model.Attributes;

type
    TPessoaGet = class
    private
        Fsequencia: Integer;
        Fnome: string;
        Frg: string;
        Fcpf: string;
        Fsexo: string;
        Fdatanascimento : string;
        Ffoto: string;
    public

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
    end;


type
    TPessoaPost = class
    private
        Fnome: string;
        Frg: string;
        Fcpf: string;
        Fsexo: string;
        Fdatanascimento : string;
        Ffoto: string;
    public

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
end;

implementation



end.
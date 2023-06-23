object ServicePessoas: TServicePessoas
  Height = 255
  Width = 390
  PixelsPerInch = 96
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Desenvolvimento\Treinamento_Leonardo\BD e SQL\TREINA' +
        'MENTO.FB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 32
    Top = 32
  end
  object qryGet: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from PESSOAS')
    Left = 128
    Top = 40
    object qryGetSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      Required = True
    end
    object qryGetNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryGetRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 11
    end
    object qryGetCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryGetSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object qryGetDATANASCIMENTO: TDateField
      FieldName = 'DATANASCIMENTO'
      Origin = 'DATANASCIMENTO'
    end
    object qryGetFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object qryGetPessoa: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM PESSOAS WHERE SEQUENCIA = :SEQUENCIA')
    Left = 232
    Top = 48
    ParamData = <
      item
        Name = 'SEQUENCIA'
        DataType = ftInteger
        ParamType = ptInput
        Size = 5
        Value = Null
      end>
    object qryGetPessoaSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      Required = True
    end
    object qryGetPessoaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryGetPessoaRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 11
    end
    object qryGetPessoaCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryGetPessoaSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object qryGetPessoaDATANASCIMENTO: TDateField
      FieldName = 'DATANASCIMENTO'
      Origin = 'DATANASCIMENTO'
    end
    object qryGetPessoaFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object qryDelete: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'delete from Pessoas where sequencia = :sequencia')
    Left = 208
    Top = 152
    ParamData = <
      item
        Name = 'SEQUENCIA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end

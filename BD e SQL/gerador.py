import random
from random import choices
from datetime import date, timedelta
import firebirdsql

conn = firebirdsql.connect(user='SYSDBA',password='masterkey',database='C:\Desenvolvimento\Treinamento_Leonardo\BD e SQL\TREINAMENTO.FB',host='localhost', charset='ANSI')
cur = conn.cursor()


## NOMES
nomes = 'Alice,Miguel,Sophia,Arthur,Júlia,Davi,Laura,Pedro,Isabella,Bernardo,Manuela,Gabriel,Luiza,Lucas,Helena,Matheus,Valentina,Heitor,Giovanna,Rafael,Maria Eduarda,Enzo,Beatriz,Nicolas,Maria Clara,Lorenzo,Maria Luiza,Guilherme,Heloísa,Samuel,Mariana,Theo,Lara,Felipe,Lívia,Gustavo,Lorena,Henrique,Ana Clara,João Pedro,Isadora,João Lucas,Rafaela,Daniel,Sarah,Murilo,Yasmin,Vitor,Ana Luiza,Pedro Henrique,Letícia,Eduardo,Nicole,Leonardo,Gabriela,Pietro,Isabelly,Benjamin,Melissa,Isaac,Cecília,João,Esther,Joaquim,Ana Júlia,Lucca,Emanuelly,Caio,Clara,Vinicius,Marina,Cauã,Rebeca,Bryan,Vitória,João Miguel,Isis,Vicente,Lavínia,Francisco,Maria,Antônio,Bianca,Benício,Ana Beatriz,João Vitor,Larissa,Enzo Gabriel,Maria Fernanda,Davi Lucas,Catarina,Davi Lucca,Alícia,Thiago,Maria Alice,Thomas,Amanda,Emanuel,Ana,Enrico'

nomeFormatado = nomes.split(',')

sobrenomes = 'da Silva,dos Santos,Pereira,Alves,Ferreira,de Oliveira,Silva,Rodrigues,de Souza,Gomes,Santos,Oliveira,Ribeiro,Martins,Gonçalves,Soares,Barbosa,Lopes,Vieira,Souza,Fernandes,Lima,Costa,Batista,Dias,Moreira,de Lima,de Sousa,Nunes,da Costa,de Almeida,Mendes,Carvalho,Araujo,Cardoso,Teixeira,Marques,do Nascimento,Almeida,Ramos,Machado,Rocha,Nascimento,de Araujo,da Conceiçao,Bezerra,Sousa,Borges,Santana,de Carvalho,Aparecido,Pinto,Pinheiro,Monteiro,Andrade,Leite,Correa,Nogueira,Garcia,de Freitas,Henrique,Tavares,Coelho,Pires,de Paula,Correia,Miranda,de Jesus,Duarte,Freitas,Barros,de Andrade,Campos,Sántos,de Melo,da Cruz,Reis,Guimaraes,Moraes,do Carmo,dos Reis,Viana,de Castro,Silveira,Moura,Brito,Neves,Carneiro,Melo,Medeiros,Cordeiro,Conceição,Farias,Dantas,Cavalcante,da Rocha,de Assis,Braga,Cruz,Siqueira'

sobrenomeFormatado = sobrenomes.split(',')

## RG
def rg():
  return str(int((random.random()) * (pow(10,8))))

## CPF
def cpf(): 
  return str(int((random.random()) * (pow(10,11))))

def gerarDia():
  test_date1, test_date2 = date(1960, 1, 1), date(2004, 12, 31)
    
  res_dates = [test_date1]
    
  while test_date1 != test_date2:
      test_date1 += timedelta(days=1)
      res_dates.append(test_date1)
    
  # random K dates from pack
  res = choices(res_dates)
  dataFormatada = str(res)
  dataFormatada = dataFormatada.strip('[datetime.date]()')
  dataFormatada = dataFormatada.split(',')
  dataFinal = ''
  for i in dataFormatada:
     i = i.strip(' ')
     dataFinal += i + '-'
  dataFinal = dataFinal.strip('-')
  return dataFinal

lista = []

# for nome in (nomeFormatado):
#     for sobrenome in (sobrenomeFormatado):
#       cpfAtual = cpf()
#       rgAtual = rg()
#       nomeCompleto = (nome + ' ' + sobrenome)
#       dadosCompletos = nomeCompleto, cpfAtual, rgAtual
#       lista.append(dadosCompletos)
i = 0
with open('lista.txt','w') as arquivo:
  for index, nome in enumerate(nomeFormatado):
    sexo = 'F'
    if (int(index) % 2) == 1:
      sexo = 'M'
    else: 
      sexo = 'F'
    
    for sobrenome in (sobrenomeFormatado):
      i += 1
      data = gerarDia()
      cpfAtual = cpf()
      rgAtual = rg()
      nomeCompleto = ("'" + nome + ' ' + sobrenome + "'")
      dadosCompletos = ("INSERT INTO PESSOAS (SEQUENCIA, NOME, RG, CPF, SEXO, DATANASCIMENTO) VALUES " + '(' + str(i) + ',' + nomeCompleto + ',' + "'" + rgAtual + "'" + ',' + "'" + cpfAtual + "'" + ',' + "'" + sexo + "'" + ',' + "'" + data + "'" + ")" + ';' '\n')
      cur.execute(dadosCompletos)
      conn.commit()
      print(dadosCompletos)
      arquivo.write(str(dadosCompletos))


conn.close
unit Form.Editar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Service.Pessoa;

type
  TFormEditar = class(TForm)
    editCPF: TEdit;
    editData: TEdit;
    editNome: TEdit;
    editRG: TEdit;
    editSexo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    submitButton: TButton;
    Fechar: TCornerButton;
    lblTitle: TLabel;
    procedure submitButtonClick(Sender: TObject);
    procedure FecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Sequencia: Integer;
    Nome: string;
    RG: string;
    CPF: string;
    Sexo: string;
    Data: string;
  end;

var
  FormEditar: TFormEditar;

implementation

{$R *.fmx}

procedure TFormEditar.submitButtonClick(Sender: TObject);
var
LService: TDataModule1;
begin
    if editNome.Text <> '' then
      Nome := editNome.Text;

    if editCPF.Text <> '' then
      CPF := editCPF.Text;

    if editRG.Text <> '' then
      RG := editRG.Text;

    if editSexo.Text <> '' then
      Sexo := editSexo.Text;

    if editData.Text <> '' then
      Data := editData.Text;


    LService.EditPessoa(Sequencia,Nome, RG, CPF, Sexo, Data);
    ShowMessage('Pessoa Editada');
    Close;
end;

procedure TFormEditar.FecharClick(Sender: TObject);
begin
Close;
end;

end.

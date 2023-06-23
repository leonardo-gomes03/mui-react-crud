unit FramePessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, Service.Pessoa, Form.Editar, FMX.Objects;

type
  TFPessoa = class(TFrame)
    lblSequencia: TLabel;
    lblNome: TLabel;
    lblRG: TLabel;
    lblCPF: TLabel;
    btnEditar: TButton;
    btnExcluir: TButton;
    lblData: TLabel;
    lblSexo: TLabel;
    Rectangle1: TRectangle;
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    end;

implementation

{$R *.fmx}
uses HeaderFooterTemplate;

procedure TFPessoa.btnEditarClick(Sender: TObject);
var
LForm: TFormEditar;
begin
  LForm := TFormEditar.Create(nil);
  LForm.Sequencia:=    lblSequencia.Text.ToInteger;
  LForm.Nome:=         lblNome.Text;
  LForm.RG:=           lblRG.Text;
  LForm.CPF:=          lblCPF.Text;
  LForm.Sexo:=         lblSexo.Text;
  LForm.Data:=         lblData.Text;

  LForm.lblTitle.Text := 'Editando: ' + lblNome.Text;
  LForm.editNome.Text:=  lblNome.Text;
  LForm.editRG.Text:=  lblRG.Text;
  LForm.editCPF.Text:=  lblCPF.Text;
  LForm.editSexo.Text:=  lblSexo.Text;
  LForm.editData.Text:=  lblData.Text;

  LForm.Show;
end;

procedure TFPessoa.btnExcluirClick(Sender: TObject);
var
  LService: TDataModule1;
begin
  LService.DeletePessoa(Self.lblSequencia.Text.ToInteger);
  ShowMessage('Pessoa Excluida');
end;


end.

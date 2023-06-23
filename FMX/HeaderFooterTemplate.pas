unit HeaderFooterTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FramePessoa, Service.Pessoa,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, DataSet.Serialize,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D,
  FMX.TabControl, FMX.Edit;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    vsbPessoas: TVertScrollBox;
    btnCadastrar: TButton;
    btnNext: TSpeedButton;
    btnPrevious: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Voltar: TCornerButton;
    editNome: TEdit;
    editRG: TEdit;
    editCPF: TEdit;
    editSexo: TEdit;
    editData: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    submitButton: TButton;
    procedure changePage(direction: integer);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure VoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure submitButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isEdit: Boolean;

  end;

var
  HeaderFooterForm: THeaderFooterForm;
  page: Integer;

implementation

{$R *.fmx}
uses System.Threading;


// Função trocar de pagina
procedure THeaderFooterForm.changePage(direction: integer);
var
LFrame: TFPessoa;
LService: TDataModule1;
I: Integer;
begin
  LService := TDataModule1.Create(Self);
  try
  vsbPessoas.BeginUpdate;


    if vsbPessoas.Content.ControlsCount > 0 then
    begin
      for I := vsbPessoas.Content.ChildrenCount - 1 downto 0 do
        TFPessoa(vsbPessoas.Content.Children[I]).DisposeOf;

    end;

    LService.ChangePage(direction);
    
    LService.mTable.First;
    while not LService.mTable.Eof do
    begin
      TThread.Synchronize(TThread.Current,
      procedure
      begin
        LFrame := TFPessoa.Create(vsbPessoas);
        LFrame.Parent := vsbPessoas;
        LFrame.Name :=  'TFrame1' + LService.mTable.RecNo.ToString;
        LFrame.Align := TAlignLayout.Top;
        LFrame.lblSequencia.Text :=  LService.mTable.FieldByName('sequencia').AsString;
        LFrame.lblNome.Text :=       LService.mTable.FieldByName('nome').AsString;
        LFrame.lblRG.Text :=         LService.mTable.FieldByName('rg').AsString;
        LFrame.lblCPF.Text :=        LService.mTable.FieldByName('cpf').AsString;
        LFrame.lblSexo.Text :=       LService.mTable.FieldByName('sexo').AsString;
        LFrame.lblData.Text  :=      LService.mTable.FieldByName('datanascimento').AsString;



      end);
      LService.mTable.Next;
    end;
  finally
    vsbPessoas.EndUpdate;
    LService.Free;
  end;
end;


// Carrega lista na inicialização
procedure THeaderFooterForm.FormShow(Sender: TObject);
var
LFrame: TFPessoa;
LService: TDataModule1;
I: Integer;
begin
  LService := TDataModule1.Create(Self);
  try
    vsbPessoas.BeginUpdate;

    if vsbPessoas.Content.ControlsCount > 0 then
    begin
      for I := vsbPessoas.Content.ChildrenCount - 1 downto 0 do
        TFPessoa(vsbPessoas.Content.Children[I]).DisposeOf;

    end;


    LService.GetPessoas;


    LService.mTable.First;
    while not LService.mTable.Eof do
    begin
      TThread.Synchronize(TThread.Current,
      procedure
      begin
        LFrame := TFPessoa.Create(vsbPessoas);
        LFrame.Parent := vsbPessoas;
        LFrame.Name :=  'TFrame1' + LService.mTable.RecNo.ToString;
        LFrame.Align := TAlignLayout.Top;
        LFrame.lblSequencia.Text :=  LService.mTable.FieldByName('sequencia').AsString;
        LFrame.lblNome.Text :=       LService.mTable.FieldByName('nome').AsString;
        LFrame.lblRG.Text :=         LService.mTable.FieldByName('rg').AsString;
        LFrame.lblCPF.Text :=        LService.mTable.FieldByName('cpf').AsString;
        LFrame.lblSexo.Text :=       LService.mTable.FieldByName('sexo').AsString;
        LFrame.lblData.Text  :=      LService.mTable.FieldByName('datanascimento').AsString;
      end);
      LService.mTable.Next;
    end;
  finally
    vsbPessoas.EndUpdate;
    LService.Free;
    page := 1;
  end;
end;



// Botao volta para tela de Listagem
procedure THeaderFooterForm.VoltarClick(Sender: TObject);
begin
  TabControl1.ActiveTab := (TabItem1);
end;

// Botao proxima pagina
procedure THeaderFooterForm.btnNextClick(Sender: TObject);
begin
page := page + 1;
changePage(page)
end;

// Botao pagina anterior
procedure THeaderFooterForm.btnPreviousClick(Sender: TObject);
begin
  page := page - 1;

  if page < 1 then
    page := 1;

  changePage(page)
end;


// Botão ir para Cadastro
procedure THeaderFooterForm.btnCadastrarClick(Sender: TObject);
begin
  TabControl1.ActiveTab := (TabItem2);
end;

// Botão de Submit
procedure THeaderFooterForm.submitButtonClick(Sender: TObject);
var
LService: TDataModule1;
begin

    LService.PostPessoa(editNome.Text, editRG.Text, editCPF.Text, editSexo.Text, editData.Text);
    ShowMessage('Pessoa Inserida');
    TabControl1.ActiveTab := TabItem1;

end;

end.

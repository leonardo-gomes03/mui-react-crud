program HeaderFooterApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  HeaderFooterTemplate in 'HeaderFooterTemplate.pas' {HeaderFooterForm},
  FramePessoa in 'FramePessoa.pas' {FPessoa: TFrame},
  Service.Pessoa in 'Service.Pessoa.pas' {DataModule1: TDataModule},
  Form.Editar in 'Form.Editar.pas' {FormEditar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THeaderFooterForm, HeaderFooterForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormEditar, FormEditar);
  Application.Run;
end.

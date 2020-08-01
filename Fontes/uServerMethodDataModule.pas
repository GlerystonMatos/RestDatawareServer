unit uServerMethodDataModule;

interface

uses
  System.Classes, UDWDatamodule, uDWAbout, uRESTDWServerEvents, uDWJSONObject,
  JSON, System.SysUtils, uDWConsts;

type
  TdmServerMethodDataModule = class(TServerMethodDataModule)
    DWServerEvents: TDWServerEvents;
    procedure DWServerEventsEventsEcoReplyEvent(var Params: TDWParams; var Result: string);
    procedure DWServerEventsEventsSomaReplyEvent(var Params: TDWParams; var Result: string);
    procedure DWServerEventsEventsUsuarioReplyEventByType(var Params: TDWParams; var Result: string; const RequestType: TRequestType; var StatusCode: Integer; RequestHeader: TStringList);
  private
    function UsuarioGet(var Params: TDWParams): string;
    function UsuarioPost(var Params: TDWParams): string;
    function UsuarioPut(var Params: TDWParams): string;
    function UsuarioDelete(var Params: TDWParams): string;
  public
    { Public declarations }
  end;

var
  dmServerMethodDataModule: TdmServerMethodDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmServerMethodDataModule.DWServerEventsEventsEcoReplyEvent(var Params: TDWParams; var Result: string);
var
  value: string;
  objeto: TJSONObject;
begin
  value := '';
  if (Assigned(Params.ItemsString['value'])) then
    value := Params.ItemsString['value'].Asstring;

  objeto := TJSONObject.Create;
  objeto.AddPair(TJSONPair.Create('result', value));
  Result := objeto.ToString;
end;

procedure TdmServerMethodDataModule.DWServerEventsEventsSomaReplyEvent(var Params: TDWParams; var Result: string);
var
  objeto: TJSONObject;
  value01: Integer;
  value02: Integer;
begin
  value01 := 0;
  if (Assigned(Params.ItemsString['value01'])) then
    value01 := Params.ItemsString['value01'].AsInteger;

  value02 := 0;
  if (Assigned(Params.ItemsString['value02'])) then
    value02 := Params.ItemsString['value02'].AsInteger;

  objeto := TJSONObject.Create;
  objeto.AddPair(TJSONPair.Create('result', IntToStr((value01 + value02))));
  Result := objeto.ToString;
end;

procedure TdmServerMethodDataModule.DWServerEventsEventsUsuarioReplyEventByType(var Params: TDWParams; var Result: string; const RequestType: TRequestType; var StatusCode: Integer; RequestHeader: TStringList);
begin
  case (RequestType) of
    rtGet:
      Result := UsuarioGet(Params);
    rtPost:
      Result := UsuarioPost(Params);
    rtPut:
      Result := UsuarioPut(Params);
    rtDelete:
      Result := UsuarioDelete(Params);
  end;
end;

function TdmServerMethodDataModule.UsuarioGet(var Params: TDWParams): string;
var
  lista: TJSONArray;
  objeto01: TJSONObject;
  objeto02: TJSONObject;
  objeto03: TJSONObject;
begin
  lista := TJSONArray.Create;

  objeto01 := TJSONObject.Create;
  objeto01.AddPair(TJSONPair.Create('nome', 'Snoopy'));
  objeto01.AddPair(TJSONPair.Create('senha', '123465'));
  lista.AddElement(objeto01);

  objeto02 := TJSONObject.Create;
  objeto02.AddPair(TJSONPair.Create('nome', 'Lola'));
  objeto02.AddPair(TJSONPair.Create('senha', '654321'));
  lista.AddElement(objeto02);

  objeto03 := TJSONObject.Create;
  objeto03.AddPair(TJSONPair.Create('nome', 'Tobias'));
  objeto03.AddPair(TJSONPair.Create('senha', '456123'));
  lista.AddElement(objeto03);

  Result := lista.ToString;
end;

function TdmServerMethodDataModule.UsuarioPost(var Params: TDWParams): string;
var
  dados: TJSONObject;
  objeto: TJSONObject;
  usuario: string;
  senha: string;
begin
  if (Assigned(Params.ItemsString['Undefined'])) then
  begin
    dados := TJSONObject.ParseJSONValue(Params.ItemsString['Undefined'].AsString) as TJSONObject;
    objeto := TJSONObject.Create;

    usuario := '';
    if (not dados.GetValue('nome').Null) then
      usuario := dados.GetValue('nome').value;

    senha := '';
    if (not dados.GetValue('senha').Null) then
      senha := dados.GetValue('senha').value;

    objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + usuario + ' com a senha ' + senha + ', foi criado com sucesso'));
    Result := objeto.ToString;
  end
  else
  begin
    Result := '';
  end;
end;

function TdmServerMethodDataModule.UsuarioPut(var Params: TDWParams): string;
var
  dados: TJSONObject;
  objeto: TJSONObject;
  usuario: string;
  senha: string;
begin
  if (Assigned(Params.ItemsString['Undefined'])) then
  begin
    dados := TJSONObject.ParseJSONValue(Params.ItemsString['Undefined'].AsString) as TJSONObject;
    objeto := TJSONObject.Create;

    usuario := '';
    if (not dados.GetValue('nome').Null) then
      usuario := dados.GetValue('nome').value;

    senha := '';
    if (not dados.GetValue('senha').Null) then
      senha := dados.GetValue('senha').value;

    objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + usuario + ' com a senha ' + senha + ', foi atualizado com sucesso'));
    Result := objeto.ToString;
  end
  else
  begin
    Result := '';
  end;
end;

function TdmServerMethodDataModule.UsuarioDelete(var Params: TDWParams): string;
var
  objeto: TJSONObject;
  value: string;
begin
  value := '';
  if (Assigned(Params.ItemsString['nome'])) then
    value := Params.ItemsString['nome'].Asstring;

  objeto := TJSONObject.Create;
  objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + value + ' exclu�do com sucesso'));
  Result := objeto.ToString;
end;

end.

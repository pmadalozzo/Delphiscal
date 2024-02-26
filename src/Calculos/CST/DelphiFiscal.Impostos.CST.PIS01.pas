unit DelphiFiscal.Impostos.CST.PIS01;

interface

uses
  DelphiFiscal.CST.Interfaces,
  DelphiFiscal.Controller.Interfaces;

type
  TPIS01 = class(TInterfacedObject, iPIS01)
    private
      [weak]
      FParent : iController;
    public
      constructor Create(Parent : iController);
      destructor Destroy; override;
      class function New(Parent : iController) : iPIS01;
      function BasePis: Double;
      function ValorPis: Double;
      function ValorPisEspecifico: Double;
      Function &End : iController;
  end;

implementation

{ TPIS01 }

uses Delphiscal.Utils;

function TPIS01.BasePis: Double;
begin
  result:= RoundABNT(((FParent.Base.ValorProduto +
                       FParent.Base.ValorFrete +
                       FParent.Base.ValorSeguro +
                       FParent.Base.ValorDespesasAcessorias) -
                       FParent.Base.ValorDescontos), 2);
end;

constructor TPIS01.Create(Parent: iController);
begin
  FParent:= Parent;
end;

destructor TPIS01.Destroy;
begin

  inherited;
end;

function TPIS01.&End: iController;
begin
  Result:= FParent;
end;

class function TPIS01.New(Parent: iController): iPIS01;
begin
  Result:= Self.Create(Parent);
end;

function TPIS01.ValorPis: Double;
begin
  Result := RoundABNT(BasePis * (FParent.PIS.AliquotaPIS / 100), 2);
end;

function TPIS01.ValorPisEspecifico: Double;
begin
  Result := RoundABNT((FParent.PIS.QtdePISTributada *
                       FParent.PIS.ValorPISPorUnidade), 2);
end;

end.


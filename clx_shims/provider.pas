unit Provider;
{$mode delphi}
interface
uses Classes, DB;

type
  TResolverResponse = (rrSkip, rrAbort, rrMerge, rrApply, rrIgnore);

  EUpdateError = class(EDatabaseError)
  end;

  TDataSetProvider = class(TComponent)
  private
    FDataSet: TDataSet;
  published
    property DataSet: TDataSet read FDataSet write FDataSet;
  end;

implementation
end.

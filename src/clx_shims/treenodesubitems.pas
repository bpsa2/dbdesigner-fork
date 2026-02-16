unit TreeNodeSubItems;
{$mode delphi}
interface

uses Classes, SysUtils, ComCtrls;

type
  TTreeNodeHelper = class helper for TTreeNode
  private
    function GetSubItems: TStringList;
  public
    property SubItems: TStringList read GetSubItems;
  end;

  // Also provide Item[] indexed access for child nodes
  // CLX TTreeNode had Item[index] to access children

implementation

{ We store a TStringList in the TTreeNode.Data pointer. 
  WARNING: This means the original Data pointer usage must be adapted.
  For this project, Data is also used to store TDBHost/TDBConn objects.
  We'll use a wrapper record to hold both. }

type
  PNodeExtra = ^TNodeExtra;
  TNodeExtra = record
    OrigData: Pointer;
    SubItems: TStringList;
  end;

function GetOrCreateExtra(Node: TTreeNode): PNodeExtra;
begin
  // We tag the extra record by checking if Data is our allocated record
  // This is fragile - but needed for compatibility
  // We'll store the extra in a global dictionary keyed by node pointer
  Result := nil;
end;

// Simpler approach: use a global TFPList to track allocations
var
  NodeExtras: TStringList; // maps IntToStr(PtrUInt(Node)) -> PNodeExtra

function FindExtra(Node: TTreeNode): PNodeExtra;
var idx: Integer;
begin
  Result := nil;
  if NodeExtras = nil then
    NodeExtras := TStringList.Create;
  idx := NodeExtras.IndexOf(IntToStr(PtrUInt(Node)));
  if idx >= 0 then
    Result := PNodeExtra(NodeExtras.Objects[idx]);
end;

function EnsureExtra(Node: TTreeNode): PNodeExtra;
var idx: Integer;
    key: string;
begin
  if NodeExtras = nil then
    NodeExtras := TStringList.Create;
  key := IntToStr(PtrUInt(Node));
  idx := NodeExtras.IndexOf(key);
  if idx >= 0 then
    Result := PNodeExtra(NodeExtras.Objects[idx])
  else
  begin
    New(Result);
    Result^.OrigData := nil;
    Result^.SubItems := TStringList.Create;
    NodeExtras.AddObject(key, TObject(Result));
  end;
end;

function TTreeNodeHelper.GetSubItems: TStringList;
begin
  Result := EnsureExtra(Self)^.SubItems;
end;

initialization
  NodeExtras := nil;

finalization
  if NodeExtras <> nil then
  begin
    // Clean up
    NodeExtras.Free;
  end;

end.

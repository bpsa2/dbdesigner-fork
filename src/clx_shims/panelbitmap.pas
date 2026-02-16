unit PanelBitmap;
{$mode delphi}
interface

uses Classes, SysUtils, Graphics, ExtCtrls, Contnrs;

type
  TPanelHelper = class helper for TPanel
  private
    function GetBitmap: TBitmap;
    procedure SetBitmap(Value: TBitmap);
  public
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
  end;

implementation

var
  PanelBitmaps: TFPHashList;

function PanelKey(Panel: TPanel): string;
begin
  Result := IntToStr(PtrUInt(Panel));
end;

function TPanelHelper.GetBitmap: TBitmap;
var
  idx: Integer;
begin
  if PanelBitmaps = nil then
    PanelBitmaps := TFPHashList.Create;
  idx := PanelBitmaps.FindIndexOf(PanelKey(Self));
  if idx >= 0 then
    Result := TBitmap(PanelBitmaps.Items[idx])
  else
  begin
    Result := TBitmap.Create;
    PanelBitmaps.Add(PanelKey(Self), Result);
  end;
end;

procedure TPanelHelper.SetBitmap(Value: TBitmap);
var
  idx: Integer;
  key: string;
  existing: TBitmap;
begin
  if PanelBitmaps = nil then
    PanelBitmaps := TFPHashList.Create;
  key := PanelKey(Self);
  idx := PanelBitmaps.FindIndexOf(key);
  if Value = nil then
  begin
    if idx >= 0 then
    begin
      existing := TBitmap(PanelBitmaps.Items[idx]);
      PanelBitmaps.Delete(idx);
      existing.Free;
    end;
  end
  else
  begin
    if idx >= 0 then
    begin
      existing := TBitmap(PanelBitmaps.Items[idx]);
      existing.Assign(Value);
    end
    else
    begin
      existing := TBitmap.Create;
      existing.Assign(Value);
      PanelBitmaps.Add(key, existing);
    end;
  end;
end;

initialization
  PanelBitmaps := nil;

finalization
  if PanelBitmaps <> nil then
    PanelBitmaps.Free;

end.

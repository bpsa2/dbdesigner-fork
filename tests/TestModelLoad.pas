program TestModelLoad;

{$mode delphi}
{$H+}

uses
  {$IFDEF UNIX}cthreads,{$ENDIF}
  Classes, SysUtils, LibXmlParser;

var
  Parser: TXmlParser;
  TableCount: Integer;
  TableName: string;
begin
  WriteLn('=== DBDesigner Fork Model Load Test ===');
  WriteLn;
  
  if not FileExists('bin/Examples/order.xml') then
  begin
    WriteLn('ERROR: bin/Examples/order.xml not found');
    WriteLn('Run from the project root directory');
    Halt(1);
  end;
  
  Parser := TXmlParser.Create;
  try
    Parser.LoadFromFile('bin/Examples/order.xml');
    Parser.StartScan;
    
    TableCount := 0;
    
    while Parser.Scan do
    begin
      if (Parser.CurPartType = ptStartTag) then
      begin
        if (Parser.CurName = 'DBMODEL') then
          WriteLn('Model format version: ', Parser.CurAttr.Value('Version'));
          
        if (Parser.CurName = 'TABLE') then
        begin
          Inc(TableCount);
          TableName := Parser.CurAttr.Value('Tablename');
          WriteLn('  Table ', TableCount, ': ', TableName);
        end;
        
        if (Parser.CurName = 'GLOBALSETTINGS') then
        begin
          WriteLn('Model name: ', Parser.CurAttr.Value('ModelName'));
          WriteLn('Database type: ', Parser.CurAttr.Value('DatabaseType'));
        end;
      end;
    end;
    
    WriteLn;
    WriteLn('Total tables found: ', TableCount);
    
    if TableCount > 0 then
    begin
      WriteLn;
      WriteLn('SUCCESS: Model loaded and parsed correctly!');
    end
    else
    begin
      WriteLn;
      WriteLn('WARNING: No tables found in model');
      Halt(1);
    end;
    
  finally
    Parser.Free;
  end;
end.

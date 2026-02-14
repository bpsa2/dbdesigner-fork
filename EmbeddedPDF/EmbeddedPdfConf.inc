{$IFDEF FPC}
  {.$DEFINE USE_CLX}  // Disabled for FPC/LCL
{$ELSE}
  {$DEFINE USE_CLX}
{$ENDIF}

// if use "FlateDecode" compression, comment out the next line.
// (this unit and PdfTypes.pas)
{.$DEFINE NOZLIB}

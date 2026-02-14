# Notes to Myself - DBDesigner Fork CLX→LCL Port

## Current Status (Latest)
- **Project compiles successfully** with Free Pascal/Lazarus
- **SynEdit enabled** - SQL syntax highlighting works
- **49 warnings remaining** - mostly cosmetic (destructor visibility, uninitialized vars)
- **Binary**: 36MB+ ELF x86-64 in `bin/DBDesignerFork`

## Architecture
- **Shim approach**: `clx_shims/` directory with 30+ compatibility units
- Key shims: `Qt.pas`, `SqlExpr.pas` (wraps SQLDB), `DBClient.pas` (wraps BufDataset), `Provider.pas`, `PanelBitmap.pas`, `TreeNodeSubItems.pas`

## Git Commits Made
1. Phase 0: Project setup, shims, .xfm→.lfm conversion
2. Phase 1: Bulk CLX→LCL unit name replacements
3. Phase 2: Compilation error fixes (many iterations)
4. Phase 4: SynEdit re-enabled with SynEditTypes added
5. .lfm fixes: BorderStyle (fbs→bs), clBackground→clBtnFace, fcsLatin1→0, MaxBlobSize removed, SQLConnection→Database
6. RegisterClass calls for shim components
7. Deprecation fixes: DecimalSeparator, Thread.Resume→Start

## .lfm Files Status
- All 34+ .lfm files converted from CLX format
- BorderStyle values fixed (fbsToolWindow→bsToolWindow etc)
- clBackground→clBtnFace
- Font.CharSet CLX values→numeric
- AutoScroll removed
- DB component properties fixed (MaxBlobSize removed, SQLConnection→Database)
- Classes registered: TSQLConnection, TSQLDataSet, TSQLMonitor, TClientDataSet, TDataSetProvider

## Key Disabled Features
- `USE_IXMLDBMODELType` - Not needed! LoadFromFile2/SaveToFile2 use TXmlParser instead
- `USE_QTheming` - Windows-only, not applicable

## Known Runtime Risks
1. Screen.SystemFont assignment in LoadApplicationFont may fail (read-only in LCL)
2. Some stubs are no-ops (SaveBitmap, Application.OnEvent)
3. TPanel.Bitmap usage commented out in EditorQueryDragTarget.pas
4. TTreeNode.SubItems via class helper - untested at runtime
5. TSQLConnection shim wraps TSQLConnector - DB connectivity untested

## Remaining Warnings (49)
- 13x "Destructor should be public" in EERModel.pas
- 4x "An inherited method is hidden" in EERModel.pas  
- 4x "Local variable not initialized" in EERModel.pas
- 2x "Destructor should be public" in DBDM.pas
- 2x "Class types not related" in DBConnSelect.pas (TListItem/TTreeNode cast)
- 1x "Function result not set" in MainDM.pas
- Various string type conversion warnings

## Next Steps
1. Test runtime (needs display/X11)
2. Fix remaining warnings (destructor visibility, uninitialized vars)
3. Test DB connectivity with MySQL via SQLDB
4. Fix Screen.SystemFont for LCL compatibility
5. Consider re-enabling TPanel.Bitmap via class helper

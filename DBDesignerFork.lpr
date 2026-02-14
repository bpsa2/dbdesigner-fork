
program DBDesignerFork;

//----------------------------------------------------------------------------------------------------------------------
//
// This file is part of DBDesigner Fork which is forked from DBDesigner 4.
// Lazarus/FPC port.
//
//----------------------------------------------------------------------------------------------------------------------

{$I DBDesigner4.inc}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // LCL widgetset
  Forms,

//-------------------------------------------------------------
// Include all units

  Main in 'Main.pas' {MainForm},
  MainDM in 'MainDM.pas' {DMMain: TDataModule},
  Splash in 'Splash.pas' {SplashForm},
  EER in 'EER.pas' {EERForm},
  PaletteTools in 'PaletteTools.pas' {PaletteToolsForm},
  EERModel in 'EERModel.pas',
  ZoomSel in 'ZoomSel.pas' {ZoomSelForm},
  PaletteModel in 'PaletteModel.pas' {PaletteModelFrom},
  PaletteDatatypes in 'PaletteDatatypes.pas' {PaletteDataTypesForm},
  EditorTable in 'EditorTable.pas' {EditorTableForm},
  EditorDatatype in 'EditorDatatype.pas' {EditorDatatypeForm},
  EditorString in 'EditorString.pas' {EditorStringForm},
  EditorRegion in 'EditorRegion.pas' {EditorRegionForm},
  EditorNote in 'EditorNote.pas' {EditorNoteForm},
  OptionsModel in 'OptionsModel.pas' {OptionsModelForm},
  EditorRelation in 'EditorRelation.pas' {EditorRelationForm},
  Options in 'Options.pas' {OptionsForm},
  EERPageSetup in 'EERPageSetup.pas' {EERPageSetupForm},
  PaletteNav in 'PaletteNav.pas' {PaletteNavForm},
  EditorImage in 'EditorImage.pas' {EditorImageForm},
  EERExportSQLScript in 'EERExportSQLScript.pas' {EERExportSQLScriptFrom},
  DBConnSelect in 'DBConnSelect.pas' {DBConnSelectForm},
  PaletteDataTypesReplace in 'PaletteDataTypesReplace.pas' {PaletteDataTypesReplaceForm},
  EERReverseEngineering in 'EERReverseEngineering.pas' {EERReverseEngineeringForm},
  EERSynchronisation in 'EERSynchronisation.pas' {EERSynchronisationForm},
  DBConnEditor in 'DBConnEditor.pas' {DBConnEditorForm},
  DBConnLogin in 'DBConnLogin.pas' {DBConnLoginForm},
  EERStoreInDatabase in 'EERStoreInDatabase.pas' {EERStoreInDatabaseForm},
  EERDM in 'EERDM.pas' {DMEER: TDataModule},
  EditorTableField in 'EditorTableField.pas',
  EditorTableFieldDatatypeInplace in 'EditorTableFieldDatatypeInplace.pas',
  GUIDM in 'GUIDM.pas' {DMGUI: TDataModule},
  DBDM in 'DBDM.pas' {DMDB: TDataModule},
  DBEERDM in 'DBEERDM.pas' {DMDBEER: TDataModule},
  EditorTableFieldParam in 'EditorTableFieldParam.pas' {EditorTableFieldParamForm},
  Tips in 'Tips.pas' {TipsForm},
  EditorQuery in 'EditorQuery.pas' {EditorQueryForm},
  EditorQueryDragTarget in 'EditorQueryDragTarget.pas' {EditorQueryDragTargetForm},
  EERExportImportDM in 'EERExportImportDM.pas',

//-------------------------------------------------------------
// Include SynEdit if USE_SYNEDIT is defined
// Lazarus SynEdit package is used instead of bundled QSynEdit

{$IFDEF USE_SYNEDIT}
  // SynEdit units are provided by the Lazarus SynEdit package
{$ENDIF}

//-------------------------------------------------------------
// Include EmbeddedPDF

  EmbeddedPdfDoc in 'EmbeddedPDF/EmbeddedPdfDoc.pas',
  EmbeddedPdfFonts in 'EmbeddedPDF/EmbeddedPdfFonts.pas',
  EmbeddedPdfTypes in 'EmbeddedPDF/EmbeddedPdfTypes.pas',
  EmbeddedPdfImages in 'EmbeddedPDF/EmbeddedPdfImages.pas',
  EmbeddedPdfDB in 'EmbeddedPDF/EmbeddedPdfDB.pas',

//-------------------------------------------------------------
// Include XML model support if USE_IXMLDBMODELType is defined

{$IFDEF USE_IXMLDBMODELType}
  EERModel_XML_ERwin41_Import in 'EERModel_XML_ERwin41_Import.pas',
  EERModel_XML in 'EERModel_XML.pas',
{$ENDIF}

//-------------------------------------------------------------
// Include the new LibXmlParser

  LibXmlParser in 'LibXmlParser.pas',

  EERPlaceModel in 'EERPlaceModel.pas',
  // RegExpr, // using system regexpr
  GlobalSysFunctions in 'GlobalSysFunctions.pas',
  UITestRunner in 'UITestRunner.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DBDesigner Fork';

  //Initialize Application Font
  LoadApplicationFont;

  //Show Splash Form
  //SplashForm:=TSplashForm.Create(Application);
  //SplashForm.VersionLbl.Caption:='1.5';
  //SplashForm.Show;
  //SplashForm.Update;

  Application.ShowMainForm := False;
  Application.CreateForm(TMainForm, MainForm);
  //Bring Splash Screen back to top again...
  //SplashForm.BringToFront;

  Application.Run;
end.

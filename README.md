
# DBDesigner Fork

**DBDesigner Fork** is an open-source visual database design and modeling tool (Entity-Relationship / EER diagram editor). It is a community fork of the original **DBDesigner 4**, created by fabFORCE (Mike).

![License: GPL v2](https://img.shields.io/badge/License-GPLv2-blue.svg)

## Overview

DBDesigner Fork provides a full-featured graphical environment for designing and managing relational database schemas. It allows you to visually create Entity-Relationship diagrams and generate SQL scripts, reverse-engineer existing databases, and much more.

## Key Facts

| Aspect | Details |
|---|---|
| **Language** | Object Pascal (Free Pascal / Lazarus LCL) — originally Delphi 7 / CLX |
| **License** | GNU General Public License v2 (GPLv2) |
| **Original** | DBDesigner 4 (v4.0.2.92) by fabFORCE |
| **Fork versions** | Fork 1.0 (Sep 2006) → Fork 1.5 (Oct 2010) |
| **Original platforms** | Windows (Delphi 7) and Linux (Kylix 3) |
| **Current platform** | Linux (Lazarus/FPC) — Windows and macOS possible |
| **Codebase size** | ~175,000 lines of Pascal source code |

## Features

- **Visual database modeling** — Design Entity-Relationship (EER) diagrams with tables, fields, relations (1:1, 1:n, n:m), regions, notes, and images.
- **SQL script export** — Generate CREATE TABLE scripts from the visual model.
- **Reverse engineering** — Import existing database schemas into visual models.
- **Database connectivity** — Connect to MySQL, Oracle, MS SQL Server, SQLite, and ODBC databases.
- **XML model storage** — Models are saved as XML files; also supports ERwin 4.1 import.
- **Query editor** — Visual SQL query builder with drag-and-drop.
- **Synchronization** — Sync models with live databases.
- **PDF generation** — Embedded PDF export of diagrams.
- **Plugin system** — Extensible via plugins (HTML Report, Data Importer, Simple Web Front-end, etc.).
- **Multi-language support** — Translation files for internationalization.

## Project Structure

```
DBDesignerFork/
├── *.pas, *.xfm          # Core application source (main form, EER model engine,
│                          #   editors, palettes, options, etc.)
├── DBDesignerFork.dpr     # Main Delphi project file
├── EmbeddedPDF/           # Built-in PDF document generation library
├── SynEdit/               # Syntax-highlighting text editor component (for SQL editing)
├── Plugins/               # Plugin projects
│   ├── DataImporter/      #   - Data import tool
│   ├── Demo/              #   - Demo/example plugin
│   ├── HTMLReport/        #   - HTML report generator
│   └── SimpleWebFront/    #   - Simple web front-end generator
├── bin/                   # Runtime files
│   ├── Data/              #   - Configuration, settings, translations
│   ├── Doc/               #   - User documentation (HTML + PDF manual)
│   ├── Examples/          #   - Example model files (XML)
│   ├── Gfx/              #   - Graphics: cursors, icons, table bitmaps, splash screen
│   └── dbxoodbc/          #   - Open ODBC DBExpress driver
├── dcu/                   # Compiled unit output directory
└── test-base/             # Test XML models and SQL export reference files
```

## Original Build Instructions

### Windows
- **Requirements:** Delphi 7 (Professional or Enterprise)
- Open `DBDesignerFork.dpr` in Delphi, configure output directories, and build.

### Linux
- **Requirements:** Kylix 3 (Professional or Enterprise)
- Open the project in Kylix, configure output directories, and build.

See [`_How to compile DBDesigner4.txt`](_How%20to%20compile%20DBDesigner4.txt) for detailed original instructions.

## 🚀 Porting to Free Pascal / Lazarus

**The primary goal of this repository is to port DBDesigner Fork from Delphi/Kylix to [Free Pascal (FPC)](https://www.freepascal.org/) and the [Lazarus IDE](https://www.lazarus-ide.org/).**

### Why?

- **Delphi 7 and Kylix 3 are long discontinued.** Building the original source requires proprietary, legacy tools that are increasingly difficult to obtain and run on modern systems.
- **Free Pascal and Lazarus are free, open-source, and actively maintained.** They support Windows, Linux, macOS, and many other platforms — a natural fit for a GPLv2 project.
- **Preserve and modernize a valuable tool.** DBDesigner Fork remains useful for database design, and porting it ensures it can continue to be built, improved, and used by the community.

### Porting Challenges

The main areas that require attention during the port include:

1. **CLX → LCL migration** — The original project uses Borland's CLX (cross-platform component library). This needs to be migrated to Lazarus's LCL (Lazarus Component Library). Form files (`.xfm`) will need to be converted to Lazarus format (`.lfm`).
2. **Delphi-specific units and APIs** — Some Delphi-specific units (e.g., `DBXpress` database drivers) need to be replaced with FPC/Lazarus equivalents or open-source alternatives.
3. **SynEdit component** — The bundled SynEdit version is Delphi-era; Lazarus ships with its own maintained SynEdit package that should be used instead.
4. **Database connectivity** — The DBExpress driver architecture needs to be replaced (e.g., with SQLDB, ZeosLib, or similar FPC-compatible database access libraries).
5. **Plugin system** — The DLL-based plugin architecture may need adjustments for cross-platform compatibility under FPC.
6. **PDF generation** — The embedded PDF library will need to be reviewed for FPC compatibility.
7. **Platform-specific code** — Any Windows-specific or Kylix-specific code paths need to be updated.

### Porting Status

✅ **All projects compile successfully under Free Pascal / Lazarus!**

| Project | Lines Compiled | Binary |
|---------|---------------|--------|
| Main Application | 56,608 | `bin/DBDesignerFork` |
| Demo Plugin | 21,793 | `bin/DBDplugin_Demo` |
| HTMLReport Plugin | 22,258 | `bin/DBDplugin_HTMLReport` |
| DataImporter Plugin | 8,836 | `bin/DBDplugin_DataImporter` |
| SimpleWebFront Plugin | 40,096 | `bin/DBDplugin_SimpleWebFront` |
| **Total** | **~150,000** | |

### Building with Lazarus

**Requirements:**
- Free Pascal Compiler (FPC) 3.2.2+
- Lazarus 3.0+ (for `lazbuild` command-line tool)
- Required Lazarus packages: `LCL`, `SynEdit`

**Build all projects:**
```bash
# Main application
lazbuild DBDesignerFork.lpi

# Plugins
lazbuild Plugins/Demo/DBDplugin_Demo.lpi
lazbuild Plugins/HTMLReport/DBDplugin_HTMLReport.lpi
lazbuild Plugins/DataImporter/DBDplugin_DataImporter.lpi
lazbuild Plugins/SimpleWebFront/DBDplugin_SimpleWebFront.lpi
```

All binaries are output to the `bin/` directory.

### Porting Approach

The port uses a **compatibility shim layer** (`clx_shims/` directory) to minimize changes to original source files:

- **CLX → LCL shims**: Units like `QForms.pas`, `QControls.pas` etc. that re-export LCL equivalents
- **Qt shim** (`qt.pas`): Maps Qt widget types and key constants to LCL equivalents
- **Database shims** (`sqlexpr.pas`, `dbclient.pas`, `provider.pas`): Wrap FPC's SQLDB behind Delphi DBExpress-compatible interfaces
- **XML shims** (`xmlintf.pas`, `xmldoc.pas`, `xmldom.pas`): Wrap `laz2_DOM` behind Delphi XML DOM interfaces

See [`port-to-lazarus.md`](port-to-lazarus.md) for the detailed porting guide and [`port-to-lazarus-task-list.md`](port-to-lazarus-task-list.md) for the task checklist (195/229 tasks complete).

### Runtime Testing Status

⚠️ **Runtime testing is still needed.** The application compiles and links but has not yet been tested with a display server. Known areas requiring runtime verification:
- Application launch and UI rendering
- Database connectivity (MySQL, PostgreSQL, SQLite)
- Model loading/saving
- PDF export
- Plugin loading

## License

This project is licensed under the **GNU General Public License v2**. See [`Copying.txt`](Copying.txt) for the full license text.

## Contributing

Contributions to the FPC/Lazarus port are highly welcome! Whether it's converting a single unit, fixing compilation issues, testing on different platforms, or improving documentation — every bit helps.

; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppName "Lidarr"
#define AppPublisher "Team Lidarr"
#define AppURL "https://lidarr.audio/"
#define ForumsURL "https://forums.lidarr.audio/"
#define AppExeName "Lidarr.exe"
#define BuildNumber "0.3.1"
#define BuildNumber GetEnv('APPVEYOR_BUILD_NUMBER')
#define BuildVersion GetEnv('APPVEYOR_BUILD_VERSION')
#define BranchName GetEnv('APPVEYOR_REPO_BRANCH')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{56C1065D-3523-4025-B76D-6F73F67F7F93}
AppName={#AppName}
AppVersion=0.3.1
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#ForumsURL}
AppUpdatesURL={#AppURL}
DefaultDirName={commonappdata}\Lidarr\bin
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputBaseFilename=Lidarr.{#BranchName}.{#BuildVersion}.windows
SolidCompression=yes
AppCopyright=Creative Commons 3.0 License
AllowUNCPath=False
UninstallDisplayIcon={app}\Lidarr.exe
DisableReadyPage=True
CompressionThreads=2
Compression=lzma2/normal
AppContact={#ForumsURL}
VersionInfoVersion=0.3.1.{#BuildNumber}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"
Name: "windowsService"; Description: "Install Windows Service (Starts when the computer starts)"; GroupDescription: "Start automatically"; Flags: exclusive
Name: "startupShortcut"; Description: "Create shortcut in Startup folder (Starts when you log into Windows)"; GroupDescription: "Start automatically"; Flags: exclusive unchecked
Name: "none"; Description: "Do not start automatically"; GroupDescription: "Start automatically"; Flags: exclusive unchecked

[Files]
Source: "..\_output\Lidarr.exe"; DestDir: "{app}"; Flags: ignoreversion  
Source: "..\_output\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "/icon"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "/icon"
Name: "{userstartup}\{#AppName}"; Filename: "{app}\Lidarr.exe"; WorkingDir: "{app}"; Tasks: startupShortcut

[Run]
Filename: "{app}\Lidarr.Console.exe"; StatusMsg: "Removing previous Windows Service"; Parameters: "/u"; Flags: runhidden waituntilterminated;
Filename: "{app}\Lidarr.Console.exe"; Description: "Enable Access from Other Devices"; StatusMsg: "Enabling Remote access"; Parameters: "/registerurl"; Flags: postinstall runascurrentuser runhidden waituntilterminated; Tasks: startupShortcut none;
Filename: "{app}\Lidarr.Console.exe"; StatusMsg: "Installing Windows Service"; Parameters: "/i"; Flags: runhidden waituntilterminated; Tasks: windowsService
Filename: "{app}\Lidarr.exe"; Description: "Open Lidarr Web UI"; Flags: postinstall skipifsilent nowait; Tasks: windowsService;
Filename: "{app}\Lidarr.exe"; Description: "Start Lidarr"; Flags: postinstall skipifsilent nowait; Tasks: startupShortcut none;

[UninstallRun]
Filename: "{app}\lidarr.console.exe"; Parameters: "/u"; Flags: waituntilterminated skipifdoesntexist

[Code]
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: Integer;
begin
  Exec(ExpandConstant('{commonappdata}\Lidarr\bin\Lidarr.Console.exe'), '/u', '', 0, ewWaitUntilTerminated, ResultCode)
end;

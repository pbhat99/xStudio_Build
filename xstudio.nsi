!include "MUI2.nsh"


; details -------------------
!define PRODUCT_NAME "xStudio"
!define PRODUCT_VERSION "1.0.0"
!define INSTALL_DIR "$PROGRAMFILES64\xStudio"


Name "xStudio"
OutFile "xStudioInstaller.exe"
InstallDir "${INSTALL_DIR}"
BrandingText "DNEG"
RequestExecutionLevel admin

; graphics -------------------------
!define MUI_ICON "xstudio.ico"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"

!define MUI_WELCOMEFINISHPAGE_BITMAP "wizard.bmp"

!define MUI_WELCOMEPAGE_TEXT "Setup will guide you through the installation process of xStudio.$\n$\n You should close all other application before continuing.$\n$\n Click Next to continue and Cancel to exit the Setup Wizard."

!define MUI_FINISHPAGE_RUN "$INSTDIR\bin\xstudio.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run xStudio"
!define MUI_FINISHPAGE_LINK "more info on DNEG xStudio"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.dneg.com/xstudio/"


VIProductVersion "1.0.0.0"
VIAddVersionKey ProductName "xStudio"
VIAddVersionKey CompanyName "DNEG"



; Installer Pages -----------------------------------------------------
!insertmacro MUI_PAGE_WELCOME

!define MUI_PAGE_HEADER_TEXT "Apache-2.0 license"
!define MUI_PAGE_HEADER_SUBTEXT "Please read before installing"
!insertmacro MUI_PAGE_LICENSE "license.txt"

!define MUI_PAGE_HEADER_TEXT "Code of Conduct - Security policy"
!define MUI_PAGE_HEADER_SUBTEXT "Please review before installing xStudio."
!insertmacro MUI_PAGE_LICENSE "COC.md"

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"




; Uninstaller Pages --------------------------------------------
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "header.bmp"
!define MUI_WELCOMEPAGE_TITLE "Uninstall xStudio"
!define MUI_WELCOMEPAGE_TEXT "Setup will guide you through the installation process of xStudio"
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
;!insertmacro MUI_UNPAGE_FINISH

Section "xStudio"

  SetOutPath $INSTDIR
  file "license.txt"
  file "COC.md"
  file "xstudio.ico"
  File /r "Compiled\*"

  WriteUninstaller "$INSTDIR\xStudio-Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "DisplayName" "xStudio"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "DisplayVersion" "1.0.0.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "Publisher" "DNEG"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "DisplayIcon" "$INSTDIR\xstudio.ico"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "NoRepair" 1
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio" "UninstallString" "$INSTDIR\xStudio-Uninstall.exe"

SectionEnd

Section "Desktop Shortcut"
  CreateShortCut "$DESKTOP\xStudio.lnk" "$INSTDIR\bin\xstudio.exe" "" "$INSTDIR\xstudio.ico" "0" "SW_SHOWMAXIMIZED"
SectionEnd

Section "StartMenu Shortcut"
  CreateShortCut "$SMPROGRAMS\xStudio.lnk" "$INSTDIR\bin\xstudio.exe" "" "$INSTDIR\xstudio.ico" "0" "SW_SHOWMAXIMIZED"
SectionEnd

Section "Reset preferences"
  RMDir /r "$PROFILE\.config\DNEG\xstudio"
SectionEnd

Section "Uninstall"

    delete "$INSTDIR\xstudio.ico"
    delete "$INSTDIR\COC.md"
    Delete "$INSTDIR\license.txt"
    Delete "$INSTDIR\xStudio-Uninstall.exe"

    ; Remove the directory
    RMDir /r "$INSTDIR\bin" 
    RMDir /r "$INSTDIR\extern"
    RMDir /r "$INSTDIR\include"
    RMDir /r "$INSTDIR\lib"
    RMDir /r "$INSTDIR\plugin"
    RMDir /r "$INSTDIR\python"
    RMDir /r "$INSTDIR\share"
    RMDir /r "$INSTDIR\snippets"
    ; thumbs & autosave files
    RMDir /r "$PROFILE\xStudio"
    RMDir  "$INSTDIR"

    ; Remove Shortcut
    Delete "$DESKTOP\xStudio.lnk"
    Delete "$SMPROGRAMS\xStudio.lnk"

    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xStudio"

SectionEnd
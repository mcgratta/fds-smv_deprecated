@echo off
set version=%1
REM
REM This batch file creates a self unarchiving file containing
REM a test version of smokeview and associated files
REM
REM usage: 
REM  make_smv_release_win32 version
REM    where version is of the from test_svn#

cd ..\for_bundle
set smvdir=to_google\smv_%version%_win32

echo
echo filling distribution directory
mkdir %smvdir%
copy smokeview_test.exe %smvdir%\smokeview.exe
copy smokezip_release.exe %smvdir%\smokezip.exe
copy devices.svo %smvdir%\.
copy note.txt %smvdir%\.

echo
echo winzipping distribution directory
wzzip -a %smvdir%.zip %smvdir%\*

echo
echo creating self-extracting archive
d:\bin\winzip\wzipse32 %smvdir%.zip -d "c:\program files\nist\smokeview"

cd ..\scripts
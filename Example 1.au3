#include 'ExtInputBox.au3'

$sData = _ExtInputBox("Login", "Username|Password", Null, "2")

If $sData = False Then
   MsgBox(0, "", "You pressed cancel, exit or timeout ended.")
Else
   MsgBox(0, "You entered:", "Username: " & $sData[1] & @CRLF & "Password: " & $sData[2])
EndIf
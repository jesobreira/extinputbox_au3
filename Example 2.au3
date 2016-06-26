#include 'ExtInputBox.au3'

$sData = _ExtInputBox("Login", "Your full name|Your email|Your telephone|Choose an username|Choose a password|Repeat password", "Mr./Ms. ||+1 |admin||", "5,6", "Register|Cancel")

If $sData = False Then
   Switch @extended
	  Case 1
		 MsgBox(0, "", "You clicked Cancel")
	  Case 2
		 MsgBox(0, "", "You closed the window.")
	  Case 3
		 MsgBox(0, "", "Timeout ended (but we have no timeout on this example, so this will never happen)")
   EndSwitch
Else
   MsgBox(0, "You entered:", "Full name: " & $sData[1] & @CRLF & _
			 "Email: " & $sData[2] & @CRLF & _
			 "Telephone:" & $sData[3] & @CRLF & _
			 "Username: " & $sData[4] & @CRLF & _
			 "Password: " & $sData[5] & @CRLF & _
			 "Password repeat: " & $sData[6])
EndIf
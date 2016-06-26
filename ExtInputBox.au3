#include-once
#include 'StringSize.au3'
#include <Timers.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>

#cs
   ExtInputBox UDF
	  written by Jefrey <jefrey[at]jefrey.ml>
#ce

Func _ExtInputBox($sTitle, $sTexts, $sDefaults = Null, $sPasswords = Null, $sBtnLabels = "OK|Cancel", $iWidth = -1, $iLeft = -1, $iTop = -1, $iTimeout = 0, $hParent = 0)
   $sTexts = StringSplit($sTexts, "|")

   $sPasswords = StringRegExpReplace($sPasswords, "[^0-9]", "|")
   $sPasswords = "|" & $sPasswords & "|"

   $aSize = _StringSize($sTexts[1], Default, Default, Default, Default, @DesktopWidth/4)
   $iLabelHeight = $aSize[3]
   If $iWidth = -1 Then $iWidth = $aSize[2]
   If $iWidth < 190 Then $iWidth = 190

   $iTextHeight = 21
   Local $iHeight = ($iTextHeight + $iLabelHeight + 3) * $sTexts[0]

   $old_oneventmode = Opt("GUIOnEventMode", 0)

   Local $hWnd = GUICreate($sTitle, $iWidth, $iHeight + 35, $iLeft, $iTop, -1, -1, $hParent)

   Local $aPwdInputs = StringSplit($sPasswords, "|")

   Local $aDefaults = StringSplit($sDefaults, "|")

   Local $aInputs[UBound($sTexts)]
   $aInputs[0] = UBound($sTexts)-1
   For $i = 1 To $sTexts[0]
	  GUICtrlCreateLabel($sTexts[$i], 2, ($i-1)*($iTextHeight + $iLabelHeight + 3), $iWidth-2, $iLabelHeight)
	  Local $style
	  If StringInStr($sPasswords, "|" & $i & "|") Then
		 $style = $ES_PASSWORD
	  Else
		 $style = -1
	  EndIf
	  Local $value = Null
	  If $aDefaults[0] = $aInputs[0] Then
		 $value = $aDefaults[$i]
	  EndIf
	  $aInputs[$i] = GUICtrlCreateInput($value, 2, (($i-1)*($iTextHeight + $iLabelHeight + 3))+$iLabelHeight+2, $iWidth-2, $iTextHeight, $style)
   Next

   $aBtnLabels = StringSplit($sBtnLabels, "|")
   $hOkBtn = GUICtrlCreateButton($aBtnLabels[1], 2, ($i-1)*($iTextHeight + $iLabelHeight + 3)+4, 60)
   $hCancelBtn = GUICtrlCreateButton($aBtnLabels[2], 62, ($i-1)*($iTextHeight + $iLabelHeight + 3)+4, 60)

   GUISetState(@SW_SHOW, $hWnd)
   GUICtrlSetState($aInputs[1], $GUI_FOCUS)
   $hStarttime = _Timer_Init()
   While 1
	  If $iTimeout > 0 And _Timer_Diff($hStarttime) >= $iTimeout Then
		 $return = False
		 $ext = 3
		 ExitLoop
	  EndIf
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
			$return = False
			$ext = 2
			ExitLoop
		 Case $hCancelBtn
			$return = False
			$ext = 1
			ExitLoop
		 Case $hOkBtn
			Local $return[UBound($aInputs)]
			$return[0] = $aInputs[0]
			For $i = 1 To $aInputs[0]
			   $return[$i] = GUICtrlRead($aInputs[$i])
			Next
			ExitLoop
	  EndSwitch
   WEnd
   GUIDelete($hWnd)
   Opt("GUIOnEventMode", $old_oneventmode)
   If $return = False Then
	  Return SetError(0, $ext, False)
   Else
	  Return $return
   EndIf
EndFunc

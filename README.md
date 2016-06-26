ExtInputBox UDF
===============

This UDF creates input boxes (just like native InputBox), but with multiple inputs.

You can also set some inputs to be password-style, set the default texts for some of the edits and even set the label of the OK/cancel buttons.

How to use
----------

```
_ExtInputBox($sTitle, $sTexts [ , $sDefaults = Null [ , $sPasswords = Null [ , $sBtnLabels = "OK|Cancel" [ , $iWidth = -1 [ , $iLeft = -1 [ , $iTop = -1 [ , $iTimeout = 0 [ , $hParent = 0 ] ] ] ] ] ] ] ] )
```

Arguments are:

* **$sTitle** (mandatory): The window title (e.g.: "Hello World")
* **$sTexts** (mandatory): The edit labels, separated by | (e.g.: "Your email|Your password")
* **$sDefaults**: The default input texts, separated by | (e.g.: "|you@us.com||" will tell that the first input will have nothing as default text, the second will have `you@us.com` as default text and the third and forth will also have nothing). Note that if you set the default value of 1 input, you must set the value of them all (even if it's nothing), otherwise all inputs will have no default value. Default is none.
* **$sPasswords**: One or more 1-based index of inputs, separated by anything that is not a number (pipeline - | - recommended), of the inputs that will receive password style (e.g.: "2|3" wíll tell that the second and third inputs are password-style, default is none)
* **$sBtnLabels**: The TWO label of the default OK/Cancel buttons (e.g.: "Submit|Close")
* **$iWidth**: Window width (default is the size of the longest string with the limit of 25% of the screen width). Obviously it's not possible to set the height as it's calculated automatically.
* **$iLeft**: Distance of the window from the left side of the screen (default is centered)
* **$iTop**: Distance of the window to the top of the screen (default is centered)
* **$iTimeout**: Time limit for filling the form data (default is none)
* **$hParent**: Parent form (default is none)

Return value
------------

Sucess: an 1-based array with the input values entered ($aArray[1] = 1st input value, $aArray[2] = 2nd input value, $aArray[n] = nth input value, whereas $aArray[0] = input count)

Failure: False, and set @extended to 1 if the user clicked cancel, 2 if the user closed the window, or 3 if timeout ended.

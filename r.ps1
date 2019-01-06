$VerbosePreference = "Continue"
Clear-Host
## Variables
##▼▼
$script:AllowExit		=  $TRUE
$script:OpeningBet	= 10
$script:BetZone		= 12
$script:Units			= 2
$script:BetLo			= $null
$script:BetHi			= $null
$script:BetMed			= $null
$script:Spin			= $null
$script:Time			= $null
$script:ValidSpin		= $null
$script:WinLose		= $null

$Gob = [system.collections.arrayList] @()
$Timer =  [system.diagnostics.stopwatch]::startnew()
$WinLoseRA = [system.collections.arrayList] @()

##▲
## Functions
	## Startup
##▼▼
Function F-Startup
{
	If ( $BetZone -eq 12 ) {
		$BetLo  = $OpeningBet
		$BetMed = $OpeningBet
		$BetHi = $null
	}	Elseif ($Betzone -eq 13 ) {
		$BetLo  = $OpeningBet
		$BetMed = $null
		$BetHi  = $OpeningBet
	} Else {
		$BetLo =  $null
		$BetMed = $OpeningBet
		$BetHi = $OpeningBet
	}
}	##▲	END FUNCTION
	## Spin Validate
##▼▼
Function F-SpinValidate
{
	If ( $AllowExit ) { If ( $spin -eq 't' -OR $spin -eq 'tt' ) { exit } }
	If ( $spin -match '^[0-9]$' -OR $spin -match '^[1-2][0-9]$' -OR $spin -match '^[3][0-6]$' )  {
	} Else { Write-Host -f Red " [ NOT VALID NUMBER ]"  ; Start-Sleep -m 500  ; Clear-Host ; Continue 	}
}	##▲	END FUNCTION
	## Update
##▼▼
Function F-Update
{
	Param ()	
	## Time
	##▼▼
	$hrs  = '{0:0}' -f ($Timer.Elapsed.Hours)
	#$mins = '{0:00}' -f $Timer.Elapsed.Minutes
	$mins = '{0:00}' -f $Timer.Elapsed.Ticks
	$Time =  ('{0}:{1}' -f $hrs,$mins )
	##	▲	END Time
	## WinOrLose
	##▼▼
	Switch ( $Gob[-1] ) {
		{ $_ -in 0 } { [void] $WinLoseRA.Add('Z') ; $WinLose = 'L' ; BREAK }  ##	Spin 0
		{ $_ -in 1..12 } {  ##	Spin Lo
			[void] $WinLoseRA.Add('L')
			If  ( $BetZone -eq 12 ) { $WinLose = 'W12'; BREAK }
			Elseif ( $BetZone -eq 13 ) { $WinLose = 'W13' ; BREAK }
			Else { $WinLose = 'L'; BREAK }
		}
		{ $_ -in 13..24 } { ##	Spin Med
			[void] $WinLoseRA.Add('M') ;
			If  ( $BetZone -eq 12 ) { $WinLose = 'W12' }
			Elseif ( $BetZone -eq 13 ) { $WinLose = 'L' }
			Else {$WinLose = 'W23'; BREAK }
		}
		{ $_ -in 25..36 } { ##	Spin Hi
			[void] $WinLoseRA.Add('H') ;
			If  ( $BetZone -eq 12 ) { $WinLose = 'L' }
			Elseif ( $BetZone -eq 13 ) { $.WinLose = 'W13' }
			Else {$WinLose = 'W23'; BREAK }
		}
	}##	END Switch
	##▲	END WinOrLose






	##▲	END WinOrLose
	## NEW
##▼▼
Function F-NEW
{
[CmdletBinding( SupportsShouldProcess=$True ) ]
	Param ()
	Begin{}
	Process{
	}
	End{}
}##▲	END FUNCTION
}	##▲	END FUNCTION

F-Startup

While (1) {
	If ( $Gob.count -eq 0 ) { Write-Host  "`n BetZone: $BetZone  Units: $Units	Inital Bet: $OpeningBet`n" }
	$Spin  = Read-Host -Prompt "$("`n" * 4 ) $(" " * (10)) Enter Spin"
	F-SpinValidate
	[Void] $Gob.Add( $Spin )
	Clear-Host
	F-UpDate
}	


## Make this into one program

#	F-Update
	##	Above the Line
#	$_betlo = '{0:0}' -f $BetLo

#	fff 'here1'
#	fff $BetLo
#	Write-Host -n -f Darkgray  $_betlo
#	Write-Host -n -f Darkgray  $Betlo
#	sleep 2
#	$gap = [Math]::Floor([Math]::Log10( $Gob.Count ) + 1 ) }
#	Write-Host -n -f Darkgray  " Bet: "

	
	
	## I want to find the updated cash 
   ## Before I can do that I need to know if I won or lost


<#
		##	WinOrLose
		## ▼▼
		Switch ( $this.Gob[-1] ) {
			{ $_ -in 0 } { $this.lmhRA.Add('Z') ; $this.WinLose = 'L' ; BREAK }  ##	Spin 0
			{ $_ -in 1..12 } {  ##	Spin Lo
				$this.lmhRA.Add('L') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12'; BREAK }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' ; BREAK }
				Else { $this.WinLose = 'L'; BREAK }
			}
			{ $_ -in 13..24 } { ##	Spin Med
				$this.lmhRA.Add('M') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12' }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'L' }
				Else {$this.WinLose = 'W23'; BREAK }
			}
			{ $_ -in 25..36 } { ##	Spin Hi
				$this.lmhRA.Add('H') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'L' }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' }
				Else {$this.WinLose = 'W23'; BREAK }
			}
		}##	END Switch
		$this.WinsRA += $this.WinLose
			## ▲
#>


#Write-Host -f y `n`n`n 'Timer: ' $Timer.ElapsedMilliSeconds 'ms'`n`n`n


	Write-Host -f darkGreen '  Lo         Med         Hi     '
	fff $Gob.Count


#TODO


#	Write-Host -n " " $BetLo
#	If ( $BetLo -eq $null ) { $gap = 0 } Else { $gap = [Math]::Floor([Math]::Log10( $BetLo ) + 1 ) }
#	Write-host -n $( " " * ( 11 - $gap ) )
#	Write-Host -n $BetMed
#	If ( $BetMed -eq $null ) { $gap = 0 } Else { $gap = [Math]::Floor([Math]::Log10( $BetMed ) + 1 ) }
#	Write-host -n $( " " * ( 12 - $gap ) )
#	Write-Host -n $BetHi



#33	F-SpinValidate

	#Write-Host "Gary"
  # Write-Host -f y `n`n`n 'Timer: ' $Timer.ElapsedMilliSeconds 'ms'`n`n`n
  # Sleep 5



#Write-Host -f y `n`n`n 'Timer: ' $Timer.ElapsedMilliSeconds 'ms'`n`n`n



#		If ( $.BetLo  -eq  $null )  { $gapL = 0 } Else { $gapL = [Math]::Floor([Math]::Log10($.BetLo) + 1) }

#		If ( $.BetMed -eq  $null )  { $gapM = 0 } Else { $gapM = [Math]::Floor([Math]::Log10($.BetMed) + 1) }
#		If ( $.BetHi  -eq  $null )  { $gapH = 0 } Else { $gapH = [Math]::Floor([Math]::Log10($.BetHi) + 1) }
#		$.BetSizePrevious = ( $.BetLo + $.BetMed + $.BetHi ) / 2
#		Write-Host -f darkcyan "  Lo     Med     Hi"
#		Write-Host -n " " $($BetLo)
#		Write-host -n $(" " * (7-$gapL))
#		Write-Host -n $($BetMed)
#		Write-host -n $(" " * (8-$gapM))
#		Write-Host -n $($BetHi)












<#
##	Site
$Site = '888'
$Site = '' # comment out to save to HD


##	Class Definition
Class Dozens {
	##	Properties
##	▼▼
	$AllowExit
	$BetHi
	$BetHiPrevious
	$BetLo
	$BetLoPrevious
	$BetMed
	$BetMedPrevious
	$BetSize
	$BetSizePrevious
	$BetZone
	$BettingMethod
	[int] $Cash
	[int] $CashLow
	[int] $CashHigh
	$OpeningBet
	$Units
	$ValidSpin
	$WinLose
	$Gob = [System.Collections.ArrayList] @()
	$lmhRA = [System.Collections.ArrayList] @() ## Lo Med High Count
	$TimerObj =  [system.diagnostics.stopwatch]::startnew()
	$WinsRA = [System.Collections.ArrayList] @()
	$GetPercentagesRA = [System.Collections.ArrayList] @()
#	$Spin
#	[int] $BetCount
#	[int] $BetTotal
#	[int] $HighBank
#	[int] $LowBank
#	[int] $PercentHi
#	[int] $PercentLimit
#	[int] $PercentLo
#	[int] $PercentMed
#	[int] $Tracking
##▲	END Properties
	##	Methods
	##	Start()
##	▼▼
	[Void] Start() {
		Clear-Host
		if ( $this.Betzone -eq  12 ) {
			$this.BetLo  = $this.OpeningBet
			$this.BetMed = $this.OpeningBet
			$this.BetHi  = $null
		}	Elseif ($this.Betzone -eq 13 ) {
			$this.BetLo  = $this.OpeningBet
			$this.BetMed = $null
			$this.BetHi  = $this.OpeningBet
		} Else {
			$this.BetLo =  $null
			$this.BetMed = $this.OpeningBet
			$this.BetHi = $this.OpeningBet
		}
		Write-Host  "`n BetZone: $($this.BetZone)  Units: $($this.Units)  Inital Bet: $($this.OpeningBet)`n"
		If ( $this.BetLo  -eq  $null )  { $gapL = 0 } Else { $gapL = [Math]::Floor([Math]::Log10($this.BetLo) + 1) }
		If ( $this.BetMed -eq  $null )  { $gapM = 0 } Else { $gapM = [Math]::Floor([Math]::Log10($this.BetMed) + 1) }
		If ( $this.BetHi  -eq  $null )  { $gapH = 0 } Else { $gapH = [Math]::Floor([Math]::Log10($this.BetHi) + 1) }
		$this.BetSizePrevious = ( $this.BetLo + $this.BetMed + $this.BetHi ) / 2
		Write-Host -f darkcyan "  Lo     Med     Hi"
		Write-Host -n " " $($this.BetLo)
		Write-host -n $(" " * (7-$gapL))
		Write-Host -n $($this.BetMed)
		Write-host -n $(" " * (8-$gapM))
		Write-Host -n $($this.BetHi)
	}
##▲	END Start Method
	##	SpinValidate()
##	▼▼
	[Void] SpinValidate( $spin ) {
		If ( $this.AllowExit ) { if ( $spin -eq 't' -OR $spin -eq 'tt' ) { exit } }

		If ( $spin -match '^[0-9]$' -OR $spin -match '^[1-2][0-9]$' -OR $spin -match '^[3][0-6]$' )  {
			$this.ValidSpin = 1
		} Else {  ## NOT VALID
			Write-Host -f Red " [ NOT VALID NUMBER ]"  ; Start-Sleep -m 500
			If ($this.Gob.Count -gt 0 ) { $this.gob.Remove($($this.gob[-1])) }  
			$this.ValidSpin = 0
			Clear-Host
			Continue
		}
	}##▲	END SpinValidate Method
	## Update Method
	[Void] Update( $spin ) {	## ▼ ▼
		$MyUpdateTimer =  [system.diagnostics.stopwatch]::startnew()
		$this.Gob.Add( $spin)
		##	WinOrLose
		## ▼▼
		Switch ( $this.Gob[-1] ) {
			{ $_ -in 0 } { $this.lmhRA.Add('Z') ; $this.WinLose = 'L' ; BREAK }  ##	Spin 0
			{ $_ -in 1..12 } {  ##	Spin Lo
				$this.lmhRA.Add('L') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12'; BREAK }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' ; BREAK }
				Else { $this.WinLose = 'L'; BREAK }
			}
			{ $_ -in 13..24 } { ##	Spin Med
				$this.lmhRA.Add('M') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12' }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'L' }
				Else {$this.WinLose = 'W23'; BREAK }
			}
			{ $_ -in 25..36 } { ##	Spin Hi
				$this.lmhRA.Add('H') ;
				If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'L' }
				Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' }
				Else {$this.WinLose = 'W23'; BREAK }
			}
		}##	END Switch
		$this.WinsRA += $this.WinLose
			## ▲
		##	Cash
		## ▼▼
		If ( $this.WinLose -eq 'L') {	$this.Cash = $this.Cash - (2 * $this.BetSizePrevious)
		} Else { $this.Cash = $this.Cash + $this.BetSizePrevious }
		If  ( $this.Cash -le $this.CashLow ) {
			$this.CashLow = $this.Cash
		} ElseIf  ( $this.Cash -gt $this.CashHigh ) {
			$this.CashHigh = $this.Cash
		}	
		## ▲
		##	Bets
		## ▼▼
		$this.BetLoPrevious    = $this.BetLo
		$this.BetMedPrevious   = $this.BetMed
		$this.BetHiPrevious    = $this.BetHi
		$this.BetSizePrevious = ($this.BetLo + $this.BetMed + $this.BetHi)/2
		If ( $this.BettingMethod -eq "Up2" ) {
			If ( $this.WinLose -eq 'W12') {
				$this.BetLo  = $this.BetLo - ( 1 * $this.Units )
				$this.BetMed = $this.BetMed - ( 1 * $this.Units )
				$this.BetHi = $null
				If  ( $this.BetLo -le $this.Units ) { $this.BetLo =  $this.Units }
				If  ( $this.BetMed -le $this.Units ) { $this.BetMed =  $this.Units }
			}
			If ( $this.WinLose -eq 'W13') {
				$this.BetLo  = $this.BetLo - ( 1 * $this.Units )
				$this.BetMed = $null
				$this.BetHi = $this.BetHi - ( 1 * $this.Units )
				If  ( $this.BetLo -le $this.Units ) { $this.BetLo =  $this.Units }
				If  ( $this.BetHi -le $this.Units ) { $this.BetHi =  $this.Units }
			}
			If ( $this.WinLose -eq 'W23') {
				$this.BetLo = $null
				$this.BetMed  = $this.BetMed - ( 1 * $this.Units )
				$this.BetHi = $this.BetHi - ( 1 * $this.Units )
				If  ( $this.BetMed -le $this.Units ) { $this.BetMed =  $this.Units }
				If  ( $this.BetHi -le $this.Units ) { $this.BetHi =  $this.Units }
			}
			If ( $this.WinLose -eq 'L') {
				If ( -NOT ( $this.BetLo -eq $null ) ) {
					$this.BetLo = $this.BetLo + (2 * $this.Units )
				}
				If ( -NOT ( $this.BetMed -eq $null) ) {
					$this.BetMed = $this.BetMed + (2 * $this.Units )
				}
				If ( -NOT ( $this.BetHi -eq $null ) ) {
					$this.BetHi = $this.BetHi + (2 * $this.Units )
				}
			}
		}
		$this.BetSize = ($this.BetLo + $this.BetMed + $this.BetHi )/2
		## ▲


		##  Switch Bets
		
		## ▼▼  JUNK

#	If (! $Site ) { Write-Host -f y  "`n       Not Saving To HD!! `n`n" }
#	$OB.Timer( $OB.TimerObj )
#  $OB.HighLow()
#	$OB.Last(1)
#	$OB.Last(6)
#	$OB.Last(30)
#	$OB.Last(24)
#	$OB.Last(18)
#	$OB.Last(12)
#	$OB.NoHits()
#	$OB.Bets()
#	$OB.DoAuto()
#	$OB.Last(6)


		## ▲

	#	Write-Host -f y 'update: ' $MyUpdateTimer.ElapsedMilliSeconds
	}##	END Update METHOD
## ▲
	
## ************************        DISPLAY         ***********************************************************************	
	[Void] Display() {	## ▼ ▼
	## ▼▼  DONE SO FAR

		$MyDisplayTimer =  [system.diagnostics.stopwatch]::startnew()
		$tspin=  [system.diagnostics.stopwatch]::startnew()
		##	Results
#		$resultRA = @()
#		$color = $null
		##	Spin
		$tspin1 =  [system.diagnostics.stopwatch]::startnew()
		If ( $this.Gob[-1] -eq 0 ){ $gap = 1 } Else { $gap = [Math]::Floor([Math]::Log10( $this.Gob.Count ) + 1) }
		$spinT1 = $tspin1.Elapsed.MilliSeconds
		Write-Host -n -f DarkGray "`n  Spin:"
		Write-Host -n $(" " * (5-$gap))
		Write-Host -n  $this.Gob.Count
		$spinT = $tspin.Elapsed.MilliSeconds
		$ttime =  [system.diagnostics.stopwatch]::startnew()
		##	Time
		Write-Host -n  $(" " * 7 )
		Write-Host -n -f DarkGray "Time: "
		$hrs  = '{0:0}' -f ($this.TimerObj.Elapsed.Hours)
		$mins = '{0:00}' -f $this.TimerObj.Elapsed.Minutes
		Write-Host ('{0}:{1}' -f $hrs,$mins ) -nonewline -f DarkGray
		$timeT = $ttime.Elapsed.MilliSeconds
		##	Cash
		Write-Host -n -f DarkGray "        Cash: "
		$_cash = '{0:C0}' -f ($this.Cash)
		$gap = $_cash.length
		Write-Host -n  $(" " * (7-$gap))
		If ( $this.Cash -ge 0 ) { Write-Host -f Green $_cash } Else { Write-Host -f Red $_cash }
		$timecash = $MyDisplayTimer.Elapsed.MilliSeconds
		## CashLo/CashHigh
		Write-host -n -f DarkGray `n'  Low: '
		$_cashlo = '{0:C0}' -f $this.CashLow
		$_cashhi = '{0:C0}' -f $this.CashHigh
		Write-host -n -f DarkGray $_cashlo
		Write-host -n -f DarkGray '  High: '
		Write-host  -f DarkGray $_cashhi
		$timecashlohigh  = $MyDisplayTimer.Elapsed.MilliSeconds

		## Previous
		If ( $this.BetLoPrevious  -eq $null ) { $gapL = 0 } Else { [int]	$gapL = [Math]::Floor([Math]::Log10( $this.BetLoPrevious )  + 1) }
		If ( $this.BetMedPrevious -eq $null ) { $gapM = 0 } Else { [int]	$gapM = [Math]::Floor([Math]::Log10( $this.BetMedPrevious ) + 1) }
		If ( $this.BetHiPrevious  -eq $null ) { $gapH = 0 } Else { [int]	$gapH = [Math]::Floor([Math]::Log10( $this.BetHiPrevious )  + 1) }
		If ( $this.WinLose -eq 'L' ) { $color = "Red"	} Else { $color = "Green" }
	#	Write-Host -f darkcyan "`n  Lo     Med     Hi     Dolly"
		Write-Host -f darkcyan "`n  $      $       $      Dolly"
		Write-Host -n  " " $( $this.BetLoPrevious )
		Write-host -n  $(" " * (7-$gapL))
		Write-Host -n  $( $this.BetMedPrevious )
		Write-host -n  $(" " * (8-$gapM))
		Write-Host -n  $( $this.BetHiPrevious)
		Write-host -n  $(" " * (7-$gapH))
		$timeprevious  = $MyDisplayTimer.Elapsed.MilliSeconds
		## Dolly
		If ( $this.Gob.Count -eq 1 ) {
			Write-Host -n -f $color $this.Gob[-1]
			$gapD = ($this.Gob[-1]).ToString().Length
			Write-Host -n $(" " * (10-$gapD))
			$message = ''
			If ( $color -eq "Green" ) {
				Write-Host -n -f $color 'You Won: '
				$_cash = '{0:C0}' -f ($this.BetSizePrevious)
				$gap = $_cash.ToString().Length
				Write-host -n $(" " * (7-$gap))
				Write-host -n -f $color $_cash
			} Else {
				Write-Host -n -f $color 'You Lost: '
				$_cash = '{0:C0}' -f ($this.BetSizePrevious * 2 )
				$gap = $_cash.ToString().Length
				Write-host -n $(" " * (6-$gap))
				Write-host -n -f $color $_cash
			}
		} Else {
			Write-Host -n -f $color $this.Gob[-1]
			$gapD = ($this.Gob[-1]).ToString().Length
			Write-Host -n $(" " * (10-$gapD))
			$message = ''
			If ( $color -eq "Green" ) {
				Write-Host -n -f $color 'You Won: '
				$_cash = '{0:C0}' -f ($this.BetSizePrevious)
				$gap = $_cash.ToString().Length
				Write-host -n $(" " * (7-$gap))
				Write-host -n -f $color $_cash
			} Else {
				Write-Host -n -f $color 'You Lost: '
				$_cash = '{0:C0}' -f ($this.BetSizePrevious * 2 )
				$gap = $_cash.ToString().Length
				Write-host -n $(" " * (6-$gap))
				Write-host -n -f $color $_cash
			}
		}
		$timedolly  = $MyDisplayTimer.Elapsed.MilliSeconds
		## Line
	   Write-Host -f DarkGray  "`n " $("_" * 48)`n
		
		$timeline  = $MyDisplayTimer.Elapsed.MilliSeconds
		
 ## ▲ END OF DONE
		## Percentages 
		If ( $this.GetPercentagesRA.Count -gt 0 ) { ## In case I don't want to calculate percentages
			$loc = $medc = $hic = 0
			$lop = $medp = $hip = 0
			Foreach ( $element in $this.GetPercentagesRA ) {
				If ( $($element) -eq 1  ) {
					Foreach ($item in $this.lmhRA) {
						If ( $item -eq 'L' ) { $loc ++ } ElseIf  ( $item -eq 'M' ) { $medc ++ } ElseIf ( $item -eq 'H' ) { $hic ++ }
			#			[int] $lop = $loc/$this.Gob.Count*100 ; [int] $medp = $medc/$this.Gob.Count*100 ; [int] $hip = $hic/$this.Gob.Count*100
					fff 'this is low count' $loc	
					fff 'this is med count' $medc	
					fff 'this is hi count' $hic	
					}	
				} 
					
			
			
			
			}	

		} ## END GetPercentagesRA.Count -gt 0






<#


					$GetColorRA = GetColor $loc $medc $hic
					Write-Host -n -f DarkGray ' '$loc
					Write-Host -n -f $GetColorRA[0] ''$lop`%	
					$gap = $loc.tostring().length + $GetColorRA[0].tostring().length
					Write-host -n $(" " * (7-$gap))
					Write-Host -n "---"
					Write-Host -n -f DarkGray ' '$medc
					Write-Host -n -f $GetColorRA[1] ''$medp`%	
					$gap = $loc.tostring().length + $GetColorRA[1].tostring().length
					Write-host -n $(" " * (7-$gap))
					Write-Host -n "---"
					Write-Host -n -f DarkGray ' '$hic
					Write-Host -n -f $GetColorRA[2] ''$hip`%	
					$gap = $loc.tostring().length + $GetColorRA[2].tostring().length
					Write-host -n $(" " * (14-$gap))
					Write-Host 'ALL'
				}
#>


##	Color Function
##	▼▼
Function GetColor ( $lop, $medp, $hip ) {
	$ColorRA =  $lop, $medp, $hip
	$minvalue = [int]($ColorRA | measure -Minimum).Minimum
	$maxvalue = [int]($ColorRA | measure -Maximum).Maximum
	$minIndex = $ColorRA.IndexOf($minvalue)
	$maxIndex = $ColorRA.IndexOf($maxvalue)
	$lopcolor = $medpcolor = $hipcolor = "cyan"
	If ( $minindex -eq 0 ) {
		$lopcolor = "red"
	}
	If ( $minindex -eq 1 ) {
		$medpcolor = "red"
	}
	If ( $minindex -eq 2 ) {
		$hipcolor = "red"
	}
	If ( $maxindex -eq 0 ) {
		$lopcolor = "green"
	}
	If ( $maxindex -eq 1 ) {
		$medpcolor = "green"
	}
	If ( $maxindex -eq 2 ) {
		$hipcolor = "green"
	}
	Return  $lopcolor, $medpcolor, $hipcolor
} ##▲	END GetColor Function



#				} Else {
#					If ( $this.lmhRA.Count -ge $($element) ) {
#						Foreach ($item in $this.lmhRA[-1..-($($element))]) {
#							If ( $item -eq 'L' ) { $loc ++ } ElseIf  ( $item -eq 'M' ) { $medc ++ } ElseIf ( $item -eq 'H' ) { $hic ++ }
#							[int] $lop = $loc/$this.Gob.Count*100 ; [int] $medp = $medc/$this.Gob.Count*100 ; [int] $hip = $hic/$this.Gob.Count*100
#						}	
#
#					$GetColorRA = GetColor $loc $medc $hic
#					Write-Host -n -f DarkGray ' '$loc
#					Write-Host -n -f $GetColorRA[0] ''$lop`%	
#					$gap = $loc.tostring().length + $GetColorRA[0].tostring().length
#					Write-host -n $(" " * (7-$gap))
#					}	
#				}
#			}
#	Write-Host -f DarkGray "`n`n`n`n`n01234567890123456789012345678901234567890123456789012345"
#			Write-Host -f darkGreen "  Lo         Med         Hi     "
			#	Write-Host 'lo count' $lop
			#	Write-Host 'med count' $medp
			#	Write-Host 'hi count' $hip
		   ## Get The Lo Med Hi Count and Percentage
				#If ( ($this.lmhRA).Count -ge $_ ) {
			#		Foreach ($item in $this.lmhRA) {
			#			If ( $item -eq 'L' ) { $locount ++ } ElseIf  ( $item -eq 'M' ) { $medcount ++ } ElseIf ( $item -eq 'H' ) { $hicount ++ }
			#			[int] $lop = $locount/$this.Gob.Count*100 ; [int] $medp = $medcount/$this.Gob.Count*100 ; [int] $hip = $hicount/$this.Gob.Count*100
			#		}
			#		Return  $locount, $lop, $medcount, $medp, $hicount, $hip
		
<#			
			Foreach ( $element in $this.GetPercentagesRA ) {
				write-host -f y $element
				If ( $this.lmhRA.Count -ge $($element) ) {
				#	Write-Host -f red $this.lmhRA.count
				#	Write-Host -f red $($element)
					$tloc = $tmedc = $thic = 0
				}	
					## Total Count
					Foreach ( $t in $this.lmhRA ) {
						If ( $t -eq 'L' ) { $tloc ++ } ElseIf  ( $t -eq 'M' ) { $tmedc ++ } ElseIf ( $t -eq 'H' ) { $thic ++ }
#					[int] $lop = $locount/$this.Gob.Count*100 ; [int] $medp = $medcount/$this.Gob.Count*100 ; [int] $hip = $hicount/$this.Gob.Count*100
							Write-Host -f red 'total lo count ' $tloc
							Write-Host -f red 'total med count ' $tmedc
							Write-Host -f red 'total hi count ' $thic
					}
				## How do I get the last 5	
					$x = $element
					Write-Host -f black -b yellow $x 	
				#	
					If ( $this.lmhRA.Count -ge $($element )) {
					}
					#	Write-Host -				#Foreach ( $i in $this.lmhRA[-1..-$($element)] ) {
					Write-Host -f black -b yellow $($element ))
						
					}	
				}	
			} ##END FOREACH
			} ##END FOREACH
		}## END GREATER THAN 0
#>

#	Write-Host -f y 'display timer: ' $MyDisplayTimer.Elapsed.MilliSeconds

#	}	##	END DISPLAY METHOD

##	▼▼ More Stuff


<#


		##	Function GetCount
		Function GetCount ( $el ) {
			$lop = $medp = $hip = 0
			$locount = $medcount = $hicount = 0
			If ( ($this.lmhRA).Count -ge $el ) {
				Foreach ($item in $this.lmhRA) {
					If ( $item -eq 'L' ) { $locount ++ } ElseIf  ( $item -eq 'M' ) { $medcount ++ } ElseIf ( $item -eq 'H' ) { $hicount ++ }
					[int] $lop = $locount/$this.Gob.Count*100 ; [int] $medp = $medcount/$this.Gob.Count*100 ; [int] $hip = $hicount/$this.Gob.Count*100
				}
				Return  $locount, $lop, $medcount, $medp, $hicount, $hip
			}
		}
		
		
		##	Function Color
		Function GetColor ( $lo, $med, $hi ) {
			$ColorRA =  $lo, $med, $hi
			$minvalue = [int]($ColorRA | measure -Minimum).Minimum
			$maxvalue = [int]($ColorRA | measure -Maximum).Maximum
			$minIndex = $ColorRA.IndexOf($minvalue)
			$maxIndex = $ColorRA.IndexOf($maxvalue)
			$locolor = $medcolor = $hicolor = "cyan"
			If ( $minindex -eq 0 ) {
				$locolor = "red"
			}
			If ( $minindex -eq 1 ) {
				$medcolor = "red"
			}
			If ( $minindex -eq 2 ) {
				$hicolor = "red"
			}
			If ( $minindex -eq 0 ) {
				$locolor = "red"
			}
			If ( $minindex -eq 1 ) {
				$medcolor = "red"
			}
			If ( $minindex -eq 2 ) {
				$hicolor = "red"
			}
	<#
			Write-Host -f y 'minindex ' $minIndex
			Write-Host -f y ' $minvalue ' $minvalue
			Write-Host -f y ' $maxindex ' $maxindex
			Write-Host -f y ' $maxvalue ' $maxvalue
			Write-Host -f $color $lo
			Write-Host -f y ' $maxvalue ' $maxvalue
	#>	
#		}	
		
		
#}





		
# Get PercentagesRA is the list of numbers I wast  ... Last 5   Last 10  Last 15
# lmhRA is the Array with win/lose for every spin

# I want the last 5  from gob and last 5 from lmhRA
	<#	
		$this.GetPercentagesRA | %  {
				Write-Host $_ 
			If ( $this.GetPercentagesRA.Count -gt 0 -AND $this.lmhRA.Count -gt 0 ) { ## In case I don't want to calculate percentages
							#	$locount = $medcount = $hicount = $null
#				If ( ($this.lmhRA).Count -ge $_ ) {  ## Make sure we have enough data
#				Write-Host $_
			
			}
		#		If ( ($this.lmhRA).Count -ge $el ) {  ## Make sure we have enough data
		#			$this.lmhRA | % {$TheCount = 0}{
		#				If ( $this.LmhRA[$TheCount] -eq 'L' ) { $locount ++ }
		#				If ( $this.LmhRA[$TheCount] -eq 'M' ) { $medcount ++ }
		#				If ( $this.LmhRA[$TheCount] -eq 'H' ) { $hicount ++ }
		#				$TheCount ++
		#			}
		#		
		#		}
		#	}

		#				Write-Host $locount
		#				Write-Host $medcount
		#				Write-Host $hicount
		}
#>
	#}		
		
  # $timepercentages  = $MyDisplayTimer.Elapsed.MilliSeconds
		
		
	## ▼▼  MORE JUNK
		
<#		
		Write-Host -f DarkGray "01234567890123456789012345678901234567890123456789012345"
		##	GetLast
		$result = GetLast   ## Function
		#Foreach ( $el in $this.LastRA ) {
		#	$result = GetLast $el   ## Function
		#}

		##	GetLowestHighest
		Function GetLast () {
			$lop = $medp = $hip = 0
			$locount = $medcount = $hicount = 0
			Foreach ($item in $this.lmhRA) {
				If ( $item -eq 'L' ) { $locount ++ } ElseIf  ( $item -eq 'M' ) { $medcount ++ } ElseIf ( $item -eq 'H' ) { $hicount ++ }
				[int] $lop = $locount/$this.Gob.Count*100 ; [int] $medp = $medcount/$this.Gob.Count*100 ; [int] $hip = $hicount/$this.Gob.Count*100
			}
			Return  $locount, $lop, $medcount, $medp, $hicount, $hip
		}	
		$result = GetLast   ## Function
		Write-Host -f darkcyan "`n     Lo         Med         Hi     "
		## Lo
		Write-Host -n -f DarkGray '    '	$result[0]
		$gap =  $result[0].tostring().length + $result[1].tostring().length
		Write-Host -n -f red " $($result[1])`%"
      Write-host -n $( "-" * ( 9 - $gap ) )
		## Med
		Write-Host -n -f DarkGray $result[2]
		Write-Host -n -f cyan " $($result[3])`%"
		$gap =  $result[2].tostring().length + $result[3].tostring().length
      Write-host -n $( "-" * ( 10 - $gap ) )
		## Hi
		Write-Host -n -f DarkGray $result[4]
		$gap =  $result[0].tostring().length + $result[1].tostring().length
		Write-Host -n -f red " $($result[5])`%"
      Write-host -n $( "-" * ( 9 - $gap ) )
#>

 ## ▲ END OF MORE JUNK

 #  Write-Host
 #  Write-Host
  # Write-Host
  # Write-Host
  # Write-Host

  # Write-Host -f y 'display timer: ' $MyDisplayTimer.Elapsed.MilliSeconds
		
  # 		}	##	END DISPLAY METHOD

## ▲
#TODO	



<#




<#
		[Void] Timer( $TimerObj ) {	##	▼▼
		$secs = $null
		Write-Host -n -f Darkgray 'Time: '
		$hrs  = '{0:0}' -f ($TimerObj.Elapsed.Hours)
		$mins = '{0:00}' -f $TimerObj.Elapsed.Minutes
		$Secs = '{0:00}' -f $TimerObj.Elapsed.Seconds ;  ## Uncomment to Display Seconds
		If ( $secs -eq  $null  ) { Write-Host ('{0}:{1}' -f $hrs,$mins ) -nonewline -f DarkGray }
		Else { Write-Host ('{0}:{1}:{2}' -f $hrs , $mins , $secs ) -nonewline -f DarkGray }
	}	##	END METHOD
##▲
	[Void] HighLow()	{	##	▼▼	
			$lowcash = 0 ; $lowcashLen = 0 ; $highcash = 0 ; $highcashLen = 0 ;
		If ( $this.Gob.Count -gt 0 ) {
			If  ( ( [int] $this.Bank ) -le ( [int] $this.LowBank ) ) {
				$this.LowBank = $this.Bank
			} ElseIf  ( ( [int] $this.Bank ) -gt ( [int] $this.HighBank ) ) {
				$this.HighBank = $this.Bank
			}	
		}	
<#
			Write-Host -n -f DarkGray '             Lo: '
			$lowcash  = '{0:C0}' -f $this.LowBank
			$lowcashLen =  $lowcash.tostring().length
			For ( $i=1; $i -lt ( 7 - $lowcashLen ) ; $i++ ) { Write-Host -no "" } ;  ##	Spaces After	'Lo:'   √
			Write-Host -n -f DarkGray  $lowcash
			For ( $i=1; $i -lt ( 11 - $lowcashLen ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces Before	'Hi'   √
			Write-Host -n -f DarkGray  'Hi: '
			$highcash  = '{0:C0}' -f $this.HighBank
			$highcashLen =  $highcash.tostring().length
			For ( $i=1; $i -lt ( 9 - $highcashLen ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After	'Hi:'  √
			Write-Host  -f DarkGray  $highcash
		} ##	END If Gob.Count
#>
#	}	##	END METHOD
##▲
<#	
	[Void] Bets() {	##	▼▼
		## Original Bet
		$lo = ($this.BetLo * $this.Units)
		$med = ($this.BetMed * $this.Units)
		$hi = ($this.BetHi * $this.Units)
		if ( ($this.Gob).Count -eq 0) {
			$lo =  $this.OpeningBet
			$med =  $this.OpeningBet
			$hi =  $this.OpeningBet
		}
		## Remove unused BetZone
		If ( $this.BetZone -eq 12 ){ Clear-Variable hi ; $this.BetHi  = 0 ; $hilen =  0 }
		If ( $this.BetZone -eq 13 ){ Clear-Variable med ; $this.BetMed = 0 ; $medlen = 0 }
		If ( $this.BetZone -eq 23 ){ Clear-Variable lo  ; $this.BetLo  = 0 ; $lolen =  0 }
		##	Calculate Bet Total
		$this.BetTotal =  $lo + $med + $hi
	}	##	END METHOD
##▲
<#	
	[Void] Last( $num ) {	## ▼▼
		$percentRA = $this.PercentLo, $this.PercentMed, $this.PercentHi
		$loCount = $medCount = $hiCount = 0
		$range = $null
		If ( $this.Gob.Count -gt 0 ) {
			If ( $num = 1 ) {
				Foreach ( $item in $this.Gob ) {
					Switch ( $item ) {
						{ $_ -in 0 } { BREAK }  ##	Spin 0
						{ $_ -in 1..12 }  { $loCount ++  ; BREAK }	##	Lo
						{ $_ -in 13..24 } { $medCount ++ ; BREAK }	##	Med
						{ $_ -in 25..36 } { $hiCount ++  ; BREAK }	##	Hi
					}
				}
				$this.PercentLo = $locount/$this.Gob.count*100
				$this.PercentMed = $medCount/$this.Gob.Count*100
				$this.PercentHi  = $hiCount/$this.Gob.Count*100
				Write-Host 'this is $locount' $loCount
				Write-Host 'this is $medcount' $medCount
				Write-Host 'this is $hicount' $hiCount
				Write-Host 'this is $gob count' $this.Gob.Count
				Write-Host	'this is$this.PercentLo ' $this.PercentLo
				Write-Host	'this is $this.PercentMed' $this.PercentMed
				Write-Host	'this is $this.PercentHi' $this.PercentHi
			}
		}

	}	##	END METHOD
		#		Write-Host 'medcount' $medcount
		#		Write-Host 'hicount' $hicount
<#
		If ( $this.Gob.Count -gt 0 ) {
				Write-Host 'gob.count greater than 0 '
				Write-Host 'loCount' $locount
				Write-Host 'medcount' $medcount
				Write-Host 'hicount' $hicount
				Write-Host 'gobcount' $this.Gob.Count
				$manLo = $locount/$this.Gob.count
				Write-Host 'manLo' $manLo
				$manmed = $medcount/$this.Gob.count
				Write-Host 'manmed' $manmed
				$manHi = $hicount/$this.Gob.count
				Write-Host 'manhi' $manHi
				$this.PercentLo = $locount/$this.Gob.count*100
				$this.PercentLo  = $loCount/$this.Gob.Count*100
				$this.PercentMed = $medCount/$this.Gob.Count*100
				$this.PercentHi  = $hiCount/$this.Gob.Count*100
				Write-Host -f magenta $this.PercentLo
				Write-Host -f magenta $this.PercentMed
				Write-Host -f magenta $this.PercentHi
		} Else {
			If (  ($this.Gob).Count -ge 0 -AND ($this.Gob).Count -ge $num ) {
				Write-Host 'in else'
				Sleep 2
				Foreach ( $item in ( $this.Gob[-$num..-1]) ) {
					Switch ( $item ) { { $_ -in 0 } { BREAK }     ##	0
						{ $_ -in 1..12 }  { $loCount ++  ; BREAK }	##	Lo
						{ $_ -in 13..24 } { $medCount ++ ; BREAK }	##	Med
						{ $_ -in 25..36 } { $hiCount ++  ; BREAK }	##	Hi
					}
				}
					$this.PercentLo  = $loCount/$num
					Write-Host -f y $this.PercentLo
					Sleep 1

					$this.PercentMed = $medCount/$num
					$this.PercentHi  = $hiCount/$num
			}
		}

#>
		#Write-Host 'this is percentLo' $this.PercentLo
		#Write-Host 'this is percentmed' $this.PercentMed
		#Write-Host 'this is percentHi' $this.PercentHi

## ▲
<#	
	[Void] SwitchingAuto() {	##	▼▼
	<#
		If ( ($this.Gob).Count -ge $this.Tracking ) {
			$HighSpins = $null
			$MedSpins = $null
			$LowSpins = $null
			Foreach ( $item in $this.Gob[-$this.Tracking..-1] ) {
				##	Lo
				If ( $item -in 1..12 )  { $LowSpins ++  ; }
				If ( $item -in 13..24 ) { $MedSpins ++  ; }
				If ( $item -in 25..36 ) { $HighSpins ++ ; }
				[int] $PercentLo = ( $LowSpins / $this.Tracking * 100 )
				[int] $PercentMed = ( $MedSpins / $this.Tracking * 100 )
				[int] $PercentHi = ( $HighSpins / $this.Tracking * 100 )
			}	
			[array] $RA = $PercentLo, $PercentMed, $PercentHi	
			$minvalue=[int]($RA | measure -Minimum).Minimum
			$minIndex = $RA.IndexOf($minvalue)
			If ( $minIndex -eq 0 ) {
				$this.BetZone = 23
			    If ( $this.WinLose -eq 'W' ) {
					$this.BetMed = ( $this.BetLo -1 )
					$this.BetHi  = ( $this.BetLo -1)
				} Else {
					$this.BetMed = ( $this.BetLo -1 )
					$this.BetHi  = ( $this.BetLo -1)
				}
			## added	
			## added	
				Write-Host 'minidex is zero'
				Sleep 2
			} Elseif  ( $minIndex -eq 1 ) {
				Write-Host 'minidex is 1'
			} Else {
				Write-Host 'minidex is 2'
			}		

			If ( $minIndex = 2 ) {
			}	
			Write-Host $this.BetLo
			Write-Host $this.BetMed
			Write-Host $this.BetHi
			Write-Host $this.WinLose
			Write-Host $this.WinsRA[-1]
			Write-Host $PercentLo
			Write-Host $PercentMed
			Write-Host $PercentHi
			Write-Host $minIndex
			Write-Host $MinValue
			
			If ( $this.BetLo -le $this.PercentLimit ) {
				$this.BetZone = 23
			    If ( $this.WinLose -eq 'W' ) {
					$this.BetMed = ( ($this.BetLo -1) * $this.Units)
					$this.BetHi = ( ($this.BetLo -1) * $this.Units)
						
				}
				
			
			read-host "stopped"
				
				Continue

			}
	 <#   	
		} ElseIF ( $Spin -eq 's13' ) {
			If ( $this.BetZone -eq '13' ) { Write-Host -f Red $Message ; Start-Sleep 2 ; Continue }
			$this.BetZone = 13
			$this.BetLo = $this.BetMed
			$this.BetHi = $this.BetMed
		} ElseIF ( $Spin -eq 's23' ) {
			If ( $this.BetZone -eq '23' ) { Write-Host -f Red $Message ; Start-Sleep 2 ; Continue }
			$this.BetZone = 23
			$this.BetMed = $this.BetLo
			$this.BetHi = $this.BetLo
		}	
	
	}	##	END METHOD
## ▲
<#	
	[Void] Display() {	## ▼▼
		Write-Host -f DarkGray "01234567890123456789012345678901234567890123456789012345678901234567890123456789"
		##	BetNumber
		Write-Host -n -f Darkgray  " Bet: "
		$len =  ((($this.Gob).Count) + 1 ).tostring().length
		For ( $i=1; $i -lt ( 5 - $len ) ; $i++ ) { Write-Host -no " " } # Spaces After 'Bank'
		Write-Host -n -f Darkgray ( ($this.Gob).Count + 1 )
		##	Timer
		$hrs   = $null; $mins = $null ; $secs  = $null
		Write-Host -n -f Darkgray '   Time: '
		$hrs  = '{0:0}' -f ($this.TimerObj.Elapsed.Hours)
		$mins = '{0:00}' -f $this.TimerObj.Elapsed.Minutes
		#$secs = '{0:00}' -f $this.TimerObj.Elapsed.Seconds ;  ## Uncomment to Display secs
		If ( $secs -eq  $null  ) { Write-Host ('{0}:{1}' -f $hrs,$mins ) -nonewline -f DarkGray }
		Else { Write-Host ('{0}:{1}:{2}' -f $hrs , $mins , $secs ) -nonewline -f DarkGray }
		##	Cash
		Write-Host -n -f Darkgray  "   Cash: "
		$dollars  = '{0:C0}' -f $this.Bank
		If ( $this.Bank -ge 0 ) { $color = 'green' } Else { $color = 'red' }
		$len =  $dollars.tostring().length
		For ( $i=1; $i -lt ( 8 - $len ) ; $i++ ) { Write-Host -no " " } # Spaces After 'Cash'
		Write-Host -f $color $dollars
		##	HighLow
		Write-Host -n -f DarkGray '       Lo: '
		$lowcash  = '{0:C0}' -f $this.LowBank
		$lowcashLen =  $lowcash.tostring().length
		For ( $i=1; $i -lt ( 7 - $lowcashLen ) ; $i++ ) { Write-Host -no "" } ;  ##	Spaces After	'Lo:'   √
		Write-Host -n -f DarkGray  $lowcash
		For ( $i=1; $i -lt ( 11 - $lowcashLen ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces Before	'Hi'   √
		Write-Host -n -f DarkGray  'Hi: '
		$highcash  = '{0:C0}' -f $this.HighBank
		$highcashLen =  $highcash.tostring().length
		For ( $i=1; $i -lt ( 9 - $highcashLen ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After	'Hi:'  √
		Write-Host  -f DarkGray  $highcash
		##	Last/Prior
		If ( $this.Gob.Count -eq 1 ) {
			Write-Host -n -f darkgray  " Last: "
			$len = $this.Gob[-1].tostring().length
			For ( $i=1; $i -lt ( 3 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	'Last'
			Write-Host -n $this.Gob[-1]
		} ElseIf ( $this.Gob.Count -gt 1 ) {
			Write-Host -n -f darkgray  " Last: "
			$len = $this.Gob[-2].tostring().length
			For ( $i=1; $i -lt ( 3 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	'Last'
			Write-Host -n $this.Gob[-1]
			Write-Host -n -f darkgray  "   Prior: "
			Write-Host -n -f darkgray $this.Gob[-2]
		}
		##	Line
		$indent = 2 ;
		$length = 39 ;
		$color = 'DarkGray' ;
		If ( $this.Gob.Count -gt 0 ) {
		for ($i=1; $i -lt $indent ; $i ++) { Write-Host -n -f $color "`n " }
		for ($i=1; $i -lt $length ; $i ++) { Write-Host -n -f $color "_" }
		Write-Host
		}







<#


		##	Last
		$lop = $null
		$medp = $null
		$hip = $null
		$loCount = $null
		$medCount = $null
		$hiCount = $null
		$loColor = $medColor = $hiColor = 'cyan'
		$PercentRA = $loP, $medP, $hiP
		## Highest
		IF ( ($loP -gt $medP ) -AND ( $loP -gt $hiP)  ) { $loColor  =  'Green' }
		IF ( ($medP -gt $loP ) -AND ( $medP -gt $hiP)  ) { $medColor  =  'Green' }
		IF ( ($hiP -gt $loP ) -AND ( $hiP -gt $medP)  ) { $hiColor  =  'Green' }
		## Lowest
		IF ( ($loP -lt $medP ) -AND ( $loP -lt $hiP)  ) { $loColor  =  'Red' }
		IF ( ($medP -lt $loP ) -AND ( $medP -lt $hiP)  ) { $medColor  =  'Red' }
		IF ( ($hiP -lt $loP ) -AND ( $hiP -lt $medP)  ) { $hiColor  =  'Red' }
		$loCount  = '{0:0}' -f  $loCount ; $medCount  = '{0:0}' -f  $medCount ; $hiCount  = '{0:0}' -f  $hiCount
		$loP  = '{0:P0}' -f  $loP ; $medP  = '{0:P0}' -f  $medP ; $hiP  = '{0:P0}' -f  $hiP
		If ( ( ($this.Gob).Count -gt 1 -AND $num -eq 1) -OR ($this.Gob).Count -ge $num ) {
			Write-Host
			## Lo
			$len = $loCount.Length ; For ( $i=1; $i -lt ( 7 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before LoCount
			Write-Host -n -f DarkGray $loCount;
			$len = $loP.Length ; For ( $i=1; $i -lt ( 5 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before LoP
			Write-Host -n -f $loColor $loP
			## Med
			$len = $medCount.Length ; For ( $i=1; $i -lt ( 7 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before medCount
			Write-Host -n -f DarkGray $medCount
			$len = $medP.Length ; For ( $i=1; $i -lt ( 5 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before medP
			Write-Host -n -f $medColor $medP
			## Med
			$len = $hiCount.Length ; For ( $i=1; $i -lt ( 7 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before hiCount
			Write-Host -n -f DarkGray $hiCount
			$len = $hiP.Length ; For ( $i=1; $i -lt ( 5 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before hiP
			Write-Host -n -f $hiColor $hiP
			## WinRate
			$winRate = $winCount = $text = $null
			If ( $num -eq 1 ){
				Foreach ($item in $this.WinsRA ) { If ($item -eq 'W' ) { $winCount ++ } }
				$WinRate ='{0:P0}' -f ($winCount / $this.Gob.Count)
				$len = $WinRate.Length ; For ( $i=1; $i -lt ( 6 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before WinRate
				$text = ' ALL'
			} Else {
				Foreach ($item in $this.WinsRA[-$num..-1] ) { If ($item -eq 'W' ) { $winCount ++ } }
				$WinRate ='{0:P0}' -f ( $winCount / $this.Gob[-$num..-1].Count )
				$len = $WinRate.Length ; For ( $i=1; $i -lt ( 6 - $len ) ; $i++ ) { Write-Host -no " " } ##	Spaces Before WinRate
				$text = " $winCount/$num"
			}
			Write-Host -n -f Yellow $Winrate $text
			
		}	## END IF








#>


#	}	##	END METHOD
## ▲
<#	
	[Void] NoHits() {	## ▼▼
	<#
		$NoHitsLo = $null; $NoHitsMed = $null ; $NoHitsHi = $null
		If ( ($this.Gob).Count -gt 0 ) {
			For ( $i = 0 ; $i -lt $this.Gob.Count ; $i ++ ) {
				If ( $this.Gob[$i] -eq 0 ) {
					$NoHitsLo ++ 
					$NoHitsMed ++ 
					$NoHitsHi ++ 
				}
				If ( $this.Gob[$i] -in 1..12 ) {
					$NoHitsLo = 0 
					$NoHitsMed ++ 
					$NoHitsHi ++ 
				}
				If ( $this.Gob[$i] -in 13..24 ) {
					$NoHitsLo  ++ 
					$NoHitsMed = 0
					$NoHitsHi ++ 
				}
				If ( $this.Gob[$i] -in 25..36 ) {
					$NoHitsLo  ++ 
					$NoHitsMed ++
					$NoHitsHi = 0
				}
			} ##	END Foreach
			$viewcntr = 10
			If ( $NoHitsLo -ge $viewcntr -OR $NoHitsMed -ge $viewcntr -OR  $NoHitsHi -ge $viewcntr ){
				Write-Host "`n`n`n"
				If ( $NoHitsLo -ge $viewcntr ) {
					Write-Host -n "  No Lo:  " ; Write-Host -f r $NoHitsLo
				}
				If ( $NoHitsMed -ge $viewcntr ) {
					Write-Host -n " No Med:  " ; Write-Host -f r $NoHitsMed
				}
				If ( $NoHitsHi -ge $viewcntr ) {
					Write-Host -n "  No Hi:  " ;  Write-Host -f r $NoHitsHi
				}
			} ##	END If
		} ##	END If
	}	##	END METHOD
## ▲
<#	
	[Void] DoAuto() {	## ▼▼
	<#
		If ( $this.Gob.Count -ge $this.Tracking ) {
		[int] $HighSpins = $null
		[int] $MedSpins = $null
		[int] $LowSpins = $null
		$PercentLo = $null
		$PercentMed = $null
		$PercentHi =  $null
			Foreach ( $item in $this.Gob[-$this.Tracking..-1] ) {
				##	Lo
				If ( $item -in 1..12 )  { $LowSpins ++  ; }
				If ( $item -in 13..24 ) { $MedSpins ++  ; }
				If ( $item -in 25..36 ) { $HighSpins ++ ; }
				[int] $PercentLo = ( $LowSpins / $this.Tracking * 100 )
				[int] $PercentMed = ( $MedSpins / $this.Tracking * 100 )
				[int] $PercentHi = ( $HighSpins / $this.Tracking * 100 )

			}
			Write-Host
			Write-Host  $PercentLo
			Write-Host  $PercentMed
			Write-Host  $PercentHi
			If ( $PercentLo -lt $this.PercentLimit ) {
				$this.Betzone = 23
#				[int]	$this.BetLo  = $Max
#				[int] $this.BetMed = $Max
#				[int]	$this.BetHi  = $Max
			}
		}	
	}	##	END METHOD

## ▲
#>




<#


	
} ## ▲ END Class Dozens
$OB = [Dozens]::new()
$OB.AllowExit = 1
$OB.BetZone = 12
$OB.OpeningBet = 10
$OB.Units = 1
$OB.BettingMethod = "Up2"
$OB.BetSize = $OB.OpeningBet
$OB.GetPercentagesRA = 1,5,10
While (1) {
	$OB.Start()
	$spin  = Read-Host -Prompt "$("`n" * 4 ) $(" " * (10)) Enter Spin"
	$OB.SpinValidate( $spin )
	Clear-Host
	While (1) {
#		$MyUpdateTimer =  [system.diagnostics.stopwatch]::startnew()
		If ( $OB.ValidSpin ) {
			$OB.Update( $spin )
		}
		$OB.Display()
		$spin  = Read-Host -Prompt "$("`n" * 4 ) $(" " * (10)) Enter Spin"
		$validSpin = $OB.SpinValidate( $spin )
		Clear-Host

	}
<#
#TODO fix add content if spin equals return only  ????
	## Add Content 	▼▼
	$DataPath = 'D:\GitHub\manual' ; $TheDate =  Get-Date -UFormat %b%e ; $Ext = 'txt'
	$DataFile  =  ($DataPath + "\" + $Site + "." + $TheDate + "." + $Ext)
	If ($Site ) { $spin | Add-Content $DataFile }
##▲
#>

#} ##	THE END

##  RED + ODD + Colum1 +_ Column3
##  CASH IS WRONG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<#
	Write-Host	'spin '   $spinT
	Write-Host	'spinT1 ' $spinT1
	Write-Host	'time '$timeT
	Write-Host	'cash '$timecash
	Write-Host	'cashlohigh '	$timecashlohigh
	Write-Host	'previous '$timeprevious
	Write-Host	'dolly '$timedolly
	Write-Host	'line '$timeline
	Write-Host	'percentages '$timepercentages
#>

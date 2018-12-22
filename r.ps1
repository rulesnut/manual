﻿
##	Site
$Site = '888'
$Site = '' # comment out to save to HD

##	Class Definition
Class Dozens {
	##	Properties
##	▼▼
	[string]	$BetLo
	[string]	$BetHi
	[string]	$BetMed
	$BetLoPrevious
	$BetHiPrevious
	$BetMedPrevious
	[int]		$BetZone
	[int]		$Cash
	[int]		$OpeningBet
	[string]	$Spin
	[string]	$Tick
	[int]		$Units
	[string]	$WinLose = ''
#	[int] $BetCount
#	[int] $BetTotal
#	[int] $HighBank
#	[int] $LowBank
#	[int] $PercentHi
#	[int] $PercentLimit
#	[int] $PercentLo
#	[int] $PercentMed
#	[int] $Tracking
	$Gob = [System.Collections.ArrayList] @()
	$TimerObj =  [system.diagnostics.stopwatch]::startnew()
	$WinsRA = [System.Collections.ArrayList] @()
##▲	END Properties
	## Update Method
	[Void] Update( $spin, $UpdateTimer  ) {	## ▼ ▼
		## Add spin to Gob
		$this.Gob += $spin
		$this.Spin = $spin
		##	WinOrLose
		## ▼▼
			Switch ( $this.Gob[-1] ) {
				{ $_ -in 0 } { $this.WinLose = 'L' ; BREAK }  ##	Spin 0
				{ $_ -in 1..12 } {  ##	Spin Lo
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12'; BREAK }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' ; BREAK }
					Else { $this.WinLose = 'L23'; BREAK }
				}
				{ $_ -in 13..24 } { ##	Spin Med
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W12' }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'L13' }
					Else {$this.WinLose = 'W23'; BREAK }
				}
				{ $_ -in 25..36 } { ##	Spin Hi
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'L12' }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W13' }
					Else {$this.WinLose = 'W23'; BREAK }
				}
			}##	END Switch
		## ▲
		##	Opening Bets
		## ▼▼
		If ( $this.Gob.Count -eq 1 ){
			if ( $this.Betzone -eq  12 ) {
				$this.BetLoPrevious  = $this.BetLo  = $this.OpeningBet
				$this.BetMedPrevious = $this.BetMed = $this.OpeningBet
				$this.BetHiPrevious  = $this.BetHi  = $null
			}	Elseif ($this.Betzone -eq 13 ) {
				$this.BetLoPrevious  = $this.BetLo  = $this.OpeningBet
				$this.BetMedPrevious = $this.BetMed = $null
				$this.BetHiPrevious  = $this.BetHi  = $this.OpeningBet

			} Else {
				$this.BetLoPrevious = $this.BetLo =  $null
				$this.BetMedPrevious = $this.BetMed = $this.OpeningBet
				$this.BetHiPrevious = $this.BetHi = $this.OpeningBet
			}
		}
		## ▲
		##  All Bets
		## ▼ ▼
		If ( $this.WinLose.substring(0,1) -eq 'W' ) {
	   
		}
		
		## ▲

		##	Opening Cash
		## ▼▼
		If ( $this.Gob.Count -eq 1 ){
			if ( $this.Betzone -eq  12 ) {
				$this.BetLoPrevious  = $this.BetLo  = $this.OpeningBet
				$this.BetMedPrevious = $this.BetMed = $this.OpeningBet
				$this.BetHiPrevious  = $this.BetHi  = $null
			}	Elseif ($this.Betzone -eq 13 ) {
				$this.BetLoPrevious  = $this.BetLo  = $this.OpeningBet
				$this.BetMedPrevious = $this.BetMed = $null
				$this.BetHiPrevious  = $this.BetHi  = $this.OpeningBet

			} Else {
				$this.BetLoPrevious = $this.BetLo =  $null
				$this.BetMedPrevious = $this.BetMed = $this.OpeningBet
				$this.BetHiPrevious = $this.BetHi = $this.OpeningBet
			}
		}
		## ▲
#$y += $line.substring(0,$amount) } 

		##  Update Cash

		##  Switch Bets
	
			fff  "Do you want to Switch bets"
			fff  "Show Percentages"
	
	
	<#	Else {
			if ( $this.Betzone -eq  12 ) {
				$betLo =  $this.OpeningBet
				$betMed =  $this.OpeningBet
			}	Elseif ($this.Betzone -eq 13 ) {
				$betLo =  $this.OpeningBet
				$betHi =  $this.OpeningBet

			} Else {
				$betMed =  $this.OpeningBet
				$betHi =  $this.OpeningBet
			}

		}	
#>
		fff "`n`n`n`n`n`n`n`n`nthis is winorlose " $this.WinLose
		fff 'this is betLo ' $this.BetLo
		fff 'this is betMed ' $this.BetMed
		fff 'this is betHi ' $this.BetHi
		$this.Tick =   $UpdateTimer.ElapsedTicks
		fff -f magenta $this.Tick
		}##	END Update METHOD
## ▲
	
## ***********************************************************************************************	
	[Void] Display() {	## ▼ ▼
		##	Results
		$color = $null
		$message = $null
		Write-Host  -f yellow  $($this.Tick)  ## Started out at 13 or 14 thousand ticks
		Write-Host -f DarkGray "01234567890123456789012345678901234567890123456789012345"

		
		
		Write-Host -f DarkGray " Results of Bet $($this.Gob.Count[-1]): "
		Write-Host -f darkcyan "  Lo          Med          Hi          Dolly"
		If (	$this.BetLoPrevious -lt 1 ) { $lenL = 1 } Else { [int]	$lenL = [Math]::Floor([Math]::Log10($this.BetLoPrevious) + 1) }
		If (	$this.BetMedPrevious -lt 1 ) { $lenM = 1 } Else { [int]	$lenM = [Math]::Floor([Math]::Log10($this.BetLoPrevious) + 1) }
		If (	$this.BetHiPrevious -lt 1 ) { $lenH = 1 } Else { [int]	$lenH = [Math]::Floor([Math]::Log10($this.BetLoPrevious) + 1) }



		Write-Host " " $( $this.BetLoPrevious ) $(" " * ( 5 - $lenL ) ) $( $this.BetMedPrevious ) $(" " * ( 8 - $lenM ) ) $( $this.BetHiPrevious )  $(" " * ( 8 - $lenH ) ) $( $this.spin )
	
		fff $lenL
		fff $lenM
		fff $lenH
	
#Write-Host "this is a test"  $(" " * $len) "of numbers and spaces " $test

			
		
		
			Write-Host -n "   $($this.BetLo)     $($this.BetMed)     $($this.BetHi)      " 
			If ( $this.WinLose = 'W12') {
				$color = 'Green'
				$message = "You Won $($this.BetLo) "
			}
			Write-Host -n  -f $color  $this.spin  $message
	#		
	#$lo  = '{0:0}' -f $lo
	#		If ( $lo -gt 0 ) {$len = $lo.tostring().length } Else { $len = 0 } 
	#		For ($i=1; $i -lt ( 8 - $len ) ; $i++) { Write-Host -no " " } ## Before Lo
	#		Write-Host -n -f White $lo
	#		If ( $med -gt 0 ) {$len = $med.tostring().length } Else { $len = 0 }
	#		For ($i=1; $i -lt ( 11 - $len ); $i++) { Write-Host -no " " } ## Before Med
	#		Write-Host -n -f White $med
	#		If ( $hi -gt 0 ) {$len = $hi.tostring().length } Else { $len = 0 } 
	#		For ($i=1; $i -lt ( 10 - $len ); $i++) { Write-Host -no " " } ## Before Hi
	#		Write-Host -n -f White $hi
	#		$len = $dollarsbet.tostring().length
	#		For ($i=1; $i -lt ( 14 - $len ); $i++) { Write-Host -no " " } ## Before DollarsBet
	#		Write-Host -n  -f White $dollarsbet


<#

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
#>
	}	##	END METHOD
## ▲

<#
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


#>




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


	
} ## ▲ END Class Dozens
## ***********************************************************************	
	## Call WinOrLose()
#	$WinOrLoseResult = $this.WinOrLose( $spin )
#	fff 'this is winorlose spin'  $spin
#	fff 'this is WinOrLoseResult' $WinOrLoseResult
#	fff 'this is winsRa'  $this.WinsRA
	# How much did I win or loose
#	$WonLostOnBet = 0







<#


		## Update Bank
		If ( $this.WinLose -eq 'W' ) { $this.Bank += ($this.BetTotal/2) } Else { $this.Bank += -$this.BetTotal }
		## Update Bets
			If ( $this.WinLose -eq  'L' ) {
				$this.BetLo =  $this.BetLo + ( 2 * $this.Units )
				$this.BetMed =  $this.BetMed + ( 2 * $this.Units )
				$this.BetHi =  $this.BetHi + ( 2 * $this.Units )
			} Else {
				$this.BetLo --
				$this.BetMed --
				$this.BetHi --
			}
		If ( $this.BetLo -le $this.OpeningBet ) { $this.BetLo = $this.OpeningBet }
		If ( $this.BetMed -le $this.OpeningBet ) { $this.BetMed = $this.OpeningBet  }
		If ( $this.BetHi -le $this.OpeningBet ) { $this.BetHi = $this.OpeningBet  }
#>	
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
				fff 'this is $locount' $loCount
				fff 'this is $medcount' $medCount
				fff 'this is $hicount' $hiCount
				fff 'this is $gob count' $this.Gob.Count
				fff	'this is$this.PercentLo ' $this.PercentLo
				fff	'this is $this.PercentMed' $this.PercentMed
				fff	'this is $this.PercentHi' $this.PercentHi
			}
		}

	}	##	END METHOD
		#		fff 'medcount' $medcount
		#		fff 'hicount' $hicount
<#
		If ( $this.Gob.Count -gt 0 ) {
				fff 'gob.count greater than 0 '
				fff 'loCount' $locount
				fff 'medcount' $medcount
				fff 'hicount' $hicount
				fff 'gobcount' $this.Gob.Count
				$manLo = $locount/$this.Gob.count
				fff 'manLo' $manLo
				$manmed = $medcount/$this.Gob.count
				fff 'manmed' $manmed
				$manHi = $hicount/$this.Gob.count
				fff 'manhi' $manHi
				$this.PercentLo = $locount/$this.Gob.count*100
				$this.PercentLo  = $loCount/$this.Gob.Count*100
				$this.PercentMed = $medCount/$this.Gob.Count*100
				$this.PercentHi  = $hiCount/$this.Gob.Count*100
				fff -f magenta $this.PercentLo
				fff -f magenta $this.PercentMed
				fff -f magenta $this.PercentHi
		} Else {
			If (  ($this.Gob).Count -ge 0 -AND ($this.Gob).Count -ge $num ) {
				fff 'in else'
				Sleep 2
				Foreach ( $item in ( $this.Gob[-$num..-1]) ) {
					Switch ( $item ) { { $_ -in 0 } { BREAK }     ##	0
						{ $_ -in 1..12 }  { $loCount ++  ; BREAK }	##	Lo
						{ $_ -in 13..24 } { $medCount ++ ; BREAK }	##	Med
						{ $_ -in 25..36 } { $hiCount ++  ; BREAK }	##	Hi
					}
				}
					$this.PercentLo  = $loCount/$num
					fff -f y $this.PercentLo
					Sleep 1

					$this.PercentMed = $medCount/$num
					$this.PercentHi  = $hiCount/$num
			}
		}

#>
		#fff 'this is percentLo' $this.PercentLo
		#fff 'this is percentmed' $this.PercentMed
		#fff 'this is percentHi' $this.PercentHi

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
				fff 'minidex is zero'
				Sleep 2
			} Elseif  ( $minIndex -eq 1 ) {
				fff 'minidex is 1'
			} Else {
				fff 'minidex is 2'
			}		

			If ( $minIndex = 2 ) {
			}	
			fff $this.BetLo
			fff $this.BetMed
			fff $this.BetHi
			fff $this.WinLose
			fff $this.WinsRA[-1]
			fff $PercentLo
			fff $PercentMed
			fff $PercentHi
			fff $minIndex
			fff $MinValue
			
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
			fff
			fff  $PercentLo
			fff  $PercentMed
			fff  $PercentHi
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

## *******************************************************************
$Spin = $null
$Payout = 2
$OB = [Dozens]::new()
$OB.BetZone = 12
$OB.OpeningBet = 9999
$OB.Units = 2

Clear-Host
Write-Host  "`n BetZone: $($OB.BetZone)  Units: $($OB.Units)  Inital Bet: $($OB.OpeningBet)"
While ( 1 ) {
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


	$spin = Read-Host -Prompt "`n`n`n                         Enter Spin"  ## Read-Host
##	▼▼	Spin Validation
	#If ( $OB.PercentLimit -lt 30 ) {  ## Like 10 losses in a row 
		#$OB.SwitchingAuto()
	#}
	if ( $spin -eq 't' -OR $spin -eq 'tt'  -OR $Spin -eq 'rr' ) { ##	PR = Restart function in profile ....NOT For PRODUCTION
		Write-Host -f Cyan '    Reloading Powershell' ; sleep 1 ; rr ; exit
	} 
	if ( $Spin -match "^\d+$" ) {	##  Integer
		If ( $Spin -notmatch '^[0-9]$'  -AND $Spin -notmatch '^[1-2][0-9]$' -AND $Spin -notmatch '^[3][0-6]$' )  {
			Write-Host -f Red " Input Error !!!" ; Start-Sleep  2 ; Clear-Host ; Continue
		}
	}
	#} Else {
	#	If ( $Spin -eq 's12' -OR $Spin -eq 's13'  -OR $Spin -eq 's23'  ) {
	#		$OB.Switching($Spin)
	#		Continue
	#	} Else {
	#		Write-Host -f Red " Input Error !!!" ; Start-Sleep  2 ; Clear-Host ; Continue
	#	}
	#}
## ▲	END VALIDATION
	## Add Content 	▼▼
	$DataPath = 'D:\GitHub\manual' ; $TheDate =  Get-Date -UFormat %b%e ; $Ext = 'txt'
	$DataFile  =  ($DataPath + "\" + $Site + "." + $TheDate + "." + $Ext)
	If ($Site ) { $spin | Add-Content $DataFile }
##▲


	$UpdateTimer =  [system.diagnostics.stopwatch]::startnew()
	$OB.Update( $Spin, $UpdateTimer )
	Clear-Host
	$OB.Display()

} ##	 End	 While

##	▼▼
## ▲


######## Put is a FileSite to Save to HD
$FileSite = '888'
########

##	▼▼	Path Setup
$DataPath = 'D:\GitHub\manual' ;
$TheDate =  Get-Date -UFormat %b%e
$Ext = 'txt';
$DataFile  =  ($DataPath + "\" + $FileSite + "." + $TheDate + "." + $Ext)
## ▲	END Content Path
##                                  #


Class Dozens {
	## Properties
	[int] $BetZone = 12 ; [int] $OpeningBet = 1 ; [int] $Units = 1
	$TimerObj =  [system.diagnostics.stopwatch]::startnew() ; $Gob = [System.Collections.ArrayList] @() ; $WinsRA = [System.Collections.ArrayList] @()
	[int] $Bank ; [int] $HighBank ;  [int] $LowBank ; [int] $BetTotal = 0 ; [int] $BetLo ; [int] $BetMed ; [int] $BetHi ; [string] $WinLose
	[int] $Tracking = 5 ; $PercentLimit = 20 ;
	## Methods
	[Void] Betcount() {	##	▼▼
		$betcount = ( ( $this.Gob ).Count + 1 )
		$len =  $betcount.tostring().length
		Write-Host -n -f Darkgray  " Bet:"
		For ( $i=1; $i -lt ( 6 - $len ) ; $i++ ) { Write-Host -no " " } #	Spaces After Bet:
		Write-Host -n -f Darkgray $betcount
		For ( $i=1; $i -lt 4 ; $i++ ) { Write-Host -no " " }  #	Spaces After $betcount
	}	##	END METHOD
## ▲
	[Object] Static  GetLength( $arg ) {	##	▼▼
		[int ] $arg = ( $arg ).tostring().length
		Return $arg
	}
## ▲
	[Void] Timer( $TimerObj ) {	## ▼▼
		$secs = $null
		Write-Host -n -f Darkgray 'Time: '
		$hrs  = '{0:0}' -f ($TimerObj.Elapsed.Hours)
		$mins = '{0:00}' -f $TimerObj.Elapsed.Minutes
#		$Secs = '{0:00}' -f $TimerObj.Elapsed.Seconds ;  ## Uncomment to Display Seconds
		If ( $secs -eq  $null  ) { Write-Host ('{0}:{1}' -f $hrs,$mins ) -nonewline -f DarkGray }
		Else { Write-Host ('{0}:{1}:{2}' -f $hrs , $mins , $secs ) -nonewline -f DarkGray }
	}
## ▲
	[Void] Cash()	{	##	▼▼
		Write-Host -n -f Darkgray  "  Cash: "
		$dollars  = '{0:C0}' -f $this.Bank
		If ( $this.Bank -ge 0 ) { $color = 'green' } Else { $color = 'red' }
		$len =  $Dollars.tostring().length
		For ( $i=1; $i -lt ( 9 - $len ) ; $i++ ) { Write-Host -no " " } # Spaces After 'Bank'
		Write-Host -f $color $dollars
		If ( ($this.Gob).Count -eq 0 ) {	# no bets so far
			$indent = 2
			$length = 39
			$color = 'DarkGray'
			for ($i=1; $i -lt $indent ; $i ++) { Write-Host -n -f $color " " }
			for ($i=1; $i -lt $length ; $i ++) { Write-Host -n -f $color "_" }
		Write-Host
		}
	}
## ▲
	[Void] HighLow()	{	##	▼▼
			$lowcash = 0 ; $lowcashLen = 0 ; $highcash = 0 ; $highcashLen = 0 ;
		If ( $this.Gob.Count -gt 0 ) {
			If  ( ( [int] $this.Bank ) -le ( [int] $this.LowBank ) ) {
				$this.LowBank = $this.Bank
			} ElseIf  ( ( [int] $this.Bank ) -gt ( [int] $this.HighBank ) ) {
				$this.HighBank = $this.Bank
			}	
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
	}	##	END METHOD
## ▲
	[Void] LastPrior() {	## ▼▼
		If ( ( $this.Gob ).Count -gt 0 ) {	
			##	Color
			If ( $this.WinLose -eq 'W' ) { 
				$color = 'green'; $wonlost = '   You Won!' ; $bt = $this.BetTotal ;
			} Else { 
				$color = 'red'; $wonlost = '  You Lost!' ; $bt = -$this.BetTotal ;
			}
			If ( ($this.Gob).Count  -eq 1 ) {
				Write-Host -n -f Darkgray  " Last: "
				$len = $this.Gob[-1].tostring().length
				For ( $i=1; $i -lt ( 4 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	'Last'
				Write-Host -n -f white $this.Gob[-1]
				For ( $i=1; $i -lt 19 ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After	Gob[-1]
				Write-Host -f $color $wonlost ;
			#	$bt = '{0:C0}' -f $bt ; #	Total Bet as Currency
			#	$len = $bt.tostring().length
			#	For ( $i=1; $i -lt ( 9 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	$WonLost
			#	Write-Host -f darkgray $bt ;
			}
			If ( ($this.Gob).Count -gt 1 ) {
				Write-Host -n -f darkgray  " Last: "
				$len = $this.Gob[-1].tostring().length
				For ( $i=1; $i -lt ( 4 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	'Last'
				Write-Host -n -f darkgray $this.Gob[-1]
				For ( $i=1; $i -lt 4 ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After	Gob[-1]
				Write-Host -n -f darkgray  "Prior: "
				$len = $this.Gob[-2].tostring().length
				For ( $i=1; $i -lt ( 4 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	Gob[-2]
				Write-Host -n -f darkgray $this.Gob[-2]
				Write-Host  -f $color "    " $wonlost
			#	$bt = '{0:C0}' -f $BT ; #	Total Bet as Currency
			#	$len = $bt.tostring().length
			#	For ( $i=1; $i -lt ( 9 - $len ) ; $i++ ) { Write-Host -no " " } ;  ##	Spaces After the word	$WonLost
			#	Write-Host -f darkgray $bt ;
			}
			## Line	
			$indent = 2 ;
			$length = 39 ;
			$color = 'DarkGray' ;
			for ($i=1; $i -lt $indent ; $i ++) { Write-Host -n -f $color " " }
			for ($i=1; $i -lt $length ; $i ++) { Write-Host -n -f $color "_" }
			Write-Host
		}
	}	##	END METHOD
## ▲
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
		$dollarsbet  = '{0:C0}' -f $this.BetTotal
		##	Display 
		Write-Host -f darkgreen "`n`n`n`n     Lo       Med       Hi          Bet"
		$lo  = '{0:0}' -f $lo
		If ( $lo -gt 0 ) {$len = $lo.tostring().length } Else { $len = 0 } 
		For ($i=1; $i -lt ( 8 - $len ) ; $i++) { Write-Host -no " " } ## Before Lo
		Write-Host -n -f White $lo
		If ( $med -gt 0 ) {$len = $med.tostring().length } Else { $len = 0 }
	  	For ($i=1; $i -lt ( 11 - $len ); $i++) { Write-Host -no " " } ## Before Med
		Write-Host -n -f White $med
		If ( $hi -gt 0 ) {$len = $hi.tostring().length } Else { $len = 0 } 
		For ($i=1; $i -lt ( 10 - $len ); $i++) { Write-Host -no " " } ## Before Hi
  	 	Write-Host -n -f White $hi
		$len = $dollarsbet.tostring().length
	 	For ($i=1; $i -lt ( 14 - $len ); $i++) { Write-Host -no " " } ## Before DollarsBet
   		Write-Host -n -f White $dollarsbet
	}	##	END METHOD
## ▲
	[Void] Last( $num ) {	## ▼▼
		$loP = $medP = $hiP = $null  ## P is for Percentage
		$PercentRA = $lop, $medP, $hiP
		$loCount = 0
		$medCount = 0
		$hiCount = 0
		##	Get Individual Count
##	▼▼
		If ( $num  -eq 1 ) {
			Foreach ( $item in $this.Gob ) {
				Switch ( $item ) {
					{ $_ -in 0 } { BREAK }  ##	Spin 0
					{ $_ -in 1..12 }  { $loCount ++  ; BREAK }	##	Lo
					{ $_ -in 13..24 } { $medCount ++ ; BREAK }	##	Med
					{ $_ -in 25..36 } { $hiCount ++  ; BREAK }	##	Hi
				}
			}
			If ( ($this.Gob).Count -gt 0 ) {
				$loP  = ( $loCount /  ($this.Gob).Count )
				$medP  = ( $medCount /  ($this.Gob).Count )
				$hiP  = ( $hiCount /  ($this.Gob).Count )
			}
		} Else {
			If (  ($this.Gob).Count -ge 0 -AND ($this.Gob).Count -ge $num ) {
				Foreach ( $item in ( $this.Gob[-$num..-1]) ) {
					Switch ( $item ) { { $_ -in 0 } { BREAK }     ##	0
						{ $_ -in 1..12 }  { $loCount ++  ; BREAK }	##	Lo
						{ $_ -in 13..24 } { $medCount ++ ; BREAK }	##	Med
						{ $_ -in 25..36 } { $hiCount ++  ; BREAK }	##	Hi
					}
				}
					$loP  = ( $loCount /  $num )
					$medP = ( $medCount / $num )
					$hiP  = ( $hiCount /  $num )
			}
		}	##  END INDIVIDUAL COUNT
## ▲
		##	Determine Color
##	▼▼
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
## ▲
		##	Display
##	▼▼
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
## ▲
	}	##	END METHOD

## ▲
	[Void] Update() {	## ▼▼
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
		}	##	END	METHOD
## ▲
	[Void] WinOrLose() {	## ▼▼
		If ( ($this.Gob).Count -gt 0 ) {
			Switch ( $this.Gob[-1] ) {
				{ $_ -in 0 } { $this.WinLose = 'L' ; BREAK }  ##	Spin 0
				{ $_ -in 1..12 } {  ##	Spin Lo
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W'; BREAK }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W' ; BREAK }
					Else { $this.WinLose = 'L'; BREAK }
				}
				{ $_ -in 13..24 } { ##	Spin Med
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'W' }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'L' }
					Else {$this.WinLose = 'W'; BREAK }
				}
				{ $_ -in 25..36 } { ##	Spin Hi
					If  ( $this.BetZone -eq 12 ) { $this.WinLose = 'L' }
					Elseif ( $this.BetZone -eq 13 ) { $this.WinLose = 'W' }
					Else {$this.WinLose = 'W'; BREAK }
				}
			} ##	END Switch
#			If ( $this.WinLose -eq 'W' ) {
				$this.WinsRA += $this.WinLose
#			}
		} ##	END If
	}	##	END METHOD
## ▲
	[Void] Switching( $Spin ) {	##	▼▼
		$message = "You are already in that BetZone, Dufus"
		If ( $Spin -eq 's12' ) {
			If ( $this.BetZone -eq '12' ) { Write-Host -f Red $Message ; Start-Sleep 2 ; Continue }
			$this.BetZone = 12
			$this.BetLo = $this.BetHi
			$this.BetMed = $this.BetHi
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
	[Void] SwitchingAuto() {	##	▼ ▼
		If ( ($this.Gob).Count -ge $this.Tracking ) {
## What if there is more than 1 that is low????
## Need percentlo...
			$HighSpins = $null
			$MedSpins = $null
			$LowSpins = $null
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
	#>		
		}	
	}	##	END METHOD

## ▲
	[Void] NoHits() {	## ▼▼
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
	[Void] DoAuto() {	## ▼▼
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
} ## END Class

$OB = [Dozens]::new() ; $OB.BetLo  = $OB.OpeningBet ; $OB.BetMed = $OB.OpeningBet ; $OB.BetHi  = $OB.OpeningBet
While ( 1 ) {
	Clear-Host ; Write-Host;
	If (! $FileSite ) { Write-Host -f y  "`n       Not Saving To HD!! `n`n" }
	$OB.BetCount()
	$OB.Timer( $OB.TimerObj )
	$OB.Cash()
	$OB.HighLow()
	$OB.LastPrior()
	$OB.Last(1)
	$OB.Last(30)
	$OB.Last(24)
	$OB.Last(18)
	$OB.Last(12)
	$OB.Last(6)
	$OB.NoHits()
	$OB.Bets()
#	$OB.DoAuto()
		
	$Spin = Read-Host -Prompt "`n`n`n                         Enter Spin"  ## Read-Host
##	▼▼	Spin Validation
	If ( $OB.PercentLimit -lt 30 ) {  ## Like 10 losses in a row 
		$OB.SwitchingAuto()
	}
	if ( $Spin -eq 't' -OR $Spin -eq 'tt'  -OR $Spin -eq 'rr' ) { ##	PR = Restart function in profile ....NOT For PRODUCTION
		Write-Host -f Cyan '    Reloading Powershell' ; sleep 1 ; rr ; exit
	} 
	if ( $Spin -match "^\d+$" ) {	##  Integer
		If ( $Spin -notmatch '^[0-9]$'  -AND $Spin -notmatch '^[1-2][0-9]$' -AND $Spin -notmatch '^[3][0-6]$' )  {
			Write-Host -f Red " Input Error !!!" ; Start-Sleep  2 ; Clear-Host ; Continue
		}
	} Else {
		If ( $Spin -eq 's12' -OR $Spin -eq 's13'  -OR $Spin -eq 's23'  ) {
			$OB.Switching($Spin)
			Continue
		} Else {
			Write-Host -f Red " Input Error !!!" ; Start-Sleep  2 ; Clear-Host ; Continue
		}
	}
## ▲	END VALIDATION
	Clear-Host ; Write-Host
	If ($FileSite ) { $Spin | Add-Content $DataFile }
	$OB.Gob += $Spin
	$OB.WinOrLose()
	$OB.Update()
} ##	 End	 While

#TODO
#  want to know highest cash total  DONE !!!
# Strategy For stopping:     8 losses in 11 spins?     4 losses in 6 spins?

##	▼▼
## ▲

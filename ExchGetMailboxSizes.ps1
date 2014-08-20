#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Reports the size (in MB) of all Exchange Mailboxes

.DESCRIPTION  
    Reports the size (in MB) of all Exchange Mailboxes
    Output is reverse sorted by mailbox size

.NOTES  
    File Name      : ExchGetMailboxSizes.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, Exchange modules
#>

Get-Mailbox -ResultSize Unlimited |
	Get-MailboxStatistics |
	Select DisplayName,StorageLimitStatus, `
    	@{name="TotalItemSize (MB)"; `
    	   expression={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","") / 1MB) ,2)} `
        }, `
	   ItemCount |
	Sort "TotalItemSize (MB)" -Descending

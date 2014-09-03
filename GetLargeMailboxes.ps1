#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Reports a list of mailboxes greater than $gt (MB) and lists folders within those
    mailboxes greater than $f (MB)

.DESCRIPTION  
    Reports a list of mailboxes greater than $gt (MB) and lists folders within those
    mailboxes greater than $f (MB)
    Excludes the "Deletions" Exchange folder

.NOTES  
    File Name      : GetLargeMailboxes.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, Exchange modules
#>

param (
    [parameter(Mandatory=$true)]
    [int]$gt = $(throw "-gt is required."),
    [parameter(Mandatory=$true)]
    [int]$f = $(throw "-f is required.")

)

"Mailbox Report"
"--------------"
"Users with mailboxes greater than " + $gt + "MB"
"Displaying folders greater than " + $f + "MB`n"

$users = Get-Mailbox -ResultSize Unlimited |
	Get-MailboxStatistics |
	Select DisplayName, @{expression = {$_.TotalItemSize.Value.ToMB()}; label="TotalItemSizeMB"} |
	Sort "TotalItemSizeMB" -Descending | Where-Object {$_.TotalItemSizeMB -gt $gt}

if ($users) {
    foreach ($user in $users) {

        "---`nUser: " + $user.DisplayName + "`nMailbox Size: " + $user.TotalItemSizeMB + "MB"

        Get-MailboxFolderStatistics $user.DisplayName | Select Name,FolderSize,ItemsinFolder |
            Where-Object {$_.FolderSize -gt ($f * 1024 * 1024) -and $_.Name -ne "Deletions"} |
            sort FolderSize -Descending | 
            Format-Table
    }
}

#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Emails the output of ExchGetMailboxSizes.ps1 and GetLargeMailboxes.ps1

.DESCRIPTION  
    Emails the output of ExchGetMailboxSizes.ps1 and GetLargeMailboxes.ps1
    For use as a scheduled mailbox size alert tool

.NOTES  
    File Name      : MailboxAlerts.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, Exchange modules
#>

$messageParameters1 = @{
    Subject = "[Exchange Report] Mailbox Sizes"
    Body = (.\ExchGetMailboxSizes.ps1 | Out-String)
    From = "server@mydomain.com"
    To = "me@mydomain.com"
    SmtpServer = "my-smtp-server"
}

Send-MailMessage @messageParameters1

$messageParameters2 = @{
    Subject = "[Exchange Report] Large Mailboxes"
    Body = (.\GetLargeMailboxes.ps1 -gt 4000 -f 100 | Out-String)
    From = "server@mydomain.com"
    To = "me@mydomain.com"
    SmtpServer = "my-smtp-server"
}

Send-MailMessage @messageParameters2

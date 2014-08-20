#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Emails the output of ExchGetMailboxSizes.ps1

.DESCRIPTION  
    Emails the output of ExchGetMailboxSizes.ps1
    For use as a scheduled mailbox size alert tool

.NOTES  
    File Name      : MailboxAlerts.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, Exchange modules
#>

$messageParameters = @{
    Subject = "[Exchange Report] Mailbox Sizes"
    Body = (.\ExchGetMailboxSizes.ps1 | Out-String)
    From = "me@mydomain.com"
    To = "whoever@mydomain.com"
    SmtpServer = "smtpserveraddress"
}

Send-MailMessage @messageParameters

<#	
	Remote provisioning engine for a SharePoint Online site collection. XML definition used is based on PnP Schema definition.

	PREREQUISITE: You must install the PnP Cmdlet in order for this script to work properly.
				  https://github.com/OfficeDev/PnP-PowerShell/blob/master/Binaries/PnPPowerShellCommands16.msi?raw=true
#>
Param
(
	[Parameter(Mandatory=$true)]
	[xml]$Tokens
)

Try
{
	# Connect to the site collection
	$SiteCollectionUrl = $Tokens.Tokens.SiteCollection.Url;
	Write-Host "Trying to connect to $SiteCollectionUrl..." -ForeGroundColor Yellow -NoNewLine
	Connect-SPOnline -Url $SiteCollectionUrl
	Write-Host "Success!" -ForegroundColor Green

	Try
	{	
		Write-Host "Provisioning files..." -ForeGroundColor Yellow -NoNewline
		Apply-SPOProvisioningTemplate -Path ".\Templates\files.xml"
		Write-Host "Success!" -ForeGroundColor Green
	}
	Catch
	{
		Write-Error $_.Exception.Message
	}
}
Catch
{
	Write-Host "Failed!" -ForegroundColor Red
	Write-Error $_.Exception.Message
}


$shell = $Host.UI.RawUI
$shell.WindowTitle= "arisu"
$shell.BackgroundColor = "Black"
$shell.ForegroundColor = "White"

# -----------------------------------------------------------------------------------

$dnsProfiles = @{
    "electro" = @("78.157.42.101", "78.157.42.100")
    "shecan" = @("178.22.122.100", "185.51.200.2")
    "shelter" = @("94.103.125.157", "94.103.125.158")
    "radar" = @("10.202.10.11", "10.202.10.10")
}

function set-dns {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProfileName
    )

    if ($dnsProfiles.ContainsKey($ProfileName.ToLower())) {
        $dnsServers = $dnsProfiles[$ProfileName.ToLower()]
        $primaryDns = $dnsServers[0]
        $secondaryDns = $dnsServers[1]
        $activeInterface = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Name
        if ($activeInterface) {
            Set-DnsClientServerAddress -InterfaceAlias $activeInterface -ServerAddresses $primaryDns, $secondaryDns
            Write-Host "Done"
        } else {
            Write-Error "No active network interface"
        }
    } else {
        Write-Error "Profile '$ProfileName' not found."
    }
}

function reset-dns {
    $activeInterface = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Name
    if ($activeInterface) {
        Set-DnsClientServerAddress -InterfaceAlias $activeInterface -ResetServerAddresses
        Write-Host "DNS settings reset"
    } else {
        Write-Error "No active network interface"
    }
}

function show-dns {
    $activeInterface = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Name
    if ($activeInterface) {
        $currentDns = Get-DnsClientServerAddress -InterfaceAlias $activeInterface
        $primaryDns = $currentDns.ServerAddresses[0]
        $secondaryDns = $currentDns.ServerAddresses[1]

        foreach ($profile in $dnsProfiles.GetEnumerator()) {
            if ($profile.Value[0] -eq $primaryDns -and $profile.Value[1] -eq $secondaryDns) {
                Write-Host "--: $($profile.Key)"
                return
            }
        }
        Write-Host "Current DNS settings do not match any predefined profile."
    } else {
        Write-Error "No active network interface"
    }
}
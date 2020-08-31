## Get the public ip address of an azure vm

# Get vm
$Splat = @{
    ResourceGroupName = 'lab-rg'
    VMName            = 'workstation'
}
$VM = Get-AzVM @Splat

# Get NIC id
$NICId = $VM.NetworkProfile.NetworkInterfaces[0].id

# Get NIC
$NIC = Get-AzNetworkInterface -ResourceId $NICId

# Get public ip id
$PIPId = $NIC.IpConfigurations.PublicIpAddress.id

# Get public ip
$PIP = Get-AzResource -ResourceId $PIPId

# Output
[pscustomobject]@{
    IpAddress                = $PIP.Properties.ipAddress
    PublicIPAllocationMethod = $PIP.Properties.publicIPAllocationMethod
    FQDN                     = $pip.Properties.dnsSettings.fqdn
}

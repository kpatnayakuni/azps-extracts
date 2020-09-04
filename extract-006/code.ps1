## Create a Public IP with DNS name and assign it to a Azure VM

# Declare local variables
$ResourceGroupName = 'test-tg'
$VMName = 'testvm'
$Location = 'westus'
$PublicIPName = "{0}-pip" -f $VMName
$DNSLabelPrefix = $VMName, -join (97..122 | ForEach-Object { [char]$_ } | Get-Random -Count 8) -join ''

# Create a public ip with dns label
$PublicIP = New-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Location $Location -Name $PublicIPName -Sku Basic `
    -AllocationMethod Dynamic -IpAddressVersion  IPv4 -DomainNameLabel $DNSLabelPrefix

# Get VM
$VM = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

# Get VM NIC
$NIC = Get-AzNetworkInterface -ResourceId $VM.NetworkProfile.NetworkInterfaces.Id

# Set public IP address
$NIC | Set-AzNetworkInterfaceIpConfig -PublicIpAddressId $PublicIP.Id -Name $NIC.IpConfigurations[0].Name | Set-AzNetworkInterface

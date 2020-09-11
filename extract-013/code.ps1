## Create two Virtual Networks and connect with Virtual Network Peering

# Declare local variables
# Virtual Network 1
$RGName1 = 'network1-rg'
$Location1 = 'westus'
$VNetName1 = 'vNet1'
$VNetAddressSpace1 = '10.1.0.0/16'
$SubnetName1 = 'subnet1'
$SubnetAddressPrefix1 = '10.1.1.0/24'

# Virtual Network 2
$RGName2 = 'network2-rg'
$Location2 = 'eastus'
$VNetName2 = 'vNet2'
$VNetAddressSpace2 = '10.2.0.0/16'
$SubnetName2 = 'subnet2'
$SubnetAddressPrefix2 = '10.2.1.0/24'

# Create Resource Group 1
New-AzResourceGroup -Name $RGName1 -Location $Location1 | Out-Null

# Create Resource Group 2
New-AzResourceGroup -Name $RGName2 -Location $Location2 | Out-Null

# Create Virtual Network 1 with subnet
$Subnet1 = New-AzVirtualNetworkSubnetConfig -Name $SubnetName1 -AddressPrefix $SubnetAddressPrefix1
$VNet1 = New-AzVirtualNetwork -ResourceGroupName $RGName1 -Location $Location1 -Name $VNetName1 -AddressPrefix $VNetAddressSpace1 -Subnet $Subnet1

# Create Virtual Network 2 with subnet
$Subnet2 = New-AzVirtualNetworkSubnetConfig -Name $SubnetName2 -AddressPrefix $SubnetAddressPrefix2
$VNet2 = New-AzVirtualNetwork -ResourceGroupName $RGName2 -Location $Location2 -Name $VNetName2 -AddressPrefix $VNetAddressSpace2 -Subnet $Subnet2

# Create peering from VNet1 to VNet2
Add-AzVirtualNetworkPeering -Name VNet1-VNet2 -VirtualNetwork $VNet1 -RemoteVirtualNetworkId $VNet2.Id | Out-Null

# Create peering from VNet2 to VNet1
Add-AzVirtualNetworkPeering -Name VNet2-VNet1 -VirtualNetwork $VNet2 -RemoteVirtualNetworkId $VNet1.Id | Out-Null

# Verify
Get-AzVirtualNetworkPeering -ResourceGroupName $RGName1 -VirtualNetworkName $VNetName1 | Select-Object -Property Name, PeeringState
  
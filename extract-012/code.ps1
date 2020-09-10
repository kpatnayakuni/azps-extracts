## Create a Storage Account and enable Boot Diagnostics of an Azure VM

# Declare local variables
$ResourceGroupName = 'compute-rg'
$VMName = 'winsvr'
$StorageAccountName = -join ('sabd', $( -join ((0x30..0x39) + ( 0x61..0x7A) | Get-Random -Count 8 | ForEach-Object { [char]$_ })))

# Get VM
$VM = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Location $VM.Location -Name $StorageAccountName -SkuName Standard_LRS | Out-Null

# Enable boot diabnostics
$VM | Set-AzVMBootDiagnostic -Enable -StorageAccountName $StorageAccountName | Update-AzVM

# Verify
# Give it a moment and pull the boot diagnostics data 
# Start-Sleep 30
Get-AzVMBootDiagnosticsData -ResourceGroupName $ResourceGroupName -Name $VMName -Windows -LocalPath C:\Temp\

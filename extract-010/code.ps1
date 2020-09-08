## Add a new data disk to an Azure VM

# Declare local variables
$ResourceGroupName = 'compute-rg'
$VMName = 'winsvr'
$Location = 'westus' 
$StorageType = 'Premium_LRS'
$DataDiskName = $VMName + '_datadisk'

# Create Data Disk
$DiskConfig = New-AzDiskConfig -SkuName $StorageType -OsType Windows -DiskSizeGB 128 -Location $Location -CreateOption Empty 
$DataDisk = New-AzDisk -ResourceGroupName $ResourceGroupName -DiskName $DataDiskName -Disk $DiskConfig

# Get Azure VM and add the data disk
$VM = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName
$VM | Add-AzVMDataDisk -Name $DataDiskName -CreateOption Attach -ManagedDiskId $DataDisk.Id -Lun 1 | Out-Null

# Update the VM
Update-AzVM -ResourceGroupName $ResourceGroupName -VM $VM
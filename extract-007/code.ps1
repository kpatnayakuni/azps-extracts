## Deploy Azure SQL Database

# Declare local variables
$ResourceGroupName = 'database-rg'
$Location = 'westus'
$ServerName = -join ('sql', $( -join ((0x30..0x39) + ( 0x61..0x7A) | Get-Random -Count 8 | ForEach-Object { [char]$_ })))
$SqlDBName = 'SampleDB'
$ServiceObjectiveName = 'S0'
$AdminCredential = Get-Credential

# Create Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location | Out-Null

# Create a server with a system wide unique server name
$SqlServer = New-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName -Location $Location -SqlAdministratorCredentials $AdminCredential

# Create a blank database with an S0 performance level
New-AzSqlDatabase  -ResourceGroupName $ResourceGroupName -ServerName $ServerName -DatabaseName $SqlDBName -RequestedServiceObjectiveName $ServiceObjectiveName | Out-Null

# Print Sql Server FQDN to connect to the server
Write-Host ("Connect SQL Server using {0},1433" -f $SqlServer.FullyQualifiedDomainName)
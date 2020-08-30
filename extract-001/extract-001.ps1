## Add tags to a resource using Azure PowerShell

# Get resource 
$Splat = @{
    ResourceGroupName = 'test-rg'
    ResourceName = 'testvm01'
}
$Resource = Get-AzResource @Splat

# Get resource tags
$Tags = $Resource.Tags

# Add new tags
$Tags += @{
    Env = 'Prod'
    Dept = 'IT'
}

# Add/Update tags
$Resource | Set-AzResource -Tag $Tags -Force | Out-Null

# Verify
$Resource = Get-AzResource @Splat
$Resource.Tags
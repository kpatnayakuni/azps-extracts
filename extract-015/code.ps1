## Function to switch between multiple subscriptions with tab completion

Function Switch-AzSubscription
{
    [Alias('ss')]
    [CmdletBinding()]
    Param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [ArgumentCompleter( {
                return @(Get-AzContext -ListAvailable | ForEach-Object { 
                        if ($_.Subscription.Name.ToString().Contains(' ') ) { "'$($_.Subscription.Name)'" }
                        else { $_.Subscription.Name }
                    })
            })]
        [string] $SubscriptionName 
    )
    Set-AzContext -SubscriptionName $SubscriptionName -Force
}
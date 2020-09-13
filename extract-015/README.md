## Function to switch between multiple subscriptions with tab completion

```powershell
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
```

<video width="540" height="480" controls>
  <source src="video.mp4" type="video/mp4">
</video>
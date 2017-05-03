function Get-DSCResourceModule {
<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    begin {
        $data = Get-Content -Path $path -Raw | ConvertFrom-Json
    }
    
    process {
        
        foreach ($dscResource in $data.DSCResourcesToExecute) 
        {
            
            if ($dscResource.dscResourceName -eq 'File')
            {
                $moduleName = 'PSDesiredStateConfiguration'
            } 
           else
           {
                $moduleName = (Get-DscResource -Name $dscResource.dscResourceName).ModuleName
           }
            
            [string[]]$modules += $moduleName
        }
    }
    
    end {
        $modules | Select-Object -Unique
    }
}

#Get-DSCResourceModule -Path 'C:\Users\jduffney\Documents\GitHub\Invoke-DSC\examples\AppProvisioning.json'
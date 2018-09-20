
Function Get-JenkinsJobs {
    [cmdletbinding()]
    [OutputType([PSCustomObject])]
    Param(
        [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [String]
            $Uri,
        
        [Parameter()]
            [ValidateNotNullOrEmpty()]
            [String]
            $Folder,

        [Parameter()]
            [pscredential]
            $Credential,

        [Parameter()]
            [Switch]
            $Recursive
    )
    if($Recursive){
        Write-Verbose "Recursive call on Folder: $Folder/$($PSItem.name)"
        if($Folder){
            Get-JenkinsFolderList -Uri $Uri -Credential $Credential -Folder $Folder | ForEach-Object {
                Get-JenkinsJobs -Uri $Uri -Credential $Credential -Folder "$Folder/$($PSItem.name)" -Recursive
            }
        }else{
            Get-JenkinsFolderList -Uri $Uri -Credential $Credential | ForEach-Object {
                Get-JenkinsJobs -Uri $Uri -Credential $Credential -Folder $PSItem.name -Recursive
            }
        }
    }
    
    if($Folder){
        $JobList = Get-JenkinsJobList -Uri $Uri -Credential $Credential -Folder $Folder
    }else{
        $JobList = Get-JenkinsJobList -Uri $Uri -Credential $Credential
    }
    foreach($Job in $JobList){
        $Job | Add-Member -MemberType NoteProperty -Name "Definition" -Value $null
        $Job | Add-Member -MemberType NoteProperty -Name "Folder" -Value $null
        if($Folder){
            $Job.Definition = Get-JenkinsJob -Uri $Uri -Credential $Credential -Name $Job.name -Folder $Folder
            $Job.Folder = $Folder
        }else{
            $Job.Definition = Get-JenkinsJob -Uri $Uri -Credential $Credential -Name $Job.name
        }
        Write-Output $Job
    }
}

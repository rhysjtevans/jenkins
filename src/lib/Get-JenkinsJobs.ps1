
Function Get-JenkinsJobs {
    [cmdletbinding()]
    [OutputType([PSCustomObject])]
    Param(
        [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [String]
            $Uri,
        
        [Parameter()]
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
        Write-Verbose "Recursive call on Folder: $Folder/$PSItem"
        if($Folder){
            Get-JenkinsFolderList -Uri $JenkinsServer -Credential $Credential -Folder $Folder | ForEach-Object {
                Get-JenkinsJobs -Uri $JenkinsServer -Credential $Credential -Folder "$Folder/$PSItem"
            }
        }else{
            Get-JenkinsFolderList -Uri $JenkinsServer -Credential $Credential | ForEach-Object {
                Get-JenkinsJobs -Uri $JenkinsServer -Credential $Credential -Folder $PSItem
            }
        }
    }
    
    if($Folder){
        $JobList = Get-JenkinsJobList -Uri $JenkinsServer -Credential $Credential -Folder $Folder
    }else{
        $JobList = Get-JenkinsJobList -Uri $JenkinsServer -Credential $Credential
    }
    foreach($Job in $JobList){
        $Job | Add-Member -MemberType NoteProperty -Name "Definition" -Value $null
        $Job | Add-Member -MemberType NoteProperty -Name "Folder" -Value $null
        if($Folder){
            $Job.Definition = Get-JenkinsJob -Uri $JenkinsServer -Credential $Credential -Name $Job.name -Folder $Folder
            $Job.Folder = $Folder
        }else{
            $Job.Definition = Get-JenkinsJob -Uri $JenkinsServer -Credential $Credential -Name $Job.name
        }
        Write-Output $Job
    }
}
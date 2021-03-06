<#
    .SYNOPSIS
        Throws a custom exception.

    .DESCRIPTION
        This cmdlet throws a terminating or non-terminating exception.

    .PARAMETER errorId
        The Id of the exception.

    .PARAMETER errorCategory
        The category of the exception. It must be a valid [System.Management.Automation.ErrorCategory]
        value.

    .PARAMETER errorMessage
        The exception message.

    .PARAMETER terminate
        This switch will cause the exception to terminate the cmdlet.

    .EXAMPLE
        $ExceptionParameters = @{
            errorId = 'ConnectionFailure'
            errorCategory = 'ConnectionError'
            errorMessage = 'Could not connect'
        }
        New-JenkinsException @ExceptionParameters
        Throw a ConnectionError exception with the message 'Could not connect'.

    .OUTPUTS
        None
#>
function New-JenkinsException
{
    [CmdLetBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ErrorId,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.ErrorCategory]
        $ErrorCategory,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ErrorMessage,

        [Switch]
        $Terminate
    )

    $exception = New-Object -TypeName System.Exception `
        -ArgumentList $ErrorMessage
    $errorRecord = New-Object -TypeName System.Management.Automation.ErrorRecord `
        -ArgumentList $exception, $ErrorId, $ErrorCategory, $null

    if ($true -or $())
    {
        if ($Terminate)
        {
            # This is a terminating exception.
            throw $errorRecord
        }
        else
        {
            # Note: Although this method is called ThrowTerminatingError, it doesn't terminate.
            $PSCmdlet.ThrowTerminatingError($errorRecord)
        }
    } # if
} # function New-JenkinsException

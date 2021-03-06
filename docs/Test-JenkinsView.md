---
external help file: Jenkins-help.xml
Module Name: jenkins
online version:
schema: 2.0.0
---

# Test-JenkinsView

## SYNOPSIS
Determines if a Jenkins View exists.

## SYNTAX

```
Test-JenkinsView [-Uri] <String> [[-Credential] <PSCredential>] [[-Crumb] <String>] [[-Name] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns true if a View exists in the specified Jenkins Master server with a matching Name.

## EXAMPLES

### EXAMPLE 1
```
Test-JenkinsView `
```

-Uri 'https://jenkins.contoso.com' \`
    -Credential (Get-Credential) \`
    -Name 'My View' \`
    -Verbose
Returns true if the 'My View' view is found on https://jenkins.contoso.com using the credentials provided by
the user.

## PARAMETERS

### -Uri
Contains the Uri to the Jenkins Master server to execute the command on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Contains the credentials to use to authenticate with the Jenkins Master server.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Crumb
Contains a Crumb to pass to the Jenkins Master Server if CSRF is enabled.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the view to check for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### A boolean indicating if the View was found or not.

## NOTES

## RELATED LINKS

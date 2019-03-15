$acctKey = ConvertTo-SecureString -String "WHCoVWnrOFEL2ANllzyGTiZJ2jj8xMIIGkxz07K/aJq8mBdZ3m0dp5zDJo9ln3dfUQk3SyjV/69AWgufl97A/A==" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\frazrfsa", $acctKey
New-PSDrive -Name S -PSProvider FileSystem -Root "\\frazrfsa.file.core.windows.net\azrfsaftpworkspace" -Credential $credential -Persist

Clear-Host

foreach ($server in Get-Content servers.txt) {

    $ChildFoldersSource = @('\\' + $server +  '\c$\PerfLogs\Admin')
    $ChildFoldersDest = @('H:\KHIReports\')

    for($i = 0; $i -lt $ChildFoldersSource.Count; $i++){

        $FolderPath = $ChildFoldersSource[$i]
        $DestinationPath = $ChildFoldersDest[$i]

        gci -Path $FolderPath -File | Sort-Object -Property LastWriteTime -Descending | Select FullName -First 1 | %($_){
        $_.FullName
        Copy-Item $_.FullName -Destination $DestinationPath
        }

    }
}

#Edge Servers

foreach ($server in Get-Content edgeservers.txt) {

    Import-Module bitstransfer

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $oReturn=[System.Windows.Forms.Messagebox]::Show('Enter Credentials for Edge: ' + $server + '')

    $cred = Get-Credential

        $ChildFoldersSource = @('\\' + $server +  '\c$\PerfLogs\Admin')
        $ChildFoldersDest = @('H:\KHIReports\')

        for($i = 0; $i -lt $ChildFoldersSource.Count; $i++){

            $FolderPath = $ChildFoldersSource[$i]
            $DestinationPath = $ChildFoldersDest[$i]

                Start-BitsTransfer -Source $_.FullName -Destination $DestinationPath -Credential $cred
                    gci -Path $FolderPath -File | Sort-Object -Property LastWriteTime -Descending | Select FullName -First 1 | %($_){
                        $_.FullName
                Start-BitsTransfer -Source $_.FullName -Destination $DestinationPath -Credential $cred
            }

        }
}

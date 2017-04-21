Function Generate-Form {

Add-Type -AssemblyName System.Windows.Forms

$primaryForm = New-Object system.Windows.Forms.Form
$primaryForm.Text = "Get-KHIReports"
$primaryForm.TopMost = $true
$primaryForm.Width = 400
$primaryForm.Height = 346
$primaryForm.MaximizeBox = $false

$runButton = New-Object system.windows.Forms.Button
$runButton.Text = "Collect"
$runButton.Width = 94
$runButton.Height = 50
$runButton.location = new-object system.drawing.point(279,38)
$runButton.Font = "Calibri,10"
$runButton.add_click({collectCSV})
$primaryForm.controls.Add($runButton)

$tbServers = New-Object System.Windows.Forms.TextBox
$tbServers.Location = New-Object System.Drawing.Size(7,36)
$tbServers.Width = 260
$tbServers.Height = 196
$tbServers.AcceptsReturn = $true
$tbServers.AcceptsTab = $false
$tbServers.Multiline = $true
$tbServers.ScrollBars = 'Both'
$primaryForm.Controls.Add($tbServers)

$tbCSVsave = New-Object System.Windows.Forms.TextBox
$tbCSVsave.Location = New-Object System.Drawing.Size(7,266)
$tbCSVsave.Width = 260
$tbCSVsave.Height = 28
$primaryForm.Controls.Add($tbCSVsave)

$label7 = New-Object system.windows.Forms.Label
$label7.Text = "Server List (Full FQDN, 1 Per Line)"
$label7.AutoSize = $true
$label7.Width = 25
$label7.Height = 10
$label7.location = new-object system.drawing.point(7,12)
$label7.Font = "Microsoft Sans Serif,10"
$primaryForm.controls.Add($label7)

$label8 = New-Object system.windows.Forms.Label
$label8.Text = "Location to save collected files (UNC Path)"
$label8.AutoSize = $true
$label8.Width = 25
$label8.Height = 10
$label8.location = new-object system.drawing.point(6,243)
$label8.Font = "Microsoft Sans Serif,10"
$primaryForm.controls.Add($label8)

[void]$primaryForm.ShowDialog()
$primaryForm.Dispose()
}

Function collectCSV() {
foreach ($server in $tbServers.Text) {

    $ChildFoldersSource = @('\\' + $server +  '\c$\PerfLogs\Admin')
    $ChildFoldersDest = @($tbCSVsave)

    for($i = 0; $i -lt $ChildFoldersSource.Count; $i++){

        $FolderPath = $ChildFoldersSource[$i]
        $DestinationPath = $ChildFoldersDest[$i]

        $fileName = gci $FolderPath | sort LastWriteTime | select -last 1
        $fullPathfilename = $FolderPath + "\" + $fileName
        #Write-Host $fullPathfilename
        Copy-Item $fullPathfilename -Destination $tbCSVsave.Text
        }
      }

    }
Generate-Form

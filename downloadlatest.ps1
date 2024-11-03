# Define the installation directory and setup application path
$installDir = "C:\winaerotweaker"
$setupApp = "WinaeroTweaker-1.63.0.0-setup.exe"
$uninstaller = "uninst000.exe"

# Define the path for the temporary PowerShell script
$tempPsScript = Join-Path -Path $env:TEMP -ChildPath "pscript.ps1"

# Create the PowerShell script content
$scriptContent = @"
Add-Type -AssemblyName System.Windows.Forms

function Show-Message {
    param (
        [string]`$message,
        [string]`$title = "WinaeroTweaker Installer"
    )
    [System.Windows.Forms.MessageBox]::Show(`$message, `$title)
}

function Install-WinaeroTweaker {
    if (Test-Path "$installDir\$uninstaller") {
        Show-Message "WinaeroTweaker is already installed. Please uninstall it first."
        return
    }

    Show-Message "Downloading WinaeroTweaker..."
    Invoke-WebRequest -Uri 'https://github.com/userdev265scratchandpython/upgrade11/raw/refs/heads/main/winaerotweaker.zip' -OutFile 'winaerotweaker.zip'

    Show-Message "Extracting WinaeroTweaker..."
    Expand-Archive -Path 'winaerotweaker.zip' -DestinationPath 'winaerotweaker' -ErrorAction SilentlyContinue

    Set-Location -Path 'winaerotweaker'
    if (-Not (Test-Path "$installDir")) {
        New-Item -Path "$installDir" -ItemType Directory
    }

    Show-Message "Installing WinaeroTweaker..."
    if (Test-Path "$setupApp") {
        Start-Process -FilePath "$setupApp" -ArgumentList '/SP-', '/VERYSILENT', "/DIR=`"$installDir`"" -Wait
    }

    Set-Location -Path ..
    Remove-Item "winaerotweaker.zip" -ErrorAction SilentlyContinue
    if (Test-Path "winaerotweaker") {
        Remove-Item "winaerotweaker" -Recurse -Force -ErrorAction SilentlyContinue
    }

    Show-Message "WinaeroTweaker installed successfully!"
}

function Uninstall-WinaeroTweaker {
    if (-Not (Test-Path "$installDir\$uninstaller")) {
        Show-Message "WinaeroTweaker is not currently installed."
        return
    }

    Show-Message "Uninstalling WinaeroTweaker..."
    Start-Process -FilePath "$installDir\$uninstaller" -ArgumentList '/SILENT' -Wait
    if ($LASTEXITCODE -eq 0) {
        Show-Message "WinaeroTweaker uninstalled successfully!"
    } else {
        Show-Message "Failed to uninstall WinaeroTweaker."
    }
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "WinaeroTweaker Installer"
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.StartPosition = "CenterScreen"

$installButton = New-Object System.Windows.Forms.Button
$installButton.Location = New-Object System.Drawing.Point(75, 120)
$installButton.Size = New-Object System.Drawing.Size(75, 23)
$installButton.Text = "Install"
$installButton.Add_Click({ Install-WinaeroTweaker })
$form.Controls.Add($installButton)

$uninstallButton = New-Object System.Windows.Forms.Button
$uninstallButton.Location = New-Object System.Drawing.Point(150, 120)
$uninstallButton.Size = New-Object System.Drawing.Size(75, 23)
$uninstallButton.Text = "Uninstall"
$uninstallButton.Add_Click({ Uninstall-WinaeroTweaker })
$form.Controls.Add($uninstallButton)

$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()

"@

# Write the script content to the temporary PowerShell script
Set-Content -Path $tempPsScript -Value $scriptContent

# Clean up the temporary PowerShell script
Remove-Item -Path $tempPsScript -Force -ErrorAction SilentlyContinue

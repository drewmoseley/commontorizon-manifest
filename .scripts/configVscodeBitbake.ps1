# suppress warnings that we need to use
param()

# Setup the Yocto Vscode settings file in
#     ${workdir}/torizon/layers/.vscode/settings.json
# check if the folder exists
if (! (Test-Path -Path ./.vscode)) {
    New-Item -ItemType Directory -Path ./.vscode

    # create the settings.json file
    New-Item -ItemType File -Path ./.vscode/settings.json
Write-Output @"
{
    "window.title": "`${folderName}",
    "terminal.integrated.defaultProfile.linux": "bash",
    "bitbake.machine": "raspberrypi3-64",
    "bitbake.distro": "torizon-upstream",
    "bitbake.image": "torizon-core-docker",
    "bitbake.setupScript": "bitbakes.sh",
    "ctags.disable": false,
    "machine": "verdin-imx8mm",
    "image": "torizon-core-docker",
    "distro": "torizon",
    "build_dir": "build-torizon",
    "sstate_dir": "sstate-cache",
    "dl_dir": "downloads",
}
"@ | Out-File ./.vscode/settings.json
}

# update the Yocto Vscode settings.json file
$yoctoSettings = 
    Get-Content ./.vscode/settings.json | ConvertFrom-Json -Depth 100

# update the settings
$yoctoSettings."bitbake.machine" = $settings.machine
$yoctoSettings."bitbake.distro" = $settings.distro
$yoctoSettings."bitbake.image" = $settings.image
$yoctoSettings."bitbake.buildDir" = $settings.build_dir

# output the settings.json file
$yoctoSettings | ConvertTo-Json -Depth 100 | Out-File ./.vscode/settings.json

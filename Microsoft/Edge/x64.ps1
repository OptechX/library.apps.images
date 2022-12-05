$app_category = "Microsoft"
$app_publisher = "Microsoft"
$app_name = "Edge"
$app_lcid = @("en-US")
$app_cpu_arch = "x64"
$app_homepage = "https://www.microsoft.com/en-us/edge"
$app_copyright = ""
$app_icon = "https://github.com/DennisGaida/chocolatey-packages/raw/master/microsoft-edge/icon.png"
$app_license_accept = $false
$app_docs = "https://docs.microsoft.com/en-us/microsoft-edge/"
$app_license = "https://www.microsoft.com/en-us/servicesagreement/"
$app_tags = @("microsoft","edge","browser","stable","chromium","open","source","open source")
$app_summary = "Microsoft Edge browser, based on the Chromium open source browser"
$pkg_reboot_required = $false
$pkg_filename = "MicrosoftEdgeEnterpriseX64.msi"
$pkg_absolute_uri = ""
$pkg_executable = "msi"
$pkg_install_cmd = ""
$pkg_install_args = ""
$pkg_display_name = ""
$pkg_display_publisher = ""
$pkg_display_version = ""
$pkg_detection = ""
$pkg_detect_value = ""
$pkg_detect_script = ""
$pkg_uninstall_process = ""
$pkg_uninstall_cmd = ""
$pkg_uninstall_args = ""
$pkg_uninstall_script = ""
$pkg_transfer_method = ""
$pkg_locale = ""
$pkg_uri_path = ""
$pkg_enabled = ""
$pkg_depends_on = @()


# get icon if not exist
$icon_path = "${PSScriptRoot}/icon.png"
if (-not(Test-Path -Path $icon_path))
{
    Invoke-WebRequest -Uri $app_icon -OutFile $icon_path -UseBasicParsing -Method Get
    
}

# get data of application
$msedge_api_uri = "https://edgeupdates.microsoft.com/api/products"
$msedge_build_stream = "Stable"
$msedge_api_dl_data = (Invoke-WebRequest -Uri $msedge_api_uri -Method Get -UseBasicParsing).Content
$json = $msedge_api_dl_data | ConvertFrom-Json
$releases = $json | Where-Object -Property Product -eq $msedge_build_stream | Select-Object Releases
$download_url = ($releases.Releases | Where-Object {$_.Platform -eq 'Windows'} | Where-Object {$_.Architecture -eq 'x64'}).Artifacts.Location
$download_hash= ($releases.Releases | Where-Object {$_.Platform -eq 'Windows'} | Where-Object {$_.Architecture -eq 'x64'}).Artifacts.Hash
$version = ($releases.Releases | Where-Object {$_.Platform -eq 'Windows'} | Where-Object {$_.Architecture -eq 'x64'}).ProductVersion.Trim()



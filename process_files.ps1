$json = iwr "https://wdwntnowapi.azurewebsites.net/api/v2/facilities.json" | ConvertFrom-Json

foreach ($facility in $json) {
  write-host "Processing $($facility.name) ($($facility.id))..."
  try {
    $url = "https://wdwntnowapi.azurewebsites.net/api/v2/facilities/getparkxmlobjects/$($facility.id).xml"
    Invoke-RestMethod -Uri $url -TimeoutSec 300 -OutFile "$($facility.id).xml"
  } catch {
    write-host "Error: $_.Exception.Message"
  }
}

write-host "Executing git commands..."
git config --global user.email "rob@rorpage.com"
git config --global user.name "Robbie Page"

git add .
git commit -m 'master_2018.11.9.15'
git push -u origin HEAD:master

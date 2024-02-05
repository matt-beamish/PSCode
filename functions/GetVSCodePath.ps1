<#
.SYNOPSIS
Obtains VS Code's install path via 32 and 64 bit hives.
#>
function GetVSCodePath() {
    $result = $null
    $registryViews = @([Microsoft.Win32.RegistryView]::Registry32, [Microsoft.Win32.RegistryView]::Registry64)

    foreach ($view in $registryViews) {
        $key = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $view)
        $subKey = $key.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

        $subKeyName = $subKey.GetSubKeyNames() | ?{
            $subKey.OpenSubKey($_).GetValue("DisplayName") -eq 'Microsoft Visual Studio Code'
        } | Select -First 1

        if ($subKeyName) {
            $result = $subKey.OpenSubKey($subKeyName).GetValue("InstallLocation")
        }
    }
    if ($null -eq $result) {
      $userPath =  (Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code")
      if (Test-Path $userPath ){
        $result = $userPath
      }
    }
    $result
}

# SIG # Begin signature block
# MIII/QYJKoZIhvcNAQcCoIII7jCCCOoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCqN/7Xh1Jty4Hz
# nZbBILonOwBuIK0EmAOqF1a3e2Kmk6CCBVwwggVYMIIDQKADAgECAhBkQJ8HG9NV
# mUgFpv8uLW5XMA0GCSqGSIb3DQEBBQUAMDExLzAtBgNVBAMMJk1hdHQgQmVhbWlz
# aCA8bWF0dC5iZWFtaXNoQHV3YS5lZHUuYXU+MB4XDTI0MDIwNTA4NTE0N1oXDTI1
# MDIwNTA5MTE0N1owMTEvMC0GA1UEAwwmTWF0dCBCZWFtaXNoIDxtYXR0LmJlYW1p
# c2hAdXdhLmVkdS5hdT4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC5
# wEvIN0TmhGrhAISEOiS5xgQzVgGol1OldS9wvqaI9GyW2kObrrW1H7OwPGPvZhSB
# yyUMr/ONqhb2t/JDTOMbahU1UMBFLIn6uAlspkoI78IMEk0YRafNUoxtExw0ArII
# xbDnG2Cpua2nvi45Jgmwpwc99sDbwRHhcgcgfETHwb+14ruf454ctJP8uuh8Z5Wi
# WWdLYn78hXwYueTBWqs46Nzuyuei3MetOJi05TxgGG3sREryWNRm0FJrSd2ecIks
# nT8QQ+vcxgA6QuNj2Nzhi7HR0r9MDRPAvFd/Ztgl+F31p7haU5U0NnmapAjE1NXh
# AdLey8UgpXpoHbLDROywdksuREuNaALbsRGBpagsrsFliFsWefDO2KmCSPGAkQkQ
# 47kFDwEQ6YK1QADC7qMDgm4Z6eky+5yGnydCv1qWb1kGBhqxkR2fdpT0oKFWNZXN
# V2eMQcYvIQOoxxJHoqEz/JKPFvB0UdkKmVor7D44x2D9G/bKPVkYgT0wTt627TMe
# sU6i9ldVbokdLH7NPz3AwwRnTzpTFqxiGsrcdXBDVAnl6a7I55ngTZOx5ShLr6P5
# pYvsAw+rXQjQ5tTeayHXL/K0w8ilA/nQaQk6ZmKbb4RNvpmdL8gHcTpXWdMZWT7X
# 0rW7L+F91BRQNRDDLit7209COW/eqrCiR8ZD8kbGPQIDAQABo2wwajAOBgNVHQ8B
# Af8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwJAYDVR0RBB0wG4IZREVQNjY4
# MzEudW5pd2EudXdhLmVkdS5hdTAdBgNVHQ4EFgQU/F1paWGqkJwdS+Br3mU0YlmZ
# 4SUwDQYJKoZIhvcNAQEFBQADggIBAGvWAqQsOIlVv0Pa+m3t7SuzEEY5g57pZ4Ws
# AJ56NwuXH4k9hDLC1qiZgfU48qe2kYQdH7EoEf4bNuqDQ08PpGwKtbuWL+VsfziJ
# XrmmQVSAngXIHOHl2Dnfyh4DTR/6/yRYR1S5ja86+S846yGM+VRDSLAQ8GvsjHY/
# ShFlv08JVYWx5GcF+NKVUm1M2LBAXCFGxUwggTfAyrIq9F3CT+lgJViMnWY+A4qY
# Mql78Gh0qpjJvbATTUObh2MJRDfHF0q7EPTCk5jIgbSPkM6Jyf7GIYjkz63DAo7b
# qke/uZIQVQ65L2U/m2bP0IVEtUse5wkkGJLLF2cCh1ZwS0k3fTAVlOM1X0WAApTs
# 6XezF6PtLfEHwTKvJEAVqj8PwxEFnwrj81NLkQi1v3YXDXWXnS+1KnMlskJ8O38C
# KXMKHwKpA3dOT+sdzTQPYElWtvn5KEXMrpgVeXR1UYdGhan2N5YfjwhxNIeh7xFv
# fjuFpxhHQVcGx5JG7jRHlmuL0uOJcknB9kkX26YsX24XlFV+Mjf0HxePPmdsBNnv
# P558r3F6N+RJIjei9wxJwetscn2Kl0XAeD7plrM3JC3Po3jKxOcabJiVW3I76y10
# 0p3suRBgkifEAT3xT2vQktWVdUX35cVzar9RSRPrKv0KUBnaXXSS88eTixXEAdGl
# Cjurgwq5MYIC9zCCAvMCAQEwRTAxMS8wLQYDVQQDDCZNYXR0IEJlYW1pc2ggPG1h
# dHQuYmVhbWlzaEB1d2EuZWR1LmF1PgIQZECfBxvTVZlIBab/Li1uVzANBglghkgB
# ZQMEAgEFAKCBhDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJ
# AzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8G
# CSqGSIb3DQEJBDEiBCBXckcJugcBYrOXiJEs+uQmzlUuCOI/TNn6qT4BVIYlmTAN
# BgkqhkiG9w0BAQEFAASCAgA9rQrqF3pwgKEo+D+UY+5e9uxaeOEyyeFZLS5MYbs3
# fupcrRxbDwbySsG3dSSZWxrQiUU2xFlKQHYarN9l8WF8j6lRcX+o2SH6hns+ZnZg
# w7b60G8QwSkVagZ6fOFnA9O1Ie3tK4Bs/Z0cqI/bXtqcXpQy7OWm9wuklc+4zRtl
# D1kiF3yeT9oE54osV4zDC5zuYU5joBYFm0u83xTb95978rgap6seQJVWUA3ZEgw4
# 2QGcaM487Q8LV9qw8e3KVzcKnUUDsXnkC71zt6kMjNsIfOCovNaZxFIid51PR4jY
# Dg8LGyzbU3WPVHvLc0vtqAGcOm0cF3YiZKPQ8rx/i6LxDP38sA7m5TmZbkYv4SVL
# PeYkW9CFREP05dQyyZMVRHJ1k9VXl9zIWMIEcQSiJKVPLMxJcTkJOxWp2caUl5p8
# /RnomAqXhEWBBIFZgMZA4WalVMBAnzJihdcpdN0y0GSm3vVqj/qEVuI/V/YqI1xX
# d2fW66DkxcaFubpSLh7cQtko0Thp7id4FEvrXfLocGflfy83/ccKLTzb4Qi4hvXb
# OFDEadbJgHutvlCW6OdMS6eSo2octQgL24ZLs7afpy+BQ9LVWEZWVwpu5gw7qC46
# 0ccncyTk+NMOLSsvEBRHqHXt8bqkx+INyaaUSuC/nz5edYeOfGsxxjWTpaCB+Cit
# 9g==
# SIG # End signature block

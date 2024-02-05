$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleRoot = "$here\.."

"$moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath; write-host $_.ProviderPath}


function SetupDrive {
    mkdir 'TestDrive:\ArgsTest'
    echo '' > 'TestDrive:\ArgsTest\a.txt'
    echo '' > 'TestDrive:\ArgsTest\b.txt'
    echo '' > 'TestDrive:\ArgsTest\c.txt'
}

$rcPath = 'RC'
$rcPathResult = '"RC"'

Describe "GetArgs" {
    $result = GetArgs $rcPath @('a.txt', 'b.txt:10', '-g')
    It "Should pass string args unmodified" {
        $result | Should Be @($rcPathResult, 'a.txt', 'b.txt:10', '-g')
        Write-host $result
    }

    $result = GetArgs $rcPath @('c:\some path to\a file.txt', 'c:\some path to\b file.txt')
    It "Should quote as needed" {
        $result | Should Be @($rcPathResult, '"c:\some path to\a file.txt"', '"c:\some path to\b file.txt"')
        Write-host $result
    }

    SetupDrive
    $files = (get-item 'TestDrive:\ArgsTest\*')
    $result = GetArgs $rcPath @('a.txt', $files)
    It "Should flatten array" {
        $result | Should Be @($rcPathResult, 'a.txt', $files[0].FullName, $files[1].FullName, $files[2].FullName)
        # Posh will give equality between a file object and the file's FullName,
        # so ensure that we only have strings.
        $result[2] -is [string] -and $result[3] -is [string] | Should Be $true
        Write-host ($result | ConvertTo-Json)
    }

    $result = GetArgs $rcPath @('a.txt', 'TestDrive:\ArgsTest\*')
    It "Should resolve a glob input" {
        $result | Should Be @($rcPathResult, 'a.txt', $files[0].FullName, $files[1].FullName, $files[2].FullName)
        # Posh will give equality between a file object and the file's FullName,
        # so ensure that we only have strings.
        $result[2] -is [string] -and $result[3] -is [string] | Should Be $true
        Write-host ($result | ConvertTo-Json)
    }

}

# SIG # Begin signature block
# MIII/QYJKoZIhvcNAQcCoIII7jCCCOoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAneANqyCcfZ2hb
# Ye0teg881USUg/AJbEFihdO1E0hkiKCCBVwwggVYMIIDQKADAgECAhBkQJ8HG9NV
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
# CSqGSIb3DQEJBDEiBCDcG2VBeJWdwuxXnECblve8jtoq1FjbC443ML1w/V8T4jAN
# BgkqhkiG9w0BAQEFAASCAgAgq7n3iBlcZ9rV+/metcwFiLXJL68q92AxPTn3s0Ip
# xZQcAfxOc+d1p3mc+M45dbHjbHO0v4LSXqN4MoytIoh4s+V36nhfpUyrRs8JlwrG
# Fw0UPDW/MOj2U5v35a+4fmMZB1iRyZEOGvNvqep80dTrDwwAkgqG4NTP7ZDVTFhu
# WZ7aJzltPymO//icuyT3mNXWdoHDhGqHZmIOb4qIYMpZOeeBf/ZCHHnhmR1pAKXs
# /Xp6ThSdhaiEnh/lIiGrhrewqxhQKNiehKoFstrTzBEMbYFVIjYBHQ91tNYV4guV
# zDoqYPeZQsepmQUOdC4DS9FbcEpnAg01MQJhrAosPXeUDQWFtTjO0Vrn9PjQWoD0
# bLNEMrCQUk0XzxoOx5nJApYDBYwXXK0dLQ0VBYPAhif2fg+4RwZIoznhjQjEssQQ
# uLBC72hWnY2/Nu2EgwgRWsDmru5pKKCWD+5FfjvQKvVoly+7fOMcNWc7O3+v1Hew
# rt8WfLB3LSW4wyYRxUcjTqPVDCYfc5mLqDnAv4V4yVef4nBAKOBzCVmakKQzqdK/
# 15Fax3lqHSHFXGoYpq8uY8esKwBstCLVFaaN18hU+LfnZjl2sMvYHU7TTHH9NW/a
# OSE1Okh+tBWvD+TCQyiSM00yanDjuCCzechta77i/MDkDRgnKJ1lkIazKZZZ+x76
# Ng==
# SIG # End signature block

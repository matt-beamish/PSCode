<#
.SYNOPSIS
Return an argument list for code.exe

.PARAMETER resourcePath
Path to the electron resource used by code.exe. See file code.cmd

.PARAMETER allArgs
Input arguments as an array of objects
#>
function GetArgs($resourcePath, [object[]]$allArgs) {

    # Attempt to flatten array and object type elements by resolving
    $flattenedArgs = @()

    foreach ($curArg in $allArgs) {
        $resolved = (Resolve-Path $curArg -ea si | Convert-Path)
        if ($resolved) {
            $flattenedArgs += $resolved
        }
        else {
            $flattenedArgs += [string]$curArg
        }
    }

    $allArgsQuoted = $flattenedArgs | % {
        if ($_ -like '* *') {'"{0}"' -f $_ } else {$_}
    }

    # Prepend the resource path to match behavior of code.cmd
    $codeArgs = @(('"{0}"' -f $resourcePath)) + $allArgsQuoted | select -uniq

    $codeArgs
}

# SIG # Begin signature block
# MIII/QYJKoZIhvcNAQcCoIII7jCCCOoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA0fxoJKQv+8gXi
# V0zZvSrKeQIQIJcbPeOjAujd6fc4wKCCBVwwggVYMIIDQKADAgECAhBkQJ8HG9NV
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
# CSqGSIb3DQEJBDEiBCCfYDird9DALSoSY8riU31ML0m/X5sT61z7zyJogjIUzTAN
# BgkqhkiG9w0BAQEFAASCAgAi8lwUuOYB/f8cHoNZTS4PjS0AppQVZ5QY2pcmHk4P
# sKBbzIRTfc+76ud0VckOKzR1ytXkyoXagWItYSw7CHsnnH5PZaynMZC7FsQOJfo1
# fHvjtMGnsLEB80utFEnO69Hhlx6zgqNp82YlhVUOIFo4ivBjR4RiS75pd5o+y5Gu
# uVU0KJeA6/Lp66fca1jXVzBSMI2+XNBkXnaAf73+oHs6dBmEb0UmOwtxm2jfK3+1
# nKQxFzADIRwh3hTFISNRsk0rCHArcGqmTeklluQlj6oNeIqAEhXyRAuwK+P4XoZ1
# pT1EYqkKbSXgP5qXr6RaUD/6pvMymmh94++rweItHPbXFyrnC7CYvKriLzy/TyDo
# 1GbDlkbuZqgO0xTPaA6OLO5Ld81Sxh7I50T4hWdoCntdVgQwWgub0myjCqQERBZV
# wFMLpJh2QnBL7qXwnasMsXzqiBMl4MMFe2/DaRtaUTtJ2N+BGkCNJ87TUD/FAG4D
# 56WIAEtuTzSNsab2eUtBdLomjNfMZ7uDbjhictUTw/Nn6lrJbYXQSVIV5zp68+6K
# K2eBWH1+eJPAIVSx/OKEtL3xgaErCzEGjJHgwKhjWuAJ7zFMfHVarJqKgdojjeq6
# G7usR+shCogCgT8DdFlLPPjlSK5uvtvvth+g7uONiqdNCRybkZnvgmXOMw2qxY5Y
# FQ==
# SIG # End signature block

<#
    Match behavior of code.cmd
#>
function Invoke-VSCode() {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true)]
        [object]$inputObject,
        [Parameter(
            Mandatory=$false,
            Position=0,
            ValueFromRemainingArguments=$true)]
        [object[]]$allArgs=@()
    )
    BEGIN {
        $inputObjects = @()

        $codePath = join-path $script:vscodePath 'code.exe'
        $resourcePath = join-path $script:vscodePath 'resources\app\out\cli.js'
        # no longer necessary
        # $allArgs = $allArgs + "--ms-enable-electron-run-as-node"
        $codeArgs = GetArgs $resourcePath $allArgs
        Write-Verbose ("Launching VSCode with args:`n{0}" -f ($codeArgs | convertTo-json))
    }
    PROCESS {
        if ($inputObject) {
            $inputObjects += $inputObject
        }
    }
    END {
        $prior1 = $env:ELECTRON_RUN_AS_NODE
        $prior2 = $env:VSCODE_DEV
        $env:ELECTRON_RUN_AS_NODE=1
        $env:VSCODE_DEV = $null

        if ($inputObject) {
            $pipeTempPath = (join-path $env:TEMP ("pscode-stdin-{0}.txt" -f [System.GUID]::NewGuid().ToString()))
            Write-Verbose "Writing out piped input to file $pipeTempPath"
            $inputObjects | out-file $pipeTempPath -Encoding ascii
            Start-Process -FilePath $codePath -ArgumentList $codeArgs -RedirectStandardInput $pipeTempPath
        } else {
            Start-Process -FilePath $codePath -ArgumentList $codeArgs
        }

        $env:ELECTRON_RUN_AS_NODE = $prior1
        $env:VSCODE_DEV = $prior2
    }
}

# SIG # Begin signature block
# MIII/QYJKoZIhvcNAQcCoIII7jCCCOoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAa32bd5gu5kcRx
# GSFVefkA5d/jkeNnkjI8LsIyfJevDaCCBVwwggVYMIIDQKADAgECAhBkQJ8HG9NV
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
# CSqGSIb3DQEJBDEiBCAxvqM1+g8HHpuLWt5xyqyfYO2iSQJc/567ln0SGUzkQDAN
# BgkqhkiG9w0BAQEFAASCAgA0w0G6pwTdbnv+J7B31SEnFo4EqsGPU2JTa1UawXkG
# RJHwSRdunw8jN/+KcxeguwDjeqwcIt3vq3Thn+RclucZ0BEbhSPoWNM2CHs6yYzV
# wuogk82/grDZoeuGz8dnwHk0j8ODRkm8WGOqzbMlML7rh2sFzdwO2X8SaWChJxL3
# vJcgAXdMRJGYy6/xoNN0iO7zqwKdXfvtFOy+kctthEEgwwLjGZ3ypBnnA/ZMrNMA
# CV+B3a46HDoM3oQI6aVW5zJKw675MJ3nqQwiBq9cMKkGTbh2VU+Bp9GlXfM2h/+d
# BIWSKjpREgopwkp3YTee+BKi+7DJ1+XlPCn2vBamxQj3EIXk5+udp7iExn8FH4N7
# bAYYiSo/4a2YthapKStyhoAm8jIRSRudqCQNzhRFtxVUPpwpzsLQKbPndmwCQNJR
# bb1muxMSVQbVch8mbME2l3MitRRP5wqApmT2QYaaPfwrANA9PgEFGML3g3zq/kSY
# GjxFjBC1b4Xuo4g1L/CMMs+TAOyAkWdALhCOMS89OqXf+XruB6N4Q+406qmIq0QO
# Jbtfp+5wMz+p4jEBFENmsJN3wHTF12kO6zm/WRvE/Qz93VU9i22pXdZG7IRyKoi7
# tXUSXGg/RzgLWAR0j1d3+IxhDr5NCdUMXWNB6SpYOwdah9bbNsN81FRNY9SEdD+z
# ZA==
# SIG # End signature block

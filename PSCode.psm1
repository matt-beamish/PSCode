param([parameter(Position=0, Mandatory = $false)][string]$vscodePath = $null)

$script:moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path

# Dot source functions
"$script:moduleRoot\functions\*.ps1" | Resolve-Path | %{. $_.ProviderPath}

$script:vscodePath = if ($vscodePath) {$vscodePath} else {GetVsCodePath}

if (!$script:vscodePath) {
    Write-Error "VS Code's path was not able to be determined. If this is a portable install, please use -ArgumentList to pass the path."
}

set-alias code Invoke-VSCode

# Only functions with a dash are public
Export-ModuleMember -function *-* -Alias *

# SIG # Begin signature block
# MIII/QYJKoZIhvcNAQcCoIII7jCCCOoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBJ1cfRywaki+If
# Tqr5VVL+2mY7W82Oyuy3O0lW9IaEqqCCBVwwggVYMIIDQKADAgECAhBkQJ8HG9NV
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
# CSqGSIb3DQEJBDEiBCCeccJ8W7EK+lUU3gwFBLx6MV3RnpdFPa86Fszt1S7+zjAN
# BgkqhkiG9w0BAQEFAASCAgBHBc4rudKicb9WzPBmCLc+TK9tWl/5wAlMGmmJTNaF
# S2Kyoogn5C6oLczt58asp8ZaUpdeL43xJedzvKDnIpJL6zpTf/JuhkjssV9rh/7a
# gSLzER9p9h7A/h/gQiKG0vbURY4Q+lnt88h1Qy1x2IlNW7cMYqAjB11iaIEdl0kI
# 1MUgzhefk9sx3bCoxUfQ8LdWkD2lQ6iTPOyawyfalJfxNkSKMcIEW8S4dgPvlJbe
# /ZEIKO51TmyZ0o9xFdGRoY5zFWwNVyT7axvUFgmBdtzoIRwPrjnjqno/atJy0tz3
# 34yck6Av4zH1rfSmPK/co1IDnpegeaMCTyid0cr7x9XuZ9ZZ71hVZBig2YfjIy/U
# ua2PhVZLUR4UChlpCXD6XU9hAzx/eH6yXgNb/d8K6Q9RUpRTooYH3jn3ZUFhbC0M
# LkFoBXNJ1Lv6K81Jn8mGjCmEz/jJ6CpASoP4IfFSIMvrXBsTPC0OJAbIDSYUhVJ2
# RJGVN4ZkDG3oEW75nKOwRkc7q6SfAaWVgK2yroWO+JdRYgOmzsvnqGnO6foyCzJv
# aJf+MG+mvEvwRhBGARG1EenZGXFBPb5CYQGCz6hIaSYDc8B0Mw4YDjBPe5qHBv+j
# 1Ul/qNikzGBkSLf9GUr3q7baQwN/6hryHDUfrg3OD/2NtXTPHTL7xkhlZOiYVyCm
# XA==
# SIG # End signature block

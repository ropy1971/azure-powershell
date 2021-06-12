$RNG = [Security.Cryptography.RNGCryptoServiceProvider]::Create()
[Byte[]]$x=1
for($r=''; $r.length -lt 64){$RNG.GetBytes($x); if([char]$x[0] -clike '[2-7A-Z]'){$r+=[char]$x[0]}}
$r

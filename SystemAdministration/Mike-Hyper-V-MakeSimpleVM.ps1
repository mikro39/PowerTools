### Automated Hyper-V VM Creation Script for blank box ###






$envname = "vkube02"
$envmemory = 2GB
$envdisksize = 60GB
$vhdpath = "V:\VMs\" + $envname + "\" + $envname + ".vhdx"

New-VM -Generation 2 -Name $envname -MemoryStartupBytes $envmemory -NewVHDSizeBytes $envdisksize -NewVHDPath $vhdpath
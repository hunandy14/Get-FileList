# 格式化容量單位
function FormatCapacity {
    param (
        [Parameter(Position = 0, ParameterSetName = "")]
        [double] $Value=0,
        [Parameter(Position = 1, ParameterSetName = "")]
        [double] $Digit=1, 
        [switch] $KB
    )
    # 設定單位
    [string] $Unit_Type = ' B'
    [double] $Unit = 1024.0
    $UnitList = @('KB', 'MB', 'GB', 'TB', 'PB')
    # 開始換算
    foreach ($Item in $UnitList) {
        $bool = (([Math]::Floor($Value)|Measure-Object -Character).Characters -gt 3)
        if ($bool -or $KB) {
            $Value = $Value/$Unit; $Unit_Type = $Item
            if ($KB) { break }
        } else { break }
    }
    return "$([Math]::Round($Value, $Digit)) $Unit_Type"
} # FormatCapacity 18915618941 0 -KB

# 獲取檔案清單
function Get-FileList {
    param (
        [Parameter(Position = 0, ParameterSetName = "")]
        [string] $Path = (Get-Location),
        [Parameter(ParameterSetName = "")]
        [double] $Digit=0, 
        [switch] $AutoCarry,
        [object] $Include,
        [object] $Exclude,
        [string] $NoMatch,
        
        [switch] $FullName,
        [switch] $FullPath
    )
    # 儲存當前路徑
    $CurrPath = Get-Location
    # 獲取檔案
    $List = (Get-ChildItem -Recurse -File $Path -Include:$Include -Exclude:$Exclude)
    if ($NoMatch) { $List=$List -notmatch $NoMatch }
    # 格式化輸出
    Set-Location $Path
    if ($FullName) {
        $List|Format-Table `
        @{Name='File'; Expression={$_.FullName}},`
        @{Name='Size'; Expression={FormatCapacity $_.Length $Digit -KB:(!$AutoCarry)}; align='right'},`
        LastWriteTime  
    } elseif ($FullPath) {
        $List|Format-Table `
        @{Name='File'; Expression={$_.FullName|Resolve-Path -Relative}},`
        @{Name='Size'; Expression={FormatCapacity $_.Length $Digit -KB:(!$AutoCarry)}; align='right'},`
        LastWriteTime
    } else {
        $List|Format-Table `
        @{Name='ResolvePath'; Expression={($_.Directory|Resolve-Path -Relative)-replace'^..\\(.*)', '.\' }},`
        @{Name='Name'; Expression={$_.Name}},`
        @{Name='Size'; Expression={FormatCapacity $_.Length $Digit -KB:(!$AutoCarry)}; align='right'},`
        LastWriteTime
    }
    Set-Location $CurrPath
} # Get-FileList -AutoCarry
# Get-FileList "C:\Users\hunan\OneDrive\Git Repository\pwshApp" -Include:@('*.txt', '*.md') -Exclude:@('README*') -NoMatch:'hita_html'
Get-FileList 'Z:\uniqlo' -AutoCarry -FullName
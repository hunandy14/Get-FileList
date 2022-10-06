獲取Windwos檔案清單
===

快速使用
```ps1
irm bit.ly/Get-FileList|iex; Get-FileList
```

詳細使用方法
```ps1
# 獲取當前路徑清單
irm bit.ly/Get-FileList|iex; Get-FileList
# 獲取指定路徑清單
irm bit.ly/Get-FileList|iex; Get-FileList 'C:\Work'
# 檔案大小自動進位
irm bit.ly/Get-FileList|iex; Get-FileList -AutoCarry 'C:\Work'
# 檔案大小進位位數
irm bit.ly/Get-FileList|iex; Get-FileList -Digit 0

# 獲取特定檔名
irm bit.ly/Get-FileList|iex; Get-FileList -Include:@('*.txt', '*.md') 'C:\Work'
# 排除特定檔名
irm bit.ly/Get-FileList|iex; Get-FileList -Exclude:@('README*') 'C:\Work'
# 排除特定路徑 (輸入是正則, 有符號記得加入標記符號)
irm bit.ly/Get-FileList|iex; Get-FileList -NoMatch:"dirName1|dirName2" 'C:\Work'

# 完整路徑 (預設把路徑跟檔名分開了)
irm bit.ly/Get-FileList|iex; Get-FileList -FullPath
# 完整名稱 (絕對路徑)
irm bit.ly/Get-FileList|iex; Get-FileList -FullName

```
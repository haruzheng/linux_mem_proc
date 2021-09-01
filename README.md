# mem_proc
## Source
* https://blog.csdn.net/sunao2002002/article/details/53999098
* https://www.twblogs.net/a/5cbf2b04bd9eee397113c09e
## How to cross compile for embeded linux?
```bash
add the following in CMakeLists.txt:
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_C_COMPILER "arm-linux-gnueabihf-gcc")
```

## VSS/RSS/PSS/USS 的介紹
![](https://i.imgur.com/9hfPmMH.png)
Android 有一個名爲 procrank (/system/xbin/procrank) 的工具，它從高到低的順序列出了 Linux Process 的內部記憶體使用情況。其報告中有四個不同的大小，分別 VSS、RSS、PSS 和 USS。
一般來說內部記憶體占用大小有如下規律或關係：VSS >= RSS >= PSS >= USS

### VSS - Virtual Set Size (用處不大)
虛擬記憶體所使用的內部記憶體 (包含共享函式庫所佔用的全部內部記憶體，以及分配但未使用內部記憶體)。其大小還包括了可能不在 RAM 中的內部記憶體 (比如雖然 malloc 分配了空間，但尚未寫入)。 VSS 很少被用於判斷一個 Process 的真實內部記憶體使用量。

### RSS - Resident Set Size (用處不大)
實際使用物理內部記憶體 (包含共享函式庫佔用的全部內部記憶體)。但是 RSS 還是可能會造成誤導，因為它僅僅表示該 Process 所使用的所有共享函式庫的大小，它不管有多少個 Process 使用該共享函式庫，該共享函式庫僅被加載到內部記憶體一次。所以 RSS 並不能準確反映單 Process 的內部記憶體使用情況。

### PSS - Proportional Set Size (僅供參考)
實際使用的物理內部記憶體 (比例分配共享函式庫佔用的內部記憶體，按照 Process 數等比例劃分)。例如：如果有三個 Process 都使用了一個共享函式庫，共佔用了 30 Pages 的內部記憶體。那麼 PSS 將認為每個 Process 分別佔用該共享函式庫 10 Pages 的大小。 PSS 是非常有用的資訊，因為系統中所有 Process 的 PSS 都相加的話，就剛好反映了系統中整體總共佔用的內部記憶體。而當一個 Process 被 Kill/Drop 之後， 其占用的共享函式庫那部分比例的 PSS，將會再次按比例分配給餘下使用該共享函式庫的 Process。這樣 PSS 可能會造成一點的誤導，因為當一個 Process 被 Kill/Drop 後， PSS 不能準確地表示返回給全域系統的內部記憶體。

### USS - Unique Set Size (非常有用)
 Process 獨自佔用的物理內部記憶體 (不包含共享函式庫佔用的內部記憶體)。 USS是非常非常有用的資訊，因為它反映了運行一個特定 Process 真實的邊際成本 (增量成本)。當一個 Process 被 Kill/ Drop 後，USS 是真實返回給系統的內部記憶體。當 Process 中存在一個可疑的內部記憶體洩露時，USS 是最佳觀察數據。

## procmem 欄位
* ShCl  --  shared clean
* ShDi  --  shared dirty
* PrCl  --  private clean
* PrDi  --  private dirty
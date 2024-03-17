# For Developer
Usage:
更新到 1.6.7 Julia
1. 執行Julia應該在專案目錄上一層
2. using Pkg (第一次安裝)
   Pkg.add("Revise")
   Pkg.add("FilePathsBase")
3. using Revise ; using FilePathsBase
4. ]
5. activate TWElectionANA
6. ctrl+c or backspace
7. using TWElectionANA
8. dtl = TWElectionANA.  <TAB> 查看指令
9.dtl = TWElectionANA.get_p_data("新北市", 2024)

```
# Open Julia terminal
julia>]
(@v1.6) pkg> st
      Status `C:\Users\David\.julia\environments\v1.6\Project.toml`
  [5fb14364] OhMyREPL v0.5.23
  [295af30f] Revise v3.5.13
  [3867c857] TWElectionANA v0.1.0 `D:\David\dev\julia\packages\TWElectionANA`
  [fdbf4ff8] XLSX v0.10.1
julia> using Revise
(@v1.6) pkg> activate TWElectionANA
  Activating environment at `D:\David\dev\julia\packages\TWElectionANA\Project.toml`
julia> using TWElectionANA
[ Info: Precompiling TWElectionANA [3867c857-bc43-4d23-84ca-015006f4a3a6]
julia> TWElectionANA.bar()
ERROR: UndefVarError: bar not defined
Stacktrace:
 [1] getproperty(x::Module, f::Symbol)
   @ Base .\Base.jl:26
 [2] top-level scope
   @ REPL[5]:1
# Add function bar in TWElectionANA package and save the file
julia> TWElectionANA.bar()
bar
```

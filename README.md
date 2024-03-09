# For Developer

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

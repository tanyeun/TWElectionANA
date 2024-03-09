module TWElectionANA

using XLSX
using PrettyTables
using FilePathsBase

greet() = println("選舉數據分析")

function main()
  greet()
  year2023()
end

function assign_data(dt, row)
  dt["柯盈"]         = row[4]
  dt["賴蕭"]         = row[5]
  dt["侯趙"]         = row[6]
  dt["有效票數"]     = row[7]
  dt["無效票數"]     = row[8]
  dt["投票數"]       = row[9]
  dt["已領未投票數"] = row[10]
  dt["發出票數"]     = row[11]
  dt["用餘票數"]     = row[12]
  dt["選舉人數"]     = row[13]
  dt["投票率"]       = row[14]
  return dt
end

function add_suo_data(li, suo)
  li["柯盈"]         += suo["柯盈"]
  li["賴蕭"]         += suo["賴蕭"]
  li["侯趙"]         += suo["侯趙"]
  li["有效票數"]     += suo["有效票數"]
  li["無效票數"]     += suo["無效票數"]
  li["投票數"]       += suo["投票數"]
  li["已領未投票數"] += suo["已領未投票數"]
  li["發出票數"]     += suo["發出票數"]
  li["用餘票數"]     += suo["用餘票數"]
  li["選舉人數"]     += suo["選舉人數"]
  return li
end

function assign_data_liwei(dt, row)
  dt["民進黨"]       = row[9]
  dt["國民黨"]       = row[12]
  dt["民眾黨"]       = row[15]
  dt["有效票數"]     = row[20]
  dt["無效票數"]     = row[21]
  dt["投票數"]       = row[22]
  dt["已領未投票數"] = row[23]
  dt["發出票數"]     = row[24]
  dt["用餘票數"]     = row[25]
  dt["選舉人數"]     = row[26]
  dt["投票率"]       = row[27]
  return dt
end

function add_suo_data_liwei(li, suo)
  li["民進黨"]         += suo["民進黨"]
  li["國民黨"]         += suo["國民黨"]
  li["民眾黨"]         += suo["民眾黨"]
  li["有效票數"]     += suo["有效票數"]
  li["無效票數"]     += suo["無效票數"]
  li["投票數"]       += suo["投票數"]
  li["已領未投票數"] += suo["已領未投票數"]
  li["發出票數"]     += suo["發出票數"]
  li["用餘票數"]     += suo["用餘票數"]
  li["選舉人數"]     += suo["選舉人數"]
  return li
end

function get_f_name(area)
    return "總統-A05-4-候選人得票數一覽表-各投開票所($(area)).xlsx"
end

function get_f_head(year)
  if year == 2024
    return joinpath("TWElectionANA", "data", "20240113全國開票數據", "總統副總統選舉")
  else
    return nothing
  end
end

function get_f_name_liwei(area)
  return "不分區立委-A05-6-得票數一覽表($(area)).xlsx"
end

function get_f_head_liwei(year)
  if year == 2024
    return joinpath("TWElectionANA", "data", "20240113全國開票數據", "不分區立委")
  else
    return nothing
  end
end

function get_district(dt, cat)
  if "各區" in keys(dt[2])
    i = 1
    for x in dt[2]["各區"]
      for y in x
        if length(y.first) > 2
          if cat == "總統"
            p = round(100 * y.second["柯盈"] / y.second["有效票數"], digits=2)
            println("$(y.first)\t$(i)\t$(Int(y.second["柯盈"]))\t$(p)")
          elseif cat == "不分區"
            p = round(100 * y.second["民眾黨"] / y.second["有效票數"], digits=2)
            println("$(y.first)\t$(i)\t$(Int(y.second["民眾黨"]))\t$(p)")
          end
        end
      end 
      i += 1
    end
    total = length(dt[2]["各區"])
    println("總共: $(total)區")
  end
end
function print_district(dt, cat)
  if "各區" in keys(dt[2])
    i = 1
    for x in dt[2]["各區"]
      for y in x
        if length(y.first) > 2
          if cat == "總統"
            p = round(100 * y.second["柯盈"] / y.second["有效票數"], digits=2)
            println("$(y.first)\t$(i)\t$(Int(y.second["柯盈"]))\t$(p)")
          elseif cat == "不分區"
            p = round(100 * y.second["民眾黨"] / y.second["有效票數"], digits=2)
            println("$(y.first)\t$(i)\t$(Int(y.second["民眾黨"]))\t$(p)")
          end
        end
      end 
      i += 1
    end
    total = length(dt[2]["各區"])
    println("總共: $(total)區")
  end
end
function get_district_over(dt, cat, rate)
  if "各區" in keys(dt[2])
    i = 1
    for x in dt[2]["各區"]
      for y in x
        if length(y.first) > 2
          if cat == "總統"
            p = round(100 * y.second["柯盈"] / y.second["有效票數"], digits=2)
            if p > rate
              println("$(y.first)\t$(Int(y.second["柯盈"]))\t$(p)")
              i += 1
            end
          elseif cat == "不分區"
            p = round(100 * y.second["民眾黨"] / y.second["有效票數"], digits=2)
            if p > rate
              println("$(y.first)\t$(Int(y.second["民眾黨"]))\t$(p)")
              i += 1
            end
          end
        end
      end 
    end
    println("總共: $(i-1)區")
  end
end

function get_li(dt, dist, cat)
  total = 0
  if "各區" in keys(dt[2])
    for x in dt[2]["各區"]
      for y in x
        if length(y.first) > 2
          if y.first == dist
            total = length(x["各里"])
            i = 1
            for z in x["各里"]
              for a in z
                if cat == "總統"
                  if length(a.first) > 2
                    p = round(100 * a.second["柯盈"] / a.second["有效票數"], digits=2)
                    over_half = Int(trunc(a.second["有效票數"]/2))
                    println("$(a.first)\t$(i)\t$(Int(a.second["柯盈"]))\t$(p)\t$(over_half-Int(a.second["柯盈"]))")
                  end
                elseif cat == "不分區"
                  if length(a.first) > 2
                    p = round(100 * a.second["民眾黨"] / a.second["有效票數"], digits=2)
                    over_half = Int(trunc(a.second["有效票數"]/2))
                    println("$(a.first)\t$(i)\t$(Int(a.second["民眾黨"]))\t$(p)\t$(over_half-Int(a.second["民眾黨"]))")
                  end
                end
              end
              i += 1
            end
          end
        end
      end 
    end
    println("總共: $(total)里")
  end
end

function get_li_over(dt, dist, rate, cat)
  i = 1
  if "各區" in keys(dt[2])
    for x in dt[2]["各區"]
      for y in x
        if length(y.first) > 2
          if y.first == dist
            total = length(x["各里"])

            for z in x["各里"]
              for a in z
                if length(a.first) > 2
                  if cat == "總統"
                    p = round(100 * a.second["柯盈"] / a.second["有效票數"], digits=2)
                    over_half = Int(trunc(a.second["有效票數"]/2))
                    if p > rate
                      println("$(a.first)\t$(Int(a.second["柯盈"]))\t$(p)\t$(over_half-Int(a.second["柯盈"]))")
                      i += 1
                    end
                  elseif cat == "不分區"
                    p = round(100 * a.second["民眾黨"] / a.second["有效票數"], digits=2)
                    over_half = Int(trunc(a.second["有效票數"]/2))
                    if p > rate
                      println("$(a.first)\t$(Int(a.second["民眾黨"]))\t$(p)\t$(over_half-Int(a.second["柯盈"]))")
                      i += 1
                    end
                  end
                end
              end
            end
          end
        end
      end 
    end
    println("總共: $(i-1)里")
  end
end

function get_p_data(area, year)
  println("第16任總統副總統選舉")
  # 資料來源: 中央選舉委員會
  #    raw data: data\20240113全國開票數據
  raw_p_taipei_fname = get_f_name(area)
  f_head = get_f_head(year)
  if isnothing(f_head)
    println("Year not supported!")
    return
  end
  xf = XLSX.readxlsx(joinpath(pwd(), f_head, raw_p_taipei_fname))
  sh = xf[area]
  dict_p_taipei = Dict{String,Any}()
  dict_p_taipei["各區"] = []
  dist = Dict{String, Any}()
  dist["各里"] = []
  li = Dict{String, Any}()
  li["各所"] = []
  current_dist = ""
  current_li = ""
  row = []
  for r in XLSX.eachrow(sh)
    push!(row, r)
    # r is a `SheetRow`, values are read using column references
    rn = XLSX.row_number(r) # `SheetRow` row number
    v1 = r[1]    # will read value at column 1
    v2 = r[2]    # will read value at column 2
    v3 = r[3]    
    if !ismissing(v1)
      if v1 == "總　計"
        println("v1=$v1, v2=$v2")
        dict_p_taipei = assign_data(dict_p_taipei, r)
      end
      if v1[end] in ['鄉', '鎮', '市', '區']
        printstyled("v1=$v1, v2=$v2\n";color=:red)
        name = strip(v1)
        if current_dist != "" && current_dist != name
          println("$(current_dist) vs $(name)")
          if !isempty(li)
            push!(dist["各里"], li)
          end
          push!(dict_p_taipei["各區"], dist)
          dist = Dict{String, Any}()
          dist["各里"] = []
          li = Dict{String, Any}()
          current_li = ""
        end
        data = Dict{String, Any}()
        current_dist = name
        data = assign_data(data, r)
        dist[name] = data
      end
    end
    if !ismissing(v2)
      if v2[end] in ['村', '里']
        println("v1=$v1, v2=$v2")
        name = strip(v2)
        if current_li != "" && current_li != name
          println(current_li)
          li[current_li]["投票率"] = round((li[current_li]["投票數"] / li[current_li]["選舉人數"])*100, digits=2)
          push!(dist["各里"], li)
          li = Dict{String, Any}()
        end
        data = Dict{String, Any}()
        current_li = name
        data = assign_data(data, r)
        suo = Dict{String, Dict}()
        suo[v3] = data
        if name in keys(li)
          li[name] = add_suo_data(li[name], data)
        else
          li[name] = data
          li["各所"] = []
        end
        push!(li["各所"], suo)
      end
    end
    #println("v1=$v1, v2=$v2")
  end
  if !isempty(dist)
    # println(current_dist)
    push!(dict_p_taipei["各區"], dist)
  end
  return (row, dict_p_taipei)
end

function get_liwei_data(area, year)
  println("第11屆立法委員選舉-不分區")
  # 資料來源: 中央選舉委員會
  #    raw data: data\20240113全國開票數據
  raw_p_taipei_fname = get_f_name_liwei(area)
  f_head = get_f_head_liwei(year)
  if isnothing(f_head)
    println("Year not supported!")
    return
  end
  xf = XLSX.readxlsx(joinpath(pwd(), f_head, raw_p_taipei_fname))
  sh = xf[area]
  dict_p_taipei = Dict{String,Any}()
  dict_p_taipei["各區"] = []
  dist = Dict{String, Any}()
  dist["各里"] = []
  li = Dict{String, Any}()
  li["各所"] = []
  current_dist = ""
  current_li = ""
  row = []
  for r in XLSX.eachrow(sh)
    push!(row, r)
    # r is a `SheetRow`, values are read using column references
    rn = XLSX.row_number(r) # `SheetRow` row number
    v1 = r[1]    # will read value at column 1
    v2 = r[2]    # will read value at column 2
    v3 = r[3]    
    if !ismissing(v1)
      if v1 == "總　計"
        println("v1=$v1, v2=$v2")
        dict_p_taipei = assign_data_liwei(dict_p_taipei, r)
      end
      if v1[end] in ['鄉', '鎮', '市', '區']
        printstyled("v1=$v1, v2=$v2\n";color=:red)
        name = strip(v1)
        if current_dist != "" && current_dist != name
          println("$(current_dist) vs $(name)")
          if !isempty(li)
            push!(dist["各里"], li)
          end
          push!(dict_p_taipei["各區"], dist)
          dist = Dict{String, Any}()
          dist["各里"] = []
          li = Dict{String, Any}()
          current_li = ""
        end
        data = Dict{String, Any}()
        current_dist = name
        data = assign_data_liwei(data, r)
        dist[name] = data
      end
    end
    if !ismissing(v2)
      if v2[end] in ['村', '里']
        println("v1=$v1, v2=$v2")
        name = strip(v2)
        if current_li != "" && current_li != name
          println(current_li)
          li[current_li]["投票率"] = round((li[current_li]["投票數"] / li[current_li]["選舉人數"])*100, digits=2)
          push!(dist["各里"], li)
          li = Dict{String, Any}()
        end
        data = Dict{String, Any}()
        current_li = name
        data = assign_data_liwei(data, r)
        suo = Dict{String, Dict}()
        suo[v3] = data
        if name in keys(li)
          li[name] = add_suo_data_liwei(li[name], data)
        else
          li[name] = data
          li["各所"] = []
        end
        push!(li["各所"], suo)
      end
    end
    #println("v1=$v1, v2=$v2")
  end
  if !isempty(dist)
    # println(current_dist)
    push!(dict_p_taipei["各區"], dist)
  end
  return (row, dict_p_taipei)
end

end # module

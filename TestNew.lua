local vm={stack={}}
local output_log=""
local print=type(print)=="function" and print or function()end
function vm:run()
    print("LuaRPH-like VM Starting")
end
vm.constants={}
vm.code={}

vm:run()

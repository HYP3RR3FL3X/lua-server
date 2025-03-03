local vm={stack={}}
local output_log=""
local print=print or function()end
function vm:run()
    print("LuaRPH-like VM Starting")
end
vm.constants={}
vm.code={}


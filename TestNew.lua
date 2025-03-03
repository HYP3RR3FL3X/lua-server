local vm={stack={}}
local output_log=""
local print=print or function()end
function vm:log(msg)
    print("Logging: print is a function")
    print(msg)
    output_log=output_log..msg.."
"
end
function vm:run()
    print("Before loop: print is a function")
    self:log("LuaRPH-like VM Starting")
    print("After first log: print is a function")
    while self.ip<=#self.code do
        print("Inside loop: print is a function")
        local inst=self.code[self.ip]
        self:log("Executing: "..inst.op.." at ip: "..self.ip)
        self.ip=self.ip+1
    end
end
vm.constants={}
vm.code={{op="NOP"}}

vm:run()

local vm={stack={}}
local output_log=""
local type=type or function()return"unknown"end
local print=type(print)=="function" and print or function()end
function vm:log(msg)
    print("Logging: type of print is "..type(print))
    print(msg)
    output_log=output_log..msg.."
"
end
function vm:run()
    print("Before loop: type of print is "..type(print))
    self:log("LuaRPH-like VM Starting")
    print("After first log: type of print is "..type(print))
    while self.ip<=#self.code do
        print("Inside loop: type of print is "..type(print))
        local inst=self.code[self.ip]
        self:log("Executing: "..inst.op.." at ip: "..self.ip)
        self.ip=self.ip+1
    end
end
vm.constants={}
vm.code={{op="NOP"}}

vm:run()

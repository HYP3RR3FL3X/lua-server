local vm={stack={},instructions={},ip=1,vars={}}
local output_log=""
local identityFunc=function()end
identityFunc("Wave Executor running")
function vm:log(msg)print(msg)output_log=output_log..msg.."\n"end
function vm:run()while self.ip<=#self.instructions do self.ip=self.ip+1 end end
vm.constants={}
vm.code={}
vm:run()

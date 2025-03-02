local vm={stack={},instructions={},ip=1}if not _G.print then _G.print=function(...)local t={...}for i=1,#t do t[i]=tostring(t[i])end warn(table.concat(t," "))end end function vm:push(value)print("PUSH: "..tostring(value))table.insert(self.stack,value)end function vm:pop()local v=table.remove(self.stack)print("POP: "..tostring(v))return v end function vm:run()while self.ip<=#self.instructions do local inst=self.instructions[self.ip]print("Executing: "..inst.op)if inst.op=="PUSH"then self:push(inst.value)elseif inst.op=="CALL"then local func=_G[inst.func]if func then local args={}for i=1,inst.arg_count do table.insert(args,1,self:pop())end print("Calling "..inst.func.." with args: "..table.concat(args,","))local success,err=pcall(func,unpack(args))if not success then print("Error calling "..inst.func..": "..tostring(err))end else print("Function "..inst.func.." not found")end end self.ip=self.ip+1 end end
local bytecode={{op="PUSH",value="hello"},{op="CALL",func="print",arg_count=1}}
vm.instructions=bytecode
vm:run()

local vm={stack={},instructions={},ip=1}function vm:push(value)table.insert(self.stack,value)end function vm:pop()return table.remove(self.stack)end function vm:run()while self.ip<=#self.instructions do local inst=self.instructions[self.ip]if inst.op=="PUSH"then self:push(inst.value)elseif inst.op=="CALL"then local func=_G[inst.func]if func then local args={}for i=1,inst.arg_count do table.insert(args,1,self:pop())end func(unpack(args))end end self.ip=self.ip+1 end end
local bytecode={{op="PUSH",value="hello"},{op="CALL",func="print",arg_count=1}}
vm.instructions=bytecode
vm:run()

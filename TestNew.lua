local vm={stack={},instructions={},ip=1,vars={}}local output_log=""
print("printidentity:", printidentity, "type:", type(printidentity))
print("table:", table, "type:", type(table))
print("tostring:", tostring, "type:", type(tostring))
print("pcall:", pcall, "type:", type(pcall))
print("unpack:", unpack, "type:", type(unpack))
local identityFunc=printidentity or function()end
identityFunc("Wave Executor running")
function vm:log(msg)print(msg)output_log=output_log..msg.."
"end
function vm:push(value)self:log("PUSH: "..tostring(value))table.insert(self.stack,value)end
function vm:pop()local v=table.remove(self.stack)self:log("POP: "..tostring(v))return v end
function vm:run()while self.ip<=#self.instructions do local inst=self.instructions[self.ip]self:log("Executing: "..inst.op.." at ip: "..self.ip)if inst.op=="PUSH"then self:push(inst.value)elseif inst.op=="PUSH_NUM"then self:push(inst.value)elseif inst.op=="ADD"then local b=self:pop()local a=self:pop()local result=a+b self:push(result)elseif inst.op=="SUB"then local b=self:pop()local a=self:pop()local result=a-b self:push(result)elseif inst.op=="MUL"then local b=self:pop()local a=self:pop()local result=a*b self:push(result)elseif inst.op=="DIV"then local b=self:pop()local a=self:pop()if b==0 then self:log("Division by zero!")self:push(0)else local result=a/b self:push(result)end elseif inst.op=="SET_VAR"then local value=self:pop()self.vars[inst.var_name]=value elseif inst.op=="GET_VAR"then local value=self.vars[inst.var_name] or 0 self:push(value)elseif inst.op=="CMP"then local b=self:pop()local a=self:pop()local result=0 if inst.cmp_type=="EQ"then result=(a==b) and 1 or 0 elseif inst.cmp_type=="LT"then result=(a<b) and 1 or 0 elseif inst.cmp_type=="GT"then result=(a>b) and 1 or 0 end self:push(result)elseif inst.op=="JUMP_IF_ZERO"then local condition=self:pop()self:log("JUMP_IF_ZERO: condition: "..tostring(condition)..", offset: "..inst.offset)if condition==0 then self.ip=self.ip+inst.offset self:log("Jumping to ip: "..self.ip)else self.ip=self.ip+1 end elseif inst.op=="JUMP"then self:log("JUMP: offset: "..inst.offset) self.ip=self.ip+inst.offset self:log("Jumping to ip: "..self.ip)elseif inst.op=="CALL"then if inst.func=="print" then local args={}for i=1,inst.arg_count do table.insert(args,1,self:pop())end self:log("Calling print with args: "..table.concat(args,","))print(unpack(args))else local func=_G[inst.func]self:log("CALL: func name: "..inst.func..", value: "..tostring(func)..", type: "..type(func))if type(func)=="function" then local args={}for i=1,inst.arg_count do table.insert(args,1,self:pop())end self:log("Calling "..inst.func.." with args: "..table.concat(args,","))local success,err=pcall(func,unpack(args))if not success then self:log("Error calling "..inst.func..": "..tostring(err))end else warn("Function "..inst.func.." not callable, type: "..type(func))end end else self.ip=self.ip+1 end end end
local bytecode={{op="PUSH",value="hello"},{op="CALL",func="print",arg_count=1},{op="PUSH_NUM",value=5},{op="PUSH_NUM",value=3},{op="ADD"},{op="SET_VAR",var_name="x"},{op="GET_VAR",var_name="x"},{op="CALL",func="print",arg_count=1},{op="GET_VAR",var_name="x"},{op="PUSH_NUM",value=5},{op="CMP",cmp_type="GT"},{op="JUMP_IF_ZERO",offset=3},{op="PUSH",value="x is greater than 5"},{op="CALL",func="print",arg_count=1},{op="JUMP",offset=2},{op="PUSH",value="x is not greater than 5"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x is greater than 5"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x is not greater than 5"},{op="CALL",func="print",arg_count=1},{op="GET_VAR",var_name="x"},{op="PUSH_NUM",value=8},{op="CMP",cmp_type="EQ"},{op="JUMP_IF_ZERO",offset=3},{op="PUSH",value="x equals 8"},{op="CALL",func="print",arg_count=1},{op="JUMP",offset=2},{op="PUSH",value="x does not equal 8"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x equals 8"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x does not equal 8"},{op="CALL",func="print",arg_count=1},{op="GET_VAR",var_name="x"},{op="PUSH_NUM",value=10},{op="CMP",cmp_type="LT"},{op="JUMP_IF_ZERO",offset=3},{op="PUSH",value="x is less than 10"},{op="CALL",func="print",arg_count=1},{op="JUMP",offset=2},{op="PUSH",value="x is not less than 10"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x is less than 10"},{op="CALL",func="print",arg_count=1},{op="PUSH",value="x is not less than 10"},{op="CALL",func="print",arg_count=1}}
vm.instructions=bytecode
vm:run()

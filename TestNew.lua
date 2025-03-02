-- Define variables
local isReady = true
local myFunc = nil
local someValue = 42

-- Debug: Confirm isReady is set correctly
print("isReady after definition: ", isReady, " type: ", type(isReady))

-- Define a function
local function greet(name)
    print("Hello, " .. name)
end

-- Attempt to call a boolean
if isReady then
    print("isReady before call: ", isReady, " type: ", type(isReady))
    isReady()  -- This may cause an error if isReady is not a function
end

-- Attempt to call a nil value
myFunc()  -- This may cause an error if myFunc is nil

-- Correct function call
greet("World")

-- Another potential error: calling a number
someValue()  -- This may cause an error if someValue is not a function

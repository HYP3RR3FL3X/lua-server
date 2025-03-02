
function base64decode(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local t = {}
    local result = ""
    data = string.gsub(data, "[^" .. b .. "=]", "")
    for i = 1, #data, 4 do
        local c = string.sub(data, i, i + 3)
        c = string.gsub(c, "=", "A")
        local n = 0
        for j = 1, 4 do
            local k = string.find(b, string.sub(c, j, j)) - 1
            n = n * 64 + k
        end
        for j = 3, 1, -1 do
            local k = math.floor(n / (256 ^ (j - 1))) % 256
            result = result .. string.char(k)
        end
    end
    return result
end
loadstring(base64decode("cHJpbnQoIjEzNDE0NTY0NDk1MjM2NzkyOTMgaXMgQHJlYnJhbmRlZHNraWRgcyBEaXNjb3JkSUQgR08gUkFJRCBISU1NTSIp"))()

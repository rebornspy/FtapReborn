local HttpService = game:GetService("HttpService")

local source = HttpService:GetAsync("https://sirius.menu/rayfield")
local fn = loadstring(source)

if fn == nil then
	error("Rayfield failed to load: loadstring returned nil")
end

return fn()

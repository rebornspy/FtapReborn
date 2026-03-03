local Rayfield = require(script.Parent.rayfield)

local Window = Rayfield:CreateWindow({
	Name = "FTAP Reborn",
	LoadingTitle = "FTAP",
	LoadingSubtitle = "Initializing...",
	ConfigurationSaving = {
		Enabled = true,
	},
})

local MainTab = Window:CreateTab("Main")
local SettingsTab = Window:CreateTab("Settings")

MainTab:CreateButton({
	Name = "Start FTAP",
	Callback = function()
		print("FTAP Started")
	end,
})

SettingsTab:CreateToggle({
	Name = "Enable Feature",
	CurrentValue = false,
	Callback = function(state)
		print("Feature:", state)
	end,
})

SettingsTab:CreateSlider({
	Name = "Speed",
	Range = { 1, 100 },
	Increment = 1,
	CurrentValue = 50,
	Callback = function(value)
		print("Speed:", value)
	end,
})

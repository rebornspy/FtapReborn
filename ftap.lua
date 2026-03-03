--// Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "FTAP",
	LoadingTitle = "FTAP Loader",
	LoadingSubtitle = "Initializing...",
	ConfigurationSaving = {
		Enabled = false,
	},
})

--// Tab
local MainTab = Window:CreateTab("Main")

--// Variables
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local FLING_VELOCITY_NAME = "FlingVelocity"
local superFlingEnabled = true
local flingStrength = 850

--// UI: Toggle
MainTab:CreateToggle({
	Name = "Super Fling",
	CurrentValue = true,
	Flag = "SuperFling",
	Callback = function(state)
		superFlingEnabled = state
		print("Super Fling:", state)
	end,
})

--// UI: Slider
MainTab:CreateSlider({
	Name = "Fling Strength",
	Range = { 0, 1000 },
	Increment = 1,
	CurrentValue = flingStrength,
	Flag = "FlingStrength",
	Callback = function(value)
		flingStrength = value
		print("Strength set to:", value)
	end,
})

--// UI: Label
MainTab:CreateParagraph({
	Title = "Credits",
	Content = "YouTube: R Scripter",
})

--// Core Logic: Detect GrabParts
Workspace.ChildAdded:Connect(function(child)
	if child.Name == "GrabParts" then
		local success, grabPart = pcall(function()
			return child:WaitForChild("GrabPart", 2):WaitForChild("WeldConstraint", 2).Part1
		end)

		if not success or not grabPart then
			return
		end

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = FLING_VELOCITY_NAME
		bodyVelocity.Parent = grabPart

		local connection
		connection = child:GetPropertyChangedSignal("Parent"):Connect(function()
			if child.Parent == nil then
				if superFlingEnabled then
					print("Launched with power:", flingStrength)
					bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					bodyVelocity.Velocity = Workspace.CurrentCamera.CFrame.LookVector * flingStrength
					Debris:AddItem(bodyVelocity, 1)
				else
					bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
					Debris:AddItem(bodyVelocity, 1)
					print("Launch cancelled")
				end

				if connection then
					connection:Disconnect()
				end
			end
		end)
	end
end)

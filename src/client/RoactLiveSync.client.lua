local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

if not RunService:IsStudio() then return end

local liveSyncLocal = Instance.new("BindableEvent")
liveSyncLocal.Name = "LiveSyncLocal"
liveSyncLocal.Parent = ReplicatedStorage

local rerenderPlanned = false

-- Prevents constant reconciliation
local function planRerender()
	print("planRerender from client")
	if rerenderPlanned then return end
	rerenderPlanned = true
	liveSyncLocal:Fire()
	rerenderPlanned = false
end

local function hookLiveSync(instance)
	instance.Changed:connect(planRerender)
	instance.ChildAdded:connect(planRerender)
	instance.ChildRemoved:connect(planRerender)

	print("Client hooked", instance)
	for _, child in pairs(instance:GetChildren()) do
		hookLiveSync(child)
	end
end

hookLiveSync(ReplicatedStorage.Common)
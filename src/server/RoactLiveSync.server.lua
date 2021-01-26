local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

if not RunService:IsStudio() then return end

local liveSyncRemote = Instance.new("RemoteEvent")
liveSyncRemote.Name = "LiveSyncRemote"
liveSyncRemote.Parent = ReplicatedStorage

local rerenderPlanned = false

-- Prevents constant reconciliation
local function planRerender()
	print("planRerender from server")
	if rerenderPlanned then return end
	rerenderPlanned = true
	liveSyncRemote:FireAllClients()
	rerenderPlanned = false
end

local function hookLiveSync(instance)
	instance.Changed:connect(planRerender)
	instance.ChildAdded:connect(planRerender)
	instance.ChildRemoved:connect(planRerender)

	print("Server hooked", instance)
	for _, child in pairs(instance:GetChildren()) do
		hookLiveSync(child)
	end
end

hookLiveSync(ReplicatedStorage:WaitForChild("Common"))
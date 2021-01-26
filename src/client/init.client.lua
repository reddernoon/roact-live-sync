local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Roact = require(ReplicatedStorage.Vendor.Roact)

local existingTree = false

Roact.setGlobalConfig({
	elementTracing = true,
	propValidation = RunService:IsStudio(),
})

local function render()
    print("render")
	if existingTree then
		Roact.unmount(existingTree)
	end

	local app = require(ReplicatedStorage.Common.App:Clone())

	existingTree = Roact.mount(app, Players.LocalPlayer.PlayerGui, "MainApp")
end

local function renderLocal()
	print("render triggered from client")
	render()
end
local function renderRemote()
	print("render triggered from server")
	render()
end

if RunService:IsStudio() then
    ReplicatedStorage:WaitForChild("LiveSyncRemote").OnClientEvent:connect(renderRemote)
    ReplicatedStorage.LiveSyncLocal.Event:Connect(renderLocal)
end

render()
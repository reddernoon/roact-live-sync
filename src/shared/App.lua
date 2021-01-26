local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Vendor.Roact)

return Roact.createElement("ScreenGui", {}, {
    HelloWorld = Roact.createElement("TextLabel", {
        Size = UDim2.new(0, 500, 0, 300),
        Text = "Hello, Roact World!"
    })
})

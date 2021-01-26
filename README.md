# roact-live-sync
Experiment on a live sync for Roblox Roact through Rojo.
Heavily inspired from [Kampfkarren's code](https://github.com/Kampfkarren/zombie-strike).
The workflow aimed is:
1. Modify the UI source code from VSCode (with evaera's Studio Sync plugin), save
2. UI updates in Roblox Studio

## Getting Started

Open the source folder in VSCode, click "Start Rojo", or alternatively:

```bash
rojo build -o "roact-live-sync.rbxlx"
```

Next, open `roact-live-sync.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

## In Roblox Studio

You should have the Rojo plugin installed. Open the baseplate template in Studio.
1. Click on `Connect` in the Rojo plugin's window.
2. Click on `Play` or F5 in Studio.
You should see a `Hello, Roact World` window.

From my understanding the live sync should already be working, but it is not.

You have to toggle to server mode (the button next to Play) and hit `Connect` in the Rojo plugin. Switch again to client mode.

Now you should be able to open `src/shared/App.lua` and for example change the Text in...
```lua
return Roact.createElement("ScreenGui", {}, {
    HelloWorld = Roact.createElement("TextLabel", {
        Size = UDim2.new(0, 500, 0, 300),
        Text = "Hello, Roact World!"
    })
})
```
...to see the effect immediately, both in server or client mode.
Editing `ReplicatedStorage/Common/App` from Studio should also update in realtime both in server and client mode.

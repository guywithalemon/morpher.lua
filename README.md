# morpher.lua
Extremely simple Roblox module to change a player's character model into another model.
Includes extra functionality such as reverting a player's character into their original.

# code examples;

### supplying an original character
```luau

local Morpher = require("@Morpher")
local Players = game:GetService("Players")

local function OnPlayerAdded(player:Player)
	
	local playerCharacter = player.Character or player.CharacterAdded:Wait()
	
	if not player:HasAppearanceLoaded() then 
		player.CharacterAppearanceLoaded:Wait() -- character is actually a gray dummy on immediate load
	end
	
	playerCharacter.Archivable = true
	
	local characterClone = playerCharacter:Clone()

	for _, instance in characterClone:GetChildren() do
		if instance:IsA("LuaSourceContainer") then instance:Destroy() end
	end
	
	Morpher.SupplyOriginalModel(player, characterClone)
	playerCharacter.Archivable = false

end

Players.PlayerAdded:Connect(OnPlayerAdded)

```

### morphing
```luau
local Morpher = require("@Morpher")
local Players = game:GetService("Players")

local MyCoolCharacter:Model = workspace.MyCoolCharacter

local function OnPlayerAdded(player:Player)
	
	task.wait(10)
	Morpher.Morph(player, MyCoolCharacter)
	
end

Players.PlayerAdded:Connect(OnPlayerAdded)
```

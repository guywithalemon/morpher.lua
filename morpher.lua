--@author guywithalemon - https://guywithalemon.neocities.org
--@desc Extremely simple module to change a player's character model into another model. Includes some extra functionality.

local morpher = {}

local StarterCharacterScripts = game:GetService("StarterPlayer").StarterCharacterScripts
local OriginalPlayerModels:{[Players]:Model} = {}

-- Returns the list of supplied original models.
function morpher.GetOriginalModelsList()
	return OriginalPlayerModels
end

-- Supply a model to be considered as the original model for this player, which is used when UndoMorph() is called.
function morpher.SupplyOriginalModel(player:Player, modelToBeSupplied:Model)
	OriginalPlayerModels[player] = modelToBeSupplied
end

-- Removes a player from the supplied model list. Example use is when a player leaves. If the player is not in the list, nothing happens.
function morpher.RemovePlayerFromOriginalModelList(player:Player)
	if not OriginalPlayerModels[player] then return end
	OriginalPlayerModels[player] = nil
end

-- Changes a player's character model into the morphModel.
function morpher.Morph(player:Player, morphModel:Model): Model
	
	local playerOldCharacter = player.Character
	local newMorphModel = morphModel:Clone()
	
	newMorphModel.Name = player.Name
	newMorphModel:PivotTo(playerOldCharacter:GetPivot())
	
	player.Character = newMorphModel
	
	newMorphModel.Parent = game.Workspace
	
	for _, object in StarterCharacterScripts:GetChildren() do
		object:Clone().Parent = newMorphModel
	end
	
	playerOldCharacter:Destroy()
	
	return newMorphModel
	
end

-- Morphs a player into their supplied original model, which must be supplied first through SupplyOriginalModel().
function morpher.UndoMorph(player:Player)
	
	assert(OriginalPlayerModels[player], `No player found with name {player.Name} within list of supplied characters. Did you forget to call SupplyOriginalModel() for {player.Name}?`)
	morpher.Morph(player, OriginalPlayerModels[player])
	
end

return morpher

local Module  =  game:GetService("Players").LocalPlayer.PlayerScripts.Code.controllers.character.characterStaminaController
local ClassModule = require(Module).CharacterStaminaController
hookfunction(ClassModule.useStamina, function() return true end)

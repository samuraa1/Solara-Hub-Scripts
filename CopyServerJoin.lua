local Place = game.PlaceId
local JobId = game.JobId
setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance('..Place..', "'..JobId ..'", game:GetService("Players").LocalPlayer)')

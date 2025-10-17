local discord = 'https://discord.gg/gYhqMRBeZV'
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local HTTPs = game:GetService("HttpService")
local Market = game:GetService("MarketplaceService")
local pending = {}
local allowed = {}
local allowed2 = {}

local request2
if type(request) == "function" then
    request2 = clonefunction(request)
else
    request2 = function() return {Success = false} end
end

local blockedfunctions = {}
local function safeAdd(tbl, func, name)
    if type(func) == "function" then
        table.insert(tbl, func)
    end
end

safeAdd(blockedfunctions, hookfunction, "hookfunction")
safeAdd(blockedfunctions, writefile, "writefile")
safeAdd(blockedfunctions, makefolder, "makefolder")
safeAdd(blockedfunctions, request, "request")
safeAdd(blockedfunctions, Market.PromptPurchase, "PromptPurchase")
safeAdd(blockedfunctions, Market.PromptGamePassPurchase, "PromptGamePassPurchase")
safeAdd(blockedfunctions, Market.PromptBundlePurchase, "PromptBundlePurchase")
safeAdd(blockedfunctions, Market.PromptPremiumPurchase, "PromptPremiumPurchase")
safeAdd(blockedfunctions, Market.PromptSubscriptionPurchase, "PromptSubscriptionPurchase")
safeAdd(blockedfunctions, Market.PromptProductPurchase, "PromptProductPurchase")
safeAdd(blockedfunctions, Market.PerformPurchase, "PerformPurchase")
safeAdd(blockedfunctions, Market.PerformPurchaseV2, "PerformPurchaseV2")

local RBX = game:GetService('RbxAnalyticsService')

local Specific = {
    RbxAnalyticsService = {
        RBX.GetClientId,
        RBX.GetSessionId,
        RBX.GetPlaySessionId
    },
    Requests = {}
}

if syn_backup and type(syn_backup.request) == "function" then
    Specific.Requests['syn_backup.request'] = syn_backup.request
end
if type(http_request) == "function" then
    Specific.Requests['http_request'] = http_request
end
if type(request) == "function" then
    Specific.Requests['request'] = request
end
if http and type(http.request) == "function" then
    Specific.Requests['http.request'] = http.request
end
if syn and type(syn.request) == "function" then
    Specific.Requests['syn.request'] = syn.request
end
if fluxus and type(fluxus.request) == "function" then
    Specific.Requests['fluxus.request'] = fluxus.request
end

local Methods = {
    RBX = {
        'GetClientId',
        'GetSessionId',
        'GetPlaySessionId'
    }
}
local path = 'RoTotal'
local SelfWriting, SendAsyncAllowed, SendAsyncBlocked, SelfRequesting, BySelf = false, false, false, false, false

local HttpMethods = {}
local function safeAddHttpMethod(name)
    if game:FindFirstChild(name) and type(game[name]) == "function" then
        table.insert(HttpMethods, game[name])
    end
end

safeAddHttpMethod("HttpPost")
safeAddHttpMethod("HttpGet")
safeAddHttpMethod("HttpPostAsync")
safeAddHttpMethod("HttpGetAsync")

function encode(a)
    return HTTPs:JSONEncode(a)
end

function decode(a)
    return HTTPs:JSONDecode(a)
end

function getid(list)
    for i, v in pairs(list) do 
        if type(v) == 'number' then 
            return v 
        end 
    end
    return nil
end

local functions = {
    URLMain = function(url)
        local formatted = url:match("https://.+") or url:match("http://.+")
        if formatted then
            formatted = formatted:split("/")[3]
            return formatted:gsub("https://", ''):gsub('http://', '')
        end
        return "unknown"
    end
}

function TableLoop(thing, indent)
    indent = indent or 1
    if typeof(thing) ~= 'table' then 
        return tostring(thing) 
    end
    
    local result = '{\n'
    
    for i, v in pairs(thing) do
        local key = tostring(i)
        local value = TableLoop(v, indent + 1)
        local value2 = ''
        value2 = (typeof(v) == 'string' and ("'%s'"):format(v)) or tostring(value)
        
        result = result .. string.rep('  ', indent) .. "['" .. key .. "'] = " .. value2 .. ',\n'
    end
    
    return result .. string.rep('  ', indent - 1) .. "}"
end

function tocURL(args)
    local cmd = "curl -X " .. (args.Method or "GET") .. " \"" .. (args.Url or "") .. "\""
    
    if args.Headers then
        for key, value in pairs(args.Headers) do
            cmd = cmd .. " -H \"" .. tostring(key) .. ": " .. tostring(value) .. "\""
        end
    end
    
    if args.Body then
        cmd = cmd .. " --data-raw '" .. tostring(args.Body) .. "'"
    end
    
    return cmd
end

local Window = Fluent:CreateWindow({
    Title = "RoTotal",
    SubTitle = "by vxsty",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Socials = Window:AddTab({ Title = "Social", Icon = "globe" })
}

local Options = Fluent.Options

function Notify(title, text, duration)
    Fluent:Notify({
        Title = title,
        Content = text,
        Duration = duration or 5
    })
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

Tabs.Socials:AddButton({
    Title = "Discord",
    Description = "Join my discord server",
    Callback = function()
        local success, err = pcall(setclipboard, discord)
        if success then
            Notify("Success", 'Successfully copied discord invite to clipboard!', 5)
        else
            Notify("Error!", 'Failed to copy invite to clipboard, Printed error message.', 5)
            warn(err)
        end
    end
})

Tabs.Socials:AddButton({
    Title = "Other Scripts",
    Description = "https://scriptblox.com/u/vxsty",
    Callback = function()
        setclipboard("https://scriptblox.com/u/vxsty")
        Notify("Success", "Copied to clipboard!", 3)
    end
})

local old0, old00, old, old3, old4, old5, old6, old7, old10

local function safeHookFunction(func, newFunc, funcName)
    if type(func) == "function" then
        return hookfunction(func, newFunc)
    else
        warn("Attempted to hook non-function: " .. tostring(funcName))
        return func
    end
end

old0 = safeHookFunction(game:GetService("Players").LocalPlayer.Kick, newcclosure(function(Self, message)
    return Notify("AntiKick", 'Kick attempt denied, Kick Message: ' .. tostring(message), 10)
end), "LocalPlayer.Kick")

old00 = safeHookFunction(game:GetService("Players").ReportAbuse, newcclosure(function(Self, ...)
    return Notify("ReportAbuse", 'ReportAbuse attempt denied.', 6)
end), "Players.ReportAbuse")

old = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Method, Args = getnamecallmethod(), {...}

    if Method:lower():find('http') and SelfRequesting then 
        return old(Self, ...) 
    end
    
    if Method == 'CaptureFocus' then
        local tab = Window:AddTab({ Title = 'CaptureFocus', Icon = "focus" })
        tab:AddParagraph({
            Title = 'CaptureFocus access wanted.',
            Content = (getcallingscript() and getcallingscript():GetFullName() or 'unknown') .. ' would like to use CaptureFocus on ' .. tostring(Self)
        })
        tab:AddButton({
            Title = 'Allow', 
            Description = 'Always allows CaptureFocus on this instance', 
            Callback = function()
                table.insert(allowed2, Self)
            end
        })
        tab:AddButton({
            Title = 'Block', 
            Description = 'Removes this from the allowed table', 
            Callback = function()
                for i, v in pairs(allowed2) do 
                    if v == Self then 
                        table.remove(allowed2, i) 
                        break 
                    end 
                end
            end
        })
        return
    elseif Method == 'SendAsync' then
        if not table.find(allowed2, Self) and not BySelf then
            local tab = Window:AddTab({ Title = 'SendAsync', Icon = "send" })
            tab:AddParagraph({
                Title = "Channel",
                Content = Self.Name
            })
            tab:AddParagraph({
                Title = "Message",
                Content = Args[1]
            })
            tab:AddButton({
                Title = 'Send', 
                Description = 'Sends the message in the select channel.', 
                Callback = function()
                    BySelf = true 
                    local success = pcall(function() 
                        Self:SendAsync(Args[1]) 
                    end)
                    BySelf = false
                    if success then
                        Notify("Success", "Message sent!", 3)
                    end
                end
            })
            tab:AddButton({
                Title = 'Allow', 
                Description = "Allows messages to be sent by a script in this channel", 
                Callback = function()
                    table.insert(allowed2, Self)
                end
            })
            tab:AddButton({
                Title = 'Block', 
                Description = "Blocks messages being sent by a script in this channel", 
                Callback = function()
                    for i, v in pairs(allowed2) do 
                        if v == Self then 
                            table.remove(allowed2, i) 
                            break 
                        end 
                    end
                end
            })
            return
        end
    elseif table.find(Methods.RBX, Method) then
        return HTTPs:GenerateGUID(false)
    elseif Method == 'RequestLimitedAsync' then
        Notify('RequestLimitedAsync', 'Script tried to use RequestLimitedAsync, Denying..', 5)
        return
    end
    
    return old(Self, ...)
end))

for i, methodName in pairs({"HttpPost", "HttpGet", "HttpPostAsync", "HttpGetAsync"}) do
    if game:FindFirstChild(methodName) and type(game[methodName]) == "function" then
        local original = game[methodName]
        safeHookFunction(original, function(Self, ...)
            if SelfRequesting then 
                SelfRequesting = false
                return original(Self, ...)
            end
            
            local Args = {...}
            local url = Args[1]
            local method = methodName:gsub("Async", ""):gsub("Http", "")
            
            if not table.find(allowed, url) then
                local tab = Window:AddTab({ Title = functions.URLMain(url), Icon = "globe" })
                tab:AddParagraph({
                    Title = 'Requested With',
                    Content = 'game:' .. methodName
                })
                tab:AddParagraph({
                    Title = "URL",
                    Content = url
                })
                tab:AddParagraph({
                    Title = "Method",
                    Content = method
                })
                
                if method == "Post" and Args[2] then
                    tab:AddParagraph({
                        Title = "Body",
                        Content = tostring(Args[2])
                    })
                end
                
                if method == "Post" then
                    tab:AddButton({
                        Title = 'Allow', 
                        Description = "Adds the request url to the allowed urls table", 
                        Callback = function()
                            table.insert(allowed, url)
                        end
                    })
                    tab:AddButton({
                        Title = 'Block', 
                        Description = "Removes the request url from the allowed urls table", 
                        Callback = function()
                            for i, v in pairs(allowed) do 
                                if v == url then 
                                    table.remove(allowed, i) 
                                    break 
                                end 
                            end
                        end
                    })
                end
                
                return nil
            end
            
            return original(Self, ...)
        end, methodName)
    end
end

old3 = safeHookFunction(writefile, newcclosure(function(file, content)
    if not SelfWriting and file == path.."/config.json" then
        warn("Script tried to access RoTotal/config.json files, Attempt denied.")
        Notify('Files Accessed', 'Script attempted to access the RoTotal files, Attempt denied.', 8)
        return
    end
    return old3(file, tostring(content))
end), "writefile")

old4 = safeHookFunction(makefolder, newcclosure(function(folderPath)
    if not SelfWriting and folderPath == path then
        warn("Script tried to recreate the RoTotal folder, Attempt denied.")
        Notify('Files Accessed', 'Script attempted to access the RoTotal files, Attempt denied.', 8)
        return
    end
    return old4(folderPath)
end), "makefolder")

old5 = safeHookFunction(clonefunction, newcclosure(function(func)
    if table.find(blockedfunctions, func) or func == clonefunction then
        Notify('Bypass Attempt', 'Script tried to bypass detections with clonefunction, attempt denied.', 8)
        return print
    end
    return old5(func)
end), "clonefunction")

old6 = safeHookFunction(hookfunction, newcclosure(function(func, func2)
    if func == hookfunction then
        Notify('Bypass Attempt', 'Script tried to bypass detections with hookfunction, attempt denied.', 8)
        return print
    end
    return old6(func, func2)
end), "hookfunction")

for i = 7, #blockedfunctions do
    local func = blockedfunctions[i]
    if type(func) == "function" then
        safeHookFunction(func, newcclosure(function(...)
            local productId = getid({...})
            if productId then
                local success, info = pcall(function()
                    return Market:GetProductInfo(productId)
                end)
                if success then
                    local owner = info.CreatorTargetId
                    local Owner = "Unknown"
                    local price = info.PriceInRobux or 0
                    
                    pcall(function()
                        Owner = game:GetService('Players'):GetNameFromUserIdAsync(owner)
                    end)
                    
                    print("Owner:", Owner, "\nPrice:", price, '\nOwner ID:', owner)
                    Notify('MarketplaceService', 'Script attempted to prompt/complete a purchase, printed product info.', 5)
                end
            end
            return
        end), "MarketplaceFunction_" .. i)
    end
end

for i, v in ipairs(Specific.RbxAnalyticsService) do
    if type(v) == "function" then
        safeHookFunction(v, function()
            Notify("RbxAnalyticsService accessed", 'RbxAnalyticsService accessed, returned random GUID', 5)
            return HTTPs:GenerateGUID(false)
        end, "RbxAnalyticsService_" .. i)
    end
end

for name, v in pairs(Specific.Requests) do
    if type(v) == "function" then
        local old0 = v
        safeHookFunction(v, newcclosure(function(...)
            if SelfRequesting then 
                SelfRequesting = false 
                return old0(...) 
            end
            
            local args = {...}
            if #args > 0 and type(args[1]) == 'table' then 
                args = args[1]
            end
            
            if args.Url and not table.find(allowed, args.Url) then
                local tab = Window:AddTab({ Title = functions.URLMain(args.Url), Icon = "globe" })
                tab:AddParagraph({
                    Title = 'Requested With',
                    Content = name
                })
                tab:AddParagraph({
                    Title = "URL",
                    Content = args.Url
                })
                tab:AddParagraph({
                    Title = "Method",
                    Content = args.Method or "GET"
                })
                tab:AddParagraph({
                    Title = 'Headers', 
                    Content = args.Headers and TableLoop(args.Headers, 1) or 'No Headers'
                })
                tab:AddParagraph({
                    Title = "Body",
                    Content = args.Body or 'Empty'
                })
                
                if args.Method and args.Method ~= 'GET' then
                    tab:AddButton({
                        Title = 'Allow', 
                        Description = "Adds the request url to the allowed urls table", 
                        Callback = function()
                            table.insert(allowed, args.Url)
                        end
                    })
                    tab:AddButton({
                        Title = 'Block', 
                        Description = "Removes the request url from the allowed urls table", 
                        Callback = function()
                            for i, v in pairs(allowed) do 
                                if v == args.Url then 
                                    table.remove(allowed, i) 
                                    break 
                                end 
                            end
                        end
                    })
                end
                
                local drop = tab:AddDropdown("CopyDropdown", {
                    Title = "Copy As",
                    Values = {'', "Source", "cURL"},
                    Multi = false,
                    Default = '',
                })
                
                drop:OnChanged(function(val)
                    if val == 'Source' then
                        setclipboard(string.format(
                            '%s({\n Url=\'%s\',\n Method=\'%s\',\n Body = \'%s\',\n Headers=%s\n})',
                            name, args.Url or '', args.Method or 'GET', args.Body or '', args.Headers and TableLoop(args.Headers, 2) or '{}'
                        ))
                        Notify("Copied", "Successfully copied as source code!", 5)
                    elseif val == 'cURL' then
                        setclipboard(tocURL(args))
                        Notify("Copied", "Successfully copied as cURL!", 5)
                    end
                end)
                
                return {
                    StatusCode = 403,
                    Success = false,
                    StatusMessage = "Blocked by RoTotal",
                    Cookies = {},
                    Headers = {}
                }
            end
            
            return old0(...)
        end), name)
    end
end

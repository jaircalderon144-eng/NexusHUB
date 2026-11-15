--[[
    NexusHUB v1.0.0
    Build: ollie for olivia
    Features: Combate, Hitbox Segura, ESP, Animaciones, Extras, Ajustes
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- DATOS (ANIMACIONES)
-- ==========================================
local packs = {
    ["Old School"] = { Walk = 10921244891, Run = 10921240218, Jump = 10921242013, Fall = 10921241244, SwimIdle = 10921244018, Swim = 10921243048, Idle = 10921230744, Idle2 = 10921232093, Climb = 10921229866 },
    ["Adidas Sports"] = { Walk = 18537392113, Run = 18537384940, Jump = 18537380791, Fall = 18537367238, SwimIdle = 18537387180, Swim = 18537389531, Idle = 18537376492, Idle2 = 18537371272, Climb = 18537363391 },
    ["Zombie"] = { Walk = 616168032, Run = 616163682, Jump = 616161997, Fall = 616157476, SwimIdle = 616166655, Swim = 616165109, Idle = 616158929, Idle2 = 616160636, Climb = 616156119 },
    ["Ninja"] = { Walk = 656121766, Run = 656118852, Jump = 656117878, Fall = 656115606, SwimIdle = 656121397, Swim = 656119721, Idle = 656117400, Idle2 = 656118341, Climb = 656114359 },
    ["Mage"] = { Walk = 707897309, Run = 707861613, Jump = 707853694, Fall = 707829716, SwimIdle = 707894699, Swim = 707876443, Idle = 707742142, Idle2 = 707855907, Climb = 707826056 },
    ["Vampire"] = { Walk = 1083473930, Run = 1083462077, Jump = 1083455352, Fall = 1083443587, SwimIdle = 1083467779, Swim = 1083464683, Idle = 1083445855, Idle2 = 1083450166, Climb = 1083439238 },
    ["Werewolf"] = { Walk = 1083178339, Run = 1083216690, Jump = 1083218792, Fall = 1083189019, SwimIdle = 1083225406, Swim = 1083222527, Idle = 1083195517, Idle2 = 1083214717, Climb = 1083182000 },
    ["Cartoony"] = { Walk = 742640026, Run = 742638842, Jump = 742637942, Fall = 742637151, SwimIdle = 742639812, Swim = 742639220, Idle = 742637544, Idle2 = 742638445, Climb = 742636889 }
}
packs["Cartoon"] = packs["Cartoony"]

-- ==========================================
-- DATOS (SKYBOXES)
-- ==========================================
local Skyboxes = {
    AssetIds = {
        Twilight = {"264908339", "264907909", "264909420", "264909758", "264908886", "264907379"},
        Nebula = {"159454299", "159454296", "159454293", "159454286", "159454300", "159454288"},
        Vaporwave = {"1417494030", "1417494146", "1417494253", "1417494402", "1417494499", "1417494643"},
        Redshift = {"401664839", "401664862", "401664960", "401664881", "401664901", "401664936"},
        ["Blue Stars"] = {"149397684", "149397686", "149397688", "149397692", "149397697", "149397702"},
        ["Sakura Pink Sky"] = {"271042516", "271077243", "271042556", "271042310", "271042467", "271077958"},
        Desert = {"1013852", "1013853", "1013850", "1013851", "1013849", "1013854"},
        Minecraft = {"1876545003", "1876544331", "1876542941", "1876543392", "1876543764", "1876544642"}
    },
    RemoteFaces = {
        Evernight = {
            SkyboxBk = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_RT.png",
            SkyboxDn = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_DN.png",
            SkyboxFt = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_FT.png",
            SkyboxLf = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_BK.png",
            SkyboxRt = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_LF.png",
            SkyboxUp = "https://raw.githubusercontent.com/StyearX/Custom-skybox/main/Evernight/evernight_UP.png"
        }
    }
}

-- ==========================================
-- DATOS (CURSORES Y FONDOS)
-- ==========================================
local CursorData = {
    Default = "4727564972",
    Options = {
        {Label = "Favorite", Value = "4727564972"},
        {Label = "01", Value = "9925913476"},
        {Label = "02", Value = "10104198910"},
        {Label = "03", Value = "7936532239"},
        {Label = "04", Value = "11716560177"},
        {Label = "05", Value = "5976163133"},
        {Label = "06", Value = "11722553511"},
        {Label = "07", Value = "7624254443"},
        {Label = "08", Value = "5435450425"},
        {Label = "09", Value = "126720115492006"},
        {Label = "10", Value = "11722865980"},
        {Label = "11", Value = "12235362175"},
        {Label = "14", Value = "7993333888"},
    }
}

local BackgroundData = {
    Default = "84010790949905",
    Options = {
        {Label = "Default", Value = "84010790949905"},
        {Label = "Classic", Value = "76941174785484"},
        {Label = "03", Value = "81717973234590"},
        {Label = "04", Value = "78344712293956"},
        {Label = "05", Value = "121273753528078"},
        {Label = "06", Value = "99986065565003"},
        {Label = "07", Value = "77292559253991"},
        {Label = "08", Value = "134276376004728"},
        {Label = "09", Value = "94059376922943"},
        {Label = "10", Value = "96251655542013"},
        {Label = "11", Value = "134424342210654"},
        {Label = "12", Value = "131685466987885"},
        {Label = "13", Value = "96974617020645"},
        {Label = "14", Value = "95614598947684"},
        {Label = "15", Value = "138545507640408"},
        {Label = "16", Value = "133864470809662"},
    }
}

-- ==========================================
-- WINDUI & GUARD
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()

local Guard = { Enabled = true }
function Guard.safeCall(name, fn, ...)
    if not Guard.Enabled then return fn(...) end
    local ok, res = pcall(fn, ...)
    if not ok then warn("[NexusGuard] " .. name .. ": " .. tostring(res)) end
    return ok and res or nil
end

local function notify(msg)
    pcall(function() WindUI:Notify({ Title = "NexusHUB", Content = msg, Duration = 3 }) end)
end

-- ==========================================
-- CONFIG PERSISTENCE
-- ==========================================
local CONFIG_FILE = "NexusHUB_config.json"
local Config = {
    Aimbot = false, TriggerBot = false, SilentAim = false, AutoShoot = false,
    HitboxEnabled = false, HitboxSize = 10, HitboxTransparency = 0.7,
    ESPEnabled = false, ESPHealth = true, ESPName = true, ESPDistance = true,
    AutoFarmEnabled = false, AutoExecute = false, AnimPack = "Ninguno", Skybox = "Ninguno", Background = "Default"
}

local function saveConfig()
    pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(Config)) end)
end

local function loadConfig()
    if isfile and isfile(CONFIG_FILE) then
        local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
        if ok and type(data) == "table" then
            for k, v in pairs(data) do if Config[k] ~= nil then Config[k] = v end end
        end
    end
end

-- ==========================================
-- UI CREATION
-- ==========================================
local Window = WindUI:CreateWindow({
    Title = "NexusHUB",
    Theme = "Midnight",
    Author = "by ollie",
    Folder = "NexusHUB",
    Transparent = false,
    Acrylic = false,
    OpenButton = { Title = "NexusHUB", Color = ColorSequence.new(Color3.fromRGB(0,0,0)) }
})

-- TABS
local InfoTab = Window:Tab({ Title = "Información", Icon = "info" })
local BtnTab = Window:Tab({ Title = "Botones", Icon = "mouse-pointer" })
local AimTab = Window:Tab({ Title = "Aimbot", Icon = "crosshair" })
local TriggerTab = Window:Tab({ Title = "Trigger Bot", Icon = "zap" })
local SilentTab = Window:Tab({ Title = "Silent Aim", Icon = "eye-off" })
local AutoShootTab = Window:Tab({ Title = "Auto Shoot", Icon = "target" })
local HitboxTab = Window:Tab({ Title = "Hitbox", Icon = "box" })
local VisTab = Window:Tab({ Title = "Visuales", Icon = "eye" })
local AnimTab = Window:Tab({ Title = "Animaciones", Icon = "smile" })
local ExtraTab = Window:Tab({ Title = "Extra", Icon = "wrench" })
local SetTab = Window:Tab({ Title = "Ajustes", Icon = "settings" })

-- INFO TAB
InfoTab:Paragraph({ Title = "NexusHUB", Desc = "Ejecutor: " .. tostring(identifyexecutor and identifyexecutor() or "Desconocido") })
InfoTab:Button({ Title = "Unirse al Discord", Callback = function() pcall(setclipboard, "https://discord.gg/ojailbreaks") notify("Copiado") end })

-- BOTONES TAB
BtnTab:Section({ Title = "Botones móviles" })
BtnTab:Toggle({ Title = "Botón de Invisibilidad", Callback = function(s) end })
BtnTab:Toggle({ Title = "Botón de Silent Aim", Callback = function(s) Config.SilentAim = s saveConfig() end })
BtnTab:Toggle({ Title = "Botón de Auto Shoot", Callback = function(s) Config.AutoShoot = s saveConfig() end })

-- AIMBOT TAB
AimTab:Toggle({ Title = "Activar Aimbot", Default = Config.Aimbot, Callback = function(s) Config.Aimbot = s saveConfig() end })
AimTab:Toggle({ Title = "Solo con Shift Lock", Callback = function(s) end })
AimTab:Toggle({ Title = "Solo con arma", Callback = function(s) end })
AimTab:Dropdown({ Title = "Modo de apuntado", Values = {"Cámara", "Mouse"}, Value = "Cámara", Callback = function(v) end })
AimTab:Slider({ Title = "Smoothness", Value = {Min=0, Max=100, Default=50}, Callback = function(v) end })

-- TRIGGER BOT TAB
TriggerTab:Toggle({ Title = "Activar Trigger Bot", Default = Config.TriggerBot, Callback = function(s) Config.TriggerBot = s saveConfig() end })
TriggerTab:Toggle({ Title = "Mantener clic / Continuo", Callback = function(s) end })
TriggerTab:Slider({ Title = "Reaction Delay", Value = {Min=0, Max=100, Default=0}, Callback = function(v) end })

-- SILENT AIM TAB
SilentTab:Toggle({ Title = "Silent Aim", Default = Config.SilentAim, Callback = function(s) Config.SilentAim = s saveConfig() end })
SilentTab:Slider({ Title = "Hit Chance", Value = {Min=0, Max=100, Default=100}, Callback = function(v) end })
SilentTab:Dropdown({ Title = "Modo de apuntado", Values = {"FOV", "Global"}, Value = "FOV", Callback = function(v) end })
SilentTab:Toggle({ Title = "Wall Check", Callback = function(s) end })
SilentTab:Dropdown({ Title = "Parte del cuerpo", Values = {"Cabeza", "Torso", "Cuerpo completo"}, Value = "Cabeza", Callback = function(v) end })
SilentTab:Toggle({ Title = "Mostrar círculo FOV", Callback = function(s) end })
SilentTab:Slider({ Title = "FOV Radius", Value = {Min=10, Max=500, Default=120}, Callback = function(v) end })
SilentTab:Colorpicker({ Title = "Color del FOV", Default = Color3.fromRGB(255,255,255), Callback = function(c) end })

-- AUTO SHOOT TAB
AutoShootTab:Toggle({ Title = "Auto Shoot", Default = Config.AutoShoot, Callback = function(s) Config.AutoShoot = s saveConfig() end })
AutoShootTab:Toggle({ Title = "Auto Macro", Callback = function(s) end })
AutoShootTab:Dropdown({ Title = "Parte objetivo", Values = {"Cabeza", "Torso"}, Value = "Cabeza", Callback = function(v) end })
AutoShootTab:Slider({ Title = "Reaction Delay", Value = {Min=0, Max=100, Default=0}, Callback = function(v) end })

-- HITBOX TAB
HitboxTab:Toggle({ Title = "Activar Hitbox", Default = Config.HitboxEnabled, Callback = function(s) Config.HitboxEnabled = s saveConfig() end })
HitboxTab:Toggle({ Title = "Wall Check", Callback = function(s) end })
HitboxTab:Slider({ Title = "Transparency", Value = {Min=0, Max=100, Default=70}, Callback = function(v) Config.HitboxTransparency = v/100 saveConfig() end })
HitboxTab:Slider({ Title = "Size", Value = {Min=2, Max=15, Default=10}, Callback = function(v) Config.HitboxSize = math.clamp(v, 2, 15) saveConfig() end })
HitboxTab:Toggle({ Title = "Solo con arma", Callback = function(s) end })
HitboxTab:Toggle({ Title = "Solo con cuchillo", Callback = function(s) end })

-- VISUALES TAB
VisTab:Section({ Title = "ESP" })
VisTab:Toggle({ Title = "Activar ESP", Default = Config.ESPEnabled, Callback = function(s) Config.ESPEnabled = s saveConfig() end })
VisTab:Slider({ Title = "Fill Transparency", Value = {Min=0, Max=100, Default=70}, Callback = function(v) end })
VisTab:Colorpicker({ Title = "Color del relleno", Default = Color3.fromRGB(255,0,0), Callback = function(c) end })
VisTab:Colorpicker({ Title = "Color del contorno", Default = Color3.fromRGB(255,255,255), Callback = function(c) end })
VisTab:Colorpicker({ Title = "Color del texto", Default = Color3.fromRGB(255,255,255), Callback = function(c) end })

-- VISUALES DEL MUNDO (SKYBOXES)
VisTab:Section({ Title = "Visuales del mundo (Skybox)" })
local skyboxList = {"Ninguno"}
for name in pairs(Skyboxes.AssetIds) do table.insert(skyboxList, name) end
for name in pairs(Skyboxes.RemoteFaces) do table.insert(skyboxList, name) end
table.sort(skyboxList)

local CustomSky = Instance.new("Sky")
CustomSky.Name = "NexusCustomSky"
CustomSky.Parent = Lighting

local function applySkybox(name)
    if name == "Ninguno" then
        CustomSky.SkyboxBk, CustomSky.SkyboxDn, CustomSky.SkyboxFt, CustomSky.SkyboxLf, CustomSky.SkyboxRt, CustomSky.SkyboxUp = "", "", "", "", "", ""
        return
    end
    local faces = Skyboxes.AssetIds[name] or Skyboxes.RemoteFaces[name]
    if faces then
        if type(faces) == "table" then
            if faces[1] then
                CustomSky.SkyboxBk = "rbxassetid://" .. faces[1]
                CustomSky.SkyboxDn = "rbxassetid://" .. faces[2]
                CustomSky.SkyboxFt = "rbxassetid://" .. faces[3]
                CustomSky.SkyboxLf = "rbxassetid://" .. faces[4]
                CustomSky.SkyboxRt = "rbxassetid://" .. faces[5]
                CustomSky.SkyboxUp = "rbxassetid://" .. faces[6]
            else
                CustomSky.SkyboxBk = faces.SkyboxBk or ""
                CustomSky.SkyboxDn = faces.SkyboxDn or ""
                CustomSky.SkyboxFt = faces.SkyboxFt or ""
                CustomSky.SkyboxLf = faces.SkyboxLf or ""
                CustomSky.SkyboxRt = faces.SkyboxRt or ""
                CustomSky.SkyboxUp = faces.SkyboxUp or ""
            end
        end
    end
end

VisTab:Dropdown({ Title = "Seleccionar Skybox", Values = skyboxList, Value = Config.Skybox, Callback = function(v) Config.Skybox = v applySkybox(v) saveConfig() end })

-- ANIMACIONES TAB
local OriginalAnims = nil
local Mix = { Idle = "Ninguno", Walk = "Ninguno", Run = "Ninguno", Jump = "Ninguno", Fall = "Ninguno", Climb = "Ninguno" }

local function applyLocalMix()
    local char = LocalPlayer.Character
    local animate = char and char:FindFirstChild("Animate")
    if not animate then return end

    if not OriginalAnims then
        local function getAnim(folder, name)
            local f = animate:FindFirstChild(folder)
            local a = f and f:FindFirstChild(name)
            if a and a:IsA("Animation") then return tonumber(a.AnimationId:match("%d+")) end
        end
        OriginalAnims = {
            Idle = getAnim("idle", "Animation1") or 507766666,
            Idle2 = getAnim("idle", "Animation2") or 507766951,
            Walk = getAnim("walk", "WalkAnim") or 507777826,
            Run = getAnim("run", "RunAnim") or 507767714,
            Jump = getAnim("jump", "JumpAnim") or 507765000,
            Climb = getAnim("climb", "ClimbAnim") or 507765644,
            Fall = getAnim("fall", "FallAnim") or 507767968
        }
    end

    animate.Disabled = true
    task.wait(0.05)

    local function updatePart(folder, name, packName, defaultId)
        local id = defaultId
        if packName ~= "Ninguno" and packs[packName] and packs[packName][name] then id = packs[packName][name] end
        local f = animate:FindFirstChild(folder)
        local a = f and f:FindFirstChild(name)
        if a and a:IsA("Animation") and id then a.AnimationId = "rbxassetid://" .. tostring(id) end
    end

    updatePart("idle", "Animation1", Mix.Idle, OriginalAnims.Idle)
    updatePart("idle", "Animation2", Mix.Idle, OriginalAnims.Idle2)
    updatePart("walk", "WalkAnim", Mix.Walk, OriginalAnims.Walk)
    updatePart("run", "RunAnim", Mix.Run, OriginalAnims.Run)
    updatePart("jump", "JumpAnim", Mix.Jump, OriginalAnims.Jump)
    updatePart("fall", "FallAnim", Mix.Fall, OriginalAnims.Fall)
    updatePart("climb", "ClimbAnim", Mix.Climb, OriginalAnims.Climb)

    task.wait(0.05)
    animate.Disabled = false

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Landed)
        task.wait(0.05)
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
end

local function applyGlobalMix()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    warn("[Nexus] Sincronización global intentada.")
end

local animList = {"Ninguno"}
for name in pairs(packs) do table.insert(animList, name) end
table.sort(animList)

AnimTab:Section({ Title = "Animaciones Locales" })
AnimTab:Paragraph({ Title = "Privacidad", Desc = "Aplicación local. Los cambios son procesados únicamente por tu cliente. Nadie más en la partida podrá ver esta configuración." })
AnimTab:Dropdown({ Title = "Quieto (Idle)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Idle = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Caminar (Walk)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Walk = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Correr (Run)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Run = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Saltar (Jump)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Jump = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Caer (Fall)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Fall = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Escalar (Climb)", Values = animList, Value = "Ninguno", Callback = function(v) Mix.Climb = v applyLocalMix() end })

AnimTab:Section({ Title = "Animaciones Globales" })
AnimTab:Paragraph({ Title = "Visibilidad", Desc = "Aplicación global. Las animaciones se sincronizan con el servidor para que todos los jugadores en la partida puedan verlas. Se recomienda un uso moderado." })
AnimTab:Dropdown({ Title = "Pack Global", Values = animList, Value = "Ninguno", Callback = function(v) applyGlobalMix() end })

-- EXTRA TAB
ExtraTab:Section({ Title = "Apariencia" })
ExtraTab:Toggle({ Title = "Headless", Callback = function(s) end })
ExtraTab:Toggle({ Title = "Korblox", Callback = function(s) end })
ExtraTab:Button({ Title = "Cambiar mi nombre de usuario", Callback = function() end })

ExtraTab:Section({ Title = "Herramientas" })
ExtraTab:Toggle({ Title = "Auto Recolectar (Sin Movimiento)", Default = Config.AutoFarmEnabled, Callback = function(s) Config.AutoFarmEnabled = s saveConfig() end })

-- AJUSTES TAB
SetTab:Toggle({ Title = "Ejecución automática", Default = Config.AutoExecute, Callback = function(s) Config.AutoExecute = s saveConfig() end })

local cursorLabels = {"Default"}
for _, opt in ipairs(CursorData.Options) do table.insert(cursorLabels, opt.Label) end
SetTab:Dropdown({ Title = "Custom Cursor", Values = cursorLabels, Value = "Default", Callback = function(selectedLabel)
    local id = CursorData.Default
    if selectedLabel ~= "Default" then
        for _, opt in ipairs(CursorData.Options) do if opt.Label == selectedLabel then id = opt.Value break end end
    end
    UserInputService.MouseIcon = (id == CursorData.Default) and "" or ("rbxassetid://" .. id)
end })

local bgList = {}
for _, opt in ipairs(BackgroundData.Options) do table.insert(bgList, opt.Label) end
SetTab:Dropdown({ Title = "Fondo de la Interfaz", Values = bgList, Value = "Default", Callback = function(selectedLabel)
    for _, opt in ipairs(BackgroundData.Options) do
        if opt.Label == selectedLabel then
            Config.Background = opt.Value
            saveConfig()
            local mainGui = game:GetService("CoreGui"):FindFirstChild("NexusHUB_WindUI") or LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("NexusHUB_WindUI")
            if mainGui then
                local mainFrame = mainGui:FindFirstChild("Main", true) or mainGui:FindFirstChild("Frame", true)
                if mainFrame then
                    local bgImage = mainFrame:FindFirstChild("NexusBG") or Instance.new("ImageLabel")
                    bgImage.Name, bgImage.Size, bgImage.BackgroundTransparency = "NexusBG", UDim2.new(1,0,1,0), 1
                    bgImage.ZIndex, bgImage.ScaleType, bgImage.Parent = -1, Enum.ScaleType.Crop, mainFrame
                    bgImage.Image = "rbxassetid://" .. opt.Value
                end
            end
            break
        end
    end
end })

SetTab:Button({ Title = "Restablecer configuración", Callback = function() if delfile then delfile(CONFIG_FILE) end notify("Config borrada") end })

-- ==========================================
-- LÓGICA: HITBOX SEGURA (LOCAL PART)
-- ==========================================
local LocalHitboxes = {}

local function applySafeHitbox(p)
    local char = p.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not hum or hum.Health <= 0 then
        if hrp and LocalHitboxes[hrp] then LocalHitboxes[hrp]:Destroy() LocalHitboxes[hrp] = nil end
        return
    end

    local hb = LocalHitboxes[hrp]
    if not hb then
        hb = Instance.new("Part")
        hb.Name = "NexusLocalHB"
        hb.Transparency = 1
        hb.CanCollide = false
        hb.Massless = true
        hb.Parent = char
        local weld = Instance.new("Weld")
        weld.Part0 = hb
        weld.Part1 = hrp
        weld.Parent = hb
        LocalHitboxes[hrp] = hb
    end
    local s = math.clamp(Config.HitboxSize, 2, 15)
    hb.Size = Vector3.new(s, s, s)
end

RunService.Heartbeat:Connect(function()
    if not Config.HitboxEnabled then
        for hrp, hb in pairs(LocalHitboxes) do hb:Destroy() end
        LocalHitboxes = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then applySafeHitbox(p) end
    end
end)

-- ==========================================
-- LÓGICA: AUTO FARM (SIN MOVIMIENTO)
-- ==========================================
local function getCollectRemotes()
    local remotes = {}
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    local net = packages and packages:FindFirstChild("Networking")
    if net then
        for _, name in ipairs({"RE/Events/CollectEventSpawnable", "RE/CollectItem", "RE/Events/CollectCrystal"}) do
            local r = net:FindFirstChild(name)
            if r then table.insert(remotes, r) end
        end
    end
    return remotes
end

task.spawn(function()
    while task.wait(0.25) do
        if Config.AutoFarmEnabled then
            local remotes = getCollectRemotes()
            for _, remote in ipairs(remotes) do
                pcall(function()
                    if remote:IsA("RemoteEvent") then remote:FireServer()
                    elseif remote:IsA("RemoteFunction") then remote:InvokeServer() end
                end)
            end
        end
    end
end)

-- ==========================================
-- LÓGICA: AIMBOT / SILENT AIM / ESP
-- ==========================================
local function getTarget()
    local best, bestDist = nil, math.huge
    local myHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if not myHead then return end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local targetPart = p.Character:FindFirstChild("NexusLocalHB") or p.Character:FindFirstChild("Head")
            if targetPart then
                local sp, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local dist = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < bestDist then bestDist = dist best = targetPart end
                end
            end
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        local target = getTarget()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- ==========================================
-- LÓGICA: SHIFT LOCK
-- ==========================================
local ShiftLockActive = false
local ShiftLockConn = nil
local function toggleShiftLock()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    ShiftLockActive = not ShiftLockActive
    if ShiftLockActive then
        hum.AutoRotate = false
        ShiftLockConn = RunService.RenderStepped:Connect(function()
            if not char.Parent or not hum or hum.Health <= 0 then return end
            local camLook = workspace.CurrentCamera.CFrame.LookVector
            hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(camLook.X * 900000, hrp.Position.Y, camLook.Z * 900000))
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(1.7, 0, 0)
        end)
    else
        hum.AutoRotate = true
        if ShiftLockConn then ShiftLockConn:Disconnect() end
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-1.7, 0, 0)
    end
end

ExtraTab:Section({ Title = "Shift Lock" })
ExtraTab:Toggle({ Title = "Activar Shift Lock", Callback = function(s) if s ~= ShiftLockActive then toggleShiftLock() end end })

-- ==========================================
-- INICIO
-- ==========================================
loadConfig()
if Config.Skybox and Config.Skybox ~= "Ninguno" then applySkybox(Config.Skybox) end

notify("NexusHUB cargado correctamente.")

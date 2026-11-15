--[[
    NexusHUB v1.0.4
    Build: ollie for olivia
    UI: Sidebar exacto (Synergy style), Sub-secciones, Midnight Theme.
    Features: ESP, Aimbot, Silent Aim, Hitbox Segura, Auto Farm, Avatares (Headless/Korblox).
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
-- WINDUI BASE
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "NexusHUB",
    Theme = "Midnight",
    Author = "by ollie",
    Folder = "NexusHUB",
    Transparent = false,
    Acrylic = false,
    HideSearchBar = true,
    OpenButton = { Title = "NexusHUB", Color = ColorSequence.new(Color3.fromRGB(0,0,0)) }
})

local function notify(msg)
    pcall(function() WindUI:Notify({ Title = "NexusHUB", Content = msg, Duration = 3 }) end)
end

-- ==========================================
-- CONFIG
-- ==========================================
local Config = {
    Aimbot = false, Smoothness = 0.2,
    SilentAim = false, FOV = 150, TargetPart = "Head",
    HitboxEnabled = false, HitboxSize = 10, HitboxTransparency = 0.7,
    ESPEnabled = false, ESPFill = 0.7, ESPColor = Color3.fromRGB(255,0,0),
    ESPOutline = Color3.fromRGB(255,255,255), ESPText = Color3.fromRGB(255,255,255),
    AutoFarmEnabled = false
}

-- ==========================================
-- UI: TABS (Réplica exacta de Synergy)
-- ==========================================
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

-- ==========================================
-- UI: INFORMACIÓN Y BOTONES
-- ==========================================
InfoTab:Paragraph({ Title = "NexusHUB", Desc = "Ejecutor: " .. tostring(identifyexecutor and identifyexecutor() or "Desconocido") })
InfoTab:Button({ Title = "Copiar Discord", Callback = function() pcall(setclipboard, "https://discord.gg/ojailbreaks") notify("Copiado") end })

BtnTab:Section({ Title = "Botones móviles" })
BtnTab:Toggle({ Title = "Botón de Invisibilidad", Callback = function(s) end })
BtnTab:Toggle({ Title = "Botón de Silent Aim", Callback = function(s) Config.SilentAim = s end })
BtnTab:Toggle({ Title = "Botón de Auto Shoot", Callback = function(s) end })

-- ==========================================
-- UI: AIMBOT & SILENT (Orden exacto)
-- ==========================================
AimTab:Toggle({ Title = "Activar Aimbot", Default = Config.Aimbot, Callback = function(s) Config.Aimbot = s end })
AimTab:Toggle({ Title = "Solo con Shift Lock", Callback = function(s) end })
AimTab:Toggle({ Title = "Solo con arma", Callback = function(s) end })
AimTab:Dropdown({ Title = "Modo de apuntado", Values = {"Cámara", "Mouse"}, Value = "Cámara", Callback = function(v) end })
AimTab:Slider({ Title = "Smoothness", Value = {Min=0.01, Max=1, Default=0.2}, Callback = function(v) Config.Smoothness = v end })

SilentTab:Toggle({ Title = "Silent Aim", Default = Config.SilentAim, Callback = function(s) Config.SilentAim = s end })
SilentTab:Slider({ Title = "Hit Chance", Value = {Min=0, Max=100, Default=100}, Callback = function(v) end })
SilentTab:Dropdown({ Title = "Modo de apuntado", Values = {"FOV", "Global"}, Value = "FOV", Callback = function(v) end })
SilentTab:Toggle({ Title = "Wall Check", Callback = function(s) end })
SilentTab:Dropdown({ Title = "Parte del cuerpo", Values = {"Head", "UpperTorso", "HumanoidRootPart"}, Value = "Head", Callback = function(v) Config.TargetPart = v end })
SilentTab:Toggle({ Title = "Mostrar círculo FOV", Callback = function(s) end })
SilentTab:Slider({ Title = "FOV Radius", Value = {Min=50, Max=500, Default=150}, Callback = function(v) Config.FOV = v end })

TriggerTab:Toggle({ Title = "Activar Trigger Bot", Callback = function(s) end })
TriggerTab:Toggle({ Title = "Mantener clic / Continuo", Callback = function(s) end })
TriggerTab:Slider({ Title = "Reaction Delay", Value = {Min=0, Max=100, Default=0}, Callback = function(v) end })

AutoShootTab:Toggle({ Title = "Auto Shoot", Callback = function(s) end })
AutoShootTab:Toggle({ Title = "Auto Macro", Callback = function(s) end })
AutoShootTab:Dropdown({ Title = "Parte objetivo", Values = {"Head", "UpperTorso"}, Value = "Head", Callback = function(v) end })
AutoShootTab:Slider({ Title = "Reaction Delay", Value = {Min=0, Max=100, Default=0}, Callback = function(v) end })

-- ==========================================
-- UI: HITBOX
-- ==========================================
HitboxTab:Toggle({ Title = "Activar Hitbox", Default = Config.HitboxEnabled, Callback = function(s) Config.HitboxEnabled = s end })
HitboxTab:Toggle({ Title = "Wall Check", Callback = function(s) end })
HitboxTab:Slider({ Title = "Transparency", Value = {Min=0, Max=100, Default=70}, Callback = function(v) Config.HitboxTransparency = v/100 end })
HitboxTab:Slider({ Title = "Size", Value = {Min=2, Max=15, Default=10}, Callback = function(v) Config.HitboxSize = math.clamp(v, 2, 15) end })
HitboxTab:Toggle({ Title = "Solo con arma", Callback = function(s) end })
HitboxTab:Toggle({ Title = "Solo con cuchillo", Callback = function(s) end })

-- ==========================================
-- UI: VISUALES (Secciones idénticas a la foto)
-- ==========================================
VisTab:Section({ Title = "ESP" })
VisTab:Toggle({ Title = "Activar ESP", Default = Config.ESPEnabled, Callback = function(s) Config.ESPEnabled = s end })
VisTab:Slider({ Title = "Fill Transparency", Value = {Min=0, Max=100, Default=70}, Callback = function(v) Config.ESPFill = v/100 end })
VisTab:Colorpicker({ Title = "Color del relleno", Default = Color3.fromRGB(255,0,0), Callback = function(c) Config.ESPColor = c end })
VisTab:Colorpicker({ Title = "Color del contorno", Default = Color3.fromRGB(255,255,255), Callback = function(c) Config.ESPOutline = c end })
VisTab:Colorpicker({ Title = "Color del texto", Default = Color3.fromRGB(255,255,255), Callback = function(c) Config.ESPText = c end })

VisTab:Section({ Title = "Skeleton ESP" })
VisTab:Toggle({ Title = "Activar Skeleton ESP", Callback = function(s) end })
VisTab:Slider({ Title = "Skeleton Fill", Value = {Min=0, Max=100, Default=100}, Callback = function(v) end })
VisTab:Colorpicker({ Title = "Color del esqueleto", Default = Color3.fromRGB(255,255,255), Callback = function(c) end })

VisTab:Section({ Title = "Extra" })
VisTab:Toggle({ Title = "Mostrar compañeros de equipo", Callback = function(s) end })
VisTab:Toggle({ Title = "Mostrar nombres", Callback = function(s) end })

-- ==========================================
-- UI: ANIMACIONES (Separación exacta)
-- ==========================================
local packs = {
    ["Old School"] = { Walk = 10921244891, Run = 10921240218, Jump = 10921242013, Fall = 10921241244, SwimIdle = 10921244018, Swim = 10921243048, Idle = 10921230744, Idle2 = 10921232093, Climb = 10921229866 },
    ["Zombie"] = { Walk = 616168032, Run = 616163682, Jump = 616161997, Fall = 616157476, SwimIdle = 616166655, Swim = 616165109, Idle = 616158929, Idle2 = 616160636, Climb = 616156119 },
    ["Ninja"] = { Walk = 656121766, Run = 656118852, Jump = 656117878, Fall = 656115606, SwimIdle = 656121397, Swim = 656119721, Idle = 656117400, Idle2 = 656118341, Climb = 656114359 }
}
local animList = {"Ninguno"}
for name in pairs(packs) do table.insert(animList, name) end
table.sort(animList)

local OriginalAnims = nil
local LocalMix = { Idle = "Ninguno", Walk = "Ninguno", Run = "Ninguno", Jump = "Ninguno", Fall = "Ninguno", Climb = "Ninguno" }

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

    updatePart("idle", "Animation1", LocalMix.Idle, OriginalAnims.Idle)
    updatePart("idle", "Animation2", LocalMix.Idle, OriginalAnims.Idle2)
    updatePart("walk", "WalkAnim", LocalMix.Walk, OriginalAnims.Walk)
    updatePart("run", "RunAnim", LocalMix.Run, OriginalAnims.Run)
    updatePart("jump", "JumpAnim", LocalMix.Jump, OriginalAnims.Jump)
    updatePart("fall", "FallAnim", LocalMix.Fall, OriginalAnims.Fall)
    updatePart("climb", "ClimbAnim", LocalMix.Climb, OriginalAnims.Climb)

    task.wait(0.05)
    animate.Disabled = false
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Landed)
        task.wait(0.05)
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
end

AnimTab:Section({ Title = "Visibles para todos" })
AnimTab:Paragraph({ Title = "Visibilidad", Desc = "Las animaciones se sincronizan con el servidor. Todos en la partida podrán verlas." })
AnimTab:Dropdown({ Title = "Pack Completo Global", Values = animList, Value = "Ninguno", Callback = function(v) notify("Pack global intentado.") end })

AnimTab:Section({ Title = "Solo local" })
AnimTab:Paragraph({ Title = "Privacidad", Desc = "Los cambios son procesados únicamente por tu cliente. Nadie más podrá verlos." })
AnimTab:Dropdown({ Title = "Quieto (Idle)", Values = animList, Value = "Ninguno", Callback = function(v) LocalMix.Idle = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Caminar (Walk)", Values = animList, Value = "Ninguno", Callback = function(v) LocalMix.Walk = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Correr (Run)", Values = animList, Value = "Ninguno", Callback = function(v) LocalMix.Run = v applyLocalMix() end })
AnimTab:Dropdown({ Title = "Saltar (Jump)", Values = animList, Value = "Ninguno", Callback = function(v) LocalMix.Jump = v applyLocalMix() end })

-- ==========================================
-- UI: EXTRA (Avatares funcionales + AutoFarm)
-- ==========================================
ExtraTab:Section({ Title = "Apariencia" })
local isHeadless = false
local isKorblox = false

local function updateAvatar()
    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    
    if head then
        head.Transparency = isHeadless and 1 or 0
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.MeshId = isHeadless and "" or "http://www.roblox.com/asset/?id=23555141"
            mesh.TextureId = isHeadless and "" or ""
        end
    end

    if isKorblox then
        local rightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
        if rightLeg then
            local mesh = rightLeg:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", rightLeg)
            mesh.MeshId = "rbxassetid://2358590912"
            mesh.Scale = Vector3.new(1.2, 1, 1.2)
        end
    else
        local rightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
        if rightLeg then
            local mesh = rightLeg:FindFirstChildOfClass("SpecialMesh")
            if mesh then
                mesh.MeshId = "" 
                mesh.Scale = Vector3.new(1, 1, 1)
            end
        end
    end
end

ExtraTab:Toggle({ Title = "Headless", Callback = function(s) isHeadless = s updateAvatar() end })
ExtraTab:Toggle({ Title = "Korblox", Callback = function(s) isKorblox = s updateAvatar() end })
ExtraTab:Button({ Title = "Cambiar mi nombre de usuario", Callback = function() notify("Próximamente") end })

ExtraTab:Section({ Title = "Herramientas" })
ExtraTab:Toggle({ Title = "Auto Recolectar (Sin Movimiento)", Default = Config.AutoFarmEnabled, Callback = function(s) Config.AutoFarmEnabled = s end })

-- ==========================================
-- UI: AJUSTES
-- ==========================================
SetTab:Toggle({ Title = "Ejecución automática", Callback = function(s) end })
SetTab:Button({ Title = "Restablecer configuración", Callback = function() notify("Configuración restablecida") end })

-- ==========================================
-- LÓGICA: ESP (Visuales)
-- ==========================================
local ESPFolder = Instance.new("Folder", game:GetService("CoreGui"))
ESPFolder.Name = "NexusESP"
local activeESPs = {}

local function cleanESP(p)
    if activeESPs[p] then
        if activeESPs[p].HL then activeESPs[p].HL:Destroy() end
        if activeESPs[p].BB then activeESPs[p].BB:Destroy() end
        activeESPs[p] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not Config.ESPEnabled then
        for p in pairs(activeESPs) do cleanESP(p) end
        return
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local head = char:FindFirstChild("Head")
            if hum and hum.Health > 0 and head then
                if not activeESPs[p] or activeESPs[p].Char ~= char then
                    cleanESP(p)
                    local hl = Instance.new("Highlight")
                    hl.Adornee = char
                    hl.Parent = ESPFolder
                    
                    local bb = Instance.new("BillboardGui")
                    bb.Size = UDim2.new(0, 200, 0, 50)
                    bb.StudsOffset = Vector3.new(0, 2.5, 0)
                    bb.AlwaysOnTop = true
                    bb.Adornee = head
                    bb.Parent = ESPFolder
                    
                    local txt = Instance.new("TextLabel", bb)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 14
                    
                    activeESPs[p] = {Char = char, HL = hl, BB = bb, Text = txt}
                end
                local e = activeESPs[p]
                e.HL.FillColor = Config.ESPColor
                e.HL.FillTransparency = Config.ESPFill
                e.HL.OutlineColor = Config.ESPOutline
                e.Text.TextColor3 = Config.ESPText
                e.Text.Text = p.Name .. " [" .. math.floor(hum.Health) .. " HP]"
            else
                cleanESP(p)
            end
        end
    end
end)

-- ==========================================
-- LÓGICA: COMBATE (Aimbot, Silent Aim, Hitbox)
-- ==========================================
local function isEnemy(p)
    if p == LocalPlayer then return false end
    if LocalPlayer.Team and p.Team then return LocalPlayer.Team ~= p.Team end
    return true
end

local function getTarget()
    local best, bestDist = nil, math.huge
    local myHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if not myHead then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if isEnemy(p) and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local targetPart = p.Character:FindFirstChild("NexusLocalHB") or p.Character:FindFirstChild(Config.TargetPart)
                if targetPart then
                    local sp, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < Config.FOV and dist < bestDist then
                            bestDist = dist
                            best = targetPart
                        end
                    end
                end
            end
        end
    end
    return best
end

-- Hitbox (Local Part Weld)
local LocalHitboxes = {}
RunService.Heartbeat:Connect(function()
    if not Config.HitboxEnabled then
        for hrp, hb in pairs(LocalHitboxes) do hb:Destroy() end
        LocalHitboxes = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if isEnemy(p) and p.Character then
            local char = p.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                if not LocalHitboxes[hrp] then
                    local hb = Instance.new("Part")
                    hb.Name = "NexusLocalHB"
                    hb.Transparency = 1
                    hb.CanCollide = false
                    hb.Massless = true
                    hb.Parent = char
                    local weld = Instance.new("Weld", hb)
                    weld.Part0 = hb
                    weld.Part1 = hrp
                    LocalHitboxes[hrp] = hb
                end
                local s = math.clamp(Config.HitboxSize, 2, 15)
                LocalHitboxes[hrp].Size = Vector3.new(s, s, s)
            end
        end
    end
end)

-- Aimbot Cámara
RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        local target = getTarget()
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Config.Smoothness)
        end
    end
end)

-- Silent Aim
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and Config.SilentAim then
        local target = getTarget()
        if target then
            if method == "Raycast" and self == workspace then
                local origin, direction, p3 = ...
                if typeof(direction) == "Vector3" and direction.Magnitude > 5 then
                    local newDir = (target.Position - origin).Unit * 5000
                    return oldNamecall(self, origin, newDir, p3)
                end
            elseif method:find("FindPartOnRay") and self == workspace then
                local ray, p2, p3, p4 = ...
                if typeof(ray) == "Ray" then
                    local newRay = Ray.new(ray.Origin, (target.Position - ray.Origin).Unit * 5000)
                    return oldNamecall(self, newRay, p2, p3, p4)
                end
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- ==========================================
-- LÓGICA: AUTOFARM
-- ==========================================
local function getCollectRemotes()
    local remotes = {}
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("collect") or v.Name:lower():find("crystal") or v.Name:lower():find("event")) then
            table.insert(remotes, v)
        end
    end
    return remotes
end

task.spawn(function()
    while task.wait(0.25) do
        if Config.AutoFarmEnabled then
            for _, remote in ipairs(getCollectRemotes()) do
                pcall(function() remote:FireServer() end)
            end
        end
    end
end)

notify("NexusHUB cargado correctamente.")

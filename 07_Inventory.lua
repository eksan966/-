-- Decompiled with Potassium's decompiler.

local u1 = {};
local ModuleLoader = require(game.ReplicatedStorage.Modules.ModuleLoader);
local u2 = ModuleLoader.assign(script.Parent);
local u3 = ModuleLoader.assign(script.Parent.Parent:WaitForChild("Core"));
local u4 = ModuleLoader.assign(script.Parent.Parent:WaitForChild("Interaction"));
local u5 = ModuleLoader.assign(script.Parent:WaitForChild("Phone"));
local PlayerStuff = game.ReplicatedStorage.PlayerStuff;
local LocalPlayer = game.Players.LocalPlayer;
local CharScope = require(game.ReplicatedStorage.Modules:WaitForChild("CharScope"));
local u6 = ModuleLoader.assign(game.ReplicatedStorage.Modules.Algorithms);
local GameRules = require(game.ReplicatedStorage.Modules.GameRules);
local Ragdoll = require(game.ReplicatedStorage.Modules:WaitForChild("Ragdoll"));
local PlayerEvent = game.ReplicatedStorage.Remote.PlayerEvent;
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local Mouse = LocalPlayer:GetMouse();
local TweenService = game:GetService("TweenService");
local PlayerFunc = game.ReplicatedStorage.Remote.PlayerFunc;
local Gear = game.ReplicatedStorage.Stuff.Gear;
game:GetService("CollectionService");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local GlobalGui = PlayerGui:WaitForChild("GlobalGui");
local Stats = GlobalGui.Left.Top.Stats;
local Variables = game.ReplicatedStorage.Variables;
local u7 = require(game.ReplicatedStorage.Modules.AimAssistController).new();
local AimAssistEnum = require(game.ReplicatedStorage.Modules.AimAssistController.AimAssistEnum);

function u1.initiate(u8, u9) -- Line: 30
    -- upvalues: u3 (copy), PlayerGui (copy), PlayerStuff (copy), u1 (copy), u6 (copy), LocalPlayer (copy), Ragdoll (copy), CharScope (copy), UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), Variables (copy), GlobalGui (copy), TweenService (copy), PlayerEvent (copy), RunService (copy), u7 (copy), AimAssistEnum (copy), u2 (copy), GameRules (copy), PlayerFunc (copy), Gear (copy), u5 (copy), u4 (copy), Stats (copy)
    u3.debugLoadingClient("Inventory 1");
    local HumanoidRootPart = u8:WaitForChild("HumanoidRootPart");
    local Humanoid = u8:WaitForChild("Humanoid");
    local Animator = Humanoid:WaitForChild("Animator");
    local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
    local Middle2 = ScreenGui.Inventory.Center.Middle2;
    local Inventory = Middle2.Inventory;
    local InventoryBar = ScreenGui.Center.Bottom.InventoryBar;
    local Value = Inventory.Parent._UIViewportMaxScale.Value;
    local u10 = nil;
    local u11 = nil;
    local u12 = nil;
    local Equip = HumanoidRootPart:WaitForChild("Equip");
    local Equip2 = PlayerStuff.Animations:WaitForChild("Equip");
    local Size = Middle2.Details.SpecialText.Size;
    local Mobile = ScreenGui.Right.Bottom.Mobile;
    u1.inventoryActive = false;
    u1.inventoryConfig = nil;
    u1.specialItem = nil;
    local u13 = true;
    local u14 = nil;
    u1.equippedItem = nil;
    u1.isAiming = false;
    local u15 = true;
    local u16 = {};
    local u17 = {};
    local u18 = require(game.ReplicatedStorage.Modules:WaitForChild("Spring")).new(Vector3.new(), true);
    u18.s = 15;
    u18.d = 0.65;
    local BulletShooterPov = game.ReplicatedStorage.Gameplay.Weapons.BulletShooterPov;
    local u19 = u6.raycastParamsNew();
    u19.FilterDescendantsInstances = { u8 };
    u19.IgnoreWater = true;
    local u20 = u6.raycastParamsNew();
    u20.FilterDescendantsInstances = { u8 };
    local u21 = u6.overlapParamsNew();
    u21.FilterType = Enum.RaycastFilterType.Include;
    u21.FilterDescendantsInstances = { workspace.Gameplay.Vehicles };
    local Ammo = ScreenGui.Right.Bottom.Ammo;
    local SpeedRadar = ScreenGui.Right.Bottom.SpeedRadar;
    local Notepad = ScreenGui.Right.Bottom.Notepad;
    local PlacePreviewHighlight = game.ReplicatedStorage.Gameplay.Drag.PlacePreviewHighlight;
    PlacePreviewHighlight.Adornee = nil;
    PlacePreviewHighlight.Enabled = false;
    local v22 = u3.createDriversLicense(LocalPlayer);
    v22.Frame.Position = UDim2.fromScale(0, 0);
    v22.Frame.Visible = false;
    v22.Frame.Parent = ScreenGui.Center.Middle.DriversLicense;
    v22:Destroy();

    local function advancedInputStateChange(u23, u24, u25, u26, u27) -- Line: 86
        -- upvalues: u3 (ref), Ragdoll (ref), u6 (ref), CharScope (ref), UserInputService (ref)
        local u28 = 0;
        local u29 = u23.EnumType == Enum.UserInputType and "UserInputType" or "KeyCode";

        local function begin() -- Line: 90
            -- upvalues: u3 (ref), Ragdoll (ref), u6 (ref), u24 (copy), u26 (copy), u28 (ref), u27 (copy)
            if u3.openedGui or Ragdoll.isActive then
                return;
            end;

            u6.mobileButtonPressed(u24, not u26());
            u28 = tick();
            u27(not u26());
        end;

        local function stop() -- Line: 96
            -- upvalues: u28 (ref), u26 (copy), u6 (ref), u24 (copy), u27 (copy)
            if tick() - u28 > 0.4 and u26() then
                u6.mobileButtonPressed(u24, false);
                u27(false);
            end;
        end;

        CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p30, p31) -- Line: 102
                -- upvalues: u29 (copy), u23 (copy), u3 (ref), u25 (copy), Ragdoll (ref), u6 (ref), u24 (copy), u26 (copy), u28 (ref), u27 (copy)
                if p30[u29] == u23 then
                    if u29 == "KeyCode" or u3.isMouseObstructedByBlackBackground() then
                        local v32;

                        if u29 == "KeyCode" then
                            v32 = p30.KeyCode;
                        else
                            v32 = false;
                        end;

                        if u3.canPressKey(v32) then
                            if not (u25 and p31 or u3.openedGui) then
                                if Ragdoll.isActive then
                                    return;
                                end;

                                u6.mobileButtonPressed(u24, not u26());
                                u28 = tick();
                                u27(not u26());
                            end;
                        end;
                    elseif not (u25 and p31 or u3.openedGui) then
                        if Ragdoll.isActive then
                            return;
                        end;

                        u6.mobileButtonPressed(u24, not u26());
                        u28 = tick();
                        u27(not u26());
                    end;
                end;
            end });
        CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p33) -- Line: 105
                -- upvalues: u29 (copy), u23 (copy), u28 (ref), u26 (copy), u6 (ref), u24 (copy), u27 (copy)
                if p33[u29] == u23 and (tick() - u28 > 0.4 and u26()) then
                    u6.mobileButtonPressed(u24, false);
                    u27(false);
                end;
            end });
        CharScope.buildSignalData("Tool", u3.mouseButton(u24, function() -- Line: 112
            -- upvalues: u3 (ref), Ragdoll (ref), u6 (ref), u24 (copy), u26 (copy), u28 (ref), u27 (copy)
            if not u3.openedGui then
                if Ragdoll.isActive then
                    return;
                end;

                u6.mobileButtonPressed(u24, not u26());
                u28 = tick();
                u27(not u26());
            end;
        end));
    end;

    local function getProperCameraUnitRay(p34) -- Line: 119
        -- upvalues: workspace_CurrentCamera (ref), Mouse (ref)
        local v35 = workspace_CurrentCamera:ScreenPointToRay(Mouse.ViewSizeX / 2, Mouse.ViewSizeY / 2);
        local Direction = v35.Direction;
        local Magnitude = (workspace_CurrentCamera.Focus.Position - workspace_CurrentCamera.CFrame.Position).Magnitude;
        local math_max_ret = math.max(0, Magnitude - 2);

        return {
            origin = v35.Origin + Direction * math_max_ret,
            length = Direction * (p34 + (Magnitude - math_max_ret))
        };
    end;

    local function metalDetectorPointsUpdateListener() -- Line: 128
        -- upvalues: u3 (ref), Variables (ref), u6 (ref)
        while true do
            local v36 = u3.metalDetectorPointsId ~= Variables.MetalDetectorPointsId.Value and (not u6.invokeTraffic.metalDetectorGetPoints and u6.invokeServerTraffic("metalDetectorGetPoints"));

            if v36 then
                u3.metalDetectorPoints = v36;
                u3.metalDetectorPointsId = Variables.MetalDetectorPointsId.Value;
            end;

            task.wait(0.1);
        end;
    end;

    local function mouseDotInteract(p37) -- Line: 142
        -- upvalues: GlobalGui (ref), TweenService (ref)
        if p37 ~= (GlobalGui.Center.Middle.MouseDotInteract.ImageLabel.ImageTransparency == 0) then
            for _, child in pairs(GlobalGui.Center.Middle.MouseDotInteract:GetChildren()) do
                TweenService:Create(child, TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = p37 and 0 or 1
                }):Play();
            end;
        end;
    end;

    local function targetHitIcon(p38) -- Line: 150
        -- upvalues: u3 (ref), TweenService (ref)
        for _, child in pairs(u3.mouseIconGui.TargetHit:GetChildren()) do
            child.ImageColor3 = p38;
        end;

        local function tween(p39, p40) -- Line: 152
            -- upvalues: u3 (ref), TweenService (ref)
            for _, child in pairs(u3.mouseIconGui.TargetHit:GetChildren()) do
                TweenService:Create(child, TweenInfo.new(p39, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ImageTransparency = p40
                }):Play();
            end;
        end;

        tween(0.03, 0);
        task.delay(0.03, function() -- Line: 158
            -- upvalues: tween (copy)
            tween(0.6, 1);
        end);
    end;

    local function attachHole(p41, p42) -- Line: 161
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p41;
        WeldConstraint.Part1 = p42;
        WeldConstraint.Parent = p41;
        p41.Anchored = false;
    end;

    local u43 = u6.raycastParamsNew();
    u43.IgnoreWater = true;
    u43.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities, workspace.Gameplay.Vehicles };

    local function canShootNoGunInWall(p44) -- Line: 172
        -- upvalues: u6 (ref), u8 (copy), u43 (copy)
        return not u6.raycastVisible(u8.Head.Position, p44 - u8.Head.Position, u43);
    end;

    local u45 = {
        _Glass = true,
        _GlassLight = true
    };

    local function bulletHoleEffect(p46) -- Line: 177
        -- upvalues: u6 (ref), u45 (copy), CharScope (ref)
        local u47 = u6.clone(game.ReplicatedStorage.Gameplay.Weapons[u45[p46.Instance.Name] and "BulletGlassHole" or "BulletHole"]);
        u47.CFrame = CFrame.new(p46.Position, p46.Position + p46.Normal) * CFrame.Angles(0, 0, math.random() * 3.141592653589793);

        if p46.Instance == workspace.Terrain then
            u47.Debris.Color = ColorSequence.new(workspace.Terrain:GetMaterialColor(p46.Material));
        else
            u47.Debris.Color = ColorSequence.new(p46.Instance.Color);
        end;

        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = u47;
        WeldConstraint.Part1 = p46.Instance;
        WeldConstraint.Parent = u47;
        u6.emit(u47.Impact, 1);
        u6.emit(u47.DirectionalSmoke, 10);
        u6.emit(u47.Smoke, 20);
        u6.emit(u47.Debris, 10);
        u47.Sound:Play();
        u47.Sound.PlaybackSpeed = math.random(8, 12) / 10;
        u47.Anchored = false;
        u47.Parent = workspace.Gameplay.Entities;
        local u48 = nil;

        local function cleanUp() -- Line: 198
            -- upvalues: u47 (copy), u48 (ref)
            if u47.Parent then
                u47:Destroy();
                u48:Disconnect();
            end;
        end;

        u48 = p46.Instance.Destroying:Connect(cleanUp);
        CharScope.taskDelay(15, cleanUp);
    end;

    local u49 = nil;

    local function aimToolAtMouseHit(u50, p51, p52) -- Line: 220
        -- upvalues: CharScope (ref), u6 (ref), PlayerEvent (ref), getProperCameraUnitRay (copy), u19 (copy), u49 (ref)
        local u53 = false;

        local function v54() -- Line: 222
            -- upvalues: u53 (ref), CharScope (ref), u6 (ref), PlayerEvent (ref), u50 (copy)
            if not u53 then
                u53 = true;

                if CharScope.getConnectionsAndThreads("Tool").aimToolAtMouseHit then
                    u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").aimToolAtMouseHit[1]);
                end;

                if CharScope.getConnectionsAndThreads("Tool").aimToolAtMouseHit2 then
                    u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").aimToolAtMouseHit2[1]);
                end;

                PlayerEvent:FireServer("aimToolAtMouseHit", u50);
            end;
        end;

        local u55 = p52 or 0.06;
        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "aimToolAtMouseHit", CharScope.taskSpawn(function() -- Line: 231
            -- upvalues: getProperCameraUnitRay (ref), u6 (ref), u19 (ref), u49 (ref), u50 (copy), u55 (ref)
            while true do
                local v56 = getProperCameraUnitRay(1000);
                local v57 = u6.raycastVisible(v56.origin, v56.length, u19);
                local v58 = v57 and v57.Position or v56.origin + v56.length;
                u49 = v58;
                local v59 = CFrame.new(u50.Part1.Position, v58):ToObjectSpace(u50.Part1.CFrame);
                u50.C0 = v59 - v59.Position;
                task.wait(u55);
            end;
        end));
        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "aimToolAtMouseHit2", CharScope.taskSpawn(function() -- Line: 242
            -- upvalues: PlayerEvent (ref), u50 (copy), u49 (ref)
            while true do
                PlayerEvent:FireServer("aimToolAtMouseHit", u50, u49);
                task.wait(0.4);
            end;
        end));

        return v54;
    end;

    local function keepLocalTransparencyOffForTool(u60) -- Line: 251
        -- upvalues: CharScope (ref), RunService (ref)
        local u61 = {};

        for _, descendant in pairs(u60:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Decal")) then
                table.insert(u61, descendant);
            end;
        end;

        local function setLocalTransparency(p62) -- Line: 256
            -- upvalues: u61 (copy)
            for _, v in pairs(u61) do
                v.LocalTransparencyModifier = p62;
            end;
        end;

        CharScope.buildSignalData("Tool", { RunService.RenderStepped, function(p63) -- Line: 259
                -- upvalues: u60 (copy), u61 (copy)
                if u60.PrimaryPart.LocalTransparencyModifier ~= 0 then
                    for _, v in pairs(u61) do
                        v.LocalTransparencyModifier = 0;
                    end;
                end;
            end });

        for _, v in pairs(u61) do
            v.LocalTransparencyModifier = 0;
        end;
    end;

    local function aimAssist(p64) -- Line: 265
        -- upvalues: CharScope (ref), u3 (ref), u7 (ref), workspace_CurrentCamera (ref), u9 (copy), AimAssistEnum (ref), aimAssist (copy), UserInputService (ref)
        CharScope.setThreadOrCleanUpFunctionIndex("Global", "aimAssistCleanUp", nil);

        if not p64 or (u3.readPlayerData("Settings", "AimAssist") or u3.platform ~= "Mobile" and u3.platform ~= "Console") then
            u7:disable();

            return;
        end;

        u7:setSubject(workspace_CurrentCamera);
        u7:setRange(2000);
        u7:setFieldOfView(20);

        if u9 == "Civilian" then
            u7:addTargetTag("AimAssistTargetCivilian", { "AimAssistTargetBonesCivilian" });
            u7:addTargetTag("AimAssistTargetPolice", { "AimAssistTargetBonesPolice" });
        else
            u7:addTargetTag("AimAssistTargetCivilian", { "AimAssistTargetBonesCivilian" });
        end;

        u7:setMethodStrength(AimAssistEnum.AimAssistMethod.Friction, 0.5);
        u7:setMethodStrength(AimAssistEnum.AimAssistMethod.Tracking, 0.5);
        u7:setMethodStrength(AimAssistEnum.AimAssistMethod.Centering, 0.5);
        u7:setEasingFunc(AimAssistEnum.AimAssistEasingAttribute.Distance, function(p65: number) -- Line: 283
            return p65 < 10 and 0 or 1;
        end);
        u7:enable();
        CharScope.buildSignalData("Tool", { u3.platformChangedEvent.Event, function() -- Line: 292
                -- upvalues: u3 (ref), aimAssist (ref)
                if u3.platform ~= "Mobile" and u3.platform ~= "Console" then
                    aimAssist();
                end;
            end });
        CharScope.setThreadOrCleanUpFunctionIndex("Global", "aimAssistCleanUp", function() -- Line: 297
            -- upvalues: aimAssist (ref)
            aimAssist();
        end);
        CharScope.buildSignalData("Tool", { UserInputService.InputChanged, function(p66: userdata, p67: any) -- Line: 300
                -- upvalues: u7 (ref)
                if p66.UserInputType == Enum.UserInputType.Gamepad1 and (p66.KeyCode == Enum.KeyCode.Thumbstick1 or p66.KeyCode == Enum.KeyCode.Thumbstick2) then
                    u7:updateGamepadEligibility(p66.KeyCode, p66.Position);
                end;
            end });
        CharScope.buildSignalData("Tool", { UserInputService.TouchPan, function() -- Line: 305
                -- upvalues: u7 (ref)
                u7:updateTouchEligibility();
            end });
    end;

    u1.shoulderCam = nil;

    local function aimSystem(u68, u69, u70, p71, u72) -- Line: 314
        -- upvalues: u1 (ref), u3 (ref), u2 (ref), aimAssist (copy), u6 (ref), Animator (copy), advancedInputStateChange (copy), Mobile (copy)
        if u1.isAiming then
            u1.shoulderCam(false);
        end;

        u3.activateMouseIcon(false);
        u2.keepMobileGuiTypePersistent(p71 and (p71.Name or "Aim") or "Aim", u68 and true or false);

        if u68 then
            function u1.shoulderCam(p73) -- Line: 319
                -- upvalues: u2 (ref), u1 (ref), u3 (ref), u69 (copy), u72 (copy), aimAssist (ref), u6 (ref), u68 (copy), Animator (ref), u70 (copy)
                local v74 = u2.activateShoulderCamera(p73);
                u1.isAiming = v74;
                u2.lockEmotes("isAiming", v74);
                u2.setCharRotType("aiming", v74 and {
                    priority = 1,
                    client = 5,
                    server = 6
                });
                u3.activateMouseIcon(v74 and u69 or false);

                if u72 then
                    aimAssist(v74);
                end;

                if v74 then
                    if u6.typeOf(u68) == "table" then
                        for i, v in pairs(u68) do
                            u6.animationBuffer(Animator, "play", i, nil, v);
                        end;
                    else
                        u6.animationBuffer(Animator, "play", u68);
                    end;
                elseif u68 then
                    if u6.typeOf(u68) == "table" then
                        for i, _ in pairs(u68) do
                            u6.animationBuffer(Animator, "stop", i);
                        end;
                    else
                        u6.animationBuffer(Animator, "stop", u68);
                    end;
                end;

                if u70 then
                    u70(v74);
                end;
            end;

            advancedInputStateChange(Enum.UserInputType.MouseButton2, p71 or Mobile.Aim.Aim, false, function() -- Line: 339
                -- upvalues: u1 (ref)
                return u1.isAiming;
            end, u1.shoulderCam);
        end;
    end;

    local function actionEvent(u75, p76, u77) -- Line: 343
        -- upvalues: u3 (ref), Ragdoll (ref), CharScope (ref), UserInputService (ref)
        local function run() -- Line: 344
            -- upvalues: u3 (ref), Ragdoll (ref), u77 (copy), u75 (copy)
            if u3.openedGui or Ragdoll.isActive and not u77 then
                return;
            end;

            u75();
        end;

        CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p78, p79) -- Line: 348
                -- upvalues: u3 (ref), Ragdoll (ref), u77 (copy), u75 (copy)
                if p78.UserInputType == Enum.UserInputType.MouseButton1 and not p79 then
                    if u3.isMouseObstructedByBlackBackground() then
                        return;
                    end;

                    if not u3.openedGui then
                        if Ragdoll.isActive and not u77 then
                            return;
                        end;

                        u75();
                    end;
                end;
            end });
        CharScope.buildSignalData("Tool", u3.mouseButton(p76, run));
    end;

    local function wheelToPunctureWhitelist(p80) -- Line: 357
        -- upvalues: u3 (ref)
        if p80.Name == "WheelCollision" then
            return p80;
        end;

        if u3.platform == "Mobile" or u3.platform == "Console" then
            local v81 = p80.Name == "Rim" and p80.Parent.WheelCollision;

            if not v81 then
                if p80.Parent.Name == "Rim" then
                    v81 = p80.Parent.Parent.Tire.WheelCollision;
                else
                    v81 = false;
                end;
            end;

            return v81;
        end;
    end;

    local u82 = 0;

    local function loadItem(u83, u84) -- Line: 368
        -- upvalues: u82 (ref), CharScope (ref), u6 (ref), LocalPlayer (ref), u3 (ref), u1 (ref), PlayerEvent (ref), HumanoidRootPart (copy), Equip (copy), PlayerStuff (ref), Equip2 (copy), Animator (copy), keepLocalTransparencyOffForTool (copy), GameRules (ref), u2 (ref), actionEvent (copy), Mobile (copy), u8 (copy), Ammo (copy), UserInputService (ref), aimSystem (copy), targetHitIcon (copy), bulletHoleEffect (copy), PlayerFunc (ref), u19 (copy), u18 (copy), BulletShooterPov (copy), getProperCameraUnitRay (copy), RunService (ref), u16 (copy), u43 (copy), Ragdoll (ref), u17 (copy), workspace_CurrentCamera (ref), Humanoid (copy), ScreenGui (copy), TweenService (ref), advancedInputStateChange (copy), PlacePreviewHighlight (copy), u21 (copy), mouseDotInteract (copy), aimToolAtMouseHit (copy), u20 (copy), SpeedRadar (copy), metalDetectorPointsUpdateListener (copy), Notepad (copy)
        u82 = (u82 + 1) % 1000;
        local u85 = u82;
        CharScope.setConnectionsAndThreads("Tool");

        if u83 then
            CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(function() -- Line: 373
                -- upvalues: u83 (copy), u6 (ref), LocalPlayer (ref), u3 (ref), u1 (ref), CharScope (ref), PlayerEvent (ref), HumanoidRootPart (ref), Equip (ref), PlayerStuff (ref), Equip2 (ref), Animator (ref), keepLocalTransparencyOffForTool (ref), GameRules (ref), u84 (copy), u2 (ref), actionEvent (ref), Mobile (ref), u8 (ref), Ammo (ref), UserInputService (ref), aimSystem (ref), targetHitIcon (ref), bulletHoleEffect (ref), PlayerFunc (ref), u19 (ref), u18 (ref), BulletShooterPov (ref), getProperCameraUnitRay (ref), RunService (ref), u16 (ref), u43 (ref), Ragdoll (ref), u85 (copy), u82 (ref), u17 (ref), workspace_CurrentCamera (ref), Humanoid (ref), ScreenGui (ref), TweenService (ref), advancedInputStateChange (ref), PlacePreviewHighlight (ref), u21 (ref), mouseDotInteract (ref), aimToolAtMouseHit (ref), u20 (ref), SpeedRadar (ref), metalDetectorPointsUpdateListener (ref), Notepad (ref)
                local Handle = u83:WaitForChild("Handle");
                local Config = require(u83:WaitForChild("Config"));

                if Config.DAMAGE or u83.Name == "PD Handcuffs" then
                    if u6.isKid(LocalPlayer) then
                        task.wait(0.1);
                        u3.notify({
                            message = "Kids can\'t engage in combat",
                            color = "red"
                        });
                        u1.equipSlot();

                        return true;
                    end;

                    local function propertyCombatRestricted() -- Line: 389
                        -- upvalues: Config (copy), LocalPlayer (ref), u3 (ref), u1 (ref)
                        if Config.DAMAGE and (Config.CATEGORY ~= "Taser" and (LocalPlayer.InsideLocation.Value and LocalPlayer.InsideLocation.Value:FindFirstChild("CombatRestricted"))) then
                            task.wait(0.1);
                            u3.notify({
                                message = "You cannot fight inside this location",
                                color = "red"
                            });
                            u1.equipSlot();

                            return true;
                        end;
                    end;

                    if Config.DAMAGE or u83.Name == "PD Handcuffs" then
                        if propertyCombatRestricted() then
                            return;
                        end;

                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(1, function() -- Line: 401
                            -- upvalues: propertyCombatRestricted (copy)
                            while not propertyCombatRestricted() do
                                task.wait(1);
                            end;
                        end));
                        PlayerEvent:FireServer("combatMode", true);
                    end;
                end;

                CharScope.buildSignalData("Tool", u6.instanceDestroyed(u83, function() -- Line: 408
                    -- upvalues: u1 (ref)
                    u1.equipSlot();
                end));
                local u86 = {};
                local u87 = Handle:FindFirstChild("EquipSound") or (Config.CATEGORY and HumanoidRootPart:FindFirstChild(Config.CATEGORY .. "Equip") or Equip);
                local v88 = Handle:FindFirstChild("EquipAnimation") and PlayerStuff.Items.Animations[Handle.EquipAnimation.Value] or (Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Equip") or Equip2);
                local v89 = v88:FindFirstChild("Weight") and (v88.Weight.Value / 10 or 1) or 1;
                local u90 = u6.loadAnimation(Animator, v88);
                local u91;

                if Handle:FindFirstChild("IdleAnimation") then
                    if Handle.IdleAnimation.Value == "" then
                        u91 = true;
                    else
                        u91 = PlayerStuff.Items.Animations[Handle.IdleAnimation.Value] or Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Idle");
                    end;
                else
                    u91 = Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Idle");
                end;

                if u91 == true then
                    u91 = nil;
                end;

                local v92 = u91 and u91:FindFirstChild("Weight") and (u91.Weight.Value / 10 or 1) or 1;

                if u91 then
                    u91 = u6.loadAnimation(Animator, u91);
                end;

                local u93 = Handle:FindFirstChild("ActionAnimation") and PlayerStuff.Items.Animations[Handle.ActionAnimation.Value] or Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Action");

                if u93 then
                    u93 = u6.loadAnimation(Animator, u93);
                end;

                if u91 then
                    u6.playAnimation(u91, "play", 0.4, v92);
                end;

                u6.playAnimation(u90, "play", nil, v89);
                u6.playSoundReplicate(u87);
                keepLocalTransparencyOffForTool(u83);
                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 429
                    -- upvalues: Config (copy), u83 (ref), PlayerEvent (ref), u90 (ref), u6 (ref), GameRules (ref), u91 (ref), u93 (ref), u87 (copy), u86 (copy)
                    if Config.DAMAGE or u83.Name == "PD Handcuffs" then
                        PlayerEvent:FireServer("combatMode", false);
                    end;

                    if u90.animationTrack.IsPlaying then
                        u6.playAnimation(u90, "stop", GameRules.defaultCharacterAnimationFadeTime);
                    end;

                    if u91 and u91.animationTrack.IsPlaying then
                        u6.playAnimation(u91, "stop", GameRules.defaultCharacterAnimationFadeTime);
                    end;

                    if u93 and u93.animationTrack.IsPlaying then
                        u6.playAnimation(u93, "stop", GameRules.defaultCharacterAnimationFadeTime);
                    end;

                    if u87.IsPlaying then
                        u6.stopSoundReplicate(u87);
                    end;

                    if u86.Prompts then
                        for _, v in pairs(u86.Prompts) do
                            if v.Parent then
                                v:Destroy();
                            end;
                        end;
                    end;

                    local function check(p94) -- Line: 440
                        -- upvalues: u6 (ref)
                        if u6.typeOf(p94) == "Instance" and (p94:IsA("Sound") and p94.IsPlaying) then
                            u6.stopSoundReplicate(p94);
                        end;
                    end;

                    for _, v in pairs(u86) do
                        if u6.typeOf(v) == "table" then
                            for _, v2 in pairs(v) do
                                if u6.typeOf(v2) == "Instance" and (v2:IsA("Sound") and v2.IsPlaying) then
                                    u6.stopSoundReplicate(v2);
                                end;
                            end;
                        elseif u6.typeOf(v) == "Instance" and (v:IsA("Sound") and v.IsPlaying) then
                            u6.stopSoundReplicate(v);
                        end;
                    end;
                end);

                if u84 then
                    local function degradeItemsLoop(u95, u96, u97, u98) -- Line: 453
                        -- upvalues: CharScope (ref), PlayerEvent (ref), u83 (ref)
                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(u95, function() -- Line: 454
                            -- upvalues: u97 (copy), u98 (copy), PlayerEvent (ref), u83 (ref), u96 (copy), u95 (copy)
                            while not u97 or u97() do
                                if not u98 or u98() then
                                    PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), u96);
                                end;

                                task.wait(u95);
                            end;
                        end));
                    end;

                    if u84 == true or u84 == "Vehicle" then
                        for _, child in pairs(u83.Config:GetChildren()) do
                            if child.Name == "TotalAmmo" then
                                u6.propertyListener(child, true);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 468
                                    -- upvalues: u6 (ref), child (copy)
                                    u6.propertyListener(child, false);
                                end);
                            end;
                        end;
                    end;

                    if u84 == true then
                        if Config.RAIN_PROTECTION then
                            u2.rainProtection = true;
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 477
                                -- upvalues: u2 (ref)
                                u2.rainProtection = false;
                            end);
                        end;

                        if Config.LOCK_HUMANOID_STATE then
                            u2.lockHumanoidState("item", Config.LOCK_HUMANOID_STATE);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 487
                                -- upvalues: u2 (ref)
                                u2.lockHumanoidState("item", nil);
                            end);
                        end;
                    end;

                    if Config.CATEGORY == "Food" or Config.CATEGORY == "Drink" then
                        if u84 == true or u84 == "Vehicle" then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            local u99 = {
                                Food = 3.5,
                                Drink = 2.2
                            };
                            u86.actionSound = HumanoidRootPart:WaitForChild(Config.CATEGORY .. "Action");
                            local u100 = true;
                            actionEvent(function() -- Line: 499
                                -- upvalues: u100 (ref), u6 (ref), u86 (copy), u93 (ref), GameRules (ref), u99 (copy), Config (copy), u2 (ref), CharScope (ref), PlayerEvent (ref), u83 (ref)
                                if u100 then
                                    u100 = false;
                                    u6.playSoundReplicate(u86.actionSound);
                                    u6.playAnimation(u93, "play", GameRules.defaultCharacterAnimationFadeTime);
                                    local v101 = u99[Config.CATEGORY] + 0.6;
                                    u2.displayBottomBarMessage("foodDrink", 10, Config.CATEGORY == "Food" and "Eating" or "Drinking", v101, Config.CATEGORY == "Food" and Color3.fromRGB(255, 189, 114) or Color3.fromRGB(88, 188, 255));
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "foodDrinkThread", CharScope.taskDelay(v101, function() -- Line: 506
                                        -- upvalues: u2 (ref), PlayerEvent (ref), u83 (ref), Config (ref), u100 (ref)
                                        u2.displayBottomBarMessage("foodDrink");
                                        PlayerEvent:FireServer("modifyInventory", {
                                            change = 1,
                                            removeById = u83:GetAttribute("Id")
                                        });

                                        if Config.ENERGY then
                                            u2.changeStamina(Config.ENERGY);
                                            u2.canUseStaminaAgain();
                                        end;

                                        if Config.HUNGER then
                                            u2.changeFood(Config.HUNGER);
                                        end;

                                        u100 = true;
                                    end));
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 519
                                -- upvalues: u2 (ref)
                                u2.displayBottomBarMessage("foodDrink");
                                u2.keepMobileGuiTypePersistent("Action", false);
                            end);
                        end;
                    elseif Config.GUN then
                        local u102 = Handle:FindFirstChild("AimAnimation") and Handle.AimAnimation.Value or Config.CATEGORY;
                        local u103 = Handle:FindFirstChild("ReloadAnimation") and Handle.ReloadAnimation.Value or Config.CATEGORY;
                        local u104 = { u3.mouseIconGui.Reloading.Left.ImageLabel, u3.mouseIconGui.Reloading.Left.Shades };
                        local u105 = { u3.mouseIconGui.Reloading.Right.ImageLabel, u3.mouseIconGui.Reloading.Right.Shades };
                        local u106 = u6.availableItems[u83.Name];
                        local u107 = false;

                        local function setViewModelPart() -- Line: 530
                            -- upvalues: Config (copy), u2 (ref), u1 (ref)
                            if Config.CATEGORY == "Handgun" then
                                u2.setCameraRelativeToViewModelPart(u1.isAiming and "Item" or "HumanoidRootPart", u1.isAiming and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                return;
                            end;

                            u2.setCameraRelativeToViewModelPart("Item", u1.isAiming and Config.FIRST_PERSON_AIM_OFFSET or (not u1.isAiming and Config.FIRST_PERSON_OFFSET or CFrame.new(0, 1.7, 0)), true);
                        end;

                        local function setToolGrip(p108) -- Line: 537
                            -- upvalues: u6 (ref), u83 (ref), u1 (ref), u8 (ref), Config (copy)
                            local setToolGrip = u6.setToolGrip;
                            local v109 = (p108 or u1.isAiming) and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                            setToolGrip(nil, u83, v109);
                        end;

                        local function reload(u110) -- Line: 540
                            -- upvalues: u107 (ref), u83 (ref), u106 (copy), u3 (ref), u1 (ref), Config (copy), setViewModelPart (copy), u6 (ref), u8 (ref), CharScope (ref), u86 (copy), Animator (ref), u103 (copy), u2 (ref), GameRules (ref), u104 (copy), u105 (copy), Ammo (ref)
                            if u107 or (u83.Config.Ammo.Value >= u106.Config.Ammo.Value or u83.Config.TotalAmmo.Value <= 0) then
                                if u110 then
                                    u110();
                                end;

                                return;
                            end;

                            local function u112() -- Line: 542
                                -- upvalues: u3 (ref), u1 (ref), Config (ref), u107 (ref), setViewModelPart (ref), u6 (ref), u83 (ref), u8 (ref), CharScope (ref), u110 (copy)
                                u3.activateMouseIcon(u1.isAiming and (Config.MOUSE_ICON or "Crosshair") or false);
                                u107 = false;
                                setViewModelPart();
                                local setToolGrip2 = u6.setToolGrip;
                                local v111 = u1.isAiming and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                setToolGrip2(nil, u83, v111);
                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading", nil);
                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading3", nil);

                                if u110 then
                                    CharScope.taskSpawn(u110);
                                end;
                            end;

                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading", u112);
                            u107 = true;

                            if u86.reloadSound.IsPlaying then
                                u6.stopSoundReplicate(u86.reloadSound);
                            end;

                            u6.animationBuffer(Animator, "stop", u103 .. "Reload", 0.7);
                            u3.activateMouseIcon("Reloading");
                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading2", CharScope.taskDelay(0.5, function() -- Line: 556
                                -- upvalues: u107 (ref), u2 (ref), u6 (ref), u83 (ref), u8 (ref), Config (ref), u86 (ref), Animator (ref), u103 (ref)
                                if not u107 then
                                    return;
                                end;

                                u2.setCameraRelativeToViewModelPart("HumanoidRootPart", CFrame.new(0, 1.7, 0), true);
                                u6.setToolGrip(nil, u83, u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                u6.playSoundReplicate(u86.reloadSound);
                                u6.animationBuffer(Animator, "play", u103 .. "Reload", 0.4);
                                local v113 = u6.animationBuffer(Animator, "get", u103 .. "Reload");
                                task.wait(v113.Length - 0.7);
                                u6.animationBuffer(Animator, "stop", u103 .. "Reload", 0.7);
                            end));
                            local u114 = Config.RELOAD_TIME or (GameRules.reloadTimeByCategory[u103] or 2.6);
                            local u115 = 0;
                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading3", CharScope.taskDefer(function() -- Line: 568
                                -- upvalues: u115 (ref), u114 (copy), u6 (ref), u104 (ref), u105 (ref), u107 (ref), u83 (ref), u106 (ref), Ammo (ref), u112 (copy)
                                while u115 < u114 do
                                    u6.updateCircularHud(u104, u105, u115 / u114);
                                    u115 = u115 + task.wait();

                                    if not u107 then
                                        return;
                                    end;
                                end;

                                local v116 = u83.Config.TotalAmmo.Value + u83.Config.Ammo.Value < u106.Config.Ammo.Value and u83.Config.TotalAmmo.Value + u83.Config.Ammo.Value or u106.Config.Ammo.Value;
                                u83.Config.TotalAmmo.Value = u83.Config.TotalAmmo.Value - v116 + u83.Config.Ammo.Value;
                                u83.Config.Ammo.Value = v116;
                                Ammo.ImageLabel2.Ammo.Text = v116;
                                Ammo.ImageLabel2.TotalAmmo.Text = "/ " .. u83.Config.TotalAmmo.Value;
                                u112();
                            end));
                        end;

                        if u84 == "Vehicle" then
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 584
                                -- upvalues: u2 (ref), u6 (ref), Animator (ref), u103 (copy), u83 (ref)
                                u2.keepMobileGuiTypePersistent("GunVehicle", false);
                                u6.animationBuffer(Animator, "unload", u103 .. "Reload");
                                u6.propertyListenerReceived(nil, u83.Config.Ammo, u83.Config.Ammo.Value);
                            end);
                            u2.keepMobileGuiTypePersistent("GunVehicle", true);
                            u86.reloadSound = HumanoidRootPart:FindFirstChild(u103 .. "Reload") or u83.Handle:WaitForChild("ReloadSound");
                            u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u103 .. "Reload"]);
                            CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p117) -- Line: 592
                                    -- upvalues: u3 (ref), reload (copy)
                                    if p117.KeyCode == Enum.KeyCode.R and u3.canPressKey(p117.KeyCode) then
                                        reload();
                                    end;
                                end });
                            CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.GunVehicle.Reload, reload));
                        elseif u84 == true then
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 599
                                -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref), u103 (copy), u102 (copy), u83 (ref), CharScope (ref), Ammo (ref)
                                u2.keepMobileGuiTypePersistent("Gun", false);

                                if u1.isAiming then
                                    u1.shoulderCam(false);
                                end;

                                u3.activateMouseIcon(false);
                                u2.keepMobileGuiTypePersistent("Aim", false);
                                u6.animationBuffer(Animator, "unload", u103 .. "Reload", u102 .. "AimStabilize", u102 .. "Aim");
                                u6.propertyListenerReceived(nil, u83.Config.Ammo, u83.Config.Ammo.Value);
                                CharScope.taskDelay(0.03, function() -- Line: 604
                                    -- upvalues: Ammo (ref), u83 (ref), u6 (ref)
                                    if Ammo:GetAttribute("Id") == u83:GetAttribute("Id") then
                                        u6.guiTransition(Ammo, "Position", UDim2.fromScale(0, 0.2), false);
                                    end;
                                end);
                            end);
                            u2.keepMobileGuiTypePersistent("Gun", true);
                            local Barrel = Handle:WaitForChild("Barrel");
                            local u118 = HumanoidRootPart:FindFirstChild(Config.CATEGORY .. "Fire") or u83.Handle:WaitForChild("FireSound");
                            u86.reloadSound = HumanoidRootPart:FindFirstChild(u103 .. "Reload") or u83.Handle:WaitForChild("ReloadSound");
                            u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u102 .. "AimStabilize"], PlayerStuff.Items.Animations[u102 .. "Aim"], PlayerStuff.Items.Animations[u103 .. "Reload"], Config.SHOTGUN_QUICK_RELOAD and PlayerStuff.Items.Animations.ShotgunQuickReload);

                            if Config.FIRST_PERSON_OFFSET then
                                u2.setCameraRelativeToViewModelPart("Item", Config.FIRST_PERSON_OFFSET);
                            end;

                            aimSystem({
                                [u102 .. "AimStabilize"] = 0.7,
                                [u102 .. "Aim"] = 1
                            }, Config.MOUSE_ICON or "Crosshair", function(p119) -- Line: 616
                                -- upvalues: u107 (ref), u6 (ref), u83 (ref), u1 (ref), u8 (ref), Config (copy), setViewModelPart (copy), u91 (ref), GameRules (ref), u3 (ref)
                                if not u107 then
                                    local setToolGrip2 = u6.setToolGrip;
                                    local v120 = u1.isAiming and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                    setToolGrip2(nil, u83, v120);
                                    setViewModelPart();
                                end;

                                if u91 and u1.equippedItem == u83 then
                                    u6.playAnimation(u91, p119 and "stop" or "play", GameRules.defaultCharacterAnimationFadeTime);
                                end;

                                if u107 and p119 then
                                    u3.activateMouseIcon("Reloading");
                                end;
                            end, nil, true);
                            u6.guiTransition(Ammo, "Position", UDim2.fromScale(0, 0.2), true);
                            Ammo:SetAttribute("Id", u83:GetAttribute("Id"));
                            Ammo.ImageLabel.Item.Text = u83.Name;
                            Ammo.ImageLabel2.Ammo.Text = u83.Config.Ammo.Value;
                            Ammo.ImageLabel2.TotalAmmo.Text = "/ " .. u83.Config.TotalAmmo.Value;
                            local u121 = 0;
                            local u122 = false;
                            local u123 = true;

                            local function RAND(p124, p125, p126) -- Line: 644
                                local v127 = 1 / (p126 or 1);

                                return math.random(p124 * v127, p125 * v127) / v127;
                            end;

                            local v128 = u3.mouseIconGui[Config.MOUSE_ICON or "Crosshair"];

                            if v128:FindFirstChild("IsCrosshair") then
                                local _ = {
                                    Bottom = Vector2.new(0, 1),
                                    Top = Vector2.new(0, -1),
                                    Left = Vector2.new(-1, 0),
                                    Right = Vector2.new(1, 0),
                                    TopLeft = Vector2.new(-0.5, -0.5),
                                    TopRight = Vector2.new(0.5, -0.5),
                                    BottomLeft = Vector2.new(-0.5, 0.5),
                                    BottomRight = Vector2.new(0.5, 0.5)
                                };

                                for _, child in pairs(v128:GetChildren()) do
                                    if child:IsA("GuiBase") and not child:GetAttribute("BasePosition") then
                                        child:SetAttribute("BasePosition", child.Position);
                                    end;
                                end;
                            end;

                            local function bulletTarget(u129, u130, u131) -- Line: 677
                                -- upvalues: u6 (ref), LocalPlayer (ref), Config (copy), u3 (ref), GameRules (ref), targetHitIcon (ref), PlayerEvent (ref), bulletHoleEffect (ref), CharScope (ref), PlayerFunc (ref)
                                local Instance2 = u129.Instance;

                                local function characterHit(p132, p133) -- Line: 679
                                    -- upvalues: u6 (ref), LocalPlayer (ref), Config (ref), u3 (ref), u129 (copy), GameRules (ref), Instance2 (copy), targetHitIcon (ref), PlayerEvent (ref), u130 (copy), u131 (copy)
                                    if u6.canPenetrate(LocalPlayer, p132, Config) then
                                        local v134, v135 = u6.canCombat(LocalPlayer, p132, Config.WANTED_COMBAT);

                                        if u6.typeOf(v134) == "string" then
                                            if not u6.rest(v135, 60, LocalPlayer) then
                                                u3.notify({
                                                    message = v134
                                                });
                                            end;
                                        elseif v134 then
                                            if not p133 and Config.DAMAGE > 0 then
                                                u3.emitBlood(p132, u129.Position);
                                            end;

                                            local v136 = GameRules.characterMeshesToBodyParts[Instance2.Name];

                                            if Instance2.Name == "Head" then
                                                targetHitIcon(Color3.fromRGB(255, 137, 97));
                                                PlayerEvent:FireServer("damage", {
                                                    bodyParts = v136 and {
                                                        { v136, 1 }
                                                    },
                                                    shotCode = u130,
                                                    pos = u129.Position,
                                                    target = p132,
                                                    damageFactor = (u131 or 1) * 1.5,
                                                    bulletProofTool = p133
                                                });

                                                return;
                                            end;

                                            targetHitIcon(Color3.fromRGB(212, 212, 212));
                                            PlayerEvent:FireServer("damage", {
                                                bodyParts = v136 and {
                                                    { v136, 1 }
                                                },
                                                shotCode = u130,
                                                pos = u129.Position,
                                                target = p132,
                                                damageFactor = u131,
                                                bulletProofTool = p133
                                            });
                                        end;
                                    end;
                                end;

                                if Instance2:IsDescendantOf(workspace.Characters) then
                                    if u6.toolSystem.isTool(Instance2.Parent) then
                                        local v137 = require(u6.availableItems[Instance2.Parent.Name].Config).BULLET_PROOF_DURABILITY and u6.getPlayerFromCharacter(Instance2.Parent.Parent);

                                        if v137 then
                                            characterHit(v137, Instance2.Parent);
                                        end;
                                    else
                                        local PlayerFromCharacter = u6.getPlayerFromCharacter(Instance2.Parent);

                                        if PlayerFromCharacter then
                                            characterHit(PlayerFromCharacter);

                                            return;
                                        end;
                                    end;

                                    return;
                                end;

                                if Instance2.Parent.Name == "PVPNPC" then
                                    characterHit(Instance2.Parent);

                                    return;
                                end;

                                if Instance2:IsDescendantOf(workspace.Gameplay.Vehicles) then
                                    if Instance2.Name == "WheelCollision" and not Instance2:GetAttribute("DontPuncture") then
                                        local Parent = Instance2:GetRootPart().Parent;
                                        local v138 = u6.getVehicleInfo.lastDrove(Parent, true);

                                        if v138 and v138 ~= LocalPlayer then
                                            local v139 = u6.canPunctureTire(LocalPlayer, v138);

                                            if v139 == true then
                                                if Instance2:GetAttribute("Durability") ~= 0 then
                                                    targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                end;

                                                PlayerEvent:FireServer("damage", {
                                                    shotCode = u130,
                                                    pos = u129.Position,
                                                    targetTire = Instance2
                                                });

                                                return;
                                            end;

                                            if not u6.rest((v139 or "combat") .. "Tire", 60, LocalPlayer) then
                                                u3.notify({
                                                    message = v139 == "policeShootingNonCivilian" and "Cannot puncture non-civilian vehicle" or (v139 == "policeShootingNotWanted" and "Cannot puncture a vehicle of player that is not wanted" or (v139 == "policeShootingCriminalInside" and "Cannot puncture a vehicle of criminal that is inside building" or (v139 == "crewmateCombat" and "Cannot puncture a crew member\'s vehicle" or "Cannot puncture a vehicle of player not in Combat Mode")))
                                                });
                                            end;
                                        end;
                                    elseif not Config.NO_HOLE then
                                        bulletHoleEffect(u129);
                                    end;
                                elseif Instance2.Parent:GetAttribute("Pet") then
                                    if Instance2.Parent ~= u6.getInstanceAttribute(LocalPlayer, "Pet") then
                                        local v140, v141 = u6.canCombat(LocalPlayer, game.Players[Instance2.Parent.Parent.Name], nil, true);

                                        if u6.typeOf(v140) == "string" then
                                            if not u6.rest(v141, 60, LocalPlayer) then
                                                u3.notify({
                                                    message = v140
                                                });
                                            end;
                                        elseif v140 then
                                            targetHitIcon(Color3.fromRGB(212, 212, 212));
                                            PlayerEvent:FireServer("damage", {
                                                shotCode = u130,
                                                pos = u129.Position,
                                                targetPet = Instance2.Parent,
                                                damageFactor = u131
                                            });
                                        end;
                                    end;
                                elseif not Instance2:IsDescendantOf(workspace.Gameplay.Entities) then
                                    if Instance2.Parent:FindFirstChild("Humanoid") then
                                        return;
                                    end;

                                    if Instance2.Name == "_TargetHitIcon" or Instance2.Name == "_TargetHitIconHead" then
                                        targetHitIcon(Instance2.Name == "_TargetHitIcon" and Color3.fromRGB(212, 212, 212) or Color3.fromRGB(255, 137, 97));
                                    elseif Instance2.Parent:GetAttribute("GiveDamageMission") then
                                        CharScope.taskDefer(function() -- Line: 745
                                            -- upvalues: PlayerFunc (ref), Instance2 (copy), Config (ref)
                                            PlayerFunc:InvokeServer("talkToMission", Instance2.Parent, {
                                                dmg = Config.DAMAGE
                                            });
                                        end);
                                    end;

                                    if not Config.NO_HOLE then
                                        bulletHoleEffect(u129);
                                    end;
                                end;
                            end;

                            local u142 = u6.raycastParamsNew();
                            u142.FilterType = Enum.RaycastFilterType.Exclude;
                            u142.FilterDescendantsInstances = { workspace.Gameplay, workspace.Characters };
                            local u143 = 0;
                            local u144 = 0;

                            local function shootThroughWindows(u145, u146, u147, p148) -- Line: 758
                                -- upvalues: Config (copy), u6 (ref), u8 (ref), u19 (ref)
                                local u149 = p148 or {};
                                local v154 = u145.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) and u6.raycastVisible(u146, u147, u19, {
                                    customRequirements = function(p150) -- Line: 761, Name: customRequirements
                                        -- upvalues: Config (ref), u145 (copy), u6 (ref), u8 (ref), u146 (copy), u147 (copy), u149 (ref)
                                        if p150 then
                                            if p150.Instance.Name == "_Glass" and (not Config.CANT_PRENETRATE_GLASS and (u145.Position - p150.Position).Magnitude < 2) then
                                                local Parent = p150.Instance.Parent.Parent;
                                                local v151 = u6.raycastParamsNew();
                                                v151.FilterDescendantsInstances = { u8, Parent };
                                                v151.IgnoreWater = true;
                                                local v152 = u6.raycastVisible(u146, u147 + u6.smartUnit(u147) * 20, v151, {
                                                    character = true
                                                });

                                                if not (v152 and (v152.Instance.Parent.Parent == workspace.Characters and (u6.getPlayerFromCharacter(v152.Instance.Parent) and u6.getVehicleInfo.inVehicle(u6.getPlayerFromCharacter(v152.Instance.Parent)) == Parent))) then
                                                    return p150;
                                                end;

                                                if u149.windowHit then
                                                    u149.windowHit(p150);
                                                end;

                                                return v152;
                                            end;

                                            local v153 = u149.hit and ((u145.Position - p150.Position).Magnitude < 2 and u149.hit(p150));

                                            if v153 then
                                                return v153;
                                            end;
                                        end;
                                    end
                                });

                                if v154 then
                                    return v154;
                                end;
                            end;

                            local function laserShoot() -- Line: 785
                                -- upvalues: u143 (ref), u121 (ref), u144 (ref), u2 (ref), Config (copy), Barrel (copy), u18 (ref), CharScope (ref), u6 (ref), u118 (copy), BulletShooterPov (ref), getProperCameraUnitRay (ref), u19 (ref), shootThroughWindows (copy), u142 (copy), PlayerEvent (ref), u83 (ref), RunService (ref), bulletHoleEffect (ref), u3 (ref), bulletTarget (copy)
                                u143 = (u143 + 1) % 100;
                                local v155 = tick();
                                u121 = math.max(0, 0.5 - v155 + u144) / 0.5 * u121 * 0.1 + 0.3;
                                u144 = v155;

                                if u2.gunRecoilFirstPerson then
                                    u2.gunRecoilFirstPerson(Config.RECOIL, Barrel);
                                end;

                                local v156 = Config.RECOIL * 25;
                                local v157 = 1 / (Config.ACCURACY or 0.1 or 1);
                                local v158 = v156 * (math.random(u121 * v157, u121 * v157) / v157);
                                local math_rad_ret = math.rad(v158);
                                local v159 = 1 / (Config.ACCURACY or 0.1 or 1);
                                local v160 = v156 * (math.random(-0.1 * v159, 0.1 * v159) / v159);
                                local math_rad_ret2 = math.rad(v160);
                                local v161 = 1 / (Config.ACCURACY or 0.1 or 1);
                                local v162 = v156 * (math.random(-0.5 * v161, 0.5 * v161) / v161);
                                local math_rad_ret3 = math.rad(v162);
                                u18.accelerate((Vector3.new(math_rad_ret, math_rad_ret2, math_rad_ret3)));
                                CharScope.taskDelay(0.03, function() -- Line: 797
                                    -- upvalues: u18 (ref), math_rad_ret (copy), math_rad_ret2 (copy), math_rad_ret3 (copy)
                                    u18.accelerate((Vector3.new(-math_rad_ret, -math_rad_ret2, -math_rad_ret3)));
                                end);
                                u6.playSoundReplicate(u118);
                                local u163 = nil;
                                local v164 = Config.BULLET_DISTANCE or 600;
                                local u165 = Config.BULLET_TYPE and u6.clone(game.ReplicatedStorage.Gameplay.Weapons[Config.BULLET_TYPE]) or u6.clone(BulletShooterPov);
                                local v166 = getProperCameraUnitRay(10);
                                local v167 = u6.bulletSpread(v166.length.Unit, (Config.TR_DIFF or 0) + (u2.jumpingShootingSpread and 70 or 0)) * 1000;
                                local v168 = u6.raycastVisible(v166.origin, v167, u19, {
                                    character = true
                                });

                                if v168 and not v168.Instance:IsDescendantOf(workspace.Characters) then
                                    v168 = shootThroughWindows(v168, v166.origin, v167) or v168;
                                end;

                                local v169 = v168 and v168.Position or v166.origin + v167;
                                local CFrame_new_ret = CFrame.new(Barrel.WorldPosition, v169);
                                u165.CFrame = CFrame_new_ret;
                                u165.Parent = workspace.Gameplay.Entities;
                                local LookVector = CFrame_new_ret.LookVector;
                                local v170 = u6.raycastVisible(CFrame_new_ret.Position, LookVector * v164, u142);
                                local X = (CFrame_new_ret.Position + LookVector * v164).X;
                                local v171;

                                if v170 then
                                    v171 = v170.Position.X or X;
                                else
                                    v171 = X;
                                end;

                                local u172 = u6.bulletPosDestroyXCheck(nil, X, u165);
                                PlayerEvent:FireServer("bullet", {
                                    pos = v169,
                                    posDestroyX = v171,
                                    weaponName = u83.Name
                                });

                                local function destroyBullet() -- Line: 829
                                    -- upvalues: u165 (copy), u163 (ref), Config (ref)
                                    if u165.Parent then
                                        u163:Disconnect();

                                        if Config.BULLET_DESTROY_DELAY then
                                            task.wait(Config.BULLET_DESTROY_DELAY);
                                        end;

                                        u165:Destroy();
                                    end;
                                end;

                                local u173 = { CFrame_new_ret.Position, CFrame_new_ret.LookVector };
                                CharScope.taskDefer(function() -- Line: 837
                                    -- upvalues: u163 (ref), RunService (ref), u6 (ref), u172 (copy), X (copy), u165 (copy), destroyBullet (copy), LookVector (copy), Config (ref), u19 (ref), bulletHoleEffect (ref), u3 (ref), shootThroughWindows (ref), bulletTarget (ref), u173 (copy)
                                    u163 = RunService.Heartbeat:Connect(function(p174) -- Line: 838
                                        -- upvalues: u6 (ref), u172 (ref), X (ref), u165 (ref), destroyBullet (ref), LookVector (ref), Config (ref), u19 (ref), bulletHoleEffect (ref), u3 (ref), shootThroughWindows (ref), bulletTarget (ref), u173 (ref)
                                        if u6.bulletPosDestroyXCheck(u172, X, u165) then
                                            return destroyBullet();
                                        end;

                                        local Position = u165.Position;
                                        local v175 = LookVector * (Config.BULLET_SPEED or 2000) * p174;
                                        local u176 = u6.raycastVisible(Position, v175, u19, {
                                            character = true
                                        });
                                        u165.CFrame = u165.CFrame + v175;

                                        if u176 then
                                            local u177 = nil;

                                            local function windowHitFunc(p178) -- Line: 846
                                                -- upvalues: u177 (ref), Config (ref), bulletHoleEffect (ref)
                                                u177 = 0.6;

                                                if not Config.NO_HOLE then
                                                    bulletHoleEffect(p178);
                                                end;
                                            end;

                                            local function hitFunc(p179) -- Line: 850
                                                -- upvalues: u3 (ref), u176 (ref)
                                                local Instance2 = p179.Instance;
                                                local v180;

                                                if Instance2.Name == "WheelCollision" then
                                                    v180 = Instance2;
                                                elseif u3.platform == "Mobile" or u3.platform == "Console" then
                                                    v180 = Instance2.Name == "Rim" and Instance2.Parent.WheelCollision;

                                                    if not v180 then
                                                        if Instance2.Parent.Name == "Rim" then
                                                            v180 = Instance2.Parent.Parent.Tire.WheelCollision;
                                                        else
                                                            v180 = false;
                                                        end;
                                                    end;
                                                else
                                                    v180 = nil;
                                                end;

                                                if v180 and (u176.Position - v180.Position).Magnitude < 2 then
                                                    return {
                                                        Instance = v180,
                                                        Position = p179.Position,
                                                        Material = p179.Material,
                                                        Normal = p179.Normal
                                                    };
                                                end;
                                            end;

                                            if not u176.Instance:IsDescendantOf(workspace.Characters) then
                                                u176 = shootThroughWindows(u176, Position, v175, {
                                                    windowHit = windowHitFunc,
                                                    hit = hitFunc
                                                }) or u176;
                                            end;

                                            bulletTarget(u176, u173, u177);

                                            return destroyBullet();
                                        end;
                                    end);
                                end);
                                CharScope.taskDelay(5, destroyBullet);
                            end;

                            local function shootCalculation() -- Line: 868
                                -- upvalues: u16 (ref), u83 (ref), laserShoot (copy), u6 (ref), Barrel (copy), CharScope (ref), Ammo (ref), reload (copy), Config (copy)
                                u16[u83] = true;
                                laserShoot();
                                u6.emit(Barrel.DischargeFlashClient, 3);
                                Barrel.DischargeLight.Enabled = true;
                                CharScope.taskDelay(0.03, function() -- Line: 873
                                    -- upvalues: Barrel (ref)
                                    Barrel.DischargeLight.Enabled = false;
                                end);
                                u83.Config.Ammo.Value = u83.Config.Ammo.Value - 1;
                                Ammo.ImageLabel2.Ammo.Text = u83.Config.Ammo.Value;

                                if u83.Config.Ammo.Value == 0 then
                                    reload(function() -- Line: 877
                                        -- upvalues: Config (ref), u16 (ref), u83 (ref)
                                        task.wait(60 / Config.RPM);
                                        u16[u83] = nil;
                                    end);

                                    return;
                                end;

                                task.wait(60 / Config.RPM);
                                u16[u83] = nil;
                            end;

                            local function beginShooting(p181) -- Line: 886
                                -- upvalues: Barrel (copy), u6 (ref), u8 (ref), u43 (ref), u123 (ref), u107 (ref), u83 (ref), u16 (ref), u1 (ref), u3 (ref), Ragdoll (ref), Mobile (ref), Config (copy), shootCalculation (copy), u122 (ref), u85 (ref), u82 (ref), u17 (ref), laserShoot (copy), CharScope (ref), Animator (ref)
                                if not (u6.raycastVisible(u8.Head.Position, Barrel.WorldPosition - u8.Head.Position, u43) or (u123 or (u107 or (u83.Config.Ammo.Value <= 0 or u16[u83])))) then
                                    if not (u1.isAiming or (p181 or (u3.openedGui or Ragdoll.isActive))) then
                                        u1.shoulderCam(true);
                                        u6.mobileButtonPressed(Mobile.Aim.Aim, true);
                                    end;

                                    if u1.isAiming then
                                        if Config.SHOOT_MODE == 1 then
                                            shootCalculation();

                                            return;
                                        end;

                                        if Config.SHOOT_MODE == 2 then
                                            u6.mobileButtonPressed(Mobile.Gun.Fire, true);
                                            u122 = true;

                                            while u85 == u82 and (u1.isAiming and (u122 and (u83.Config.Ammo.Value > 0 and not (u16[u83] or u107)))) do
                                                shootCalculation();
                                            end;
                                        else
                                            if Config.SHOOT_MODE == 3 then
                                                if u17[u83] then
                                                    return;
                                                end;

                                                u17[u83] = true;

                                                for i = 1, 3 do
                                                    if u107 or u83.Config.Ammo.Value == 0 then
                                                        u17[u83] = nil;

                                                        return;
                                                    end;

                                                    shootCalculation();
                                                    local _ = i;
                                                end;

                                                task.wait(Config.BURST_COOLDOWN);
                                                u17[u83] = nil;

                                                return;
                                            end;

                                            if Config.SHOOT_MODE == 4 then
                                                for i = 1, Config.BULLET_AMOUNT - 1 do
                                                    laserShoot();
                                                    local _ = i;
                                                end;

                                                if Config.SHOTGUN_QUICK_RELOAD then
                                                    CharScope.taskDelay(0.3, function() -- Line: 918
                                                        -- upvalues: u6 (ref), Animator (ref)
                                                        u6.animationBuffer(Animator, "play", "ShotgunQuickReload");
                                                    end);
                                                end;

                                                shootCalculation();
                                            end;
                                        end;
                                    end;
                                end;
                            end;

                            local function stopShooting() -- Line: 927
                                -- upvalues: u6 (ref), Mobile (ref), u122 (ref)
                                u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                u122 = false;
                            end;

                            CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p182, p183) -- Line: 931
                                    -- upvalues: u3 (ref), beginShooting (copy), reload (copy)
                                    if p182.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                        if p182.KeyCode == Enum.KeyCode.R and u3.canPressKey(p182.KeyCode) then
                                            reload();
                                        end;

                                        return;
                                    end;

                                    if u3.isMouseObstructedByBlackBackground() then
                                        return;
                                    end;

                                    beginShooting(p183);
                                end });
                            CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p184) -- Line: 939
                                    -- upvalues: u6 (ref), Mobile (ref), u122 (ref)
                                    if p184.UserInputType == Enum.UserInputType.MouseButton1 then
                                        u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                        u122 = false;
                                    end;
                                end });
                            CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Gun.Fire, function() -- Line: 945
                                -- upvalues: CharScope (ref), beginShooting (copy), u3 (ref), u6 (ref), Mobile (ref), u122 (ref)
                                CharScope.taskSpawn(beginShooting);
                                u3.mobileInputServiceClick();
                                u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                u122 = false;
                            end));
                            CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Gun.Reload, reload));
                            CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(0.4, function() -- Line: 952
                                -- upvalues: u123 (ref), u3 (ref), Config (copy), CharScope (ref), beginShooting (copy)
                                u123 = false;

                                if u3.isMouseButton1Pressed() and (u3.platform ~= "Mobile" and Config.SHOOT_MODE == 2) then
                                    CharScope.taskSpawn(beginShooting);
                                end;
                            end));
                        end;
                    elseif Config.CATEGORY == "Melee" then
                        if u84 == true then
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 959
                                -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref)
                                u2.keepMobileGuiTypePersistent("Melee", false);

                                if u1.isAiming then
                                    u1.shoulderCam(false);
                                end;

                                u3.activateMouseIcon(false);
                                u2.keepMobileGuiTypePersistent("Aim", false);
                                u6.animationBuffer(Animator, "unload", "MeleeAim", "MeleeAimStabilize", "MeleeSwingLeft", "MeleeSwingRight");
                            end);
                            local u185 = { "MeleeSwingLeft", "MeleeSwingRight" };
                            u2.keepMobileGuiTypePersistent("Melee", true);
                            u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.MeleeAim, PlayerStuff.Items.Animations.MeleeAimStabilize, PlayerStuff.Items.Animations.MeleeSwingLeft, PlayerStuff.Items.Animations.MeleeSwingRight);
                            u86.hitHumanSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "HitHuman");
                            u86.hitSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "Hit");
                            u86.swingSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "Swing");
                            aimSystem({
                                MeleeAimStabilize = 0.7,
                                MeleeAim = 1
                            }, "Dot", nil, nil, true);
                            local u186 = true;
                            CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(0.4, function() -- Line: 972
                                -- upvalues: u186 (ref)
                                u186 = false;
                            end));

                            local function hit(p187) -- Line: 975
                                -- upvalues: u186 (ref), u6 (ref), Config (copy), u83 (ref), u1 (ref), u3 (ref), Ragdoll (ref), Mobile (ref), Animator (ref), u185 (copy), u86 (copy), getProperCameraUnitRay (ref), u19 (ref), LocalPlayer (ref), targetHitIcon (ref), GameRules (ref), PlayerEvent (ref), workspace_CurrentCamera (ref), CharScope (ref), PlayerFunc (ref)
                                if not (u186 or u6.rest("Rest", Config.REST_TIME, u83)) then
                                    if not (u1.isAiming or (p187 or (u3.openedGui or Ragdoll.isActive))) then
                                        u1.shoulderCam(true);
                                        u6.mobileButtonPressed(Mobile.Aim.Aim, true);
                                    end;

                                    if u1.isAiming then
                                        u6.animationBuffer(Animator, "play", u185[math.random(#u185)], 0.1);
                                        u86.swingSound:Play();
                                        local v188 = getProperCameraUnitRay(6);
                                        local u189 = u6.raycastVisible(v188.origin, v188.length, u19, {
                                            character = true
                                        });

                                        if u189 then
                                            local Instance2 = u189.Instance;

                                            local function v195(p190, p191) -- Line: 992
                                                -- upvalues: u6 (ref), LocalPlayer (ref), Config (ref), u3 (ref), u86 (ref), targetHitIcon (ref), u189 (copy), GameRules (ref), Instance2 (copy), PlayerEvent (ref), workspace_CurrentCamera (ref)
                                                if u6.canPenetrate(LocalPlayer, p190, Config) then
                                                    local v192, v193 = u6.canCombat(LocalPlayer, p190, Config.WANTED_COMBAT);

                                                    if u6.typeOf(v192) == "string" then
                                                        if not u6.rest(v193, 60, LocalPlayer) then
                                                            u3.notify({
                                                                message = v192
                                                            });
                                                        end;
                                                    elseif v192 then
                                                        u86.hitHumanSound:Play();
                                                        targetHitIcon(Color3.fromRGB(212, 212, 212));

                                                        if not p191 and Config.DAMAGE > 0 then
                                                            u3.emitBlood(p190, u189.Position);
                                                        end;

                                                        local v194 = GameRules.characterMeshesToBodyParts[Instance2.Name];
                                                        PlayerEvent:FireServer("damage", {
                                                            bodyParts = v194 and {
                                                                { v194, 1 }
                                                            },
                                                            shotCode = { workspace_CurrentCamera.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector },
                                                            pos = u189.Position,
                                                            target = p190,
                                                            bulletProofTool = p191
                                                        });
                                                    end;
                                                end;
                                            end;

                                            if Instance2:IsDescendantOf(workspace.Characters) then
                                                if u6.toolSystem.isTool(Instance2.Parent) then
                                                    local v196 = require(u6.availableItems[Instance2.Parent.Name].Config).BULLET_PROOF_DURABILITY and u6.getPlayerFromCharacter(Instance2.Parent.Parent);

                                                    if v196 then
                                                        v195(v196, Instance2.Parent);
                                                    end;
                                                else
                                                    local PlayerFromCharacter = u6.getPlayerFromCharacter(Instance2.Parent);

                                                    if PlayerFromCharacter then
                                                        v195(PlayerFromCharacter);

                                                        return;
                                                    end;
                                                end;

                                                return;
                                            end;

                                            if Instance2.Parent.Name == "PVPNPC" then
                                                v195(Instance2.Parent);

                                                return;
                                            end;

                                            if Instance2.Name == "_TargetHitIcon" or Instance2.Name == "_TargetHitIconHead" then
                                                targetHitIcon(Instance2.Name == "_TargetHitIcon" and Color3.fromRGB(212, 212, 212) or Color3.fromRGB(255, 137, 97));
                                            elseif Instance2.Parent:GetAttribute("GiveDamageMission") then
                                                CharScope.taskDefer(function() -- Line: 1027
                                                    -- upvalues: PlayerFunc (ref), Instance2 (copy), Config (ref)
                                                    PlayerFunc:InvokeServer("talkToMission", Instance2.Parent, {
                                                        dmg = Config.DAMAGE
                                                    });
                                                end);
                                            end;

                                            u86.hitSound:Play();
                                            local v197 = u6.clone(game.ReplicatedStorage.Gameplay.Weapons.MeleeHit);
                                            v197.CFrame = CFrame.new(u189.Position, u189.Position + u189.Normal);
                                            u6.emit(v197.Smoke, 20);
                                            u6.emit(v197.Impact, 1);
                                            v197.Parent = workspace.Gameplay.Entities;
                                            u6.debrisServiceAddItem(v197, 10);
                                            local v200 = u6.raycastVisible(v188.origin, v188.length, u19, {
                                                customRequirements = function(p198) -- Line: 1037, Name: customRequirements
                                                    -- upvalues: u3 (ref), u189 (copy)
                                                    if p198 then
                                                        local Instance3 = p198.Instance;
                                                        local v199;

                                                        if Instance3.Name == "WheelCollision" then
                                                            v199 = Instance3;
                                                        elseif u3.platform == "Mobile" or u3.platform == "Console" then
                                                            v199 = Instance3.Name == "Rim" and Instance3.Parent.WheelCollision;

                                                            if not v199 then
                                                                if Instance3.Parent.Name == "Rim" then
                                                                    v199 = Instance3.Parent.Parent.Tire.WheelCollision;
                                                                else
                                                                    v199 = false;
                                                                end;
                                                            end;
                                                        else
                                                            v199 = nil;
                                                        end;

                                                        if v199 and (u189.Position - v199.Position).Magnitude < 2 then
                                                            return {
                                                                Instance = v199,
                                                                Position = p198.Position,
                                                                Material = p198.Material,
                                                                Normal = p198.Normal
                                                            };
                                                        end;
                                                    end;
                                                end
                                            });

                                            if v200 then
                                                if v200.Instance.Name == "WheelCollision" and not v200.Instance:GetAttribute("DontPuncture") then
                                                    local Parent = v200.Instance:GetRootPart().Parent;
                                                    local v201 = u6.getVehicleInfo.lastDrove(Parent, true);

                                                    if v201 and v201 ~= LocalPlayer then
                                                        local v202 = u6.canPunctureTire(LocalPlayer, v201);

                                                        if v202 == true then
                                                            if v200.Instance:GetAttribute("Durability") ~= 0 then
                                                                targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                            end;

                                                            PlayerEvent:FireServer("damage", {
                                                                shotCode = { workspace_CurrentCamera.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector },
                                                                pos = v200.Position,
                                                                targetTire = v200.Instance
                                                            });

                                                            return;
                                                        end;

                                                        if not u6.rest((v202 or "combat") .. "Tire", 60, LocalPlayer) then
                                                            u3.notify({
                                                                message = v202 == "policeShootingNonCivilian" and "Cannot puncture non-civilian vehicle" or (v202 == "policeShootingNotWanted" and "Cannot puncture a vehicle of player that is not wanted" or (v202 == "policeShootingCriminalInside" and "Cannot puncture a vehicle of criminal that is inside building" or (v202 == "crewmateCombat" and "Cannot puncture a crew member\'s vehicle" or "Cannot puncture a vehicle of player not in Combat Mode")))
                                                            });
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;

                            CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p203, p204) -- Line: 1066
                                    -- upvalues: u3 (ref), hit (copy)
                                    if p203.UserInputType == Enum.UserInputType.MouseButton1 then
                                        if u3.isMouseObstructedByBlackBackground() then
                                            return;
                                        end;

                                        hit(p204);
                                    end;
                                end });
                            CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Melee.Hit, hit));
                        end;
                    elseif Config.CATEGORY == "Pocket" or Config.CATEGORY == "Jewelry" then
                        if u84 == true then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            actionEvent(function() -- Line: 1078
                                -- upvalues: u6 (ref), u83 (ref), Config (copy), u3 (ref), PlayerEvent (ref), u1 (ref)
                                local v205 = u6.findSlotWithItemId(nil, u83:GetAttribute("Id"));
                                local string_lower_ret = string.lower(Config.CATEGORY);
                                local v206 = u3.inventory[v205];
                                u3.inventory[v205] = nil;

                                if u6.slotMovedInventory(nil, u3.inventory, u3.inventory, v206, {
                                    fromSize = 999,
                                    toSize = 999,
                                    from = v205,
                                    to = string_lower_ret
                                }) == true then
                                    PlayerEvent:FireServer("modifyInventory", {
                                        from = v205,
                                        to = string_lower_ret
                                    });
                                    u1.equipSlot();
                                    u3.notify({
                                        message = "Equipped",
                                        color = "green"
                                    });
                                end;

                                u1.renderInventoryBar();
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1091
                                -- upvalues: u2 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                            end);
                        end;
                    elseif u83.Name == "Medicine" then
                        if u84 == true or u84 == "Vehicle" then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            u86.actionSound = Handle:WaitForChild("ActionSound");
                            local u207 = true;
                            actionEvent(function() -- Line: 1100
                                -- upvalues: u207 (ref), Humanoid (ref), u8 (ref), u6 (ref), u86 (copy), u93 (ref), GameRules (ref), CharScope (ref), Config (copy), PlayerEvent (ref), u3 (ref)
                                if u207 then
                                    if Humanoid.Health < 100 then
                                        if u8:GetAttribute("MedicineUsed") then
                                            u3.notify({
                                                message = "You cannot take another yet",
                                                color = "red"
                                            });

                                            return;
                                        end;

                                        u207 = false;
                                        u6.playSoundReplicate(u86.actionSound);
                                        u6.playAnimation(u93, "play", GameRules.defaultCharacterAnimationFadeTime);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "medicineThread", CharScope.taskDelay(Config.HOLD_DURATION, function() -- Line: 1107
                                            -- upvalues: PlayerEvent (ref), u8 (ref), u6 (ref), u93 (ref), GameRules (ref), u207 (ref)
                                            PlayerEvent:FireServer("medicine", u8);
                                            u6.playAnimation(u93, "stop", GameRules.defaultCharacterAnimationFadeTime);
                                            u207 = true;
                                        end));

                                        return;
                                    end;

                                    u3.notify({
                                        message = "You already have full health",
                                        color = "red"
                                    });
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1116
                                -- upvalues: u2 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                            end);
                        end;
                    elseif u83.Name == "PD Megaphone" then
                        if u84 == true then
                            local ActionSound = u83:WaitForChild("Handle"):WaitForChild("ActionSound");
                            u2.keepMobileGuiTypePersistent("Action", true);
                            local u208 = false;
                            local u209 = 0;
                            u6.setToolGrip(nil, u83);
                            actionEvent(function() -- Line: 1128
                                -- upvalues: u209 (ref), u208 (ref), PlayerEvent (ref), u8 (ref), u6 (ref), u93 (ref), GameRules (ref), u83 (ref), ActionSound (copy)
                                u209 = (u209 + 1) % 1000;
                                u208 = not u208;
                                PlayerEvent:FireServer("megaphoneTool", u8, u208);
                                u6.playAnimation(u93, u208 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                local setToolGrip = u6.setToolGrip;
                                local v210 = u208 and CFrame.new(
                                    -0.0797643661,
                                    -0.262356758,
                                    0.0542488098,
                                    0.86479944,
                                    0.163539141,
                                    -0.474740922,
                                    -0.229441151,
                                    0.969698906,
                                    -0.0839129761,
                                    0.446632087,
                                    0.181492448,
                                    0.876116514
                                );
                                setToolGrip(nil, u83, v210);
                                u6.playSoundReplicate(ActionSound);
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1141
                                -- upvalues: u2 (ref), PlayerEvent (ref), u8 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                                PlayerEvent:FireServer("megaphoneTool", u8, false);
                            end);
                        end;
                    elseif u83.Name == "Driver\'s License" then
                        if u84 == true or u84 == "Vehicle" then
                            local _ = ScreenGui.Center.Middle.DriversLicense;
                            u2.keepMobileGuiTypePersistent("Action", true);
                            local u211 = false;
                            u6.setToolGrip(nil, u83);
                            actionEvent(function() -- Line: 1152
                                -- upvalues: u211 (ref), u6 (ref), u8 (ref), u93 (ref), GameRules (ref), u83 (ref)
                                u211 = not u211;
                                u6.selectiveObjReplicaSystem("driversLicense", u8, u211);
                                u6.playAnimation(u93, u211 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                local setToolGrip = u6.setToolGrip;
                                local v212 = u211 and CFrame.new(
                                    -0.0897827148,
                                    -0.157539845,
                                    0.444522858,
                                    0.859363258,
                                    0.314252466,
                                    -0.403410852,
                                    -0.163115919,
                                    0.916135609,
                                    0.366182953,
                                    0.484652847,
                                    -0.248881757,
                                    0.838552713
                                );
                                setToolGrip(nil, u83, v212);
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1158
                                -- upvalues: u2 (ref), u6 (ref), u8 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                                u6.selectiveObjReplicaSystem("driversLicense", u8, false);
                            end);
                        end;
                    elseif u83.Name == "PD Flashlight" or (u83.Name == "FD Flashlight" or (u83.Name == "MT Flashlight" or u83.Name == "Flashlight")) then
                        if u84 == true then
                            local Handle2 = u83:WaitForChild("Handle");
                            local Light = u83:WaitForChild("Light");
                            local SpotLight = Light:WaitForChild("SpotLight");
                            local On = Handle2:WaitForChild("On");
                            local Off = Handle2:WaitForChild("Off");
                            u2.keepMobileGuiTypePersistent("Action", true);
                            local u213 = 0;
                            local u214 = false;
                            u6.setToolGrip(nil, u83);
                            actionEvent(function() -- Line: 1179
                                -- upvalues: u213 (ref), u214 (ref), Light (copy), SpotLight (copy), PlayerEvent (ref), u8 (ref), u6 (ref), u93 (ref), GameRules (ref), u83 (ref), On (copy), Off (copy), CharScope (ref)
                                u213 = (u213 + 1) % 1000;
                                u214 = not u214;
                                Light.Transparency = u214 and 0 or 1;
                                SpotLight.Enabled = u214;
                                PlayerEvent:FireServer("flashlight", u8, u214);
                                u6.playAnimation(u93, u214 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                local setToolGrip = u6.setToolGrip;
                                local v215 = u214 and CFrame.new(
                                    0.25743866,
                                    -0.0461893082,
                                    -0.0762119293,
                                    -0.819851518,
                                    -0.463403404,
                                    0.336306721,
                                    -0.304887235,
                                    0.850479722,
                                    0.42863512,
                                    -0.484652698,
                                    0.248881668,
                                    -0.838552594
                                );
                                setToolGrip(nil, u83, v215);
                                u6.playSoundReplicate(u214 and On or Off);

                                if u214 then
                                    local u216 = u213;

                                    local function u217() -- Line: 1190
                                        -- upvalues: u216 (copy), u213 (ref)
                                        return u216 == u213;
                                    end;

                                    local u218 = nil;
                                    local u219 = 100;
                                    local u220 = 15;
                                    CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(15, function() -- Line: 454
                                        -- upvalues: u217 (copy), u218 (copy), PlayerEvent (ref), u83 (ref), u219 (copy), u220 (copy)
                                        while not u217 or u217() do
                                            if not u218 or u218() then
                                                PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), u219);
                                            end;

                                            task.wait(u220);
                                        end;
                                    end));
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1193
                                -- upvalues: u2 (ref), Light (copy), SpotLight (copy), PlayerEvent (ref), u8 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                                Light.Transparency = 1;
                                SpotLight.Enabled = false;
                                PlayerEvent:FireServer("flashlight", u8, false);
                            end);
                        end;
                    elseif u83.Name == "Binoculars" or (u83.Name == "PD Binoculars" or (u83.Name == "News Camera" or (u83.Name == "PD Camera" or u83.Name == "Camera"))) then
                        if u84 == true then
                            local u221 = 0;

                            local function loadNewsString() -- Line: 1205
                                -- upvalues: ScreenGui (ref), u83 (ref)
                                ScreenGui.Center.HideGuiBottom.NewsCameraItem.Headline.Text = string.upper(u83:GetAttribute("Headline") or "BREAKING NEWS");
                                ScreenGui.Center.HideGuiBottom.NewsCameraItem.Description.Text = string.upper(u83:GetAttribute("Description") or "BREAKING NEWS IN THE CITY OF SAN AURIE | BROADCASTING LIVE");
                            end;

                            local function disable() -- Line: 1209
                                -- upvalues: u83 (ref), u3 (ref), TweenService (ref), workspace_CurrentCamera (ref), u221 (ref), LocalPlayer (ref), u6 (ref), u2 (ref)
                                if u83.Name == "News Camera" then
                                    u3.hideGui();
                                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                        FieldOfView = u3.initialFOV
                                    }):Play();
                                elseif u83.Name == "Binoculars" or u83.Name == "PD Binoculars" then
                                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                        FieldOfView = u3.initialFOV
                                    }):Play();
                                elseif u83.Name == "Camera" or u83.Name == "PD Camera" then
                                    u3.hideGui();
                                end;

                                u3.mouseIconGui.Visible = true;

                                if u221 > 1 then
                                    LocalPlayer.CameraMaxZoomDistance = u221;
                                    LocalPlayer.CameraMinZoomDistance = u221;
                                end;

                                u6.setCameraProperties("3");
                                u6.toolVisibility(u83, true);
                                u2.setViewModelVisibility(true);
                            end;

                            u2.keepMobileGuiTypePersistent("Action", true);

                            local function activateMain() -- Line: 1229
                                -- upvalues: u221 (ref), HumanoidRootPart (ref), workspace_CurrentCamera (ref), u6 (ref), u83 (ref), u2 (ref), u3 (ref)
                                u221 = (HumanoidRootPart.Position + Vector3.new(0, 1.5, 0) - workspace_CurrentCamera.CFrame.Position).Magnitude;
                                u6.setCameraProperties("3", {
                                    CameraMaxZoomDistance = 0,
                                    CameraMinZoomDistance = 0
                                });
                                u6.toolVisibility(u83, false);
                                u2.setViewModelVisibility(false);
                                u3.mouseIconGui.Visible = false;
                            end;

                            if u83.Name == "News Camera" then
                                u2.keepMobileGuiTypePersistent("NewsCamera", true);
                                loadNewsString();
                                local u222 = u3.readPlayerData("Settings", "ClockFormat");
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1240
                                    -- upvalues: ScreenGui (ref), u6 (ref), u3 (ref), u222 (copy)
                                    while true do
                                        ScreenGui.Center.HideGuiBottom.NewsCameraItem.Time.Text = u6.getClockFormat(u3.clockTime, u222);
                                        task.wait(1);
                                    end;
                                end));
                                local u223 = false;
                                local u224 = 0;
                                advancedInputStateChange(Enum.UserInputType.MouseButton1, Mobile.Action.Action, true, function() -- Line: 1260
                                    -- upvalues: u223 (ref)
                                    return u223;
                                end, function(p225) -- Line: 1249, Name: activate
                                    -- upvalues: u224 (ref), u223 (ref), workspace_CurrentCamera (ref), u3 (ref), Mobile (ref), activateMain (copy), disable (copy)
                                    u224 = (u224 + 1) % 1000;
                                    u223 = p225;
                                    workspace_CurrentCamera.FieldOfView = u3.initialFOV;

                                    if not u223 then
                                        disable();

                                        return;
                                    end;

                                    u3.hideGui("NewsCameraItem", { Mobile });
                                    activateMain();
                                end);

                                local function editText() -- Line: 1261
                                    -- upvalues: u3 (ref), u223 (ref), u6 (ref), Ragdoll (ref), Mobile (ref), CharScope (ref), u83 (ref), loadNewsString (copy)
                                    if u3.canPressKey() and not (u223 or u6.invokeTraffic.cameraEditText) then
                                        if u3.openedGui or Ragdoll.isActive then
                                            return;
                                        end;

                                        u6.mobileButtonPressed(Mobile.NewsCamera.Edit, true);
                                        local v226 = u3.mainBox({
                                            case = "Text",
                                            headline = "Set news headline and description",
                                            textPlaceholder = "Headline ; description",
                                            textCanBeEmpty = true
                                        });
                                        u6.mobileButtonPressed(Mobile.NewsCamera.Edit, false);

                                        if v226 then
                                            local u227, u228 = unpack(string.split(v226, ";"));
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "editText", CharScope.taskSpawn(function() -- Line: 1269
                                                -- upvalues: u227 (copy), u228 (copy), u6 (ref), u83 (ref), loadNewsString (ref)
                                                local v229, v230;

                                                if u227 or u228 then
                                                    v229, v230 = u6.invokeServerTraffic("cameraEditText", u227, u228);
                                                else
                                                    v229 = nil;
                                                    v230 = nil;
                                                end;

                                                if not (v229 and (v229 ~= "" and v229)) then
                                                    v229 = nil;
                                                end;

                                                u83:SetAttribute("Headline", v229);
                                                u83:SetAttribute("Description", v230);
                                                loadNewsString();
                                            end));
                                        end;
                                    end;
                                end;

                                CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p231) -- Line: 1279
                                        -- upvalues: u3 (ref), editText (copy)
                                        if p231.KeyCode == Enum.KeyCode.E and u3.canPressKey(p231.KeyCode) then
                                            editText();
                                        end;
                                    end });
                                CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.NewsCamera.Edit, editText));
                                CharScope.buildSignalData("Tool", { UserInputService.InputChanged, function(p232, p233) -- Line: 1283
                                        -- upvalues: u3 (ref), Ragdoll (ref), u223 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                        if u3.openedGui or (p233 or Ragdoll.isActive) then
                                            return;
                                        end;

                                        if p232.UserInputType == Enum.UserInputType.MouseWheel and u223 then
                                            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p232.Position.Z * -5, 30, 70)
                                            }):Play();
                                        end;
                                    end });
                                local v235 = u6.touchPinch(function(p234) -- Line: 1289
                                    -- upvalues: u3 (ref), Ragdoll (ref), u223 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                    if u3.openedGui or Ragdoll.isActive then
                                        return;
                                    end;

                                    if u223 then
                                        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                            FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p234 * -15, 30, 70)
                                        }):Play();
                                    end;
                                end);
                                CharScope.buildSignalData("Tool", v235.signalData);
                            elseif u83.Name == "Binoculars" or u83.Name == "PD Binoculars" then
                                local u236 = false;
                                advancedInputStateChange(Enum.UserInputType.MouseButton1, Mobile.Action.Action, true, function() -- Line: 1306
                                    -- upvalues: u236 (ref)
                                    return u236;
                                end, function(p237) -- Line: 1298, Name: activate
                                    -- upvalues: u236 (ref), TweenService (ref), workspace_CurrentCamera (ref), activateMain (copy), disable (copy)
                                    u236 = p237;

                                    if not u236 then
                                        disable();

                                        return;
                                    end;

                                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                        FieldOfView = 25
                                    }):Play();
                                    activateMain();
                                end);
                            elseif u83.Name == "PD Camera" or u83.Name == "Camera" then
                                u2.keepMobileGuiTypePersistent("Camera", true);
                                local u238 = false;
                                advancedInputStateChange(Enum.KeyCode.E, Mobile.Camera.Change, true, function() -- Line: 1319
                                    -- upvalues: u238 (ref)
                                    return u238;
                                end, function(p239) -- Line: 1310, Name: activate
                                    -- upvalues: u238 (ref), u3 (ref), Mobile (ref), activateMain (copy), disable (copy)
                                    u238 = p239;

                                    if not u238 then
                                        disable();

                                        return;
                                    end;

                                    u3.hideGui("CameraTool", { Mobile });
                                    activateMain();
                                end);
                                CharScope.buildSignalData("Tool", { UserInputService.InputChanged, function(p240, p241) -- Line: 1320
                                        -- upvalues: u3 (ref), Ragdoll (ref), u238 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                        if u3.openedGui or (p241 or Ragdoll.isActive) then
                                            return;
                                        end;

                                        if p240.UserInputType == Enum.UserInputType.MouseWheel and u238 then
                                            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p240.Position.Z * -5, 30, 70)
                                            }):Play();
                                        end;
                                    end });
                                local v243 = u6.touchPinch(function(p242) -- Line: 1326
                                    -- upvalues: u3 (ref), Ragdoll (ref), u238 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                    if u3.openedGui or Ragdoll.isActive then
                                        return;
                                    end;

                                    if u238 then
                                        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                            FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p242 * -15, 30, 70)
                                        }):Play();
                                    end;
                                end);
                                CharScope.buildSignalData("Tool", v243.signalData);
                                actionEvent(function() -- Line: 1333
                                    -- upvalues: u6 (ref), u238 (ref), u2 (ref)
                                    if not (u6.invokeTraffic.cameraTakePicture or u6.rest("CameraTakePicture", 1.5)) then
                                        u6.invokeServerTraffic("cameraTakePicture");

                                        if u238 then
                                            u2.takePictureEffect();
                                        end;
                                    end;
                                end, Mobile.Action.Action);
                            end;

                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1340
                                -- upvalues: u2 (ref), disable (copy)
                                u2.keepMobileGuiTypePersistent("Action", false);
                                u2.keepMobileGuiTypePersistent("NewsCamera", false);
                                u2.keepMobileGuiTypePersistent("Camera", false);
                                disable();
                            end);
                        end;
                    elseif u83.Name == "PD Tape" then
                        if u84 == true then
                            local u244 = u6.policeTapeMaxLength();
                            u2.keepMobileGuiTypePersistent("Action", true);
                            u86.group = Instance.new("Model");
                            u86.group.Name = "PD Tape";
                            u86.group.Parent = workspace.Gameplay.Entities;
                            CharScope.addEntity(u86.group);
                            PlacePreviewHighlight.Adornee = u86.group;
                            PlacePreviewHighlight.Enabled = true;

                            local function createProp(p245) -- Line: 1357
                                -- upvalues: u6 (ref), u86 (copy), CharScope (ref)
                                local v246 = u6.clone(game.ReplicatedStorage.Gameplay.Items["PD Tape"][p245]);
                                v246.Transparency = 1;

                                for _, child in pairs(v246:GetChildren()) do
                                    if child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                                        child:Destroy();
                                    end;
                                end;

                                v246.Material = Enum.Material.Glass;
                                v246.Parent = u86.group;
                                CharScope.addEntity(v246);

                                return v246;
                            end;

                            u86.pole = createProp("Pole");
                            CharScope.buildSignalData("Tool", { RunService.Heartbeat, function(p247) -- Line: 1367
                                    -- upvalues: u3 (ref), u6 (ref), u19 (ref), u86 (copy), u244 (copy), PlacePreviewHighlight (ref)
                                    local v248 = u3.getMouseProperty.unitRay("FreeSpacePersistent");
                                    local v249 = u6.raycastVisible(v248.Origin, v248.Direction * 25, u19);
                                    local v250 = true;
                                    u86.pole.CFrame = u86.pole.CFrame:Lerp(CFrame.new((v249 and v249.Position or v248.Origin + v248.Direction * 25) + Vector3.new(0, u86.pole.Size.X / 2, 0)) * CFrame.Angles(0, 0, -1.5707963267948966), 1 - 1e-6 ^ p247);

                                    if u86.pole2 then
                                        local v251 = u86.pole.Position - u86.pole2.Position;

                                        if u244 < v251.Magnitude then
                                            v250 = false;
                                        end;

                                        u86.tape.CFrame = CFrame.new((u86.pole.Position + u86.pole2.Position) / 2 + Vector3.new(0, 1, 0), u86.pole2.Position + Vector3.new(0, 1, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);
                                        local Size2 = u86.tape.Size;
                                        u86.tape.Size = Vector3.new(v251.Magnitude, Size2.Y, Size2.Z);
                                    end;

                                    if v250 and v249 then
                                        if u86.pole.Parent ~= u86.group then
                                            PlacePreviewHighlight.Adornee = nil;
                                            u86.pole.Parent = u86.group;
                                            PlacePreviewHighlight.Adornee = u86.group;
                                        end;
                                    elseif u86.pole.Parent ~= workspace.Gameplay.Entities then
                                        PlacePreviewHighlight.Adornee = nil;
                                        u86.pole.Parent = workspace.Gameplay.Entities;
                                        PlacePreviewHighlight.Adornee = u86.group;
                                    end;
                                end });
                            actionEvent(function() -- Line: 1393
                                -- upvalues: u6 (ref), u86 (copy), u83 (ref), Animator (ref), u3 (ref), createProp (copy)
                                if not u6.invokeTraffic.placeItem and u86.pole.Parent == u86.group then
                                    if u86.pole2 then
                                        local v252 = u6.invokeServerTraffic("placeItem", {
                                            place = true,
                                            item = u83.Name,
                                            position = u86.pole.Position,
                                            position2 = u86.pole2.Position,
                                            tapeCFrame = u86.tape.CFrame
                                        });

                                        if u6.typeOf(v252) == "table" then
                                            for i, v in pairs(v252) do
                                                local InstanceReference = u6.getInstanceReference(v, 20);

                                                if InstanceReference then
                                                    if i == 2 then
                                                        u6.animationBuffer(Animator, "play", "PlaceGive");
                                                    end;

                                                    u6.clone(game.ReplicatedStorage.Gameplay.Items.PickUpItem).Parent = InstanceReference;
                                                end;
                                            end;
                                        elseif u6.typeOf(v252) == "string" then
                                            u3.notify({
                                                color = "red",
                                                message = v252
                                            });
                                        end;

                                        u86.pole2:Destroy();
                                        u86.tape:Destroy();
                                        u86.pole2 = nil;
                                        u86.tape = nil;

                                        return;
                                    end;

                                    u86.tape = createProp("Tape");
                                    u86.pole2 = createProp("Pole");
                                    u86.pole2.CFrame = u86.pole.CFrame;
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1421
                                -- upvalues: PlacePreviewHighlight (ref), u2 (ref), u86 (copy)
                                PlacePreviewHighlight.Adornee = nil;
                                PlacePreviewHighlight.Enabled = false;
                                u2.keepMobileGuiTypePersistent("Action", false);

                                for _, v in pairs({ "pole2", "pole", "tape", "group" }) do
                                    if u86[v] and u86[v].Parent then
                                        u86[v]:Destroy();
                                    end;
                                end;
                            end);
                        end;
                    elseif u83.Name == "MT Lifebuoy" or u83.Name == "FD Lifebuoy" then
                        if u84 == true then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            actionEvent(function() -- Line: 1431
                                -- upvalues: u6 (ref), HumanoidRootPart (ref), u83 (ref), Animator (ref), u3 (ref)
                                if not u6.invokeTraffic.placeItem then
                                    local v253 = u6.raycastParamsNew();
                                    v253.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities };
                                    local v254 = u6.raycastVisible(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5 + Vector3.new(0, 5, 0), Vector3.new(-0, -100, -0), v253);

                                    if v254 and v254.Material == Enum.Material.Water then
                                        local _, v255, _ = HumanoidRootPart.CFrame:ToOrientation();
                                        local v256 = u6.invokeServerTraffic("placeItem", {
                                            place = true,
                                            item = u83.Name,
                                            position = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 3.5,
                                            rotation = v255
                                        });

                                        if tonumber(v256) then
                                            local InstanceReference = u6.getInstanceReference(v256, 20);

                                            if InstanceReference then
                                                u6.animationBuffer(Animator, "play", "PlaceGive");
                                                u6.clone(game.ReplicatedStorage.Gameplay.Items.PickUpItem).Parent = InstanceReference.PrimaryPart;
                                            end;
                                        elseif u6.typeOf(v256) == "string" then
                                            u3.notify({
                                                color = "red",
                                                message = v256
                                            });
                                        end;
                                    else
                                        u3.notify({
                                            message = "You must be near the water",
                                            color = "red"
                                        });
                                    end;
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1453
                                -- upvalues: u2 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                            end);
                        end;
                    elseif u83.Name == "MT Cone" or (u83.Name == "FD Cone" or (u83.Name == "PD Cone" or (u83.Name == "FD Ladder" or (u83.Name == "PD Barricade" or (u83.Name == "PD Evidence Marker" or (u83.Name == "PD Spike Strips" or (u83.Name == "RS Cone" or (u83.Name == "RS Roll-Up Sign" or (u83.Name == "RS Traffic Barricade" or u83.Name == "RS Flashing Barricade"))))))))) then
                        if u84 == true then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            local Items = game.ReplicatedStorage.Gameplay.Items;
                            u86.item = u6.clone(Items[u83.Name]);

                            if u83.Name == "RS Flashing Barricade" then
                                u86.item.Light._Blinker.Name = "MeshPart";
                            end;

                            u86.item.Parent = workspace.Gameplay.Entities;
                            CharScope.addEntity(u86.item);

                            for _, descendant in pairs(u86.item:GetDescendants()) do
                                if descendant:IsA("BasePart") then
                                    descendant.CanCollide = false;
                                    descendant.Transparency = 1;

                                    if not descendant:GetAttribute("DontIncludeInHighlight") then
                                        descendant.Material = Enum.Material.Glass;
                                    end;
                                elseif descendant:IsA("SurfaceAppearance") or (descendant:IsA("Texture") or (descendant:IsA("Decal") or descendant:IsA("SurfaceGui"))) then
                                    descendant:Destroy();
                                end;
                            end;

                            local u257 = u6.raycastParamsNew();
                            u257.FilterDescendantsInstances = { workspace.Characters, u86.item };
                            u257.IgnoreWater = true;
                            PlacePreviewHighlight.Adornee = u86.item;
                            local u258 = (Config.HEADING or 0) * 3.141592653589793 / 2;
                            u86.item:PivotTo(CFrame.new(HumanoidRootPart.Position));
                            CharScope.buildSignalData("Tool", { RunService.Heartbeat, function(p259) -- Line: 1489
                                    -- upvalues: u3 (ref), u6 (ref), u257 (copy), HumanoidRootPart (ref), u86 (copy), u258 (copy), PlacePreviewHighlight (ref)
                                    local v260 = u3.getMouseProperty.unitRay("FreeSpacePersistent");
                                    local v261 = u6.raycastVisible(v260.Origin, v260.Direction * 25, u257);
                                    local v262 = v261 and v261.Position or v260.Origin + v260.Direction * 25;
                                    local v263 = HumanoidRootPart.Position - v262;
                                    u86.heading = math.atan2(-v263.Z, v263.X) + u258;
                                    u86.item:PivotTo(u86.item.PrimaryPart.CFrame:Lerp(CFrame.new(v262 + Vector3.new(0, u86.item.PrimaryPart.Size.Y / 2, 0)) * CFrame.Angles(0, u86.heading, 0), 1 - 1e-6 ^ p259));

                                    if PlacePreviewHighlight.Enabled ~= (v261 and true or false) then
                                        PlacePreviewHighlight.Enabled = v261;
                                    end;
                                end });
                            actionEvent(function() -- Line: 1498
                                -- upvalues: u6 (ref), PlacePreviewHighlight (ref), u83 (ref), u86 (copy), Config (copy), Animator (ref), Items (copy), CharScope (ref), u21 (ref), PlayerFunc (ref), u3 (ref)
                                if not u6.invokeTraffic.placeItem and PlacePreviewHighlight.Enabled then
                                    local v264 = u6.invokeServerTraffic("placeItem", {
                                        place = true,
                                        item = u83.Name,
                                        position = u86.item.PrimaryPart.Position,
                                        rotation = u86.heading,
                                        textSequence = Config.TEXT_SEQUENCE
                                    });

                                    if tonumber(v264) then
                                        local InstanceReference = u6.getInstanceReference(v264, 20);

                                        if InstanceReference then
                                            u6.animationBuffer(Animator, "play", "PlaceGive");
                                            u6.clone(Items.PickUpItem).Parent = InstanceReference.PrimaryPart;

                                            if u83.Name == "PD Spike Strips" then
                                                local u265 = {};
                                                CharScope.taskDefer(function() -- Line: 1509
                                                    -- upvalues: InstanceReference (copy), u21 (ref), u265 (copy), CharScope (ref), PlayerFunc (ref)
                                                    while InstanceReference.Parent do
                                                        for _, v in pairs(workspace:GetPartsInPart(InstanceReference.Area, u21)) do
                                                            if v.Name == "WheelCollision" and (v.Transparency == 0 and not u265[v]) then
                                                                u265[v] = true;
                                                                CharScope.taskSpawn(function() -- Line: 1514
                                                                    -- upvalues: PlayerFunc (ref), InstanceReference (ref), v (copy), u265 (ref)
                                                                    PlayerFunc:InvokeServer("spikeStrips", InstanceReference, v);
                                                                    task.wait(10);
                                                                    u265[v] = nil;
                                                                end);
                                                            end;
                                                        end;

                                                        task.wait();
                                                    end;
                                                end);

                                                return;
                                            end;

                                            if u83.Name == "FD Ladder" then
                                                u6.clone(Items.ExpandLadder).Parent = InstanceReference.PrimaryPart;
                                            end;
                                        end;
                                    elseif u6.typeOf(v264) == "string" then
                                        u3.notify({
                                            color = "red",
                                            message = v264
                                        });
                                    end;
                                end;
                            end, Mobile.Action.Action);
                            local u266 = u83.Name == "RS Roll-Up Sign" and "RollUpSign" or (u83.Name == "RS Traffic Barricade" and "TrafficBarricade" or false);

                            if u266 then
                                local ToolWithSelection = ScreenGui.Right.Bottom.ToolWithSelection;

                                for _, child in pairs(ToolWithSelection:GetChildren()) do
                                    if child:IsA("Frame") then
                                        child.Visible = child.Name == u266;
                                    end;
                                end;

                                local function activateButton(p267, p268) -- Line: 1538
                                    -- upvalues: activateButton (copy), Config (copy), ToolWithSelection (copy), u266 (copy), u6 (ref)
                                    if p268 then
                                        activateButton(Config.TEXT_SEQUENCE or "1", false);
                                    end;

                                    ToolWithSelection[u266][p267].ImageColor3 = p268 and Color3.fromRGB(152, 152, 152) or Color3.fromRGB(76, 76, 76);
                                    u6.resetButtonColor(ToolWithSelection[u266][p267], p268);
                                end;

                                for _, child in pairs(ToolWithSelection[u266]:GetChildren()) do
                                    if child:IsA("ImageButton") then
                                        child.ImageColor3 = Color3.fromRGB(76, 76, 76);
                                        CharScope.buildSignalData("Tool", u6.buttonHoverSignalData(child));
                                        CharScope.buildSignalData("Tool", u3.mouseButton(child, function() -- Line: 1547
                                            -- upvalues: activateButton (copy), child (copy), Config (copy)
                                            activateButton(child.Name, true);
                                            local v269;

                                            if child.Name == "1" then
                                                v269 = false;
                                            else
                                                v269 = child.Name;
                                            end;

                                            Config.TEXT_SEQUENCE = v269;
                                        end));
                                    end;
                                end;

                                activateButton(Config.TEXT_SEQUENCE or "1", true);
                                u6.guiTransition(ToolWithSelection, "Position", UDim2.fromScale(0, 0.2), true);
                                ToolWithSelection:SetAttribute("Id", u83:GetAttribute("Id"));
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1556
                                    -- upvalues: ToolWithSelection (copy), u83 (ref), u6 (ref)
                                    if ToolWithSelection:GetAttribute("Id") == u83:GetAttribute("Id") then
                                        u6.guiTransition(ToolWithSelection, "Position", UDim2.fromScale(0, 0.2), false);
                                    end;
                                end);
                            end;

                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1560
                                -- upvalues: PlacePreviewHighlight (ref), u2 (ref), u86 (copy)
                                PlacePreviewHighlight.Adornee = nil;
                                PlacePreviewHighlight.Enabled = false;
                                u2.keepMobileGuiTypePersistent("Action", false);
                                u86.item:Destroy();
                            end);
                        end;
                    elseif u83.Name == "FD Fire Hose" or u83.Name == "FD Fire Extinguisher" then
                        if u84 == true then
                            local Stream = u83:WaitForChild("Stream");
                            u83:WaitForChild("StreamBase");
                            u2.keepMobileGuiTypePersistent("Action", true);
                            u86.streamSound = Handle:WaitForChild("Stream");
                            local u270 = u83.Name == "FD Fire Hose" and 30 or 15;
                            local u271 = u83.Name == "FD Fire Hose" and 1 or 1.2;
                            local u272 = {};
                            local u273 = 0;
                            local u274 = nil;

                            for _, child in pairs(Stream:GetChildren()) do
                                if child.Name == "WaterHitbox" then
                                    table.insert(u272, child);
                                end;
                            end;

                            local u275 = u6.overlapParamsNew();
                            u275.FilterDescendantsInstances = { workspace.Characters, workspace.World };

                            local function u276() -- Line: 1581
                                -- upvalues: mouseDotInteract (ref), Stream (copy), PlayerEvent (ref), u6 (ref), u86 (copy), u273 (ref), u274 (ref)
                                mouseDotInteract(false);

                                if Stream.StreamEmitter.Enabled then
                                    PlayerEvent:FireServer("emitter", Stream.StreamEmitter, false);
                                    Stream.StreamEmitter.Enabled = false;

                                    if Stream:FindFirstChild("StreamEmitter2") then
                                        PlayerEvent:FireServer("emitter", Stream.StreamEmitter2, false);
                                        Stream.StreamEmitter2.Enabled = false;
                                    end;

                                    u6.stopSoundReplicate(u86.streamSound);
                                    u273 = (u273 + 1) % 100;

                                    if u274 then
                                        u274();
                                    end;
                                end;
                            end;

                            if u83.Name == "FD Fire Hose" then
                                u6.animationBuffer(Animator, "load", u83:WaitForChild("Handle"):WaitForChild("RecoilAnimation"), PlayerStuff.Items.Animations.FireHoseAimStabilize, PlayerStuff.Items.Animations.FireHoseAim);
                                local u277 = nil;

                                local function getHoseAttachmentFromVehicle(p278) -- Line: 1598
                                    -- upvalues: HumanoidRootPart (ref), u277 (ref)
                                    if p278 and ((p278._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not p278:GetAttribute("Totaled") and p278._Chassis:FindFirstChild("HoseAttachment"))) then
                                        u277 = p278._Chassis.HoseAttachment;

                                        return true;
                                    end;
                                end;

                                local BelongingVehicle = u6.getVehicleInfo.getBelongingVehicle(LocalPlayer);

                                if BelongingVehicle and ((BelongingVehicle._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not BelongingVehicle:GetAttribute("Totaled") and BelongingVehicle._Chassis:FindFirstChild("HoseAttachment"))) then
                                    u277 = BelongingVehicle._Chassis.HoseAttachment;
                                end;

                                if not u277 then
                                    for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                        local v279;

                                        if child and ((child._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not child:GetAttribute("Totaled") and child._Chassis:FindFirstChild("HoseAttachment"))) then
                                            u277 = child._Chassis.HoseAttachment;
                                            v279 = true;
                                        else
                                            v279 = nil;
                                        end;

                                        if v279 then
                                            break;
                                        end;
                                    end;
                                end;

                                if not u277 then
                                    local v280 = {};

                                    for _, child in pairs(workspace.World.Interactive["Fire Hydrants"]:GetChildren()) do
                                        if u6.areObjectReferencesLoaded(child) then
                                            table.insert(v280, child);
                                        end;
                                    end;

                                    local v281, _, v282 = u6.findClosestFromTable(HumanoidRootPart.Position, v280);

                                    if v281 and v282 < 150 then
                                        u277 = v281.PrimaryPart.HoseAttachment;
                                    end;
                                end;

                                if not u277 then
                                    u3.notify({
                                        message = "You must be near a fire truck or fire hydrant",
                                        color = "red"
                                    });
                                    task.wait(0.1);

                                    return u1.equipSlot();
                                end;

                                PlayerEvent:FireServer("fireHose", u8, u277);
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1622
                                    -- upvalues: u277 (ref), HumanoidRootPart (ref), u1 (ref)
                                    while u277:IsDescendantOf(workspace) and (u277.WorldPosition - HumanoidRootPart.Position).Magnitude <= 150 do
                                        task.wait(2);
                                    end;

                                    return u1.equipSlot();
                                end));
                                aimSystem({
                                    FireHoseAimStabilize = 0.7,
                                    FireHoseAim = 1
                                }, "Dot", function(p283) -- Line: 1628
                                    -- upvalues: u2 (ref), Config (copy), u6 (ref), u83 (ref), u276 (copy)
                                    u2.setCameraRelativeToViewModelPart(p283 and "Item" or "HumanoidRootPart", p283 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                    local setToolGrip = u6.setToolGrip;
                                    local v284;

                                    if p283 then
                                        v284 = CFrame.new(
                                            -0.328115463,
                                            -0.230318069,
                                            -0.182041168,
                                            -0.440460384,
                                            -0.492896318,
                                            -0.750365138,
                                            -0.895676732,
                                            0.184187889,
                                            0.404769063,
                                            -0.0613010079,
                                            0.850369334,
                                            -0.522603214
                                        );
                                    else
                                        v284 = p283;
                                    end;

                                    setToolGrip(nil, u83, v284);

                                    if not p283 then
                                        u276();
                                    end;
                                end);
                            elseif u83.Name == "FD Fire Extinguisher" then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FireExtinguisherAimStabilize, PlayerStuff.Items.Animations.FireExtinguisherAim);
                                aimSystem({
                                    FireExtinguisherAimStabilize = 0.7,
                                    FireExtinguisherAim = 1
                                }, "Dot", function(p285) -- Line: 1635
                                    -- upvalues: u2 (ref), Config (copy), u6 (ref), u83 (ref), u276 (copy)
                                    u2.setCameraRelativeToViewModelPart(p285 and "Item" or "HumanoidRootPart", p285 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                    local setToolGrip = u6.setToolGrip;
                                    local v286;

                                    if p285 then
                                        v286 = CFrame.new(
                                            -0.366176605,
                                            0.0753266811,
                                            0.538593292,
                                            0.211218357,
                                            0.975580156,
                                            -0.0602500141,
                                            -0.919472575,
                                            0.219226077,
                                            0.326358825,
                                            0.331597567,
                                            -0.0135347359,
                                            0.943323851
                                        );
                                    else
                                        v286 = p285;
                                    end;

                                    setToolGrip(nil, u83, v286);

                                    if not p285 then
                                        u276();
                                    end;
                                end);
                            end;

                            actionEvent(function() -- Line: 1641
                                -- upvalues: u1 (ref), mouseDotInteract (ref), u273 (ref), u274 (ref), u83 (ref), CharScope (ref), PlayerEvent (ref), u6 (ref), Handle (copy), Stream (copy), u86 (copy), Animator (ref), aimToolAtMouseHit (ref), u270 (copy), u272 (copy), u275 (copy), PlayerFunc (ref), u271 (copy)
                                if u1.isAiming then
                                    mouseDotInteract(false);
                                    u273 = (u273 + 1) % 100;

                                    if u274 then
                                        u274();
                                    end;

                                    local u287 = u273;

                                    if u83.Name == "FD Fire Extinguisher" then
                                        local function u288() -- Line: 1648
                                            -- upvalues: u273 (ref), u287 (copy)
                                            return u273 == u287;
                                        end;

                                        local u289 = nil;
                                        local u290 = 200;
                                        local u291 = 3;
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(3, function() -- Line: 454
                                            -- upvalues: u288 (copy), u289 (copy), PlayerEvent (ref), u83 (ref), u290 (copy), u291 (copy)
                                            while not u288 or u288() do
                                                if not u289 or u289() then
                                                    PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), u290);
                                                end;

                                                task.wait(u291);
                                            end;
                                        end));
                                        u6.playSoundReplicate(Handle.Start);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireExtinguisherThread", CharScope.taskDelay(0.12, function() -- Line: 1650
                                            -- upvalues: u273 (ref), u287 (copy), Stream (ref), u6 (ref), u86 (ref)
                                            if u273 == u287 and Stream.StreamEmitter.Enabled then
                                                u6.playSoundReplicate(u86.streamSound);
                                            end;
                                        end));
                                    else
                                        u6.animationBuffer(Animator, "play", "RecoilAnimation");
                                        u6.playSoundReplicate(u86.streamSound);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireHoseThread", CharScope.taskDelay(0.09, function() -- Line: 1654
                                            -- upvalues: u273 (ref), u287 (copy), u6 (ref), Animator (ref)
                                            if u273 == u287 then
                                                u6.animationBuffer(Animator, "stop", "RecoilAnimation", 0.3);
                                            end;
                                        end));
                                    end;

                                    PlayerEvent:FireServer("emitter", Stream.StreamEmitter, true);
                                    Stream.StreamEmitter.Enabled = true;

                                    if Stream:FindFirstChild("StreamEmitter2") then
                                        PlayerEvent:FireServer("emitter", Stream.StreamEmitter2, true);
                                        Stream.StreamEmitter2.Enabled = true;
                                    end;

                                    u274 = aimToolAtMouseHit(Stream.AimToolAtMouseHit, u270);
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireExtinguisherThread2", CharScope.taskDelay(0.5, function() -- Line: 1665
                                        -- upvalues: u273 (ref), u287 (copy), u272 (ref), u275 (ref), CharScope (ref), PlayerFunc (ref), mouseDotInteract (ref), u6 (ref), u271 (ref)
                                        while u273 == u287 do
                                            local v292 = 2;
                                            local v293 = {};

                                            for _, v in pairs(u272) do
                                                for _, v2 in pairs(workspace:GetPartsInPart(v, u275)) do
                                                    if v292 > 0 and v2:GetAttribute("Extinguishable") then
                                                        v293[v2] = true;
                                                        v292 = v292 - 1;
                                                    end;
                                                end;
                                            end;

                                            for i, _ in pairs(v293) do
                                                CharScope.taskDefer(function() -- Line: 1674
                                                    -- upvalues: PlayerFunc (ref), i (copy)
                                                    PlayerFunc:InvokeServer("talkToMission", i);
                                                end);
                                            end;

                                            mouseDotInteract(not u6.isTableEmpty(v293));
                                            task.wait(u271);
                                        end;
                                    end));
                                end;
                            end, Mobile.Action.Action);
                            CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p294) -- Line: 1681
                                    -- upvalues: u1 (ref), u276 (copy)
                                    if (p294.UserInputType == Enum.UserInputType.MouseButton1 or p294.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                        u276();
                                    end;
                                end });
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1684
                                -- upvalues: mouseDotInteract (ref), u2 (ref), u1 (ref), u3 (ref), PlayerEvent (ref), Stream (copy), u8 (ref), u83 (ref), u6 (ref), Animator (ref)
                                mouseDotInteract(false);
                                u2.keepMobileGuiTypePersistent("Action", false);

                                if u1.isAiming then
                                    u1.shoulderCam(false);
                                end;

                                u3.activateMouseIcon(false);
                                u2.keepMobileGuiTypePersistent("Aim", false);
                                PlayerEvent:FireServer("emitter", Stream.StreamEmitter, false);
                                Stream.StreamEmitter.Enabled = false;
                                PlayerEvent:FireServer("fireHose", u8);

                                if u83.Name ~= "FD Fire Hose" then
                                    if u83.Name == "FD Fire Extinguisher" then
                                        u6.animationBuffer(Animator, "unload", "FireExtinguisherAimStabilize", "FireExtinguisherAim");
                                    end;

                                    return;
                                end;

                                u6.animationBuffer(Animator, "unload", "RecoilAnimation");
                                u6.animationBuffer(Animator, "unload", "FireHoseAimStabilize", "FireHoseAim");
                            end);
                        end;
                    elseif u83.Name == "FD Chainsaw" or u83.Name == "RS Impact Wrench" then
                        if u84 == true then
                            local u295;

                            if u83.Name == "FD Chainsaw" then
                                u295 = u83:WaitForChild("Hitbox");
                            else
                                u295 = false;
                            end;

                            u2.keepMobileGuiTypePersistent("Action", true);

                            if u83.Name == "FD Chainsaw" then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.ChainsawAim, PlayerStuff.Items.Animations.ChainsawAimStabilize);
                                u86.idleSound = Handle:WaitForChild("Idle");
                                u86.actionSound = Handle:WaitForChild("Action");
                            elseif u83.Name == "RS Impact Wrench" then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.ImpactWrenchAim, PlayerStuff.Items.Animations.ImpactWrenchAimStabilize);
                                u86.beginActionSound = Handle:WaitForChild("BeginAction");
                                u86.actionSound = Handle:WaitForChild("Action");
                            end;

                            local u296 = 0;
                            aimSystem(u83.Name == "FD Chainsaw" and ({
                                ChainsawAimStabilize = 0.7,
                                ChainsawAim = 1
                            } or {
                                ImpactWrenchAimStabilize = 0.7,
                                ImpactWrenchAim = 1
                            }) or {
                                ImpactWrenchAimStabilize = 0.7,
                                ImpactWrenchAim = 1
                            }, "Dot", function(p297) -- Line: 1713
                                -- upvalues: u296 (ref), u86 (copy), u6 (ref), u2 (ref), Config (copy), u83 (ref), u8 (ref), u295 (copy), mouseDotInteract (ref)
                                u296 = (u296 + 1) % 100;

                                if u86.actionSound.IsPlaying then
                                    u6.stopSoundReplicate(u86.actionSound);
                                end;

                                u2.setCameraRelativeToViewModelPart(p297 and "Item" or "HumanoidRootPart", p297 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                if u83.Name == "FD Chainsaw" then
                                    local v298 = u8:GetAttribute("BodyType") == "Blocky" and CFrame.new(
                                        -0.283234596,
                                        -0.181575775,
                                        -0.835891724,
                                        -0.998626828,
                                        -0.0139965154,
                                        -0.0504344888,
                                        -0.0411391072,
                                        -0.385827869,
                                        0.921652734,
                                        -0.0323589668,
                                        0.922462046,
                                        0.384724081
                                    ) or CFrame.new(
                                        -0.0482702255,
                                        -0.17042923,
                                        -0.855205536,
                                        -0.994409204,
                                        -0.0927722752,
                                        -0.0504341833,
                                        -0.0105578285,
                                        -0.387874097,
                                        0.9216519,
                                        -0.105065845,
                                        0.917031646,
                                        0.384726107
                                    );
                                    u6.setToolGrip(nil, u83, p297 and v298);

                                    if u86.idleSound.IsPlaying ~= p297 then
                                        u86.idleSound[p297 and "Play" or "Stop"](u86.idleSound);
                                    end;

                                    if u295.Residue.Enabled then
                                        u295.Residue.Enabled = false;
                                    end;
                                elseif u83.Name == "RS Impact Wrench" then
                                    local setToolGrip = u6.setToolGrip;
                                    local v299;

                                    if p297 then
                                        v299 = CFrame.new(
                                            0.00243377686,
                                            -0.139491081,
                                            0.180562973,
                                            0.5504421,
                                            0.515630841,
                                            -0.656610668,
                                            -0.195514947,
                                            0.844223142,
                                            0.499058872,
                                            0.811657429,
                                            -0.146326333,
                                            0.565510392
                                        );
                                    else
                                        v299 = p297;
                                    end;

                                    setToolGrip(nil, u83, v299);
                                end;

                                if not p297 then
                                    mouseDotInteract(false);
                                end;
                            end);
                            local u300 = u6.overlapParamsNew();
                            u300.FilterDescendantsInstances = { workspace.Characters, workspace.World };
                            actionEvent(function() -- Line: 1729
                                -- upvalues: u1 (ref), u296 (ref), u83 (ref), u6 (ref), u86 (copy), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u295 (copy), u300 (copy), mouseDotInteract (ref), getProperCameraUnitRay (ref), u19 (ref)
                                if u1.isAiming then
                                    local u301 = u296;

                                    if u83.Name == "FD Chainsaw" then
                                        u6.stopSoundReplicate(u86.idleSound);
                                        u6.playSoundReplicate(u86.actionSound);
                                        local u302 = nil;
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "chainsawThread", CharScope.taskDelay(1, function() -- Line: 1737
                                            -- upvalues: u296 (ref), u301 (copy), u302 (ref), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u83 (ref)
                                            while u296 == u301 do
                                                if u302 and u302.Parent then
                                                    CharScope.taskDefer(function() -- Line: 1740
                                                        -- upvalues: PlayerFunc (ref), u302 (ref), PlayerEvent (ref), u83 (ref)
                                                        if PlayerFunc:InvokeServer("talkToMission", u302.Parent, u302) then
                                                            PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), 90);
                                                        end;
                                                    end);
                                                end;

                                                task.wait(1);
                                            end;
                                        end));
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "chainsawThread2", CharScope.taskSpawn(function() -- Line: 1747
                                            -- upvalues: u296 (ref), u301 (copy), u302 (ref), u295 (ref), u300 (ref), mouseDotInteract (ref)
                                            while true do
                                                if u296 ~= u301 then
                                                    mouseDotInteract(false);

                                                    return;
                                                end;

                                                u302 = nil;

                                                for _, v in pairs(workspace:GetPartsInPart(u295, u300)) do
                                                    if v.Name == "ChopArea" then
                                                        u302 = v;
                                                        break;
                                                    end;
                                                end;

                                                if u295.Residue.Enabled ~= (u302 and true or false) then
                                                    u295.Residue.Enabled = u302;
                                                    mouseDotInteract(u302);
                                                end;

                                                task.wait(0.3);
                                            end;
                                        end));

                                        return;
                                    end;

                                    if u83.Name == "RS Impact Wrench" then
                                        u6.playSoundReplicate(u86.beginActionSound);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread2", CharScope.taskDelay(0.12, function() -- Line: 1763
                                            -- upvalues: u296 (ref), u301 (copy), u6 (ref), u86 (ref), CharScope (ref), PlayerEvent (ref), u83 (ref), getProperCameraUnitRay (ref), u19 (ref), mouseDotInteract (ref)
                                            if u296 == u301 then
                                                u6.playSoundReplicate(u86.actionSound);
                                                local u303 = nil;
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread", CharScope.taskDelay(1, function() -- Line: 1767
                                                    -- upvalues: u296 (ref), u301 (ref), u303 (ref), u6 (ref), PlayerEvent (ref), u83 (ref)
                                                    while u296 == u301 do
                                                        if u303 then
                                                            local v304 = (u303:GetAttribute("UnscrewingTire") or 0) + 1;

                                                            if v304 >= 4 then
                                                                local Parent = u303.Parent.Parent.Parent;
                                                                local CFrame2 = u303.Parent.CFrame;
                                                                local u305 = u6.smartUnit(Parent.PrimaryPart.Position - CFrame2.Position):Dot(Parent.PrimaryPart.CFrame.RightVector) > 0;
                                                                local u306 = u6.clone(u303);
                                                                u306.Tire.Rim.CanCollide = true;
                                                                u306.Pivot.Massless = false;
                                                                u306.Pivot.CustomPhysicalProperties = PhysicalProperties.new(12, 0.2, 0.5);
                                                                u306.Parent = workspace.Gameplay.Entities;
                                                                task.delay(0.03, function() -- Line: 1781
                                                                    -- upvalues: u306 (copy), CFrame2 (copy), u305 (copy)
                                                                    u306.Pivot:ApplyImpulse(CFrame2.RightVector * 120 * (u305 and -1 or 1));
                                                                end);
                                                                PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), 40);
                                                                u6.debrisServiceAddItem(u306, 10);
                                                                u6.unscrewVehicleRim(u303, true);
                                                            else
                                                                u303:SetAttribute("UnscrewingTire", v304);
                                                            end;
                                                        end;

                                                        task.wait(1);
                                                    end;
                                                end));
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread3", CharScope.taskSpawn(function() -- Line: 1795
                                                    -- upvalues: u296 (ref), u301 (ref), u303 (ref), getProperCameraUnitRay (ref), u6 (ref), u19 (ref), mouseDotInteract (ref)
                                                    while u296 == u301 do
                                                        u303 = nil;
                                                        local v307 = getProperCameraUnitRay(10);
                                                        local u309 = u6.raycastVisible(v307.origin, v307.length, u19, {
                                                            customRequirements = function(p308) -- Line: 1799, Name: customRequirements
                                                                if p308.Instance.Transparency == 1 then
                                                                    p308 = false;
                                                                end;

                                                                return p308;
                                                            end
                                                        });

                                                        if u309 and u309.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) then
                                                            local AncestorsChild = u6.getAncestorsChild(workspace.Gameplay.Vehicles, u309.Instance);
                                                            local v311 = u6.raycastVisible(v307.origin, v307.length, u19, {
                                                                customRequirements = function(p310) -- Line: 1802, Name: customRequirements
                                                                    -- upvalues: AncestorsChild (copy), u309 (copy)
                                                                    if p310 and (p310.Instance:IsDescendantOf(AncestorsChild.Thrusters) and (u309.Position - p310.Position).Magnitude < 4) then
                                                                        return p310;
                                                                    end;
                                                                end
                                                            });

                                                            if v311 then
                                                                local AncestorsChild2 = u6.getAncestorsChild(AncestorsChild.Thrusters, v311.Instance);

                                                                if AncestorsChild2 and not AncestorsChild2.Parent.Parent:GetAttribute("Totaled") then
                                                                    local WheelCollision = AncestorsChild2.Wheel.Tire.WheelCollision;

                                                                    if AncestorsChild2.Wheel:GetAttribute("UnscrewingTire") ~= true and (not WheelCollision:GetAttribute("DontPuncture") and WheelCollision:GetAttribute("Durability")) then
                                                                        u303 = AncestorsChild2.Wheel;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;

                                                        mouseDotInteract(u303 and true or false);
                                                        task.wait(0.3);
                                                    end;

                                                    mouseDotInteract(false);
                                                end));
                                            end;
                                        end));
                                    end;
                                end;
                            end, Mobile.Action.Action);
                            CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p312) -- Line: 1826
                                    -- upvalues: u1 (ref), u296 (ref), u83 (ref), u6 (ref), u86 (copy), u295 (copy)
                                    if (p312.UserInputType == Enum.UserInputType.MouseButton1 or p312.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                        u296 = (u296 + 1) % 100;

                                        if u83.Name == "FD Chainsaw" then
                                            u6.playSoundReplicate(u86.idleSound);
                                            u6.stopSoundReplicate(u86.actionSound);

                                            if u295.Residue.Enabled then
                                                u295.Residue.Enabled = false;
                                            end;
                                        elseif u83.Name == "RS Impact Wrench" and u86.actionSound.IsPlaying then
                                            u6.stopSoundReplicate(u86.actionSound);
                                        end;
                                    end;
                                end });
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1838
                                -- upvalues: u2 (ref), u1 (ref), u3 (ref), u83 (ref), u6 (ref), Animator (ref), u295 (copy)
                                u2.keepMobileGuiTypePersistent("Action", false);

                                if u1.isAiming then
                                    u1.shoulderCam(false);
                                end;

                                u3.activateMouseIcon(false);
                                u2.keepMobileGuiTypePersistent("Aim", false);

                                if u83.Name == "FD Chainsaw" then
                                    u6.animationBuffer(Animator, "unload", "ChainsawAim", "ChainsawAimStabilize");

                                    if u295.Residue.Enabled then
                                        u295.Residue.Enabled = false;
                                    end;
                                elseif u83.Name == "RS Impact Wrench" then
                                    u6.animationBuffer(Animator, "unload", "ImpactWrenchAim", "ImpactWrenchAimStabilize");
                                end;
                            end);
                        end;
                    elseif u83.Name == "Orange Parachute" or (u83.Name == "Blue Parachute" or u83.Name == "Black Parachute") then
                        if u84 == true then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            actionEvent(function() -- Line: 1852
                                -- upvalues: u6 (ref), HumanoidRootPart (ref), u20 (ref), LocalPlayer (ref), Ragdoll (ref), u8 (ref), PlayerFunc (ref), workspace_CurrentCamera (ref), u2 (ref), u3 (ref)
                                if not u6.invokeTraffic.deployParachute then
                                    if not u6.raycastVisible(HumanoidRootPart.Position, Vector3.new(-0, -15, -0), u20) then
                                        local function clear() -- Line: 1855
                                            -- upvalues: LocalPlayer (ref)
                                            LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;
                                        end;

                                        if Ragdoll.isActive then
                                            Ragdoll.activate(u8, false);
                                        end;

                                        local v313 = u6.invokeServerTraffic("deployParachute", u8);
                                        local v314 = v313 and u6.getInstanceReference(v313, 20);

                                        if v314 then
                                            local v315 = u6.raycastParamsNew();
                                            v315.FilterDescendantsInstances = { u8, v314 };
                                            LocalPlayer.CameraMinZoomDistance = 5;
                                            local AlignOrientation = v314:WaitForChild("_Seat"):WaitForChild("Attachment"):WaitForChild("AlignOrientation");

                                            while v314.Parent do
                                                local LookVector = HumanoidRootPart.CFrame.LookVector;

                                                if u6.raycastVisible(HumanoidRootPart.Position, Vector3.new(-0, -6, -0), v315) or (u6.raycastVisible(HumanoidRootPart.Position, LookVector * 3, v315) or u6.raycastVisible(HumanoidRootPart.Position, LookVector * -3, v315)) then
                                                    LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                                    return PlayerFunc:InvokeServer("deployParachute");
                                                end;

                                                local v316 = workspace_CurrentCamera.CFrame:vectorToObjectSpace(u2.hum.MoveDirection);
                                                local v317, v318, _ = HumanoidRootPart.CFrame:ToOrientation();

                                                if v317 > 0.5 or v317 < -0.5 then
                                                    LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                                    return PlayerFunc:InvokeServer("deployParachute");
                                                end;

                                                AlignOrientation.CFrame = CFrame.new() * CFrame.Angles(0, v318 + (math.abs(v316.X) > 0.1 and (v316.X > 0 and -0.2 or 0.2) or 0), math.abs(v316.X) > 0.1 and (v316.X > 0 and -0.3 or 0.3) or 0);
                                                task.wait();
                                            end;

                                            LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;
                                        end;

                                        LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                        return;
                                    end;

                                    u3.notify({
                                        message = "You must be in the air",
                                        color = "red"
                                    });
                                end;
                            end, Mobile.Action.Action, true);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1894
                                -- upvalues: u2 (ref)
                                u2.keepMobileGuiTypePersistent("Action", false);
                            end);
                        end;
                    elseif u83.Name == "PD Handcuffs" then
                        if u84 == true then
                            local function refreshWantedGui(p319) -- Line: 1901
                                -- upvalues: u3 (ref), u6 (ref), HumanoidRootPart (ref)
                                for i, _ in pairs(u3.nameDisplays) do
                                    local PlayerFromCharacter = u6.getPlayerFromCharacter(i.Parent.Parent);

                                    if PlayerFromCharacter then
                                        local v320;

                                        if p319 or (HumanoidRootPart.Position - i.Parent.Position).Magnitude >= 50 then
                                            v320 = nil;
                                        else
                                            v320 = PlayerFromCharacter:GetAttribute("WantedLevel") or nil;
                                        end;

                                        if v320 ~= i:GetAttribute("GuiWantedLevel") then
                                            i:SetAttribute("GuiWantedLevel", v320);
                                            u3.refreshWantedGui(i.Wanted, v320 or 0);
                                        end;
                                    end;
                                end;
                            end;

                            local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.Handcuffs.MaxActivationDistance;
                            u86.Prompts = {};
                            CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                promptTable = u86.Prompts,

                                promptPreview = function() -- Line: 1919, Name: promptPreview
                                    -- upvalues: u6 (ref)
                                    return u6.clone(game.ReplicatedStorage.Gameplay.Items.Handcuffs);
                                end,

                                getWorkspaceObject = function(p321) -- Line: 1920, Name: getWorkspaceObject
                                    return p321.Character.PrimaryPart;
                                end,

                                update = function(p322, p323) -- Line: 1921, Name: update
                                    -- upvalues: u6 (ref)
                                    local v324 = game.ReplicatedStorage.Gameplay.Items[u6.getVehicleInfo.inVehicle(p323) and "HandcuffsEject" or "Handcuffs"];
                                    p322.ActionText = v324.ActionText;
                                    p322.HoldDuration = v324.HoldDuration;
                                end,

                                getTargets = function() -- Line: 1926, Name: getTargets
                                    -- upvalues: u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), MaxActivationDistance (copy)
                                    local v325 = {};

                                    for _, v in pairs(u6.getLoadedPlayers()) do
                                        if v ~= LocalPlayer and (v.Team and (v.Team.Name ~= "Police" and (v.Team.Name ~= "Medical" and (v.Team.Name ~= "Fire" and (v.Team.Name ~= "Road Service" and (v:GetAttribute("WantedLevel") or u6.isPrivateServerConfigurationSettingEnabled("elevatedPolicePermissions"))))))) and (u6.isCharLoaded(v) and ((v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (not v:GetAttribute("Arrested") and v.Team.Name ~= "Prisoner"))) then
                                            v325[v] = true;
                                        end;
                                    end;

                                    return v325;
                                end
                            }));
                            CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1938
                                -- upvalues: refreshWantedGui (copy)
                                while true do
                                    refreshWantedGui();
                                    task.wait(1);
                                end;
                            end));
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1944
                                -- upvalues: refreshWantedGui (copy)
                                refreshWantedGui(true);
                            end);
                        end;
                    elseif u83.Name == "MT First Aid Kit" or (u83.Name == "MT Bandage" or u83.Name == "FD First Aid Kit") then
                        if u84 == true then
                            u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u83.Name == "MT Bandage" and "BandageSomebody" or "HealingSomebody"], PlayerStuff.Items.Animations[u83.Name == "MT Bandage" and "BandageSomebodyStanding" or "HealingSomebodyStanding"]);
                            local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.MedicKit.MaxActivationDistance;
                            local HoldDuration = game.ReplicatedStorage.Gameplay.Items.MedicKit.HoldDuration;
                            local u326 = u83.Name == "MT Bandage";
                            u86.Prompts = {};
                            CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                promptTable = u86.Prompts,

                                promptPreview = function(p327) -- Line: 1960, Name: promptPreview
                                    -- upvalues: u6 (ref), GameRules (ref)
                                    local v328 = u6.clone(game.ReplicatedStorage.Gameplay.Items.MedicKit);
                                    v328.ActionText = u6.splitCapitalLetters(GameRules.bodyParts[p327.Name]);

                                    return v328;
                                end,

                                update = function(p329, p330) -- Line: 1965, Name: update
                                    -- upvalues: u83 (ref), GameRules (ref), HoldDuration (copy)
                                    if u83.Name == "FD First Aid Kit" or not p330.Parent.Humanoid:GetAttribute(GameRules.bodyParts[p330.Name] .. "_Bleeding") then
                                        local v331 = p330.Parent.Humanoid:GetAttribute(GameRules.bodyParts[p330.Name]) or 1000;
                                        local v332 = math.max(0, v331 - 500) / 500 * 100;
                                        local v333 = math.floor(v332) .. " %";

                                        if p329.ObjectText ~= v333 then
                                            p329.ObjectText = v333;
                                            p329.HoldDuration = math.max(0.1, (1 + (1000 - v331) / 1000 * HoldDuration) * (u83.Name == "MT First Aid Kit" and 1 or 2));
                                        end;
                                    elseif p329.ObjectText ~= "BLEEDING" then
                                        p329.ObjectText = "BLEEDING";
                                        p329.HoldDuration = 3.5;
                                    end;
                                end,

                                getTargets = function() -- Line: 1980, Name: getTargets
                                    -- upvalues: GameRules (ref), u326 (copy), HumanoidRootPart (ref), MaxActivationDistance (copy), u6 (ref), LocalPlayer (ref), u3 (ref)
                                    local u334 = {};

                                    local function addCharacter(p335) -- Line: 1982
                                        -- upvalues: GameRules (ref), u326 (ref), HumanoidRootPart (ref), MaxActivationDistance (ref), u334 (copy)
                                        for i, v in pairs(GameRules.bodyParts) do
                                            local v336;

                                            if u326 then
                                                v336 = v .. "_Bleeding" or v;
                                            else
                                                v336 = v;
                                            end;

                                            if p335.Humanoid:GetAttribute(v336) and (p335[i].Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance then
                                                u334[p335[i]] = true;
                                            end;
                                        end;
                                    end;

                                    for _, v in pairs(u6.getLoadedPlayers()) do
                                        if v ~= LocalPlayer and u6.isCharLoaded(v) then
                                            addCharacter(v.Character);
                                        end;
                                    end;

                                    for i, _ in pairs(u3.healNpcs) do
                                        addCharacter(i);
                                    end;

                                    return u334;
                                end
                            }));
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1995
                                -- upvalues: u6 (ref), Animator (ref), u83 (ref)
                                u6.animationBuffer(Animator, "unload", u83.Name == "MT Bandage" and "BandageSomebody" or "HealingSomebody", u83.Name == "MT Bandage" and "BandageSomebodyStanding" or "HealingSomebodyStanding");
                            end);
                        end;
                    elseif u83.Name == "MT Stretcher" then
                        if u84 == true then
                            local _Seat = u83:WaitForChild("_Seat");
                            u2.firstPersonHeightRestriction = { 0, 0 };
                            u2.setCharRotType("tool", {
                                priority = 1,
                                client = 0,
                                server = 0
                            });
                            local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.Stretcher.MaxActivationDistance;
                            u86.Prompts = {};
                            CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                promptTable = u86.Prompts,

                                promptPreview = function() -- Line: 2015, Name: promptPreview
                                    -- upvalues: u6 (ref)
                                    return u6.clone(game.ReplicatedStorage.Gameplay.Items.Stretcher);
                                end,

                                getWorkspaceObject = function(p337) -- Line: 2016, Name: getWorkspaceObject
                                    return p337.Character.PrimaryPart;
                                end,

                                getTargets = function() -- Line: 2017, Name: getTargets
                                    -- upvalues: u6 (ref), LocalPlayer (ref), _Seat (copy), HumanoidRootPart (ref), MaxActivationDistance (copy)
                                    local v338 = {};

                                    for _, v in pairs(u6.getLoadedPlayers()) do
                                        if v ~= LocalPlayer and (not _Seat:GetAttribute("SeatOccupied") and (u6.isCharLoaded(v, {
                                            isAlive = true
                                        }) and ((v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and not u6.getInstanceAttribute(v, "Seat")))) then
                                            v338[v] = true;
                                        end;
                                    end;

                                    return v338;
                                end
                            }));
                            CharScope.buildSignalData("Tool", { _Seat:GetAttributeChangedSignal("SeatOccupied"), function() -- Line: 2029
                                    -- upvalues: CharScope (ref), _Seat (copy), u6 (ref), u2 (ref)
                                    if CharScope.getConnectionsAndThreads("Tool").putInVehiclePrompt then
                                        CharScope.getConnectionsAndThreads("Tool").putInVehiclePrompt();
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "putInVehiclePrompt", nil);
                                    end;

                                    if _Seat:GetAttribute("SeatOccupied") then
                                        for _, v in pairs(u6.getLoadedPlayers()) do
                                            if u6.getInstanceAttribute(v, "Seat") == _Seat then
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "putInVehiclePrompt", u2.putInVehicleThirdPartyPrompt("Stretcher", v));

                                                return;
                                            end;
                                        end;
                                    end;
                                end });
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2043
                                -- upvalues: u2 (ref)
                                u2.firstPersonHeightRestriction = nil;
                                u2.setCharRotType("tool");
                            end);
                        end;
                    elseif u83.Name == "Lockpick Device" then
                        if u84 == true then
                            local u339 = game.ReplicatedStorage.Gameplay.Items.StealVehicle.MaxActivationDistance + 1;
                            u86.Prompts = {};
                            local u340 = u6.isPrivateServerConfigurationSettingEnabled("realisticVehicleTheft");
                            CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                promptTable = u86.Prompts,

                                promptPreview = function() -- Line: 2057, Name: promptPreview
                                    -- upvalues: u6 (ref)
                                    return u6.clone(game.ReplicatedStorage.Gameplay.Items.StealVehicle);
                                end,

                                getWorkspaceObject = function(p341) -- Line: 2058, Name: getWorkspaceObject
                                    return p341.DriveSeat.Attachment;
                                end,

                                getTargets = function() -- Line: 2059, Name: getTargets
                                    -- upvalues: HumanoidRootPart (ref), u339 (copy), u6 (ref), LocalPlayer (ref), u340 (copy)
                                    local v342 = {};

                                    for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                        if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= u339 then
                                            local v343 = u6.getVehicleInfo.belongsToPlayer(child);
                                            local PlayersWithCanDriveAccess = u6.getVehicleInfo.getPlayersWithCanDriveAccess(child);
                                            local Attribute = child:GetAttribute("OwnerIdBeforeItWasStolen");

                                            if not (child.Config.On.Value or not (v343 or Attribute) or (v343 == LocalPlayer or (Attribute == LocalPlayer.UserId or PlayersWithCanDriveAccess and PlayersWithCanDriveAccess[LocalPlayer]) or (not u340 and u6.getVehicleInfo.getVehicleTeam(child) ~= "Civilian" or (child:GetAttribute("Totaled") or u6.getVehicleInfo.isTowed(child))))) then
                                                v342[child] = true;
                                            end;
                                        end;
                                    end;

                                    return v342;
                                end
                            }));
                        end;
                    elseif u83.Name ~= "PD Shield" then
                        if u83.Name == "Fishing Rod" or u83.Name == "Enhanced Fishing Rod" then
                            if u84 == true then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FishingRodIdleWater, PlayerStuff.Items.Animations.FishingRodPullOut, PlayerStuff.Items.Animations.FishingRodThrow);
                                u2.keepMobileGuiTypePersistent("Action", true);
                                local StartPoint = Handle:WaitForChild("StartPoint");
                                local Splash = Handle:WaitForChild("Splash");
                                local FishingAreas = game.ReplicatedStorage.Gameplay.FishingAreas;
                                local u344 = false;
                                u86.tossed = false;
                                local u345 = {};
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(function() -- Line: 2090
                                    -- upvalues: u345 (copy), FishingAreas (copy), u3 (ref)
                                    while true do
                                        local v346 = false;

                                        for i, _ in pairs(u345) do
                                            if i.Name ~= "ActiveArea" then
                                                u345[i] = nil;
                                                v346 = true;
                                            end;
                                        end;

                                        for _, child in pairs(FishingAreas:GetChildren()) do
                                            if child.Name == "ActiveArea" and not u345[child] then
                                                u345[child] = child.Position;
                                                v346 = true;
                                            end;
                                        end;

                                        if v346 then
                                            u3.createWaypoint({
                                                name = "Fishing Area",
                                                image = "rbxassetid://14075571453",
                                                create = true,
                                                destroyOnDeath = true,
                                                location = u345,
                                                color = Color3.fromRGB(204, 144, 95),
                                                hasRadius = FishingAreas.Area.Size.Y * 5
                                            });
                                        end;

                                        task.wait(1);
                                    end;
                                end));

                                local function actionFunc() -- Line: 2111
                                    -- upvalues: u86 (copy), u2 (ref), CharScope (ref), u6 (ref), u91 (ref), Animator (ref), PlayerFunc (ref), u83 (ref), HumanoidRootPart (ref), FishingAreas (copy), StartPoint (copy), GameRules (ref), u20 (ref), Splash (copy), actionFunc (copy), u344 (ref), u3 (ref)
                                    if u86.tossed then
                                        u2.lockHumanoidState("fishing");
                                    end;

                                    u86.tossed = not u86.tossed;

                                    if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow then
                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow[1]);
                                    end;

                                    if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow2 then
                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow2[1]);
                                    end;

                                    if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow3 then
                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow3[1]);
                                    end;

                                    if not u86.tossed then
                                        u6.playAnimation(u91, "play");
                                        u6.animationBuffer(Animator, "stop", "FishingRodIdleWater");
                                        PlayerFunc:InvokeServer("fishingBait", u83);

                                        return;
                                    end;

                                    local v347 = HumanoidRootPart.CFrame.Position + HumanoidRootPart.CFrame.LookVector * 10;

                                    for _, child in pairs(FishingAreas:GetChildren()) do
                                        if child.Name == "ActiveArea" and (Vector2.new(v347.X, v347.Z) - Vector2.new(child.Position.X, child.Position.Z)).Magnitude <= child.Size.Y * 5 then
                                            local RightVector = StartPoint.WorldCFrame.RightVector;
                                            u2.lockHumanoidState("fishing", 1);
                                            u6.playAnimation(u91, "stop", GameRules.defaultCharacterAnimationFadeTime);
                                            u6.animationBuffer(Animator, "play", "FishingRodIdleWater");
                                            u6.animationBuffer(Animator, "play", "FishingRodThrow");
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow", CharScope.taskDelay(0.85, function() -- Line: 2130
                                                -- upvalues: PlayerFunc (ref), u83 (ref), u6 (ref), u20 (ref), CharScope (ref), Splash (ref), StartPoint (ref), RightVector (copy), HumanoidRootPart (ref), actionFunc (ref), u344 (ref), Animator (ref), u3 (ref), u91 (ref), GameRules (ref)
                                                local v348 = PlayerFunc:InvokeServer("fishingBait", u83, true);
                                                local u349 = v348 and u6.getInstanceReference(v348, 20);

                                                if not u349 then
                                                    return;
                                                end;

                                                local function isBaitInWater() -- Line: 2135
                                                    -- upvalues: u6 (ref), u349 (copy), u20 (ref)
                                                    local v350 = u6.raycastVisible(u349.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                    if v350 and (v350.Instance == workspace.Terrain and v350.Material == Enum.Material.Water) then
                                                        return v350;
                                                    end;
                                                end;

                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow2", CharScope.taskDefer(function() -- Line: 2139
                                                    -- upvalues: u349 (copy), u6 (ref), u20 (ref), Splash (ref)
                                                    while u349.Parent do
                                                        local v351 = u6.raycastVisible(u349.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                        if not (v351 and (v351.Instance == workspace.Terrain and v351.Material == Enum.Material.Water)) then
                                                            v351 = nil;
                                                        end;

                                                        if v351 then
                                                            return u6.playSoundReplicate(Splash);
                                                        end;

                                                        task.wait(0.25);
                                                    end;
                                                end));
                                                u349:PivotTo(CFrame.new(StartPoint.WorldPosition));
                                                u349.PrimaryPart:ApplyImpulse(RightVector * 5);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow3", CharScope.taskDefer(function() -- Line: 2147
                                                    -- upvalues: u349 (copy), HumanoidRootPart (ref), actionFunc (ref)
                                                    while u349.Parent do
                                                        if (u349.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude > 150 then
                                                            return actionFunc();
                                                        end;

                                                        task.wait(2);
                                                    end;
                                                end));

                                                while true do
                                                    local math_random_ret = math.random(3, 12);

                                                    for i = 1, math_random_ret do
                                                        if not u349.Parent then
                                                            return;
                                                        end;

                                                        local v352 = u6.raycastVisible(u349.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                        if not (v352 and (v352.Instance == workspace.Terrain and v352.Material == Enum.Material.Water)) then
                                                            v352 = nil;
                                                        end;

                                                        if not v352 then
                                                            task.wait(3);
                                                        end;

                                                        if i == math_random_ret then
                                                            u344 = true;
                                                            u6.animationBuffer(Animator, "play", "FishingRodPullOut");
                                                            local v353 = PlayerFunc:InvokeServer("catchFish");

                                                            if v353 and u3.questFunctions.catchFish then
                                                                u3.questFunctions.catchFish(v353);
                                                            end;

                                                            u6.animationBuffer(Animator, "stop", "FishingRodPullOut");
                                                            u6.animationBuffer(Animator, "stop", "FishingRodIdleWater");
                                                            u6.playAnimation(u91, "play", GameRules.defaultCharacterAnimationFadeTime);
                                                            u344 = false;
                                                            actionFunc();

                                                            return;
                                                        end;

                                                        task.wait(3);
                                                        local _ = i;
                                                    end;
                                                end;
                                            end));

                                            return;
                                        end;
                                    end;

                                    u86.tossed = false;
                                    u3.notify({
                                        message = "There is no fish here",
                                        color = "red"
                                    });
                                end;

                                actionEvent(function() -- Line: 2187
                                    -- upvalues: u6 (ref), u344 (ref), actionFunc (copy)
                                    if u6.rest("Toss", 1) or u344 then
                                        return;
                                    end;

                                    actionFunc();
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2191
                                    -- upvalues: u6 (ref), Animator (ref), u2 (ref), u3 (ref), u86 (copy), PlayerFunc (ref), u83 (ref)
                                    u6.animationBuffer(Animator, "unload", "FishingRodIdleWater", "FishingRodPullOut", "FishingRodThrow");
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                    u3.createWaypoint({
                                        name = "Fishing Area"
                                    });

                                    if u86.tossed then
                                        u2.lockHumanoidState("fishing");
                                        task.spawn(function() -- Line: 2197
                                            -- upvalues: PlayerFunc (ref), u83 (ref)
                                            PlayerFunc:InvokeServer("fishingBait", u83);
                                        end);
                                    end;
                                end);
                            end;
                        elseif u83.Name == "PD Ticket Clipboard" then
                            if u84 == true then
                                local u354 = game.ReplicatedStorage.Gameplay.Items.TicketClipboard.MaxActivationDistance + 1;
                                u86.Prompts = {};
                                CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                    promptTable = u86.Prompts,

                                    promptPreview = function() -- Line: 2208, Name: promptPreview
                                        -- upvalues: u6 (ref)
                                        return u6.clone(game.ReplicatedStorage.Gameplay.Items.TicketClipboard);
                                    end,

                                    getWorkspaceObject = function(p355) -- Line: 2209, Name: getWorkspaceObject
                                        return p355.Character.PrimaryPart;
                                    end,

                                    getTargets = function() -- Line: 2210, Name: getTargets
                                        -- upvalues: u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u354 (copy)
                                        local v356 = {};

                                        for _, v in pairs(u6.getLoadedPlayers()) do
                                            if v ~= LocalPlayer and (u6.isCharLoaded(v, {
                                                isAlive = true
                                            }) and (v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= u354) then
                                                v356[v] = true;
                                            end;
                                        end;

                                        return v356;
                                    end
                                }));
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2221
                                    -- upvalues: u2 (ref)
                                    u2.citation();
                                end);
                            end;
                        elseif u83.Name == "PD Speed Radar" then
                            if u84 == true then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.HandgunAimStabilize, PlayerStuff.Items.Animations.HandgunAim);
                                u6.guiTransition(SpeedRadar, "Position", UDim2.fromScale(0, 0.2), true);
                                SpeedRadar:SetAttribute("Id", u83:GetAttribute("Id"));
                                local u357 = false;
                                local v358 = u3.readPlayerData("Settings", "SpeedUnit");
                                local u359 = v358 and GameRules.mphToKmh or 1;
                                SpeedRadar.SpeedLimitText.Text = v358 and "KMH" or "MPH";
                                SpeedRadar.VehicleSpeedText.Text = v358 and "KMH" or "MPH";
                                local u360 = nil;
                                u360 = u3.recordSpeed(true, SpeedRadar.VehicleSpeed, function() -- Line: 2239
                                    -- upvalues: SpeedRadar (ref)
                                    SpeedRadar.VehicleSpeed.TextColor3 = Color3.fromRGB(0, 255, 17);
                                    SpeedRadar.VehicleSpeedText.TextColor3 = Color3.fromRGB(0, 255, 17);
                                    SpeedRadar.VehicleSpeed.TextTransparency = 0;
                                    SpeedRadar.VehicleSpeedText.TextTransparency = 0;
                                end, function() -- Line: 2245
                                    -- upvalues: SpeedRadar (ref), u357 (ref), CharScope (ref), u360 (ref)
                                    SpeedRadar.VehicleSpeed.TextColor3 = Color3.fromRGB(255, 0, 0);
                                    SpeedRadar.VehicleSpeedText.TextColor3 = Color3.fromRGB(255, 0, 0);

                                    if not u357 then
                                        local u361 = false;
                                        u357 = true;
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "speedRadarThread", CharScope.taskDefer(function() -- Line: 2251
                                            -- upvalues: u360 (ref), u361 (ref), SpeedRadar (ref), u357 (ref)
                                            while u360.overSpeedLimit do
                                                u361 = not u361;
                                                SpeedRadar.VehicleSpeed.TextTransparency = u361 and 0 or 1;
                                                SpeedRadar.VehicleSpeedText.TextTransparency = u361 and 0 or 1;
                                                task.wait(u361 and 1 or 0.5);
                                            end;

                                            u357 = false;
                                        end));
                                    end;
                                end, function() -- Line: 2262
                                    -- upvalues: SpeedRadar (ref), u360 (ref), u359 (copy)
                                    SpeedRadar.SpeedLimit.Text = u360.speedLimit and math.round(u360.speedLimit * u359) or "--";
                                end);
                                CharScope.addThreadOrCleanUpFunction("Tool", u360.cleanUp);
                                local u362 = 0;
                                aimSystem({
                                    HandgunAimStabilize = 0.7,
                                    HandgunAim = 1
                                }, "SpeedRadar", function(p363) -- Line: 2268
                                    -- upvalues: u6 (ref), u83 (ref), Config (copy), u2 (ref), u362 (ref)
                                    local v364;

                                    if p363 then
                                        v364 = Config.AIM_GRIP;
                                    else
                                        v364 = p363;
                                    end;

                                    u6.setToolGrip(nil, u83, v364);
                                    u2.setCameraRelativeToViewModelPart(p363 and "Item" or "HumanoidRootPart", p363 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                    u362 = (u362 + 1) % 1000;
                                end, Mobile.Action.Action);
                                CharScope.buildSignalData("Tool", { RunService.Heartbeat, function() -- Line: 2275
                                        -- upvalues: u1 (ref), getProperCameraUnitRay (ref), u6 (ref), u19 (ref), u360 (ref), SpeedRadar (ref)
                                        if u1.isAiming then
                                            local v365 = getProperCameraUnitRay(1000);
                                            local v366 = u6.raycastVisible(v365.origin, v365.length, u19);

                                            if v366 then
                                                local v367 = v366.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) and u6.getAncestorsChild(workspace.Gameplay.Vehicles, v366.Instance);
                                                u360.update(v367, v366.Position);

                                                if not (v367 or u360.overSpeedLimit) then
                                                    SpeedRadar.VehicleSpeed.Text = "--";
                                                end;
                                            elseif not u360.overSpeedLimit then
                                                SpeedRadar.SpeedLimit.Text = "--";
                                                u360.lastPos = Vector3.new();
                                            end;
                                        elseif not u360.overSpeedLimit then
                                            SpeedRadar.SpeedLimit.Text = "--";
                                            SpeedRadar.VehicleSpeed.Text = "--";
                                        end;
                                    end });
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2289
                                    -- upvalues: SpeedRadar (ref), u83 (ref), u6 (ref), Mobile (ref), u1 (ref), u3 (ref), u2 (ref), Animator (ref)
                                    if SpeedRadar:GetAttribute("Id") == u83:GetAttribute("Id") then
                                        u6.guiTransition(SpeedRadar, "Position", UDim2.fromScale(0, 0.2), false);
                                    end;

                                    local Action = Mobile.Action.Action;

                                    if u1.isAiming then
                                        u1.shoulderCam(false);
                                    end;

                                    u3.activateMouseIcon(false);
                                    u2.keepMobileGuiTypePersistent(Action and Action.Name or "Aim", false);
                                    u6.animationBuffer(Animator, "unload", "HandgunAimStabilize", "HandgunAim");
                                end);
                            end;
                        elseif u83.Name == "Metal Detector" then
                            if u84 == true then
                                local MetalDetector = ScreenGui.Right.Bottom.MetalDetector;
                                local Beep = Handle:WaitForChild("Beep");
                                u6.guiTransition(MetalDetector, "Position", UDim2.fromScale(0, 0.2), true);
                                MetalDetector:SetAttribute("Id", u83:GetAttribute("Id"));
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(metalDetectorPointsUpdateListener));
                                local u368 = 3.1;
                                local u369 = 0;

                                local function beepSound() -- Line: 2304
                                    -- upvalues: u369 (ref), u6 (ref), Beep (copy), MetalDetector (copy), TweenService (ref), u368 (ref)
                                    u369 = (u369 + 1) % 100;

                                    while u369 == u369 do
                                        u6.playSoundReplicate(Beep);
                                        MetalDetector.ImageLabel.Signal.ImageTransparency = 0;
                                        TweenService:Create(MetalDetector.ImageLabel.Signal, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ImageTransparency = 1
                                        }):Play();
                                        task.wait(u368);
                                    end;
                                end;

                                local u370 = nil;
                                local u371 = nil;
                                local u372 = 130;
                                local u373 = 15;
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(15, function() -- Line: 454
                                    -- upvalues: u370 (copy), u371 (copy), PlayerEvent (ref), u83 (ref), u372 (copy), u373 (copy)
                                    while not u370 or u370() do
                                        if not u371 or u371() then
                                            PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), u372);
                                        end;

                                        task.wait(u373);
                                    end;
                                end));
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 2315
                                    -- upvalues: u3 (ref), HumanoidRootPart (ref), u368 (ref), MetalDetector (copy), CharScope (ref), beepSound (copy)
                                    while true do
                                        local v374 = 50;
                                        local v375 = nil;

                                        for i, v in pairs(u3.metalDetectorPoints or {}) do
                                            if (v - HumanoidRootPart.Position).Magnitude < v374 then
                                                v374 = (v - HumanoidRootPart.Position).Magnitude;
                                                v375 = i;
                                            end;
                                        end;

                                        local v376 = v375 and (v374 < 8 and 0.25 or (v374 < 28 and 0.5 or 1)) or 3;

                                        if v376 ~= u368 then
                                            MetalDetector.ImageLabel.Signal.ImageColor3 = v374 < 8 and Color3.fromRGB(96, 217, 75) or v374 < 28 and Color3.fromRGB(212, 183, 65) or (v375 and Color3.fromRGB(150, 129, 46) or Color3.fromRGB(129, 129, 129));
                                            MetalDetector.ImageLabel.TextLabel.Text = v374 < 8 and "Found!" or (v375 and "Nearby" or "Clear");

                                            if v376 < u368 then
                                                u368 = v376;
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "metalDetectorThread", CharScope.taskSpawn(beepSound));
                                            end;
                                        end;

                                        u368 = v376;
                                        task.wait(1);
                                    end;
                                end));
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2338
                                    -- upvalues: MetalDetector (copy), u83 (ref), u6 (ref)
                                    if MetalDetector:GetAttribute("Id") == u83:GetAttribute("Id") then
                                        u6.guiTransition(MetalDetector, "Position", UDim2.fromScale(0, 0.2), false);
                                    end;
                                end);
                            end;
                        elseif u83.Name == "Repair Kit" or u83.Name == "RS Repair Kit" then
                            if u84 == true then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FixingVehicle);
                                local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items[u83.Name == "Repair Kit" and "RepairKit" or "RSRepairKit"].MaxActivationDistance;
                                u86.Prompts = {};
                                CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                    promptTable = u86.Prompts,

                                    promptPreview = function() -- Line: 2350, Name: promptPreview
                                        -- upvalues: u6 (ref)
                                        return u6.clone(game.ReplicatedStorage.Gameplay.Items.RepairKit);
                                    end,

                                    getWorkspaceObject = function(p377) -- Line: 2351, Name: getWorkspaceObject
                                        return p377._Chassis.HoodPart;
                                    end,

                                    getTargets = function() -- Line: 2352, Name: getTargets
                                        -- upvalues: HumanoidRootPart (ref), MaxActivationDistance (copy)
                                        local v378 = {};

                                        for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                            if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (child.Config.Durability.Value > 0 and child.Config.Durability.Value < require(child.Config).MAX_DURABILITY) then
                                                v378[child] = true;
                                            end;
                                        end;

                                        return v378;
                                    end
                                }));
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2363
                                    -- upvalues: u6 (ref), Animator (ref)
                                    u6.animationBuffer(Animator, "unload", "FixingVehicle");
                                end);
                            end;
                        elseif u83.Name == "RS Fuel Can" then
                            if u84 == true then
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FuelCanAction);
                                local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.FuelCan.MaxActivationDistance;
                                u86.Prompts = {};
                                CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                    promptTable = u86.Prompts,

                                    promptPreview = function() -- Line: 2375, Name: promptPreview
                                        -- upvalues: u6 (ref)
                                        return u6.clone(game.ReplicatedStorage.Gameplay.Items.FuelCan);
                                    end,

                                    getWorkspaceObject = function(p379) -- Line: 2376, Name: getWorkspaceObject
                                        return p379._Chassis.VisualCenter;
                                    end,

                                    getTargets = function() -- Line: 2377, Name: getTargets
                                        -- upvalues: HumanoidRootPart (ref), MaxActivationDistance (copy)
                                        local v380 = {};

                                        for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                            if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (child.Config.Durability.Value > 0 and child.Config.Fuel.Value < require(child.Config).MAX_FUEL) then
                                                v380[child] = true;
                                            end;
                                        end;

                                        return v380;
                                    end
                                }));
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2388
                                    -- upvalues: u6 (ref), Animator (ref)
                                    u6.animationBuffer(Animator, "unload", "FuelCanAction");
                                end);
                            end;
                        elseif u83.Name == "RS Traffic Paddle" then
                            if u84 == true then
                                u83:WaitForChild("Weld");
                                u2.keepMobileGuiTypePersistent("Action", true);
                                actionEvent(function() -- Line: 2396
                                    -- upvalues: u6 (ref), u83 (ref), PlayerFunc (ref), u8 (ref)
                                    if not u6.rest("PaddleSwitch", 0.6, u83) then
                                        PlayerFunc:InvokeServer("trafficPaddle", u8);
                                    end;
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2399
                                    -- upvalues: u2 (ref)
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                end);
                            end;
                        elseif u83.Name == "Trowel" then
                            if u84 == true then
                                u2.keepMobileGuiTypePersistent("Action", true);
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(metalDetectorPointsUpdateListener));
                                actionEvent(function() -- Line: 2407
                                    -- upvalues: u6 (ref), u2 (ref), u93 (ref), GameRules (ref), CharScope (ref), u3 (ref), HumanoidRootPart (ref)
                                    if not u6.rest("Trowel", 5) then
                                        u2.lockHumanoidState("trowel", -1);
                                        u6.playAnimation(u93, "play", GameRules.defaultCharacterAnimationFadeTime);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "trowelThread", CharScope.taskDelay(5, function() -- Line: 2413
                                            -- upvalues: u2 (ref), u6 (ref), u93 (ref), GameRules (ref), u3 (ref), HumanoidRootPart (ref)
                                            u2.lockHumanoidState("trowel");
                                            u6.playAnimation(u93, "stop", GameRules.defaultCharacterAnimationFadeTime);

                                            for i, v in pairs(u3.metalDetectorPoints or {}) do
                                                if (v - HumanoidRootPart.Position).Magnitude < 8 and not u6.invokeTraffic.metalDetectorFinding then
                                                    local v381, _, v382 = u6.invokeServerTraffic("metalDetectorFinding", i);

                                                    if v381 then
                                                        if u3.questFunctions.metalDetectorFinding then
                                                            u3.questFunctions.metalDetectorFinding(v382);
                                                        end;

                                                        table.remove(u3.metalDetectorPoints, i);
                                                        u3.notify({
                                                            color = "green",
                                                            message = v381
                                                        });

                                                        return;
                                                    end;
                                                end;
                                            end;

                                            u3.notify({
                                                message = "There is nothing here",
                                                color = "red"
                                            });
                                        end));
                                    end;
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2433
                                    -- upvalues: u2 (ref)
                                    u2.lockHumanoidState("trowel");
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                end);
                            end;
                        elseif u83.Name == "Crew Graffiti" then
                            if u84 == true then
                                local ActionSound = Handle:WaitForChild("ActionSound");
                                local SprayEmitter = u83:WaitForChild("Handle"):WaitForChild("Attachment"):WaitForChild("SprayEmitter");

                                local function u383() -- Line: 2467
                                    -- upvalues: u2 (ref), u6 (ref), ActionSound (copy), PlayerEvent (ref), SprayEmitter (copy)
                                    u2.lockHumanoidState("graffiti", false);
                                    u2.rotateTowards();
                                    u6.stopSoundReplicate(ActionSound);
                                    u6.animationBuffer(u2.animator, "stop", "Graffiti");
                                    PlayerEvent:FireServer("emitter", SprayEmitter, false);
                                    u2.displayBottomBarMessage("graffiti");
                                end;

                                u2.keepMobileGuiTypePersistent("Action", true);
                                local u384 = false;
                                u6.setToolGrip(nil, u83);
                                actionEvent(function() -- Line: 2478
                                    -- upvalues: u384 (ref), u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u3 (ref), PlayerEvent (ref), SprayEmitter (copy), u83 (ref), u2 (ref), ActionSound (copy), CharScope (ref), u383 (copy)
                                    if u384 then
                                        return;
                                    end;

                                    u384 = true;

                                    if u6.getInstanceAttribute(LocalPlayer, "Crew") then
                                        local v385 = u6.raycastParamsNew();
                                        v385.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay, workspace.Terrain };
                                        v385.IgnoreWater = true;
                                        local v386 = u6.raycastVisible(HumanoidRootPart.Position + Vector3.new(0, 2, 0), HumanoidRootPart.CFrame.LookVector * 7, v385);

                                        if v386 then
                                            local CFrame_new_ret = CFrame.new(v386.Position, v386.Position + v386.Normal);

                                            for _, v in pairs({ -1, 1 }) do
                                                local v387 = CFrame_new_ret * CFrame.new(game.ReplicatedStorage.Gameplay.Crews.Graffiti.Size.X / 2 * v, game.ReplicatedStorage.Gameplay.Crews.Graffiti.Size.Y / 2 * v, -0.2);

                                                if not u6.raycastVisible(v387.Position, v387.LookVector * -1, v385) then
                                                    u384 = false;
                                                    u3.notify({
                                                        message = "Not enough space",
                                                        color = "red"
                                                    });

                                                    return;
                                                end;
                                            end;

                                            PlayerEvent:FireServer("emitter", SprayEmitter, true);
                                            u6.setToolGrip(nil, u83, CFrame.new(
                                                -0.182678223,
                                                -0.183644533,
                                                -0.105064392,
                                                -0.752559543,
                                                0.652841926,
                                                -0.0863215253,
                                                0.634098411,
                                                0.753763199,
                                                0.172511384,
                                                0.177688628,
                                                0.0750888065,
                                                -0.981217861
                                            ));
                                            u6.animationBuffer(u2.animator, "play", "Graffiti");
                                            u2.lockHumanoidState("graffiti", -1);
                                            u2.rotateTowards(CFrame_new_ret.Position);
                                            u6.playSoundReplicate(ActionSound);
                                            u2.displayBottomBarMessage("graffiti", 10, nil, 12, Color3.fromRGB(190, 106, 106));
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "crewGraffitiThread", CharScope.taskDelay(12, function() -- Line: 2500
                                                -- upvalues: u6 (ref), CFrame_new_ret (copy), u3 (ref), u83 (ref), u383 (ref), u384 (ref)
                                                local v388 = u6.invokeServerTraffic("crewGraffiti", CFrame_new_ret);

                                                if u6.typeOf(v388) == "string" then
                                                    u3.notify({
                                                        color = "red",
                                                        message = v388
                                                    });
                                                end;

                                                u6.setToolGrip(nil, u83);
                                                u383();
                                                u384 = false;
                                            end));

                                            return;
                                        end;

                                        u3.notify({
                                            message = "You must face a wall",
                                            color = "red"
                                        });
                                    else
                                        u3.notify({
                                            message = "You have to be in a crew to do that",
                                            color = "red"
                                        });
                                    end;

                                    u384 = false;
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2512
                                    -- upvalues: u383 (copy), u2 (ref)
                                    u383();
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                end);
                            end;
                        elseif u83.Name == "PD Notepad" or (u83.Name == "FD Notepad" or (u83.Name == "MT Notepad" or u83.Name == "RS Notepad")) then
                            if u84 == true or u84 == "Vehicle" then
                                Notepad:TweenPosition(UDim2.fromScale(0, 0), "Out", "Quint", 0.6, true);

                                if not u3.notepadContent then
                                    u3.notepadContent = {};

                                    for i, v in pairs(u6.deepCopyTable(u3.readPlayerData("Notepad"))) do
                                        u3.notepadContent[i] = u6.decodeHex(v);
                                    end;
                                end;

                                Notepad:SetAttribute("Id", u83:GetAttribute("Id"));
                                local u389 = u6.textBoxSystem(Notepad.TextBoxFrame);
                                CharScope.buildSignalData("Tool", unpack(u389.multipleSignalData));
                                CharScope.addThreadOrCleanUpFunction("Tool", u389.cleanUp);
                                CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Paper, function() -- Line: 2528
                                    -- upvalues: u389 (copy)
                                    u389.captureFocus();
                                end));

                                local function changePage(p390) -- Line: 2531
                                    -- upvalues: u86 (copy), Notepad (ref), u3 (ref)
                                    local v391 = u86.page or 1;
                                    u86.page = math.clamp(v391 + p390, 1, 10);

                                    if u86.page ~= v391 then
                                        game.SoundService.NotepadPage:Play();
                                    end;

                                    Notepad.TextBoxFrame.TextBox.Text = u3.notepadContent[tostring(u86.page or 1)] or "";
                                    Notepad.Page.Text = u86.page;
                                    Notepad.Back.Visible = u86.page > 1;
                                    Notepad.Next.Visible = u86.page < 10;
                                end;

                                changePage(0);
                                CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Next, function() -- Line: 2541
                                    -- upvalues: changePage (copy)
                                    changePage(1);
                                end));
                                CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Back, function() -- Line: 2542
                                    -- upvalues: changePage (copy)
                                    changePage(-1);
                                end));

                                local function updateText() -- Line: 2543
                                    -- upvalues: Notepad (ref), u6 (ref), u3 (ref), u86 (copy)
                                    Notepad.TextBoxFrame.TextBox.Size = UDim2.fromScale(Notepad.TextBoxFrame.TextBox.Size.X.Scale, 0.06666666666666667);
                                    local CursorPosition = Notepad.TextBoxFrame.TextBox.CursorPosition;
                                    local _, _ = u6.fitText(Notepad.TextBoxFrame.TextBox, Notepad.TextBoxFrame.TextBox.Text, 10);
                                    u3.notepadContent[tostring(u86.page or 1)] = Notepad.TextBoxFrame.TextBox.Text;
                                    Notepad.TextBoxFrame.TextBox.CursorPosition = CursorPosition;
                                end;

                                updateText();
                                CharScope.buildSignalData("Tool", { Notepad.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), updateText });
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2552
                                    -- upvalues: Notepad (ref), u83 (ref), PlayerEvent (ref), u3 (ref)
                                    if Notepad:GetAttribute("Id") == u83:GetAttribute("Id") then
                                        Notepad:TweenPosition(UDim2.fromScale(0, 5.4), "Out", "Quint", 0.5, true);
                                    end;

                                    PlayerEvent:FireServer("notepadContent", u3.notepadContent);
                                end);
                            end;
                        elseif u83.Name == "RS Jackhammer" then
                            if u84 == true then
                                local Handle2 = u83:WaitForChild("Handle");
                                local Debris = u83:WaitForChild("Emitter"):WaitForChild("Debris");
                                u2.keepMobileGuiTypePersistent("Action", true);
                                u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.JackhammerAim, PlayerStuff.Items.Animations.JackhammerAimStabilize, u83:WaitForChild("DrillAnimation"));
                                u86.drillSound = Handle2:WaitForChild("Drill");
                                local CompressorSoundEffect = u86.drillSound:WaitForChild("CompressorSoundEffect");
                                local EqualizerSoundEffect = u86.drillSound:WaitForChild("EqualizerSoundEffect");

                                local function _() -- Line: 2566
                                    -- upvalues: u6 (ref), Animator (ref), u86 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                    u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                    u6.stopSoundReplicate(u86.drillSound);
                                    Debris.Enabled = false;
                                    CompressorSoundEffect.Enabled = true;
                                    EqualizerSoundEffect.Enabled = true;
                                    mouseDotInteract(false);
                                end;

                                aimSystem({
                                    JackhammerAimStabilize = 0.7,
                                    JackhammerAim = 1
                                }, "Dot", function(p392) -- Line: 2574
                                    -- upvalues: CharScope (ref), u6 (ref), u2 (ref), Config (copy), Animator (ref), u86 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                    if CharScope.getConnectionsAndThreads("Tool").jackhammerThread then
                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread[1]);
                                    end;

                                    if CharScope.getConnectionsAndThreads("Tool").jackhammerThread2 then
                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread2[1]);
                                    end;

                                    u2.setCameraRelativeToViewModelPart(p392 and "Item" or "HumanoidRootPart", p392 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                    if not p392 then
                                        u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                        u6.stopSoundReplicate(u86.drillSound);
                                        Debris.Enabled = false;
                                        CompressorSoundEffect.Enabled = true;
                                        EqualizerSoundEffect.Enabled = true;
                                        mouseDotInteract(false);
                                    end;
                                end);
                                actionEvent(function() -- Line: 2581
                                    -- upvalues: u1 (ref), CharScope (ref), u6 (ref), Animator (ref), u86 (copy), PlayerFunc (ref), PlayerEvent (ref), u83 (ref), getProperCameraUnitRay (ref), u19 (ref), Debris (copy), mouseDotInteract (ref), CompressorSoundEffect (copy), EqualizerSoundEffect (copy)
                                    if u1.isAiming then
                                        if CharScope.getConnectionsAndThreads("Tool").jackhammerThread then
                                            u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread[1]);
                                        end;

                                        if CharScope.getConnectionsAndThreads("Tool").jackhammerThread2 then
                                            u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread2[1]);
                                        end;

                                        u6.animationBuffer(Animator, "play", "DrillAnimation");
                                        u6.playSoundReplicate(u86.drillSound);
                                        local u393 = nil;
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "jackhammerThread", CharScope.taskDelay(1, function() -- Line: 2589
                                            -- upvalues: u393 (ref), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u83 (ref)
                                            while true do
                                                if u393 then
                                                    CharScope.taskDefer(function() -- Line: 2592
                                                        -- upvalues: PlayerFunc (ref), u393 (ref), PlayerEvent (ref), u83 (ref)
                                                        if PlayerFunc:InvokeServer("talkToMission", u393) then
                                                            PlayerEvent:FireServer("degradeItem", u83:GetAttribute("Id"), 210);
                                                        end;
                                                    end);
                                                end;

                                                task.wait(1);
                                            end;
                                        end));
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "jackhammerThread2", CharScope.taskSpawn(function() -- Line: 2599
                                            -- upvalues: getProperCameraUnitRay (ref), u6 (ref), u19 (ref), u393 (ref), Debris (ref), mouseDotInteract (ref), CompressorSoundEffect (ref), EqualizerSoundEffect (ref)
                                            while true do
                                                local v394 = getProperCameraUnitRay(10);
                                                local v395 = u6.raycastVisible(v394.origin, v394.length, u19);

                                                if v395 and v395.Instance:GetAttribute("Drillable") then
                                                    u393 = v395.Instance;

                                                    if not Debris.Enabled then
                                                        mouseDotInteract(true);
                                                        Debris.Enabled = true;
                                                        CompressorSoundEffect.Enabled = false;
                                                        EqualizerSoundEffect.Enabled = false;
                                                    end;
                                                else
                                                    u393 = nil;

                                                    if Debris.Enabled then
                                                        mouseDotInteract(false);
                                                        Debris.Enabled = false;
                                                        CompressorSoundEffect.Enabled = true;
                                                        EqualizerSoundEffect.Enabled = true;
                                                    end;
                                                end;

                                                task.wait(0.3);
                                            end;
                                        end));
                                    end;
                                end, Mobile.Action.Action);
                                CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p396) -- Line: 2625
                                        -- upvalues: u1 (ref), u6 (ref), Animator (ref), u86 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                        if (p396.UserInputType == Enum.UserInputType.MouseButton1 or p396.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                            u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                            u6.stopSoundReplicate(u86.drillSound);
                                            Debris.Enabled = false;
                                            CompressorSoundEffect.Enabled = true;
                                            EqualizerSoundEffect.Enabled = true;
                                            mouseDotInteract(false);
                                        end;
                                    end });
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2630
                                    -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref)
                                    u2.keepMobileGuiTypePersistent("Action", false);

                                    if u1.isAiming then
                                        u1.shoulderCam(false);
                                    end;

                                    u3.activateMouseIcon(false);
                                    u2.keepMobileGuiTypePersistent("Aim", false);
                                    u6.animationBuffer(Animator, "unload", "JackhammerAim", "JackhammerAimStabilize", "DrillAnimation");
                                end);
                            end;
                        elseif u83.Name == "Empty Blue Gift" or (u83.Name == "Empty Pink Gift" or u83.Name == "Empty Red Gift") then
                            if u84 == true then
                                u2.keepMobileGuiTypePersistent("Action", true);
                                actionEvent(function() -- Line: 2639
                                    -- upvalues: u6 (ref), u1 (ref), u83 (ref)
                                    if not u6.invokeTraffic.christmasGift then
                                        u1.activateInventory("Gift", {
                                            giftBoxId = u83:GetAttribute("Id")
                                        });
                                    end;
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2644
                                    -- upvalues: u2 (ref)
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                end);
                            end;
                        elseif u83.Name == "Pink Gift" or (u83.Name == "Red Gift" or u83.Name == "Blue Gift") then
                            if u84 == true then
                                u2.keepMobileGuiTypePersistent("Action", true);
                                CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p397) -- Line: 2651
                                        -- upvalues: u2 (ref), CharScope (ref), u6 (ref)
                                        if p397.UserInputType == Enum.UserInputType.MouseButton1 or p397.UserInputType == Enum.UserInputType.Touch then
                                            u2.displayBottomBarMessage("giftOpening");

                                            if CharScope.getConnectionsAndThreads("Tool").giftThread then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").giftThread[1]);
                                            end;
                                        end;
                                    end });
                                actionEvent(function() -- Line: 2657
                                    -- upvalues: u2 (ref), CharScope (ref), u6 (ref), u83 (ref)
                                    u2.displayBottomBarMessage("giftOpening", 10, "Opening", 2, Color3.fromRGB(255, 255, 255));
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "giftThread", CharScope.taskDelay(2, function() -- Line: 2659
                                        -- upvalues: u2 (ref), u6 (ref), u83 (ref)
                                        u2.displayBottomBarMessage("giftOpening");

                                        if not u6.invokeTraffic.christmasGift then
                                            u6.invokeServerTraffic("christmasGift", "open", {
                                                giftId = u83:GetAttribute("Id")
                                            });
                                        end;
                                    end));
                                end, Mobile.Action.Action);
                                CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2666
                                    -- upvalues: u2 (ref)
                                    u2.displayBottomBarMessage("giftOpening");
                                    u2.keepMobileGuiTypePersistent("Action", false);
                                end);
                            end;
                        elseif u83.Name == "Snowball" and u84 == true then
                            u2.keepMobileGuiTypePersistent("Action", true);
                            u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.SnowballAimStabilize, PlayerStuff.Items.Animations.SnowballAim, PlayerStuff.Items.Animations.ThrowSnowball);
                            aimSystem({
                                SnowballAimStabilize = 0.7,
                                SnowballAim = 1
                            }, "Dot", function(p398) -- Line: 2675
                                -- upvalues: u2 (ref), Config (copy)
                                u2.setCameraRelativeToViewModelPart(p398 and "Item" or "HumanoidRootPart", p398 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                            end);
                            actionEvent(function() -- Line: 2679
                                -- upvalues: u1 (ref), u6 (ref), CharScope (ref), Animator (ref), u83 (ref), getProperCameraUnitRay (ref), u19 (ref), u3 (ref), HumanoidRootPart (ref)
                                if u1.isAiming and not u6.rest("ThrowSnowball", 2) then
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "snowballThread", CharScope.taskSpawn(function() -- Line: 2681
                                        -- upvalues: u6 (ref), Animator (ref), u83 (ref), getProperCameraUnitRay (ref), u19 (ref), u3 (ref), HumanoidRootPart (ref)
                                        u6.animationBuffer(Animator, "play", "ThrowSnowball");
                                        task.wait(0.25);
                                        u83.PrimaryPart.Transparency = 1;
                                        local v399 = getProperCameraUnitRay(80);
                                        local v400 = u6.raycastVisible(v399.origin, v399.length, u19, {
                                            character = true
                                        });
                                        u3.throwPhysicsObject("Snowball", HumanoidRootPart.CFrame, v400 and v400.Position or v399.origin + v399.length, Vector3.new(0, 1, -2));
                                        task.wait(1.65);
                                        u83.PrimaryPart.Transparency = 0;
                                    end));
                                end;
                            end, Mobile.Action.Action);
                            CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2694
                                -- upvalues: u1 (ref), u3 (ref), u2 (ref), u6 (ref), Animator (ref), u83 (ref)
                                if u1.isAiming then
                                    u1.shoulderCam(false);
                                end;

                                u3.activateMouseIcon(false);
                                u2.keepMobileGuiTypePersistent("Aim", false);
                                u6.animationBuffer(Animator, "unload", "SnowballAim", "SnowballAimStabilize");
                                u2.keepMobileGuiTypePersistent("Action", false);
                                u83.PrimaryPart.Transparency = 0;
                            end);
                        end;
                    end;
                end;
            end));
        end;
    end;

    u3.debugLoadingClient("Inventory 2");

    local function itemDisabledVisual(p401, p402, p403) -- Line: 2708
        -- upvalues: u6 (ref), u9 (copy)
        local v404;

        if p401 then
            if p401[4] and (p401[4].Condition or 1000) <= 0 then
                v404 = true;
            else
                v404 = not p403 and not u6.isTeamWhitelisted(u6.availableItems[p401[1]], u9);
            end;
        else
            v404 = p401;
        end;

        p402.ImageTransparency = v404 and 0.5 or 0;
        p402.ImageColor3 = v404 and Color3.fromRGB(153, 153, 153) or Color3.fromRGB(255, 255, 255);
    end;

    local function renderSlot(p405, p406, p407) -- Line: 2716
        -- upvalues: u6 (ref), GameRules (ref), Gear (ref), itemDisabledVisual (copy)
        local v408;

        if p406 then
            v408 = require(u6.availableItems[p406[1]].Config);
        else
            v408 = p406;
        end;

        p405.Quantity.Text = p406 and p406[2] > 1 and (p406[2] or "") or "";
        p405.Icon.Image = v408 and (v408.ICON or "") or "";
        local Condition = p405.Condition;
        local v409 = p406 and (p406[4] and p406[4].Condition);

        if v409 then
            if math.ceil(p406[4].Condition / 1000 * 100) < (v408.CONDITION == "Freshness" and (100 - 100 / GameRules.foodAndDrinkShelfLifeInHours or 100) or 100) then
                v409 = require(u6.availableItems[p406[1]].Config).CONDITION;
            else
                v409 = false;
            end;
        end;

        Condition.Visible = v409;

        if p405.Condition.Visible then
            p405.Condition.Bar.Size = UDim2.fromScale(p406[4].Condition / 1000, 1);
        end;

        local Special = p405.Special;
        local v410;

        if p406 then
            v410 = u6.availableItems[p406[1]]:IsDescendantOf(Gear);
        else
            v410 = p406;
        end;

        Special.Visible = v410;

        if p407 then
            itemDisabledVisual(p406, p405.Icon, p407 == "onlyCondition");
        end;
    end;

    local u411 = nil;

    function u1.renderInventory(p412) -- Line: 2727
        -- upvalues: u6 (ref), GameRules (ref), Inventory (copy), u3 (ref), renderSlot (copy), itemDisabledVisual (copy), u11 (ref), Middle2 (copy), u411 (ref)
        local PocketAmountInventory = u6.getPocketAmountInventory(nil, p412);
        local v413 = 0;

        for i = 1, GameRules.inventorySize + GameRules.maxPocketAmount do
            if GameRules.inventorySize < i then
                Inventory.Slots[i].Locked.Visible = PocketAmountInventory < i - GameRules.inventorySize;
            end;

            local v414 = (p412 or u3.inventory)[tostring(i)];
            renderSlot(Inventory.Slots[i], v414, p412 and "onlyCondition" or true);
            local v415;

            if v414 then
                v413 = v413 + 1;
                v415 = i;
            else
                v415 = i;
            end;
        end;

        for _, v in pairs({ "Pocket", "Jewelry" }) do
            local v416 = (p412 or u3.inventory)[string.lower(v)];
            local v417;

            if v416 then
                v417 = require(u6.availableItems[v416[1]].Config);
            else
                v417 = v416;
            end;

            Inventory[v].Icon.Image = v417 and v417.ICON or "";
            Inventory[v].Quantity.Text = v416 and (v416[2] > 1 and v416[2]) or "";
            Inventory[v].PlaceHolder.Visible = Inventory[v].Icon.Image == "";
        end;

        itemDisabledVisual(u11, Middle2.GrabIcon);
        local v418 = u11 and require(u6.availableItems[u11[1]].Config);
        Middle2.GrabIcon.Image = v418 and v418.ICON or "";
        Inventory.TopBar.Capacity.Text = v413 .. " / " .. GameRules.inventorySize + PocketAmountInventory;

        if not p412 and GameRules.inventorySize + PocketAmountInventory - v413 <= 1 then
            u3.displayTip("clearingInventory", 5);
        end;

        if u411 then
            u411();
        end;
    end;

    local function visualSlot(p419, p420, p421) -- Line: 2755
        -- upvalues: u6 (ref)
        for _, child in pairs(p419:GetChildren()) do
            if child.Name == "Line" then
                if p421 then
                    child.Visible = p420;
                else
                    child.BackgroundColor3 = p420 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140);
                    child.BackgroundTransparency = p420 and 0 or 0.6;
                    u6.transparencyFadeRemove(child, true);
                    u6.resetButtonColor(child, p420);
                end;
            end;
        end;
    end;

    local function refreshHighlight(p422) -- Line: 2769
        -- upvalues: u10 (ref), visualSlot (copy), Inventory (copy), u3 (ref), InventoryBar (copy)
        if p422 ~= nil then
            if u10 then
                visualSlot(Inventory.Slots[u10], false);
            end;

            if p422 then
                visualSlot(Inventory.Slots[p422], true);
            end;

            u10 = p422;
        end;

        if u10 and not u3.inventory[tostring(u10)] then
            visualSlot(Inventory.Slots[u10], false);
            u10 = nil;
        end;

        for i = 1, 5 do
            local v423;

            if InventoryBar:FindFirstChild((tostring(i))) and InventoryBar[i].Line.Visible ~= (tostring(i) == u10) then
                local v424 = not InventoryBar[i].Line.Visible;
                v423 = i;

                for _, child in pairs(InventoryBar[i]:GetChildren()) do
                    if child.Name == "Line" then
                        child.Visible = v424;
                    end;
                end;
            else
                v423 = i;
            end;
        end;
    end;

    function u1.renderInventoryBar() -- Line: 2788
        -- upvalues: CharScope (ref), InventoryBar (copy), u3 (ref), u6 (ref), renderSlot (copy), u1 (ref), itemDisabledVisual (copy), refreshHighlight (copy)
        CharScope.setConnectionsAndThreads("InventoryBar");

        for _, child in pairs(InventoryBar:GetChildren()) do
            if child:IsA("ImageButton") and child.Name ~= "Preview" then
                child:Destroy();
            end;
        end;

        for i = 1, 5 do
            local v425 = u3.inventory[tostring(i)];
            local v426;

            if v425 then
                local _ = u6.availableItems[v425[1]];
                local v427 = u6.clone(InventoryBar.Preview);
                v427.Name = i;
                v427.Number.Text = i;
                v427.Visible = true;
                renderSlot(v427, v425);
                v427.Parent = InventoryBar;
                CharScope.buildSignalData("InventoryBar", u3.mouseButton(v427, function() -- Line: 2804
                    -- upvalues: u1 (ref), i (copy)
                    u1.equipSlot((tostring(i)));
                end));
                CharScope.buildSignalData("InventoryBar", u3.displayGuiDetails(v427, v425[1]));
                itemDisabledVisual(v425, v427.Icon);
                v426 = i;
            else
                v426 = i;
            end;
        end;

        refreshHighlight();
    end;

    local u428 = {};
    local u429 = {};

    function u1.specialItemEquipped(p430) -- Line: 2816
        -- upvalues: u428 (copy), u6 (ref), CharScope (ref), u429 (copy), u1 (ref), LocalPlayer (ref), u2 (ref), u5 (ref), u4 (ref), refreshHighlight (copy)
        local function v431() -- Line: 2817
            -- upvalues: u428 (ref), u6 (ref), CharScope (ref), u429 (ref)
            for _, v in pairs(u428) do
                u6.taskCancel(v);
            end;

            table.clear(u428);
            CharScope.setConnectionsAndThreads("specialItem");

            for _, v in pairs(u429) do
                v();
            end;

            table.clear(u429);
        end;

        if not p430 then
            if u1.specialItem then
                v431();
                u1.specialItem = nil;
                u2.onEquipStateChanged();
                u2.onEquipStateChangedItemLoaded();
                refreshHighlight(false);
            end;

            return;
        end;

        v431();
        u1.equipSlot(nil, true);
        u6.toolSystem.equip(LocalPlayer, p430);
        local Config = require(p430:WaitForChild("Config"));

        if Config.LOCK_HUMANOID_STATE then
            u2.lockHumanoidState("specialItem", Config.LOCK_HUMANOID_STATE);
            table.insert(u429, function() -- Line: 2832
                -- upvalues: u2 (ref)
                u2.lockHumanoidState("specialItem");
            end);
        end;

        if Config.LOCK_PHONE then
            u5.pullOutPhone(false);
            u5.phoneEnabled = false;
            table.insert(u429, function() -- Line: 2839
                -- upvalues: u5 (ref)
                u5.phoneEnabled = true;
            end);
        end;

        if Config.LOCK_EMOTES then
            u2.lockEmotes("specialItem", true);
            table.insert(u429, function() -- Line: 2845
                -- upvalues: u2 (ref)
                u2.lockEmotes("specialItem", false);
            end);
        end;

        if p430.Name == "HandcuffsVisual" then
            u4.disabled(true, "handcuffed");
            table.insert(u429, function() -- Line: 2864
                -- upvalues: u4 (ref)
                u4.disabled(false, "handcuffed");
            end);
        end;

        u1.specialItem = p430;
        u2.onEquipStateChanged(p430);
        u2.onEquipStateChangedItemLoaded(p430);
        refreshHighlight(false);
    end;

    local function equipSlotEnabledCanEquipItem(p432) -- Line: 2883
        -- upvalues: u1 (ref)
        local v433;

        if u1.equipSlotEnabled == true then
            v433 = true;
        else
            v433 = u1.equipSlotEnabled and u1.equipSlotEnabled == require(p432.Config).CAN_EQUIP_EXCLUSIVE;
        end;

        return v433;
    end;

    u1.equipSlotEnabled = true;

    function u1.canEquipSlot(p434) -- Line: 2888
        -- upvalues: u1 (ref)
        u1.equipSlotEnabled = p434;

        if u1.equippedItem then
            local equippedItem = u1.equippedItem;
            local v435;

            if u1.equipSlotEnabled == true then
                v435 = true;
            else
                v435 = u1.equipSlotEnabled and u1.equipSlotEnabled == require(equippedItem.Config).CAN_EQUIP_EXCLUSIVE;
            end;

            if not v435 then
                u1.equipSlot();
            end;
        end;
    end;

    function u1.canUseSlotActions(p436) -- Line: 2893
        -- upvalues: u15 (ref), u1 (ref), u6 (ref)
        u15 = p436;

        if u1.equippedItem then
            local Attribute = u1.equippedItem:GetAttribute("Id");
            u1.equipSlot();
            u1.equipSlot(u6.findSlotWithItemId(nil, Attribute));
        end;
    end;

    u6.toolSystem.antiRubberBandToolEquipListener(u8);

    function u1.equipSlot(p437, p438) -- Line: 2904
        -- upvalues: u1 (ref), u82 (ref), CharScope (ref), u2 (ref), u6 (ref), LocalPlayer (ref), PlayerEvent (ref), u8 (copy), u3 (ref), u9 (copy), refreshHighlight (copy), u15 (ref), HumanoidRootPart (copy), Equip (copy), PlayerStuff (ref), Equip2 (copy), Animator (copy), keepLocalTransparencyOffForTool (copy), GameRules (ref), actionEvent (copy), Mobile (copy), Ammo (copy), UserInputService (ref), aimSystem (copy), targetHitIcon (copy), bulletHoleEffect (copy), PlayerFunc (ref), u19 (copy), u18 (copy), BulletShooterPov (copy), getProperCameraUnitRay (copy), RunService (ref), u16 (copy), u43 (copy), Ragdoll (ref), u17 (copy), workspace_CurrentCamera (ref), Humanoid (copy), ScreenGui (copy), TweenService (ref), advancedInputStateChange (copy), PlacePreviewHighlight (copy), u21 (copy), mouseDotInteract (copy), aimToolAtMouseHit (copy), u20 (copy), SpeedRadar (copy), metalDetectorPointsUpdateListener (copy), Notepad (copy), Gear (ref)
        if u1.specialItem and require(u1.specialItem.Config).SPECIAL >= 0 then
            return;
        end;

        local equippedItem = u1.equippedItem;

        if equippedItem then
            u1.equippedItem = nil;
            u82 = (u82 + 1) % 1000;
            CharScope.setConnectionsAndThreads("Tool");
            u2.onEquipStateChanged();
            u2.onEquipStateChangedItemLoaded();
            u6.toolSystem.equip(LocalPlayer, nil, not p438 and true);

            if not p438 then
                PlayerEvent:FireServer("equipItem", u8);
            end;
        end;

        local u439;

        if p437 then
            if equippedItem and equippedItem:GetAttribute("Id") == u3.inventory[p437][3] then
                u439 = false;
            else
                u439 = u6.getItemFromId(LocalPlayer, u3.inventory[p437][3]);
            end;
        else
            u439 = p437;
        end;

        if u439 then
            local v440;

            if u1.equipSlotEnabled == true then
                v440 = true;
            else
                v440 = u1.equipSlotEnabled and u1.equipSlotEnabled == require(u439.Config).CAN_EQUIP_EXCLUSIVE;
            end;

            if v440 then
                if not u6.isTeamWhitelisted(u439, u9) then
                    local v441 = {};

                    for _, child in pairs(u439._TeamWhitelisted:GetChildren()) do
                        table.insert(v441, child.Name);
                    end;

                    u3.notify({
                        color = "red",
                        message = "Only a <b>" .. table.concat(v441, ", ") .. "</b> team can use it"
                    });
                    refreshHighlight(false);

                    return;
                end;

                if u3.inventory[p437][4] and (u3.inventory[p437][4].Condition or 1000) <= 0 then
                    local CONDITION = require(u6.availableItems[u439.Name].Config).CONDITION;
                    local v442 = CONDITION == "Consumption" and "This item is out of uses" or "This item is broken";

                    if u6.availableItems[u439.Name]:IsDescendantOf(Gear) then
                        v442 = v442 .. ". " .. (CONDITION == "Consumption" and "Replenish at base" or "Repair at base");
                    end;

                    u3.notify({
                        color = "red",
                        message = v442
                    });
                    refreshHighlight(false);

                    return;
                end;

                if u1.specialItem then
                    u1.specialItemEquipped();
                end;

                refreshHighlight(p437);
                u1.equippedItem = u439;
                u6.toolSystem.equip(LocalPlayer, u439, true);
                PlayerEvent:FireServer("equipItem", u8, u439);
                u2.onEquipStateChanged(u439);
                local u443 = u15;
                u82 = (u82 + 1) % 1000;
                local u444 = u82;
                CharScope.setConnectionsAndThreads("Tool");

                if u439 then
                    CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(function() -- Line: 373
                        -- upvalues: u439 (copy), u6 (ref), LocalPlayer (ref), u3 (ref), u1 (ref), CharScope (ref), PlayerEvent (ref), HumanoidRootPart (ref), Equip (ref), PlayerStuff (ref), Equip2 (ref), Animator (ref), keepLocalTransparencyOffForTool (ref), GameRules (ref), u443 (copy), u2 (ref), actionEvent (ref), Mobile (ref), u8 (ref), Ammo (ref), UserInputService (ref), aimSystem (ref), targetHitIcon (ref), bulletHoleEffect (ref), PlayerFunc (ref), u19 (ref), u18 (ref), BulletShooterPov (ref), getProperCameraUnitRay (ref), RunService (ref), u16 (ref), u43 (ref), Ragdoll (ref), u444 (copy), u82 (ref), u17 (ref), workspace_CurrentCamera (ref), Humanoid (ref), ScreenGui (ref), TweenService (ref), advancedInputStateChange (ref), PlacePreviewHighlight (ref), u21 (ref), mouseDotInteract (ref), aimToolAtMouseHit (ref), u20 (ref), SpeedRadar (ref), metalDetectorPointsUpdateListener (ref), Notepad (ref)
                        local Handle = u439:WaitForChild("Handle");
                        local Config = require(u439:WaitForChild("Config"));

                        if Config.DAMAGE or u439.Name == "PD Handcuffs" then
                            if u6.isKid(LocalPlayer) then
                                task.wait(0.1);
                                u3.notify({
                                    message = "Kids can\'t engage in combat",
                                    color = "red"
                                });
                                u1.equipSlot();

                                return true;
                            end;

                            local function u445() -- Line: 389
                                -- upvalues: Config (copy), LocalPlayer (ref), u3 (ref), u1 (ref)
                                if Config.DAMAGE and (Config.CATEGORY ~= "Taser" and (LocalPlayer.InsideLocation.Value and LocalPlayer.InsideLocation.Value:FindFirstChild("CombatRestricted"))) then
                                    task.wait(0.1);
                                    u3.notify({
                                        message = "You cannot fight inside this location",
                                        color = "red"
                                    });
                                    u1.equipSlot();

                                    return true;
                                end;
                            end;

                            if Config.DAMAGE or u439.Name == "PD Handcuffs" then
                                if u445() then
                                    return;
                                end;

                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(1, function() -- Line: 401
                                    -- upvalues: u445 (copy)
                                    while not u445() do
                                        task.wait(1);
                                    end;
                                end));
                                PlayerEvent:FireServer("combatMode", true);
                            end;
                        end;

                        CharScope.buildSignalData("Tool", u6.instanceDestroyed(u439, function() -- Line: 408
                            -- upvalues: u1 (ref)
                            u1.equipSlot();
                        end));
                        local u446 = {};
                        local u447 = Handle:FindFirstChild("EquipSound") or (Config.CATEGORY and HumanoidRootPart:FindFirstChild(Config.CATEGORY .. "Equip") or Equip);
                        local v448 = Handle:FindFirstChild("EquipAnimation") and PlayerStuff.Items.Animations[Handle.EquipAnimation.Value] or (Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Equip") or Equip2);
                        local v449 = v448:FindFirstChild("Weight") and (v448.Weight.Value / 10 or 1) or 1;
                        local u450 = u6.loadAnimation(Animator, v448);
                        local u451;

                        if Handle:FindFirstChild("IdleAnimation") then
                            if Handle.IdleAnimation.Value == "" then
                                u451 = true;
                            else
                                u451 = PlayerStuff.Items.Animations[Handle.IdleAnimation.Value] or Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Idle");
                            end;
                        else
                            u451 = Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Idle");
                        end;

                        if u451 == true then
                            u451 = nil;
                        end;

                        local v452 = u451 and u451:FindFirstChild("Weight") and (u451.Weight.Value / 10 or 1) or 1;

                        if u451 then
                            u451 = u6.loadAnimation(Animator, u451);
                        end;

                        local u453 = Handle:FindFirstChild("ActionAnimation") and PlayerStuff.Items.Animations[Handle.ActionAnimation.Value] or Config.CATEGORY and PlayerStuff.Items.Animations:FindFirstChild(Config.CATEGORY .. "Action");

                        if u453 then
                            u453 = u6.loadAnimation(Animator, u453);
                        end;

                        if u451 then
                            u6.playAnimation(u451, "play", 0.4, v452);
                        end;

                        u6.playAnimation(u450, "play", nil, v449);
                        u6.playSoundReplicate(u447);
                        keepLocalTransparencyOffForTool(u439);
                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 429
                            -- upvalues: Config (copy), u439 (ref), PlayerEvent (ref), u450 (ref), u6 (ref), GameRules (ref), u451 (ref), u453 (ref), u447 (copy), u446 (copy)
                            if Config.DAMAGE or u439.Name == "PD Handcuffs" then
                                PlayerEvent:FireServer("combatMode", false);
                            end;

                            if u450.animationTrack.IsPlaying then
                                u6.playAnimation(u450, "stop", GameRules.defaultCharacterAnimationFadeTime);
                            end;

                            if u451 and u451.animationTrack.IsPlaying then
                                u6.playAnimation(u451, "stop", GameRules.defaultCharacterAnimationFadeTime);
                            end;

                            if u453 and u453.animationTrack.IsPlaying then
                                u6.playAnimation(u453, "stop", GameRules.defaultCharacterAnimationFadeTime);
                            end;

                            if u447.IsPlaying then
                                u6.stopSoundReplicate(u447);
                            end;

                            if u446.Prompts then
                                for _, v in pairs(u446.Prompts) do
                                    if v.Parent then
                                        v:Destroy();
                                    end;
                                end;
                            end;

                            local function _(p454) -- Line: 440
                                -- upvalues: u6 (ref)
                                if u6.typeOf(p454) == "Instance" and (p454:IsA("Sound") and p454.IsPlaying) then
                                    u6.stopSoundReplicate(p454);
                                end;
                            end;

                            for _, v in pairs(u446) do
                                if u6.typeOf(v) == "table" then
                                    for _, v2 in pairs(v) do
                                        if u6.typeOf(v2) == "Instance" and (v2:IsA("Sound") and v2.IsPlaying) then
                                            u6.stopSoundReplicate(v2);
                                        end;
                                    end;
                                elseif u6.typeOf(v) == "Instance" and (v:IsA("Sound") and v.IsPlaying) then
                                    u6.stopSoundReplicate(v);
                                end;
                            end;
                        end);

                        if u443 then
                            local function _(u455, u456, u457, u458) -- Line: 453
                                -- upvalues: CharScope (ref), PlayerEvent (ref), u439 (ref)
                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(u455, function() -- Line: 454
                                    -- upvalues: u457 (copy), u458 (copy), PlayerEvent (ref), u439 (ref), u456 (copy), u455 (copy)
                                    while not u457 or u457() do
                                        if not u458 or u458() then
                                            PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), u456);
                                        end;

                                        task.wait(u455);
                                    end;
                                end));
                            end;

                            if u443 == true or u443 == "Vehicle" then
                                for _, child in pairs(u439.Config:GetChildren()) do
                                    if child.Name == "TotalAmmo" then
                                        u6.propertyListener(child, true);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 468
                                            -- upvalues: u6 (ref), child (copy)
                                            u6.propertyListener(child, false);
                                        end);
                                    end;
                                end;
                            end;

                            if u443 == true then
                                if Config.RAIN_PROTECTION then
                                    u2.rainProtection = true;
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 477
                                        -- upvalues: u2 (ref)
                                        u2.rainProtection = false;
                                    end);
                                end;

                                if Config.LOCK_HUMANOID_STATE then
                                    u2.lockHumanoidState("item", Config.LOCK_HUMANOID_STATE);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 487
                                        -- upvalues: u2 (ref)
                                        u2.lockHumanoidState("item", nil);
                                    end);
                                end;
                            end;

                            if Config.CATEGORY == "Food" or Config.CATEGORY == "Drink" then
                                if u443 == true or u443 == "Vehicle" then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    local u459 = {
                                        Food = 3.5,
                                        Drink = 2.2
                                    };
                                    u446.actionSound = HumanoidRootPart:WaitForChild(Config.CATEGORY .. "Action");
                                    local u460 = true;
                                    actionEvent(function() -- Line: 499
                                        -- upvalues: u460 (ref), u6 (ref), u446 (copy), u453 (ref), GameRules (ref), u459 (copy), Config (copy), u2 (ref), CharScope (ref), PlayerEvent (ref), u439 (ref)
                                        if u460 then
                                            u460 = false;
                                            u6.playSoundReplicate(u446.actionSound);
                                            u6.playAnimation(u453, "play", GameRules.defaultCharacterAnimationFadeTime);
                                            local v461 = u459[Config.CATEGORY] + 0.6;
                                            u2.displayBottomBarMessage("foodDrink", 10, Config.CATEGORY == "Food" and "Eating" or "Drinking", v461, Config.CATEGORY == "Food" and Color3.fromRGB(255, 189, 114) or Color3.fromRGB(88, 188, 255));
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "foodDrinkThread", CharScope.taskDelay(v461, function() -- Line: 506
                                                -- upvalues: u2 (ref), PlayerEvent (ref), u439 (ref), Config (ref), u460 (ref)
                                                u2.displayBottomBarMessage("foodDrink");
                                                PlayerEvent:FireServer("modifyInventory", {
                                                    change = 1,
                                                    removeById = u439:GetAttribute("Id")
                                                });

                                                if Config.ENERGY then
                                                    u2.changeStamina(Config.ENERGY);
                                                    u2.canUseStaminaAgain();
                                                end;

                                                if Config.HUNGER then
                                                    u2.changeFood(Config.HUNGER);
                                                end;

                                                u460 = true;
                                            end));
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 519
                                        -- upvalues: u2 (ref)
                                        u2.displayBottomBarMessage("foodDrink");
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                    end);
                                end;
                            elseif Config.GUN then
                                local u462 = Handle:FindFirstChild("AimAnimation") and Handle.AimAnimation.Value or Config.CATEGORY;
                                local u463 = Handle:FindFirstChild("ReloadAnimation") and Handle.ReloadAnimation.Value or Config.CATEGORY;
                                local u464 = { u3.mouseIconGui.Reloading.Left.ImageLabel, u3.mouseIconGui.Reloading.Left.Shades };
                                local u465 = { u3.mouseIconGui.Reloading.Right.ImageLabel, u3.mouseIconGui.Reloading.Right.Shades };
                                local u466 = u6.availableItems[u439.Name];
                                local u467 = false;

                                local function u468() -- Line: 530
                                    -- upvalues: Config (copy), u2 (ref), u1 (ref)
                                    if Config.CATEGORY == "Handgun" then
                                        u2.setCameraRelativeToViewModelPart(u1.isAiming and "Item" or "HumanoidRootPart", u1.isAiming and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                        return;
                                    end;

                                    u2.setCameraRelativeToViewModelPart("Item", u1.isAiming and Config.FIRST_PERSON_AIM_OFFSET or (not u1.isAiming and Config.FIRST_PERSON_OFFSET or CFrame.new(0, 1.7, 0)), true);
                                end;

                                local function _(p469) -- Line: 537
                                    -- upvalues: u6 (ref), u439 (ref), u1 (ref), u8 (ref), Config (copy)
                                    local setToolGrip = u6.setToolGrip;
                                    local v470 = (p469 or u1.isAiming) and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                    setToolGrip(nil, u439, v470);
                                end;

                                local function u478(u471) -- Line: 540
                                    -- upvalues: u467 (ref), u439 (ref), u466 (copy), u3 (ref), u1 (ref), Config (copy), u468 (copy), u6 (ref), u8 (ref), CharScope (ref), u446 (copy), Animator (ref), u463 (copy), u2 (ref), GameRules (ref), u464 (copy), u465 (copy), Ammo (ref)
                                    if u467 or (u439.Config.Ammo.Value >= u466.Config.Ammo.Value or u439.Config.TotalAmmo.Value <= 0) then
                                        if u471 then
                                            u471();
                                        end;

                                        return;
                                    end;

                                    local function u473() -- Line: 542
                                        -- upvalues: u3 (ref), u1 (ref), Config (ref), u467 (ref), u468 (ref), u6 (ref), u439 (ref), u8 (ref), CharScope (ref), u471 (copy)
                                        u3.activateMouseIcon(u1.isAiming and (Config.MOUSE_ICON or "Crosshair") or false);
                                        u467 = false;
                                        u468();
                                        local setToolGrip = u6.setToolGrip;
                                        local v472 = u1.isAiming and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                        setToolGrip(nil, u439, v472);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading", nil);
                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading3", nil);

                                        if u471 then
                                            CharScope.taskSpawn(u471);
                                        end;
                                    end;

                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading", u473);
                                    u467 = true;

                                    if u446.reloadSound.IsPlaying then
                                        u6.stopSoundReplicate(u446.reloadSound);
                                    end;

                                    u6.animationBuffer(Animator, "stop", u463 .. "Reload", 0.7);
                                    u3.activateMouseIcon("Reloading");
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading2", CharScope.taskDelay(0.5, function() -- Line: 556
                                        -- upvalues: u467 (ref), u2 (ref), u6 (ref), u439 (ref), u8 (ref), Config (ref), u446 (ref), Animator (ref), u463 (ref)
                                        if not u467 then
                                            return;
                                        end;

                                        u2.setCameraRelativeToViewModelPart("HumanoidRootPart", CFrame.new(0, 1.7, 0), true);
                                        u6.setToolGrip(nil, u439, u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                        u6.playSoundReplicate(u446.reloadSound);
                                        u6.animationBuffer(Animator, "play", u463 .. "Reload", 0.4);
                                        local v474 = u6.animationBuffer(Animator, "get", u463 .. "Reload");
                                        task.wait(v474.Length - 0.7);
                                        u6.animationBuffer(Animator, "stop", u463 .. "Reload", 0.7);
                                    end));
                                    local u475 = Config.RELOAD_TIME or (GameRules.reloadTimeByCategory[u463] or 2.6);
                                    local u476 = 0;
                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "reloading3", CharScope.taskDefer(function() -- Line: 568
                                        -- upvalues: u476 (ref), u475 (copy), u6 (ref), u464 (ref), u465 (ref), u467 (ref), u439 (ref), u466 (ref), Ammo (ref), u473 (copy)
                                        while u476 < u475 do
                                            u6.updateCircularHud(u464, u465, u476 / u475);
                                            u476 = u476 + task.wait();

                                            if not u467 then
                                                return;
                                            end;
                                        end;

                                        local v477 = u439.Config.TotalAmmo.Value + u439.Config.Ammo.Value < u466.Config.Ammo.Value and u439.Config.TotalAmmo.Value + u439.Config.Ammo.Value or u466.Config.Ammo.Value;
                                        u439.Config.TotalAmmo.Value = u439.Config.TotalAmmo.Value - v477 + u439.Config.Ammo.Value;
                                        u439.Config.Ammo.Value = v477;
                                        Ammo.ImageLabel2.Ammo.Text = v477;
                                        Ammo.ImageLabel2.TotalAmmo.Text = "/ " .. u439.Config.TotalAmmo.Value;
                                        u473();
                                    end));
                                end;

                                if u443 == "Vehicle" then
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 584
                                        -- upvalues: u2 (ref), u6 (ref), Animator (ref), u463 (copy), u439 (ref)
                                        u2.keepMobileGuiTypePersistent("GunVehicle", false);
                                        u6.animationBuffer(Animator, "unload", u463 .. "Reload");
                                        u6.propertyListenerReceived(nil, u439.Config.Ammo, u439.Config.Ammo.Value);
                                    end);
                                    u2.keepMobileGuiTypePersistent("GunVehicle", true);
                                    u446.reloadSound = HumanoidRootPart:FindFirstChild(u463 .. "Reload") or u439.Handle:WaitForChild("ReloadSound");
                                    u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u463 .. "Reload"]);
                                    CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p479) -- Line: 592
                                            -- upvalues: u3 (ref), u478 (copy)
                                            if p479.KeyCode == Enum.KeyCode.R and u3.canPressKey(p479.KeyCode) then
                                                u478();
                                            end;
                                        end });
                                    CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.GunVehicle.Reload, u478));
                                elseif u443 == true then
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 599
                                        -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref), u463 (copy), u462 (copy), u439 (ref), CharScope (ref), Ammo (ref)
                                        u2.keepMobileGuiTypePersistent("Gun", false);

                                        if u1.isAiming then
                                            u1.shoulderCam(false);
                                        end;

                                        u3.activateMouseIcon(false);
                                        u2.keepMobileGuiTypePersistent("Aim", false);
                                        u6.animationBuffer(Animator, "unload", u463 .. "Reload", u462 .. "AimStabilize", u462 .. "Aim");
                                        u6.propertyListenerReceived(nil, u439.Config.Ammo, u439.Config.Ammo.Value);
                                        CharScope.taskDelay(0.03, function() -- Line: 604
                                            -- upvalues: Ammo (ref), u439 (ref), u6 (ref)
                                            if Ammo:GetAttribute("Id") == u439:GetAttribute("Id") then
                                                u6.guiTransition(Ammo, "Position", UDim2.fromScale(0, 0.2), false);
                                            end;
                                        end);
                                    end);
                                    u2.keepMobileGuiTypePersistent("Gun", true);
                                    local Barrel = Handle:WaitForChild("Barrel");
                                    local u480 = HumanoidRootPart:FindFirstChild(Config.CATEGORY .. "Fire") or u439.Handle:WaitForChild("FireSound");
                                    u446.reloadSound = HumanoidRootPart:FindFirstChild(u463 .. "Reload") or u439.Handle:WaitForChild("ReloadSound");
                                    u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u462 .. "AimStabilize"], PlayerStuff.Items.Animations[u462 .. "Aim"], PlayerStuff.Items.Animations[u463 .. "Reload"], Config.SHOTGUN_QUICK_RELOAD and PlayerStuff.Items.Animations.ShotgunQuickReload);

                                    if Config.FIRST_PERSON_OFFSET then
                                        u2.setCameraRelativeToViewModelPart("Item", Config.FIRST_PERSON_OFFSET);
                                    end;

                                    aimSystem({
                                        [u462 .. "AimStabilize"] = 0.7,
                                        [u462 .. "Aim"] = 1
                                    }, Config.MOUSE_ICON or "Crosshair", function(p481) -- Line: 616
                                        -- upvalues: u467 (ref), u6 (ref), u439 (ref), u1 (ref), u8 (ref), Config (copy), u468 (copy), u451 (ref), GameRules (ref), u3 (ref)
                                        if not u467 then
                                            local setToolGrip = u6.setToolGrip;
                                            local v482 = u1.isAiming and (u8:GetAttribute("BodyType") == "Blocky" and Config.BLOCKY_AIM_GRIP or Config.AIM_GRIP);
                                            setToolGrip(nil, u439, v482);
                                            u468();
                                        end;

                                        if u451 and u1.equippedItem == u439 then
                                            u6.playAnimation(u451, p481 and "stop" or "play", GameRules.defaultCharacterAnimationFadeTime);
                                        end;

                                        if u467 and p481 then
                                            u3.activateMouseIcon("Reloading");
                                        end;
                                    end, nil, true);
                                    u6.guiTransition(Ammo, "Position", UDim2.fromScale(0, 0.2), true);
                                    Ammo:SetAttribute("Id", u439:GetAttribute("Id"));
                                    Ammo.ImageLabel.Item.Text = u439.Name;
                                    Ammo.ImageLabel2.Ammo.Text = u439.Config.Ammo.Value;
                                    Ammo.ImageLabel2.TotalAmmo.Text = "/ " .. u439.Config.TotalAmmo.Value;
                                    local u483 = 0;
                                    local u484 = false;
                                    local u485 = true;

                                    local function _(p486, p487, p488) -- Line: 644
                                        local v489 = 1 / (p488 or 1);

                                        return math.random(p486 * v489, p487 * v489) / v489;
                                    end;

                                    local v490 = u3.mouseIconGui[Config.MOUSE_ICON or "Crosshair"];

                                    if v490:FindFirstChild("IsCrosshair") then
                                        local _ = {
                                            Bottom = Vector2.new(0, 1),
                                            Top = Vector2.new(0, -1),
                                            Left = Vector2.new(-1, 0),
                                            Right = Vector2.new(1, 0),
                                            TopLeft = Vector2.new(-0.5, -0.5),
                                            TopRight = Vector2.new(0.5, -0.5),
                                            BottomLeft = Vector2.new(-0.5, 0.5),
                                            BottomRight = Vector2.new(0.5, 0.5)
                                        };

                                        for _, child in pairs(v490:GetChildren()) do
                                            if child:IsA("GuiBase") and not child:GetAttribute("BasePosition") then
                                                child:SetAttribute("BasePosition", child.Position);
                                            end;
                                        end;
                                    end;

                                    local function u505(u491, u492, u493) -- Line: 677
                                        -- upvalues: u6 (ref), LocalPlayer (ref), Config (copy), u3 (ref), GameRules (ref), targetHitIcon (ref), PlayerEvent (ref), bulletHoleEffect (ref), CharScope (ref), PlayerFunc (ref)
                                        local Instance2 = u491.Instance;

                                        local function v499(p494, p495) -- Line: 679
                                            -- upvalues: u6 (ref), LocalPlayer (ref), Config (ref), u3 (ref), u491 (copy), GameRules (ref), Instance2 (copy), targetHitIcon (ref), PlayerEvent (ref), u492 (copy), u493 (copy)
                                            if u6.canPenetrate(LocalPlayer, p494, Config) then
                                                local v496, v497 = u6.canCombat(LocalPlayer, p494, Config.WANTED_COMBAT);

                                                if u6.typeOf(v496) == "string" then
                                                    if not u6.rest(v497, 60, LocalPlayer) then
                                                        u3.notify({
                                                            message = v496
                                                        });
                                                    end;
                                                elseif v496 then
                                                    if not p495 and Config.DAMAGE > 0 then
                                                        u3.emitBlood(p494, u491.Position);
                                                    end;

                                                    local v498 = GameRules.characterMeshesToBodyParts[Instance2.Name];

                                                    if Instance2.Name == "Head" then
                                                        targetHitIcon(Color3.fromRGB(255, 137, 97));
                                                        PlayerEvent:FireServer("damage", {
                                                            bodyParts = v498 and {
                                                                { v498, 1 }
                                                            },
                                                            shotCode = u492,
                                                            pos = u491.Position,
                                                            target = p494,
                                                            damageFactor = (u493 or 1) * 1.5,
                                                            bulletProofTool = p495
                                                        });

                                                        return;
                                                    end;

                                                    targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                    PlayerEvent:FireServer("damage", {
                                                        bodyParts = v498 and {
                                                            { v498, 1 }
                                                        },
                                                        shotCode = u492,
                                                        pos = u491.Position,
                                                        target = p494,
                                                        damageFactor = u493,
                                                        bulletProofTool = p495
                                                    });
                                                end;
                                            end;
                                        end;

                                        if Instance2:IsDescendantOf(workspace.Characters) then
                                            if u6.toolSystem.isTool(Instance2.Parent) then
                                                local v500 = require(u6.availableItems[Instance2.Parent.Name].Config).BULLET_PROOF_DURABILITY and u6.getPlayerFromCharacter(Instance2.Parent.Parent);

                                                if v500 then
                                                    v499(v500, Instance2.Parent);
                                                end;
                                            else
                                                local PlayerFromCharacter = u6.getPlayerFromCharacter(Instance2.Parent);

                                                if PlayerFromCharacter then
                                                    v499(PlayerFromCharacter);

                                                    return;
                                                end;
                                            end;

                                            return;
                                        end;

                                        if Instance2.Parent.Name == "PVPNPC" then
                                            v499(Instance2.Parent);

                                            return;
                                        end;

                                        if Instance2:IsDescendantOf(workspace.Gameplay.Vehicles) then
                                            if Instance2.Name == "WheelCollision" and not Instance2:GetAttribute("DontPuncture") then
                                                local Parent = Instance2:GetRootPart().Parent;
                                                local v501 = u6.getVehicleInfo.lastDrove(Parent, true);

                                                if v501 and v501 ~= LocalPlayer then
                                                    local v502 = u6.canPunctureTire(LocalPlayer, v501);

                                                    if v502 == true then
                                                        if Instance2:GetAttribute("Durability") ~= 0 then
                                                            targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                        end;

                                                        PlayerEvent:FireServer("damage", {
                                                            shotCode = u492,
                                                            pos = u491.Position,
                                                            targetTire = Instance2
                                                        });

                                                        return;
                                                    end;

                                                    if not u6.rest((v502 or "combat") .. "Tire", 60, LocalPlayer) then
                                                        u3.notify({
                                                            message = v502 == "policeShootingNonCivilian" and "Cannot puncture non-civilian vehicle" or (v502 == "policeShootingNotWanted" and "Cannot puncture a vehicle of player that is not wanted" or (v502 == "policeShootingCriminalInside" and "Cannot puncture a vehicle of criminal that is inside building" or (v502 == "crewmateCombat" and "Cannot puncture a crew member\'s vehicle" or "Cannot puncture a vehicle of player not in Combat Mode")))
                                                        });
                                                    end;
                                                end;
                                            elseif not Config.NO_HOLE then
                                                bulletHoleEffect(u491);
                                            end;
                                        elseif Instance2.Parent:GetAttribute("Pet") then
                                            if Instance2.Parent ~= u6.getInstanceAttribute(LocalPlayer, "Pet") then
                                                local v503, v504 = u6.canCombat(LocalPlayer, game.Players[Instance2.Parent.Parent.Name], nil, true);

                                                if u6.typeOf(v503) == "string" then
                                                    if not u6.rest(v504, 60, LocalPlayer) then
                                                        u3.notify({
                                                            message = v503
                                                        });
                                                    end;
                                                elseif v503 then
                                                    targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                    PlayerEvent:FireServer("damage", {
                                                        shotCode = u492,
                                                        pos = u491.Position,
                                                        targetPet = Instance2.Parent,
                                                        damageFactor = u493
                                                    });
                                                end;
                                            end;
                                        elseif not Instance2:IsDescendantOf(workspace.Gameplay.Entities) then
                                            if Instance2.Parent:FindFirstChild("Humanoid") then
                                                return;
                                            end;

                                            if Instance2.Name == "_TargetHitIcon" or Instance2.Name == "_TargetHitIconHead" then
                                                targetHitIcon(Instance2.Name == "_TargetHitIcon" and Color3.fromRGB(212, 212, 212) or Color3.fromRGB(255, 137, 97));
                                            elseif Instance2.Parent:GetAttribute("GiveDamageMission") then
                                                CharScope.taskDefer(function() -- Line: 745
                                                    -- upvalues: PlayerFunc (ref), Instance2 (copy), Config (ref)
                                                    PlayerFunc:InvokeServer("talkToMission", Instance2.Parent, {
                                                        dmg = Config.DAMAGE
                                                    });
                                                end);
                                            end;

                                            if not Config.NO_HOLE then
                                                bulletHoleEffect(u491);
                                            end;
                                        end;
                                    end;

                                    local u506 = u6.raycastParamsNew();
                                    u506.FilterType = Enum.RaycastFilterType.Exclude;
                                    u506.FilterDescendantsInstances = { workspace.Gameplay, workspace.Characters };
                                    local u507 = 0;
                                    local u508 = 0;

                                    local function u519(u509, u510, u511, p512) -- Line: 758
                                        -- upvalues: Config (copy), u6 (ref), u8 (ref), u19 (ref)
                                        local u513 = p512 or {};
                                        local v518 = u509.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) and u6.raycastVisible(u510, u511, u19, {
                                            customRequirements = function(p514) -- Line: 761, Name: customRequirements
                                                -- upvalues: Config (ref), u509 (copy), u6 (ref), u8 (ref), u510 (copy), u511 (copy), u513 (ref)
                                                if p514 then
                                                    if p514.Instance.Name == "_Glass" and (not Config.CANT_PRENETRATE_GLASS and (u509.Position - p514.Position).Magnitude < 2) then
                                                        local Parent = p514.Instance.Parent.Parent;
                                                        local v515 = u6.raycastParamsNew();
                                                        v515.FilterDescendantsInstances = { u8, Parent };
                                                        v515.IgnoreWater = true;
                                                        local v516 = u6.raycastVisible(u510, u511 + u6.smartUnit(u511) * 20, v515, {
                                                            character = true
                                                        });

                                                        if not (v516 and (v516.Instance.Parent.Parent == workspace.Characters and (u6.getPlayerFromCharacter(v516.Instance.Parent) and u6.getVehicleInfo.inVehicle(u6.getPlayerFromCharacter(v516.Instance.Parent)) == Parent))) then
                                                            return p514;
                                                        end;

                                                        if u513.windowHit then
                                                            u513.windowHit(p514);
                                                        end;

                                                        return v516;
                                                    end;

                                                    local v517 = u513.hit and ((u509.Position - p514.Position).Magnitude < 2 and u513.hit(p514));

                                                    if v517 then
                                                        return v517;
                                                    end;
                                                end;
                                            end
                                        });

                                        if v518 then
                                            return v518;
                                        end;
                                    end;

                                    local function u549() -- Line: 785
                                        -- upvalues: u507 (ref), u483 (ref), u508 (ref), u2 (ref), Config (copy), Barrel (copy), u18 (ref), CharScope (ref), u6 (ref), u480 (copy), BulletShooterPov (ref), getProperCameraUnitRay (ref), u19 (ref), u519 (copy), u506 (copy), PlayerEvent (ref), u439 (ref), RunService (ref), bulletHoleEffect (ref), u3 (ref), u505 (copy)
                                        u507 = (u507 + 1) % 100;
                                        local v520 = tick();
                                        u483 = math.max(0, 0.5 - v520 + u508) / 0.5 * u483 * 0.1 + 0.3;
                                        u508 = v520;

                                        if u2.gunRecoilFirstPerson then
                                            u2.gunRecoilFirstPerson(Config.RECOIL, Barrel);
                                        end;

                                        local v521 = Config.RECOIL * 25;
                                        local v522 = 1 / (Config.ACCURACY or 0.1 or 1);
                                        local v523 = v521 * (math.random(u483 * v522, u483 * v522) / v522);
                                        local math_rad_ret = math.rad(v523);
                                        local v524 = 1 / (Config.ACCURACY or 0.1 or 1);
                                        local v525 = v521 * (math.random(-0.1 * v524, 0.1 * v524) / v524);
                                        local math_rad_ret2 = math.rad(v525);
                                        local v526 = 1 / (Config.ACCURACY or 0.1 or 1);
                                        local v527 = v521 * (math.random(-0.5 * v526, 0.5 * v526) / v526);
                                        local math_rad_ret3 = math.rad(v527);
                                        u18.accelerate((Vector3.new(math_rad_ret, math_rad_ret2, math_rad_ret3)));
                                        CharScope.taskDelay(0.03, function() -- Line: 797
                                            -- upvalues: u18 (ref), math_rad_ret (copy), math_rad_ret2 (copy), math_rad_ret3 (copy)
                                            u18.accelerate((Vector3.new(-math_rad_ret, -math_rad_ret2, -math_rad_ret3)));
                                        end);
                                        u6.playSoundReplicate(u480);
                                        local u528 = nil;
                                        local v529 = Config.BULLET_DISTANCE or 600;
                                        local u530 = Config.BULLET_TYPE and u6.clone(game.ReplicatedStorage.Gameplay.Weapons[Config.BULLET_TYPE]) or u6.clone(BulletShooterPov);
                                        local v531 = getProperCameraUnitRay(10);
                                        local v532 = u6.bulletSpread(v531.length.Unit, (Config.TR_DIFF or 0) + (u2.jumpingShootingSpread and 70 or 0)) * 1000;
                                        local v533 = u6.raycastVisible(v531.origin, v532, u19, {
                                            character = true
                                        });

                                        if v533 and not v533.Instance:IsDescendantOf(workspace.Characters) then
                                            v533 = u519(v533, v531.origin, v532) or v533;
                                        end;

                                        local v534 = v533 and v533.Position or v531.origin + v532;
                                        local CFrame_new_ret = CFrame.new(Barrel.WorldPosition, v534);
                                        u530.CFrame = CFrame_new_ret;
                                        u530.Parent = workspace.Gameplay.Entities;
                                        local LookVector = CFrame_new_ret.LookVector;
                                        local v535 = u6.raycastVisible(CFrame_new_ret.Position, LookVector * v529, u506);
                                        local X = (CFrame_new_ret.Position + LookVector * v529).X;
                                        local v536;

                                        if v535 then
                                            v536 = v535.Position.X or X;
                                        else
                                            v536 = X;
                                        end;

                                        local u537 = u6.bulletPosDestroyXCheck(nil, X, u530);
                                        PlayerEvent:FireServer("bullet", {
                                            pos = v534,
                                            posDestroyX = v536,
                                            weaponName = u439.Name
                                        });

                                        local function u538() -- Line: 829
                                            -- upvalues: u530 (copy), u528 (ref), Config (ref)
                                            if u530.Parent then
                                                u528:Disconnect();

                                                if Config.BULLET_DESTROY_DELAY then
                                                    task.wait(Config.BULLET_DESTROY_DELAY);
                                                end;

                                                u530:Destroy();
                                            end;
                                        end;

                                        local u539 = { CFrame_new_ret.Position, CFrame_new_ret.LookVector };
                                        CharScope.taskDefer(function() -- Line: 837
                                            -- upvalues: u528 (ref), RunService (ref), u6 (ref), u537 (copy), X (copy), u530 (copy), u538 (copy), LookVector (copy), Config (ref), u19 (ref), bulletHoleEffect (ref), u3 (ref), u519 (ref), u505 (ref), u539 (copy)
                                            u528 = RunService.Heartbeat:Connect(function(p540) -- Line: 838
                                                -- upvalues: u6 (ref), u537 (ref), X (ref), u530 (ref), u538 (ref), LookVector (ref), Config (ref), u19 (ref), bulletHoleEffect (ref), u3 (ref), u519 (ref), u505 (ref), u539 (ref)
                                                if u6.bulletPosDestroyXCheck(u537, X, u530) then
                                                    return u538();
                                                end;

                                                local Position = u530.Position;
                                                local v541 = LookVector * (Config.BULLET_SPEED or 2000) * p540;
                                                local u542 = u6.raycastVisible(Position, v541, u19, {
                                                    character = true
                                                });
                                                u530.CFrame = u530.CFrame + v541;

                                                if u542 then
                                                    local u543 = nil;

                                                    local function v545(p544) -- Line: 846
                                                        -- upvalues: u543 (ref), Config (ref), bulletHoleEffect (ref)
                                                        u543 = 0.6;

                                                        if not Config.NO_HOLE then
                                                            bulletHoleEffect(p544);
                                                        end;
                                                    end;

                                                    local function v548(p546) -- Line: 850
                                                        -- upvalues: u3 (ref), u542 (ref)
                                                        local Instance2 = p546.Instance;
                                                        local v547;

                                                        if Instance2.Name == "WheelCollision" then
                                                            v547 = Instance2;
                                                        elseif u3.platform == "Mobile" or u3.platform == "Console" then
                                                            v547 = Instance2.Name == "Rim" and Instance2.Parent.WheelCollision;

                                                            if not v547 then
                                                                if Instance2.Parent.Name == "Rim" then
                                                                    v547 = Instance2.Parent.Parent.Tire.WheelCollision;
                                                                else
                                                                    v547 = false;
                                                                end;
                                                            end;
                                                        else
                                                            v547 = nil;
                                                        end;

                                                        if v547 and (u542.Position - v547.Position).Magnitude < 2 then
                                                            return {
                                                                Instance = v547,
                                                                Position = p546.Position,
                                                                Material = p546.Material,
                                                                Normal = p546.Normal
                                                            };
                                                        end;
                                                    end;

                                                    if not u542.Instance:IsDescendantOf(workspace.Characters) then
                                                        u542 = u519(u542, Position, v541, {
                                                            windowHit = v545,
                                                            hit = v548
                                                        }) or u542;
                                                    end;

                                                    u505(u542, u539, u543);

                                                    return u538();
                                                end;
                                            end);
                                        end);
                                        CharScope.taskDelay(5, u538);
                                    end;

                                    local function u550() -- Line: 868
                                        -- upvalues: u16 (ref), u439 (ref), u549 (copy), u6 (ref), Barrel (copy), CharScope (ref), Ammo (ref), u478 (copy), Config (copy)
                                        u16[u439] = true;
                                        u549();
                                        u6.emit(Barrel.DischargeFlashClient, 3);
                                        Barrel.DischargeLight.Enabled = true;
                                        CharScope.taskDelay(0.03, function() -- Line: 873
                                            -- upvalues: Barrel (ref)
                                            Barrel.DischargeLight.Enabled = false;
                                        end);
                                        u439.Config.Ammo.Value = u439.Config.Ammo.Value - 1;
                                        Ammo.ImageLabel2.Ammo.Text = u439.Config.Ammo.Value;

                                        if u439.Config.Ammo.Value == 0 then
                                            u478(function() -- Line: 877
                                                -- upvalues: Config (ref), u16 (ref), u439 (ref)
                                                task.wait(60 / Config.RPM);
                                                u16[u439] = nil;
                                            end);

                                            return;
                                        end;

                                        task.wait(60 / Config.RPM);
                                        u16[u439] = nil;
                                    end;

                                    local function u552(p551) -- Line: 886
                                        -- upvalues: Barrel (copy), u6 (ref), u8 (ref), u43 (ref), u485 (ref), u467 (ref), u439 (ref), u16 (ref), u1 (ref), u3 (ref), Ragdoll (ref), Mobile (ref), Config (copy), u550 (copy), u484 (ref), u444 (ref), u82 (ref), u17 (ref), u549 (copy), CharScope (ref), Animator (ref)
                                        if not (u6.raycastVisible(u8.Head.Position, Barrel.WorldPosition - u8.Head.Position, u43) or (u485 or (u467 or (u439.Config.Ammo.Value <= 0 or u16[u439])))) then
                                            if not (u1.isAiming or (p551 or (u3.openedGui or Ragdoll.isActive))) then
                                                u1.shoulderCam(true);
                                                u6.mobileButtonPressed(Mobile.Aim.Aim, true);
                                            end;

                                            if u1.isAiming then
                                                if Config.SHOOT_MODE == 1 then
                                                    u550();

                                                    return;
                                                end;

                                                if Config.SHOOT_MODE == 2 then
                                                    u6.mobileButtonPressed(Mobile.Gun.Fire, true);
                                                    u484 = true;

                                                    while u444 == u82 and (u1.isAiming and (u484 and (u439.Config.Ammo.Value > 0 and not (u16[u439] or u467)))) do
                                                        u550();
                                                    end;
                                                else
                                                    if Config.SHOOT_MODE == 3 then
                                                        if u17[u439] then
                                                            return;
                                                        end;

                                                        u17[u439] = true;

                                                        for i = 1, 3 do
                                                            if u467 or u439.Config.Ammo.Value == 0 then
                                                                u17[u439] = nil;

                                                                return;
                                                            end;

                                                            u550();
                                                            local _ = i;
                                                        end;

                                                        task.wait(Config.BURST_COOLDOWN);
                                                        u17[u439] = nil;

                                                        return;
                                                    end;

                                                    if Config.SHOOT_MODE == 4 then
                                                        for i = 1, Config.BULLET_AMOUNT - 1 do
                                                            u549();
                                                            local _ = i;
                                                        end;

                                                        if Config.SHOTGUN_QUICK_RELOAD then
                                                            CharScope.taskDelay(0.3, function() -- Line: 918
                                                                -- upvalues: u6 (ref), Animator (ref)
                                                                u6.animationBuffer(Animator, "play", "ShotgunQuickReload");
                                                            end);
                                                        end;

                                                        u550();
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;

                                    local function _() -- Line: 927
                                        -- upvalues: u6 (ref), Mobile (ref), u484 (ref)
                                        u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                        u484 = false;
                                    end;

                                    CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p553, p554) -- Line: 931
                                            -- upvalues: u3 (ref), u552 (copy), u478 (copy)
                                            if p553.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                                if p553.KeyCode == Enum.KeyCode.R and u3.canPressKey(p553.KeyCode) then
                                                    u478();
                                                end;

                                                return;
                                            end;

                                            if u3.isMouseObstructedByBlackBackground() then
                                                return;
                                            end;

                                            u552(p554);
                                        end });
                                    CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p555) -- Line: 939
                                            -- upvalues: u6 (ref), Mobile (ref), u484 (ref)
                                            if p555.UserInputType == Enum.UserInputType.MouseButton1 then
                                                u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                                u484 = false;
                                            end;
                                        end });
                                    CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Gun.Fire, function() -- Line: 945
                                        -- upvalues: CharScope (ref), u552 (copy), u3 (ref), u6 (ref), Mobile (ref), u484 (ref)
                                        CharScope.taskSpawn(u552);
                                        u3.mobileInputServiceClick();
                                        u6.mobileButtonPressed(Mobile.Gun.Fire, false);
                                        u484 = false;
                                    end));
                                    CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Gun.Reload, u478));
                                    CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(0.4, function() -- Line: 952
                                        -- upvalues: u485 (ref), u3 (ref), Config (copy), CharScope (ref), u552 (copy)
                                        u485 = false;

                                        if u3.isMouseButton1Pressed() and (u3.platform ~= "Mobile" and Config.SHOOT_MODE == 2) then
                                            CharScope.taskSpawn(u552);
                                        end;
                                    end));
                                end;
                            elseif Config.CATEGORY == "Melee" then
                                if u443 == true then
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 959
                                        -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref)
                                        u2.keepMobileGuiTypePersistent("Melee", false);

                                        if u1.isAiming then
                                            u1.shoulderCam(false);
                                        end;

                                        u3.activateMouseIcon(false);
                                        u2.keepMobileGuiTypePersistent("Aim", false);
                                        u6.animationBuffer(Animator, "unload", "MeleeAim", "MeleeAimStabilize", "MeleeSwingLeft", "MeleeSwingRight");
                                    end);
                                    local u556 = { "MeleeSwingLeft", "MeleeSwingRight" };
                                    u2.keepMobileGuiTypePersistent("Melee", true);
                                    u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.MeleeAim, PlayerStuff.Items.Animations.MeleeAimStabilize, PlayerStuff.Items.Animations.MeleeSwingLeft, PlayerStuff.Items.Animations.MeleeSwingRight);
                                    u446.hitHumanSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "HitHuman");
                                    u446.hitSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "Hit");
                                    u446.swingSound = PlayerStuff.Items.Sounds:WaitForChild(Config.CATEGORY .. "Swing");
                                    aimSystem({
                                        MeleeAimStabilize = 0.7,
                                        MeleeAim = 1
                                    }, "Dot", nil, nil, true);
                                    local u557 = true;
                                    CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(0.4, function() -- Line: 972
                                        -- upvalues: u557 (ref)
                                        u557 = false;
                                    end));

                                    local function u574(p558) -- Line: 975
                                        -- upvalues: u557 (ref), u6 (ref), Config (copy), u439 (ref), u1 (ref), u3 (ref), Ragdoll (ref), Mobile (ref), Animator (ref), u556 (copy), u446 (copy), getProperCameraUnitRay (ref), u19 (ref), LocalPlayer (ref), targetHitIcon (ref), GameRules (ref), PlayerEvent (ref), workspace_CurrentCamera (ref), CharScope (ref), PlayerFunc (ref)
                                        if not (u557 or u6.rest("Rest", Config.REST_TIME, u439)) then
                                            if not (u1.isAiming or (p558 or (u3.openedGui or Ragdoll.isActive))) then
                                                u1.shoulderCam(true);
                                                u6.mobileButtonPressed(Mobile.Aim.Aim, true);
                                            end;

                                            if u1.isAiming then
                                                u6.animationBuffer(Animator, "play", u556[math.random(#u556)], 0.1);
                                                u446.swingSound:Play();
                                                local v559 = getProperCameraUnitRay(6);
                                                local u560 = u6.raycastVisible(v559.origin, v559.length, u19, {
                                                    character = true
                                                });

                                                if u560 then
                                                    local Instance2 = u560.Instance;

                                                    local function v566(p561, p562) -- Line: 992
                                                        -- upvalues: u6 (ref), LocalPlayer (ref), Config (ref), u3 (ref), u446 (ref), targetHitIcon (ref), u560 (copy), GameRules (ref), Instance2 (copy), PlayerEvent (ref), workspace_CurrentCamera (ref)
                                                        if u6.canPenetrate(LocalPlayer, p561, Config) then
                                                            local v563, v564 = u6.canCombat(LocalPlayer, p561, Config.WANTED_COMBAT);

                                                            if u6.typeOf(v563) == "string" then
                                                                if not u6.rest(v564, 60, LocalPlayer) then
                                                                    u3.notify({
                                                                        message = v563
                                                                    });
                                                                end;
                                                            elseif v563 then
                                                                u446.hitHumanSound:Play();
                                                                targetHitIcon(Color3.fromRGB(212, 212, 212));

                                                                if not p562 and Config.DAMAGE > 0 then
                                                                    u3.emitBlood(p561, u560.Position);
                                                                end;

                                                                local v565 = GameRules.characterMeshesToBodyParts[Instance2.Name];
                                                                PlayerEvent:FireServer("damage", {
                                                                    bodyParts = v565 and {
                                                                        { v565, 1 }
                                                                    },
                                                                    shotCode = { workspace_CurrentCamera.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector },
                                                                    pos = u560.Position,
                                                                    target = p561,
                                                                    bulletProofTool = p562
                                                                });
                                                            end;
                                                        end;
                                                    end;

                                                    if Instance2:IsDescendantOf(workspace.Characters) then
                                                        if u6.toolSystem.isTool(Instance2.Parent) then
                                                            local v567 = require(u6.availableItems[Instance2.Parent.Name].Config).BULLET_PROOF_DURABILITY and u6.getPlayerFromCharacter(Instance2.Parent.Parent);

                                                            if v567 then
                                                                v566(v567, Instance2.Parent);
                                                            end;
                                                        else
                                                            local PlayerFromCharacter = u6.getPlayerFromCharacter(Instance2.Parent);

                                                            if PlayerFromCharacter then
                                                                v566(PlayerFromCharacter);

                                                                return;
                                                            end;
                                                        end;

                                                        return;
                                                    end;

                                                    if Instance2.Parent.Name == "PVPNPC" then
                                                        v566(Instance2.Parent);

                                                        return;
                                                    end;

                                                    if Instance2.Name == "_TargetHitIcon" or Instance2.Name == "_TargetHitIconHead" then
                                                        targetHitIcon(Instance2.Name == "_TargetHitIcon" and Color3.fromRGB(212, 212, 212) or Color3.fromRGB(255, 137, 97));
                                                    elseif Instance2.Parent:GetAttribute("GiveDamageMission") then
                                                        CharScope.taskDefer(function() -- Line: 1027
                                                            -- upvalues: PlayerFunc (ref), Instance2 (copy), Config (ref)
                                                            PlayerFunc:InvokeServer("talkToMission", Instance2.Parent, {
                                                                dmg = Config.DAMAGE
                                                            });
                                                        end);
                                                    end;

                                                    u446.hitSound:Play();
                                                    local v568 = u6.clone(game.ReplicatedStorage.Gameplay.Weapons.MeleeHit);
                                                    v568.CFrame = CFrame.new(u560.Position, u560.Position + u560.Normal);
                                                    u6.emit(v568.Smoke, 20);
                                                    u6.emit(v568.Impact, 1);
                                                    v568.Parent = workspace.Gameplay.Entities;
                                                    u6.debrisServiceAddItem(v568, 10);
                                                    local v571 = u6.raycastVisible(v559.origin, v559.length, u19, {
                                                        customRequirements = function(p569) -- Line: 1037, Name: customRequirements
                                                            -- upvalues: u3 (ref), u560 (copy)
                                                            if p569 then
                                                                local Instance3 = p569.Instance;
                                                                local v570;

                                                                if Instance3.Name == "WheelCollision" then
                                                                    v570 = Instance3;
                                                                elseif u3.platform == "Mobile" or u3.platform == "Console" then
                                                                    v570 = Instance3.Name == "Rim" and Instance3.Parent.WheelCollision;

                                                                    if not v570 then
                                                                        if Instance3.Parent.Name == "Rim" then
                                                                            v570 = Instance3.Parent.Parent.Tire.WheelCollision;
                                                                        else
                                                                            v570 = false;
                                                                        end;
                                                                    end;
                                                                else
                                                                    v570 = nil;
                                                                end;

                                                                if v570 and (u560.Position - v570.Position).Magnitude < 2 then
                                                                    return {
                                                                        Instance = v570,
                                                                        Position = p569.Position,
                                                                        Material = p569.Material,
                                                                        Normal = p569.Normal
                                                                    };
                                                                end;
                                                            end;
                                                        end
                                                    });

                                                    if v571 then
                                                        if v571.Instance.Name == "WheelCollision" and not v571.Instance:GetAttribute("DontPuncture") then
                                                            local Parent = v571.Instance:GetRootPart().Parent;
                                                            local v572 = u6.getVehicleInfo.lastDrove(Parent, true);

                                                            if v572 and v572 ~= LocalPlayer then
                                                                local v573 = u6.canPunctureTire(LocalPlayer, v572);

                                                                if v573 == true then
                                                                    if v571.Instance:GetAttribute("Durability") ~= 0 then
                                                                        targetHitIcon(Color3.fromRGB(212, 212, 212));
                                                                    end;

                                                                    PlayerEvent:FireServer("damage", {
                                                                        shotCode = { workspace_CurrentCamera.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector },
                                                                        pos = v571.Position,
                                                                        targetTire = v571.Instance
                                                                    });

                                                                    return;
                                                                end;

                                                                if not u6.rest((v573 or "combat") .. "Tire", 60, LocalPlayer) then
                                                                    u3.notify({
                                                                        message = v573 == "policeShootingNonCivilian" and "Cannot puncture non-civilian vehicle" or (v573 == "policeShootingNotWanted" and "Cannot puncture a vehicle of player that is not wanted" or (v573 == "policeShootingCriminalInside" and "Cannot puncture a vehicle of criminal that is inside building" or (v573 == "crewmateCombat" and "Cannot puncture a crew member\'s vehicle" or "Cannot puncture a vehicle of player not in Combat Mode")))
                                                                    });
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;

                                    CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p575, p576) -- Line: 1066
                                            -- upvalues: u3 (ref), u574 (copy)
                                            if p575.UserInputType == Enum.UserInputType.MouseButton1 then
                                                if u3.isMouseObstructedByBlackBackground() then
                                                    return;
                                                end;

                                                u574(p576);
                                            end;
                                        end });
                                    CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.Melee.Hit, u574));
                                end;
                            elseif Config.CATEGORY == "Pocket" or Config.CATEGORY == "Jewelry" then
                                if u443 == true then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    actionEvent(function() -- Line: 1078
                                        -- upvalues: u6 (ref), u439 (ref), Config (copy), u3 (ref), PlayerEvent (ref), u1 (ref)
                                        local v577 = u6.findSlotWithItemId(nil, u439:GetAttribute("Id"));
                                        local string_lower_ret = string.lower(Config.CATEGORY);
                                        local v578 = u3.inventory[v577];
                                        u3.inventory[v577] = nil;

                                        if u6.slotMovedInventory(nil, u3.inventory, u3.inventory, v578, {
                                            fromSize = 999,
                                            toSize = 999,
                                            from = v577,
                                            to = string_lower_ret
                                        }) == true then
                                            PlayerEvent:FireServer("modifyInventory", {
                                                from = v577,
                                                to = string_lower_ret
                                            });
                                            u1.equipSlot();
                                            u3.notify({
                                                message = "Equipped",
                                                color = "green"
                                            });
                                        end;

                                        u1.renderInventoryBar();
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1091
                                        -- upvalues: u2 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                    end);
                                end;
                            elseif u439.Name == "Medicine" then
                                if u443 == true or u443 == "Vehicle" then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    u446.actionSound = Handle:WaitForChild("ActionSound");
                                    local u579 = true;
                                    actionEvent(function() -- Line: 1100
                                        -- upvalues: u579 (ref), Humanoid (ref), u8 (ref), u6 (ref), u446 (copy), u453 (ref), GameRules (ref), CharScope (ref), Config (copy), PlayerEvent (ref), u3 (ref)
                                        if u579 then
                                            if Humanoid.Health < 100 then
                                                if u8:GetAttribute("MedicineUsed") then
                                                    u3.notify({
                                                        message = "You cannot take another yet",
                                                        color = "red"
                                                    });

                                                    return;
                                                end;

                                                u579 = false;
                                                u6.playSoundReplicate(u446.actionSound);
                                                u6.playAnimation(u453, "play", GameRules.defaultCharacterAnimationFadeTime);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "medicineThread", CharScope.taskDelay(Config.HOLD_DURATION, function() -- Line: 1107
                                                    -- upvalues: PlayerEvent (ref), u8 (ref), u6 (ref), u453 (ref), GameRules (ref), u579 (ref)
                                                    PlayerEvent:FireServer("medicine", u8);
                                                    u6.playAnimation(u453, "stop", GameRules.defaultCharacterAnimationFadeTime);
                                                    u579 = true;
                                                end));

                                                return;
                                            end;

                                            u3.notify({
                                                message = "You already have full health",
                                                color = "red"
                                            });
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1116
                                        -- upvalues: u2 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                    end);
                                end;
                            elseif u439.Name == "PD Megaphone" then
                                if u443 == true then
                                    local ActionSound = u439:WaitForChild("Handle"):WaitForChild("ActionSound");
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    local u580 = false;
                                    local u581 = 0;
                                    u6.setToolGrip(nil, u439);
                                    actionEvent(function() -- Line: 1128
                                        -- upvalues: u581 (ref), u580 (ref), PlayerEvent (ref), u8 (ref), u6 (ref), u453 (ref), GameRules (ref), u439 (ref), ActionSound (copy)
                                        u581 = (u581 + 1) % 1000;
                                        u580 = not u580;
                                        PlayerEvent:FireServer("megaphoneTool", u8, u580);
                                        u6.playAnimation(u453, u580 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                        local setToolGrip = u6.setToolGrip;
                                        local v582 = u580 and CFrame.new(
                                            -0.0797643661,
                                            -0.262356758,
                                            0.0542488098,
                                            0.86479944,
                                            0.163539141,
                                            -0.474740922,
                                            -0.229441151,
                                            0.969698906,
                                            -0.0839129761,
                                            0.446632087,
                                            0.181492448,
                                            0.876116514
                                        );
                                        setToolGrip(nil, u439, v582);
                                        u6.playSoundReplicate(ActionSound);
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1141
                                        -- upvalues: u2 (ref), PlayerEvent (ref), u8 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        PlayerEvent:FireServer("megaphoneTool", u8, false);
                                    end);
                                end;
                            elseif u439.Name == "Driver\'s License" then
                                if u443 == true or u443 == "Vehicle" then
                                    local _ = ScreenGui.Center.Middle.DriversLicense;
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    local u583 = false;
                                    u6.setToolGrip(nil, u439);
                                    actionEvent(function() -- Line: 1152
                                        -- upvalues: u583 (ref), u6 (ref), u8 (ref), u453 (ref), GameRules (ref), u439 (ref)
                                        u583 = not u583;
                                        u6.selectiveObjReplicaSystem("driversLicense", u8, u583);
                                        u6.playAnimation(u453, u583 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                        local setToolGrip = u6.setToolGrip;
                                        local v584 = u583 and CFrame.new(
                                            -0.0897827148,
                                            -0.157539845,
                                            0.444522858,
                                            0.859363258,
                                            0.314252466,
                                            -0.403410852,
                                            -0.163115919,
                                            0.916135609,
                                            0.366182953,
                                            0.484652847,
                                            -0.248881757,
                                            0.838552713
                                        );
                                        setToolGrip(nil, u439, v584);
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1158
                                        -- upvalues: u2 (ref), u6 (ref), u8 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        u6.selectiveObjReplicaSystem("driversLicense", u8, false);
                                    end);
                                end;
                            elseif u439.Name == "PD Flashlight" or (u439.Name == "FD Flashlight" or (u439.Name == "MT Flashlight" or u439.Name == "Flashlight")) then
                                if u443 == true then
                                    local Handle2 = u439:WaitForChild("Handle");
                                    local Light = u439:WaitForChild("Light");
                                    local SpotLight = Light:WaitForChild("SpotLight");
                                    local On = Handle2:WaitForChild("On");
                                    local Off = Handle2:WaitForChild("Off");
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    local u585 = 0;
                                    local u586 = false;
                                    u6.setToolGrip(nil, u439);
                                    actionEvent(function() -- Line: 1179
                                        -- upvalues: u585 (ref), u586 (ref), Light (copy), SpotLight (copy), PlayerEvent (ref), u8 (ref), u6 (ref), u453 (ref), GameRules (ref), u439 (ref), On (copy), Off (copy), CharScope (ref)
                                        u585 = (u585 + 1) % 1000;
                                        u586 = not u586;
                                        Light.Transparency = u586 and 0 or 1;
                                        SpotLight.Enabled = u586;
                                        PlayerEvent:FireServer("flashlight", u8, u586);
                                        u6.playAnimation(u453, u586 and "play" or "stop", GameRules.defaultCharacterAnimationFadeTime);
                                        local setToolGrip = u6.setToolGrip;
                                        local v587 = u586 and CFrame.new(
                                            0.25743866,
                                            -0.0461893082,
                                            -0.0762119293,
                                            -0.819851518,
                                            -0.463403404,
                                            0.336306721,
                                            -0.304887235,
                                            0.850479722,
                                            0.42863512,
                                            -0.484652698,
                                            0.248881668,
                                            -0.838552594
                                        );
                                        setToolGrip(nil, u439, v587);
                                        u6.playSoundReplicate(u586 and On or Off);

                                        if u586 then
                                            local u588 = u585;

                                            local function u589() -- Line: 1190
                                                -- upvalues: u588 (copy), u585 (ref)
                                                return u588 == u585;
                                            end;

                                            local u590 = nil;
                                            local u591 = 100;
                                            local u592 = 15;
                                            CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(15, function() -- Line: 454
                                                -- upvalues: u589 (copy), u590 (copy), PlayerEvent (ref), u439 (ref), u591 (copy), u592 (copy)
                                                while not u589 or u589() do
                                                    if not u590 or u590() then
                                                        PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), u591);
                                                    end;

                                                    task.wait(u592);
                                                end;
                                            end));
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1193
                                        -- upvalues: u2 (ref), Light (copy), SpotLight (copy), PlayerEvent (ref), u8 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        Light.Transparency = 1;
                                        SpotLight.Enabled = false;
                                        PlayerEvent:FireServer("flashlight", u8, false);
                                    end);
                                end;
                            elseif u439.Name == "Binoculars" or (u439.Name == "PD Binoculars" or (u439.Name == "News Camera" or (u439.Name == "PD Camera" or u439.Name == "Camera"))) then
                                if u443 == true then
                                    local u593 = 0;

                                    local function u594() -- Line: 1205
                                        -- upvalues: ScreenGui (ref), u439 (ref)
                                        ScreenGui.Center.HideGuiBottom.NewsCameraItem.Headline.Text = string.upper(u439:GetAttribute("Headline") or "BREAKING NEWS");
                                        ScreenGui.Center.HideGuiBottom.NewsCameraItem.Description.Text = string.upper(u439:GetAttribute("Description") or "BREAKING NEWS IN THE CITY OF SAN AURIE | BROADCASTING LIVE");
                                    end;

                                    local function u595() -- Line: 1209
                                        -- upvalues: u439 (ref), u3 (ref), TweenService (ref), workspace_CurrentCamera (ref), u593 (ref), LocalPlayer (ref), u6 (ref), u2 (ref)
                                        if u439.Name == "News Camera" then
                                            u3.hideGui();
                                            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                FieldOfView = u3.initialFOV
                                            }):Play();
                                        elseif u439.Name == "Binoculars" or u439.Name == "PD Binoculars" then
                                            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                FieldOfView = u3.initialFOV
                                            }):Play();
                                        elseif u439.Name == "Camera" or u439.Name == "PD Camera" then
                                            u3.hideGui();
                                        end;

                                        u3.mouseIconGui.Visible = true;

                                        if u593 > 1 then
                                            LocalPlayer.CameraMaxZoomDistance = u593;
                                            LocalPlayer.CameraMinZoomDistance = u593;
                                        end;

                                        u6.setCameraProperties("3");
                                        u6.toolVisibility(u439, true);
                                        u2.setViewModelVisibility(true);
                                    end;

                                    u2.keepMobileGuiTypePersistent("Action", true);

                                    local function u596() -- Line: 1229
                                        -- upvalues: u593 (ref), HumanoidRootPart (ref), workspace_CurrentCamera (ref), u6 (ref), u439 (ref), u2 (ref), u3 (ref)
                                        u593 = (HumanoidRootPart.Position + Vector3.new(0, 1.5, 0) - workspace_CurrentCamera.CFrame.Position).Magnitude;
                                        u6.setCameraProperties("3", {
                                            CameraMaxZoomDistance = 0,
                                            CameraMinZoomDistance = 0
                                        });
                                        u6.toolVisibility(u439, false);
                                        u2.setViewModelVisibility(false);
                                        u3.mouseIconGui.Visible = false;
                                    end;

                                    if u439.Name == "News Camera" then
                                        u2.keepMobileGuiTypePersistent("NewsCamera", true);
                                        u594();
                                        local u597 = u3.readPlayerData("Settings", "ClockFormat");
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1240
                                            -- upvalues: ScreenGui (ref), u6 (ref), u3 (ref), u597 (copy)
                                            while true do
                                                ScreenGui.Center.HideGuiBottom.NewsCameraItem.Time.Text = u6.getClockFormat(u3.clockTime, u597);
                                                task.wait(1);
                                            end;
                                        end));
                                        local u598 = false;
                                        local u599 = 0;
                                        advancedInputStateChange(Enum.UserInputType.MouseButton1, Mobile.Action.Action, true, function() -- Line: 1260
                                            -- upvalues: u598 (ref)
                                            return u598;
                                        end, function(p600) -- Line: 1249, Name: activate
                                            -- upvalues: u599 (ref), u598 (ref), workspace_CurrentCamera (ref), u3 (ref), Mobile (ref), u596 (copy), u595 (copy)
                                            u599 = (u599 + 1) % 1000;
                                            u598 = p600;
                                            workspace_CurrentCamera.FieldOfView = u3.initialFOV;

                                            if not u598 then
                                                u595();

                                                return;
                                            end;

                                            u3.hideGui("NewsCameraItem", { Mobile });
                                            u596();
                                        end);

                                        local function u606() -- Line: 1261
                                            -- upvalues: u3 (ref), u598 (ref), u6 (ref), Ragdoll (ref), Mobile (ref), CharScope (ref), u439 (ref), u594 (copy)
                                            if u3.canPressKey() and not (u598 or u6.invokeTraffic.cameraEditText) then
                                                if u3.openedGui or Ragdoll.isActive then
                                                    return;
                                                end;

                                                u6.mobileButtonPressed(Mobile.NewsCamera.Edit, true);
                                                local v601 = u3.mainBox({
                                                    case = "Text",
                                                    headline = "Set news headline and description",
                                                    textPlaceholder = "Headline ; description",
                                                    textCanBeEmpty = true
                                                });
                                                u6.mobileButtonPressed(Mobile.NewsCamera.Edit, false);

                                                if v601 then
                                                    local u602, u603 = unpack(string.split(v601, ";"));
                                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "editText", CharScope.taskSpawn(function() -- Line: 1269
                                                        -- upvalues: u602 (copy), u603 (copy), u6 (ref), u439 (ref), u594 (ref)
                                                        local v604, v605;

                                                        if u602 or u603 then
                                                            v604, v605 = u6.invokeServerTraffic("cameraEditText", u602, u603);
                                                        else
                                                            v604 = nil;
                                                            v605 = nil;
                                                        end;

                                                        if not (v604 and (v604 ~= "" and v604)) then
                                                            v604 = nil;
                                                        end;

                                                        u439:SetAttribute("Headline", v604);
                                                        u439:SetAttribute("Description", v605);
                                                        u594();
                                                    end));
                                                end;
                                            end;
                                        end;

                                        CharScope.buildSignalData("Tool", { UserInputService.InputBegan, function(p607) -- Line: 1279
                                                -- upvalues: u3 (ref), u606 (copy)
                                                if p607.KeyCode == Enum.KeyCode.E and u3.canPressKey(p607.KeyCode) then
                                                    u606();
                                                end;
                                            end });
                                        CharScope.buildSignalData("Tool", u3.mouseButton(Mobile.NewsCamera.Edit, u606));
                                        CharScope.buildSignalData("Tool", { UserInputService.InputChanged, function(p608, p609) -- Line: 1283
                                                -- upvalues: u3 (ref), Ragdoll (ref), u598 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                                if u3.openedGui or (p609 or Ragdoll.isActive) then
                                                    return;
                                                end;

                                                if p608.UserInputType == Enum.UserInputType.MouseWheel and u598 then
                                                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p608.Position.Z * -5, 30, 70)
                                                    }):Play();
                                                end;
                                            end });
                                        local v611 = u6.touchPinch(function(p610) -- Line: 1289
                                            -- upvalues: u3 (ref), Ragdoll (ref), u598 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                            if u3.openedGui or Ragdoll.isActive then
                                                return;
                                            end;

                                            if u598 then
                                                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                    FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p610 * -15, 30, 70)
                                                }):Play();
                                            end;
                                        end);
                                        CharScope.buildSignalData("Tool", v611.signalData);
                                    elseif u439.Name == "Binoculars" or u439.Name == "PD Binoculars" then
                                        local u612 = false;
                                        advancedInputStateChange(Enum.UserInputType.MouseButton1, Mobile.Action.Action, true, function() -- Line: 1306
                                            -- upvalues: u612 (ref)
                                            return u612;
                                        end, function(p613) -- Line: 1298, Name: activate
                                            -- upvalues: u612 (ref), TweenService (ref), workspace_CurrentCamera (ref), u596 (copy), u595 (copy)
                                            u612 = p613;

                                            if not u612 then
                                                u595();

                                                return;
                                            end;

                                            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                FieldOfView = 25
                                            }):Play();
                                            u596();
                                        end);
                                    elseif u439.Name == "PD Camera" or u439.Name == "Camera" then
                                        u2.keepMobileGuiTypePersistent("Camera", true);
                                        local u614 = false;
                                        advancedInputStateChange(Enum.KeyCode.E, Mobile.Camera.Change, true, function() -- Line: 1319
                                            -- upvalues: u614 (ref)
                                            return u614;
                                        end, function(p615) -- Line: 1310, Name: activate
                                            -- upvalues: u614 (ref), u3 (ref), Mobile (ref), u596 (copy), u595 (copy)
                                            u614 = p615;

                                            if not u614 then
                                                u595();

                                                return;
                                            end;

                                            u3.hideGui("CameraTool", { Mobile });
                                            u596();
                                        end);
                                        CharScope.buildSignalData("Tool", { UserInputService.InputChanged, function(p616, p617) -- Line: 1320
                                                -- upvalues: u3 (ref), Ragdoll (ref), u614 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                                if u3.openedGui or (p617 or Ragdoll.isActive) then
                                                    return;
                                                end;

                                                if p616.UserInputType == Enum.UserInputType.MouseWheel and u614 then
                                                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p616.Position.Z * -5, 30, 70)
                                                    }):Play();
                                                end;
                                            end });
                                        local v619 = u6.touchPinch(function(p618) -- Line: 1326
                                            -- upvalues: u3 (ref), Ragdoll (ref), u614 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                                            if u3.openedGui or Ragdoll.isActive then
                                                return;
                                            end;

                                            if u614 then
                                                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                    FieldOfView = math.clamp(workspace_CurrentCamera.FieldOfView + p618 * -15, 30, 70)
                                                }):Play();
                                            end;
                                        end);
                                        CharScope.buildSignalData("Tool", v619.signalData);
                                        actionEvent(function() -- Line: 1333
                                            -- upvalues: u6 (ref), u614 (ref), u2 (ref)
                                            if not (u6.invokeTraffic.cameraTakePicture or u6.rest("CameraTakePicture", 1.5)) then
                                                u6.invokeServerTraffic("cameraTakePicture");

                                                if u614 then
                                                    u2.takePictureEffect();
                                                end;
                                            end;
                                        end, Mobile.Action.Action);
                                    end;

                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1340
                                        -- upvalues: u2 (ref), u595 (copy)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        u2.keepMobileGuiTypePersistent("NewsCamera", false);
                                        u2.keepMobileGuiTypePersistent("Camera", false);
                                        u595();
                                    end);
                                end;
                            elseif u439.Name == "PD Tape" then
                                if u443 == true then
                                    local u620 = u6.policeTapeMaxLength();
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    u446.group = Instance.new("Model");
                                    u446.group.Name = "PD Tape";
                                    u446.group.Parent = workspace.Gameplay.Entities;
                                    CharScope.addEntity(u446.group);
                                    PlacePreviewHighlight.Adornee = u446.group;
                                    PlacePreviewHighlight.Enabled = true;

                                    local function u623(p621) -- Line: 1357
                                        -- upvalues: u6 (ref), u446 (copy), CharScope (ref)
                                        local v622 = u6.clone(game.ReplicatedStorage.Gameplay.Items["PD Tape"][p621]);
                                        v622.Transparency = 1;

                                        for _, child in pairs(v622:GetChildren()) do
                                            if child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                                                child:Destroy();
                                            end;
                                        end;

                                        v622.Material = Enum.Material.Glass;
                                        v622.Parent = u446.group;
                                        CharScope.addEntity(v622);

                                        return v622;
                                    end;

                                    u446.pole = u623("Pole");
                                    CharScope.buildSignalData("Tool", { RunService.Heartbeat, function(p624) -- Line: 1367
                                            -- upvalues: u3 (ref), u6 (ref), u19 (ref), u446 (copy), u620 (copy), PlacePreviewHighlight (ref)
                                            local v625 = u3.getMouseProperty.unitRay("FreeSpacePersistent");
                                            local v626 = u6.raycastVisible(v625.Origin, v625.Direction * 25, u19);
                                            local v627 = true;
                                            u446.pole.CFrame = u446.pole.CFrame:Lerp(CFrame.new((v626 and v626.Position or v625.Origin + v625.Direction * 25) + Vector3.new(0, u446.pole.Size.X / 2, 0)) * CFrame.Angles(0, 0, -1.5707963267948966), 1 - 1e-6 ^ p624);

                                            if u446.pole2 then
                                                local v628 = u446.pole.Position - u446.pole2.Position;

                                                if u620 < v628.Magnitude then
                                                    v627 = false;
                                                end;

                                                u446.tape.CFrame = CFrame.new((u446.pole.Position + u446.pole2.Position) / 2 + Vector3.new(0, 1, 0), u446.pole2.Position + Vector3.new(0, 1, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);
                                                local Size2 = u446.tape.Size;
                                                u446.tape.Size = Vector3.new(v628.Magnitude, Size2.Y, Size2.Z);
                                            end;

                                            if v627 and v626 then
                                                if u446.pole.Parent ~= u446.group then
                                                    PlacePreviewHighlight.Adornee = nil;
                                                    u446.pole.Parent = u446.group;
                                                    PlacePreviewHighlight.Adornee = u446.group;
                                                end;
                                            elseif u446.pole.Parent ~= workspace.Gameplay.Entities then
                                                PlacePreviewHighlight.Adornee = nil;
                                                u446.pole.Parent = workspace.Gameplay.Entities;
                                                PlacePreviewHighlight.Adornee = u446.group;
                                            end;
                                        end });
                                    actionEvent(function() -- Line: 1393
                                        -- upvalues: u6 (ref), u446 (copy), u439 (ref), Animator (ref), u3 (ref), u623 (copy)
                                        if not u6.invokeTraffic.placeItem and u446.pole.Parent == u446.group then
                                            if u446.pole2 then
                                                local v629 = u6.invokeServerTraffic("placeItem", {
                                                    place = true,
                                                    item = u439.Name,
                                                    position = u446.pole.Position,
                                                    position2 = u446.pole2.Position,
                                                    tapeCFrame = u446.tape.CFrame
                                                });

                                                if u6.typeOf(v629) == "table" then
                                                    for i, v in pairs(v629) do
                                                        local InstanceReference = u6.getInstanceReference(v, 20);

                                                        if InstanceReference then
                                                            if i == 2 then
                                                                u6.animationBuffer(Animator, "play", "PlaceGive");
                                                            end;

                                                            u6.clone(game.ReplicatedStorage.Gameplay.Items.PickUpItem).Parent = InstanceReference;
                                                        end;
                                                    end;
                                                elseif u6.typeOf(v629) == "string" then
                                                    u3.notify({
                                                        color = "red",
                                                        message = v629
                                                    });
                                                end;

                                                u446.pole2:Destroy();
                                                u446.tape:Destroy();
                                                u446.pole2 = nil;
                                                u446.tape = nil;

                                                return;
                                            end;

                                            u446.tape = u623("Tape");
                                            u446.pole2 = u623("Pole");
                                            u446.pole2.CFrame = u446.pole.CFrame;
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1421
                                        -- upvalues: PlacePreviewHighlight (ref), u2 (ref), u446 (copy)
                                        PlacePreviewHighlight.Adornee = nil;
                                        PlacePreviewHighlight.Enabled = false;
                                        u2.keepMobileGuiTypePersistent("Action", false);

                                        for _, v in pairs({ "pole2", "pole", "tape", "group" }) do
                                            if u446[v] and u446[v].Parent then
                                                u446[v]:Destroy();
                                            end;
                                        end;
                                    end);
                                end;
                            elseif u439.Name == "MT Lifebuoy" or u439.Name == "FD Lifebuoy" then
                                if u443 == true then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    actionEvent(function() -- Line: 1431
                                        -- upvalues: u6 (ref), HumanoidRootPart (ref), u439 (ref), Animator (ref), u3 (ref)
                                        if not u6.invokeTraffic.placeItem then
                                            local v630 = u6.raycastParamsNew();
                                            v630.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities };
                                            local v631 = u6.raycastVisible(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5 + Vector3.new(0, 5, 0), Vector3.new(-0, -100, -0), v630);

                                            if v631 and v631.Material == Enum.Material.Water then
                                                local _, v632, _ = HumanoidRootPart.CFrame:ToOrientation();
                                                local v633 = u6.invokeServerTraffic("placeItem", {
                                                    place = true,
                                                    item = u439.Name,
                                                    position = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 3.5,
                                                    rotation = v632
                                                });

                                                if tonumber(v633) then
                                                    local InstanceReference = u6.getInstanceReference(v633, 20);

                                                    if InstanceReference then
                                                        u6.animationBuffer(Animator, "play", "PlaceGive");
                                                        u6.clone(game.ReplicatedStorage.Gameplay.Items.PickUpItem).Parent = InstanceReference.PrimaryPart;
                                                    end;
                                                elseif u6.typeOf(v633) == "string" then
                                                    u3.notify({
                                                        color = "red",
                                                        message = v633
                                                    });
                                                end;
                                            else
                                                u3.notify({
                                                    message = "You must be near the water",
                                                    color = "red"
                                                });
                                            end;
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1453
                                        -- upvalues: u2 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                    end);
                                end;
                            elseif u439.Name == "MT Cone" or (u439.Name == "FD Cone" or (u439.Name == "PD Cone" or (u439.Name == "FD Ladder" or (u439.Name == "PD Barricade" or (u439.Name == "PD Evidence Marker" or (u439.Name == "PD Spike Strips" or (u439.Name == "RS Cone" or (u439.Name == "RS Roll-Up Sign" or (u439.Name == "RS Traffic Barricade" or u439.Name == "RS Flashing Barricade"))))))))) then
                                if u443 == true then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    local Items = game.ReplicatedStorage.Gameplay.Items;
                                    u446.item = u6.clone(Items[u439.Name]);

                                    if u439.Name == "RS Flashing Barricade" then
                                        u446.item.Light._Blinker.Name = "MeshPart";
                                    end;

                                    u446.item.Parent = workspace.Gameplay.Entities;
                                    CharScope.addEntity(u446.item);

                                    for _, descendant in pairs(u446.item:GetDescendants()) do
                                        if descendant:IsA("BasePart") then
                                            descendant.CanCollide = false;
                                            descendant.Transparency = 1;

                                            if not descendant:GetAttribute("DontIncludeInHighlight") then
                                                descendant.Material = Enum.Material.Glass;
                                            end;
                                        elseif descendant:IsA("SurfaceAppearance") or (descendant:IsA("Texture") or (descendant:IsA("Decal") or descendant:IsA("SurfaceGui"))) then
                                            descendant:Destroy();
                                        end;
                                    end;

                                    local u634 = u6.raycastParamsNew();
                                    u634.FilterDescendantsInstances = { workspace.Characters, u446.item };
                                    u634.IgnoreWater = true;
                                    PlacePreviewHighlight.Adornee = u446.item;
                                    local u635 = (Config.HEADING or 0) * 3.141592653589793 / 2;
                                    u446.item:PivotTo(CFrame.new(HumanoidRootPart.Position));
                                    CharScope.buildSignalData("Tool", { RunService.Heartbeat, function(p636) -- Line: 1489
                                            -- upvalues: u3 (ref), u6 (ref), u634 (copy), HumanoidRootPart (ref), u446 (copy), u635 (copy), PlacePreviewHighlight (ref)
                                            local v637 = u3.getMouseProperty.unitRay("FreeSpacePersistent");
                                            local v638 = u6.raycastVisible(v637.Origin, v637.Direction * 25, u634);
                                            local v639 = v638 and v638.Position or v637.Origin + v637.Direction * 25;
                                            local v640 = HumanoidRootPart.Position - v639;
                                            u446.heading = math.atan2(-v640.Z, v640.X) + u635;
                                            u446.item:PivotTo(u446.item.PrimaryPart.CFrame:Lerp(CFrame.new(v639 + Vector3.new(0, u446.item.PrimaryPart.Size.Y / 2, 0)) * CFrame.Angles(0, u446.heading, 0), 1 - 1e-6 ^ p636));

                                            if PlacePreviewHighlight.Enabled ~= (v638 and true or false) then
                                                PlacePreviewHighlight.Enabled = v638;
                                            end;
                                        end });
                                    actionEvent(function() -- Line: 1498
                                        -- upvalues: u6 (ref), PlacePreviewHighlight (ref), u439 (ref), u446 (copy), Config (copy), Animator (ref), Items (copy), CharScope (ref), u21 (ref), PlayerFunc (ref), u3 (ref)
                                        if not u6.invokeTraffic.placeItem and PlacePreviewHighlight.Enabled then
                                            local v641 = u6.invokeServerTraffic("placeItem", {
                                                place = true,
                                                item = u439.Name,
                                                position = u446.item.PrimaryPart.Position,
                                                rotation = u446.heading,
                                                textSequence = Config.TEXT_SEQUENCE
                                            });

                                            if tonumber(v641) then
                                                local InstanceReference = u6.getInstanceReference(v641, 20);

                                                if InstanceReference then
                                                    u6.animationBuffer(Animator, "play", "PlaceGive");
                                                    u6.clone(Items.PickUpItem).Parent = InstanceReference.PrimaryPart;

                                                    if u439.Name == "PD Spike Strips" then
                                                        local u642 = {};
                                                        CharScope.taskDefer(function() -- Line: 1509
                                                            -- upvalues: InstanceReference (copy), u21 (ref), u642 (copy), CharScope (ref), PlayerFunc (ref)
                                                            while InstanceReference.Parent do
                                                                for _, v in pairs(workspace:GetPartsInPart(InstanceReference.Area, u21)) do
                                                                    if v.Name == "WheelCollision" and (v.Transparency == 0 and not u642[v]) then
                                                                        u642[v] = true;
                                                                        CharScope.taskSpawn(function() -- Line: 1514
                                                                            -- upvalues: PlayerFunc (ref), InstanceReference (ref), v (copy), u642 (ref)
                                                                            PlayerFunc:InvokeServer("spikeStrips", InstanceReference, v);
                                                                            task.wait(10);
                                                                            u642[v] = nil;
                                                                        end);
                                                                    end;
                                                                end;

                                                                task.wait();
                                                            end;
                                                        end);

                                                        return;
                                                    end;

                                                    if u439.Name == "FD Ladder" then
                                                        u6.clone(Items.ExpandLadder).Parent = InstanceReference.PrimaryPart;
                                                    end;
                                                end;
                                            elseif u6.typeOf(v641) == "string" then
                                                u3.notify({
                                                    color = "red",
                                                    message = v641
                                                });
                                            end;
                                        end;
                                    end, Mobile.Action.Action);
                                    local u643 = u439.Name == "RS Roll-Up Sign" and "RollUpSign" or (u439.Name == "RS Traffic Barricade" and "TrafficBarricade" or false);

                                    if u643 then
                                        local ToolWithSelection = ScreenGui.Right.Bottom.ToolWithSelection;

                                        for _, child in pairs(ToolWithSelection:GetChildren()) do
                                            if child:IsA("Frame") then
                                                child.Visible = child.Name == u643;
                                            end;
                                        end;

                                        local function u646(p644, p645) -- Line: 1538
                                            -- upvalues: u646 (copy), Config (copy), ToolWithSelection (copy), u643 (copy), u6 (ref)
                                            if p645 then
                                                u646(Config.TEXT_SEQUENCE or "1", false);
                                            end;

                                            ToolWithSelection[u643][p644].ImageColor3 = p645 and Color3.fromRGB(152, 152, 152) or Color3.fromRGB(76, 76, 76);
                                            u6.resetButtonColor(ToolWithSelection[u643][p644], p645);
                                        end;

                                        for _, child in pairs(ToolWithSelection[u643]:GetChildren()) do
                                            if child:IsA("ImageButton") then
                                                child.ImageColor3 = Color3.fromRGB(76, 76, 76);
                                                CharScope.buildSignalData("Tool", u6.buttonHoverSignalData(child));
                                                CharScope.buildSignalData("Tool", u3.mouseButton(child, function() -- Line: 1547
                                                    -- upvalues: u646 (copy), child (copy), Config (copy)
                                                    u646(child.Name, true);
                                                    local v647;

                                                    if child.Name == "1" then
                                                        v647 = false;
                                                    else
                                                        v647 = child.Name;
                                                    end;

                                                    Config.TEXT_SEQUENCE = v647;
                                                end));
                                            end;
                                        end;

                                        u646(Config.TEXT_SEQUENCE or "1", true);
                                        u6.guiTransition(ToolWithSelection, "Position", UDim2.fromScale(0, 0.2), true);
                                        ToolWithSelection:SetAttribute("Id", u439:GetAttribute("Id"));
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1556
                                            -- upvalues: ToolWithSelection (copy), u439 (ref), u6 (ref)
                                            if ToolWithSelection:GetAttribute("Id") == u439:GetAttribute("Id") then
                                                u6.guiTransition(ToolWithSelection, "Position", UDim2.fromScale(0, 0.2), false);
                                            end;
                                        end);
                                    end;

                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1560
                                        -- upvalues: PlacePreviewHighlight (ref), u2 (ref), u446 (copy)
                                        PlacePreviewHighlight.Adornee = nil;
                                        PlacePreviewHighlight.Enabled = false;
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        u446.item:Destroy();
                                    end);
                                end;
                            elseif u439.Name == "FD Fire Hose" or u439.Name == "FD Fire Extinguisher" then
                                if u443 == true then
                                    local Stream = u439:WaitForChild("Stream");
                                    u439:WaitForChild("StreamBase");
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    u446.streamSound = Handle:WaitForChild("Stream");
                                    local u648 = u439.Name == "FD Fire Hose" and 30 or 15;
                                    local u649 = u439.Name == "FD Fire Hose" and 1 or 1.2;
                                    local u650 = {};
                                    local u651 = 0;
                                    local u652 = nil;

                                    for _, child in pairs(Stream:GetChildren()) do
                                        if child.Name == "WaterHitbox" then
                                            table.insert(u650, child);
                                        end;
                                    end;

                                    local u653 = u6.overlapParamsNew();
                                    u653.FilterDescendantsInstances = { workspace.Characters, workspace.World };

                                    local function u654() -- Line: 1581
                                        -- upvalues: mouseDotInteract (ref), Stream (copy), PlayerEvent (ref), u6 (ref), u446 (copy), u651 (ref), u652 (ref)
                                        mouseDotInteract(false);

                                        if Stream.StreamEmitter.Enabled then
                                            PlayerEvent:FireServer("emitter", Stream.StreamEmitter, false);
                                            Stream.StreamEmitter.Enabled = false;

                                            if Stream:FindFirstChild("StreamEmitter2") then
                                                PlayerEvent:FireServer("emitter", Stream.StreamEmitter2, false);
                                                Stream.StreamEmitter2.Enabled = false;
                                            end;

                                            u6.stopSoundReplicate(u446.streamSound);
                                            u651 = (u651 + 1) % 100;

                                            if u652 then
                                                u652();
                                            end;
                                        end;
                                    end;

                                    if u439.Name == "FD Fire Hose" then
                                        u6.animationBuffer(Animator, "load", u439:WaitForChild("Handle"):WaitForChild("RecoilAnimation"), PlayerStuff.Items.Animations.FireHoseAimStabilize, PlayerStuff.Items.Animations.FireHoseAim);
                                        local u655 = nil;

                                        local function _(p656) -- Line: 1598
                                            -- upvalues: HumanoidRootPart (ref), u655 (ref)
                                            if p656 and ((p656._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not p656:GetAttribute("Totaled") and p656._Chassis:FindFirstChild("HoseAttachment"))) then
                                                u655 = p656._Chassis.HoseAttachment;

                                                return true;
                                            end;
                                        end;

                                        local BelongingVehicle = u6.getVehicleInfo.getBelongingVehicle(LocalPlayer);

                                        if BelongingVehicle and ((BelongingVehicle._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not BelongingVehicle:GetAttribute("Totaled") and BelongingVehicle._Chassis:FindFirstChild("HoseAttachment"))) then
                                            u655 = BelongingVehicle._Chassis.HoseAttachment;
                                        end;

                                        if not u655 then
                                            for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                                local v657;

                                                if child and ((child._Chassis.Position - HumanoidRootPart.Position).Magnitude < 150 and (not child:GetAttribute("Totaled") and child._Chassis:FindFirstChild("HoseAttachment"))) then
                                                    u655 = child._Chassis.HoseAttachment;
                                                    v657 = true;
                                                else
                                                    v657 = nil;
                                                end;

                                                if v657 then
                                                    break;
                                                end;
                                            end;
                                        end;

                                        if not u655 then
                                            local v658 = {};

                                            for _, child in pairs(workspace.World.Interactive["Fire Hydrants"]:GetChildren()) do
                                                if u6.areObjectReferencesLoaded(child) then
                                                    table.insert(v658, child);
                                                end;
                                            end;

                                            local v659, _, v660 = u6.findClosestFromTable(HumanoidRootPart.Position, v658);

                                            if v659 and v660 < 150 then
                                                u655 = v659.PrimaryPart.HoseAttachment;
                                            end;
                                        end;

                                        if not u655 then
                                            u3.notify({
                                                message = "You must be near a fire truck or fire hydrant",
                                                color = "red"
                                            });
                                            task.wait(0.1);

                                            return u1.equipSlot();
                                        end;

                                        PlayerEvent:FireServer("fireHose", u8, u655);
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1622
                                            -- upvalues: u655 (ref), HumanoidRootPart (ref), u1 (ref)
                                            while u655:IsDescendantOf(workspace) and (u655.WorldPosition - HumanoidRootPart.Position).Magnitude <= 150 do
                                                task.wait(2);
                                            end;

                                            return u1.equipSlot();
                                        end));
                                        aimSystem({
                                            FireHoseAimStabilize = 0.7,
                                            FireHoseAim = 1
                                        }, "Dot", function(p661) -- Line: 1628
                                            -- upvalues: u2 (ref), Config (copy), u6 (ref), u439 (ref), u654 (copy)
                                            u2.setCameraRelativeToViewModelPart(p661 and "Item" or "HumanoidRootPart", p661 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                            local setToolGrip = u6.setToolGrip;
                                            local v662;

                                            if p661 then
                                                v662 = CFrame.new(
                                                    -0.328115463,
                                                    -0.230318069,
                                                    -0.182041168,
                                                    -0.440460384,
                                                    -0.492896318,
                                                    -0.750365138,
                                                    -0.895676732,
                                                    0.184187889,
                                                    0.404769063,
                                                    -0.0613010079,
                                                    0.850369334,
                                                    -0.522603214
                                                );
                                            else
                                                v662 = p661;
                                            end;

                                            setToolGrip(nil, u439, v662);

                                            if not p661 then
                                                u654();
                                            end;
                                        end);
                                    elseif u439.Name == "FD Fire Extinguisher" then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FireExtinguisherAimStabilize, PlayerStuff.Items.Animations.FireExtinguisherAim);
                                        aimSystem({
                                            FireExtinguisherAimStabilize = 0.7,
                                            FireExtinguisherAim = 1
                                        }, "Dot", function(p663) -- Line: 1635
                                            -- upvalues: u2 (ref), Config (copy), u6 (ref), u439 (ref), u654 (copy)
                                            u2.setCameraRelativeToViewModelPart(p663 and "Item" or "HumanoidRootPart", p663 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                            local setToolGrip = u6.setToolGrip;
                                            local v664;

                                            if p663 then
                                                v664 = CFrame.new(
                                                    -0.366176605,
                                                    0.0753266811,
                                                    0.538593292,
                                                    0.211218357,
                                                    0.975580156,
                                                    -0.0602500141,
                                                    -0.919472575,
                                                    0.219226077,
                                                    0.326358825,
                                                    0.331597567,
                                                    -0.0135347359,
                                                    0.943323851
                                                );
                                            else
                                                v664 = p663;
                                            end;

                                            setToolGrip(nil, u439, v664);

                                            if not p663 then
                                                u654();
                                            end;
                                        end);
                                    end;

                                    actionEvent(function() -- Line: 1641
                                        -- upvalues: u1 (ref), mouseDotInteract (ref), u651 (ref), u652 (ref), u439 (ref), CharScope (ref), PlayerEvent (ref), u6 (ref), Handle (copy), Stream (copy), u446 (copy), Animator (ref), aimToolAtMouseHit (ref), u648 (copy), u650 (copy), u653 (copy), PlayerFunc (ref), u649 (copy)
                                        if u1.isAiming then
                                            mouseDotInteract(false);
                                            u651 = (u651 + 1) % 100;

                                            if u652 then
                                                u652();
                                            end;

                                            local u665 = u651;

                                            if u439.Name == "FD Fire Extinguisher" then
                                                local function u666() -- Line: 1648
                                                    -- upvalues: u651 (ref), u665 (copy)
                                                    return u651 == u665;
                                                end;

                                                local u667 = nil;
                                                local u668 = 200;
                                                local u669 = 3;
                                                CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(3, function() -- Line: 454
                                                    -- upvalues: u666 (copy), u667 (copy), PlayerEvent (ref), u439 (ref), u668 (copy), u669 (copy)
                                                    while not u666 or u666() do
                                                        if not u667 or u667() then
                                                            PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), u668);
                                                        end;

                                                        task.wait(u669);
                                                    end;
                                                end));
                                                u6.playSoundReplicate(Handle.Start);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireExtinguisherThread", CharScope.taskDelay(0.12, function() -- Line: 1650
                                                    -- upvalues: u651 (ref), u665 (copy), Stream (ref), u6 (ref), u446 (ref)
                                                    if u651 == u665 and Stream.StreamEmitter.Enabled then
                                                        u6.playSoundReplicate(u446.streamSound);
                                                    end;
                                                end));
                                            else
                                                u6.animationBuffer(Animator, "play", "RecoilAnimation");
                                                u6.playSoundReplicate(u446.streamSound);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireHoseThread", CharScope.taskDelay(0.09, function() -- Line: 1654
                                                    -- upvalues: u651 (ref), u665 (copy), u6 (ref), Animator (ref)
                                                    if u651 == u665 then
                                                        u6.animationBuffer(Animator, "stop", "RecoilAnimation", 0.3);
                                                    end;
                                                end));
                                            end;

                                            PlayerEvent:FireServer("emitter", Stream.StreamEmitter, true);
                                            Stream.StreamEmitter.Enabled = true;

                                            if Stream:FindFirstChild("StreamEmitter2") then
                                                PlayerEvent:FireServer("emitter", Stream.StreamEmitter2, true);
                                                Stream.StreamEmitter2.Enabled = true;
                                            end;

                                            u652 = aimToolAtMouseHit(Stream.AimToolAtMouseHit, u648);
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fireExtinguisherThread2", CharScope.taskDelay(0.5, function() -- Line: 1665
                                                -- upvalues: u651 (ref), u665 (copy), u650 (ref), u653 (ref), CharScope (ref), PlayerFunc (ref), mouseDotInteract (ref), u6 (ref), u649 (ref)
                                                while u651 == u665 do
                                                    local v670 = 2;
                                                    local v671 = {};

                                                    for _, v in pairs(u650) do
                                                        for _, v2 in pairs(workspace:GetPartsInPart(v, u653)) do
                                                            if v670 > 0 and v2:GetAttribute("Extinguishable") then
                                                                v671[v2] = true;
                                                                v670 = v670 - 1;
                                                            end;
                                                        end;
                                                    end;

                                                    for i, _ in pairs(v671) do
                                                        CharScope.taskDefer(function() -- Line: 1674
                                                            -- upvalues: PlayerFunc (ref), i (copy)
                                                            PlayerFunc:InvokeServer("talkToMission", i);
                                                        end);
                                                    end;

                                                    mouseDotInteract(not u6.isTableEmpty(v671));
                                                    task.wait(u649);
                                                end;
                                            end));
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p672) -- Line: 1681
                                            -- upvalues: u1 (ref), u654 (copy)
                                            if (p672.UserInputType == Enum.UserInputType.MouseButton1 or p672.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                                u654();
                                            end;
                                        end });
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1684
                                        -- upvalues: mouseDotInteract (ref), u2 (ref), u1 (ref), u3 (ref), PlayerEvent (ref), Stream (copy), u8 (ref), u439 (ref), u6 (ref), Animator (ref)
                                        mouseDotInteract(false);
                                        u2.keepMobileGuiTypePersistent("Action", false);

                                        if u1.isAiming then
                                            u1.shoulderCam(false);
                                        end;

                                        u3.activateMouseIcon(false);
                                        u2.keepMobileGuiTypePersistent("Aim", false);
                                        PlayerEvent:FireServer("emitter", Stream.StreamEmitter, false);
                                        Stream.StreamEmitter.Enabled = false;
                                        PlayerEvent:FireServer("fireHose", u8);

                                        if u439.Name ~= "FD Fire Hose" then
                                            if u439.Name == "FD Fire Extinguisher" then
                                                u6.animationBuffer(Animator, "unload", "FireExtinguisherAimStabilize", "FireExtinguisherAim");
                                            end;

                                            return;
                                        end;

                                        u6.animationBuffer(Animator, "unload", "RecoilAnimation");
                                        u6.animationBuffer(Animator, "unload", "FireHoseAimStabilize", "FireHoseAim");
                                    end);
                                end;
                            elseif u439.Name == "FD Chainsaw" or u439.Name == "RS Impact Wrench" then
                                if u443 == true then
                                    local u673;

                                    if u439.Name == "FD Chainsaw" then
                                        u673 = u439:WaitForChild("Hitbox");
                                    else
                                        u673 = false;
                                    end;

                                    u2.keepMobileGuiTypePersistent("Action", true);

                                    if u439.Name == "FD Chainsaw" then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.ChainsawAim, PlayerStuff.Items.Animations.ChainsawAimStabilize);
                                        u446.idleSound = Handle:WaitForChild("Idle");
                                        u446.actionSound = Handle:WaitForChild("Action");
                                    elseif u439.Name == "RS Impact Wrench" then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.ImpactWrenchAim, PlayerStuff.Items.Animations.ImpactWrenchAimStabilize);
                                        u446.beginActionSound = Handle:WaitForChild("BeginAction");
                                        u446.actionSound = Handle:WaitForChild("Action");
                                    end;

                                    local u674 = 0;
                                    aimSystem(u439.Name == "FD Chainsaw" and ({
                                        ChainsawAimStabilize = 0.7,
                                        ChainsawAim = 1
                                    } or {
                                        ImpactWrenchAimStabilize = 0.7,
                                        ImpactWrenchAim = 1
                                    }) or {
                                        ImpactWrenchAimStabilize = 0.7,
                                        ImpactWrenchAim = 1
                                    }, "Dot", function(p675) -- Line: 1713
                                        -- upvalues: u674 (ref), u446 (copy), u6 (ref), u2 (ref), Config (copy), u439 (ref), u8 (ref), u673 (copy), mouseDotInteract (ref)
                                        u674 = (u674 + 1) % 100;

                                        if u446.actionSound.IsPlaying then
                                            u6.stopSoundReplicate(u446.actionSound);
                                        end;

                                        u2.setCameraRelativeToViewModelPart(p675 and "Item" or "HumanoidRootPart", p675 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                        if u439.Name == "FD Chainsaw" then
                                            local v676 = u8:GetAttribute("BodyType") == "Blocky" and CFrame.new(
                                                -0.283234596,
                                                -0.181575775,
                                                -0.835891724,
                                                -0.998626828,
                                                -0.0139965154,
                                                -0.0504344888,
                                                -0.0411391072,
                                                -0.385827869,
                                                0.921652734,
                                                -0.0323589668,
                                                0.922462046,
                                                0.384724081
                                            ) or CFrame.new(
                                                -0.0482702255,
                                                -0.17042923,
                                                -0.855205536,
                                                -0.994409204,
                                                -0.0927722752,
                                                -0.0504341833,
                                                -0.0105578285,
                                                -0.387874097,
                                                0.9216519,
                                                -0.105065845,
                                                0.917031646,
                                                0.384726107
                                            );
                                            u6.setToolGrip(nil, u439, p675 and v676);

                                            if u446.idleSound.IsPlaying ~= p675 then
                                                u446.idleSound[p675 and "Play" or "Stop"](u446.idleSound);
                                            end;

                                            if u673.Residue.Enabled then
                                                u673.Residue.Enabled = false;
                                            end;
                                        elseif u439.Name == "RS Impact Wrench" then
                                            local setToolGrip = u6.setToolGrip;
                                            local v677;

                                            if p675 then
                                                v677 = CFrame.new(
                                                    0.00243377686,
                                                    -0.139491081,
                                                    0.180562973,
                                                    0.5504421,
                                                    0.515630841,
                                                    -0.656610668,
                                                    -0.195514947,
                                                    0.844223142,
                                                    0.499058872,
                                                    0.811657429,
                                                    -0.146326333,
                                                    0.565510392
                                                );
                                            else
                                                v677 = p675;
                                            end;

                                            setToolGrip(nil, u439, v677);
                                        end;

                                        if not p675 then
                                            mouseDotInteract(false);
                                        end;
                                    end);
                                    local u678 = u6.overlapParamsNew();
                                    u678.FilterDescendantsInstances = { workspace.Characters, workspace.World };
                                    actionEvent(function() -- Line: 1729
                                        -- upvalues: u1 (ref), u674 (ref), u439 (ref), u6 (ref), u446 (copy), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u673 (copy), u678 (copy), mouseDotInteract (ref), getProperCameraUnitRay (ref), u19 (ref)
                                        if u1.isAiming then
                                            local u679 = u674;

                                            if u439.Name == "FD Chainsaw" then
                                                u6.stopSoundReplicate(u446.idleSound);
                                                u6.playSoundReplicate(u446.actionSound);
                                                local u680 = nil;
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "chainsawThread", CharScope.taskDelay(1, function() -- Line: 1737
                                                    -- upvalues: u674 (ref), u679 (copy), u680 (ref), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u439 (ref)
                                                    while u674 == u679 do
                                                        if u680 and u680.Parent then
                                                            CharScope.taskDefer(function() -- Line: 1740
                                                                -- upvalues: PlayerFunc (ref), u680 (ref), PlayerEvent (ref), u439 (ref)
                                                                if PlayerFunc:InvokeServer("talkToMission", u680.Parent, u680) then
                                                                    PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), 90);
                                                                end;
                                                            end);
                                                        end;

                                                        task.wait(1);
                                                    end;
                                                end));
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "chainsawThread2", CharScope.taskSpawn(function() -- Line: 1747
                                                    -- upvalues: u674 (ref), u679 (copy), u680 (ref), u673 (ref), u678 (ref), mouseDotInteract (ref)
                                                    while true do
                                                        if u674 ~= u679 then
                                                            mouseDotInteract(false);

                                                            return;
                                                        end;

                                                        u680 = nil;

                                                        for _, v in pairs(workspace:GetPartsInPart(u673, u678)) do
                                                            if v.Name == "ChopArea" then
                                                                u680 = v;
                                                                break;
                                                            end;
                                                        end;

                                                        if u673.Residue.Enabled ~= (u680 and true or false) then
                                                            u673.Residue.Enabled = u680;
                                                            mouseDotInteract(u680);
                                                        end;

                                                        task.wait(0.3);
                                                    end;
                                                end));

                                                return;
                                            end;

                                            if u439.Name == "RS Impact Wrench" then
                                                u6.playSoundReplicate(u446.beginActionSound);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread2", CharScope.taskDelay(0.12, function() -- Line: 1763
                                                    -- upvalues: u674 (ref), u679 (copy), u6 (ref), u446 (ref), CharScope (ref), PlayerEvent (ref), u439 (ref), getProperCameraUnitRay (ref), u19 (ref), mouseDotInteract (ref)
                                                    if u674 == u679 then
                                                        u6.playSoundReplicate(u446.actionSound);
                                                        local u681 = nil;
                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread", CharScope.taskDelay(1, function() -- Line: 1767
                                                            -- upvalues: u674 (ref), u679 (ref), u681 (ref), u6 (ref), PlayerEvent (ref), u439 (ref)
                                                            while u674 == u679 do
                                                                if u681 then
                                                                    local v682 = (u681:GetAttribute("UnscrewingTire") or 0) + 1;

                                                                    if v682 >= 4 then
                                                                        local Parent = u681.Parent.Parent.Parent;
                                                                        local CFrame2 = u681.Parent.CFrame;
                                                                        local u683 = u6.smartUnit(Parent.PrimaryPart.Position - CFrame2.Position):Dot(Parent.PrimaryPart.CFrame.RightVector) > 0;
                                                                        local u684 = u6.clone(u681);
                                                                        u684.Tire.Rim.CanCollide = true;
                                                                        u684.Pivot.Massless = false;
                                                                        u684.Pivot.CustomPhysicalProperties = PhysicalProperties.new(12, 0.2, 0.5);
                                                                        u684.Parent = workspace.Gameplay.Entities;
                                                                        task.delay(0.03, function() -- Line: 1781
                                                                            -- upvalues: u684 (copy), CFrame2 (copy), u683 (copy)
                                                                            u684.Pivot:ApplyImpulse(CFrame2.RightVector * 120 * (u683 and -1 or 1));
                                                                        end);
                                                                        PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), 40);
                                                                        u6.debrisServiceAddItem(u684, 10);
                                                                        u6.unscrewVehicleRim(u681, true);
                                                                    else
                                                                        u681:SetAttribute("UnscrewingTire", v682);
                                                                    end;
                                                                end;

                                                                task.wait(1);
                                                            end;
                                                        end));
                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "impactWrenchThread3", CharScope.taskSpawn(function() -- Line: 1795
                                                            -- upvalues: u674 (ref), u679 (ref), u681 (ref), getProperCameraUnitRay (ref), u6 (ref), u19 (ref), mouseDotInteract (ref)
                                                            while u674 == u679 do
                                                                u681 = nil;
                                                                local v685 = getProperCameraUnitRay(10);
                                                                local u687 = u6.raycastVisible(v685.origin, v685.length, u19, {
                                                                    customRequirements = function(p686) -- Line: 1799, Name: customRequirements
                                                                        if p686.Instance.Transparency == 1 then
                                                                            p686 = false;
                                                                        end;

                                                                        return p686;
                                                                    end
                                                                });

                                                                if u687 and u687.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) then
                                                                    local AncestorsChild = u6.getAncestorsChild(workspace.Gameplay.Vehicles, u687.Instance);
                                                                    local v689 = u6.raycastVisible(v685.origin, v685.length, u19, {
                                                                        customRequirements = function(p688) -- Line: 1802, Name: customRequirements
                                                                            -- upvalues: AncestorsChild (copy), u687 (copy)
                                                                            if p688 and (p688.Instance:IsDescendantOf(AncestorsChild.Thrusters) and (u687.Position - p688.Position).Magnitude < 4) then
                                                                                return p688;
                                                                            end;
                                                                        end
                                                                    });

                                                                    if v689 then
                                                                        local AncestorsChild2 = u6.getAncestorsChild(AncestorsChild.Thrusters, v689.Instance);

                                                                        if AncestorsChild2 and not AncestorsChild2.Parent.Parent:GetAttribute("Totaled") then
                                                                            local WheelCollision = AncestorsChild2.Wheel.Tire.WheelCollision;

                                                                            if AncestorsChild2.Wheel:GetAttribute("UnscrewingTire") ~= true and (not WheelCollision:GetAttribute("DontPuncture") and WheelCollision:GetAttribute("Durability")) then
                                                                                u681 = AncestorsChild2.Wheel;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;

                                                                mouseDotInteract(u681 and true or false);
                                                                task.wait(0.3);
                                                            end;

                                                            mouseDotInteract(false);
                                                        end));
                                                    end;
                                                end));
                                            end;
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p690) -- Line: 1826
                                            -- upvalues: u1 (ref), u674 (ref), u439 (ref), u6 (ref), u446 (copy), u673 (copy)
                                            if (p690.UserInputType == Enum.UserInputType.MouseButton1 or p690.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                                u674 = (u674 + 1) % 100;

                                                if u439.Name == "FD Chainsaw" then
                                                    u6.playSoundReplicate(u446.idleSound);
                                                    u6.stopSoundReplicate(u446.actionSound);

                                                    if u673.Residue.Enabled then
                                                        u673.Residue.Enabled = false;
                                                    end;
                                                elseif u439.Name == "RS Impact Wrench" and u446.actionSound.IsPlaying then
                                                    u6.stopSoundReplicate(u446.actionSound);
                                                end;
                                            end;
                                        end });
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1838
                                        -- upvalues: u2 (ref), u1 (ref), u3 (ref), u439 (ref), u6 (ref), Animator (ref), u673 (copy)
                                        u2.keepMobileGuiTypePersistent("Action", false);

                                        if u1.isAiming then
                                            u1.shoulderCam(false);
                                        end;

                                        u3.activateMouseIcon(false);
                                        u2.keepMobileGuiTypePersistent("Aim", false);

                                        if u439.Name == "FD Chainsaw" then
                                            u6.animationBuffer(Animator, "unload", "ChainsawAim", "ChainsawAimStabilize");

                                            if u673.Residue.Enabled then
                                                u673.Residue.Enabled = false;
                                            end;
                                        elseif u439.Name == "RS Impact Wrench" then
                                            u6.animationBuffer(Animator, "unload", "ImpactWrenchAim", "ImpactWrenchAimStabilize");
                                        end;
                                    end);
                                end;
                            elseif u439.Name == "Orange Parachute" or (u439.Name == "Blue Parachute" or u439.Name == "Black Parachute") then
                                if u443 == true then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    actionEvent(function() -- Line: 1852
                                        -- upvalues: u6 (ref), HumanoidRootPart (ref), u20 (ref), LocalPlayer (ref), Ragdoll (ref), u8 (ref), PlayerFunc (ref), workspace_CurrentCamera (ref), u2 (ref), u3 (ref)
                                        if not u6.invokeTraffic.deployParachute then
                                            if not u6.raycastVisible(HumanoidRootPart.Position, Vector3.new(-0, -15, -0), u20) then
                                                local function _() -- Line: 1855
                                                    -- upvalues: LocalPlayer (ref)
                                                    LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;
                                                end;

                                                if Ragdoll.isActive then
                                                    Ragdoll.activate(u8, false);
                                                end;

                                                local v691 = u6.invokeServerTraffic("deployParachute", u8);
                                                local v692 = v691 and u6.getInstanceReference(v691, 20);

                                                if v692 then
                                                    local v693 = u6.raycastParamsNew();
                                                    v693.FilterDescendantsInstances = { u8, v692 };
                                                    LocalPlayer.CameraMinZoomDistance = 5;
                                                    local AlignOrientation = v692:WaitForChild("_Seat"):WaitForChild("Attachment"):WaitForChild("AlignOrientation");

                                                    while v692.Parent do
                                                        local LookVector = HumanoidRootPart.CFrame.LookVector;

                                                        if u6.raycastVisible(HumanoidRootPart.Position, Vector3.new(-0, -6, -0), v693) or (u6.raycastVisible(HumanoidRootPart.Position, LookVector * 3, v693) or u6.raycastVisible(HumanoidRootPart.Position, LookVector * -3, v693)) then
                                                            LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                                            return PlayerFunc:InvokeServer("deployParachute");
                                                        end;

                                                        local v694 = workspace_CurrentCamera.CFrame:vectorToObjectSpace(u2.hum.MoveDirection);
                                                        local v695, v696, _ = HumanoidRootPart.CFrame:ToOrientation();

                                                        if v695 > 0.5 or v695 < -0.5 then
                                                            LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                                            return PlayerFunc:InvokeServer("deployParachute");
                                                        end;

                                                        AlignOrientation.CFrame = CFrame.new() * CFrame.Angles(0, v696 + (math.abs(v694.X) > 0.1 and (v694.X > 0 and -0.2 or 0.2) or 0), math.abs(v694.X) > 0.1 and (v694.X > 0 and -0.3 or 0.3) or 0);
                                                        task.wait();
                                                    end;

                                                    LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;
                                                end;

                                                LocalPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance;

                                                return;
                                            end;

                                            u3.notify({
                                                message = "You must be in the air",
                                                color = "red"
                                            });
                                        end;
                                    end, Mobile.Action.Action, true);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1894
                                        -- upvalues: u2 (ref)
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                    end);
                                end;
                            elseif u439.Name == "PD Handcuffs" then
                                if u443 == true then
                                    local function u699(p697) -- Line: 1901
                                        -- upvalues: u3 (ref), u6 (ref), HumanoidRootPart (ref)
                                        for i, _ in pairs(u3.nameDisplays) do
                                            local PlayerFromCharacter = u6.getPlayerFromCharacter(i.Parent.Parent);

                                            if PlayerFromCharacter then
                                                local v698;

                                                if p697 or (HumanoidRootPart.Position - i.Parent.Position).Magnitude >= 50 then
                                                    v698 = nil;
                                                else
                                                    v698 = PlayerFromCharacter:GetAttribute("WantedLevel") or nil;
                                                end;

                                                if v698 ~= i:GetAttribute("GuiWantedLevel") then
                                                    i:SetAttribute("GuiWantedLevel", v698);
                                                    u3.refreshWantedGui(i.Wanted, v698 or 0);
                                                end;
                                            end;
                                        end;
                                    end;

                                    local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.Handcuffs.MaxActivationDistance;
                                    u446.Prompts = {};
                                    CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                        promptTable = u446.Prompts,

                                        promptPreview = function() -- Line: 1919, Name: promptPreview
                                            -- upvalues: u6 (ref)
                                            return u6.clone(game.ReplicatedStorage.Gameplay.Items.Handcuffs);
                                        end,

                                        getWorkspaceObject = function(p700) -- Line: 1920, Name: getWorkspaceObject
                                            return p700.Character.PrimaryPart;
                                        end,

                                        update = function(p701, p702) -- Line: 1921, Name: update
                                            -- upvalues: u6 (ref)
                                            local v703 = game.ReplicatedStorage.Gameplay.Items[u6.getVehicleInfo.inVehicle(p702) and "HandcuffsEject" or "Handcuffs"];
                                            p701.ActionText = v703.ActionText;
                                            p701.HoldDuration = v703.HoldDuration;
                                        end,

                                        getTargets = function() -- Line: 1926, Name: getTargets
                                            -- upvalues: u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), MaxActivationDistance (copy)
                                            local v704 = {};

                                            for _, v in pairs(u6.getLoadedPlayers()) do
                                                if v ~= LocalPlayer and (v.Team and (v.Team.Name ~= "Police" and (v.Team.Name ~= "Medical" and (v.Team.Name ~= "Fire" and (v.Team.Name ~= "Road Service" and (v:GetAttribute("WantedLevel") or u6.isPrivateServerConfigurationSettingEnabled("elevatedPolicePermissions"))))))) and (u6.isCharLoaded(v) and ((v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (not v:GetAttribute("Arrested") and v.Team.Name ~= "Prisoner"))) then
                                                    v704[v] = true;
                                                end;
                                            end;

                                            return v704;
                                        end
                                    }));
                                    CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 1938
                                        -- upvalues: u699 (copy)
                                        while true do
                                            u699();
                                            task.wait(1);
                                        end;
                                    end));
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1944
                                        -- upvalues: u699 (copy)
                                        u699(true);
                                    end);
                                end;
                            elseif u439.Name == "MT First Aid Kit" or (u439.Name == "MT Bandage" or u439.Name == "FD First Aid Kit") then
                                if u443 == true then
                                    u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations[u439.Name == "MT Bandage" and "BandageSomebody" or "HealingSomebody"], PlayerStuff.Items.Animations[u439.Name == "MT Bandage" and "BandageSomebodyStanding" or "HealingSomebodyStanding"]);
                                    local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.MedicKit.MaxActivationDistance;
                                    local HoldDuration = game.ReplicatedStorage.Gameplay.Items.MedicKit.HoldDuration;
                                    local u705 = u439.Name == "MT Bandage";
                                    u446.Prompts = {};
                                    CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                        promptTable = u446.Prompts,

                                        promptPreview = function(p706) -- Line: 1960, Name: promptPreview
                                            -- upvalues: u6 (ref), GameRules (ref)
                                            local v707 = u6.clone(game.ReplicatedStorage.Gameplay.Items.MedicKit);
                                            v707.ActionText = u6.splitCapitalLetters(GameRules.bodyParts[p706.Name]);

                                            return v707;
                                        end,

                                        update = function(p708, p709) -- Line: 1965, Name: update
                                            -- upvalues: u439 (ref), GameRules (ref), HoldDuration (copy)
                                            if u439.Name == "FD First Aid Kit" or not p709.Parent.Humanoid:GetAttribute(GameRules.bodyParts[p709.Name] .. "_Bleeding") then
                                                local v710 = p709.Parent.Humanoid:GetAttribute(GameRules.bodyParts[p709.Name]) or 1000;
                                                local v711 = math.max(0, v710 - 500) / 500 * 100;
                                                local v712 = math.floor(v711) .. " %";

                                                if p708.ObjectText ~= v712 then
                                                    p708.ObjectText = v712;
                                                    p708.HoldDuration = math.max(0.1, (1 + (1000 - v710) / 1000 * HoldDuration) * (u439.Name == "MT First Aid Kit" and 1 or 2));
                                                end;
                                            elseif p708.ObjectText ~= "BLEEDING" then
                                                p708.ObjectText = "BLEEDING";
                                                p708.HoldDuration = 3.5;
                                            end;
                                        end,

                                        getTargets = function() -- Line: 1980, Name: getTargets
                                            -- upvalues: GameRules (ref), u705 (copy), HumanoidRootPart (ref), MaxActivationDistance (copy), u6 (ref), LocalPlayer (ref), u3 (ref)
                                            local u713 = {};

                                            local function v716(p714) -- Line: 1982
                                                -- upvalues: GameRules (ref), u705 (ref), HumanoidRootPart (ref), MaxActivationDistance (ref), u713 (copy)
                                                for i, v in pairs(GameRules.bodyParts) do
                                                    local v715;

                                                    if u705 then
                                                        v715 = v .. "_Bleeding" or v;
                                                    else
                                                        v715 = v;
                                                    end;

                                                    if p714.Humanoid:GetAttribute(v715) and (p714[i].Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance then
                                                        u713[p714[i]] = true;
                                                    end;
                                                end;
                                            end;

                                            for _, v in pairs(u6.getLoadedPlayers()) do
                                                if v ~= LocalPlayer and u6.isCharLoaded(v) then
                                                    v716(v.Character);
                                                end;
                                            end;

                                            for i, _ in pairs(u3.healNpcs) do
                                                v716(i);
                                            end;

                                            return u713;
                                        end
                                    }));
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 1995
                                        -- upvalues: u6 (ref), Animator (ref), u439 (ref)
                                        u6.animationBuffer(Animator, "unload", u439.Name == "MT Bandage" and "BandageSomebody" or "HealingSomebody", u439.Name == "MT Bandage" and "BandageSomebodyStanding" or "HealingSomebodyStanding");
                                    end);
                                end;
                            elseif u439.Name == "MT Stretcher" then
                                if u443 == true then
                                    local _Seat = u439:WaitForChild("_Seat");
                                    u2.firstPersonHeightRestriction = { 0, 0 };
                                    u2.setCharRotType("tool", {
                                        priority = 1,
                                        client = 0,
                                        server = 0
                                    });
                                    local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.Stretcher.MaxActivationDistance;
                                    u446.Prompts = {};
                                    CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                        promptTable = u446.Prompts,

                                        promptPreview = function() -- Line: 2015, Name: promptPreview
                                            -- upvalues: u6 (ref)
                                            return u6.clone(game.ReplicatedStorage.Gameplay.Items.Stretcher);
                                        end,

                                        getWorkspaceObject = function(p717) -- Line: 2016, Name: getWorkspaceObject
                                            return p717.Character.PrimaryPart;
                                        end,

                                        getTargets = function() -- Line: 2017, Name: getTargets
                                            -- upvalues: u6 (ref), LocalPlayer (ref), _Seat (copy), HumanoidRootPart (ref), MaxActivationDistance (copy)
                                            local v718 = {};

                                            for _, v in pairs(u6.getLoadedPlayers()) do
                                                if v ~= LocalPlayer and (not _Seat:GetAttribute("SeatOccupied") and (u6.isCharLoaded(v, {
                                                    isAlive = true
                                                }) and ((v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and not u6.getInstanceAttribute(v, "Seat")))) then
                                                    v718[v] = true;
                                                end;
                                            end;

                                            return v718;
                                        end
                                    }));
                                    CharScope.buildSignalData("Tool", { _Seat:GetAttributeChangedSignal("SeatOccupied"), function() -- Line: 2029
                                            -- upvalues: CharScope (ref), _Seat (copy), u6 (ref), u2 (ref)
                                            if CharScope.getConnectionsAndThreads("Tool").putInVehiclePrompt then
                                                CharScope.getConnectionsAndThreads("Tool").putInVehiclePrompt();
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "putInVehiclePrompt", nil);
                                            end;

                                            if _Seat:GetAttribute("SeatOccupied") then
                                                for _, v in pairs(u6.getLoadedPlayers()) do
                                                    if u6.getInstanceAttribute(v, "Seat") == _Seat then
                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "putInVehiclePrompt", u2.putInVehicleThirdPartyPrompt("Stretcher", v));

                                                        return;
                                                    end;
                                                end;
                                            end;
                                        end });
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2043
                                        -- upvalues: u2 (ref)
                                        u2.firstPersonHeightRestriction = nil;
                                        u2.setCharRotType("tool");
                                    end);
                                end;
                            elseif u439.Name == "Lockpick Device" then
                                if u443 == true then
                                    local u719 = game.ReplicatedStorage.Gameplay.Items.StealVehicle.MaxActivationDistance + 1;
                                    u446.Prompts = {};
                                    local u720 = u6.isPrivateServerConfigurationSettingEnabled("realisticVehicleTheft");
                                    CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                        promptTable = u446.Prompts,

                                        promptPreview = function() -- Line: 2057, Name: promptPreview
                                            -- upvalues: u6 (ref)
                                            return u6.clone(game.ReplicatedStorage.Gameplay.Items.StealVehicle);
                                        end,

                                        getWorkspaceObject = function(p721) -- Line: 2058, Name: getWorkspaceObject
                                            return p721.DriveSeat.Attachment;
                                        end,

                                        getTargets = function() -- Line: 2059, Name: getTargets
                                            -- upvalues: HumanoidRootPart (ref), u719 (copy), u6 (ref), LocalPlayer (ref), u720 (copy)
                                            local v722 = {};

                                            for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                                if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= u719 then
                                                    local v723 = u6.getVehicleInfo.belongsToPlayer(child);
                                                    local PlayersWithCanDriveAccess = u6.getVehicleInfo.getPlayersWithCanDriveAccess(child);
                                                    local Attribute = child:GetAttribute("OwnerIdBeforeItWasStolen");

                                                    if not (child.Config.On.Value or not (v723 or Attribute) or (v723 == LocalPlayer or (Attribute == LocalPlayer.UserId or PlayersWithCanDriveAccess and PlayersWithCanDriveAccess[LocalPlayer]) or (not u720 and u6.getVehicleInfo.getVehicleTeam(child) ~= "Civilian" or (child:GetAttribute("Totaled") or u6.getVehicleInfo.isTowed(child))))) then
                                                        v722[child] = true;
                                                    end;
                                                end;
                                            end;

                                            return v722;
                                        end
                                    }));
                                end;
                            elseif u439.Name ~= "PD Shield" then
                                if u439.Name == "Fishing Rod" or u439.Name == "Enhanced Fishing Rod" then
                                    if u443 == true then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FishingRodIdleWater, PlayerStuff.Items.Animations.FishingRodPullOut, PlayerStuff.Items.Animations.FishingRodThrow);
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        local StartPoint = Handle:WaitForChild("StartPoint");
                                        local Splash = Handle:WaitForChild("Splash");
                                        local FishingAreas = game.ReplicatedStorage.Gameplay.FishingAreas;
                                        local u724 = false;
                                        u446.tossed = false;
                                        local u725 = {};
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(function() -- Line: 2090
                                            -- upvalues: u725 (copy), FishingAreas (copy), u3 (ref)
                                            while true do
                                                local v726 = false;

                                                for i, _ in pairs(u725) do
                                                    if i.Name ~= "ActiveArea" then
                                                        u725[i] = nil;
                                                        v726 = true;
                                                    end;
                                                end;

                                                for _, child in pairs(FishingAreas:GetChildren()) do
                                                    if child.Name == "ActiveArea" and not u725[child] then
                                                        u725[child] = child.Position;
                                                        v726 = true;
                                                    end;
                                                end;

                                                if v726 then
                                                    u3.createWaypoint({
                                                        name = "Fishing Area",
                                                        image = "rbxassetid://14075571453",
                                                        create = true,
                                                        destroyOnDeath = true,
                                                        location = u725,
                                                        color = Color3.fromRGB(204, 144, 95),
                                                        hasRadius = FishingAreas.Area.Size.Y * 5
                                                    });
                                                end;

                                                task.wait(1);
                                            end;
                                        end));

                                        local function u734() -- Line: 2111
                                            -- upvalues: u446 (copy), u2 (ref), CharScope (ref), u6 (ref), u451 (ref), Animator (ref), PlayerFunc (ref), u439 (ref), HumanoidRootPart (ref), FishingAreas (copy), StartPoint (copy), GameRules (ref), u20 (ref), Splash (copy), u734 (copy), u724 (ref), u3 (ref)
                                            if u446.tossed then
                                                u2.lockHumanoidState("fishing");
                                            end;

                                            u446.tossed = not u446.tossed;

                                            if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow[1]);
                                            end;

                                            if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow2 then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow2[1]);
                                            end;

                                            if CharScope.getConnectionsAndThreads("Tool").fishingRodThrow3 then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").fishingRodThrow3[1]);
                                            end;

                                            if not u446.tossed then
                                                u6.playAnimation(u451, "play");
                                                u6.animationBuffer(Animator, "stop", "FishingRodIdleWater");
                                                PlayerFunc:InvokeServer("fishingBait", u439);

                                                return;
                                            end;

                                            local v727 = HumanoidRootPart.CFrame.Position + HumanoidRootPart.CFrame.LookVector * 10;

                                            for _, child in pairs(FishingAreas:GetChildren()) do
                                                if child.Name == "ActiveArea" and (Vector2.new(v727.X, v727.Z) - Vector2.new(child.Position.X, child.Position.Z)).Magnitude <= child.Size.Y * 5 then
                                                    local RightVector = StartPoint.WorldCFrame.RightVector;
                                                    u2.lockHumanoidState("fishing", 1);
                                                    u6.playAnimation(u451, "stop", GameRules.defaultCharacterAnimationFadeTime);
                                                    u6.animationBuffer(Animator, "play", "FishingRodIdleWater");
                                                    u6.animationBuffer(Animator, "play", "FishingRodThrow");
                                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow", CharScope.taskDelay(0.85, function() -- Line: 2130
                                                        -- upvalues: PlayerFunc (ref), u439 (ref), u6 (ref), u20 (ref), CharScope (ref), Splash (ref), StartPoint (ref), RightVector (copy), HumanoidRootPart (ref), u734 (ref), u724 (ref), Animator (ref), u3 (ref), u451 (ref), GameRules (ref)
                                                        local v728 = PlayerFunc:InvokeServer("fishingBait", u439, true);
                                                        local u729 = v728 and u6.getInstanceReference(v728, 20);

                                                        if not u729 then
                                                            return;
                                                        end;

                                                        local function _() -- Line: 2135
                                                            -- upvalues: u6 (ref), u729 (copy), u20 (ref)
                                                            local v730 = u6.raycastVisible(u729.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                            if v730 and (v730.Instance == workspace.Terrain and v730.Material == Enum.Material.Water) then
                                                                return v730;
                                                            end;
                                                        end;

                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow2", CharScope.taskDefer(function() -- Line: 2139
                                                            -- upvalues: u729 (copy), u6 (ref), u20 (ref), Splash (ref)
                                                            while u729.Parent do
                                                                local v731 = u6.raycastVisible(u729.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                                if not (v731 and (v731.Instance == workspace.Terrain and v731.Material == Enum.Material.Water)) then
                                                                    v731 = nil;
                                                                end;

                                                                if v731 then
                                                                    return u6.playSoundReplicate(Splash);
                                                                end;

                                                                task.wait(0.25);
                                                            end;
                                                        end));
                                                        u729:PivotTo(CFrame.new(StartPoint.WorldPosition));
                                                        u729.PrimaryPart:ApplyImpulse(RightVector * 5);
                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "fishingRodThrow3", CharScope.taskDefer(function() -- Line: 2147
                                                            -- upvalues: u729 (copy), HumanoidRootPart (ref), u734 (ref)
                                                            while u729.Parent do
                                                                if (u729.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude > 150 then
                                                                    return u734();
                                                                end;

                                                                task.wait(2);
                                                            end;
                                                        end));

                                                        while true do
                                                            local math_random_ret = math.random(3, 12);

                                                            for i = 1, math_random_ret do
                                                                if not u729.Parent then
                                                                    return;
                                                                end;

                                                                local v732 = u6.raycastVisible(u729.PrimaryPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u20);

                                                                if not (v732 and (v732.Instance == workspace.Terrain and v732.Material == Enum.Material.Water)) then
                                                                    v732 = nil;
                                                                end;

                                                                if not v732 then
                                                                    task.wait(3);
                                                                end;

                                                                if i == math_random_ret then
                                                                    u724 = true;
                                                                    u6.animationBuffer(Animator, "play", "FishingRodPullOut");
                                                                    local v733 = PlayerFunc:InvokeServer("catchFish");

                                                                    if v733 and u3.questFunctions.catchFish then
                                                                        u3.questFunctions.catchFish(v733);
                                                                    end;

                                                                    u6.animationBuffer(Animator, "stop", "FishingRodPullOut");
                                                                    u6.animationBuffer(Animator, "stop", "FishingRodIdleWater");
                                                                    u6.playAnimation(u451, "play", GameRules.defaultCharacterAnimationFadeTime);
                                                                    u724 = false;
                                                                    u734();

                                                                    return;
                                                                end;

                                                                task.wait(3);
                                                                local _ = i;
                                                            end;
                                                        end;
                                                    end));

                                                    return;
                                                end;
                                            end;

                                            u446.tossed = false;
                                            u3.notify({
                                                message = "There is no fish here",
                                                color = "red"
                                            });
                                        end;

                                        actionEvent(function() -- Line: 2187
                                            -- upvalues: u6 (ref), u724 (ref), u734 (copy)
                                            if u6.rest("Toss", 1) or u724 then
                                                return;
                                            end;

                                            u734();
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2191
                                            -- upvalues: u6 (ref), Animator (ref), u2 (ref), u3 (ref), u446 (copy), PlayerFunc (ref), u439 (ref)
                                            u6.animationBuffer(Animator, "unload", "FishingRodIdleWater", "FishingRodPullOut", "FishingRodThrow");
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                            u3.createWaypoint({
                                                name = "Fishing Area"
                                            });

                                            if u446.tossed then
                                                u2.lockHumanoidState("fishing");
                                                task.spawn(function() -- Line: 2197
                                                    -- upvalues: PlayerFunc (ref), u439 (ref)
                                                    PlayerFunc:InvokeServer("fishingBait", u439);
                                                end);
                                            end;
                                        end);
                                    end;
                                elseif u439.Name == "PD Ticket Clipboard" then
                                    if u443 == true then
                                        local u735 = game.ReplicatedStorage.Gameplay.Items.TicketClipboard.MaxActivationDistance + 1;
                                        u446.Prompts = {};
                                        CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                            promptTable = u446.Prompts,

                                            promptPreview = function() -- Line: 2208, Name: promptPreview
                                                -- upvalues: u6 (ref)
                                                return u6.clone(game.ReplicatedStorage.Gameplay.Items.TicketClipboard);
                                            end,

                                            getWorkspaceObject = function(p736) -- Line: 2209, Name: getWorkspaceObject
                                                return p736.Character.PrimaryPart;
                                            end,

                                            getTargets = function() -- Line: 2210, Name: getTargets
                                                -- upvalues: u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u735 (copy)
                                                local v737 = {};

                                                for _, v in pairs(u6.getLoadedPlayers()) do
                                                    if v ~= LocalPlayer and (u6.isCharLoaded(v, {
                                                        isAlive = true
                                                    }) and (v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= u735) then
                                                        v737[v] = true;
                                                    end;
                                                end;

                                                return v737;
                                            end
                                        }));
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2221
                                            -- upvalues: u2 (ref)
                                            u2.citation();
                                        end);
                                    end;
                                elseif u439.Name == "PD Speed Radar" then
                                    if u443 == true then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.HandgunAimStabilize, PlayerStuff.Items.Animations.HandgunAim);
                                        u6.guiTransition(SpeedRadar, "Position", UDim2.fromScale(0, 0.2), true);
                                        SpeedRadar:SetAttribute("Id", u439:GetAttribute("Id"));
                                        local u738 = false;
                                        local v739 = u3.readPlayerData("Settings", "SpeedUnit");
                                        local u740 = v739 and GameRules.mphToKmh or 1;
                                        SpeedRadar.SpeedLimitText.Text = v739 and "KMH" or "MPH";
                                        SpeedRadar.VehicleSpeedText.Text = v739 and "KMH" or "MPH";
                                        local u741 = nil;
                                        u741 = u3.recordSpeed(true, SpeedRadar.VehicleSpeed, function() -- Line: 2239
                                            -- upvalues: SpeedRadar (ref)
                                            SpeedRadar.VehicleSpeed.TextColor3 = Color3.fromRGB(0, 255, 17);
                                            SpeedRadar.VehicleSpeedText.TextColor3 = Color3.fromRGB(0, 255, 17);
                                            SpeedRadar.VehicleSpeed.TextTransparency = 0;
                                            SpeedRadar.VehicleSpeedText.TextTransparency = 0;
                                        end, function() -- Line: 2245
                                            -- upvalues: SpeedRadar (ref), u738 (ref), CharScope (ref), u741 (ref)
                                            SpeedRadar.VehicleSpeed.TextColor3 = Color3.fromRGB(255, 0, 0);
                                            SpeedRadar.VehicleSpeedText.TextColor3 = Color3.fromRGB(255, 0, 0);

                                            if not u738 then
                                                local u742 = false;
                                                u738 = true;
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "speedRadarThread", CharScope.taskDefer(function() -- Line: 2251
                                                    -- upvalues: u741 (ref), u742 (ref), SpeedRadar (ref), u738 (ref)
                                                    while u741.overSpeedLimit do
                                                        u742 = not u742;
                                                        SpeedRadar.VehicleSpeed.TextTransparency = u742 and 0 or 1;
                                                        SpeedRadar.VehicleSpeedText.TextTransparency = u742 and 0 or 1;
                                                        task.wait(u742 and 1 or 0.5);
                                                    end;

                                                    u738 = false;
                                                end));
                                            end;
                                        end, function() -- Line: 2262
                                            -- upvalues: SpeedRadar (ref), u741 (ref), u740 (copy)
                                            SpeedRadar.SpeedLimit.Text = u741.speedLimit and math.round(u741.speedLimit * u740) or "--";
                                        end);
                                        CharScope.addThreadOrCleanUpFunction("Tool", u741.cleanUp);
                                        local u743 = 0;
                                        aimSystem({
                                            HandgunAimStabilize = 0.7,
                                            HandgunAim = 1
                                        }, "SpeedRadar", function(p744) -- Line: 2268
                                            -- upvalues: u6 (ref), u439 (ref), Config (copy), u2 (ref), u743 (ref)
                                            local v745;

                                            if p744 then
                                                v745 = Config.AIM_GRIP;
                                            else
                                                v745 = p744;
                                            end;

                                            u6.setToolGrip(nil, u439, v745);
                                            u2.setCameraRelativeToViewModelPart(p744 and "Item" or "HumanoidRootPart", p744 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                            u743 = (u743 + 1) % 1000;
                                        end, Mobile.Action.Action);
                                        CharScope.buildSignalData("Tool", { RunService.Heartbeat, function() -- Line: 2275
                                                -- upvalues: u1 (ref), getProperCameraUnitRay (ref), u6 (ref), u19 (ref), u741 (ref), SpeedRadar (ref)
                                                if u1.isAiming then
                                                    local v746 = getProperCameraUnitRay(1000);
                                                    local v747 = u6.raycastVisible(v746.origin, v746.length, u19);

                                                    if v747 then
                                                        local v748 = v747.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) and u6.getAncestorsChild(workspace.Gameplay.Vehicles, v747.Instance);
                                                        u741.update(v748, v747.Position);

                                                        if not (v748 or u741.overSpeedLimit) then
                                                            SpeedRadar.VehicleSpeed.Text = "--";
                                                        end;
                                                    elseif not u741.overSpeedLimit then
                                                        SpeedRadar.SpeedLimit.Text = "--";
                                                        u741.lastPos = Vector3.new();
                                                    end;
                                                elseif not u741.overSpeedLimit then
                                                    SpeedRadar.SpeedLimit.Text = "--";
                                                    SpeedRadar.VehicleSpeed.Text = "--";
                                                end;
                                            end });
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2289
                                            -- upvalues: SpeedRadar (ref), u439 (ref), u6 (ref), Mobile (ref), u1 (ref), u3 (ref), u2 (ref), Animator (ref)
                                            if SpeedRadar:GetAttribute("Id") == u439:GetAttribute("Id") then
                                                u6.guiTransition(SpeedRadar, "Position", UDim2.fromScale(0, 0.2), false);
                                            end;

                                            local Action = Mobile.Action.Action;

                                            if u1.isAiming then
                                                u1.shoulderCam(false);
                                            end;

                                            u3.activateMouseIcon(false);
                                            u2.keepMobileGuiTypePersistent(Action and Action.Name or "Aim", false);
                                            u6.animationBuffer(Animator, "unload", "HandgunAimStabilize", "HandgunAim");
                                        end);
                                    end;
                                elseif u439.Name == "Metal Detector" then
                                    if u443 == true then
                                        local MetalDetector = ScreenGui.Right.Bottom.MetalDetector;
                                        local Beep = Handle:WaitForChild("Beep");
                                        u6.guiTransition(MetalDetector, "Position", UDim2.fromScale(0, 0.2), true);
                                        MetalDetector:SetAttribute("Id", u439:GetAttribute("Id"));
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(metalDetectorPointsUpdateListener));
                                        local u749 = 3.1;
                                        local u750 = 0;

                                        local function u751() -- Line: 2304
                                            -- upvalues: u750 (ref), u6 (ref), Beep (copy), MetalDetector (copy), TweenService (ref), u749 (ref)
                                            u750 = (u750 + 1) % 100;

                                            while u750 == u750 do
                                                u6.playSoundReplicate(Beep);
                                                MetalDetector.ImageLabel.Signal.ImageTransparency = 0;
                                                TweenService:Create(MetalDetector.ImageLabel.Signal, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                                    ImageTransparency = 1
                                                }):Play();
                                                task.wait(u749);
                                            end;
                                        end;

                                        local u752 = nil;
                                        local u753 = nil;
                                        local u754 = 130;
                                        local u755 = 15;
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDelay(15, function() -- Line: 454
                                            -- upvalues: u752 (copy), u753 (copy), PlayerEvent (ref), u439 (ref), u754 (copy), u755 (copy)
                                            while not u752 or u752() do
                                                if not u753 or u753() then
                                                    PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), u754);
                                                end;

                                                task.wait(u755);
                                            end;
                                        end));
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskDefer(function() -- Line: 2315
                                            -- upvalues: u3 (ref), HumanoidRootPart (ref), u749 (ref), MetalDetector (copy), CharScope (ref), u751 (copy)
                                            while true do
                                                local v756 = 50;
                                                local v757 = nil;

                                                for i, v in pairs(u3.metalDetectorPoints or {}) do
                                                    if (v - HumanoidRootPart.Position).Magnitude < v756 then
                                                        v756 = (v - HumanoidRootPart.Position).Magnitude;
                                                        v757 = i;
                                                    end;
                                                end;

                                                local v758 = v757 and (v756 < 8 and 0.25 or (v756 < 28 and 0.5 or 1)) or 3;

                                                if v758 ~= u749 then
                                                    MetalDetector.ImageLabel.Signal.ImageColor3 = v756 < 8 and Color3.fromRGB(96, 217, 75) or v756 < 28 and Color3.fromRGB(212, 183, 65) or (v757 and Color3.fromRGB(150, 129, 46) or Color3.fromRGB(129, 129, 129));
                                                    MetalDetector.ImageLabel.TextLabel.Text = v756 < 8 and "Found!" or (v757 and "Nearby" or "Clear");

                                                    if v758 < u749 then
                                                        u749 = v758;
                                                        CharScope.setThreadOrCleanUpFunctionIndex("Tool", "metalDetectorThread", CharScope.taskSpawn(u751));
                                                    end;
                                                end;

                                                u749 = v758;
                                                task.wait(1);
                                            end;
                                        end));
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2338
                                            -- upvalues: MetalDetector (copy), u439 (ref), u6 (ref)
                                            if MetalDetector:GetAttribute("Id") == u439:GetAttribute("Id") then
                                                u6.guiTransition(MetalDetector, "Position", UDim2.fromScale(0, 0.2), false);
                                            end;
                                        end);
                                    end;
                                elseif u439.Name == "Repair Kit" or u439.Name == "RS Repair Kit" then
                                    if u443 == true then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FixingVehicle);
                                        local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items[u439.Name == "Repair Kit" and "RepairKit" or "RSRepairKit"].MaxActivationDistance;
                                        u446.Prompts = {};
                                        CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                            promptTable = u446.Prompts,

                                            promptPreview = function() -- Line: 2350, Name: promptPreview
                                                -- upvalues: u6 (ref)
                                                return u6.clone(game.ReplicatedStorage.Gameplay.Items.RepairKit);
                                            end,

                                            getWorkspaceObject = function(p759) -- Line: 2351, Name: getWorkspaceObject
                                                return p759._Chassis.HoodPart;
                                            end,

                                            getTargets = function() -- Line: 2352, Name: getTargets
                                                -- upvalues: HumanoidRootPart (ref), MaxActivationDistance (copy)
                                                local v760 = {};

                                                for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                                    if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (child.Config.Durability.Value > 0 and child.Config.Durability.Value < require(child.Config).MAX_DURABILITY) then
                                                        v760[child] = true;
                                                    end;
                                                end;

                                                return v760;
                                            end
                                        }));
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2363
                                            -- upvalues: u6 (ref), Animator (ref)
                                            u6.animationBuffer(Animator, "unload", "FixingVehicle");
                                        end);
                                    end;
                                elseif u439.Name == "RS Fuel Can" then
                                    if u443 == true then
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.FuelCanAction);
                                        local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.FuelCan.MaxActivationDistance;
                                        u446.Prompts = {};
                                        CharScope.addThreadOrCleanUpFunction("Tool", u3.displayProximityPromptOnObjects({
                                            promptTable = u446.Prompts,

                                            promptPreview = function() -- Line: 2375, Name: promptPreview
                                                -- upvalues: u6 (ref)
                                                return u6.clone(game.ReplicatedStorage.Gameplay.Items.FuelCan);
                                            end,

                                            getWorkspaceObject = function(p761) -- Line: 2376, Name: getWorkspaceObject
                                                return p761._Chassis.VisualCenter;
                                            end,

                                            getTargets = function() -- Line: 2377, Name: getTargets
                                                -- upvalues: HumanoidRootPart (ref), MaxActivationDistance (copy)
                                                local v762 = {};

                                                for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                                                    if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (child.Config.Durability.Value > 0 and child.Config.Fuel.Value < require(child.Config).MAX_FUEL) then
                                                        v762[child] = true;
                                                    end;
                                                end;

                                                return v762;
                                            end
                                        }));
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2388
                                            -- upvalues: u6 (ref), Animator (ref)
                                            u6.animationBuffer(Animator, "unload", "FuelCanAction");
                                        end);
                                    end;
                                elseif u439.Name == "RS Traffic Paddle" then
                                    if u443 == true then
                                        u439:WaitForChild("Weld");
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        actionEvent(function() -- Line: 2396
                                            -- upvalues: u6 (ref), u439 (ref), PlayerFunc (ref), u8 (ref)
                                            if not u6.rest("PaddleSwitch", 0.6, u439) then
                                                PlayerFunc:InvokeServer("trafficPaddle", u8);
                                            end;
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2399
                                            -- upvalues: u2 (ref)
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                        end);
                                    end;
                                elseif u439.Name == "Trowel" then
                                    if u443 == true then
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        CharScope.addThreadOrCleanUpFunction("Tool", CharScope.taskSpawn(metalDetectorPointsUpdateListener));
                                        actionEvent(function() -- Line: 2407
                                            -- upvalues: u6 (ref), u2 (ref), u453 (ref), GameRules (ref), CharScope (ref), u3 (ref), HumanoidRootPart (ref)
                                            if not u6.rest("Trowel", 5) then
                                                u2.lockHumanoidState("trowel", -1);
                                                u6.playAnimation(u453, "play", GameRules.defaultCharacterAnimationFadeTime);
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "trowelThread", CharScope.taskDelay(5, function() -- Line: 2413
                                                    -- upvalues: u2 (ref), u6 (ref), u453 (ref), GameRules (ref), u3 (ref), HumanoidRootPart (ref)
                                                    u2.lockHumanoidState("trowel");
                                                    u6.playAnimation(u453, "stop", GameRules.defaultCharacterAnimationFadeTime);

                                                    for i, v in pairs(u3.metalDetectorPoints or {}) do
                                                        if (v - HumanoidRootPart.Position).Magnitude < 8 and not u6.invokeTraffic.metalDetectorFinding then
                                                            local v763, _, v764 = u6.invokeServerTraffic("metalDetectorFinding", i);

                                                            if v763 then
                                                                if u3.questFunctions.metalDetectorFinding then
                                                                    u3.questFunctions.metalDetectorFinding(v764);
                                                                end;

                                                                table.remove(u3.metalDetectorPoints, i);
                                                                u3.notify({
                                                                    color = "green",
                                                                    message = v763
                                                                });

                                                                return;
                                                            end;
                                                        end;
                                                    end;

                                                    u3.notify({
                                                        message = "There is nothing here",
                                                        color = "red"
                                                    });
                                                end));
                                            end;
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2433
                                            -- upvalues: u2 (ref)
                                            u2.lockHumanoidState("trowel");
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                        end);
                                    end;
                                elseif u439.Name == "Crew Graffiti" then
                                    if u443 == true then
                                        local ActionSound = Handle:WaitForChild("ActionSound");
                                        local SprayEmitter = u439:WaitForChild("Handle"):WaitForChild("Attachment"):WaitForChild("SprayEmitter");

                                        local function u765() -- Line: 2467
                                            -- upvalues: u2 (ref), u6 (ref), ActionSound (copy), PlayerEvent (ref), SprayEmitter (copy)
                                            u2.lockHumanoidState("graffiti", false);
                                            u2.rotateTowards();
                                            u6.stopSoundReplicate(ActionSound);
                                            u6.animationBuffer(u2.animator, "stop", "Graffiti");
                                            PlayerEvent:FireServer("emitter", SprayEmitter, false);
                                            u2.displayBottomBarMessage("graffiti");
                                        end;

                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        local u766 = false;
                                        u6.setToolGrip(nil, u439);
                                        actionEvent(function() -- Line: 2478
                                            -- upvalues: u766 (ref), u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u3 (ref), PlayerEvent (ref), SprayEmitter (copy), u439 (ref), u2 (ref), ActionSound (copy), CharScope (ref), u765 (copy)
                                            if u766 then
                                                return;
                                            end;

                                            u766 = true;

                                            if u6.getInstanceAttribute(LocalPlayer, "Crew") then
                                                local v767 = u6.raycastParamsNew();
                                                v767.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay, workspace.Terrain };
                                                v767.IgnoreWater = true;
                                                local v768 = u6.raycastVisible(HumanoidRootPart.Position + Vector3.new(0, 2, 0), HumanoidRootPart.CFrame.LookVector * 7, v767);

                                                if v768 then
                                                    local CFrame_new_ret = CFrame.new(v768.Position, v768.Position + v768.Normal);

                                                    for _, v in pairs({ -1, 1 }) do
                                                        local v769 = CFrame_new_ret * CFrame.new(game.ReplicatedStorage.Gameplay.Crews.Graffiti.Size.X / 2 * v, game.ReplicatedStorage.Gameplay.Crews.Graffiti.Size.Y / 2 * v, -0.2);

                                                        if not u6.raycastVisible(v769.Position, v769.LookVector * -1, v767) then
                                                            u766 = false;
                                                            u3.notify({
                                                                message = "Not enough space",
                                                                color = "red"
                                                            });

                                                            return;
                                                        end;
                                                    end;

                                                    PlayerEvent:FireServer("emitter", SprayEmitter, true);
                                                    u6.setToolGrip(nil, u439, CFrame.new(
                                                        -0.182678223,
                                                        -0.183644533,
                                                        -0.105064392,
                                                        -0.752559543,
                                                        0.652841926,
                                                        -0.0863215253,
                                                        0.634098411,
                                                        0.753763199,
                                                        0.172511384,
                                                        0.177688628,
                                                        0.0750888065,
                                                        -0.981217861
                                                    ));
                                                    u6.animationBuffer(u2.animator, "play", "Graffiti");
                                                    u2.lockHumanoidState("graffiti", -1);
                                                    u2.rotateTowards(CFrame_new_ret.Position);
                                                    u6.playSoundReplicate(ActionSound);
                                                    u2.displayBottomBarMessage("graffiti", 10, nil, 12, Color3.fromRGB(190, 106, 106));
                                                    CharScope.setThreadOrCleanUpFunctionIndex("Tool", "crewGraffitiThread", CharScope.taskDelay(12, function() -- Line: 2500
                                                        -- upvalues: u6 (ref), CFrame_new_ret (copy), u3 (ref), u439 (ref), u765 (ref), u766 (ref)
                                                        local v770 = u6.invokeServerTraffic("crewGraffiti", CFrame_new_ret);

                                                        if u6.typeOf(v770) == "string" then
                                                            u3.notify({
                                                                color = "red",
                                                                message = v770
                                                            });
                                                        end;

                                                        u6.setToolGrip(nil, u439);
                                                        u765();
                                                        u766 = false;
                                                    end));

                                                    return;
                                                end;

                                                u3.notify({
                                                    message = "You must face a wall",
                                                    color = "red"
                                                });
                                            else
                                                u3.notify({
                                                    message = "You have to be in a crew to do that",
                                                    color = "red"
                                                });
                                            end;

                                            u766 = false;
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2512
                                            -- upvalues: u765 (copy), u2 (ref)
                                            u765();
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                        end);
                                    end;
                                elseif u439.Name == "PD Notepad" or (u439.Name == "FD Notepad" or (u439.Name == "MT Notepad" or u439.Name == "RS Notepad")) then
                                    if u443 == true or u443 == "Vehicle" then
                                        Notepad:TweenPosition(UDim2.fromScale(0, 0), "Out", "Quint", 0.6, true);

                                        if not u3.notepadContent then
                                            u3.notepadContent = {};

                                            for i, v in pairs(u6.deepCopyTable(u3.readPlayerData("Notepad"))) do
                                                u3.notepadContent[i] = u6.decodeHex(v);
                                            end;
                                        end;

                                        Notepad:SetAttribute("Id", u439:GetAttribute("Id"));
                                        local u771 = u6.textBoxSystem(Notepad.TextBoxFrame);
                                        CharScope.buildSignalData("Tool", unpack(u771.multipleSignalData));
                                        CharScope.addThreadOrCleanUpFunction("Tool", u771.cleanUp);
                                        CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Paper, function() -- Line: 2528
                                            -- upvalues: u771 (copy)
                                            u771.captureFocus();
                                        end));

                                        local function u774(p772) -- Line: 2531
                                            -- upvalues: u446 (copy), Notepad (ref), u3 (ref)
                                            local v773 = u446.page or 1;
                                            u446.page = math.clamp(v773 + p772, 1, 10);

                                            if u446.page ~= v773 then
                                                game.SoundService.NotepadPage:Play();
                                            end;

                                            Notepad.TextBoxFrame.TextBox.Text = u3.notepadContent[tostring(u446.page or 1)] or "";
                                            Notepad.Page.Text = u446.page;
                                            Notepad.Back.Visible = u446.page > 1;
                                            Notepad.Next.Visible = u446.page < 10;
                                        end;

                                        u774(0);
                                        CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Next, function() -- Line: 2541
                                            -- upvalues: u774 (copy)
                                            u774(1);
                                        end));
                                        CharScope.buildSignalData("Tool", u3.mouseButton(Notepad.Back, function() -- Line: 2542
                                            -- upvalues: u774 (copy)
                                            u774(-1);
                                        end));

                                        local function v775() -- Line: 2543
                                            -- upvalues: Notepad (ref), u6 (ref), u3 (ref), u446 (copy)
                                            Notepad.TextBoxFrame.TextBox.Size = UDim2.fromScale(Notepad.TextBoxFrame.TextBox.Size.X.Scale, 0.06666666666666667);
                                            local CursorPosition = Notepad.TextBoxFrame.TextBox.CursorPosition;
                                            local _, _ = u6.fitText(Notepad.TextBoxFrame.TextBox, Notepad.TextBoxFrame.TextBox.Text, 10);
                                            u3.notepadContent[tostring(u446.page or 1)] = Notepad.TextBoxFrame.TextBox.Text;
                                            Notepad.TextBoxFrame.TextBox.CursorPosition = CursorPosition;
                                        end;

                                        v775();
                                        CharScope.buildSignalData("Tool", { Notepad.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), v775 });
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2552
                                            -- upvalues: Notepad (ref), u439 (ref), PlayerEvent (ref), u3 (ref)
                                            if Notepad:GetAttribute("Id") == u439:GetAttribute("Id") then
                                                Notepad:TweenPosition(UDim2.fromScale(0, 5.4), "Out", "Quint", 0.5, true);
                                            end;

                                            PlayerEvent:FireServer("notepadContent", u3.notepadContent);
                                        end);
                                    end;
                                elseif u439.Name == "RS Jackhammer" then
                                    if u443 == true then
                                        local Handle2 = u439:WaitForChild("Handle");
                                        local Debris = u439:WaitForChild("Emitter"):WaitForChild("Debris");
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.JackhammerAim, PlayerStuff.Items.Animations.JackhammerAimStabilize, u439:WaitForChild("DrillAnimation"));
                                        u446.drillSound = Handle2:WaitForChild("Drill");
                                        local CompressorSoundEffect = u446.drillSound:WaitForChild("CompressorSoundEffect");
                                        local EqualizerSoundEffect = u446.drillSound:WaitForChild("EqualizerSoundEffect");

                                        local function _() -- Line: 2566
                                            -- upvalues: u6 (ref), Animator (ref), u446 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                            u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                            u6.stopSoundReplicate(u446.drillSound);
                                            Debris.Enabled = false;
                                            CompressorSoundEffect.Enabled = true;
                                            EqualizerSoundEffect.Enabled = true;
                                            mouseDotInteract(false);
                                        end;

                                        aimSystem({
                                            JackhammerAimStabilize = 0.7,
                                            JackhammerAim = 1
                                        }, "Dot", function(p776) -- Line: 2574
                                            -- upvalues: CharScope (ref), u6 (ref), u2 (ref), Config (copy), Animator (ref), u446 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                            if CharScope.getConnectionsAndThreads("Tool").jackhammerThread then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread[1]);
                                            end;

                                            if CharScope.getConnectionsAndThreads("Tool").jackhammerThread2 then
                                                u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread2[1]);
                                            end;

                                            u2.setCameraRelativeToViewModelPart(p776 and "Item" or "HumanoidRootPart", p776 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);

                                            if not p776 then
                                                u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                                u6.stopSoundReplicate(u446.drillSound);
                                                Debris.Enabled = false;
                                                CompressorSoundEffect.Enabled = true;
                                                EqualizerSoundEffect.Enabled = true;
                                                mouseDotInteract(false);
                                            end;
                                        end);
                                        actionEvent(function() -- Line: 2581
                                            -- upvalues: u1 (ref), CharScope (ref), u6 (ref), Animator (ref), u446 (copy), PlayerFunc (ref), PlayerEvent (ref), u439 (ref), getProperCameraUnitRay (ref), u19 (ref), Debris (copy), mouseDotInteract (ref), CompressorSoundEffect (copy), EqualizerSoundEffect (copy)
                                            if u1.isAiming then
                                                if CharScope.getConnectionsAndThreads("Tool").jackhammerThread then
                                                    u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread[1]);
                                                end;

                                                if CharScope.getConnectionsAndThreads("Tool").jackhammerThread2 then
                                                    u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").jackhammerThread2[1]);
                                                end;

                                                u6.animationBuffer(Animator, "play", "DrillAnimation");
                                                u6.playSoundReplicate(u446.drillSound);
                                                local u777 = nil;
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "jackhammerThread", CharScope.taskDelay(1, function() -- Line: 2589
                                                    -- upvalues: u777 (ref), CharScope (ref), PlayerFunc (ref), PlayerEvent (ref), u439 (ref)
                                                    while true do
                                                        if u777 then
                                                            CharScope.taskDefer(function() -- Line: 2592
                                                                -- upvalues: PlayerFunc (ref), u777 (ref), PlayerEvent (ref), u439 (ref)
                                                                if PlayerFunc:InvokeServer("talkToMission", u777) then
                                                                    PlayerEvent:FireServer("degradeItem", u439:GetAttribute("Id"), 210);
                                                                end;
                                                            end);
                                                        end;

                                                        task.wait(1);
                                                    end;
                                                end));
                                                CharScope.setThreadOrCleanUpFunctionIndex("Tool", "jackhammerThread2", CharScope.taskSpawn(function() -- Line: 2599
                                                    -- upvalues: getProperCameraUnitRay (ref), u6 (ref), u19 (ref), u777 (ref), Debris (ref), mouseDotInteract (ref), CompressorSoundEffect (ref), EqualizerSoundEffect (ref)
                                                    while true do
                                                        local v778 = getProperCameraUnitRay(10);
                                                        local v779 = u6.raycastVisible(v778.origin, v778.length, u19);

                                                        if v779 and v779.Instance:GetAttribute("Drillable") then
                                                            u777 = v779.Instance;

                                                            if not Debris.Enabled then
                                                                mouseDotInteract(true);
                                                                Debris.Enabled = true;
                                                                CompressorSoundEffect.Enabled = false;
                                                                EqualizerSoundEffect.Enabled = false;
                                                            end;
                                                        else
                                                            u777 = nil;

                                                            if Debris.Enabled then
                                                                mouseDotInteract(false);
                                                                Debris.Enabled = false;
                                                                CompressorSoundEffect.Enabled = true;
                                                                EqualizerSoundEffect.Enabled = true;
                                                            end;
                                                        end;

                                                        task.wait(0.3);
                                                    end;
                                                end));
                                            end;
                                        end, Mobile.Action.Action);
                                        CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p780) -- Line: 2625
                                                -- upvalues: u1 (ref), u6 (ref), Animator (ref), u446 (copy), Debris (copy), CompressorSoundEffect (copy), EqualizerSoundEffect (copy), mouseDotInteract (ref)
                                                if (p780.UserInputType == Enum.UserInputType.MouseButton1 or p780.UserInputType == Enum.UserInputType.Touch) and u1.isAiming then
                                                    u6.animationBuffer(Animator, "stop", "DrillAnimation");
                                                    u6.stopSoundReplicate(u446.drillSound);
                                                    Debris.Enabled = false;
                                                    CompressorSoundEffect.Enabled = true;
                                                    EqualizerSoundEffect.Enabled = true;
                                                    mouseDotInteract(false);
                                                end;
                                            end });
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2630
                                            -- upvalues: u2 (ref), u1 (ref), u3 (ref), u6 (ref), Animator (ref)
                                            u2.keepMobileGuiTypePersistent("Action", false);

                                            if u1.isAiming then
                                                u1.shoulderCam(false);
                                            end;

                                            u3.activateMouseIcon(false);
                                            u2.keepMobileGuiTypePersistent("Aim", false);
                                            u6.animationBuffer(Animator, "unload", "JackhammerAim", "JackhammerAimStabilize", "DrillAnimation");
                                        end);
                                    end;
                                elseif u439.Name == "Empty Blue Gift" or (u439.Name == "Empty Pink Gift" or u439.Name == "Empty Red Gift") then
                                    if u443 == true then
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        actionEvent(function() -- Line: 2639
                                            -- upvalues: u6 (ref), u1 (ref), u439 (ref)
                                            if not u6.invokeTraffic.christmasGift then
                                                u1.activateInventory("Gift", {
                                                    giftBoxId = u439:GetAttribute("Id")
                                                });
                                            end;
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2644
                                            -- upvalues: u2 (ref)
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                        end);
                                    end;
                                elseif u439.Name == "Pink Gift" or (u439.Name == "Red Gift" or u439.Name == "Blue Gift") then
                                    if u443 == true then
                                        u2.keepMobileGuiTypePersistent("Action", true);
                                        CharScope.buildSignalData("Tool", { UserInputService.InputEnded, function(p781) -- Line: 2651
                                                -- upvalues: u2 (ref), CharScope (ref), u6 (ref)
                                                if p781.UserInputType == Enum.UserInputType.MouseButton1 or p781.UserInputType == Enum.UserInputType.Touch then
                                                    u2.displayBottomBarMessage("giftOpening");

                                                    if CharScope.getConnectionsAndThreads("Tool").giftThread then
                                                        u6.taskCancel(CharScope.getConnectionsAndThreads("Tool").giftThread[1]);
                                                    end;
                                                end;
                                            end });
                                        actionEvent(function() -- Line: 2657
                                            -- upvalues: u2 (ref), CharScope (ref), u6 (ref), u439 (ref)
                                            u2.displayBottomBarMessage("giftOpening", 10, "Opening", 2, Color3.fromRGB(255, 255, 255));
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "giftThread", CharScope.taskDelay(2, function() -- Line: 2659
                                                -- upvalues: u2 (ref), u6 (ref), u439 (ref)
                                                u2.displayBottomBarMessage("giftOpening");

                                                if not u6.invokeTraffic.christmasGift then
                                                    u6.invokeServerTraffic("christmasGift", "open", {
                                                        giftId = u439:GetAttribute("Id")
                                                    });
                                                end;
                                            end));
                                        end, Mobile.Action.Action);
                                        CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2666
                                            -- upvalues: u2 (ref)
                                            u2.displayBottomBarMessage("giftOpening");
                                            u2.keepMobileGuiTypePersistent("Action", false);
                                        end);
                                    end;
                                elseif u439.Name == "Snowball" and u443 == true then
                                    u2.keepMobileGuiTypePersistent("Action", true);
                                    u6.animationBuffer(Animator, "load", PlayerStuff.Items.Animations.SnowballAimStabilize, PlayerStuff.Items.Animations.SnowballAim, PlayerStuff.Items.Animations.ThrowSnowball);
                                    aimSystem({
                                        SnowballAimStabilize = 0.7,
                                        SnowballAim = 1
                                    }, "Dot", function(p782) -- Line: 2675
                                        -- upvalues: u2 (ref), Config (copy)
                                        u2.setCameraRelativeToViewModelPart(p782 and "Item" or "HumanoidRootPart", p782 and Config.FIRST_PERSON_AIM_OFFSET or CFrame.new(0, 1.7, 0), true);
                                    end);
                                    actionEvent(function() -- Line: 2679
                                        -- upvalues: u1 (ref), u6 (ref), CharScope (ref), Animator (ref), u439 (ref), getProperCameraUnitRay (ref), u19 (ref), u3 (ref), HumanoidRootPart (ref)
                                        if u1.isAiming and not u6.rest("ThrowSnowball", 2) then
                                            CharScope.setThreadOrCleanUpFunctionIndex("Tool", "snowballThread", CharScope.taskSpawn(function() -- Line: 2681
                                                -- upvalues: u6 (ref), Animator (ref), u439 (ref), getProperCameraUnitRay (ref), u19 (ref), u3 (ref), HumanoidRootPart (ref)
                                                u6.animationBuffer(Animator, "play", "ThrowSnowball");
                                                task.wait(0.25);
                                                u439.PrimaryPart.Transparency = 1;
                                                local v783 = getProperCameraUnitRay(80);
                                                local v784 = u6.raycastVisible(v783.origin, v783.length, u19, {
                                                    character = true
                                                });
                                                u3.throwPhysicsObject("Snowball", HumanoidRootPart.CFrame, v784 and v784.Position or v783.origin + v783.length, Vector3.new(0, 1, -2));
                                                task.wait(1.65);
                                                u439.PrimaryPart.Transparency = 0;
                                            end));
                                        end;
                                    end, Mobile.Action.Action);
                                    CharScope.addThreadOrCleanUpFunction("Tool", function() -- Line: 2694
                                        -- upvalues: u1 (ref), u3 (ref), u2 (ref), u6 (ref), Animator (ref), u439 (ref)
                                        if u1.isAiming then
                                            u1.shoulderCam(false);
                                        end;

                                        u3.activateMouseIcon(false);
                                        u2.keepMobileGuiTypePersistent("Aim", false);
                                        u6.animationBuffer(Animator, "unload", "SnowballAim", "SnowballAimStabilize");
                                        u2.keepMobileGuiTypePersistent("Action", false);
                                        u439.PrimaryPart.Transparency = 0;
                                    end);
                                end;
                            end;
                        end;
                    end));
                end;

                u2.onEquipStateChangedItemLoaded(u439);

                return;
            end;
        end;

        refreshHighlight(false);
    end;

    u1.renderInventoryBar();
    local u785 = 0;
    local u786 = nil;

    local function singularDropAreaFeature(p787, u788, u789) -- Line: 2948
        -- upvalues: u2 (ref), u3 (ref), Inventory (copy), CharScope (ref), u6 (ref), u11 (ref), u13 (ref)
        u2.lockHumanoidState("inventory", -1);
        u3.updateUIViewportMaxScale[Inventory.Parent._UIViewportMaxScale](0.073);
        local v790 = Inventory.Parent[p787];
        v790.Visible = true;
        Inventory.TopBar.Close.Visible = true;
        CharScope.buildSignalData("Inventory", u6.buttonHoverSignalData(Inventory.TopBar.Close, {
            childrenVisual = Inventory.TopBar.Close:GetChildren()
        }));
        Inventory.Position = UDim2.fromScale(0, -2.017);
        CharScope.buildSignalData("Inventory", u3.mouseButton(v790.Field, function() -- Line: 2957
            -- upvalues: u11 (ref), u13 (ref), u3 (ref), u789 (copy), u788 (copy)
            if u11 then
                u13 = false;

                if u3.mainBox(u789()) == 1 then
                    u788();
                end;

                u13 = true;
            end;
        end, {
            buttonType = "MouseButton1Up"
        }));
    end;

    local function updateInventoryName(p791, p792) -- Line: 2967
        -- upvalues: u6 (ref)
        p791.TopBar.TextLabel.Text = string.upper(p792);
        p791.TopBar.Close.Position = UDim2.fromScale(0.553 + u6.getTextBounds(p791.TopBar.TextLabel).X / p791.TopBar.AbsoluteSize.X / 2, p791.TopBar.Close.Position.Y.Scale);
    end;

    local function inventoryFeature(u793, u794) -- Line: 2971
        -- upvalues: u785 (ref), Inventory (copy), u3 (ref), CharScope (ref), u1 (ref), singularDropAreaFeature (copy), u12 (ref), PlayerEvent (ref), u10 (ref), refreshHighlight (copy), u11 (ref), u6 (ref), GameRules (ref), u2 (ref), updateInventoryName (copy), PlayerFunc (ref), u9 (copy), u14 (ref), u786 (ref), renderSlot (copy), u411 (ref), Value (copy)
        local u795 = u785;
        Inventory.Parent.Bin.Visible = false;
        Inventory.Parent.Storage.Visible = false;
        Inventory.Parent.Gift.Visible = false;

        if u793 == "Bin" then
            u3.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "Inventory", function() -- Line: 2977
                -- upvalues: u1 (ref)
                u1.activateInventory();
            end);
            singularDropAreaFeature("Bin", function() -- Line: 2980
                -- upvalues: u12 (ref), PlayerEvent (ref), u1 (ref), u10 (ref), Inventory (ref), refreshHighlight (ref)
                if u12 and not u12.fromStorage then
                    PlayerEvent:FireServer("modifyInventory", {
                        change = 9999999,
                        removeById = u12.fromInventory[u12.from][3]
                    });
                    u12.fromInventory[u12.from] = nil;
                    u1.renderInventory();

                    if u10 and Inventory.Slots[u10].Icon.Image == "" then
                        refreshHighlight();
                    end;
                end;
            end, function() -- Line: 2987
                -- upvalues: u11 (ref)
                return {
                    case = "Decision",
                    button2 = "CANCEL",
                    headline = "Do you want to throw out " .. u11[1] .. (u11[2] > 1 and " (x" .. u11[2] .. ")?" or "?"),
                    button = { "THROW OUT", "red" }
                };
            end);

            return;
        end;

        if u793 == "Gift" then
            u3.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "Inventory", function() -- Line: 2989
                -- upvalues: u1 (ref)
                u1.activateInventory();
            end);
            singularDropAreaFeature("Gift", function() -- Line: 2992
                -- upvalues: u12 (ref), u6 (ref), CharScope (ref), u794 (copy), u1 (ref)
                if u12 and not (u12.fromStorage or u6.invokeTraffic.christmasGift) then
                    CharScope.taskSpawn(function() -- Line: 2995
                        -- upvalues: u6 (ref), u12 (ref), u794 (ref)
                        local invokeServerTraffic = u6.invokeServerTraffic;
                        local v796 = {
                            giftId = u12.fromInventory[u12.from][3]
                        };
                        v796.giftBoxId = u794 and u794.giftBoxId;
                        invokeServerTraffic("christmasGift", "pack", v796);
                    end);
                    u1.activateInventory();
                end;
            end, function() -- Line: 2999
                return {
                    case = "Decision",
                    headline = "Do you want to pack this item as a gift?",
                    button = "PACK",
                    button2 = "CANCEL"
                };
            end);

            return;
        end;

        if u793 ~= "Storage" and (u793 ~= "Fridge" and u793 ~= "Trunk") then
            u3.updateUIViewportMaxScale[Inventory.Parent._UIViewportMaxScale](u794 and u794.bottomMessage and 0.109 or Value);
            Inventory.Position = UDim2.fromScale(0, 0);
            Inventory.TopBar.Close.Visible = true;
            updateInventoryName(Inventory, u794 and u794.customName or "Inventory");
            CharScope.buildSignalData("Inventory", u6.buttonHoverSignalData(Inventory.TopBar.Close, {
                childrenVisual = Inventory.TopBar.Close:GetChildren()
            }));

            return;
        end;

        local u797 = u793 == "Fridge" and GameRules.housingFridgeSlots or (u793 == "Trunk" and GameRules.vehicleTrunkSlots or require(u794.property.Config).STORAGE);

        if (u793 == "Storage" or u793 == "Fridge") and u6.isGamepassOwned("Property Upgrade") then
            u797 = math.round(u797 * 1.3);
        end;

        u2.lockHumanoidState("inventory", -1);
        u3.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "Inventory", function() -- Line: 3004
            -- upvalues: u1 (ref)
            u1.activateInventory();
        end);
        local Storage = Inventory.Parent.Storage;
        local math_ceil_ret = math.ceil(u797 / Storage.Slots._ScrollingList.Scroll.UIGridLayout.FillDirectionMaxCells);

        if math_ceil_ret ~= 1 and math_ceil_ret ~= 2 then
            local _ = math_ceil_ret == 3;
        end;

        u3.updateUIViewportMaxScale[Inventory.Parent._UIViewportMaxScale](0.073);
        Storage.Visible = true;
        local v798;

        if u794 then
            v798 = u794.customName or u793;
        else
            v798 = u793;
        end;

        updateInventoryName(Storage, v798);
        Storage.Position = UDim2.fromScale(0, math_ceil_ret == 1 and -1.185 or (math_ceil_ret == 2 and -1.914 or -2.643));
        Inventory.Position = UDim2.fromScale(0, math_ceil_ret == 1 and 1.2 or (math_ceil_ret == 2 and 1.929 or 2.671));
        Inventory.TopBar.Close.Visible = false;

        for _, child in pairs(Storage.Slots._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") and child.Name ~= "SlotPreview" then
                child:Destroy();
            end;
        end;

        CharScope.buildSignalData("Inventory", u6.buttonHoverSignalData(Storage.TopBar.Close, {
            childrenVisual = Storage.TopBar.Close:GetChildren()
        }));
        CharScope.buildSignalData("Inventory", u3.mouseButton(Storage.TopBar.Close, function() -- Line: 3019
            -- upvalues: u1 (ref)
            u1.activateInventory();
        end, {
            addMobileButton = true
        }));
        Storage.TopBar.Capacity.Text = "LOADING";
        CharScope.taskSpawn(function() -- Line: 3023
            -- upvalues: u793 (copy), PlayerFunc (ref), u9 (ref), u794 (copy), u3 (ref), Storage (copy), u795 (copy), u785 (ref), u797 (ref), u6 (ref), u14 (ref), u786 (ref), CharScope (ref), renderSlot (ref), u411 (ref)
            local u799, v800;

            if u793 == "Trunk" then
                u799 = PlayerFunc:InvokeServer("readData", nil, { "VehicleTrunkStorage", u9 }) or {};
                v800 = "Trunk";
            else
                u799 = PlayerFunc:InvokeServer("readData", nil, { "Housing", u794.property.Name, u793 }) or {};
                v800 = u794.property.Name .. "-" .. u793;
            end;

            if u3.openedGui == "Inventory" and (Storage.Visible and u795 == u785) then
                for i = 1, u797 do
                    local v801 = u6.clone(Storage.Slots._ScrollingList.Scroll.SlotPreview);
                    v801.Visible = true;
                    v801.Name = i;
                    v801.Parent = Storage.Slots._ScrollingList.Scroll;
                    u14(u799, v801, tostring(i), v800, u797);
                    local _ = i;
                end;

                u786 = u6.scrollingListSystem(Storage.Slots._ScrollingList.Scroll, 0.3, {
                    hideScrollBarWhenNotUsed = true,
                    scrollBar = Storage.ScrollBar
                });
                CharScope.buildSignalData("Inventory", unpack(u786.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("Inventory", u786.cleanUp);

                u411 = function() -- Line: 3044, Name: renderStorage
                    -- upvalues: u797 (ref), u799 (ref), renderSlot (ref), Storage (ref)
                    local v802 = 0;

                    for i = 1, u797 do
                        local v803 = u799[tostring(i)];
                        renderSlot(Storage.Slots._ScrollingList.Scroll[i], v803, true);
                        local v804;

                        if v803 then
                            v802 = v802 + 1;
                            v804 = i;
                        else
                            v804 = i;
                        end;
                    end;

                    Storage.TopBar.Capacity.Text = v802 .. " / " .. u797;
                end;

                u411();
            end;
        end);
    end;

    function u1.updateInventoryBottomMessage(p805) -- Line: 3068
        -- upvalues: Inventory (copy)
        Inventory.BottomMessage.Text = p805 or "";
    end;

    local u806 = false;

    function u1.hideInventoryBar(p807) -- Line: 3073
        -- upvalues: u806 (ref), InventoryBar (copy)
        u806 = p807 and true or false;
        InventoryBar.Visible = not u806;
    end;

    local u808 = nil;
    local u809 = nil;

    function u1.activateInventory(p810, u811) -- Line: 3080
        -- upvalues: u11 (ref), u3 (ref), u785 (ref), u1 (ref), CharScope (ref), u6 (ref), u806 (ref), InventoryBar (copy), u13 (ref), u411 (ref), u2 (ref), Stats (ref), u808 (ref), u809 (ref), refreshHighlight (copy), PlayerEvent (ref), Middle2 (copy), Inventory (copy), Gear (ref), Size (copy), LocalPlayer (ref), u12 (ref), u786 (ref), GameRules (ref), u10 (ref), u14 (ref), inventoryFeature (copy), UserInputService (ref), ScreenGui (copy)
        if not (u811 and u811.forceActivate) then
            if u11 then
                return;
            end;

            if u3.openedGui and u3.openedGui ~= "Inventory" then
                return;
            end;
        end;

        u785 = (u785 + 1) % 100;
        u3.openGui(p810 and "Inventory");
        u1.inventoryConfig = u811;
        CharScope.setConnectionsAndThreads("Inventory");
        u3.activateBlur("inventory", p810);
        u6.lockScroll("inventory", p810);

        if not u806 then
            InventoryBar.Visible = not p810;
        end;

        u13 = true;
        u411 = nil;
        u2.lockHumanoidState("inventory");
        Stats.Visible = not p810;
        CharScope.setThreadOrCleanUpFunctionIndex("Global", "statsGuiVisibility", p810 and function() -- Line: 3096
            -- upvalues: Stats (ref)
            Stats.Visible = true;
        end or nil);
        u3.notificationsGuiLowDisplayOrder.Visible = not p810;

        if u808 then
            u808();
            u808 = nil;
        end;

        if u809 then
            if u1.equippedItem then
                refreshHighlight(u6.findSlotWithItemId(nil, u1.equippedItem:GetAttribute("Id")));
            end;

            u809 = nil;
        end;

        if p810 then
            if not u3.readPlayerData("Guide", "Controls_Inventory") then
                PlayerEvent:FireServer("controlsGuide", "Inventory");
            end;

            if u811 and u811.closed then
                u808 = u811.closed;
            end;

            u809 = u6.typeOf(p810) == "table" and p810 and p810 or nil;

            if u809 then
                refreshHighlight(false);
            end;

            if Middle2.Details.Visible then
                Middle2.Details.Visible = false;
            end;

            u1.updateInventoryBottomMessage(u811 and (u811.bottomMessage or "") or "");
            CharScope.buildSignalData("Inventory", u3.mouseButton(Inventory.TopBar.Close, function() -- Line: 3117
                -- upvalues: u1 (ref)
                u1.activateInventory();
            end, {
                addMobileButton = true
            }));

            local function updateDetailPosition() -- Line: 3120
                -- upvalues: Middle2 (ref), u6 (ref)
                Middle2.Details.Position = u6.guiPositionAtMouse(Middle2) + UDim2.fromOffset(5, 10);
            end;

            local function itemDetails(p812, u813) -- Line: 3123
                -- upvalues: Middle2 (ref), u6 (ref), Gear (ref), Size (ref), u809 (ref), LocalPlayer (ref), u3 (ref)
                Middle2.Details.Position = u6.guiPositionAtMouse(Middle2) + UDim2.fromOffset(5, 10);
                Middle2.Details.Visible = true;

                for _, child in pairs(Middle2.Details.Stats:GetChildren()) do
                    if child:IsA("Frame") and child.Name ~= "Preview" then
                        child:Destroy();
                    end;
                end;

                Middle2.Details.Title.Text = u813[1];
                Middle2.Details:SetAttribute("Id", u813[3]);
                local v814 = u6.availableItems[u813[1]];
                Middle2.Details.Special.Visible = v814:IsDescendantOf(Gear);
                Middle2.Details.SpecialText.Size = Size;
                u6.fitText(Middle2.Details.SpecialText, Middle2.Details.Special.Visible and string.upper(v814.Parent.Parent.Name) or "", 2);
                local u815 = not u809 and u6.getItemFromId(LocalPlayer, u813[3]);

                local function configFromData(p816) -- Line: 3136
                    -- upvalues: u815 (copy), u813 (copy)
                    return not u815 and u813[4] and u813[4][p816];
                end;

                local v817 = u815 or u6.availableItems[u813[1]];

                for _, child in pairs(v817.Config:GetChildren()) do
                    local v818;

                    if child.Name == "Ammo" then
                        v818 = {};
                        v818[1], v818[2] = not u815 and u813[4] and u813[4].Ammo or child.Value, not u815 and u813[4] and u813[4].TotalAmmo or child.Parent.TotalAmmo.Value;
                    else
                        v818 = not u815 and u813[4] and u813[4][child.Name] or child.Value;
                    end;

                    u3.createProperty(child.Name, v818, Middle2.Details.Stats.Preview);
                end;

                local Config = require(v817.Config);

                for i, v in pairs(Config) do
                    if i ~= "RANK" then
                        u3.createProperty(i, not u815 and u813[4] and u813[4][i] or v, Middle2.Details.Stats.Preview);
                    end;
                end;

                if (u813[4] and u813[4].Condition or Config.CONDITION == "Freshness") and (Config.CONDITION == "Freshness" or math.ceil(u813[4].Condition / 1000 * 100) < 100) then
                    u3.createProperty("ITEM_CONDITION_" .. string.upper(u6.typeOf(Config.CONDITION) == "string" and (Config.CONDITION or "Durability") or "Durability"), u813[4] and (u813[4].Condition or 1000) or 1000, Middle2.Details.Stats.Preview);
                end;

                Middle2.Details.Description.Visible = Config.DESCRIPTION;
                Middle2.Details.Background.Size = UDim2.fromScale(Middle2.Details.Background.Size.X.Scale, 0.25 + Middle2.Details.Stats.Position.Y.Scale + Middle2.Details.Stats.UIListLayout.AbsoluteContentSize.Y / Middle2.Details.AbsoluteSize.Y + (Config.DESCRIPTION and Middle2.Details.Description.Size.Y.Scale or 0));

                if Config.DESCRIPTION then
                    Middle2.Details.Description.TextLabel.Text = Config.DESCRIPTION;
                    Middle2.Details.Description.Position = UDim2.fromScale(0, Middle2.Details.Background.Size.Y.Scale);
                end;

                while u6.isInFrame(p812) do
                    task.wait(0.03);

                    if not Middle2.Visible then
                        return;
                    end;
                end;

                if u813 and Middle2.Details:GetAttribute("Id") == u813[3] then
                    Middle2.Details.Visible = false;
                end;
            end;

            local u819 = nil;
            u11 = nil;
            u12 = nil;
            local u820 = nil;
            local u821 = nil;
            local u822 = nil;

            u14 = function(u823, u824, u825, u826, u827) -- Line: 3174, Name: connectSlot
                -- upvalues: CharScope (ref), u6 (ref), u3 (ref), u811 (copy), u809 (ref), u13 (ref), u12 (ref), u819 (ref), u786 (ref), u820 (ref), Middle2 (ref), u821 (ref), u11 (ref), u1 (ref), u822 (ref), GameRules (ref), u10 (ref), refreshHighlight (ref), PlayerEvent (ref), itemDetails (copy)
                local v828 = {};

                for _, child in pairs(u824:GetChildren()) do
                    if child.Name == "Line" then
                        table.insert(v828, child);
                    end;
                end;

                CharScope.buildSignalData("Inventory", u6.buttonHoverSignalData(u824, {
                    intensity = 7,
                    childrenVisual = v828
                }));
                CharScope.buildSignalData("Inventory", u3.mouseButton(u824, function() -- Line: 3178
                    -- upvalues: u811 (ref), u824 (copy), u825 (copy), u823 (copy), u809 (ref), u13 (ref), u12 (ref), u826 (copy), u819 (ref), u6 (ref), u786 (ref), u3 (ref), u820 (ref), Middle2 (ref), u821 (ref), u11 (ref), u1 (ref), u822 (ref), GameRules (ref), u827 (copy), u10 (ref), refreshHighlight (ref), PlayerEvent (ref)
                    if u811 and u811.slotClicked then
                        u811.slotClicked(u824, u825, u823[u825]);
                    end;

                    if u809 then
                        return;
                    end;

                    if not u13 then
                        return;
                    end;

                    if u823[u825] then
                        u12 = {
                            fromInventory = u823,
                            gui = u824,
                            from = u825,
                            fromStorage = u826
                        };
                        u819 = u6.getMousePos();

                        if u786 and u3.platform == "Mobile" then
                            u786.freezed = true;
                        end;

                        u820 = Vector2.new(u824.AbsolutePosition.X + u824.AbsoluteSize.X / 2 - u6.getMousePos().X, u824.AbsolutePosition.Y + u824.AbsoluteSize.Y / 2 - u6.getMousePos().Y);

                        u821 = function() -- Line: 3187, Name: grabItem
                            -- upvalues: Middle2 (ref), u821 (ref), u11 (ref), u823 (ref), u825 (ref), u1 (ref)
                            Middle2.Details.Visible = false;
                            u821 = nil;
                            u11 = u823[u825];
                            u823[u825] = nil;
                            u1.renderInventory();
                        end;

                        u822 = function(p829, p830, p831, p832) -- Line: 3194, Name: slotUp
                            -- upvalues: u786 (ref), u819 (ref), u822 (ref), u11 (ref), GameRules (ref), u6 (ref), u3 (ref), u823 (ref), u826 (ref), u825 (ref), u827 (ref), u1 (ref), u10 (ref), refreshHighlight (ref), PlayerEvent (ref)
                            if u786 then
                                u786.freezed = false;
                            end;

                            u819 = nil;
                            u822 = nil;

                            if p829 then
                                if u11 then
                                    local v833 = GameRules.inventorySize + u6.getPocketAmountInventory();

                                    if not p831 and (tonumber(p829) and (v833 < tonumber(p829) and not u6.rest("moreInventorySlotsNotification", 120))) then
                                        u3.notify({
                                            message = "Do you need more slots? Buy Pockets at the supermarket"
                                        });
                                    end;

                                    local v834, v835, _ = u6.slotMovedInventory(nil, u823, p830, u11, {
                                        fromStorage = u826,
                                        toStorage = p831,
                                        from = u825,
                                        to = p829,
                                        fromSize = u827 or GameRules.inventorySize + GameRules.maxPocketAmount,
                                        toSize = p832 or v833
                                    });
                                    u11 = nil;
                                    u1.renderInventory();

                                    if v834 == true then
                                        if u825 == u10 then
                                            if u826 or (p831 or not tonumber(p829)) then
                                                refreshHighlight();
                                                u1.equipSlot();
                                            else
                                                refreshHighlight(p829);
                                            end;
                                        elseif p829 == u10 then
                                            if u826 or (p831 or not tonumber(u825)) then
                                                refreshHighlight();
                                                u1.equipSlot();
                                            else
                                                refreshHighlight(u825);
                                            end;
                                        end;

                                        PlayerEvent:FireServer("modifyInventory", {
                                            from = u825,
                                            fromStorage = u826,
                                            to = p829,
                                            toStorage = p831
                                        });

                                        return;
                                    end;

                                    if u6.typeOf(v835) == "string" then
                                        u3.notify({
                                            color = "red",
                                            message = v835
                                        });
                                    end;
                                elseif not (u826 or (u825 ~= p829 or not tonumber(p829))) then
                                    u1.equipSlot(p829);
                                end;
                            elseif u11 then
                                u823[u825] = u11;
                                u11 = nil;
                                u1.renderInventory();
                            end;
                        end;
                    end;
                end));

                if not u809 then
                    CharScope.buildSignalData("Inventory", u3.mouseButton(u824, function() -- Line: 3229
                        -- upvalues: u822 (ref), u825 (copy), u823 (copy), u826 (copy), u827 (copy)
                        if u822 then
                            u822(u825, u823, u826, u827);
                        end;
                    end, {
                        buttonType = "MouseButton1Up"
                    }));
                end;

                CharScope.buildSignalData("Inventory", { u824.MouseEnter, function() -- Line: 3233
                        -- upvalues: u13 (ref), u823 (copy), u825 (copy), u11 (ref), itemDetails (ref), u824 (copy)
                        if not u13 then
                            return;
                        end;

                        if u823[u825] and not u11 then
                            itemDetails(u824, u823[u825]);
                        end;
                    end });
            end;

            inventoryFeature(p810, u811);
            u1.renderInventory(u809);

            for i = 1, GameRules.inventorySize + GameRules.maxPocketAmount do
                u14(u809 or u3.inventory, Inventory.Slots[i], (tostring(i)));
                local _ = i;
            end;

            u14(u809 or u3.inventory, Inventory.Pocket, "pocket");
            u14(u809 or u3.inventory, Inventory.Jewelry, "jewelry");
            CharScope.buildSignalData("Inventory", { UserInputService.InputChanged, function(p836) -- Line: 3247
                    -- upvalues: u819 (ref), u821 (ref), u11 (ref), Middle2 (ref), u6 (ref), u820 (ref)
                    if p836.UserInputType == Enum.UserInputType.MouseMovement or p836.UserInputType == Enum.UserInputType.Touch then
                        if u819 then
                            if u821 and (u819 - Vector2.new(p836.Position.X, p836.Position.Y)).magnitude > 10 then
                                u821();
                            end;

                            if u11 then
                                Middle2.GrabIcon.Position = u6.guiPositionAtMouse(Middle2) + UDim2.fromOffset(u820.X, u820.Y);
                            end;
                        end;

                        if Middle2.Details.Visible then
                            Middle2.Details.Position = u6.guiPositionAtMouse(Middle2) + UDim2.fromOffset(5, 10);
                        end;
                    end;
                end });
            CharScope.buildSignalData("Inventory", { UserInputService.InputEnded, function(p837) -- Line: 3260
                    -- upvalues: u822 (ref)
                    if (p837.UserInputType == Enum.UserInputType.MouseButton1 or p837.UserInputType == Enum.UserInputType.Touch) and u822 then
                        u822();
                    end;
                end });
        else
            u1.renderInventoryBar();
        end;

        if u1.inventoryActive ~= p810 then
            u6.guiTransition(ScreenGui.Inventory, "Size", 0.9, p810);
        end;

        u1.inventoryActive = u809 and "inspect" or p810;
    end;

    function u1.equipUserInput(p838) -- Line: 3270
        -- upvalues: u3 (ref), u2 (ref), u1 (ref)
        if u3.openedGui and (u3.openedGui ~= "Inventory" and u3.openedGui ~= "Citation") then
            return;
        end;

        if p838 <= 5 and not u2.freecamActive then
            local equipSlot = u1.equipSlot;
            local v839 = u3.inventory[tostring(p838)] and tostring(p838);
            equipSlot(v839);
        end;
    end;

    function u1.inventoryUserInput() -- Line: 3275
        -- upvalues: u1 (ref)
        u1.activateInventory(not u1.inventoryActive);
    end;

    u3.debugLoadingClient("Inventory 3");
end;

return CharScope.addToCharacterModule(u1);
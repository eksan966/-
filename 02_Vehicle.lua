-- Decompiled with Potassium's decompiler.

local u1 = {
    seat = nil,
    gear = 1,
    absSpeed = 0,
    maxFuel = 0,
    maxDurability = 0,
    maxSpeed = 0,
    gearChange = { 0 }
};
local ModuleLoader = require(game.ReplicatedStorage.Modules.ModuleLoader);
local u2 = ModuleLoader.assign(script.Parent:WaitForChild("Character"));
local u3 = ModuleLoader.assign(script.Parent.Character:WaitForChild("Inventory"));
local u4 = ModuleLoader.assign(script.Parent:WaitForChild("Events"));
local u5 = ModuleLoader.assign(script.Parent:WaitForChild("Core"));
local u6 = ModuleLoader.assign(script.Parent:WaitForChild("Interaction"));
local u7 = ModuleLoader.assign(script.Parent.Character:WaitForChild("AutoShop"));
local EmergencyLightingSystem = require(script.Parent.EmergencyLightingSystem);
local Ragdoll = require(game.ReplicatedStorage.Modules:WaitForChild("Ragdoll"));
local PlayerEvent = game.ReplicatedStorage.Remote.PlayerEvent;
local PlayerFunc = game.ReplicatedStorage.Remote.PlayerFunc;
local u8 = 0;
local u9 = ModuleLoader.assign(game.ReplicatedStorage.Modules.Algorithms);
local GameRules = require(game.ReplicatedStorage.Modules.GameRules);
local Heartbeat = game:GetService("RunService").Heartbeat;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u10 = {};
local u11 = {};
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
game:GetService("CollectionService");
LocalPlayer:WaitForChild("PlayerGui");
game:GetService("ProximityPromptService");
game:GetService("PhysicsService");
local GuiService = game:GetService("GuiService");
local Easing = require(game.ReplicatedStorage.Modules.Easing);
local Vehicle = game.ReplicatedStorage.Gameplay.Vehicle;
local u12 = nil;
local u13 = nil;
local u14 = u9.raycastParamsNew();
u14.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Vehicles };
u14.IgnoreWater = true;
local u15 = {
    [Enum.Material.Sand] = "Snow",
    [Enum.Material.Sandstone] = "Snow",
    [Enum.Material.Ground] = "Dirt",
    [Enum.Material.Salt] = "Snow",
    [Enum.Material.Mud] = "Dirt",
    [Enum.Material.Asphalt] = "Snow",
    [Enum.Material.Glacier] = "Dirt",
    [Enum.Material.LeafyGrass] = "Snow",
    [Enum.Material.Grass] = "Snow",
    [Enum.Material.Rubber] = "Dirt"
};
local u16 = {
    [1] = 0,
    [0.9] = 0.12,
    [0.8] = 0.25,
    [0.7] = 0.45,
    [0.6] = 0.7,
    [0.5] = 0.95,
    [0.4] = 1.3,
    [0.3] = 2.1,
    [0.2] = 3.6
};
local u17 = 55 / GameRules.velocityToMph;
local u18 = false;

function u1.vehicleTimeOfDay(p19) -- Line: 56
    -- upvalues: u9 (copy), LocalPlayer (copy), PlayerEvent (copy), u1 (copy)
    local v20 = u9.getVehicleInfo.lastDrivenVehicle(LocalPlayer);

    if v20 then
        if not v20.Config.Headlights:GetAttribute("DynamicTimeOfDay") then
            PlayerEvent:FireServer("setVehicleDynamicLights", true);
        end;

        if u1.setVehicleLights then
            u1.setVehicleLights(not p19);
        end;
    end;
end;

local u21 = 0;

local function vehicleIntentionalCrashWantedPoints(p22, p23) -- Line: 66
    -- upvalues: u9 (copy), u21 (ref), PlayerEvent (copy)
    if u9.getVehicleInfo.getVehicleTeam(p22) == "Police" and p23 then
        local v24 = u9.getVehicleInfo.controlledBy(p23);

        if v24 and v24:GetAttribute("WantedLevel") then
            return;
        end;
    end;

    if u21 <= 0 then
        task.delay(15, function() -- Line: 72
            -- upvalues: u21 (ref)
            while u21 > 0 do
                u21 = u21 - 1;
                task.wait(15);
            end;

            u21 = 0;
        end);
    end;

    u21 = math.min(6, u21 + 1);

    if u21 >= 3 then
        PlayerEvent:FireServer("violation", "Vehicular Ramming");
    end;
end;

function u1.moveVehicleInsideOutside(p25) -- Line: 84
    -- upvalues: PlayerFunc (copy), u9 (copy), u5 (copy)
    local v26 = PlayerFunc:InvokeServer("moveVehicleInsideOutside", p25);

    if u9.typeOf(v26) == "string" then
        u5.notify({
            color = "red",
            message = v26
        });
    end;
end;

local u27 = false;

local function driveOutOfInsideLocation(p28, u29) -- Line: 90
    -- upvalues: u27 (ref), u7 (copy), u9 (copy), u5 (copy), u1 (copy)
    if not u27 then
        if u7.autoShopLocation then
            return;
        end;

        u27 = true;
        local selectVehicleSpawn = u9.selectVehicleSpawn;
        local Value = u29.Parent.ExitSpawns.Value;
        local v30 = u29:FindFirstChild("ID") and u29.ID.Value;
        local u31 = selectVehicleSpawn(Value, v30);
        u5.enterLocation({
            startFunc = function() -- Line: 96, Name: startFunc
                -- upvalues: u9 (ref), u29 (copy), u31 (copy)
                u9.playSoundReplicate(u29.GarageSound.PromptSound);
                u9.playSoundReplicate(u31.GarageSound.PromptSound);
            end,

            startedFunc = function() -- Line: 100, Name: startedFunc
                -- upvalues: u1 (ref), u31 (copy), u27 (ref)
                u1.moveVehicleInsideOutside(u31);
                u27 = false;
            end
        });
    end;
end;

function u1.makeSureAboutDespawningVehicle() -- Line: 108
    -- upvalues: u9 (copy), LocalPlayer (copy), u5 (copy)
    local BelongingVehicle = u9.getVehicleInfo.getBelongingVehicle(LocalPlayer);

    if BelongingVehicle then
        local InstanceAttribute = u9.getInstanceAttribute(BelongingVehicle, "MissionVehicle");
        local v32 = game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) and not u9.collectionHasTag(game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable[LocalPlayer.Name], "FinishedRace");

        if InstanceAttribute and u5.mainBox({
            case = "Decision",
            button = "OK",
            button2 = "CANCEL",
            headline = v32 and "The current vehicle will disappear, canceling the active race" or (InstanceAttribute:GetAttribute("Crime") and "The current vehicle will disappear, canceling the active crime" or "The current vehicle will disappear, canceling the active job")
        }) ~= 1 then
            return;
        end;
    end;

    return true;
end;

function u1.isVehicleFliped(p33) -- Line: 118
    return 1 - p33.PrimaryPart.CFrame.UpVector:Dot(Vector3.new(0, 1, 0)) > 0.6666666666666666;
end;

function u1.makeSureAboutEnteringWithVehicle(p34, p35, p36) -- Line: 122
    -- upvalues: u9 (copy), LocalPlayer (copy), u1 (copy)
    local v37 = u9.getVehicleInfo.controlledVehicle(LocalPlayer);

    if not v37 then
        return "You must have a vehicle to enter";
    end;

    local OriginalVehicle = u9.getOriginalVehicle(v37);
    local Config = require(OriginalVehicle.Config);

    if p36 ~= nil and Config.CATEGORY == "Boat" ~= p36 then
        return p36 and "Only boats are allowed to enter" or "Boats are not allowed to enter";
    end;

    if not p35 and u9.getVehicleInfo.getVehicleTeam(OriginalVehicle) ~= "Civilian" then
        return "You can\'t enter with a job vehicle";
    end;

    if not p34 or u1.makeSureAboutDespawningVehicle() then
        return v37;
    end;
end;

function u1.spawnVehicle(p38, p39, p40) -- Line: 136
    -- upvalues: PlayerFunc (copy), u9 (copy), u5 (copy)
    if p38 then
        if not u9.invokeTraffic.spawnVehicle then
            local v41, v42 = u9.invokeServerTraffic("spawnVehicle", p38, p39, p40);

            if v42 then
                u5.notify({
                    color = "red",
                    message = v42
                });
            end;

            if v41 then
                v41 = u9.getInstanceReference(v41, 20);
            end;

            return v41;
        end;

        return;
    end;

    PlayerFunc:InvokeServer("spawnVehicle");
end;

function u1.vehicleTrunkPrompt() -- Line: 146
    -- upvalues: LocalPlayer (copy), u2 (copy), u9 (copy), u3 (copy), u5 (copy)
    if require(LocalPlayer.Team.Config).TRUNK_STORAGE_ENABLED then
        if u2.loaded then
            u9.animationBuffer(u2.animator, "play", "Interact");
        end;

        if u2.loaded then
            u3.activateInventory("Trunk", {
                customName = LocalPlayer.Team.Name == "Civilian" and "Trunk" or LocalPlayer.Team.Name .. " Trunk"
            });
        end;
    else
        u5.notify({
            message = "You can\'t access this trunk",
            color = "red"
        });
    end;
end;

function u1.loadVehicle(u43, p44) -- Line: 154
    -- upvalues: Vehicle (copy), EmergencyLightingSystem (copy), u4 (copy), u9 (copy), workspace_CurrentCamera (copy)
    local Config = require(u43.Config);
    local Config2 = u43.Config;
    local u45 = {};
    local u46 = {};
    local u47 = 0;
    local u48 = 0;
    local _Chassis = u43._Chassis;
    local On = Config2.On;
    local Steer = Config2.Steer;
    local GearSpeed = Config2.GearSpeed;
    local Engine = u43._Chassis.Engine;
    local Tire = u43._Chassis.Tire;
    local _ = Vehicle.Sounds.Default.Tire.Volume;
    local u49 = {};
    local u50 = 0;
    local u51;

    if Config.ENGINE_TYPE == "Electric" then
        u51 = Engine.EVEngineGroup;
    else
        u51 = false;
    end;

    if Tire.SoundId == "" then
        Tire = nil;
    end;

    local _ = Engine.Playback.Value / 100;
    local u52 = Config.VISUAL_STEERING and _Chassis.Steering.Weld;
    local u53 = Engine:FindFirstChild("LowGain") and (Engine.LowGain.Value or 0) or 0;
    local u54 = Engine:FindFirstChild("LowGainChange") and Engine.LowGainChange;

    if Engine:FindFirstChild("HighGain") then
        Engine.EngineEqualizer.HighGain = Engine.HighGain.Value;
    end;

    if Engine:FindFirstChild("MidGain") then
        Engine.EngineEqualizer.MidGain = Engine.MidGain.Value;
    end;

    if u53 then
        Engine.EngineEqualizer.LowGain = u53;
    end;

    if Config2:FindFirstChild("ManualPitchedSiren") then
        table.insert(p44, EmergencyLightingSystem.loadManualPitchedSiren(Config2.ManualPitchedSiren, _Chassis.Manual));
    end;

    for _, child in pairs(u43.Thrusters:GetChildren()) do
        if child:FindFirstChild("WheelWeld") then
            local v55 = child.Name == "FrontThruster" and u46 and u46 or u45;
            local v56 = { child, child:GetAttribute("WheelSize"), child:GetAttribute("DefaultHeight") };
            table.insert(v55, v56);
        end;
    end;

    local u57 = 0;

    if Config2:FindFirstChild("ELS") and Config2.ELS.Value ~= 0 then
        task.spawn(EmergencyLightingSystem.activate, u43, Config2.ELS.Value);
    end;

    if Config2.Indicator.Value ~= 0 then
        task.spawn(u4.playerEvent.indicator, u43, Config2.Indicator.Value);
    end;

    if Config2:FindFirstChild("Takedown") and Config2.Takedown.Value then
        task.spawn(EmergencyLightingSystem.activateTakedown, u43, Config2.Takedown.Value);
    end;

    if Config2:FindFirstChild("Advisor") and Config2.Advisor.Value then
        task.spawn(EmergencyLightingSystem.activateAdvisor, u43, Config2.Advisor.Value);
    end;

    local u58 = u9.raycastParamsNew();
    u58.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Vehicles };
    u58.IgnoreWater = true;

    local function setThruster(p59, p60, p61, p62) -- Line: 184
        -- upvalues: u9 (ref), u58 (copy), Config (copy), u57 (ref)
        local v63 = p59.Position + p59.CFrame.UpVector * p60;
        local v64 = u9.raycastVisible(v63, p59.CFrame.UpVector * -(p61 / 2 + 0.2), u58);
        local v65 = v64 and (v64.Position - v63).Magnitude - p61 / 2 or 0.2;
        p59.WheelWeld.C0 = p62;
        p59.WheelWeld.C1 = CFrame.new(0, u9.lerp(p59.WheelWeld.C1.Position.Y, -math.max(v65, -(Config.MAX_WHEEL_RISE or 3)) + p60, 1 - 1e-18 ^ u57), 0);
    end;

    local u66 = false;

    if Config.ENGINE_TYPE == "Electric" then
        table.insert(u49, function() -- Line: 193
            -- upvalues: u51 (copy), u50 (ref)
            local math_abs_ret = math.abs(u50);
            u51.Volume = math.clamp(math_abs_ret, 0, 65) / 65;
        end);
    end;

    if u54 then
        table.insert(u49, function() -- Line: 196
            -- upvalues: Engine (copy), u53 (copy), u50 (ref), GearSpeed (copy), u54 (copy)
            Engine.EngineEqualizer.LowGain = u53 + u50 / GearSpeed.Value * u54.Value;
        end);
    end;

    if u52 then
        table.insert(u49, function() -- Line: 199
            -- upvalues: u52 (copy), u48 (ref), Config (copy)
            u52.C0 = CFrame.Angles(0, u48 * Config.VISUAL_STEERING, 0);
        end);
    end;

    table.insert(p44, task.spawn(function() -- Line: 201
        -- upvalues: u43 (copy), _Chassis (copy), workspace_CurrentCamera (ref), On (copy), u66 (ref), u50 (ref), u45 (copy), setThruster (copy), u47 (ref), u46 (copy), u48 (ref), u57 (ref), u9 (ref), Steer (copy), Engine (copy), GearSpeed (copy), Tire (ref), u49 (copy)
        while true do
            while true do
                if u43:GetAttribute("Totaled") then
                    return;
                end;

                local magnitude = (_Chassis.Position - workspace_CurrentCamera.CFrame.Position).magnitude;

                if not On.Value or magnitude >= 400 then
                    break;
                end;

                if not u66 then
                    u66 = true;
                end;

                local v67 = -_Chassis.CFrame:VectorToObjectSpace(_Chassis.AssemblyLinearVelocity).Z;
                u50 = math.abs(v67);

                for _, v in pairs(u45) do
                    setThruster(v[1], v[3], v[2] * (v[1].Wheel.Tire.WheelCollision.Transparency == 0 and 1 or 0.75), CFrame.Angles(u47 * (1 / v[2]), 0, 0));
                end;

                local v68 = (1 - math.min(1, u50 / 80)) * 0.5 + 0.5;

                for _, v in pairs(u46) do
                    setThruster(v[1], v[3], v[2] * (v[1].Wheel.Tire.WheelCollision.Transparency == 0 and 1 or 0.75), CFrame.Angles(u47 * (1 / v[2]), 0, 0) * CFrame.Angles(0, u48 * v68, 0));
                end;

                u47 = u47 + v67 * 0.027 * u57 * 60;
                u48 = u9.lerp(u48, Steer.Value * 0.5, 1 - 0.045 ^ u57);
                Engine.PlaybackSpeed = u9.lerp(Engine.PlaybackSpeed, Engine.Playback.Value / 100 + (u43:GetAttribute("EngineSpeed") or u50 / GearSpeed.Value) * (1.3 + (Engine:FindFirstChild("Acceleration") and Engine.Acceleration.Value / 100 or 0)), 1 - 0.001 ^ u57);

                if Tire and (magnitude < 100 and u50 < 50) then
                    Tire.PlaybackSpeed = u50 * 0.02 + 0.7;
                    Tire.Volume = u50 < 10 and u50 * 0.04 or 0.5 - u50 * 0.01;
                end;

                for _, v in pairs(u49) do
                    v(u57);
                end;

                u57 = task.wait();
            end;

            if u66 then
                u66 = false;

                for _, v in pairs(u45) do
                    v[1].WheelWeld.C1 = CFrame.new(0, v[1]:GetAttribute("DefaultHeight"), 0);
                end;

                for _, v in pairs(u46) do
                    v[1].WheelWeld.C1 = CFrame.new(0, v[1]:GetAttribute("DefaultHeight"), 0);
                end;

                for i = Engine.PlaybackSpeed, 0, -0.05 do
                    Engine.PlaybackSpeed = i;
                    task.wait(0.016);

                    if On.Value then
                        break;
                    end;

                    local _ = i;
                end;

                if not On.Value then
                    Engine:Stop();
                end;
            end;

            task.wait(0.5);
        end;
    end));
end;

local u69 = {};

local function belongingVehicleListener(u70) -- Line: 243
    -- upvalues: u9 (copy), u69 (copy), u5 (copy), PlayerEvent (copy), u14 (copy), PlayerFunc (copy), u2 (copy), LocalPlayer (copy)
    u9.clearConnectionsAndThreads(u69);

    if u70 and not u70.Parent then
        return;
    end;

    if not (u70 and u70.Config.On.Value) and u5.createWaypoint then
        local v71;

        if u70 then
            v71 = not u5.readPlayerData("Settings", "NewlySpawnedVehicleWaypoint");
        else
            v71 = u70;
        end;

        local createWaypoint = u5.createWaypoint;
        local v72 = {
            name = "Your Vehicle",
            image = "rbxassetid://10856840226",
            create = u70
        };
        local v73;

        if u70 then
            v73 = u70._Chassis.VisualCenter;
        else
            v73 = u70;
        end;

        v72.location = v73;
        v72.color = Color3.fromRGB(106, 197, 78);
        v72.hideOnScreen = not v71;
        v72.showForSomeTime = v71 and 7;
        createWaypoint(v72);
    end;

    if u70 then
        if game.ReplicatedStorage.Gameplay.Quests.Content:FindFirstChild(u70.Config.Type.Value .. " Vehicle Spawner") and not u5.readPlayerData("Quests", u70.Config.Type.Value .. " Vehicle Spawner") then
            PlayerEvent:FireServer("questCompleted", u70.Config.Type.Value .. " Vehicle Spawner");
        end;

        local u74 = u9.overlapParamsNew();
        u74.FilterDescendantsInstances = {
            u70,
            workspace.World,
            workspace.Characters,
            u70.Config.Trailer.Value
        };

        local function isCollidingWithVehicle() -- Line: 259
            -- upvalues: u70 (copy), u74 (copy)
            local v75 = u70.PrimaryPart:FindFirstChild("TrailerVisualCenter") or u70.PrimaryPart.VisualCenter;
            local Attribute = v75:GetAttribute("BoxSize");
            local l_pairs = pairs;
            local l_workspace = workspace;
            local WorldCFrame = v75.WorldCFrame;
            local math_max_ret = math.max(2, Attribute.X - 3);
            local math_max_ret2 = math.max(2, Attribute.Y - 3);
            local math_max_ret3 = math.max(2, Attribute.Z - 3);

            for _, v in l_pairs(l_workspace:GetPartBoundsInBox(WorldCFrame, Vector3.new(math_max_ret, math_max_ret2, math_max_ret3), u74)) do
                if v:IsDescendantOf(workspace.Gameplay.Vehicles) then
                    return true;
                end;
            end;
        end;

        local function setCollision(p76) -- Line: 266
            -- upvalues: u70 (copy)
            for _, descendant in pairs(u70:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CollisionGroup = p76;
                end;
            end;
        end;

        setCollision("VehiclesNonCollide");
        table.insert(u69, task.spawn(function() -- Line: 270
            -- upvalues: isCollidingWithVehicle (copy), setCollision (copy)
            repeat
                task.wait(2);
            until not isCollidingWithVehicle();

            return setCollision("Vehicles");
        end));

        local function isOnGround() -- Line: 278
            -- upvalues: u9 (ref), u70 (copy), u14 (ref)
            return u9.raycastVisible(u70.PrimaryPart.Position, Vector3.new(0, -20, 0), u14, {
                customRequirements = function(p77) -- Line: 279, Name: customRequirements
                    if p77.Instance.Transparency == 1 then
                        p77 = false;
                    end;

                    return p77;
                end
            });
        end;

        local v78 = isOnGround();

        if u70.PrimaryPart.Position.Y > -100 and not v78 then
            u70.PrimaryPart.Anchored = true;

            local function cleanUp() -- Line: 286
                -- upvalues: u9 (ref), u69 (ref)
                u9.taskCancel(u69.notOnGround);
                u9.taskCancel(u69.notOnGround2);
                u69.notOnGround = nil;
                u69.notOnGround2 = nil;
                u69.notOnGround3 = nil;
            end;

            u69.notOnGround = task.defer(function() -- Line: 293
                -- upvalues: PlayerFunc (ref), u70 (copy), u9 (ref), u69 (ref)
                if not PlayerFunc:InvokeServer("isGroundBelowVehicle", u70.PrimaryPart.Position) then
                    u70.PrimaryPart.Anchored = false;
                    u9.taskCancel(u69.notOnGround);
                    u9.taskCancel(u69.notOnGround2);
                    u69.notOnGround = nil;
                    u69.notOnGround2 = nil;
                    u69.notOnGround3 = nil;
                end;
            end);
            u69.notOnGround2 = task.defer(function() -- Line: 299
                -- upvalues: isOnGround (copy), u70 (copy), u9 (ref), u69 (ref)
                while not isOnGround() do
                    task.wait(0.1);
                end;

                u70.PrimaryPart.Anchored = false;
                u9.taskCancel(u69.notOnGround);
                u9.taskCancel(u69.notOnGround2);
                u69.notOnGround = nil;
                u69.notOnGround2 = nil;
                u69.notOnGround3 = nil;
            end);

            function u69.notOnGround3() -- Line: 304
                -- upvalues: u70 (copy)
                if u70.Parent then
                    u70.PrimaryPart.Anchored = false;
                end;
            end;
        end;

        if require(u70.Config).TOW then
            local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.AskTow.MaxActivationDistance;
            table.insert(u69, u5.displayProximityPromptOnObjects({
                promptTable = {},

                promptPreview = function() -- Line: 314, Name: promptPreview
                    -- upvalues: u9 (ref)
                    return u9.clone(game.ReplicatedStorage.Gameplay.Items.AskTow);
                end,

                getWorkspaceObject = function(p79) -- Line: 315, Name: getWorkspaceObject
                    return p79.PrimaryPart.VisualCenter;
                end,

                getTargets = function() -- Line: 316, Name: getTargets
                    -- upvalues: u2 (ref), MaxActivationDistance (copy), u9 (ref), LocalPlayer (ref)
                    if u2.root then
                        local v80 = {};

                        for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                            if (child.PrimaryPart.Position - u2.root.Position).Magnitude <= MaxActivationDistance then
                                local v81 = u9.getVehicleInfo.belongsToPlayer(child) or u9.getVehicleInfo.lastDrove(child);

                                if v81 and (v81 ~= LocalPlayer and not (child:GetAttribute("Totaled") or (child:GetAttribute("TowAccepted_" .. LocalPlayer.Name) or (v81:GetAttribute("IsDecidingTow_" .. LocalPlayer.Name) or u9.getVehicleInfo.isTowed(child))))) then
                                    v80[child] = true;
                                end;
                            end;
                        end;

                        return v80;
                    end;
                end
            }));
        end;
    end;
end;

task.defer(function() -- Line: 333
    -- upvalues: u9 (copy), LocalPlayer (copy), belongingVehicleListener (copy)
    u9.waitForClientToLoad(LocalPlayer);
    local BelongingVehicle = u9.getVehicleInfo.getBelongingVehicle(LocalPlayer);

    if BelongingVehicle then
        task.spawn(belongingVehicleListener, BelongingVehicle);
    end;

    local InstanceAttributeChangedSignal = u9.getInstanceAttributeChangedSignal(LocalPlayer, "BelongingVehicle", function() -- Line: 337
        -- upvalues: belongingVehicleListener (ref), u9 (ref), LocalPlayer (ref)
        belongingVehicleListener(u9.getVehicleInfo.getBelongingVehicle(LocalPlayer));
    end);
    u9.buildSignalData({}, unpack(InstanceAttributeChangedSignal));
end);
local u82 = false;
local u83 = {};
local u84 = 1;

function u1.enterVehicle(u85, p86) -- Line: 345
    -- upvalues: u1 (copy), u9 (copy), LocalPlayer (copy), u7 (copy), PlayerEvent (copy), u83 (copy), u2 (copy), u6 (copy), u84 (ref), u5 (copy), u3 (copy), u82 (ref), u18 (ref), workspace_CurrentCamera (copy), PlayerFunc (copy), GameRules (copy), Ragdoll (copy), GuiService (copy)
    local u87 = u85 or u1.seat;

    if not u87 then
        return;
    end;

    if u85 and (u9.invokeTraffic.enterVehicle and not (p86 and p86.dontSendToServer)) then
        return;
    end;

    if u85 or not (p86 and (p86.playerInput and (LocalPlayer:GetAttribute("Arrested") or u7.autoShopLocation))) then
        if not (not u87 or u87:FindFirstChild("Attachment") and u87.Parent or u1.DEBUG23494Sent) then
            u1.DEBUG23494Sent = true;
            local v88 = u87.Parent and u87.Parent:FindFirstChild("Towed");
            local v89 = u87.Parent and u9.getInstanceAttribute(u87.Parent, "IsTowing");
            local DEBUGSeatInfo = u1.DEBUGSeatInfo;

            if not (DEBUGSeatInfo and (DEBUGSeatInfo.seat == u87 and DEBUGSeatInfo)) then
                DEBUGSeatInfo = nil;
            end;

            local Attribute = LocalPlayer:GetAttribute("CharacterId");
            local v90 = time();
            local Position = u87:GetPivot().Position;
            local v91 = u87.Parent and u87.Parent:GetFullName();
            local v92 = #u87:GetDescendants();
            local v93 = u1.seat and "true" or "false";

            if v89 then
                v89 = v89:GetFullName();
            end;

            local v94 = v88 and v88.Value and v88.Value:GetFullName();
            local v95 = tick() - (u1.DEBUG10303 or 0);
            local v96;

            if DEBUGSeatInfo then
                v96 = DEBUGSeatInfo.vehicle;
            else
                v96 = DEBUGSeatInfo;
            end;

            local v97;

            if DEBUGSeatInfo then
                v97 = DEBUGSeatInfo.owner;
            else
                v97 = DEBUGSeatInfo;
            end;

            local v98;

            if DEBUGSeatInfo then
                v98 = (DEBUGSeatInfo.brokenAt or tick()) - DEBUGSeatInfo.t;
            else
                v98 = DEBUGSeatInfo;
            end;

            local v99 = DEBUGSeatInfo and DEBUGSeatInfo.brokenAt and tick() - DEBUGSeatInfo.brokenAt;
            local v100;

            if DEBUGSeatInfo then
                v100 = DEBUGSeatInfo.destroyed;
            else
                v100 = DEBUGSeatInfo;
            end;

            local v101;

            if DEBUGSeatInfo then
                v101 = DEBUGSeatInfo.parent;
            else
                v101 = DEBUGSeatInfo;
            end;

            local v102;

            if DEBUGSeatInfo then
                v102 = DEBUGSeatInfo.focus;
            else
                v102 = DEBUGSeatInfo;
            end;

            local v103;

            if DEBUGSeatInfo then
                v103 = DEBUGSeatInfo.dist;
            else
                v103 = DEBUGSeatInfo;
            end;

            if DEBUGSeatInfo then
                DEBUGSeatInfo = DEBUGSeatInfo.sinceHide;
            end;

            PlayerEvent:FireServer("developmentLogs", "DEBUG23494", Attribute, "##", v90, "|||", Position, v91, v92, u85 and "true" or "false", v93, "|", v89, "|", v94, "||", v95, " || SNAP vehicle ", v96, " | owner ", v97, " | sinceEnter ", v98, " | brokeAgo ", v99, " | destroyed ", v100, " | parentAtBreak ", v101, " | focus ", v102, " | dist ", v103, " | sinceHideAtBreak ", DEBUGSeatInfo, " ||", debug.traceback());
            task.delay(2, function() -- Line: 362
                -- upvalues: PlayerEvent (ref), LocalPlayer (ref), u87 (copy), u85 (copy), u1 (ref)
                local Attribute2 = LocalPlayer:GetAttribute("CharacterId");
                local v104 = time();
                local Position2 = u87:GetPivot().Position;
                local v105 = u87.Parent and u87.Parent:GetFullName();
                PlayerEvent:FireServer("developmentLogs", "DEBUG23494-2", Attribute2, "##", v104, "|||", Position2, v105, #u87:GetDescendants(), u85 and "true" or "false", u1.seat and "true" or "false");
            end);
            task.delay(15, function() -- Line: 365
                -- upvalues: PlayerEvent (ref), LocalPlayer (ref), u87 (copy)
                PlayerEvent:FireServer("developmentLogs", "DEBUG23494-3", LocalPlayer:GetAttribute("CharacterId"), "##", u87:GetPivot().Position);
            end);
        end;

        local Name = u87.Attachment:FindFirstChildOfClass("ProximityPrompt").Name;
        u9.clearConnectionsAndThreads(u83);
        local Config = require(u87.Parent.Config);
        u1.wearSeatbelt = nil;

        if u1.activateFirstPersonCameraVehicle then
            u1.activateFirstPersonCameraVehicle(false);
            u1.activateFirstPersonCameraVehicle = nil;
        end;

        local v106;

        if u85 then
            v106 = u9.keepCharacterContext(LocalPlayer, p86 and p86.charContextFromServer or LocalPlayer.Character, "enterVehicle");

            if not (v106 and u87.Parent) then
                return;
            end;

            local v107 = u9.clone(game.ReplicatedStorage.PlayerStuff.EnterVehicleLagAnchor);
            v107:SetAttribute("UIATC", true);
            v107.Attachment0 = u9.getCharAttachment(u2.root, "RootAttachment");
            v107.Parent = u2.root;
            u6.disabled(true, "sit");
            local v108 = p86 and p86.dontSendToServer and true or u9.invokeServerTraffic("enterVehicle", LocalPlayer.Character, u87);
            v107:Destroy();

            if v108 ~= true or not (u9.keepCharacterContext(LocalPlayer, v106) and (u2.loaded and u87.Parent)) then
                if u9.typeOf(v108) == "string" then
                    u5.notify({
                        color = "red",
                        message = v108
                    });
                end;

                u6.disabled(false, "sit");

                return;
            end;

            u84 = u2.root.AssemblyMass;
            u5.sit(u87, {
                manualExit = true,
                lockRotation = true,
                animation = "Sit"
            }, true);
            u3.canUseSlotActions("Vehicle");
            u9.charCollisionGroup(LocalPlayer.Character, "NonCollide", true);
            u82 = u2.firstPerson;
            local Attribute = u87.Parent.PrimaryPart.VisualCenter:GetAttribute("BoxSize");
            local v109 = math.max(Attribute.X, Attribute.Y, Attribute.Z) / 2;
            u9.setCameraProperties("4", {
                CameraSubject = u87.Parent,
                CameraType = Enum.CameraType.Follow,
                CameraMaxZoomDistance = v109 + 20 + (Config.ZOOM_OUT_MORE or 0),
                CameraMinZoomDistance = v109
            });
            u9.resetPlrCameraZoom();

            if u2.disableToggleCameraIfToggled then
                u2.disableToggleCameraIfToggled();
            end;

            u9.collectionAddTag(u87.Parent, "IgnoreCamera");
            local u110 = u9.getVehicleInfo.belongsToPlayer(u87.Parent);

            if u110 and (u110.Team and u110.Team.Name == "Road Service") then
                local u111 = nil;

                local function updateTownedVehicle(p112) -- Line: 408
                    -- upvalues: u111 (ref), u9 (ref)
                    if u111 then
                        u9.collectionRemoveTag(u111, "IgnoreCamera");
                    end;

                    u111 = p112;

                    if p112 then
                        u9.collectionAddTag(p112, "IgnoreCamera");
                    end;
                end;

                local InstanceAttribute = u9.getInstanceAttribute(u87.Parent, "IsTowing");

                if InstanceAttribute then
                    if u111 then
                        u9.collectionRemoveTag(u111, "IgnoreCamera");
                    end;

                    u111 = InstanceAttribute;

                    if InstanceAttribute then
                        u9.collectionAddTag(InstanceAttribute, "IgnoreCamera");
                    end;
                end;

                local InstanceAttributeChangedSignal = u9.getInstanceAttributeChangedSignal(u87.Parent, "IsTowing", updateTownedVehicle);
                u9.buildSignalData(u83, unpack(InstanceAttributeChangedSignal));
            end;

            if u110 and (u110.Team and (u110.Team.Name == "Transit" and u110 ~= LocalPlayer)) then
                local function waypoint(p113) -- Line: 420
                    -- upvalues: u5 (ref)
                    u5.createWaypoint({
                        name = "Destination",
                        create = p113 and true,
                        location = p113,
                        image = game.Teams.Transit.Icon.Texture,
                        color = Color3.fromRGB(116, 148, 255)
                    });
                end;

                local AttributeChangedSignal = u110:GetAttributeChangedSignal("TransitJobDestination");
                table.insert(u83, AttributeChangedSignal:Connect(function() -- Line: 423
                    -- upvalues: waypoint (copy), u110 (copy)
                    waypoint(u110:GetAttribute("TransitJobDestination"));
                end));
                local Attribute2 = u110:GetAttribute("TransitJobDestination");

                if Attribute2 then
                    waypoint(Attribute2);
                end;
            end;

            u18 = false;

            function u1.wearSeatbelt() -- Line: 429
                -- upvalues: u9 (ref), u18 (ref), u2 (ref)
                if u9.isPrivateServerConfigurationSettingEnabled("ejectOnCrash") then
                    u18 = not u18;

                    if u2.loaded and u2.setDashboardIcon then
                        u2.setDashboardIcon("NoSeatbelt", not u18);
                    end;

                    game.SoundService.Vehicle.Seatbelt:Play();

                    return u18;
                end;
            end;

            workspace_CurrentCamera.CameraOffset.Value = Vector3.new(0, u87.Parent.PrimaryPart.VisualCenter.Position.Y + Attribute.Y / 2 - 0.5 + (Config.CUSTOM_CAMERA_OFFSET or 0), 0);
            local u114 = nil;

            function u1.activateFirstPersonCameraVehicle(p115) -- Line: 467
                -- upvalues: u114 (ref), u9 (ref), u87 (copy)
                if p115 == nil then
                    p115 = not u114;
                end;

                if u114 then
                    u9.setCameraProperties("5");
                    u9.taskCancel(u114);
                    u114 = nil;
                end;

                if p115 then
                    u114 = task.spawn(function() -- Line: 475
                        -- upvalues: u87 (ref), u9 (ref)
                        local FirstPersonCamera = u87.Parent.PrimaryPart:WaitForChild("FirstPersonCamera");
                        u9.setCameraProperties("5", {
                            CameraType = Enum.CameraType.Scriptable
                        });

                        while true do
                            workspace.Camera.CFrame = FirstPersonCamera.WorldCFrame;
                            task.wait();
                        end;
                    end);
                end;

                return p115;
            end;

            if u2.firstPerson then
                u1.activateFirstPersonCameraVehicle(true);
            end;
        else
            v106 = u9.keepCharacterContext(LocalPlayer, p86 and p86.charContextFromServer or LocalPlayer.Character);
            u1.seat = nil;

            if not (p86 and p86.dontSendToServer) then
                task.spawn(function() -- Line: 511
                    -- upvalues: PlayerFunc (ref), LocalPlayer (ref), u87 (copy)
                    PlayerFunc:InvokeServer("enterVehicle", LocalPlayer.Character, nil, u87);
                end);
            end;

            if v106 then
                u9.charCollisionGroup(LocalPlayer.Character, nil, true);

                if u2.loaded then
                    if not u87.Parent:GetAttribute("AllowLeavingVehicleNoFalling") and LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph > 40 then
                        Ragdoll.activate(LocalPlayer.Character, true, 2);
                        LocalPlayer.Character.PrimaryPart:ApplyImpulse(u87.Parent.PrimaryPart.AssemblyLinearVelocity * 0.039 * u84);
                        PlayerEvent:FireServer("takeDamage", math.min(22, 2 + LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph * 0.2), nil, 25);
                    end;

                    if not (p86 and p86.dontSendToServer) then
                        u5.sit(nil, {
                            pivotToOnExit = p86 and p86.pivotToOnExit or u9.moveBodyOutOfVehicle(u87)
                        }, true);
                    end;
                end;
            end;

            if u82 then
                LocalPlayer.CameraMinZoomDistance = 0.5;
                LocalPlayer.CameraMaxZoomDistance = 0.5;
            end;

            u9.setCameraProperties("4");
            u9.setCameraProperties("5");
            workspace_CurrentCamera.CameraOffset.Value = Vector3.new();

            if not u82 then
                u9.resetPlrCameraZoom();
            end;

            u9.collectionRemoveTag(u87.Parent, "IgnoreCamera");
            local InstanceAttribute = u9.getInstanceAttribute(u87.Parent, "IsTowing");

            if InstanceAttribute then
                u9.collectionRemoveTag(InstanceAttribute, "IgnoreCamera");
            end;

            u5.createWaypoint({
                name = "Destination"
            });

            if v106 and u2.loaded then
                u3.canUseSlotActions(true);
            end;
        end;

        if not u87:FindFirstChild("NoDoor") then
            u9.charVisibility(LocalPlayer, not u85);

            if not (u85 and (u87.Parent._Chassis.Startup.SoundId ~= "" and Name ~= "EnterPassenger")) then
                u9.playSoundReplicate(u87.Parent._Chassis[u85 and "DoorOpen" or "DoorClose"]);
            end;
        end;

        u1.seat = u85 and u87 and u87 or nil;

        if u85 then
            u1.DEBUGSeatInfo = {
                seat = u87,
                vehicle = u87.Parent:GetFullName(),
                owner = u9.getVehicleInfo.belongsToPlayer(u87.Parent) == LocalPlayer,
                t = tick()
            };
            table.insert(u83, u87.AncestryChanged:Connect(function() -- Line: 556
                -- upvalues: u1 (ref), u87 (copy), LocalPlayer (ref), u2 (ref)
                local DEBUGSeatInfo = u1.DEBUGSeatInfo;

                if not (DEBUGSeatInfo and (DEBUGSeatInfo.seat == u87 and not (DEBUGSeatInfo.brokenAt or (u1.seat ~= u87 or u87:IsDescendantOf(workspace))))) then
                    return;
                end;

                local ReplicationFocus = LocalPlayer.ReplicationFocus;
                local root = u2.root;
                DEBUGSeatInfo.brokenAt = tick();
                DEBUGSeatInfo.destroyed = not pcall(function() -- Line: 562
                    -- upvalues: u87 (ref)
                    u87.Parent = u87.Parent;
                end);
                local v116 = u87.Parent and u87.Parent:GetFullName();
                DEBUGSeatInfo.parent = v116;

                if ReplicationFocus then
                    ReplicationFocus = ReplicationFocus:GetFullName();
                end;

                DEBUGSeatInfo.focus = ReplicationFocus;
                local v117 = root and root.Parent and (root.Position - u87:GetPivot().Position).Magnitude;
                DEBUGSeatInfo.dist = v117;
                DEBUGSeatInfo.sinceHide = tick() - (u1.DEBUG10303 or 0);
            end));
        end;

        if u9.getVehicleInfo.belongsToPlayer(u87.Parent) == LocalPlayer and u5.createWaypoint then
            u5.createWaypoint({
                name = "Your Vehicle",
                image = "rbxassetid://10856840226",
                hideOnScreen = true,
                create = not u85,
                location = u87.Parent._Chassis,
                color = Color3.fromRGB(106, 197, 78)
            });
        end;

        if Name == "EnterDriver" then
            u87.Parent.Config.On.Value = u85;
            local startVehicle = u1.startVehicle;
            local Parent = u87.Parent;
            local v118 = {};
            v118.dontStartSounds = p86 and p86.dontStartSounds;
            startVehicle(Parent, u85, v118);

            if not u85 then
                if Config.CATEGORY == "Boat" then
                    if u87.Parent.PrimaryPart:FindFirstChild("Steering") then
                        u9.activateArmIK(LocalPlayer, false);
                    end;
                elseif Config.CATEGORY == "Motorcycle" then
                    u9.activateArmIK(LocalPlayer, false);
                end;
            end;
        elseif Name == "EnterPassenger" and (v106 and (u2.loaded and u2.passengerRadio)) then
            u2.passengerRadio(u87.Parent, u85);
        end;

        GuiService.TouchControlsEnabled = not u85;

        if v106 and u2.loaded then
            u2.displayMobileGuiType(u85 and (Name == "EnterDriver" and "Vehicle" or "VehiclePassenger") or "Character");
        end;

        return true;
    end;
end;

local u119 = false;

function u1.freezeVehicle(p120, p121, p122) -- Line: 600
    -- upvalues: u13 (ref), u119 (ref), u12 (ref)
    local v123 = {};

    if p120:GetAttribute("FreezeTable") then
        for _, v in pairs(string.split(p120:GetAttribute("FreezeTable"), ";")) do
            table.insert(v123, v);
        end;
    end;

    local table_find_ret = table.find(v123, p121);

    if p122 then
        if not table_find_ret then
            table.insert(v123, p121);
        end;
    elseif table_find_ret then
        table.remove(v123, table_find_ret);
    end;

    local v124 = #v123 > 0 and table.concat(v123, ";") or nil;
    p120:SetAttribute("FreezeTable", v124);

    if u13 == p120 then
        u119 = v124 and true or false;

        if u12 then
            u12(u119);
        end;
    end;
end;

function u1.startVehicle(u125, p126, p127) -- Line: 620
    -- upvalues: u9 (copy), u10 (copy), u11 (copy), u8 (ref), u1 (copy), u12 (ref), u13 (ref), u2 (copy), GameRules (copy), PlayerEvent (copy), u5 (copy), Vehicle (copy), LocalPlayer (copy), Easing (copy), u119 (ref), UserInputService (copy), driveOutOfInsideLocation (copy), vehicleIntentionalCrashWantedPoints (copy), u18 (ref), Heartbeat (copy), u17 (copy), u16 (copy), u15 (copy)
    u9.clearConnectionsAndThreads(u10);

    for _, v in pairs(u11) do
        v();
    end;

    table.clear(u11);
    u8 = (u8 + 1) % 100;
    u9.propertyListener(u125.Config.Fuel, p126);
    u1.absSpeed = 0;
    u12 = nil;
    u1.addVehicleTrailer = nil;
    u1.switchNeon = nil;
    u1.gotPITManeuvered = nil;
    u1.setVehicleLights = nil;
    local _Chassis = u125._Chassis;
    local Config = require(u125.Config);
    u13 = p126 and u125 and u125 or nil;

    if not p126 then
        if u2.loaded then
            u2.activateVehicleGui(u125, false);
        end;

        for _, child in pairs(_Chassis:GetChildren()) do
            if child:IsA("Sound") and (child.IsPlaying and (child.Name ~= "Engine" and (child.Name ~= "DoorClose" and (child.Name ~= "Fire" and (child.Name ~= "Crash" and (child.Name ~= "Alarm" and child.Name ~= "TirePunctured")))))) then
                child:Stop();
            end;
        end;

        u9.contextAction("UnbindAction", "VehicleArrows");
        u9.contextAction("UnbindAction", "VehicleKeybinds");
        task.delay(0.5, function() -- Line: 643
            -- upvalues: u125 (copy), _Chassis (copy)
            if u125.Parent and not u125.Config.On.Value then
                _Chassis.Engine:Stop();
            end;
        end);
        u9.disableVehiclePhysics(u125);
        u2.activateVehicleTakedownOrAdivsor = nil;

        if Config.CATEGORY == "Motorcycle" and u2.loaded then
            u9.animationBuffer(u2.animator, "unload", Config.CHAR_ANIMATIONS .. "Idle");
            u9.animationBuffer(u2.animator, "unload", Config.CHAR_ANIMATIONS .. "TiltLeft");
            u9.animationBuffer(u2.animator, "unload", Config.CHAR_ANIMATIONS .. "TiltRight");
        end;

        return;
    end;

    local Config2 = u125.Config;
    local BodyGyro = _Chassis.BodyGyro;
    local LinearVelocity = _Chassis.Center.LinearVelocity;
    LinearVelocity.Enabled = true;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
    local VectorForce = _Chassis.Center.VectorForce;
    VectorForce.Enabled = true;
    VectorForce.Force = Vector3.new(0, 0, 0);
    local Headlights = Config2:FindFirstChild("Headlights");
    local Exhaust = _Chassis:FindFirstChild("Exhaust");
    local u128 = GameRules.season == "Winter" and _Chassis.SnowGroundSurface or _Chassis.GroundSurface;
    _Chassis:FindFirstChild("FirstPersonCamera");
    local u129 = Config2.Trailer.Value and Config2.Trailer.Value.Parent and Config2.Trailer.Value;
    local u130 = u8;
    local Vector3_new_ret = Vector3.new();
    local Vector3_new_ret2 = Vector3.new();
    local Vector3_new_ret3 = Vector3.new();
    u1.gear = 1;
    u1.gearChange = { 0 };
    u1.maxFuel = Config.MAX_FUEL;
    u1.maxDurability = Config.MAX_DURABILITY;
    local u131 = Config.STRENGTH or 1;
    local u132 = Config.DAMPER or 1;
    u1.maxSpeed = math.floor(0.5 + Config.MAX_SPEED / GameRules.velocityToMph);
    local maxSpeed = u1.maxSpeed;
    local u133 = 0;
    local u134 = 0;
    local u135 = 0;
    local u136 = 0;
    local u137 = 0;
    local u138 = 0;
    local u139 = 0;
    local u140 = 1;
    local u141 = 0;
    local u142 = 0;
    local u143 = 0;
    local u144 = 2.33;
    local u145 = 0;
    local u146 = 0;

    for i = 1, Config.GEAR_AMOUNT do
        table.insert(u1.gearChange, i / Config.GEAR_AMOUNT * u1.maxSpeed);
        local _ = i;
    end;

    PlayerEvent:FireServer("vehicle", "gearSpeed", u1.gearChange[u1.gear + 1]);
    local u147 = -math.floor(19 + u1.maxSpeed / 5);
    local u148 = {};
    local v149 = {};
    local u150 = {};
    local u151 = nil;
    local u152 = false;
    local u153 = false;
    local u154 = false;
    local u155 = false;
    local u156 = false;
    local u157 = false;
    local u158 = false;
    local u159 = false;
    local u160 = false;
    local u161 = false;
    local u162 = false;
    local u163 = false;
    local u164 = nil;
    local PitPoint = _Chassis:FindFirstChild("PitPoint");
    local Attribute = u125.Thrusters:GetAttribute("RearAxle");
    local Attribute2 = u125.Thrusters:GetAttribute("FrontAxle");
    local u165 = {};
    local u166 = Config.MASS_MULTIPLIER or 1;
    local u167 = 0;
    local u168 = u125.Model:FindFirstChild("Left") and true;
    local u169;

    if GameRules.season == "Winter" then
        u169 = {
            [Enum.Material.Rubber] = "Grass",
            [Enum.Material.Grass] = "Snow",
            [Enum.Material.LeafyGrass] = "Snow",
            [Enum.Material.Ground] = "GroundSmoke",
            [Enum.Material.Salt] = "Snow",
            [Enum.Material.Mud] = "GroundSmoke",
            [Enum.Material.Asphalt] = "Snow",
            [Enum.Material.Sandstone] = "Snow",
            [Enum.Material.Glacier] = "GroundSmoke",
            [Enum.Material.Sand] = "Snow",
            [Enum.Material.Limestone] = "Snow"
        };
    else
        u169 = {
            [Enum.Material.Rubber] = "Grass",
            [Enum.Material.Grass] = "Grass",
            [Enum.Material.LeafyGrass] = "Grass",
            [Enum.Material.Ground] = "GroundSmoke",
            [Enum.Material.Salt] = "GroundSmoke",
            [Enum.Material.Mud] = "GroundSmoke",
            [Enum.Material.Asphalt] = "GroundSmoke",
            [Enum.Material.Sandstone] = "GroundSmoke",
            [Enum.Material.Glacier] = "GroundSmoke",
            [Enum.Material.Sand] = "SandSmoke",
            [Enum.Material.Limestone] = "SandSmoke"
        };
    end;

    local u170 = u9.raycastParamsNew();
    u170.FilterDescendantsInstances = {
        u125,
        workspace.Characters,
        workspace.Gameplay.Vehicles,
        workspace.Terrain.Ground
    };
    u170.CollisionGroup = "Vehicles";
    local u171 = u5.readPlayerData("Settings", "SpeedUnit") and GameRules.mphToKmh or 1;
    local u172 = Config.CATEGORY == "Motorcycle" and 1 or (Config.CATEGORY == "Off-Road" and 0.4 or (Config.CATEGORY == "Truck" and 0.2 or 0.5));
    local u173 = u9.raycastParamsNew();
    u173.FilterDescendantsInstances = { u125, workspace.Characters, workspace.Terrain.Ground };

    if Attribute2 then
        if Attribute then
            Attribute2 = (Attribute2 - Attribute).Magnitude;
        else
            Attribute2 = Attribute;
        end;
    end;

    local function autoTurnSpeedBasedOnWheelBase() -- Line: 743
        -- upvalues: Attribute2 (copy)
        return Attribute2 <= 12 and 1 or 0.9 - (Attribute2 - 12) * 0.02;
    end;

    local u174 = Attribute2 and Attribute2 * 1.43 * (Config.TURN_SPEED or (Attribute2 <= 12 and 1 or 0.9 - (Attribute2 - 12) * 0.02)) or (Config.TURN_SPEED or 1) * 15;
    local u175 = 0;
    local u176 = nil;

    local function applySteerFunc() -- Line: 755
        -- upvalues: u176 (ref), u9 (ref), u130 (copy), u8 (ref), u175 (ref)
        if u176 then
            u9.taskCancel(u176);
            u176 = nil;
        end;

        local u177 = 0;
        u176 = task.spawn(function() -- Line: 762
            -- upvalues: u130 (ref), u8 (ref), u177 (ref), u175 (ref)
            while u130 == u8 and u177 < 0.12 do
                u175 = u177 / 0.12 * 0.7 + 0.1;
                u177 = u177 + task.wait();
            end;

            u175 = 1;
        end);
    end;

    if u2.loaded then
        u2.activateVehicleGui(u125, true);
    end;

    if not (p127 and p127.dontStartSounds) then
        u9.playSoundReplicate(_Chassis.Tire);
        u9.playSoundReplicate(_Chassis.Startup);
        u9.playSoundReplicate(_Chassis.Engine);
    end;

    local u178 = nil;

    local function updateAcceleration() -- Line: 782
        -- upvalues: Config2 (copy), Config (copy), u162 (ref), maxSpeed (ref), GameRules (ref), u147 (ref), u1 (ref), u178 (ref)
        local v179 = Config2.Durability.Value / Config.MAX_DURABILITY;
        local v180 = u162 and 0.5;

        if v180 and Config.OFFROAD_KEEP_ORIGINAL_SPEED_PERCENT then
            v180 = v180 + (1 - v180) * (Config.OFFROAD_KEEP_ORIGINAL_SPEED_PERCENT / 100);
        end;

        maxSpeed = math.floor(0.5 + Config.MAX_SPEED / GameRules.velocityToMph) * (v180 or 1);
        u147 = -math.floor(19 + u1.maxSpeed / 5);
        u178 = Config.ACCELERATION * 1.5 * (v179 <= 0.1 and 0.7 or (v179 <= 0.25 and 0.85 or 1));
    end;

    updateAcceleration();

    local function setBodyGyroProperties(p181, p182) -- Line: 798
        -- upvalues: BodyGyro (copy), u150 (copy), Config (copy), u146 (ref), u137 (ref), _Chassis (copy), setBodyGyroProperties (copy), Vehicle (ref)
        if not p181 then
            setBodyGyroProperties(Vehicle[Config.ROLL_BALANCE and "RollBalance_" .. Config.CATEGORY or "BodyGyro"]);

            return;
        end;

        BodyGyro.MaxTorque = p181.MaxTorque;
        BodyGyro.D = p181.D;
        BodyGyro.P = p181.P;
        u150.bodyGyro = p182 or function(p183) -- Line: 804
            -- upvalues: Config (ref), u146 (ref), u137 (ref), BodyGyro (ref), _Chassis (ref)
            if Config.ROLL_BALANCE then
                local v184 = -u146 * math.min(u137 / 37.5, 1);
                BodyGyro.CFrame = CFrame.Angles(0, math.atan2(-_Chassis.CFrame.LookVector.X, -_Chassis.CFrame.LookVector.Z), 0) * CFrame.Angles(0, 0, v184 * Config.ROLL_BALANCE * 0.175);
            end;
        end;
    end;

    if _Chassis:FindFirstChild("HookPart") then
        u5.towing("hookPrompt", {});
    end;

    if _Chassis:FindFirstChild("Trunk") and _Chassis.Trunk:FindFirstChild("ReplacementTire") then
        u5.replacementTireFunc();
    end;

    local u185 = Config.CATEGORY == "Boat";
    local u186 = Config.CATEGORY == "Motorcycle";
    u170.IgnoreWater = not u185;
    local u187;

    if u186 then
        if u2.loaded then
            u9.animationBuffer(u2.animator, "load", game.ReplicatedStorage.PlayerStuff.Animations[Config.CHAR_ANIMATIONS .. "Idle"]);
            u9.animationBuffer(u2.animator, "load", game.ReplicatedStorage.PlayerStuff.Animations[Config.CHAR_ANIMATIONS .. "TiltLeft"]);
            u9.animationBuffer(u2.animator, "load", game.ReplicatedStorage.PlayerStuff.Animations[Config.CHAR_ANIMATIONS .. "TiltRight"]);
            u9.animationBuffer(u2.animator, "play", Config.CHAR_ANIMATIONS .. "Idle");
            u9.animationBuffer(u2.animator, "play", Config.CHAR_ANIMATIONS .. "TiltLeft");
            u9.animationBuffer(u2.animator, "play", Config.CHAR_ANIMATIONS .. "TiltRight");
            local u188 = u9.animationBuffer(u2.animator, "get", Config.CHAR_ANIMATIONS .. "TiltLeft");
            local u189 = u9.animationBuffer(u2.animator, "get", Config.CHAR_ANIMATIONS .. "TiltRight");
            table.insert(u150, function() -- Line: 835
                -- upvalues: _Chassis (copy), u188 (copy), u189 (copy)
                local v190 = _Chassis.CFrame.RightVector:Dot(Vector3.new(0, 1, 0));
                u188:AdjustWeight(math.max(v190, 0.001) * 8);
                u189:AdjustWeight(math.min(v190, -0.001) * -8);
            end);
        end;

        u187 = function() -- Line: 842
            -- upvalues: u142 (ref), _Chassis (copy)
            return Vector3.new(-0, -1, -0) * (u142 + 7 + _Chassis.Size.Y / 2);
        end;

        task.delay(2, function() -- Line: 843
            -- upvalues: u187 (ref), u142 (ref), _Chassis (copy)
            u187 = function(p191) -- Line: 843
                -- upvalues: u142 (ref), _Chassis (ref)
                return -p191.UpVector * (u142 + 7 + _Chassis.Size.Y / 2);
            end;
        end);
    else
        u187 = function(p192) -- Line: 844
            -- upvalues: u142 (ref), _Chassis (copy)
            return -p192.UpVector * (u142 + 7 + _Chassis.Size.Y / 2);
        end;
    end;

    if u185 then
        u144 = 0.8;
        u142 = 5;
        u139 = 6;
        local u193 = false;
        u9.raycastParamsNew().FilterDescendantsInstances = { u125 };

        function u150.boatSteering(p194) -- Line: 852
            -- upvalues: u146 (ref), u137 (ref), u9 (ref), _Chassis (copy), Config (copy), u138 (ref), u151 (ref), LinearVelocity (copy), u193 (ref), PlayerEvent (ref)
            local v195 = -u146 * (u137 - u9.inverseLerp(80, 241, u137) * 96) / 37.5;
            local math_clamp_ret = math.clamp(v195, -1, 1);
            _Chassis.AssemblyAngularVelocity = _Chassis.AssemblyAngularVelocity:Lerp(Vector3.new(0, math_clamp_ret * (Config.TURN_SPEED or 1) * (u138 < 0 and -1 or 1), 0), 1 - 0.046 ^ p194);

            if u151 and u151 ~= Enum.Material.Water then
                LinearVelocity.VectorVelocity = Vector3.new();
            end;

            if (u151 and (u151 == Enum.Material.Water and u138 > 40) and true or false) ~= u193 then
                u193 = not u193;
                PlayerEvent:FireServer("vehicle", "streamEmitter", u193);
            end;
        end;
    else
        task.defer(function() -- Line: 868
            -- upvalues: u130 (copy), u8 (ref), u169 (ref), u151 (ref), u1 (ref), u128 (copy), u9 (ref), PlayerEvent (ref)
            local v196 = nil;

            while u130 == u8 do
                local v197 = u169[u151];

                if v197 and u1.absSpeed > 17 then
                    if v197 ~= v196 then
                        if not u128.IsPlaying then
                            u9.playSoundReplicate(u128);
                        end;

                        PlayerEvent:FireServer("vehicle", "emitters", v197);
                        v196 = v197;
                    end;
                elseif v196 then
                    u9.stopSoundReplicate(u128);
                    PlayerEvent:FireServer("vehicle", "emitters");
                    v196 = nil;
                end;

                task.wait(0.5);
            end;
        end);
    end;

    local u198 = nil;

    local function PITcleanUp() -- Line: 890
        -- upvalues: u198 (ref), u10 (ref), u9 (ref), u164 (ref)
        if u198 then
            if u10.PITManeuvered then
                u9.taskCancel(u10.PITManeuvered);
                u10.PITManeuvered = nil;
            end;

            if u10.PITManeuvered2 then
                u9.taskCancel(u10.PITManeuvered2);
                u10.PITManeuvered2 = nil;
            end;

            u198 = nil;
            u164();
        end;
    end;

    local function executePITManeuver(p199) -- Line: 904
        -- upvalues: u198 (ref), Attribute (copy), PitPoint (copy), u10 (ref), u9 (ref), u164 (ref), _Chassis (copy), u186 (copy), u185 (copy), PITcleanUp (copy), u1 (ref), Vector3_new_ret3 (ref), GameRules (ref)
        if not (u198 and u198.pittingStage) and (Attribute or PitPoint) then
            if u198 then
                if u10.PITManeuvered then
                    u9.taskCancel(u10.PITManeuvered);
                    u10.PITManeuvered = nil;
                end;

                if u10.PITManeuvered2 then
                    u9.taskCancel(u10.PITManeuvered2);
                    u10.PITManeuvered2 = nil;
                end;

                u198 = nil;
                u164();
            end;

            u198 = p199;
            u198.currentSlideStrength = u198.slideStrength;
            u198.disableSteering = true;
            u198.pittingStage = true;
            u164();

            for i = 1, 15 do
                _Chassis:ApplyImpulseAtPosition(_Chassis.CFrame.RightVector * (u186 and 1200 or (u185 and 12000 or 4000)) * (u198.isLeftSide and 1 or -1) * u198.impluseStrength, PitPoint and PitPoint.WorldPosition or _Chassis.CFrame * Attribute);
                task.wait(0.03);
                local _ = i;
            end;

            u198.disableSteering = nil;
            task.wait(0.2);
            u198.currentSlideStrength = u198.slideStrengthAfter;
            u164();
            task.wait(0.6);

            if p199.timer then
                u10.PITManeuvered2 = task.delay(p199.timer, PITcleanUp);
            end;

            u10.PITManeuvered = task.defer(function() -- Line: 923
                -- upvalues: u1 (ref), Vector3_new_ret3 (ref), u198 (ref), GameRules (ref), u10 (ref), u9 (ref), u164 (ref)
                local v200 = 999999;
                local v201 = 999999;

                while not (v200 < u1.absSpeed and v201 < Vector3_new_ret3.Magnitude or u198.endBelowMph and u1.absSpeed * GameRules.velocityToMph < u198.endBelowMph) do
                    v200 = u1.absSpeed;
                    v201 = Vector3_new_ret3.Magnitude;
                    task.wait();
                end;

                if u198 then
                    if u10.PITManeuvered then
                        u9.taskCancel(u10.PITManeuvered);
                        u10.PITManeuvered = nil;
                    end;

                    if u10.PITManeuvered2 then
                        u9.taskCancel(u10.PITManeuvered2);
                        u10.PITManeuvered2 = nil;
                    end;

                    u198 = nil;
                    u164();
                end;
            end);
            u198.pittingStage = nil;
        end;
    end;

    local u202 = {
        vehicleLowSpeed = {
            slideStrength = 0,
            slideStrengthAfter = 0.6,
            impluseStrength = 0.8,
            desiredVelChange = 0.2,
            timer = 1,
            brakeStrength = 2,
            endBelowMph = 5
        },
        vehicle = {
            slideStrength = 0,
            slideStrengthAfter = 0.6,
            impluseStrength = 0.8,
            desiredVelChange = 0.2
        },
        boat = {
            slideStrength = 0,
            slideStrengthAfter = 0.6,
            impluseStrength = 0.7,
            desiredVelChange = 0.2,
            timer = 0.8,
            brakeStrength = 2,
            endBelowMph = 25
        }
    };

    function u1.gotPITManeuvered(p203) -- Line: 945
        -- upvalues: u9 (ref), u202 (copy), Config (copy), u1 (ref), GameRules (ref), executePITManeuver (copy)
        local v204 = u9.deepCopyTable(u202[Config.CATEGORY == "Boat" and "boat" or (u1.absSpeed * GameRules.velocityToMph < 70 and "vehicleLowSpeed" or "vehicle")]);
        v204.isLeftSide = p203 and true or false;
        executePITManeuver(v204);
    end;

    if u9.getVehicleInfo.getVehicleTeam(u125) == "Police" and u9.canVehiclePITManeuver(u125) then
        local Attribute3 = _Chassis.VisualCenter:GetAttribute("BoxSize");
        local u205 = nil;
        table.insert(u10, Config2.Steer.Changed:Connect(function(u206) -- Line: 954
            -- upvalues: u205 (ref), u9 (ref), u130 (copy), u8 (ref), u125 (copy), _Chassis (copy), LocalPlayer (ref), Attribute3 (copy), GameRules (ref), PlayerEvent (ref), u5 (ref)
            if u205 then
                u9.taskCancel(u205);
            end;

            if u206 ~= 0 then
                u205 = task.defer(function() -- Line: 957
                    -- upvalues: u130 (ref), u8 (ref), u9 (ref), u125 (ref), _Chassis (ref), LocalPlayer (ref), Attribute3 (ref), u206 (copy), GameRules (ref), PlayerEvent (ref), u5 (ref)
                    while u130 == u8 do
                        local v207 = {};

                        for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                            if u9.getVehicleInfo.getVehicleTeam(child) == "Civilian" and child ~= u125 then
                                table.insert(v207, child);
                            end;
                        end;

                        local v208, _, v209 = u9.findClosestFromTable(_Chassis.Position, v207);

                        if v208 and v209 < 30 then
                            local v210 = u9.getVehicleInfo.controlledBy(v208);

                            if v210 and (v210:GetAttribute("WantedLevel") or u9.isPrivateServerConfigurationSettingEnabled("elevatedPolicePermissions")) and not u9.rest("PIT_" .. v210.Name, nil, LocalPlayer) then
                                local v211 = Vector3.new(_Chassis.VisualCenter.WorldCFrame.X, _Chassis.Position.Y, _Chassis.VisualCenter.WorldCFrame.Z) + _Chassis.CFrame.LookVector * Attribute3.Z * 0.125 + _Chassis.CFrame.RightVector * Attribute3.X / 2 * (u206 == 1 and 1 or -1);
                                local v212 = v211 + _Chassis.CFrame.LookVector * Attribute3.Z * 0.375;
                                local Attribute4 = v208.PrimaryPart.VisualCenter:GetAttribute("BoxSize");
                                local v213 = Vector3.new(v208.PrimaryPart.VisualCenter.WorldCFrame.X, v208.PrimaryPart.Position.Y, v208.PrimaryPart.VisualCenter.WorldCFrame.Z) - v208.PrimaryPart.CFrame.LookVector * Attribute4.Z * 0.125 + v208.PrimaryPart.CFrame.RightVector * Attribute4.X / 2 * (u206 == 1 and -1 or 1);

                                if u9.nearestPointsOn2LineSegments(v211, v212, v213, v213 - v208.PrimaryPart.CFrame.LookVector * Attribute4.Z * 0.375) < 2 then
                                    if v208.PrimaryPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph >= GameRules.minimumMphToNotifyAboutPit then
                                        u9.rest("PIT_" .. v210.Name, 4, LocalPlayer);
                                        PlayerEvent:FireServer("vehicle", "PITmaneuver", v210, u206 == 1);
                                    elseif not u9.rest("PITminSpeed", 120, LocalPlayer) then
                                        u5.notify({
                                            color = "red",
                                            message = "The target vehicle must be going at least " .. (u5.readPlayerData("Settings", "SpeedUnit") and math.round(GameRules.mphToKmh * GameRules.minimumMphToNotifyAboutPit) .. " kmh" or GameRules.minimumMphToNotifyAboutPit .. " mph") .. " to PIT"
                                        });
                                    end;
                                end;
                            end;
                        end;

                        task.wait(0.2);
                    end;
                end);
            end;
        end));
    end;

    local u214 = 0;
    local u215 = 0;

    u164 = function() -- Line: 994, Name: setTraction
        -- upvalues: u148 (copy), u214 (ref), u198 (ref), u133 (ref), u134 (ref), u215 (ref), LinearVelocity (copy), Easing (ref), u166 (copy), u167 (ref), u151 (ref), u9 (ref), u125 (copy), u156 (ref)
        local v216 = 0;

        for _, v in pairs(u148) do
            if v[3] then
                v216 = v216 + 1;
            end;
        end;

        u214 = u198 and u198.currentSlideStrength or v216 / (u133 + u134);
        u215 = v216 / u133;
        LinearVelocity.MaxAxesForce = Vector3.new(0, 10000, Easing.outSine(u214, 400000, -380000, 1)) * (u166 + u167);
        u151 = nil;
        u9.setTireSpark(u125, u156);
    end;

    for _, child in pairs(u125.Thrusters:GetChildren()) do
        local v217 = u9.isPartOfTrailer(u125, child);

        if v217 then
            u134 = u134 + 1;
        else
            u133 = u133 + 1;
        end;

        if not (child:FindFirstChild("Wheel") and child:GetAttribute("ThrusterFree")) then
            if child:FindFirstChild("VectorForce") then
                local v218 = {};
                local v219;

                if child.Name == "FrontThruster" then
                    v219 = true;
                else
                    local _ = child.Name == "RearThruster";
                    v219 = nil;
                end;

                v218[1], v218[2], v218[3], v218[4], v218[5], v218[6] = v219, u9.smartUnit(_Chassis.Position - child.Position):Dot(_Chassis.CFrame.RightVector) > 0, false, child:GetAttribute("WheelSize") or 0, (child:GetAttribute("CustomHeight") or 0) + (u129 and (child:GetAttribute("TrailerHeight") or 0) or 0), v217;
                u148[child] = v218;
            end;

            if child:FindFirstChild("WheelWeld") then
                if child.Name == "RearThruster" and child:FindFirstChild("Emitter") then
                    table.insert(v149, child);
                end;

                local WheelCollision = child.WheelWeld.Part0.Parent.Tire.WheelCollision;
                WheelCollision.CanCollide = false;
                WheelCollision.Parent.Rim.CanCollide = false;
                table.insert(u11, function() -- Line: 1019
                    -- upvalues: WheelCollision (copy)
                    if WheelCollision.Parent then
                        if WheelCollision.Transparency == 0 then
                            WheelCollision.CanCollide = true;

                            return;
                        end;

                        if WheelCollision.Transparency == 1 then
                            WheelCollision.Parent.Rim.CanCollide = true;
                        end;
                    end;
                end);

                local function checkFlat() -- Line: 1025
                    -- upvalues: u148 (copy), child (copy)
                    u148[child][3] = child.Wheel.Tire.WheelCollision.Transparency ~= 0;
                end;

                local PropertyChangedSignal = child.Wheel.Tire.WheelCollision:GetPropertyChangedSignal("Transparency");
                table.insert(u10, PropertyChangedSignal:Connect(function() -- Line: 1026
                    -- upvalues: child (copy), u148 (copy), u164 (ref)
                    child.Wheel.Tire.WheelCollision.CanCollide = false;
                    child.Wheel.Tire.Rim.CanCollide = false;
                    u148[child][3] = child.Wheel.Tire.WheelCollision.Transparency ~= 0;
                    u164();
                end));
                u148[child][3] = child.Wheel.Tire.WheelCollision.Transparency ~= 0;
            end;
        end;
    end;

    u164();

    local function enableThrusters(p220) -- Line: 1039
        -- upvalues: u148 (copy)
        for i, _ in pairs(u148) do
            i.VectorForce.VectorForce.Enabled = p220;
        end;
    end;

    for i, _ in pairs(u148) do
        i.VectorForce.VectorForce.Enabled = true;
    end;

    local function engineVolume(p221) -- Line: 1044
        -- upvalues: _Chassis (copy), PlayerEvent (ref), u9 (ref), u130 (copy), u8 (ref)
        local u222 = (p221 and 2 or 1) * _Chassis.Engine:GetAttribute("BaseVolume");

        if _Chassis.Engine.Volume ~= u222 then
            PlayerEvent:FireServer("vehicle", "engineVolume", u222);
            _Chassis.Engine.Volume = u9.lerp(_Chassis.Engine.Volume, u222, 0.5);
            task.delay(0.03, function() -- Line: 1049
                -- upvalues: u130 (ref), u8 (ref), _Chassis (ref), u222 (copy)
                if u130 == u8 then
                    _Chassis.Engine.Volume = u222;
                end;
            end);
        end;
    end;

    _Chassis.Engine.PlaybackSpeed = 0;
    task.spawn(engineVolume);
    local u223 = false;
    local u225 = Config.ENGINE_TYPE ~= "Electric" and not u185 and function() -- Line: 1060, Name: revWhenStopped
        -- upvalues: u223 (ref), u1 (ref), u125 (copy), u9 (ref), engineVolume (copy), u165 (copy), u119 (ref), Exhaust (copy), u145 (ref)
        if not u223 and u1.absSpeed < 1 then
            u223 = true;
            local u224 = u125:GetAttribute("EngineSpeed") and u125:GetAttribute("EngineSpeed") > 0.9;
            task.spawn(function() -- Line: 1064
                -- upvalues: u9 (ref), u125 (ref), engineVolume (ref), u165 (ref), u119 (ref), Exhaust (ref), u224 (ref), u145 (ref), u223 (ref)
                u9.selectiveObjReplicaSystem("revWhenStopped", u125.Config.GearSpeed, true);
                engineVolume(true);

                while u165.forward and (u165.reverse or (u165.handbrake or u119)) do
                    if Exhaust then
                        local Attribute3 = u125:GetAttribute("EngineSpeed");

                        if Attribute3 and Attribute3 >= 0.9 then
                            if not u224 then
                                u224 = true;
                                u9.selectiveObjReplicaSystem("vehicleBackfire", u125);
                            end;
                        elseif u224 then
                            u224 = false;
                        end;
                    end;

                    task.wait();
                end;

                if u145 ~= 1 then
                    engineVolume(false);
                end;

                u223 = false;

                if u165.forward and (u125:GetAttribute("EngineSpeed") or 0) > 0.9 then
                    u9.selectiveObjReplicaSystem("revWhenStopped", u125.Config.GearSpeed, false, {
                        revLonger = true
                    });

                    return;
                end;

                u9.selectiveObjReplicaSystem("revWhenStopped", u125.Config.GearSpeed, false);
            end);
        end;
    end or nil;

    u12 = function(p226) -- Line: 1093, Name: stopVehicle
        -- upvalues: u155 (ref), u119 (ref), u145 (ref), engineVolume (copy), u165 (copy)
        if u155 ~= p226 and (not u119 or p226) then
            u155 = p226;

            if p226 then
                u145 = -1;
                engineVolume(false);

                return;
            end;

            if u165.reverse then
                return;
            end;

            if u165.forward then
                u145 = 1;
                engineVolume(true);

                return;
            end;

            u145 = 0;
        end;
    end;

    if u119 then
        u12(true);
    end;

    local u227 = false;
    local u228 = 0;

    local function autoIndicatorRelease(u229) -- Line: 1111
        -- upvalues: u227 (ref), u9 (ref), u130 (copy), u8 (ref), u228 (ref), GameRules (ref), u1 (ref), u146 (ref), PlayerEvent (ref)
        if u227 then
            u9.taskCancel(u227);
        end;

        if u229 then
            u227 = task.defer(function() -- Line: 1114
                -- upvalues: u130 (ref), u8 (ref), u228 (ref), GameRules (ref), u1 (ref), u146 (ref), u229 (copy), PlayerEvent (ref)
                if u130 ~= u8 then
                    return;
                end;

                local v230 = 0;
                u228 = 0;

                while true do
                    if GameRules.velocityToMph * u1.absSpeed > 3 and u146 == u229 then
                        u228 = u228 + v230;

                        if u228 > 0.3 then
                            while u130 == u8 do
                                if u146 ~= u229 then
                                    game.SoundService.Vehicle.ClickIndicator:Play();

                                    return PlayerEvent:FireServer("vehicle", "indicator", 0);
                                end;

                                task.wait(0.03);

                                if u130 ~= u8 then
                                    return;
                                end;
                            end;
                        end;
                    elseif u228 > 0 then
                        u228 = 0;
                    end;

                    v230 = task.wait(0.03);

                    if u130 ~= u8 then
                        return;
                    end;
                end;
            end);
        end;
    end;

    if not u5.readPlayerData("Settings", "AutoIndicatorCancel") then
        table.insert(u10, Config2.Indicator.Changed:Connect(function(p231) -- Line: 1137
            -- upvalues: u227 (ref), u9 (ref), u130 (copy), u8 (ref), u228 (ref), GameRules (ref), u1 (ref), u146 (ref), PlayerEvent (ref)
            local u232 = p231 == 1 and -1 or (p231 == 2 and 1 or false);

            if u227 then
                u9.taskCancel(u227);
            end;

            if u232 then
                u227 = task.defer(function() -- Line: 1114
                    -- upvalues: u130 (ref), u8 (ref), u228 (ref), GameRules (ref), u1 (ref), u146 (ref), u232 (copy), PlayerEvent (ref)
                    if u130 ~= u8 then
                        return;
                    end;

                    local v233 = 0;
                    u228 = 0;

                    while true do
                        if GameRules.velocityToMph * u1.absSpeed > 3 and u146 == u232 then
                            u228 = u228 + v233;

                            if u228 > 0.3 then
                                while u130 == u8 do
                                    if u146 ~= u232 then
                                        game.SoundService.Vehicle.ClickIndicator:Play();

                                        return PlayerEvent:FireServer("vehicle", "indicator", 0);
                                    end;

                                    task.wait(0.03);

                                    if u130 ~= u8 then
                                        return;
                                    end;
                                end;
                            end;
                        elseif u228 > 0 then
                            u228 = 0;
                        end;

                        v233 = task.wait(0.03);

                        if u130 ~= u8 then
                            return;
                        end;
                    end;
                end);
            end;
        end));
    end;

    function u1.setVehicleLights(p234) -- Line: 1142
        -- upvalues: Headlights (copy), u9 (ref), u125 (copy), u153 (ref), PlayerEvent (ref), u2 (ref)
        if Headlights.Value ~= p234 then
            Headlights.Value = p234;
            u9.brakeOrReverseLights(u125, u153, Headlights.Value);
            PlayerEvent:FireServer("vehicle", "headlights", Headlights.Value);

            if u2.loaded and u2.vehicleButtonPressed then
                u2.vehicleButtonPressed("Lights", Headlights.Value);
            end;
        end;
    end;

    if u5.platform == "Mobile" and UserInputService.GyroscopeEnabled then
        local u235 = u5.readPlayerData("Settings", "TiltDeviceToSteerVehicle");

        if u235 then
            u175 = 1;
            local u236 = 0;
            table.insert(u10, UserInputService.DeviceRotationChanged:Connect(function(p237, p238) -- Line: 1157
                -- upvalues: u146 (ref), u235 (copy), u236 (ref), PlayerEvent (ref), Config2 (copy)
                local math_deg_ret = math.deg(p238.LookVector.X);
                u146 = math.clamp(math_deg_ret * (u235 == 3 and -1 or 1), -30, 30) / 30;

                if u236 ~= math.round(u146) then
                    u236 = math.round(u146);
                    PlayerEvent:FireServer("vehicle", "steer", u236);
                    Config2.Steer.Value = u236;
                end;
            end));
        end;
    end;

    u9.contextAction("BindActionAtPriority", "VehicleArrows", function() -- Line: 1167
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value + 1, Enum.KeyCode.Left, Enum.KeyCode.Right);

    function u1.actionBegan(p239) -- Line: 1168
        -- upvalues: u5 (ref), u9 (ref), u125 (copy), driveOutOfInsideLocation (ref), u165 (copy), u155 (ref), u145 (ref), engineVolume (copy), u146 (ref), PlayerEvent (ref), Config2 (copy), u176 (ref), u130 (copy), u8 (ref), u175 (ref), u168 (copy), _Chassis (copy), Config (copy), Headlights (copy), u1 (ref), GameRules (ref), u2 (ref), u171 (copy), u12 (ref)
        if u5.canPressKey() then
            if p239 == "forward" then
                local InstanceAttribute = u9.getInstanceAttribute(u125, "InsideVehicle");

                if InstanceAttribute then
                    driveOutOfInsideLocation(u125, InstanceAttribute);
                end;

                u165.forward = true;

                if not u155 then
                    if u165.reverse then
                        u145 = -1;
                        task.spawn(engineVolume, false);
                    else
                        u145 = 1;
                        task.spawn(engineVolume, true);
                    end;
                end;

                return true;
            end;

            if p239 == "reverse" then
                local InstanceAttribute = u9.getInstanceAttribute(u125, "InsideVehicle");

                if InstanceAttribute then
                    driveOutOfInsideLocation(u125, InstanceAttribute);
                end;

                u165.reverse = true;

                if not u155 then
                    if u165.forward then
                        u145 = -1;
                        task.spawn(engineVolume, false);
                    else
                        u145 = -1;
                        task.spawn(engineVolume, false);
                    end;
                end;

                return true;
            end;

            if p239 == "left" then
                u165.left = true;
                u146 = -1;
                PlayerEvent:FireServer("vehicle", "steer", u146);
                Config2.Steer.Value = u146;

                if u176 then
                    u9.taskCancel(u176);
                    u176 = nil;
                end;

                local u240 = 0;
                u176 = task.spawn(function() -- Line: 762
                    -- upvalues: u130 (ref), u8 (ref), u240 (ref), u175 (ref)
                    while u130 == u8 and u240 < 0.12 do
                        u175 = u240 / 0.12 * 0.7 + 0.1;
                        u240 = u240 + task.wait();
                    end;

                    u175 = 1;
                end);

                return true;
            end;

            if p239 == "right" then
                u165.right = true;
                u146 = 1;
                PlayerEvent:FireServer("vehicle", "steer", u146);
                Config2.Steer.Value = u146;

                if u176 then
                    u9.taskCancel(u176);
                    u176 = nil;
                end;

                local u241 = 0;
                u176 = task.spawn(function() -- Line: 762
                    -- upvalues: u130 (ref), u8 (ref), u241 (ref), u175 (ref)
                    while u130 == u8 and u241 < 0.12 do
                        u175 = u241 / 0.12 * 0.7 + 0.1;
                        u241 = u241 + task.wait();
                    end;

                    u175 = 1;
                end);

                return true;
            end;

            if p239 == "rightIndicator" and u168 then
                game.SoundService.Vehicle.ClickIndicator:Play();
                PlayerEvent:FireServer("vehicle", "indicator", 2);

                return true;
            end;

            if p239 == "leftIndicator" and u168 then
                game.SoundService.Vehicle.ClickIndicator:Play();
                PlayerEvent:FireServer("vehicle", "indicator", 1);

                return true;
            end;

            if p239 == "hazards" and u168 then
                game.SoundService.Vehicle.Click3:Play();
                PlayerEvent:FireServer("vehicle", "indicator", 3);

                return true;
            end;

            if p239 == "horn" then
                if not u9.getInstanceAttribute(u125, "InsideVehicle") then
                    u165.horn = true;
                    u9.playSoundReplicate(_Chassis.Horn);

                    if Config.SIREN_MUTE_ON_HORN then
                        for _, child in pairs(_Chassis:GetChildren()) do
                            if child:GetAttribute("BaseVolume") then
                                child.Volume = 0;
                            end;
                        end;

                        PlayerEvent:FireServer("vehicle", "muteSiren", true);
                    end;

                    return true;
                end;

                return;
            end;

            if p239 == "lights" and Headlights then
                game.SoundService.Vehicle.Click3:Play();
                u1.setVehicleLights(not Headlights.Value);

                if u125.Config.Headlights:GetAttribute("DynamicTimeOfDay") then
                    PlayerEvent:FireServer("setVehicleDynamicLights", false);
                end;

                return true;
            end;

            if p239 == "speedLimiter" then
                local math_floor_ret = math.floor(0.5 + GameRules.velocityToMph * u1.absSpeed);

                if u125.Config.SpeedLimiter.Value == 0 and GameRules.speedLimiterMinimumSpeed > math_floor_ret then
                    u5.notify({
                        color = "red",
                        message = "Reach " .. (u5.readPlayerData("Settings", "SpeedUnit") and math.round(GameRules.mphToKmh * GameRules.speedLimiterMinimumSpeed) .. " kmh" or GameRules.speedLimiterMinimumSpeed .. " mph") .. " to enable speed limiter"
                    });
                else
                    game.SoundService.Vehicle.Click3:Play();
                    u125.Config.SpeedLimiter.Value = u125.Config.SpeedLimiter.Value == 0 and (u1.absSpeed or 0) or 0;

                    if u2.loaded and u2.vehicleButtonPressed then
                        u2.vehicleButtonPressed("SpeedLimiter", u125.Config.SpeedLimiter.Value ~= 0);
                    end;

                    if u2.loaded and u2.setDashboardIcon then
                        u2.setDashboardIcon("SpeedLimiter", u125.Config.SpeedLimiter.Value ~= 0, {
                            Limit = math.round(math_floor_ret * u171)
                        });
                    end;
                end;

                return true;
            end;

            if p239 == "handbrake" then
                u165.handbrake = true;
                u12(true);

                return true;
            end;

            if p239 == "radio" then
                if u2.loaded and u2.vehicleRadio then
                    u2.vehicleRadio();
                end;

                return true;
            end;

            if p239 == "lock" then
                game.SoundService.Vehicle.Lock:Play();
                u125.Config.Locked.Value = not u125.Config.Locked.Value;
                PlayerEvent:FireServer("vehicle", "lock", u125.Config.Locked.Value);

                if u2.loaded and u2.vehicleButtonPressed then
                    u2.vehicleButtonPressed("Lock", u125.Config.Locked.Value);
                end;

                return true;
            end;
        end;
    end;

    function u1.actionEnded(p242) -- Line: 1268
        -- upvalues: u165 (copy), u155 (ref), u145 (ref), engineVolume (copy), u146 (ref), PlayerEvent (ref), Config2 (copy), u176 (ref), u9 (ref), u130 (copy), u8 (ref), u175 (ref), _Chassis (copy), Config (copy), u12 (ref)
        if u165[p242] then
            if p242 == "forward" and not u155 then
                if u165.reverse then
                    u145 = -1;
                    engineVolume(false);
                else
                    u145 = 0;
                    engineVolume(false);
                end;
            elseif p242 == "reverse" and not u155 then
                if u165.forward then
                    u145 = 1;
                    engineVolume(true);
                else
                    u145 = 0;
                    engineVolume(false);
                end;
            elseif p242 == "left" then
                if u165.right then
                    u146 = 1;
                else
                    u146 = 0;
                end;

                PlayerEvent:FireServer("vehicle", "steer", u146);
                Config2.Steer.Value = u146;

                if u146 ~= 0 then
                    if u176 then
                        u9.taskCancel(u176);
                        u176 = nil;
                    end;

                    local u243 = 0;
                    u176 = task.spawn(function() -- Line: 762
                        -- upvalues: u130 (ref), u8 (ref), u243 (ref), u175 (ref)
                        while u130 == u8 and u243 < 0.12 do
                            u175 = u243 / 0.12 * 0.7 + 0.1;
                            u243 = u243 + task.wait();
                        end;

                        u175 = 1;
                    end);
                end;
            elseif p242 == "right" then
                if u165.left then
                    u146 = -1;
                else
                    u146 = 0;
                end;

                PlayerEvent:FireServer("vehicle", "steer", u146);
                Config2.Steer.Value = u146;

                if u146 ~= 0 then
                    if u176 then
                        u9.taskCancel(u176);
                        u176 = nil;
                    end;

                    local u244 = 0;
                    u176 = task.spawn(function() -- Line: 762
                        -- upvalues: u130 (ref), u8 (ref), u244 (ref), u175 (ref)
                        while u130 == u8 and u244 < 0.12 do
                            u175 = u244 / 0.12 * 0.7 + 0.1;
                            u244 = u244 + task.wait();
                        end;

                        u175 = 1;
                    end);
                end;
            elseif p242 == "horn" then
                if _Chassis.Horn.IsPlaying then
                    u9.stopSoundReplicate(_Chassis.Horn);
                end;

                if Config.SIREN_MUTE_ON_HORN then
                    for _, child in pairs(_Chassis:GetChildren()) do
                        if child:GetAttribute("BaseVolume") then
                            child.Volume = child:GetAttribute("BaseVolume");
                        end;
                    end;

                    PlayerEvent:FireServer("vehicle", "muteSiren", false);
                end;
            elseif p242 == "handbrake" then
                u12(false);
            end;

            u165[p242] = nil;

            return true;
        end;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
        u1.actionBegan("forward");
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
        u1.actionBegan("reverse");
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
        u1.actionBegan("left");
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
        u1.actionBegan("right");
    end;

    table.insert(u10, UserInputService.InputBegan:Connect(function(p245) -- Line: 1302
        -- upvalues: u5 (ref), u1 (ref), u9 (ref), u125 (copy)
        if u5.canPressKey(p245.KeyCode) then
            if p245.KeyCode == Enum.KeyCode.W or p245.KeyCode == Enum.KeyCode.Up then
                u1.actionBegan("forward");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.S or p245.KeyCode == Enum.KeyCode.Down then
                u1.actionBegan("reverse");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.A or p245.KeyCode == Enum.KeyCode.Left then
                u1.actionBegan("left");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.D or p245.KeyCode == Enum.KeyCode.Right then
                u1.actionBegan("right");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.Q then
                u1.actionBegan("leftIndicator");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.E then
                u1.actionBegan("rightIndicator");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.G then
                u1.actionBegan("hazards");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.H then
                u1.actionBegan("horn");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.L then
                u1.actionBegan("lights");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.J then
                u1.actionBegan("speedLimiter");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.Space then
                u1.actionBegan("handbrake");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.K then
                u1.actionBegan("radio");

                return;
            end;

            if p245.KeyCode == Enum.KeyCode.U and u9.getVehicleInfo.getVehicleTeam(u125) ~= "Transit" then
                u1.actionBegan("lock");
            end;
        end;
    end));
    table.insert(u10, UserInputService.InputEnded:Connect(function(p246) -- Line: 1335
        -- upvalues: u1 (ref)
        if p246.KeyCode == Enum.KeyCode.W or p246.KeyCode == Enum.KeyCode.Up then
            u1.actionEnded("forward");

            return;
        end;

        if p246.KeyCode == Enum.KeyCode.S or p246.KeyCode == Enum.KeyCode.Down then
            u1.actionEnded("reverse");

            return;
        end;

        if p246.KeyCode == Enum.KeyCode.A or p246.KeyCode == Enum.KeyCode.Left then
            u1.actionEnded("left");

            return;
        end;

        if p246.KeyCode == Enum.KeyCode.D or p246.KeyCode == Enum.KeyCode.Right then
            u1.actionEnded("right");

            return;
        end;

        if p246.KeyCode == Enum.KeyCode.H then
            u1.actionEnded("horn");

            return;
        end;

        if p246.KeyCode == Enum.KeyCode.Space then
            u1.actionEnded("handbrake");
        end;
    end));

    local function brakesOrReverseActive(u247) -- Line: 1351
        -- upvalues: _Chassis (copy), u138 (ref), u145 (ref), Config (copy), u153 (ref), u151 (ref), u9 (ref), u125 (copy), Headlights (copy), u130 (copy), u8 (ref)
        local u248 = nil;
        local u249 = nil;

        if u247 == "brakes" then
            u249 = _Chassis.Brakes;

            u248 = function() -- Line: 1356, Name: checkFunc
                -- upvalues: u138 (ref), u145 (ref)
                local v250;

                if u138 > 0.2 then
                    v250 = u145 == -1;
                else
                    v250 = false;
                end;

                return v250;
            end;
        elseif u247 == "reverse" then
            if Config.CATEGORY == "Truck" then
                u249 = _Chassis.TruckReverse;
            else
                u249 = false;
            end;

            u248 = function() -- Line: 1361, Name: checkFunc
                -- upvalues: u138 (ref)
                return u138 < -3;
            end;
        end;

        if not u153 and (u151 and u248()) then
            u153 = u247;
            task.spawn(function() -- Line: 1367
                -- upvalues: u249 (ref), u9 (ref), u125 (ref), u247 (copy), Headlights (ref), u248 (ref), u151 (ref), u130 (ref), u8 (ref), u153 (ref)
                if u249 then
                    u9.playSoundReplicate(u249);
                end;

                u9.brakeOrReverseLights(u125, u247, Headlights.Value);

                while u248() and u151 do
                    task.wait(0.03);

                    if u130 ~= u8 then
                        return;
                    end;
                end;

                u153 = false;

                if u249 then
                    u9.stopSoundReplicate(u249);
                end;

                u9.brakeOrReverseLights(u125, false, Headlights.Value);
            end);
        end;
    end;

    local function loadCharacter(u251) -- Line: 1379
        -- upvalues: LocalPlayer (ref), u9 (ref), u10 (ref)
        if u251 == LocalPlayer.Character then
            return;
        end;

        u9.charCollisionGroup(u251, "NonCollide");

        if u10[u251] then
            u10[u251]:Disconnect();
        end;

        u10[u251] = u251:GetAttributeChangedSignal("CollisionGroup"):Connect(function() -- Line: 1383
            -- upvalues: u9 (ref), u251 (copy)
            u9.charCollisionGroup(u251, "NonCollide");
        end);
    end;

    for _, child in pairs(workspace.Characters:GetChildren()) do
        loadCharacter(child);
    end;

    table.insert(u10, workspace.Characters.ChildAdded:Connect(loadCharacter));
    table.insert(u11, function() -- Line: 1389
        -- upvalues: u9 (ref)
        for _, child in pairs(workspace.Characters:GetChildren()) do
            u9.charCollisionGroup(child, child:GetAttribute("CollisionGroup"));
        end;
    end);

    if u9.hasCustomizationPart.Neon(u125, Config) and _Chassis.Neon:GetAttribute("IsPurchased") then
        local u252 = true;

        function u1.switchNeon() -- Line: 1395
            -- upvalues: u252 (ref), PlayerEvent (ref)
            game.SoundService.Vehicle.Click3:Play();
            u252 = not u252;
            PlayerEvent:FireServer("vehicle", "switchNeon", u252);

            return u252;
        end;
    end;

    local function notifyAboutLowDurability() -- Line: 1403
        -- upvalues: Config2 (copy), Config (copy), u125 (copy), u5 (ref)
        if Config2.Durability.Value / Config.MAX_DURABILITY < 0.25 and not u125:GetAttribute("notifiedLowDurability") then
            u125:SetAttribute("notifiedLowDurability", true);
            u5.notify({
                message = "The vehicle is damaged. Visit an auto shop to repair"
            });
        end;
    end;

    notifyAboutLowDurability();
    table.insert(u10, Config2.Durability.Changed:Connect(function(p253) -- Line: 1410
        -- upvalues: notifyAboutLowDurability (copy), updateAcceleration (copy)
        if p253 > 0 then
            notifyAboutLowDurability();
        end;

        updateAcceleration();
    end));
    local u254 = u9.raycastParamsNew();
    u254.FilterDescendantsInstances = { workspace.Characters, u125 };
    u254.IgnoreWater = true;
    local u255 = {};

    local function setUpCollision(u256) -- Line: 1420
        -- upvalues: u10 (ref), u5 (ref), u255 (copy)
        table.insert(u10, u256.PrimaryPart.Touched:Connect(function(p257) -- Line: 1421
            -- upvalues: u5 (ref), u256 (copy)
            u5.touchInteraction("vehicle", p257, u256.PrimaryPart);
        end));

        for _, child in pairs(u256.Collisions:GetChildren()) do
            table.insert(u255, child);
        end;
    end;

    setUpCollision(u125);
    local u258 = u9.overlapParamsNew();
    u258.FilterDescendantsInstances = { workspace.Characters, u125 };

    local function vehicleCrashed(p259, p260) -- Line: 1430
        -- upvalues: u9 (ref), u159 (ref), u255 (copy), u258 (copy), GameRules (ref), PlayerEvent (ref), _Chassis (copy), u125 (copy), u157 (ref), u130 (copy), u8 (ref), u138 (ref), u254 (copy), vehicleIntentionalCrashWantedPoints (ref), Config (copy), u186 (copy), u18 (ref), u2 (ref)
        if not u9.rest("Crashed", 0.2) then
            if u159 then
                return;
            end;

            local v261 = {};

            for _, v in pairs(u255) do
                if u9.isVehicleCollisionValid(v, u9.smartUnit(p260)) then
                    local v262 = v;

                    for _, v2 in pairs(workspace:GetPartsInPart(v, u258)) do
                        if v2.CanCollide and not v2:GetAttribute("VehicleCollisionIgnore") then
                            table.insert(v261, v262);
                            break;
                        end;
                    end;

                    if #v261 == 0 and u9.isTerrainInPart(v262, true) then
                        table.insert(v261, v262);
                    end;
                end;
            end;

            if #v261 > 0 then
                local v263 = p259 * GameRules.velocityToMph;

                for _, v in pairs(v261) do
                    u9.vehicleCollisionEmitters(v);
                    local _ = v.AssemblyRootPart.Parent:GetAttribute("IsDeformable");
                end;

                PlayerEvent:FireServer("vehicle", "collision", v261, (math.ceil(p259)));
                u9.playSoundReplicate(_Chassis.Crash);

                if GameRules.vehicleCrashStallsSpeedMph < v263 and u9.selectiveObjReplicaSystem("vehicleStallsEffect", u125) then
                    u157 = true;
                    u9.stopSoundReplicate(_Chassis.Engine);
                    task.delay(1, function() -- Line: 1458
                        -- upvalues: u130 (ref), u8 (ref), u157 (ref), u9 (ref), _Chassis (ref)
                        if u130 == u8 then
                            u157 = false;
                            u9.playSoundReplicate(_Chassis.Startup);
                            u9.playSoundReplicate(_Chassis.Engine);
                        end;
                    end);
                end;

                if math.abs(u138) > 40 then
                    local v264 = u9.raycastVisible(_Chassis.VisualCenter.WorldCFrame.Position, _Chassis.CFrame.LookVector * (_Chassis.VisualCenter:GetAttribute("BoxSize").Z + 7) * (u138 > 0 and 1 or -1), u254);

                    if v264 and v264.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) then
                        vehicleIntentionalCrashWantedPoints(u125, u9.getAncestorsChild(workspace.Gameplay.Vehicles, v264.Instance));
                    end;
                end;

                local math_abs_ret = math.abs(u138 * GameRules.velocityToMph);

                if ((GameRules.vehicleCrashMotorcycleFallMph < math_abs_ret or Config.MAX_SPEED - GameRules.vehicleCrashMotorcycleFallBelowMaxSpeedMph < math_abs_ret) and u186 or u9.isPrivateServerConfigurationSettingEnabled("ejectOnCrash") and GameRules.vehicleCrashNoSeatbeltFallMph < math_abs_ret) and (GameRules.vehicleCrashMotorcycleFallImpactMph < v263 and (not u18 and u2.root)) then
                    u9.selectiveObjReplicaSystem("motorcycleCrash", u125, true, {
                        previousVelocity = p260
                    });

                    return true;
                end;
            end;
        end;
    end;

    if u129 then
        u167 = 0.5;

        if Config.TOW == "HookAndChain" then
            for i, v in pairs(u148) do
                if v[6] then
                    v[5] = v[5] - (i:GetAttribute("TrailerHeight") or 0) + -0.7;
                end;
            end;
        elseif u129.Name == "Harrow" then
            u129.Model.WheelCollision.CanCollide = false;
            u129.Model.WheelCollision2.CanCollide = false;
            table.insert(u11, function() -- Line: 1491
                -- upvalues: u129 (copy)
                if u129.Parent then
                    if u129.Model.WheelCollision.Transparency == 0 then
                        u129.Model.WheelCollision.CanCollide = true;
                    end;

                    if u129.Model.WheelCollision2.Transparency == 0 then
                        u129.Model.WheelCollision2.CanCollide = true;
                    end;
                end;
            end);
        elseif u129.Name == "Trailer" then
            setUpCollision(u129);
        end;

        table.insert(u10, Config2.Trailer.Changed:Connect(function() -- Line: 1500
            -- upvalues: u1 (ref), u125 (copy)
            u1.startVehicle(u125, true);
        end));
    end;

    u1.freezeVehicle(u125, "anchored", _Chassis.Anchored and true or false);
    local PropertyChangedSignal = _Chassis:GetPropertyChangedSignal("Anchored");
    table.insert(u10, PropertyChangedSignal:Connect(function() -- Line: 1507
        -- upvalues: u1 (ref), u125 (copy), _Chassis (copy)
        u1.freezeVehicle(u125, "anchored", _Chassis.Anchored);
    end));
    table.insert(u10, Heartbeat:Connect(function(u265) -- Line: 1512
        -- upvalues: _Chassis (copy), u186 (copy), Vector3_new_ret2 (ref), Vector3_new_ret (ref), GameRules (ref), vehicleCrashed (copy), Vector3_new_ret3 (ref), u138 (ref), u135 (ref), u9 (ref), u198 (ref), u146 (ref), u175 (ref), u143 (ref), u1 (ref), u137 (ref), Attribute (copy), u17 (ref), u142 (ref), u187 (ref), u173 (copy), u151 (ref), u158 (ref), u159 (ref), setBodyGyroProperties (copy), Vehicle (ref), BodyGyro (copy), u174 (copy), u172 (copy), u163 (ref), u148 (copy), LinearVelocity (copy), VectorForce (copy), u145 (ref), u157 (ref), u154 (ref), u136 (ref), u160 (ref), maxSpeed (ref), u178 (ref), Config (copy), u152 (ref), u155 (ref), u165 (copy), u225 (ref), u153 (ref), u125 (copy), Headlights (copy), u130 (copy), u8 (ref), u147 (ref), u214 (ref), Config2 (copy), u166 (copy), u167 (ref), u161 (ref), Easing (ref), u140 (ref), u185 (copy), u150 (copy), PlayerEvent (ref), Exhaust (copy), u5 (ref), u169 (ref), u215 (ref), u162 (ref), updateAcceleration (copy), u141 (ref), u144 (ref), u16 (ref), u131 (ref), u139 (ref), u170 (copy), u129 (copy), u134 (ref), u133 (ref), u132 (ref)
        local CFrame2 = _Chassis.CFrame;
        local LookVector = CFrame2.LookVector;
        local RightVector = CFrame2.RightVector;
        local _ = CFrame2.UpVector;
        local v266 = -CFrame2:VectorToObjectSpace(_Chassis.AssemblyLinearVelocity);
        local v267 = -CFrame2:VectorToObjectSpace(_Chassis.AssemblyLinearVelocity * Vector3.new(1, 0, 1));
        local v268 = u186 and (v267 - Vector3_new_ret2).Magnitude or (v266 - Vector3_new_ret).Magnitude;

        if v268 * GameRules.velocityToMph > GameRules.vehicleCrashSpeedMph and (Vector3_new_ret.Magnitude > v266.Magnitude and vehicleCrashed(v268, Vector3_new_ret3)) then
            return;
        end;

        Vector3_new_ret3 = _Chassis.AssemblyLinearVelocity;
        Vector3_new_ret2 = v267;
        Vector3_new_ret = v266;
        u138 = Vector3_new_ret.Z;
        u135 = u9.lerp(u135, u198 and u198.disableSteering and 0 or u146, u146 == 0 and 1 - 0.00005 ^ u265 or (u146 > 0 ~= (u135 > 0) and (1 - 0.0001 ^ u265) * u175 or (1 - 0.01 ^ u265) * u175));
        u143 = u9.lerp(u143, u135, 1 - 0.01 ^ u265);
        u1.absSpeed = math.abs(u138);
        u137 = Vector3_new_ret.Magnitude;
        local v269 = LookVector:Dot(Vector3.new(0, 1, 0));
        local v270 = RightVector:Dot(Vector3.new(0, 1, 0));
        local v271;

        if u1.absSpeed < 4 then
            v271 = math.abs(v269) < 0.5;
        else
            v271 = false;
        end;

        local v272 = Attribute and LookVector:Dot(u9.smartUnit(_Chassis:GetVelocityAtPosition(_Chassis.CFrame * Attribute))) or 1;
        local u273;

        if math.abs(v272) < 0.985 then
            u273 = u17 < u138;
        else
            u273 = false;
        end;

        local v274 = u9.raycastVisible(_Chassis.Position + Vector3.new(0, u142, 0) + _Chassis.AssemblyLinearVelocity * 0.2, u187(CFrame2), u173);
        local v275;

        if v274 then
            v275 = v274.Material;
        else
            v275 = v274;
        end;

        if u151 == nil or (v275 and true) ~= (u151 and true) then
            if v275 then
                if u158 and tick() - u158 > 0.5 then
                    u159 = true;
                    task.delay(0.5, function() -- Line: 1545
                        -- upvalues: u159 (ref), u158 (ref), setBodyGyroProperties (ref)
                        u159 = false;

                        if not u158 then
                            setBodyGyroProperties();
                        end;
                    end);
                else
                    setBodyGyroProperties();
                end;

                u158 = false;
            else
                setBodyGyroProperties(Vehicle.Airborne, function() -- Line: 1554
                    -- upvalues: BodyGyro (ref), _Chassis (ref), u146 (ref), u137 (ref), u135 (ref), u174 (ref), u172 (ref), u138 (ref), u265 (copy)
                    BodyGyro.CFrame = _Chassis.CFrame;

                    if u146 ~= 0 and u137 > 10 then
                        math.clamp(-u146 * u137 / 37.5, -1, 1);
                        _Chassis.AssemblyAngularVelocity = _Chassis.AssemblyAngularVelocity:Lerp(Vector3.new(0, -u135 * 0.2 * u174 * u172 * (u138 < 0 and -1 or 1), 0), 1 - 0.01 ^ u265);
                    end;
                end);
                u158 = tick();
            end;
        end;

        u151 = v275 or false;

        if math.abs(v270) >= 0.8 then
            if not u163 then
                u163 = true;

                for i, _ in pairs(u148) do
                    i.VectorForce.VectorForce.Enabled = false;
                end;
            end;
        elseif u163 then
            u163 = false;

            for i, _ in pairs(u148) do
                i.VectorForce.VectorForce.Enabled = true;
            end;
        end;

        if u151 then
            if not LinearVelocity.Enabled then
                LinearVelocity.Enabled = true;
                VectorForce.Force = Vector3.new(0, 0, 0);
            end;

            local function vehicleForceChange() -- Line: 1584
                -- upvalues: u198 (ref), u138 (ref), u145 (ref), u157 (ref), u154 (ref), u136 (ref), u160 (ref), maxSpeed (ref), u178 (ref), Config (ref), u152 (ref), u155 (ref), u165 (ref), u225 (ref), _Chassis (ref), u153 (ref), u151 (ref), u9 (ref), u125 (ref), Headlights (ref), u130 (ref), u8 (ref), u273 (copy), u147 (ref)
                if u198 and u198.brakeStrength then
                    return math.clamp(u138, -0.1, 0.1) * -u198.brakeStrength;
                end;

                if u145 == 1 and not (u157 or u154) then
                    u136 = 0.3;

                    if u138 <= 0 then
                        return Config.BRAKE_POWER * 1.2;
                    end;

                    if not u160 then
                        u160 = true;
                    end;

                    return (math.max(0, 1 - u138 / 72) * 0.4 + 0.2 + 0.8 * (1 - u138 / maxSpeed)) * u178;
                end;

                if u152 or (u145 ~= -1 or u157) then
                    if u138 < 0.2 and u160 then
                        u160 = false;
                    end;

                    return math.clamp(u138, -0.1, 0.1) * -0.15;
                end;

                if u155 or u165.forward then
                    if u225 and u165.forward then
                        u225();
                    end;

                    if u138 > 0.2 then
                        u136 = -0.3;
                    elseif u160 then
                        u160 = false;
                    end;

                    local Brakes = _Chassis.Brakes;

                    local function checkFunc() -- Line: 1356
                        -- upvalues: u138 (ref), u145 (ref)
                        local v276;

                        if u138 > 0.2 then
                            v276 = u145 == -1;
                        else
                            v276 = false;
                        end;

                        return v276;
                    end;

                    if not u153 and (u151 and checkFunc()) then
                        u153 = "brakes";
                        local u277 = "brakes";
                        task.spawn(function() -- Line: 1367
                            -- upvalues: Brakes (ref), u9 (ref), u125 (ref), u277 (copy), Headlights (ref), checkFunc (ref), u151 (ref), u130 (ref), u8 (ref), u153 (ref)
                            if Brakes then
                                u9.playSoundReplicate(Brakes);
                            end;

                            u9.brakeOrReverseLights(u125, u277, Headlights.Value);

                            while checkFunc() and u151 do
                                task.wait(0.03);

                                if u130 ~= u8 then
                                    return;
                                end;
                            end;

                            u153 = false;

                            if Brakes then
                                u9.stopSoundReplicate(Brakes);
                            end;

                            u9.brakeOrReverseLights(u125, false, Headlights.Value);
                        end);
                    end;

                    return math.clamp(u138, -1, 1) * -Config.BRAKE_POWER * 0.12 * (u273 and 0 or 10);
                end;

                if u138 > 0 then
                    local Brakes = _Chassis.Brakes;

                    local function u279() -- Line: 1356
                        -- upvalues: u138 (ref), u145 (ref)
                        local v278;

                        if u138 > 0.2 then
                            v278 = u145 == -1;
                        else
                            v278 = false;
                        end;

                        return v278;
                    end;

                    if not u153 and (u151 and u279()) then
                        u153 = "brakes";
                        local u280 = "brakes";
                        task.spawn(function() -- Line: 1367
                            -- upvalues: Brakes (ref), u9 (ref), u125 (ref), u280 (copy), Headlights (ref), u279 (ref), u151 (ref), u130 (ref), u8 (ref), u153 (ref)
                            if Brakes then
                                u9.playSoundReplicate(Brakes);
                            end;

                            u9.brakeOrReverseLights(u125, u280, Headlights.Value);

                            while u279() and u151 do
                                task.wait(0.03);

                                if u130 ~= u8 then
                                    return;
                                end;
                            end;

                            u153 = false;

                            if Brakes then
                                u9.stopSoundReplicate(Brakes);
                            end;

                            u9.brakeOrReverseLights(u125, false, Headlights.Value);
                        end);
                    end;

                    u136 = -0.3;

                    return -Config.BRAKE_POWER * 1.2;
                end;

                if not u154 then
                    local v281;

                    if Config.CATEGORY == "Truck" then
                        v281 = _Chassis.TruckReverse;
                    else
                        v281 = false;
                    end;

                    local u282 = v281;

                    local function u283() -- Line: 1361
                        -- upvalues: u138 (ref)
                        return u138 < -3;
                    end;

                    if not u153 and (u151 and u283()) then
                        u153 = "reverse";
                        local u284 = "reverse";
                        task.spawn(function() -- Line: 1367
                            -- upvalues: u282 (ref), u9 (ref), u125 (ref), u284 (copy), Headlights (ref), u283 (ref), u151 (ref), u130 (ref), u8 (ref), u153 (ref)
                            if u282 then
                                u9.playSoundReplicate(u282);
                            end;

                            u9.brakeOrReverseLights(u125, u284, Headlights.Value);

                            while u283() and u151 do
                                task.wait(0.03);

                                if u130 ~= u8 then
                                    return;
                                end;
                            end;

                            u153 = false;

                            if u282 then
                                u9.stopSoundReplicate(u282);
                            end;

                            u9.brakeOrReverseLights(u125, false, Headlights.Value);
                        end);
                    end;

                    if not u160 then
                        return -(math.max(u138, u147) / -u147 + 1 + 0) * (u178 + 0.05 - 0);
                    end;

                    u160 = false;
                    task.spawn(function() -- Line: 1609
                        -- upvalues: u152 (ref), u145 (ref)
                        u152 = true;
                        local v285 = 0;

                        while v285 < 0.3 do
                            if u145 == 1 then
                                u152 = false;
                                break;
                            end;

                            v285 = v285 + task.wait(0.016);
                        end;

                        u152 = false;
                    end);

                    return -u138;
                end;
            end;

            local v286 = (u138 > 0 and 1 or -1) * math.abs(Vector3_new_ret.X) * 0.025 * (1 - u214 * 0.5) * (u273 and not u155 and 1 or 0.5);
            local v287 = vehicleForceChange();
            local v288 = u138;
            local v289 = u125.Config.SpeedLimiter.Value ~= 0 and Config2.SpeedLimiter.Value or u1.maxSpeed;
            local v290;

            if v287 then
                local v291 = v271 and 0 or (math.abs(v269) < 0.8 and v269 * 0.3 or v269 * 4);
                v290 = math.clamp(u138 + (v287 - v286 - v291) * u265 * 60, u147, v289);
            else
                v290 = 0;
            end;

            u138 = v290;

            if v288 > 0.01 and u138 < -0.1 or v288 < -0.01 and u138 > 0.1 then
                u138 = 0;
            end;

            LinearVelocity.VectorVelocity = Vector3.new(0, 0, -u138);
        elseif LinearVelocity.Enabled then
            LinearVelocity.Enabled = false;
            VectorForce.Force = Vector3.new(0, 200000, 0) * (u166 + u167);
        end;

        if u161 and math.abs(v272) > 0.994 then
            u161 = false;
        end;

        local v292 = 0.99 + Easing.inQuint(u9.inverseLerp(u17, 120 / GameRules.velocityToMph, u1.absSpeed), 0, -0.09, 1);
        local v293 = u1.absSpeed <= u17 and true or math.abs(u135) < v292;

        if u214 > 0 then
            u140 = 0.3 - Easing.outSine(u214, 0, 1, 1) * 0.26;
        elseif u1.absSpeed < 1 then
            if u161 then
                u161 = false;
            end;

            u140 = 1;
        elseif u155 then
            if not u161 then
                u161 = true;
            end;

            u140 = u185 and 1 or (u186 and 1 or 0.17);
        elseif v293 and not u161 then
            u140 = 1;
        else
            if not u161 then
                u161 = true;
            end;

            u140 = u185 and 1 or (u186 and 1 or 0.28);
        end;

        for _, v in pairs(u150) do
            v(u265);
        end;

        if math.min(u1.absSpeed, u1.maxSpeed) > u1.gearChange[u1.gear + 1] then
            u1.gear = u1.gear + 1;
            PlayerEvent:FireServer("vehicle", "gearSpeed", u1.gearChange[u1.gear + 1]);

            if Exhaust then
                u9.selectiveObjReplicaSystem("vehicleBackfire", u125);
            end;

            u5.changeFOV(-1);
            task.delay(0.15, function() -- Line: 1676
                -- upvalues: u5 (ref)
                u5.changeFOV(-1);
            end);
            task.delay(0.45, function() -- Line: 1679
                -- upvalues: u5 (ref)
                for i = 1, 12 do
                    u5.changeFOV(0.16666666666666666);
                    task.wait(0.1);
                    local _ = i;
                end;
            end);
        elseif u1.absSpeed < u1.gearChange[u1.gear] - 12 then
            u1.gear = u1.gear - 1;
            PlayerEvent:FireServer("vehicle", "gearSpeed", u1.gearChange[u1.gear + 1]);
        end;

        if u151 and (v274.Instance ~= workspace.Terrain or u169[u151]) and (u215 ~= 1 and not u159 and (u273 or u155 and u138 > 25 or u198 and u198.pittingStage)) then
            if u125:GetAttribute("Skid") ~= (u169[u151] or true) then
                u9.setSkid(u125, true, u169[u151]);
            end;
        elseif u125:GetAttribute("Skid") then
            u9.setSkid(u125, false);
        end;

        if u151 and u169[u151] then
            if not u162 then
                u162 = true;
                updateAcceleration();
            end;
        elseif u162 then
            u162 = false;
            updateAcceleration();
        end;

        u136 = u9.lerp(u136, 0, 1 - 1e-18 ^ u265);
        u141 = u9.lerp(u141, _Chassis.AssemblyAngularVelocity.Y, 1 - 1e-18 ^ u265);
        local CFrame3 = _Chassis.CFrame;
        local CFrame_Angles = CFrame.Angles;
        local math_abs_ret = math.abs(1 / u138);
        local RightVector2 = (CFrame3 * CFrame_Angles(0, -u135 * math.min(math_abs_ret, 0.04) * u174, 0)).RightVector;
        local v294 = (v271 and 0 or 1) * 0.02;

        for i, v in pairs(u148) do
            local v295;

            if v[1] == true then
                v295 = u136 < 0 and -u136 * 0.5 or 0;
            else
                v295 = v[1] == false and (u136 > 0 and u136 * 0.5 or 0) or 0;
            end;

            local v296 = u144 + v[5] - v295 + u16[u131] - (u186 and math.min(60, u1.absSpeed) / 60 * -0.25 or -u143 * (v[2] and -0.14 or 0.14)) * math.abs(u141) - (v[3] and 0.38 or 0);
            local v297 = v[1] and RightVector2 and RightVector2 or i.CFrame.RightVector;
            local UpVector = i.CFrame.UpVector;
            local v298 = u9.raycastVisible(i.Position + UpVector * (v[4] / 2 + u139), -UpVector * (v[4] + 5 + u139 * 2), u170);

            if v298 and (not u185 or v298.Material == Enum.Material.Water) then
                local VelocityAtPosition = (v[6] and u129.PrimaryPart or i.AssemblyRootPart):GetVelocityAtPosition(i.Position);
                local v299 = -v297:Dot(VelocityAtPosition) * u140 * (u198 and (u198.pittingStage and u198.desiredVelChange) or 1) / 0.016666666666666666 * 4 / (v[6] and u134 or u133) * (v[6] and u167 * 0.7 or u166);
                local v300 = i.Position - v298.Position;
                local v301 = v296 - math.min(v300.Magnitude, 3) * (u9.smartUnit(v300):Dot(Vector3.new(0, 1, 0)) > 0 and 1 or -1);
                local v302 = UpVector:Dot(VelocityAtPosition);
                local math_abs_ret2 = math.abs(u138);
                local v303 = math.min(math_abs_ret2, 130) / 130 * 15 + math.min(u265, 0.07) / 0.07 * 15;
                local v304 = v301 * u131 - v302 * u131 * u132 * 0.0424 * (math.min(25, v303) * 0.3 / 25 + 1);
                i.VectorForce.VectorForce.Force = v297 * 100 * v299 + UpVector * Vector3.new(v294, 1, v294) * v304 * (1556 * workspace.Gravity / (u134 + u133) * (u167 + u166));
            elseif i.VectorForce.VectorForce.Force ~= Vector3.new() then
                i.VectorForce.VectorForce.Force = Vector3.new();
            end;
        end;
    end));

    if GameRules.testVehicleThrusterHeight then
        task.defer(function() -- Line: 1739
            -- upvalues: u130 (copy), u8 (ref), GameRules (ref), u144 (ref), u148 (copy), u129 (copy), u131 (ref), u132 (ref), Config (copy)
            while u130 == u8 do
                if GameRules.testVehicleThrusterHeight[1] then
                    u144 = GameRules.testVehicleThrusterHeight[1].Value;
                end;

                if GameRules.testVehicleThrusterHeight[2] then
                    for i, _ in pairs(u148) do
                        u148[i][5] = (i:GetAttribute("CustomHeight") or 0) + (u129 and i:GetAttribute("TrailerHeight") or 0);
                    end;
                end;

                if GameRules.testVehicleThrusterHeight[3] then
                    u131 = GameRules.testVehicleThrusterHeight[3].Value;
                end;

                if GameRules.testVehicleThrusterHeight[4] then
                    u132 = GameRules.testVehicleThrusterHeight[4].Value;
                end;

                if GameRules.testVehicleThrusterHeight[5] then
                    Config.MAX_WHEEL_RISE = GameRules.testVehicleThrusterHeight[5].Value;
                end;

                task.wait(0.06);
            end;
        end);
    end;

    task.defer(function() -- Line: 1758
        -- upvalues: u130 (copy), u8 (ref), Config2 (copy), u1 (ref), u154 (ref), Config (copy), u137 (ref), u151 (ref), u15 (ref), PlayerEvent (ref)
        while u130 == u8 do
            local Fuel = Config2.Fuel;
            local v305 = Config2.Fuel.Value - math.min(u1.absSpeed, 200) * 0.0004 - 0.004;
            Fuel.Value = math.max(0, v305);

            if u154 ~= (Config2.Fuel.Value <= 0) then
                u154 = Config2.Fuel.Value <= 0;
            end;

            if Config.DIRT_VERTICAL_SCALE and (u137 > 15 and (u151 and u15[u151])) then
                PlayerEvent:FireServer("vehicle", "cleanliness", math.round(u137), u15[u151]);
            end;

            task.wait(5);
        end;
    end);
    task.defer(function() -- Line: 1771
        -- upvalues: u130 (copy), u8 (ref), Config2 (copy), Config (copy), u185 (copy), u5 (ref)
        while u130 == u8 do
            if Config2.Fuel.Value < Config.MAX_FUEL * 0.2 then
                if u185 then
                    u5.notify({
                        message = "The boat is running low on fuel. Refuel at dock"
                    });
                else
                    u5.notify({
                        message = "The vehicle is running low on fuel"
                    });
                end;
            end;

            task.wait(60);
        end;
    end);
    table.insert(u10, task.spawn(function() -- Line: 1784
        -- upvalues: u9 (ref), _Chassis (copy)
        u9.antiFling(_Chassis, 70, 30);
    end));
    task.spawn(function() -- Line: 1788
        -- upvalues: u130 (copy), u8 (ref), u137 (ref), u156 (ref), u9 (ref), u125 (copy)
        while u130 == u8 do
            local v306 = u137 > 30;

            if v306 ~= u156 then
                u9.setTireSpark(u125, v306);
            end;

            u156 = v306;
            task.wait(1);
        end;
    end);
    task.spawn(function() -- Line: 1799
        -- upvalues: u130 (copy), u8 (ref), u1 (ref), u125 (copy), Vector3_new_ret3 (ref), GameRules (ref), u9 (ref), u5 (ref)
        local v307 = 0;

        while u130 == u8 do
            if u1.isVehicleFliped(u125) and Vector3_new_ret3.Magnitude * GameRules.velocityToMph < 3 then
                v307 = v307 + 1;

                if v307 >= 5 and not u9.rest("unflipNotify", 120) then
                    u5.notify({
                        message = "Exit your vehicle to unflip"
                    });
                end;
            else
                v307 = 0;
            end;

            task.wait(3);
        end;
    end);
end;

return u1;
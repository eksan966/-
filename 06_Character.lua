-- Decompiled with Potassium's decompiler.

local u1 = {};
local ModuleLoader = require(game.ReplicatedStorage.Modules.ModuleLoader);
local u2 = ModuleLoader.assign(script.Parent:WaitForChild("Core"));
local u3 = ModuleLoader.assign(script.Parent:WaitForChild("Vehicle"));
local u4 = ModuleLoader.assign(script:WaitForChild("Inventory"));
local u5 = ModuleLoader.assign(script:WaitForChild("Phone"));
local u6 = ModuleLoader.assign(script:WaitForChild("Panel"));
local u7 = ModuleLoader.assign(script:WaitForChild("AutoShop"));
local u8 = ModuleLoader.assign(script:WaitForChild("Housing"));
local u9 = ModuleLoader.assign(script.Parent:WaitForChild("Interaction"));
ModuleLoader.assign(script.Parent:WaitForChild("Events"));
local Ragdoll = require(game.ReplicatedStorage.Modules:WaitForChild("Ragdoll"));
local EmergencyLightingSystem = require(script.Parent.EmergencyLightingSystem);
local CharScope = require(game.ReplicatedStorage.Modules:WaitForChild("CharScope"));
local LocalPlayer = game.Players.LocalPlayer;
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local AssetService = game:GetService("AssetService");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local TweenService = game:GetService("TweenService");
local DampedSpring = require(game.ReplicatedStorage.Modules:WaitForChild("DampedSpring"));
local AvatarAssets = require(game.ReplicatedStorage.Modules.AvatarAssets);
local GlobalGui = PlayerGui:WaitForChild("GlobalGui");
local FullScreenGui = PlayerGui:WaitForChild("FullScreenGui");
local PlayerEvent = game.ReplicatedStorage.Remote.PlayerEvent;
local UnreliableEvent = game.ReplicatedStorage.Remote.UnreliableEvent;
local u10 = ModuleLoader.assign(game.ReplicatedStorage.Modules.Algorithms);
local OffsetCamera = require(game.ReplicatedStorage.Modules.OffsetCamera);
require(game.ReplicatedStorage.Modules.NavigationSystem);
local Variables = game.ReplicatedStorage.Variables;
local GameRules = require(game.ReplicatedStorage.Modules.GameRules);
local HandshakeSystem = require(game.ReplicatedStorage.Modules:WaitForChild("HandshakeSystem"));
local Mouse = LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;
local PlayerFunc = game.ReplicatedStorage.Remote.PlayerFunc;
local UserInputService = game:GetService("UserInputService");
local Stuff = game.ReplicatedStorage.Stuff;
game:GetService("ProximityPromptService");
local PlayerStuff = game.ReplicatedStorage.PlayerStuff;
game:GetService("CollectionService");
UserSettings():GetService("UserGameSettings");
local GuiService = game:GetService("GuiService");
local Easing = require(game.ReplicatedStorage.Modules.Easing);
local ActiveRace = game.ReplicatedStorage.Gameplay.Races.ActiveRace;
local VoiceChatInput = LocalPlayer:WaitForChild("VoiceChatInput");
LocalPlayer:WaitForChild("VoiceChatRadioInput");
game:GetService("LocalizationService");
game:GetService("TextChatService");
local HttpService = game:GetService("HttpService");
local u11 = nil;
local u12 = {};
HandshakeSystem.watch("Character", "c8k2ptw9");

function u1.loadCharacter(u13, p14, u15) -- Line: 58
    -- upvalues: LocalPlayer (copy), u2 (copy), u11 (ref), u12 (ref), u10 (copy), PlayerGui (copy), u1 (copy), CharScope (copy), VoiceChatInput (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), PlayerStuff (copy), PlayerEvent (copy), FullScreenGui (copy), workspace_CurrentCamera (copy), UserInputService (copy), TweenService (copy), RunService (copy), GameRules (copy), PlayerFunc (copy), DampedSpring (copy), UnreliableEvent (copy), GlobalGui (copy), Ragdoll (copy), GuiService (copy), Mouse (copy), u3 (copy), HttpService (copy), EmergencyLightingSystem (copy), ActiveRace (copy), Variables (copy), Easing (copy), MarketplaceService (copy), OffsetCamera (copy), AssetService (copy), Stuff (copy), AvatarAssets (copy)
    LocalPlayer.CharacterAddedClient:Fire(u13);
    u2.activateLoading(u13);

    if u11 ~= p14 then
        u11 = p14;
        u2.teamChanged(u11);
    end;

    u2.debugLoadingClient("Character 1");
    u2.isCharacter = u13;
    local v16 = tick();
    local HumanoidRootPart = u13:WaitForChild("HumanoidRootPart");

    if u12 then
        for _, v in pairs(u12) do
            v:Destroy();
        end;
    end;

    u12 = u10.playerScreenGuiSystem("createCharacter", LocalPlayer);
    local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
    u1.screenGui = ScreenGui;
    local FrontGui = PlayerGui:WaitForChild("FrontGui");
    local Humanoid = u13:WaitForChild("Humanoid");
    u2.rootPersistent = HumanoidRootPart;
    u2.humPersistent = Humanoid;
    u10.setCameraProperties("1", {
        CameraSubject = Humanoid,
        CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance,
        CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance
    });
    u10.resetPlrCameraZoom();
    local Head = u13:WaitForChild("Head");
    Head.CanCollide = true;
    Head:WaitForChild("_NameDisplay"):Destroy();
    local Animator = Humanoid:WaitForChild("Animator");
    u1.seatWeld = u13:WaitForChild("Seat");
    local MapGui = PlayerGui:WaitForChild("MapGui").MapGui;
    local Mobile = ScreenGui.Right.Bottom.Mobile;
    u1.rightBottomMobile = Mobile;
    local Chat = ScreenGui.Right.Top.Chat;
    u1.smartRadioGui = ScreenGui.Right.Bottom.SmartRadio;
    CharScope.taskDefer(function() -- Line: 92
        -- upvalues: u13 (copy), HumanoidRootPart (copy)
        while not u13:GetAttribute("MovementSoundsAdded") do
            print("MovementSoundsAdded NOT LAOADED");
            task.wait();
        end;

        for _, child in pairs(HumanoidRootPart:GetChildren()) do
            if child:IsA("Sound") and not child.SoundGroup then
                child.SoundGroup = game.SoundService.SoundGroups.Global;
            end;
        end;
    end);
    local VoiceChatEmitter = u13:WaitForChild("VoiceChatEmitter");
    VoiceChatEmitter.AudioInteractionGroup = "DontHearYourself";
    CharScope.buildSignalData("Global", { VoiceChatEmitter.ChildAdded, function(p17) -- Line: 100
            -- upvalues: VoiceChatEmitter (copy), u10 (ref)
            if p17:IsA("Folder") and p17:GetAttribute("HearYourself") then
                VoiceChatEmitter.AudioInteractionGroup = "";
                local v18 = u10.waitForChildRecrusive(VoiceChatEmitter, "AudioFader", 30);

                if v18 then
                    v18.Volume = v18.Volume / 3;
                end;
            end;
        end });
    CharScope.buildSignalData("Global", { VoiceChatEmitter.ChildRemoved, function(p19) -- Line: 107
            -- upvalues: VoiceChatInput (ref), VoiceChatEmitter (copy)
            if p19:IsA("Folder") and not VoiceChatInput.Muted then
                VoiceChatEmitter.AudioInteractionGroup = "DontHearYourself";
            end;
        end });
    local u20 = nil;
    local u21 = 0;
    local u22 = false;
    local u23 = nil;
    local RADIO_CHANNEL = require(game.Teams[u11].Config).RADIO_CHANNEL;
    u1.humanoidState = -1;
    u2.generateUserTips(u11);
    u2.teamWorldContent();
    u1.root = HumanoidRootPart;
    u1.hum = Humanoid;
    u4.initiate(u13, u11);
    u5.initiate(u13, u11);
    u6.initiate(u13, u11);
    u7.initiate(u13, u11);
    u8.initiate(u13, u11);
    local v24 = u9.interactionClock(HumanoidRootPart);
    CharScope.addThreadOrCleanUpFunction("Global", v24.cleanUp);
    CharScope.taskDefer(v24.thread);

    if u2.destroyWaypointsOnDeath then
        u2.destroyWaypointsOnDeath();
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    u9.disabled(false, "characterNotWorkspace");

    if not u2.openedGuiDontResetOnDeath then
        u2.openGui();
    end;

    FrontGui.TopBarButtons.Menu.Visible = true;
    local TeamCameras = ScreenGui.Left.HideGuiTop.TeamCameras;
    local SelectionWheel = ScreenGui.Center.Middle.SelectionWheel;
    local HackingMinigames = ScreenGui.Center.Middle.HackingMinigames;
    local EmoteMenu = ScreenGui.Center.Middle.EmoteMenu;
    u13.Archivable = true;
    local u25 = u10.clone(u13);
    u1.viewModel = u25;
    u25.Name = "ViewModel";
    CharScope.buildSignalData("Global", { Humanoid.ApplyDescriptionFinished, function() -- Line: 150
            -- upvalues: u13 (copy), u25 (copy)
            if u13:FindFirstChild("Pants") then
                u25.Pants.PantsTemplate = u13.Pants.PantsTemplate;
            end;

            if u13:FindFirstChild("Shirt") then
                u25.Shirt.ShirtTemplate = u13.Shirt.ShirtTemplate;
            end;
        end });
    local u26 = {
        ["Body Colors"] = true,
        Pants = true,
        Shirt = true,
        Humanoid = true,
        LeftHand = true,
        LeftLowerArm = true,
        LeftUpperArm = "Invisible",
        LowerTorso = "Invisible",
        RightHand = true,
        RightLowerArm = true,
        RightUpperArm = "Invisible",
        UpperTorso = "Invisible",
        HumanoidRootPart = {
            Sound = true
        }
    };

    for _, child in pairs(u25:GetChildren()) do
        if u26[child.Name] then
            if child:IsA("BasePart") then
                child.CollisionGroup = "NonCollide";
                child.CastShadow = false;
            end;

            if u10.typeOf(u26[child.Name]) == "table" then
                local v27 = child;

                for _, child2 in pairs(child:GetChildren()) do
                    if u26[v27.Name][child2.ClassName] then
                        child2:Destroy();
                    end;
                end;
            elseif u26[child.Name] == "Invisible" then
                child.Transparency = 1;
            end;
        else
            child:Destroy();
        end;
    end;

    u25.Parent = game.ReplicatedStorage.Gameplay.Entities;
    u25.PrimaryPart.Anchored = true;
    CharScope.addEntity(u25);
    local v28 = {
        Waist = true,
        Root = true
    };
    local u29 = {};

    for _, descendant in pairs(u25:GetDescendants()) do
        if descendant:IsA("AnimationConstraint") and not v28[descendant.Name] then
            u29[descendant] = u13[descendant.Parent.Name][descendant.Name];
        end;
    end;

    u13.Archivable = false;
    local u30 = true;

    function u1.setViewModelVisibility(p31) -- Line: 185
        -- upvalues: u30 (ref), u25 (copy), u26 (copy)
        if u30 ~= p31 then
            for _, child in pairs(u25:GetChildren()) do
                if child:IsA("BasePart") and (u26[child.Name] ~= "Invisible" and child.Name ~= "HumanoidRootPart") then
                    child.Transparency = p31 and 0 or 1;
                end;
            end;
        end;

        u30 = p31;
    end;

    u2.customRightGrip = u10.toolSystem.createGrip(u13);
    u10.animationBuffer(Animator, "load", PlayerStuff.Animations:WaitForChild("StomachGrowl"), PlayerStuff.Animations:WaitForChild("Interact"), PlayerStuff.Animations:WaitForChild("PushingSomething"), PlayerStuff.Animations:WaitForChild("PetPet"), PlayerStuff.Animations:WaitForChild("CommandPet"), PlayerStuff.Animations:WaitForChild("PhoneCall"), PlayerStuff.Animations:WaitForChild("VehicleSpawner"), PlayerStuff.Animations:WaitForChild("ATM"), PlayerStuff.Animations:WaitForChild("PlaceGive"), PlayerStuff.Animations:WaitForChild("PickUp"), PlayerStuff.Items.Animations:WaitForChild("Graffiti"), PlayerStuff.Items.Animations:WaitForChild("HookAction"));
    u1.animator = Animator;
    CharScope.buildSignalData("Global", u2.mouseButton(Mobile.Dragging.Drop, function() -- Line: 200
        -- upvalues: u2 (ref)
        u2.startDragging();
    end));
    u1.isKid = u10.isKid(LocalPlayer);

    function u1.onEquipStateChanged(p32) -- Line: 202
        -- upvalues: u1 (ref)
        u1.setCameraRelativeToViewModelPart("HumanoidRootPart", CFrame.new(0, 1.7, 0));
    end;

    function u1.onEquipStateChangedItemLoaded(p33) -- Line: 207
        -- upvalues: u1 (ref)
        if u1.firstPerson then
            u1.onToolEquippedWhenFirstPerson(p33);
        end;
    end;

    local function isIncidentActive(p34) -- Line: 211
        -- upvalues: u11 (ref), LocalPlayer (ref)
        local v35 = p34:IsA("StringValue") and p34:WaitForChild("Code") and (p34:WaitForChild("Team"):FindFirstChild(u11) and not p34:GetAttribute("SilentIncident")) and (not p34.Team[u11]:WaitForChild("Solo").Value or p34:WaitForChild("Players"):FindFirstChild(LocalPlayer.Name));

        return v35;
    end;

    local u36 = {
        LeftHand = true,
        RightHand = true,
        LeftLowerArm = true,
        RightLowerArm = true
    };
    u10.buildSignalData(u2.characterRemovingConnectionsAndThreads, { Humanoid.Touched, function(p37, p38) -- Line: 216
            -- upvalues: u36 (copy), u2 (ref)
            if not u36[p38.Name] then
                u2.touchInteraction("character", p37, p38);
            end;
        end });
    local Position = ScreenGui.Left.Bottom.Minimap.Position;
    local Size = ScreenGui.Left.Bottom.Minimap.Size;
    local Position2 = ScreenGui.Left.Bottom.Minimap.SpeedLimit.Position;
    local Size2 = ScreenGui.Left.Bottom.Minimap.SpeedLimit.Size;

    local function loadPlatform(p39) -- Line: 226
        -- upvalues: CharScope (ref), ScreenGui (copy), Position (copy), Size (copy), Position2 (copy), Size2 (copy), EmoteMenu (copy), HackingMinigames (copy), SelectionWheel (copy), TeamCameras (copy), Mobile (copy), Chat (copy), RADIO_CHANNEL (copy), u1 (ref), u10 (ref), LocalPlayer (ref), PlayerGui (ref)
        CharScope.setConnectionsAndThreads("NewPlatform");
        local v40 = p39 == "Mobile";

        if v40 then
            ScreenGui.Left.Bottom.Minimap.Position = UDim2.fromScale(3.2, -0.2);
            ScreenGui.Left.Bottom.Minimap.Size = UDim2.fromScale(1.75, 1.75);
            ScreenGui.Left.Bottom.Minimap.SpeedLimit.Position = UDim2.fromScale(0.15, 0.85);
            ScreenGui.Left.Bottom.Minimap.SpeedLimit.Size = UDim2.fromScale(0.3, 0.3);
            ScreenGui.Left.Bottom.Minimap.DirectionMarker.Visible = false;
            ScreenGui.Left.Bottom.Minimap.Button.Visible = false;

            for _, child in pairs(ScreenGui.Left.Bottom.Minimap.VisualMap3D.Map:GetChildren()) do
                if child.Name == "Map" then
                    child.Decal.Transparency = 1;
                end;
            end;
        else
            ScreenGui.Left.Bottom.Minimap.Position = Position;
            ScreenGui.Left.Bottom.Minimap.Size = Size;
            ScreenGui.Left.Bottom.Minimap.SpeedLimit.Position = Position2;
            ScreenGui.Left.Bottom.Minimap.SpeedLimit.Size = Size2;
            ScreenGui.Left.Bottom.Minimap.DirectionMarker.Visible = true;
            ScreenGui.Left.Bottom.Minimap.Button.Visible = true;

            for _, child in pairs(ScreenGui.Left.Bottom.Minimap.VisualMap3D.Map:GetChildren()) do
                if child.Name == "Map" then
                    child.Decal.Transparency = 0;
                end;
            end;
        end;

        EmoteMenu.Shortcut.Visible = not v40;
        HackingMinigames.Lockpick["2Circles"].Keybinds.Visible = not v40;
        HackingMinigames.Lockpick["3Circles"].Keybinds.Visible = not v40;
        HackingMinigames.Lockpick["4Circles"].Keybinds.Visible = not v40;
        SelectionWheel.Shortcut.Visible = not v40;
        TeamCameras.Keybinds.Visible = not v40;
        ScreenGui.Right.Middle.HousingEditTool.Panel.AssetNoCollision.ButtonImage.Visible = not v40;
        ScreenGui.Right.Bottom.HousingEditTool.Visible = not v40;
        ScreenGui.Left.Bottom.Mobile.Visible = v40;
        Mobile.Visible = v40;

        local function setElevation(p41, p42) -- Line: 263
            p41.Position = p42;
            p41:SetAttribute("TransitionTweenType", p42);
        end;

        if v40 then
            local function update() -- Line: 268
                -- upvalues: ScreenGui (ref)
                local math_max_ret = math.max(0, ScreenGui.Right.Bottom.Mobile.AbsoluteSize.Y - 63);
                local Ammo = ScreenGui.Right.Bottom.Ammo;
                local UDim2_new_ret = UDim2.new(0, 0, 0, -70 - math_max_ret);
                Ammo.Position = UDim2_new_ret;
                Ammo:SetAttribute("TransitionTweenType", UDim2_new_ret);
                local MetalDetector = ScreenGui.Right.Bottom.MetalDetector;
                local UDim2_new_ret2 = UDim2.new(0, 0, 0, -70 - math_max_ret);
                MetalDetector.Position = UDim2_new_ret2;
                MetalDetector:SetAttribute("TransitionTweenType", UDim2_new_ret2);
                local SpeedRadar = ScreenGui.Right.Bottom.SpeedRadar;
                local UDim2_new_ret3 = UDim2.new(0, 0, 0, -70 - math_max_ret);
                SpeedRadar.Position = UDim2_new_ret3;
                SpeedRadar:SetAttribute("TransitionTweenType", UDim2_new_ret3);
                local ToolWithSelection = ScreenGui.Right.Bottom.ToolWithSelection;
                local UDim2_new_ret4 = UDim2.new(0, 0, 0, -70 - math_max_ret);
                ToolWithSelection.Position = UDim2_new_ret4;
                ToolWithSelection:SetAttribute("TransitionTweenType", UDim2_new_ret4);
                local Vehicle = ScreenGui.Right.Bottom.Vehicle;
                local UDim2_new_ret5 = UDim2.new(0, 0, 0, -50 - math_max_ret);
                Vehicle.Position = UDim2_new_ret5;
                Vehicle:SetAttribute("TransitionTweenType", UDim2_new_ret5);
                local ELS = ScreenGui.Right.Bottom.ELS;
                local UDim2_new_ret6 = UDim2.new(0, 0, 0.02, -78 - math_max_ret);
                ELS.Position = UDim2_new_ret6;
                ELS:SetAttribute("TransitionTweenType", UDim2_new_ret6);
            end;

            update();
            CharScope.buildSignalData("NewPlatform", { ScreenGui.Right:WaitForChild("__FakeFrame"):GetPropertyChangedSignal("AbsoluteSize"), update });
        else
            local Ammo = ScreenGui.Right.Bottom.Ammo;
            local UDim2_new_ret = UDim2.new();
            Ammo.Position = UDim2_new_ret;
            Ammo:SetAttribute("TransitionTweenType", UDim2_new_ret);
            local MetalDetector = ScreenGui.Right.Bottom.MetalDetector;
            local UDim2_new_ret2 = UDim2.new();
            MetalDetector.Position = UDim2_new_ret2;
            MetalDetector:SetAttribute("TransitionTweenType", UDim2_new_ret2);
            local SpeedRadar = ScreenGui.Right.Bottom.SpeedRadar;
            local UDim2_new_ret3 = UDim2.new();
            SpeedRadar.Position = UDim2_new_ret3;
            SpeedRadar:SetAttribute("TransitionTweenType", UDim2_new_ret3);
            local ToolWithSelection = ScreenGui.Right.Bottom.ToolWithSelection;
            local UDim2_new_ret4 = UDim2.new();
            ToolWithSelection.Position = UDim2_new_ret4;
            ToolWithSelection:SetAttribute("TransitionTweenType", UDim2_new_ret4);
            local Vehicle = ScreenGui.Right.Bottom.Vehicle;
            local UDim2_new_ret5 = UDim2.new();
            Vehicle.Position = UDim2_new_ret5;
            Vehicle:SetAttribute("TransitionTweenType", UDim2_new_ret5);
            local ELS = ScreenGui.Right.Bottom.ELS;
            local UDim2_new_ret6 = UDim2.new(0, 0, 0.02, 0);
            ELS.Position = UDim2_new_ret6;
            ELS:SetAttribute("TransitionTweenType", UDim2_new_ret6);
        end;

        Chat.InputBox.TextBoxFrame.ZIndex = v40 and not RADIO_CHANNEL and 0 or 5;

        if Chat.InputBox.TextBoxFrame:FindFirstChild("MobileButton") then
            Chat.InputBox.TextBoxFrame.MobileButton.ZIndex = Chat.InputBox.TextBoxFrame.ZIndex + 1;
        end;

        Chat.InputBox.PlaceholderRight.Text = v40 and "Tap here to chat" or "Press / to open chat";
        u1.refreshELSGuiVisibility();
        local v43 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);

        if v43 then
            u1.activateVehicleGui(v43, true);
        end;

        if v40 then
            CharScope.addThreadOrCleanUpFunction("NewPlatform", CharScope.taskSpawn(function() -- Line: 295
                -- upvalues: PlayerGui (ref)
                local JumpButton = PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton", 240);

                if JumpButton then
                    JumpButton:Destroy();
                end;
            end));
        end;
    end;

    local u44 = {};
    local u45 = nil;

    function u1.displayMobileGuiType(p46) -- Line: 305
        -- upvalues: u45 (ref), u44 (copy), u10 (ref), ScreenGui (copy), Mobile (copy)
        if p46 then
            u45 = p46;
        end;

        local function focus(p47) -- Line: 307
            -- upvalues: u44 (ref), u45 (ref), u10 (ref)
            for _, child in pairs(p47:GetChildren()) do
                if child:IsA("Frame") then
                    local v48 = u44[child.Name] or child.Name == u45;
                    local v49;

                    if v48 and not child.Visible then
                        v49 = child;

                        for _, child2 in pairs(child:GetChildren()) do
                            if child2:IsA("ImageButton") then
                                u10.mobileButtonPressed(child2, false);
                            end;
                        end;
                    else
                        v49 = child;
                    end;

                    v49.Visible = v48;
                end;
            end;
        end;

        focus(ScreenGui.Left.Bottom.Mobile);
        focus(Mobile);
    end;

    u1.displayMobileGuiType("Character");

    function u1.keepMobileGuiTypePersistent(p50, p51) -- Line: 323
        -- upvalues: u44 (copy), u1 (ref)
        u44[p50] = p51 and true or nil;
        u1.displayMobileGuiType();
    end;

    local Animate = u13:WaitForChild("Animate");

    function u1.updateStrafing() -- Line: 330
        -- upvalues: u22 (ref), u1 (ref), Animate (copy)
        local v52 = u22 or (u1.firstPerson and true or false);

        if Animate:GetAttribute("StrafingEnabled") ~= v52 then
            Animate:SetAttribute("StrafingEnabled", v52);
        end;
    end;

    u1.updateStrafing();
    local EscortTypes = game.ReplicatedStorage.Gameplay.EscortTypes;
    local u53 = false;
    local u54 = nil;

    local function escortingPlayerIsClimbing(p55) -- Line: 341
        -- upvalues: u54 (ref), u10 (ref), CharScope (ref), escortingPlayerIsClimbing (copy)
        if u54 == p55 then
            return;
        end;

        if u54 then
            if u10.isCharLoaded(u54) then
                u10.charCollisionGroup(u54.Character);
            end;

            u54 = nil;
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "escortingPlayerIsClimbing", nil);
        end;

        if p55 then
            u54 = p55;

            if u10.isCharLoaded(u54) then
                u10.charCollisionGroup(u54.Character, "NonCollide");
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "escortingPlayerIsClimbing", function() -- Line: 352
                    -- upvalues: escortingPlayerIsClimbing (ref)
                    escortingPlayerIsClimbing();
                end);
            end;
        end;
    end;

    local u56 = u10.raycastParamsNew();
    u56.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities, workspace.Gameplay.Vehicles };
    u56.IgnoreWater = true;

    function u1.escortPlayer(p57, u58) -- Line: 362
        -- upvalues: u53 (ref), EscortTypes (copy), u10 (ref), Animator (copy), u4 (ref), u1 (ref), PlayerEvent (ref), escortingPlayerIsClimbing (copy), CharScope (ref), LocalPlayer (ref), Humanoid (copy), HumanoidRootPart (copy), u56 (copy), u2 (ref)
        if u53 then
            if EscortTypes[u53]:FindFirstChild("EscortAnimation") then
                u10.animationBuffer(Animator, "stop", "EscortAnimation");
                u10.animationBuffer(Animator, "unload", "EscortAnimation");
            end;

            u53 = false;
            u4.canEquipSlot(true);
            u1.lockEmotes("escortPlayer", false);
            u1.setCharRotType("escortPlayer");
            PlayerEvent:FireServer("getRidOfPlayerSittingOnYou");
            escortingPlayerIsClimbing();
        end;

        CharScope.setConnectionsAndThreads("EscortPlayer");
        print("DEBUG2 - 4");

        if p57 and not u10.invokeTraffic.escortPlayer then
            local v59 = u10.invokeServerTraffic("escortPlayer", p57, u58);
            print("DEBUG2 - 5", p57, u58, "        ", v59);

            if v59 == true then
                u53 = p57;
                u4.canEquipSlot(false);
                u1.lockEmotes("escortPlayer", true);

                if EscortTypes[p57]:FindFirstChild("EscortAnimation") then
                    u10.animationBuffer(Animator, "load", EscortTypes[p57].EscortAnimation);
                    u10.animationBuffer(Animator, "get", "EscortAnimation").Priority = Enum.AnimationPriority.Action2;
                    u10.animationBuffer(Animator, "play", "EscortAnimation");
                end;

                u1.setCharRotType("escortPlayer", {
                    priority = 2,
                    client = 0,
                    server = 0
                });
                CharScope.addThreadOrCleanUpFunction("EscortPlayer", u1.putInVehicleThirdPartyPrompt("Escorted", u58));
                local InstanceAttributeChangedSignal, v61 = u10.getInstanceAttributeChangedSignal(u58, "EscortedBy", function(p60) -- Line: 391
                    -- upvalues: LocalPlayer (ref), u1 (ref)
                    if p60 ~= LocalPlayer then
                        u1.escortPlayer();
                    end;
                end);
                CharScope.buildSignalData("EscortPlayer", unpack(InstanceAttributeChangedSignal));
                CharScope.addThreadOrCleanUpFunction("EscortPlayer", v61);
                CharScope.addThreadOrCleanUpFunction("EscortPlayer", CharScope.taskDefer(function() -- Line: 396
                    -- upvalues: Humanoid (ref), u10 (ref), HumanoidRootPart (ref), u56 (ref), escortingPlayerIsClimbing (ref), u58 (copy)
                    while true do
                        if Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
                            local v63 = u10.raycastVisible(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 5, u56, {
                                customRequirements = function(p62) -- Line: 399, Name: customRequirements
                                    if p62.Instance.Transparency == 1 then
                                        p62 = false;
                                    end;

                                    return p62;
                                end
                            });

                            if v63 and v63.Instance.Name == "_Ladder" then
                                escortingPlayerIsClimbing(u58);
                            else
                                escortingPlayerIsClimbing();
                            end;
                        end;

                        task.wait(0.1);
                    end;
                end));
                escortingPlayerIsClimbing(Humanoid:GetState() == Enum.HumanoidStateType.Climbing and u58 and u58 or nil);
                CharScope.buildSignalData("EscortPlayer", { Humanoid.StateChanged, function(p64, p65) -- Line: 412
                        -- upvalues: escortingPlayerIsClimbing (ref), u58 (copy)
                        if p65 == Enum.HumanoidStateType.Climbing then
                            escortingPlayerIsClimbing(u58);

                            return;
                        end;

                        if p64 == Enum.HumanoidStateType.Climbing then
                            escortingPlayerIsClimbing();
                        end;
                    end });

                if u10.isCharLoaded(u58) then
                    local Humanoid2 = u58.Character.Humanoid;
                    Humanoid2.EvaluateStateMachine = false;
                    CharScope.addThreadOrCleanUpFunction("EscortPlayer", function() -- Line: 422
                        -- upvalues: Humanoid2 (copy)
                        if Humanoid2.Parent then
                            Humanoid2.EvaluateStateMachine = true;
                        end;
                    end);
                end;
            elseif u10.typeOf(v59) == "string" then
                u2.notify({
                    color = "red",
                    message = v59
                });
            end;
        end;
    end;

    CharScope.taskDefer(function() -- Line: 429
        -- upvalues: u2 (ref)
        task.wait(1500);

        while true do
            while tick() - u2.lastNotifyTick < 120 do
                task.wait(60);
            end;

            u2.displayTip();
            task.wait(1500);
        end;
    end);

    function u1.getHumanoidDescription() -- Line: 438
        -- upvalues: Humanoid (copy)
        return Humanoid:FindFirstChild("HumanoidDescription") or Humanoid:GetAppliedDescription();
    end;

    local Position3 = ScreenGui.Right.HideGuiTop.PhoneCamera.Position;
    local Children = game.ReplicatedStorage.Gameplay.CameraFilters:GetChildren();
    table.sort(Children, function(p66, p67) -- Line: 445
        return p66.Name < p67.Name;
    end);
    local u68 = {};
    local u69 = u10.raycastParamsNew();
    u69.IgnoreWater = true;

    function u1.activateCinematicCameraSettings(p70, p71, u72, u73, p74) -- Line: 449
        -- upvalues: FullScreenGui (ref), u68 (copy), u2 (ref), CharScope (ref), ScreenGui (copy), Position3 (copy), u69 (copy), u10 (ref), workspace_CurrentCamera (ref), Children (copy), UserInputService (ref)
        local function cleanUp() -- Line: 450
            -- upvalues: FullScreenGui (ref), u68 (ref)
            FullScreenGui.BlackBars.Visible = false;

            for _, v in pairs(u68) do
                v:Destroy();
            end;

            table.clear(u68);
        end;

        u2.activateDepthOfFieldDynamicFocus(false);

        if p70 then
            CharScope.addThreadOrCleanUpFunction(p71, cleanUp);

            if not u2.camEffectData then
                u2.camEffectData = {
                    filter = 0,
                    depthBlur = false,
                    blackBars = false
                };
            end;

            local function blackBars(p75) -- Line: 459
                -- upvalues: u2 (ref), FullScreenGui (ref), u72 (copy), ScreenGui (ref), Position3 (ref)
                if p75 then
                    u2.camEffectData.blackBars = not u2.camEffectData.blackBars;
                end;

                FullScreenGui.BlackBars.Visible = u2.camEffectData.blackBars;
                u72.BlackBarsText.Text = "BLACK BARS (" .. (u2.camEffectData.blackBars and "ON" or "OFF") .. ")";
                ScreenGui.Left.HideGuiBottom.PhoneCamera.Position = UDim2.fromScale(0, u2.camEffectData.blackBars and -1.325 or 0);
                ScreenGui.Right.HideGuiBottom.PhoneCamera.Position = UDim2.fromScale(0, u2.camEffectData.blackBars and -1.325 or 0);
                ScreenGui.Right.HideGuiTop.PhoneCamera.Position = Position3 + UDim2.fromScale(0, u2.camEffectData.blackBars and 1.325 or 0);
            end;

            CharScope.buildSignalData(p71, u2.mouseButton(u72.BlackBars, function() -- Line: 468
                -- upvalues: blackBars (copy)
                blackBars(true);
            end));
            blackBars();
            u69.FilterDescendantsInstances = p74 or {};

            local function depthBlur(p76) -- Line: 474
                -- upvalues: u2 (ref), u10 (ref), workspace_CurrentCamera (ref), u69 (ref), u72 (copy)
                if p76 then
                    u2.camEffectData.depthBlur = not u2.camEffectData.depthBlur;
                end;

                local u77 = 0;
                u2.activateDepthOfFieldDynamicFocus(u2.camEffectData.depthBlur, 0, function() -- Line: 477
                    -- upvalues: u10 (ref), workspace_CurrentCamera (ref), u69 (ref), u77 (ref)
                    local v78 = u10.raycastVisible(workspace_CurrentCamera.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector * 130, u69);
                    u77 = u10.lerp(u77, v78 and (v78.Position - workspace_CurrentCamera.CFrame.Position).Magnitude or 130, 0.07);

                    return workspace_CurrentCamera.CFrame.Position + workspace_CurrentCamera.CFrame.LookVector * (u77 + 3);
                end);
                u72.DepthBlurText.Text = "DEPTH BLUR (" .. (u2.camEffectData.depthBlur and "ON" or "OFF") .. ")";
            end;

            CharScope.buildSignalData(p71, u2.mouseButton(u72.DepthBlur, function() -- Line: 485
                -- upvalues: depthBlur (copy)
                depthBlur(true);
            end));
            depthBlur();

            local function filters(p79) -- Line: 490
                -- upvalues: u2 (ref), Children (ref), u10 (ref), u72 (copy), u68 (ref)
                if p79 then
                    u2.camEffectData.filter = (u2.camEffectData.filter + 1) % (#Children + 1);
                end;

                u10.fitText(u72.FiltersText, "FILTERS (" .. (u2.camEffectData.filter == 0 and "OFF" or (string.upper(Children[u2.camEffectData.filter].Value) or "OFF")) .. ")", 2);

                for _, v in pairs(u68) do
                    v:Destroy();
                end;

                table.clear(u68);

                if u2.camEffectData.filter ~= 0 then
                    for _, child in pairs(Children[u2.camEffectData.filter]:GetChildren()) do
                        local v80 = u10.clone(child);
                        table.insert(u68, v80);
                        v80.Parent = game.Lighting;
                    end;
                end;
            end;

            CharScope.buildSignalData(p71, u2.mouseButton(u72.Filters, function() -- Line: 505
                -- upvalues: filters (copy)
                filters(true);
            end));
            filters();
            CharScope.buildSignalData(p71, { UserInputService.InputBegan, function(p81) -- Line: 510
                    -- upvalues: u2 (ref), depthBlur (copy), blackBars (copy), filters (copy), u73 (copy), u72 (copy)
                    if u2.canPressKey(p81.KeyCode) then
                        if p81.KeyCode == Enum.KeyCode.One then
                            depthBlur(true);

                            return;
                        end;

                        if p81.KeyCode == Enum.KeyCode.Two then
                            blackBars(true);

                            return;
                        end;

                        if p81.KeyCode == Enum.KeyCode.Three then
                            filters(true);

                            return;
                        end;

                        if p81.KeyCode == Enum.KeyCode.Zero and u73 then
                            u72.Visible = not u72.Visible;
                        end;
                    end;
                end });
        end;
    end;

    u1.freecamActive = false;

    function u1.activateFreecamGui(p82) -- Line: 527
        -- upvalues: u1 (ref), CharScope (ref), ScreenGui (copy), u9 (ref), u2 (ref)
        u1.freecamActive = p82;
        CharScope.setConnectionsAndThreads("FreecamScript");
        u1.activateCinematicCameraSettings(p82, "FreecamScript", ScreenGui.Left.HideGuiBottom.FreecamScript, true);
        u9.disabled(p82, "freecam");
        u2.hideGui(p82 and "FreecamScript" or nil);
    end;

    local function updateCircularHudColor(p83, p84, p85) -- Line: 536
        -- upvalues: TweenService (ref)
        if p84 < 0.25 then
            p85 = Color3.fromRGB(225, 48, 51) or p85;
        end;

        p83.Left.ImageLabel.ImageColor3 = p85;
        p83.Right.ImageLabel.ImageColor3 = p85;
        p83.Parent.Outer.ImageColor3 = p85;

        if p84 < p83.Progress.Value then
            p83.Parent.Icon.ImageColor3 = p85;
            TweenService:Create(p83.Parent.Icon, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;
    end;

    local u86 = nil;

    local function swimmingLimitSpeedBugFix(p87) -- Line: 549
        -- upvalues: CharScope (ref), u86 (ref), RunService (ref), HumanoidRootPart (copy), Humanoid (copy), u10 (ref), u13 (copy)
        CharScope.setConnectionsAndThreads("SwimmingLimitSpeedBugFix");

        if u86 then
            u86:Destroy();
            u86 = nil;
        end;

        if p87 then
            CharScope.buildSignalData("SwimmingLimitSpeedBugFix", { RunService.Heartbeat, function(p88) -- Line: 556
                    -- upvalues: HumanoidRootPart (ref), Humanoid (ref), u86 (ref), u10 (ref), u13 (ref)
                    if Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X, 0, HumanoidRootPart.AssemblyLinearVelocity.Z).Magnitude <= Humanoid.WalkSpeed / 1.5 * 1.2 then
                        if u86 then
                            u86.MaxAxesForce = Vector3.new(u86.MaxAxesForce.X - 50000 * p88, 0, u86.MaxAxesForce.Z - 50000 * p88);

                            if u86.MaxAxesForce.X <= 0 then
                                u86:Destroy();
                                u86 = nil;
                            end;
                        end;

                        return;
                    end;

                    if not u86 then
                        u86 = u10.clone(game.ReplicatedStorage.Gameplay.SwimmingLimitSpeedBugFix);
                        u86:SetAttribute("UIATC", true);
                        u86.Attachment0 = u10.getCharAttachment(HumanoidRootPart, "RootAttachment");
                        u86.Parent = u13;
                    end;

                    u86.MaxAxesForce = Vector3.new(u86.MaxAxesForce.X + 100000 * p88, 0, u86.MaxAxesForce.Z + 100000 * p88);
                end });
        end;
    end;

    if not GameRules.disableGuideAndQuests then
        CharScope.taskDefer(function() -- Line: 580
            -- upvalues: u2 (ref), CharScope (ref)
            local function areQuestCompleted() -- Line: 581
                -- upvalues: u2 (ref)
                local v89 = u2.readPlayerData("Quests", "TierReward1") and u2.readPlayerData("Quests", "TierReward2");

                return v89;
            end;

            local v90 = u2.readPlayerData("Quests", "TierReward1") and u2.readPlayerData("Quests", "TierReward2");

            if v90 then
                return;
            end;

            u2.notify({
                custom = "QuestBoard",
                pin = "QuestBoard",

                buttonResult = function() -- Line: 585, Name: buttonResult
                    -- upvalues: u2 (ref)
                    u2.questBoard(true);
                end
            });
            CharScope.addThreadOrCleanUpFunction("Global", function() -- Line: 586
                -- upvalues: u2 (ref)
                u2.removePin("QuestBoard");
            end);

            while true do
                local v91 = u2.readPlayerData("Quests", "TierReward1") and u2.readPlayerData("Quests", "TierReward2");

                if v91 then
                    u2.removePin("QuestBoard");

                    return;
                end;

                task.wait(5);
            end;
        end);
    end;

    local DamageIndicator = ScreenGui.Center.Middle.DamageIndicator;

    function u1.indicateDamageOrigin(p92) -- Line: 602
        -- upvalues: u10 (ref), workspace_CurrentCamera (ref), DamageIndicator (copy), TweenService (ref)
        local v93 = u10.typeOf(p92) == "Instance" and p92.Position;

        if v93 then
            p92 = v93;
        elseif u10.typeOf(p92) ~= "Vector3" then
            p92 = false;
        end;

        if p92 then
            local v94 = u10.smartUnit(p92 - workspace_CurrentCamera.CFrame.Position);
            local v95 = v94:Dot(workspace_CurrentCamera.CFrame.UpVector) > 0;
            DamageIndicator.Rotation = v94:Dot(workspace_CurrentCamera.CFrame.RightVector) * 90 * (v95 and 1 or -1) + (v95 and 0 or -1) * 180;
            DamageIndicator.ImageLabel.ImageTransparency = 0.55;
            TweenService:Create(DamageIndicator.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
        end;
    end;

    local u96 = nil;

    function u1.rotateTowards(p97, p98) -- Line: 615
        -- upvalues: u96 (ref), u1 (ref), u10 (ref), HumanoidRootPart (copy), u13 (copy)
        if not p97 then
            if u96 then
                u1.setCharRotType("rotateTowards");
                u96:Destroy();
                u96 = nil;
            end;

            return;
        end;

        if not u96 then
            if not p98 then
                u1.setCharRotType("rotateTowards", {
                    priority = 4,
                    client = 0,
                    server = 0
                });
            end;

            u96 = u10.clone(game.ReplicatedStorage.Gameplay.RotateTowardsPlayer);
            u96:SetAttribute("UIATC", true);
            u96.Enabled = true;
            u96.Attachment0 = u10.getCharAttachment(HumanoidRootPart, "RootAttachment");
            u96.Parent = HumanoidRootPart;
        end;

        local _, v99, _ = u13.UpperTorso.CFrame:ToOrientation();
        u10.charPivotTo(u13, CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v99, 0));
        local smartUnit = u10.smartUnit;

        if u10.typeOf(p97) == "Instance" then
            p97 = p97:IsA("Attachment") and p97.WorldPosition or (p97.Position or p97);
        end;

        local v100 = smartUnit(p97 - HumanoidRootPart.Position);
        u96.CFrame = CFrame.new() * CFrame.Angles(0, math.atan2(-v100.X, -v100.Z), 0);
    end;

    local Vector3_new_ret = Vector3.new();
    local u101 = {};
    local u102 = {};

    local function updateCameraOffset(u103, u104, p105) -- Line: 643
        -- upvalues: u102 (copy), u10 (ref), u101 (copy), Vector3_new_ret (ref), Humanoid (copy), CharScope (ref)
        if u103 then
            if u102[u103] then
                u10.taskCancel(u102[u103]);
                u102[u103] = nil;
            end;

            local function _(p106) -- Line: 649
                -- upvalues: u101 (ref), u103 (copy), Vector3_new_ret (ref), Humanoid (ref)
                u101[u103] = p106;
                Vector3_new_ret = Vector3.new();

                for _, v in pairs(u101) do
                    Vector3_new_ret = Vector3_new_ret + v;
                end;

                Humanoid.CameraOffset = Vector3_new_ret;
            end;

            if p105 then
                local u107 = u101[u103] or Vector3.new();
                u102[u103] = CharScope.taskSpawn(function() -- Line: 657
                    -- upvalues: u104 (copy), u107 (ref), u101 (ref), u103 (copy), Vector3_new_ret (ref), Humanoid (ref), u102 (ref)
                    local v108 = 0;

                    while (u104 - u107).Magnitude > 0.01 do
                        u107 = u107:Lerp(u104, 1 - 1e-6 ^ v108);
                        u101[u103] = u107;
                        Vector3_new_ret = Vector3.new();

                        for _, v in pairs(u101) do
                            Vector3_new_ret = Vector3_new_ret + v;
                        end;

                        Humanoid.CameraOffset = Vector3_new_ret;
                        v108 = task.wait();
                    end;

                    u102[u103] = nil;
                end);

                return;
            end;

            u101[u103] = u104;
            Vector3_new_ret = Vector3.new();

            for _, v in pairs(u101) do
                Vector3_new_ret = Vector3_new_ret + v;
            end;

            Humanoid.CameraOffset = Vector3_new_ret;
        end;
    end;

    function u1.grabFromVehicleThirdPartyPrompt(p109, u110, p111) -- Line: 671
        -- upvalues: u1 (ref), u2 (ref), u10 (ref), PlayerEvent (ref), HumanoidRootPart (copy)
        u1.grabFromVehicleThirdPartyCase = p109;
        local u112 = game.ReplicatedStorage.Gameplay.Items.GrabFromVehicleThirdParty.MaxActivationDistance + 1;

        return u2.displayProximityPromptOnObjects({
            promptTable = {},
            update = p111,

            promptPreview = function() -- Line: 677, Name: promptPreview
                -- upvalues: u10 (ref)
                return u10.clone(game.ReplicatedStorage.Gameplay.Items.GrabFromVehicleThirdParty);
            end,

            getWorkspaceObject = function(p113) -- Line: 680, Name: getWorkspaceObject
                return p113.Attachment;
            end,

            getTargets = function() -- Line: 681, Name: getTargets
                -- upvalues: u1 (ref), PlayerEvent (ref), HumanoidRootPart (ref), u112 (copy), u10 (ref), u110 (copy)
                local v114 = {};

                if not u1.putInVehicleThirdPartyTarget then
                    for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                        if not child.PrimaryPart then
                            PlayerEvent:FireServer("developmentLogs", "DEBUG 10303", tick() - (u1.DEBUG10303 or 0), #child:GetChildren());
                        end;

                        if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= 100 then
                            local v115 = child;

                            for _, child2 in pairs(child:GetChildren()) do
                                if child2:IsA("Seat") and (child2.Name ~= "DriveSeat" and ((child2.Position - HumanoidRootPart.Position).Magnitude <= u112 and not child2.Attachment.EnterPassenger.Enabled)) then
                                    local v116 = child2;

                                    for _, v in pairs(u10.getLoadedPlayers()) do
                                        local v117 = u10.getVehicleInfo.inVehicle(v);

                                        if v117 and (v117 == v115 and (u10.getInstanceAttribute(v, "Seat") == v116 and u110(v))) then
                                            local Config = require(u10.getOriginalVehicle(v115).Config);

                                            v114[v116] = function(p118) -- Line: 698
                                                -- upvalues: Config (copy), v (copy)
                                                p118.KeyboardKeyCode = Enum.KeyCode[Config.GRAB_FROM_VEHICLE_THIRD_PARTY_PROMPT_KEYCODE or "F"];
                                                p118.Target.Value = v;
                                            end;

                                            break;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;

                return v114;
            end
        });
    end;

    function u1.putInVehicleThirdPartyPrompt(p119, p120) -- Line: 720
        -- upvalues: u1 (ref), u2 (ref), u10 (ref), HumanoidRootPart (copy)
        u1.putInVehicleThirdPartyTarget = p120;
        u1.putInVehicleThirdPartyCase = p119;
        local u121 = game.ReplicatedStorage.Gameplay.Items.PutInVehicleThirdParty.MaxActivationDistance + 5;
        local u125 = u2.displayProximityPromptOnObjects({
            promptTable = {},

            promptPreview = function(p122) -- Line: 726, Name: promptPreview
                -- upvalues: u10 (ref)
                return u10.clone(game.ReplicatedStorage.Gameplay.Items.PutInVehicleThirdParty);
            end,

            getWorkspaceObject = function(p123) -- Line: 729, Name: getWorkspaceObject
                return p123.Attachment;
            end,

            getTargets = function() -- Line: 730, Name: getTargets
                -- upvalues: HumanoidRootPart (ref), u121 (copy)
                local v124 = {};

                for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                    if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= 100 then
                        for _, child2 in pairs(child:GetChildren()) do
                            if child2:IsA("Seat") and (child2.Name ~= "DriveSeat" and ((child2.Position - HumanoidRootPart.Position).Magnitude <= u121 and child2.Attachment.EnterPassenger.Enabled)) then
                                v124[child2] = true;
                            end;
                        end;
                    end;
                end;

                return v124;
            end
        });

        return function() -- Line: 748
            -- upvalues: u125 (copy), u1 (ref)
            u125();
            u1.putInVehicleThirdPartyTarget = nil;
            u1.putInVehicleThirdPartyCase = nil;
        end;
    end;

    local u126 = nil;

    function u1.putInVehicleHeldInjuredMedical(u127) -- Line: 756
        -- upvalues: u126 (ref), CharScope (ref), u10 (ref), u9 (ref), PlayerFunc (ref), u2 (ref), u1 (ref), LocalPlayer (ref)
        if u126 and u126.Parent then
            u126:Destroy();
        end;

        CharScope.setConnectionsAndThreads("PutInVehicleHeldInjuredMedical");

        if u127 then
            local function newVehicle(p128) -- Line: 760
                -- upvalues: u126 (ref), u10 (ref), CharScope (ref), u9 (ref), PlayerFunc (ref), u127 (copy), u2 (ref)
                if p128:FindFirstChild("SeatBack") then
                    if u126 and u126.Parent then
                        u126:Destroy();
                    end;

                    u126 = u10.clone(game.ReplicatedStorage.Gameplay.Missions.Stuff.Interaction);
                    u126.KeyboardKeyCode = Enum.KeyCode.F;
                    u126.ActionText = "Put In";
                    u126.HoldDuration = 1;
                    u126.MaxActivationDistance = 7;
                    u126:SetAttribute("ProximityPrompt", "isPhysicallyOccupied");
                    CharScope.addEntity(u126);
                    u9.triggerListener(u126, function() -- Line: 770
                        -- upvalues: PlayerFunc (ref), u127 (ref), u10 (ref), u2 (ref)
                        local v129 = PlayerFunc:InvokeServer("talkToMission", u127);

                        if u10.typeOf(v129) == "string" then
                            u2.notify({
                                color = "red",
                                message = v129
                            });
                        end;
                    end);
                    u126.Parent = p128.SeatBack.Attachment;
                end;
            end;

            CharScope.buildSignalData("PutInVehicleHeldInjuredMedical", { u127.Destroying, function() -- Line: 777
                    -- upvalues: u1 (ref)
                    u1.putInVehicleHeldInjuredMedical();
                end });
            local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);

            if BelongingVehicle then
                newVehicle(BelongingVehicle);
            end;

            local InstanceAttributeChangedSignal, v130 = u10.getInstanceAttributeChangedSignal(LocalPlayer, "BelongingVehicle", function() -- Line: 782
                -- upvalues: u10 (ref), LocalPlayer (ref), newVehicle (copy)
                local BelongingVehicle2 = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);

                if BelongingVehicle2 then
                    newVehicle(BelongingVehicle2);
                end;
            end);
            CharScope.buildSignalData("PutInVehicleHeldInjuredMedical", unpack(InstanceAttributeChangedSignal));
            CharScope.addThreadOrCleanUpFunction("PutInVehicleHeldInjuredMedical", v130);
        end;
    end;

    local u131 = nil;
    local u132 = nil;
    local CFrame_new_ret = CFrame.new();

    function u1.setCameraRelativeToViewModelPart(p133, p134, p135) -- Line: 795
        -- upvalues: u2 (ref), u25 (copy), u132 (ref), u131 (ref), CFrame_new_ret (ref), u1 (ref)
        local v136 = p133 == "Item" and u2.customRightGrip.Part1 or u25[p133];

        if p135 and u132 ~= v136 then
            u131 = u131 * u132.CFrame:ToObjectSpace(v136.CFrame);
        end;

        CFrame_new_ret = p134:Inverse();
        u132 = v136;

        if not p135 then
            u131 = CFrame_new_ret - (u1.firstPerson and Vector3.new(0, 3, 0) or Vector3.new());
        end;
    end;

    u1.setCameraRelativeToViewModelPart("HumanoidRootPart", CFrame.new(0, 1.7, 0));
    u1.onToolEquippedWhenFirstPerson = nil;
    u1.updateToolSwayFirstPerson = nil;
    u1.gunRecoilFirstPerson = nil;
    local u137 = DampedSpring.new(Vector3.new(), Vector3.new(), Vector3.new(), 15, 0.5);
    local u138 = DampedSpring.new(Vector3.new(), Vector3.new(), Vector3.new(), 10, 1);

    local function activateFirstPerson(p139) -- Line: 848
        -- upvalues: CharScope (ref), u1 (ref), u20 (ref), u2 (ref), u25 (copy), GameRules (ref), RunService (ref), CFrame_new_ret (ref), u131 (ref), Humanoid (copy), u137 (copy), u21 (ref), u10 (ref), workspace_CurrentCamera (ref), u138 (copy), u4 (ref), u132 (ref), u29 (copy), Animator (copy), u13 (copy)
        CharScope.setConnectionsAndThreads("FirstPerson");
        u1.firstPerson = p139;
        u1.updateStrafing();
        u20();
        u2.activateMouseIcon();
        u25.Parent = p139 and workspace.Gameplay.Entities or game.ReplicatedStorage.Gameplay.Entities;
        u1.onToolEquippedWhenFirstPerson = nil;
        u1.updateToolSwayFirstPerson = nil;
        u1.gunRecoilFirstPerson = nil;

        if p139 then
            local u140 = false;

            if GameRules.firstPersonMoveTestMode then
                CharScope.buildSignalData("FirstPerson", { RunService.RenderStepped, function(p141) -- Line: 870
                        -- upvalues: CFrame_new_ret (ref), GameRules (ref)
                        CFrame_new_ret = GameRules.firstPersonMoveTestMode.Part.Attachment.CFrame:Inverse();
                    end });
            end;

            function u1.gunRecoilFirstPerson(p142) -- Line: 874
                -- upvalues: u131 (ref)
                local CFrame_new_ret2 = CFrame.new(0, 0, -p142 * 0.15);
                local CFrame_Angles_ret = CFrame.Angles(-math.rad(p142 * 2.5), 0, 0);
                local CFrame_Angles = CFrame.Angles;
                local v143 = (math.random() - 0.5) * p142 * 1.5;
                local v144 = CFrame_Angles(0, math.rad(v143), 0);
                local CFrame_Angles2 = CFrame.Angles;
                local v145 = (math.random() - 0.5) * p142 * 0.75;
                local v146 = CFrame_Angles2(0, 0, (math.rad(v145)));
                u131 = (CFrame_new_ret2 * CFrame_Angles_ret * v144 * v146):Inverse() * u131;
            end;

            function u1.onToolEquippedWhenFirstPerson(p147) -- Line: 893
                -- upvalues: u140 (ref), Humanoid (ref)
                u140 = p147 and true or false;

                if p147 then
                    for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
                        local WeightTarget = v.WeightTarget;
                        v:AdjustWeight(9999);
                        v:AdjustWeight(WeightTarget);
                    end;
                end;
            end;

            function u1.updateToolSwayFirstPerson(p148) -- Line: 909
                -- upvalues: u2 (ref), u137 (ref)
                local v149 = u2.getMouseProperty.delta("FreeSpace");
                local v150 = math.clamp(v149.X, -30, 30) * 0.15;
                local math_rad_ret = math.rad(v150);
                local v151 = math.clamp(v149.Y, -30, 30) * 0.15;
                local math_rad_ret2 = math.rad(v151);
                u137.target = Vector3.new(math_rad_ret, math_rad_ret2, 0);
            end;

            local u152 = 0;
            u21 = 0;
            CharScope.buildSignalData("FirstPerson", { RunService.RenderStepped, function(p153) -- Line: 915
                    -- upvalues: u21 (ref), u10 (ref), u152 (ref), workspace_CurrentCamera (ref), u1 (ref), Humanoid (ref), u138 (ref), u4 (ref), u137 (ref), u131 (ref), CFrame_new_ret (ref), u132 (ref), u29 (ref)
                    if math.abs(u21) > 0.00001 then
                        u21 = u10.lerp(u21, 0, 1 - 0.00002 ^ p153);
                        local v154 = u10.lerp(u152, u21, 1 - 0.00002 ^ p153);
                        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles(v154 - u152, 0, 0);
                        u152 = v154;
                    end;

                    if u1.firstPersonHeightRestriction then
                        local v155, v156, v157 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();
                        local math_deg_ret = math.deg(v155);
                        local math_clamp_ret = math.clamp(math_deg_ret, u1.firstPersonHeightRestriction[1], u1.firstPersonHeightRestriction[2]);
                        workspace_CurrentCamera.CFrame = CFrame.new(workspace_CurrentCamera.CFrame.Position) * CFrame.fromEulerAnglesYXZ(math.rad(math_clamp_ret), v156, v157);
                    end;

                    local v158 = Humanoid.WalkSpeed * 0.8;
                    local v159 = tick();
                    local v160;

                    if Humanoid.moveDirection == Vector3.new() then
                        v160 = Vector3.new();
                    else
                        local math_sin_ret = math.sin(v159 * 0.7 * v158);
                        local math_sin_ret2 = math.sin(v159 * v158);
                        v160 = Vector3.new(math_sin_ret, math_sin_ret2, 0) * (v158 - 10) * (u1.humanoidState <= 1 and 0.002 or (u4.isAiming and 0.02 or 0.05)) or Vector3.new();
                    end;

                    u138.target = v160;
                    u137:update(p153);
                    u138:update(p153);
                    u131 = (u131 or CFrame.new()):Lerp(CFrame_new_ret, 1 - 1e-6 ^ p153);
                    u132.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles(u137.p.y, u137.p.x, 0) * CFrame.new(u138.p) * CFrame.Angles(u152 * 2, 0, 0) * u131;

                    for i, v in pairs(u29) do
                        i.Transform = v.Transform;
                    end;
                end });
            local u161 = {
                Equip = true
            };

            local function stopAnim(p162) -- Line: 952
                -- upvalues: u161 (copy)
                if u161[p162.Animation.Name] then
                    p162:Stop();
                end;
            end;

            for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
                if u161[v.Animation.Name] then
                    v:Stop();
                end;
            end;

            CharScope.buildSignalData("FirstPerson", { Animator.AnimationPlayed, stopAnim });
        end;

        local v163 = u4.equippedItem or u4.specialItem;

        if v163 then
            if p139 then
                u1.onToolEquippedWhenFirstPerson(v163);
            end;

            u10.gripTheItem(u2.customRightGrip, p139 and u25 or u13, v163);
        end;
    end;

    u2.debugLoadingClient("Character 2");
    u1.charRotType = nil;
    local u164 = {};

    function u1.setCharRotType(p165, p166) -- Line: 971
        -- upvalues: u164 (copy), u1 (ref), PlayerEvent (ref)
        if p165 then
            u164[p165] = p166 or nil;
        end;

        local v167 = nil;

        for _, v in pairs(u164) do
            if v.priority > (v167 and (v167.priority or 0) or 0) then
                v167 = v;
            end;
        end;

        u1.charRotType = v167 and (v167.client or 4) or 4;
        PlayerEvent:FireServer("charRotType", v167 and v167.server or 2);
    end;

    u1.setCharRotType();
    u1.charRotXMultiplier = 1;
    local Vector2_new_ret = Vector2.new();
    local u168, u169 = u2.initiateIdleAnimationCFrame().loadMotors(u13);
    local u170 = 0;
    CharScope.buildSignalData("Global", { RunService.Stepped, function(p171, p172) -- Line: 990
            -- upvalues: u1 (ref), u169 (copy), Vector2_new_ret (ref), HumanoidRootPart (copy), workspace_CurrentCamera (ref), u2 (ref), Animator (copy), u168 (copy), UserInputService (ref), activateFirstPerson (copy), u170 (ref), u10 (ref), u101 (copy), u102 (copy), Vector3_new_ret (ref), Humanoid (copy), CharScope (ref), u20 (ref), u25 (copy), u4 (ref), u13 (copy)
            local v173 = not u1.firstPerson and u169(p172);

            if u1.charRotType > 0 and v173 then
                Vector2_new_ret = Vector2_new_ret:Lerp(Vector2.new(HumanoidRootPart.CFrame.UpVector:Dot(workspace_CurrentCamera.CFrame.LookVector) * u1.charRotXMultiplier, HumanoidRootPart.CFrame.RightVector:Dot(workspace_CurrentCamera.CFrame.LookVector)), 1 - 5e-10 ^ p172);
            elseif Vector2_new_ret ~= Vector2.new() then
                Vector2_new_ret = Vector2.new();
            end;

            u2.adjustBodyAngle(Animator, u168, u1.firstPerson and Vector2.new() or Vector2_new_ret, u1.charRotType);

            if (workspace_CurrentCamera.Focus.Position - workspace_CurrentCamera.CFrame.Position).Magnitude >= 0.99 or u1.freecamActive then
                if u101.firstPerson then
                    if u102.firstPerson then
                        u10.taskCancel(u102.firstPerson);
                        u102.firstPerson = nil;
                    end;

                    local u174 = "firstPerson";

                    local function _(p175) -- Line: 649
                        -- upvalues: u101 (ref), u174 (copy), Vector3_new_ret (ref), Humanoid (ref)
                        u101[u174] = p175;
                        Vector3_new_ret = Vector3.new();

                        for _, v in pairs(u101) do
                            Vector3_new_ret = Vector3_new_ret + v;
                        end;

                        Humanoid.CameraOffset = Vector3_new_ret;
                    end;

                    u101.firstPerson = nil;
                    Vector3_new_ret = Vector3.new();

                    for _, v in pairs(u101) do
                        Vector3_new_ret = Vector3_new_ret + v;
                    end;

                    Humanoid.CameraOffset = Vector3_new_ret;

                    if u1.firstPerson then
                        CharScope.setConnectionsAndThreads("FirstPerson");
                        u1.firstPerson = false;
                        u1.updateStrafing();
                        u20();
                        u2.activateMouseIcon();
                        u25.Parent = game.ReplicatedStorage.Gameplay.Entities;
                        u1.onToolEquippedWhenFirstPerson = nil;
                        u1.updateToolSwayFirstPerson = nil;
                        u1.gunRecoilFirstPerson = nil;
                        local v176 = u4.equippedItem or u4.specialItem;

                        if v176 then
                            u10.gripTheItem(u2.customRightGrip, u13, v176);
                        end;
                    end;
                end;

                return;
            end;

            if u2.isMouseFirstPersonUnlocked and UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not u1.firstPerson then
                activateFirstPerson(true);
            end;

            u170 = u10.lerp(u170, u1.humanoidState == 0 and -1 or 0, u101.firstPerson and 0.1 or 1);
            local Vector3_new_ret2 = Vector3.new(0, u170, 0);

            if u102.firstPerson then
                u10.taskCancel(u102.firstPerson);
                u102.firstPerson = nil;
            end;

            local u177 = "firstPerson";

            local function _(p178) -- Line: 649
                -- upvalues: u101 (ref), u177 (copy), Vector3_new_ret (ref), Humanoid (ref)
                u101[u177] = p178;
                Vector3_new_ret = Vector3.new();

                for _, v in pairs(u101) do
                    Vector3_new_ret = Vector3_new_ret + v;
                end;

                Humanoid.CameraOffset = Vector3_new_ret;
            end;

            u101.firstPerson = Vector3_new_ret2;
            Vector3_new_ret = Vector3.new();

            for _, v in pairs(u101) do
                Vector3_new_ret = Vector3_new_ret + v;
            end;

            Humanoid.CameraOffset = Vector3_new_ret;
        end });
    local u179 = nil;
    CharScope.taskDefer(function() -- Line: 1022
        -- upvalues: Vector2_new_ret (ref), u179 (ref), UnreliableEvent (ref)
        while true do
            local Vector2_new_ret2 = Vector2.new(math.round(Vector2_new_ret.X * 100), (math.round(Vector2_new_ret.Y * 100)));

            if u179 ~= Vector2_new_ret2 then
                u179 = Vector2_new_ret2;
                UnreliableEvent:FireServer("charRot", Vector2_new_ret2);
            end;

            task.wait(0.1);
        end;
    end);
    local Payment = ScreenGui.Center.Middle.Payment;
    local u180 = 1;
    local u181 = false;

    function u1.payment(p182, u183, u184, u185, u186, u187) -- Line: 1037
        -- upvalues: u180 (ref), CharScope (ref), u9 (ref), Payment (copy), u10 (ref), u2 (ref), u181 (ref), u1 (ref)
        u180 = (u180 + 1) % 100;
        CharScope.setConnectionsAndThreads("Payment");
        u9.disabled(p182, "payment");

        if p182 then
            local function costFunc(p188) -- Line: 1042
                -- upvalues: Payment (ref), u10 (ref)
                Payment.Cost.Text = (p188 > 0 and "+" or "-") .. "＄" .. u10.commaValue((math.abs(p188)));
            end;

            CharScope.buildSignalData("Payment", u2.mouseButton(Payment.Cancel, function() -- Line: 1046
                -- upvalues: u181 (ref), u186 (copy), u185 (copy), Payment (ref), u1 (ref)
                if not u181 then
                    u186(true, nil, u185 and Payment.Multiple.Quantity.Value or nil);
                    u1.payment();
                end;
            end));
            Payment.Headline.Text = p182;
            Payment.Headline.TextColor3 = u184 > 0 and Color3.fromRGB(135, 92, 92) or Color3.fromRGB(100, 100, 100);
            Payment.Cost.Text = (u184 > 0 and "+" or "-") .. "＄" .. u10.commaValue((math.abs(u184)));
            Payment.Multiple.Visible = u185;
            Payment.Single.Visible = not u185;

            if u185 then
                Payment.Multiple.Quantity.Value = 1;
                u10.fitText(Payment.Multiple.Transaction, u183 .. " x1", 2);
            else
                u10.fitText(Payment.Single.Transaction, u183, 2);
            end;

            local function run() -- Line: 1063
                -- upvalues: Payment (ref), u184 (copy), CharScope (ref), u2 (ref), u181 (ref), u180 (ref), u1 (ref), u10 (ref), u186 (copy), u185 (copy), u183 (copy)
                Payment.Confirm.ImageColor3 = Color3.fromRGB(114, 140, 173);
                Payment.Confirm.TextLabel.Text = u184 > 0 and "Sell" or "Purchase";
                CharScope.buildSignalData("Payment", u2.mouseButton(Payment.Confirm, function() -- Line: 1066
                    -- upvalues: u181 (ref), u180 (ref), u2 (ref), u1 (ref), u10 (ref), u186 (ref), u185 (ref), Payment (ref)
                    if not u181 then
                        u181 = true;
                        local u189 = u180;
                        u186(false, function(p190, p191) -- Line: 1070, Name: completeFunc
                            -- upvalues: u2 (ref), u189 (copy), u180 (ref), u1 (ref), u10 (ref)
                            if p191 then
                                if p190 then
                                    u2.notify({
                                        color = "green",
                                        message = p190
                                    });
                                end;

                                if u189 == u180 then
                                    u1.payment();

                                    return true;
                                end;
                            elseif u10.typeOf(p190) == "string" then
                                u2.notify({
                                    color = "red",
                                    message = p190
                                });
                            end;
                        end, u185 and Payment.Multiple.Quantity.Value or nil);
                        u181 = false;
                    end;
                end));

                if u185 then
                    local function changeQuantity(p192) -- Line: 1084
                        -- upvalues: Payment (ref), u10 (ref), u185 (ref), u183 (ref), u184 (ref)
                        local Quantity = Payment.Multiple.Quantity;
                        local v193 = Payment.Multiple.Quantity.Value + p192;
                        local v194 = u10.typeOf(u185) == "number" and (u185 or 100) or 100;
                        Quantity.Value = math.clamp(v193, 1, v194);
                        Payment.Multiple.Transaction.Text = u183 .. " x" .. Payment.Multiple.Quantity.Value;
                        local math_round_ret = math.round(u184 * Payment.Multiple.Quantity.Value);
                        Payment.Cost.Text = (math_round_ret > 0 and "+" or "-") .. "＄" .. u10.commaValue((math.abs(math_round_ret)));
                    end;

                    local function holdChangeQuantity(p195) -- Line: 1089
                        -- upvalues: u2 (ref), Payment (ref), changeQuantity (copy)
                        local v196 = 0.5;

                        while u2.isMouseButton1Pressed() and Payment.Visible do
                            if v196 <= 0 then
                                changeQuantity(p195);
                            end;

                            v196 = v196 - task.wait(0.03);
                        end;
                    end;

                    CharScope.buildSignalData("Payment", u2.mouseButton(Payment.Multiple.Add, function() -- Line: 1096
                        -- upvalues: changeQuantity (copy), holdChangeQuantity (copy)
                        changeQuantity(1);
                        holdChangeQuantity(1);
                    end));
                    CharScope.buildSignalData("Payment", u2.mouseButton(Payment.Multiple.Substract, function() -- Line: 1097
                        -- upvalues: changeQuantity (copy), holdChangeQuantity (copy)
                        changeQuantity(-1);
                        holdChangeQuantity(-1);
                    end));
                end;

                CharScope.buildSignalData("Payment", u10.buttonHoverSignalData(Payment.Multiple.Add));
                CharScope.buildSignalData("Payment", u10.buttonHoverSignalData(Payment.Multiple.Substract));
                CharScope.buildSignalData("Payment", u10.buttonHoverSignalData(Payment.Cancel));
                CharScope.buildSignalData("Payment", u10.buttonHoverSignalData(Payment.Confirm));
            end;

            if u187 then
                Payment.Confirm.ImageColor3 = Color3.fromRGB(117, 117, 117);
                CharScope.addThreadOrCleanUpFunction("Payment", CharScope.taskSpawn(function() -- Line: 1108
                    -- upvalues: u187 (ref), Payment (ref), run (copy)
                    while u187 > 0 do
                        Payment.Confirm.TextLabel.Text = "Wait " .. u187 .. (u187 <= 1 and " Second" or " Seconds");
                        u187 = u187 - 1;
                        task.wait(1);
                    end;

                    run();
                end));
            else
                run();
            end;
        end;

        u10.guiTransition(Payment, "Size", 0.9, p182);
    end;

    local StalkPlayer = GlobalGui.Center.HideGuiBottom.StalkPlayer;

    local function setCamStalkPlayer(p197) -- Line: 1123
        -- upvalues: CharScope (ref), u10 (ref), PlayerEvent (ref), u2 (ref), Chat (copy), StalkPlayer (copy), setCamStalkPlayer (copy)
        CharScope.setConnectionsAndThreads("StalkPlayerCam");
        u10.setCameraProperties("10", p197 and {
            CameraSubject = p197
        });
        PlayerEvent:FireServer("stalkPlayer", p197);

        if p197 then
            u2.hideGui("StalkPlayer", { u2.notificationsGui, u2.notificationsGuiLowDisplayOrder, Chat });
            local PlayerFromCharacter = u10.getPlayerFromCharacter(p197);
            StalkPlayer.Username.Text = p197.Name;
            StalkPlayer.UserId.Text = PlayerFromCharacter and (PlayerFromCharacter.UserId or "") or "";

            if PlayerFromCharacter then
                CharScope.buildSignalData("StalkPlayerCam", { PlayerFromCharacter.CharacterAdded, function(p198) -- Line: 1133
                        -- upvalues: setCamStalkPlayer (ref)
                        setCamStalkPlayer(p198);
                    end });
            end;
        else
            u2.hideGui();
        end;
    end;

    function u1.stalkPlayer(u199) -- Line: 1141
        -- upvalues: setCamStalkPlayer (copy), CharScope (ref), u10 (ref), UserInputService (ref), u2 (ref), StalkPlayer (copy), u1 (ref)
        setCamStalkPlayer();
        CharScope.setConnectionsAndThreads("StalkPlayer");
        u10.contextAction("UnbindAction", "StalkPlayer");

        if u199 then
            local function getCharacters() -- Line: 1146
                local Children2 = workspace.Characters:GetChildren();
                table.sort(Children2, function(p200, p201) -- Line: 1148
                    return p200.Name < p201.Name;
                end);

                return Children2;
            end;

            local u202 = 1;

            local function getNextCharacter(p203) -- Line: 1152
                -- upvalues: u199 (ref), u202 (ref)
                local Children2 = workspace.Characters:GetChildren();
                table.sort(Children2, function(p204, p205) -- Line: 1148
                    return p204.Name < p205.Name;
                end);

                for i, v in pairs(Children2) do
                    if v == u199 then
                        u202 = i;
                    end;
                end;

                return Children2[(u202 + p203 - 1) % #Children2 + 1];
            end;

            setCamStalkPlayer(u199);
            u10.contextAction("BindActionAtPriority", "StalkPlayer", function() -- Line: 1159
                return Enum.ContextActionResult.Sink;
            end, false, Enum.ContextActionPriority.High.Value + 1, Enum.KeyCode.Left, Enum.KeyCode.Right);
            CharScope.buildSignalData("StalkPlayer", { UserInputService.InputBegan, function(p206) -- Line: 1160
                    -- upvalues: u2 (ref), u199 (ref), u202 (ref), setCamStalkPlayer (ref)
                    if u2.canPressKey(p206.KeyCode) then
                        if p206.KeyCode == Enum.KeyCode.A or p206.KeyCode == Enum.KeyCode.Left then
                            local Children2 = workspace.Characters:GetChildren();
                            table.sort(Children2, function(p207, p208) -- Line: 1148
                                return p207.Name < p208.Name;
                            end);

                            for i, v in pairs(Children2) do
                                if v == u199 then
                                    u202 = i;
                                end;
                            end;

                            u199 = Children2[(u202 + -1 - 1) % #Children2 + 1];
                            setCamStalkPlayer(u199);

                            return;
                        end;

                        if p206.KeyCode == Enum.KeyCode.D or p206.KeyCode == Enum.KeyCode.Right then
                            local Children2 = workspace.Characters:GetChildren();
                            table.sort(Children2, function(p209, p210) -- Line: 1148
                                return p209.Name < p210.Name;
                            end);

                            for i, v in pairs(Children2) do
                                if v == u199 then
                                    u202 = i;
                                end;
                            end;

                            u199 = Children2[(u202 + 1 - 1) % #Children2 + 1];
                            setCamStalkPlayer(u199);
                        end;
                    end;
                end });
            CharScope.buildSignalData("StalkPlayer", u10.buttonHoverSignalData(StalkPlayer.Left));
            CharScope.buildSignalData("StalkPlayer", u2.mouseButton(StalkPlayer.Left, function() -- Line: 1172
                -- upvalues: u199 (ref), u202 (ref), setCamStalkPlayer (ref)
                local Children2 = workspace.Characters:GetChildren();
                table.sort(Children2, function(p211, p212) -- Line: 1148
                    return p211.Name < p212.Name;
                end);

                for i, v in pairs(Children2) do
                    if v == u199 then
                        u202 = i;
                    end;
                end;

                u199 = Children2[(u202 + -1 - 1) % #Children2 + 1];
                setCamStalkPlayer(u199);
            end));
            CharScope.buildSignalData("StalkPlayer", u10.buttonHoverSignalData(StalkPlayer.Right));
            CharScope.buildSignalData("StalkPlayer", u2.mouseButton(StalkPlayer.Right, function() -- Line: 1177
                -- upvalues: u199 (ref), u202 (ref), setCamStalkPlayer (ref)
                local Children2 = workspace.Characters:GetChildren();
                table.sort(Children2, function(p213, p214) -- Line: 1148
                    return p213.Name < p214.Name;
                end);

                for i, v in pairs(Children2) do
                    if v == u199 then
                        u202 = i;
                    end;
                end;

                u199 = Children2[(u202 + 1 - 1) % #Children2 + 1];
                setCamStalkPlayer(u199);
            end));
            CharScope.buildSignalData("StalkPlayer", u10.buttonHoverSignalData(StalkPlayer.Exit));
            CharScope.buildSignalData("StalkPlayer", u2.mouseButton(StalkPlayer.Exit, function() -- Line: 1182
                -- upvalues: u1 (ref)
                u1.stalkPlayer();
            end));
        end;
    end;

    local BigText = ScreenGui.Center.Middle.BigText;

    function u1.bigTextAnimation(p215, p216, p217) -- Line: 1191
        -- upvalues: BigText (copy), TweenService (ref)
        BigText.Message.Text = p215;
        BigText.Message.TextColor3 = p217 or Color3.fromRGB(255, 255, 255);
        BigText.Shadow.Text = p215;
        BigText.Size = UDim2.fromScale(p216, p216);
        BigText.Message.TextTransparency = 1;
        BigText.Shadow.TextTransparency = 1;
        TweenService:Create(BigText, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(p216 * 0.66, p216 * 0.66)
        }):Play();
        TweenService:Create(BigText.Message, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
        TweenService:Create(BigText.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0.5
        }):Play();
        task.wait(1);
        TweenService:Create(BigText.Message, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
        TweenService:Create(BigText.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
    end;

    local RobberyVaultOpen = ScreenGui.Center.Bottom.RobberyVaultOpen;
    local u218 = false;

    function u1.robberyVaultTimer(p219, u220, u221) -- Line: 1210
        -- upvalues: LocalPlayer (ref), CharScope (ref), u218 (ref), RobberyVaultOpen (copy), u10 (ref), HumanoidRootPart (copy)
        if p219 and p219.Players:FindFirstChild(LocalPlayer.Name) then
            local u222 = CharScope.setConnectionsAndThreads();

            local function visibility(p223) -- Line: 1213
                -- upvalues: u218 (ref), u222 (copy), RobberyVaultOpen (ref)
                u218 = p223 and u222 or false;
                RobberyVaultOpen.Visible = p223;
            end;

            local function v224() -- Line: 1217
                -- upvalues: u218 (ref), u222 (copy), RobberyVaultOpen (ref), CharScope (ref)
                if u218 == u222 then
                    u218 = false;
                    RobberyVaultOpen.Visible = false;
                end;

                CharScope.clearConnectionsAndThreads(u222);
            end;

            CharScope.addThreadOrCleanUpFunction(u222, CharScope.taskDefer(function() -- Line: 1221
                -- upvalues: u220 (copy), u10 (ref), u221 (copy), HumanoidRootPart (ref), u218 (ref), u222 (copy), RobberyVaultOpen (ref), CharScope (ref)
                while true do
                    local v225 = u220 - 1 - u10.getDistributedGameTime();
                    local math_ceil_ret = math.ceil(v225);
                    local v226 = (u221 - HumanoidRootPart.Position).Magnitude < 400;

                    if not u218 and v226 then
                        u218 = u222 or false;
                        RobberyVaultOpen.Visible = true;
                    end;

                    if u218 == u222 then
                        if v226 then
                            RobberyVaultOpen.TextLabel.Text = "VAULT WILL CLOSE IN: " .. u10.timerFormat((math.max(0, math_ceil_ret)));
                        else
                            u218 = false;
                            RobberyVaultOpen.Visible = false;
                        end;
                    end;

                    task.wait(1);

                    if math_ceil_ret <= 0 then
                        if u218 == u222 then
                            u218 = false;
                            RobberyVaultOpen.Visible = false;
                        end;

                        CharScope.clearConnectionsAndThreads(u222);

                        return;
                    end;
                end;
            end));
            CharScope.buildSignalData(u222, { p219.Destroying, v224 });
            CharScope.buildSignalData(u222, { p219.Players[LocalPlayer.Name].Destroying, v224 });
        end;
    end;

    local u227 = {};
    local u228 = 1;

    local function selectionWheelSystem(u229, u230, ...) -- Line: 1245
        -- upvalues: CharScope (ref), u228 (ref), u1 (ref), u227 (copy), u10 (ref), u2 (ref), UserInputService (ref)
        local v231 = ...;
        local v232 = v231 and { ... };
        CharScope.setConnectionsAndThreads("SelectionWheel");
        u228 = (u228 + 1) % 100;
        local u233 = u228;
        u1.selectionWheelUserNumberInput = nil;

        if v232 then
            if u230.mouseLeave then
                u230.mouseLeave();
            end;

            for _, child in pairs(u229.Slots:GetChildren()) do
                if child.Visible then
                    child:Destroy();
                end;
            end;

            local u234 = {};

            for _, v in pairs(v232) do
                table.insert(u234, v);
            end;

            local u235 = u230.minRadius or 0;
            local u236 = nil;
            local u237 = nil;

            for i, v in pairs(u234) do
                v.id = i;
                local v238 = u230.createButton(v);
                v238.Name = i;
                v238.Visible = true;
                local v239 = i / #u234 * 360;
                v238.Position = UDim2.fromScale(u230.radius * math.cos(v239 * 3.141592653589793 / 180) + 0.5, u230.radius * math.sin(v239 * 3.141592653589793 / 180) + 0.5);
                v238.Parent = u229.Slots;
            end;

            local function execute() -- Line: 1271
                -- upvalues: u236 (ref), u230 (copy), u227 (ref), u234 (ref)
                if u236.close then
                    u230.close();
                else
                    table.insert(u227, u234);
                end;

                if u236.call then
                    u236.call();
                end;
            end;

            local function clicked() -- Line: 1275
                -- upvalues: u236 (ref), u10 (ref), u229 (copy), u230 (copy), u227 (ref), u234 (ref)
                if u236 and u10.isInFrame(u229, true, true) then
                    if u236.close then
                        u230.close();
                    else
                        table.insert(u227, u234);
                    end;

                    if u236.call then
                        u236.call();
                    end;
                end;
            end;

            local u242 = u230.buttonHoldEvent and function() -- Line: 1282, Name: holdEvent
                -- upvalues: u236 (ref), u10 (ref), u229 (copy), u230 (copy), u233 (copy), u228 (ref), u2 (ref)
                if u236 and (u10.isInFrame(u229, true) and u230.buttonHoldEvent) then
                    local v240 = u236;
                    local v241 = tick() + 1;

                    while u233 == u228 and u2.isMouseButton1Pressed() do
                        if v241 < tick() then
                            if v240 == u236 then
                                u230.buttonHoldEvent(u236);
                            end;

                            return true;
                        end;

                        task.wait();
                    end;
                end;
            end or nil;

            local function mouseMoved(p243) -- Line: 1298
                -- upvalues: u10 (ref), u236 (ref), u229 (copy), u2 (ref), u235 (copy), u234 (ref), u237 (ref), u230 (copy)
                local v244 = 200;
                local MousePos = u10.getMousePos();
                u236 = nil;

                if u10.isInFrame(u229, true) and (not p243 or u2.platform ~= "Mobile") and u235 < (MousePos - u229.AbsolutePosition - u229.AbsoluteSize / 2).Magnitude / u229.AbsoluteSize.X then
                    for _, v in pairs(u234) do
                        local Magnitude = (MousePos - u229.Slots[v.id].AbsolutePosition - u229.Slots[v.id].AbsoluteSize / 2).Magnitude;

                        if Magnitude < v244 then
                            u236 = v;
                            v244 = Magnitude;
                        end;
                    end;
                end;

                if u236 then
                    if u236 ~= u237 then
                        if not u229.Selection.Visible then
                            u229.Selection.Visible = true;
                            u229.Selection.Rotation = u236.id / #u234 * 360;
                        end;

                        if u237 then
                            if u230.mouseLeave then
                                u230.mouseLeave(u237);
                            end;

                            u237 = nil;
                        end;

                        if u230.mouseEnter then
                            u230.mouseEnter(u236);
                        end;

                        u237 = u236;
                    end;
                elseif u229.Selection.Visible then
                    u229.Selection.Visible = false;

                    if u237 then
                        if u230.mouseLeave then
                            u230.mouseLeave(u237);
                        end;

                        u237 = nil;
                    end;
                end;
            end;

            CharScope.buildSignalData("SelectionWheel", { UserInputService.InputBegan, function(p245) -- Line: 1339
                    -- upvalues: u2 (ref), u229 (copy), mouseMoved (copy), u242 (ref), CharScope (ref), u236 (ref), u10 (ref), u230 (copy), u227 (ref), u234 (ref), u1 (ref)
                    if p245.UserInputType ~= Enum.UserInputType.Touch then
                        if p245.UserInputType == Enum.UserInputType.MouseButton1 then
                            if u2.isMouseObstructedByBlackBackground(u229.ZIndex) then
                                return;
                            end;

                            if u242 and u242() then
                                return;
                            end;

                            if u236 and u10.isInFrame(u229, true, true) then
                                if u236.close then
                                    u230.close();
                                else
                                    table.insert(u227, u234);
                                end;

                                if u236.call then
                                    u236.call();

                                    return;
                                end;
                            end;
                        elseif p245.UserInputType == Enum.UserInputType.MouseButton2 and not u10.isTableEmpty(u227) then
                            local v246 = u227[#u227];
                            table.remove(u227, #u227);
                            u1.activateSelectionWheel(unpack(v246));
                        end;

                        return;
                    end;

                    if u2.isMouseObstructedByBlackBackground(u229.ZIndex) then
                        return;
                    end;

                    mouseMoved();
                    local u247 = false;

                    if u242 then
                        CharScope.taskSpawn(function() -- Line: 1345
                            -- upvalues: u242 (ref), u247 (ref)
                            if u242() then
                                u247 = true;
                            end;
                        end);
                    end;

                    u2.mobileInputServiceClick();

                    if u247 then
                        return;
                    end;

                    if u236 and u10.isInFrame(u229, true, true) then
                        if u236.close then
                            u230.close();
                        else
                            table.insert(u227, u234);
                        end;

                        if u236.call then
                            u236.call();
                        end;
                    end;
                end });

            function u1.selectionWheelUserNumberInput(p248) -- Line: 1360
                -- upvalues: u234 (ref), u236 (ref), u230 (copy), u227 (ref)
                if p248 <= #u234 then
                    u236 = u234[p248];

                    if u236.close then
                        u230.close();
                    else
                        table.insert(u227, u234);
                    end;

                    if u236.call then
                        u236.call();
                    end;
                end;
            end;

            mouseMoved(true);
            CharScope.buildSignalData("SelectionWheel", { UserInputService.InputChanged, function(p249) -- Line: 1367
                    -- upvalues: mouseMoved (copy)
                    if p249.UserInputType == Enum.UserInputType.MouseMovement or p249.UserInputType == Enum.UserInputType.Touch then
                        mouseMoved();
                    end;
                end });
            CharScope.taskSpawn(function() -- Line: 1372
                -- upvalues: u233 (copy), u228 (ref), u236 (ref), u229 (copy), u10 (ref), u234 (ref)
                while u233 == u228 do
                    if u236 then
                        u229.Selection.Rotation = u10.lerpAngleDeg(u229.Selection.Rotation, u236.id / #u234 * 360, 0.5);
                    end;

                    task.wait();
                end;
            end);
        else
            table.clear(u227);
        end;

        return u233;
    end;

    local u250 = u13:GetAttribute("BodyType") == "Blocky" and CFrame.new(2.3, 0, 0) or CFrame.new(2, 0, 0);

    function u1.activateShoulderCamera(p251, p252) -- Line: 1386
        -- upvalues: CharScope (ref), u2 (ref), Ragdoll (ref), Humanoid (copy), u22 (ref), u1 (ref), u20 (ref), u250 (copy), HumanoidRootPart (copy), RunService (ref), workspace_CurrentCamera (ref)
        local u253 = p252 or {};
        CharScope.setConnectionsAndThreads("ShoulderCam");

        if p251 and (not u253.ignoreOpenedGui and u2.openedGui or (Ragdoll.isActive or u2.isSeated())) then
            p251 = false;
        end;

        Humanoid.AutoRotate = not p251;
        u2.lockMouseBahavior(p251);
        local CFrame_new_ret2 = CFrame.new();
        u22 = p251;
        u1.updateStrafing();
        u20();

        if p251 then
            CharScope.taskSpawn(function() -- Line: 1400
                -- upvalues: CFrame_new_ret2 (ref), u253 (ref), u250 (ref)
                local v254 = 0;

                for i = 1, 20 do
                    CFrame_new_ret2 = CFrame_new_ret2:Lerp(u253.cameraOffset or u250, 1 - 1e-6 ^ v254);
                    v254 = task.wait(0.016);
                    local _ = i;
                end;

                CFrame_new_ret2 = u253.cameraOffset or u250;
            end);
            local LookVector = HumanoidRootPart.CFrame.LookVector;
            RunService:BindToRenderStep("ShoulderCam", Enum.RenderPriority.Camera.Value, function(p255) -- Line: 1409
                -- upvalues: u2 (ref), u1 (ref), Humanoid (ref), LookVector (ref), workspace_CurrentCamera (ref), u253 (ref), CFrame_new_ret2 (ref), HumanoidRootPart (ref)
                if u2.isSeated() then
                    return;
                end;

                u1.disableToggleCameraIfToggled();

                if u1.firstPerson then
                    if not Humanoid.AutoRotate then
                        Humanoid.AutoRotate = true;
                    end;
                else
                    if Humanoid.AutoRotate then
                        Humanoid.AutoRotate = false;
                    end;

                    LookVector = LookVector:Lerp(workspace_CurrentCamera.CFrame.LookVector, 1 - (u253.lerp or 5e-10) ^ p255);
                    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame_new_ret2;
                    workspace_CurrentCamera.Focus = CFrame.fromMatrix(workspace_CurrentCamera.Focus.Position, workspace_CurrentCamera.CFrame.RightVector, workspace_CurrentCamera.CFrame.UpVector) * CFrame_new_ret2;
                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(-LookVector.X, -LookVector.Z), 0);

                    if u253.rootOffset then
                        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * u253.rootOffset;
                    end;

                    if u253.limitCameraHeight then
                        local v256, v257, v258 = workspace_CurrentCamera.CFrame:ToOrientation();
                        local math_deg_ret = math.deg(v256);
                        local math_clamp_ret = math.clamp(math_deg_ret, u253.limitCameraHeight.X, u253.limitCameraHeight.Y);
                        workspace_CurrentCamera.CFrame = CFrame.new(workspace_CurrentCamera.CFrame.p) * CFrame.fromOrientation(math.rad(math_clamp_ret), v257, v258);
                    end;
                end;
            end);
            CharScope.setThreadOrCleanUpFunctionIndex("ShoulderCam", "renderStepped", function() -- Line: 1427
                -- upvalues: RunService (ref)
                RunService:UnbindFromRenderStep("ShoulderCam");
            end);

            return true;
        end;
    end;

    for _, v in pairs(u10.collectionGetTagged("TeamChangeWithEntrance")) do
        local function set(p259, p260) -- Line: 1436
            for _, child in pairs(p259:GetChildren()) do
                if child:IsA("ProximityPrompt") then
                    if child.Name == "Entrance" then
                        child:SetAttribute("Disabled", not p260 and true or nil);
                    else
                        child.Enabled = p260;
                    end;
                elseif child:IsA("BasePart") then
                    child.Transparency = p260 and 0.02 or 1;
                elseif child:IsA("BillboardGui") then
                    child.Enabled = p260;
                end;
            end;
        end;

        local v261 = v._Interaction.TeamChange.TeamSpawn.Value.Parent.Parent.Name ~= u11;

        if v:GetAttribute("ShowTeamChange") == nil or v:GetAttribute("ShowTeamChange") ~= v261 then
            v:SetAttribute("ShowTeamChange", v261);
            set(v._Interaction, v261);
            set(v._Interaction2, not v261);
        end;
    end;

    u1.bottomBarMessage = ScreenGui.Center.Bottom.BarMessage;
    local u262 = {};
    local u263 = nil;

    function u1.displayBottomBarMessage(p264, p265, p266, p267, p268, p269) -- Line: 1459
        -- upvalues: u262 (copy), u263 (ref), u1 (ref), u10 (ref)
        u262[p264] = p265 and {
            p265,
            p266,
            p267,
            p268,
            p269
        } or nil;
        local v270 = u263 and u262[u263] and u263;
        local v271 = u263 and (u262[u263] and u262[u263][1]) or -1;

        for i, v in pairs(u262) do
            if v271 < v[1] then
                v271 = v[1];
                v270 = i;
            end;
        end;

        if v270 then
            if u263 ~= v270 then
                u1.bottomBarMessage.OnlyMessage.Visible = false;
                u1.bottomBarMessage.Default.Visible = false;
                u1.bottomBarMessage[u262[v270][3] and "Default" or "OnlyMessage"].Visible = true;
                u1.bottomBarMessage[u262[v270][3] and "Default" or "OnlyMessage"].TextLabel.Text = u262[v270][2] or "";
                u1.bottomBarMessage.Default.Bar.Visible = u262[v270][3];

                if u262[v270][3] then
                    u1.bottomBarMessage.Default.Bar.Fill.BackgroundColor3 = u262[v270][4];
                    u1.bottomBarMessage.Default.Bar.Fill.Flare.ImageColor3 = u262[v270][4];
                    u1.bottomBarMessage.Default.Bar.Fill.Flare2.ImageColor3 = u262[v270][4];
                    u10.tweenServiceSet(u1.bottomBarMessage.Default.Bar.Fill, {
                        Size = UDim2.fromScale(u262[v270][5] and 1 or 0, 1)
                    });
                    u10.tweenServiceStart(u1.bottomBarMessage.Default.Bar.Fill, TweenInfo.new(u262[v270][3], Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(u262[v270][5] and 0 or 1, 1)
                    });
                end;

                if not u263 then
                    u10.guiTransition(u1.bottomBarMessage, "Position", UDim2.fromScale(0, 0.1), true);
                end;

                u263 = v270;
            end;
        elseif u263 then
            u263 = nil;
            u10.guiTransition(u1.bottomBarMessage, "Position", UDim2.fromScale(0, 0.1), false);
        end;
    end;

    local JailTime = ScreenGui.Center.Bottom.JailTime;
    local u272 = nil;

    local function prisonTimeFunc() -- Line: 1495
        -- upvalues: u272 (ref), u10 (ref), JailTime (copy), LocalPlayer (ref), CharScope (ref), u11 (ref), u2 (ref), HumanoidRootPart (copy)
        if u272 then
            u10.guiTransition(JailTime, "Position", UDim2.fromScale(0, 0.1), false);
            u10.taskCancel(u272);
            u272 = nil;
        end;

        local Attribute = LocalPlayer:GetAttribute("PrisonTime");
        local Attribute2 = LocalPlayer:GetAttribute("ArrestPrisonTime");
        local u273 = Attribute2 or Attribute;

        if u273 then
            u10.guiTransition(JailTime, "Position", UDim2.fromScale(0, 0.1), true);
            JailTime.InCustody.Visible = false;
            JailTime.InPrison.Visible = false;
            JailTime.InCustodyJailTimeEnded.Visible = false;
            local u274 = JailTime[Attribute2 and "InCustody" or "InPrison"];
            u274.Visible = true;
            u272 = CharScope.taskDefer(function() -- Line: 1511
                -- upvalues: u273 (copy), u10 (ref), LocalPlayer (ref), Attribute2 (copy), JailTime (ref), u274 (copy), Attribute (copy), u11 (ref), u2 (ref), HumanoidRootPart (ref)
                while true do
                    local v275 = u273 - u10.getDistributedGameTime();
                    local math_ceil_ret = math.ceil(v275);
                    local Attribute3 = LocalPlayer:GetAttribute("TransportTime");

                    if Attribute2 and (Attribute3 and math_ceil_ret <= 0) then
                        if not JailTime.InCustodyJailTimeEnded.Visible then
                            JailTime.InCustodyJailTimeEnded.Visible = true;
                            u274.Visible = false;
                        end;

                        local TextLabel = JailTime.InCustodyJailTimeEnded.TextLabel;
                        local v276 = LocalPlayer:GetAttribute("CustodyEscapeAttempt") and "CUSTODY ESCAPE TIME: " or "TRANSPORT TIME: ";
                        local timerFormat = u10.timerFormat;
                        local v277 = Attribute3 - u10.getDistributedGameTime();
                        local math_ceil_ret2 = math.ceil(v277);
                        TextLabel.Text = v276 .. timerFormat((math.max(0, math_ceil_ret2)));
                    else
                        if JailTime.InCustodyJailTimeEnded.Visible then
                            JailTime.InCustodyJailTimeEnded.Visible = false;
                            u274.Visible = true;
                        end;

                        u274.TextLabel.Text = "JAIL TIME: " .. u10.timerFormat((math.max(0, math_ceil_ret)));
                    end;

                    if Attribute and (u11 == "Prisoner" and (not u2.isEnteringLocation and (Vector2.new(HumanoidRootPart.Position.X, HumanoidRootPart.Position.Z) - Vector2.new(u2.prisonLocation.Zone.Position.X, u2.prisonLocation.Zone.Position.Z)).Magnitude > u2.prisonLocation.Zone.Size.Z / 2)) then
                        u10.charPivotTo(LocalPlayer.Character, u2.prisonLocation.Outside.Value.ScriptedPersistent.SpawnLocation.CFrame + Vector3.new(0, 5, 0));
                        u2.notify({
                            message = "You can\'t leave prison yet",
                            color = "red"
                        });
                    end;

                    task.wait(1);
                end;
            end);
        end;
    end;

    CharScope.buildSignalData("Global", { LocalPlayer:GetAttributeChangedSignal("PrisonTime"), prisonTimeFunc });
    CharScope.buildSignalData("Global", { LocalPlayer:GetAttributeChangedSignal("ArrestPrisonTime"), prisonTimeFunc });
    prisonTimeFunc();
    local u278 = nil;

    function u1.gameLeaderboard(u279, u280, u281) -- Line: 1544
        -- upvalues: u2 (ref), CharScope (ref), u278 (ref), u10 (ref), u1 (ref), LocalPlayer (ref)
        if not u281 then
            if u2.openedGui and u2.openedGui ~= "GameLeaderboard" then
                return;
            end;

            u2.openGui(u280 and "GameLeaderboard");
        end;

        CharScope.setConnectionsAndThreads("GameLeaderboard");
        u278 = nil;

        if u280 then
            CharScope.buildSignalData("GameLeaderboard", u10.buttonHoverSignalData(u279.Top.Close));
            CharScope.buildSignalData("GameLeaderboard", u2.mouseButton(u279.Top.Close, function() -- Line: 1553
                -- upvalues: u1 (ref), u279 (copy), u281 (copy)
                u1.gameLeaderboard(u279, false, u281);
            end, {
                addMobileButton = true
            }));

            local function setHeadline(p282, p283) -- Line: 1557
                -- upvalues: u279 (copy), u10 (ref), u280 (copy)
                u279.Top.Headline.Size = UDim2.fromScale(0.92, u279.Top.Headline.Size.Y.Scale);
                u279.Top.Headline.Text = "<i>" .. (p282 and "FINISHED <font color=\"rgb(" .. math.floor(p283.R * 255) .. ", " .. math.floor(p283.G * 255) .. ", " .. math.floor(p283.B * 255) .. ")\">" .. p282 .. string.upper(u10.getOrdinalnumberText(p282)) .. "</font>" or "LEADERBOARD") .. "</i>";
                u279.Top.Headline.Size = UDim2.fromScale(u10.getTextBounds(u279.Top.Headline).X / u279.Top.AbsoluteSize.X, u279.Top.Headline.Size.Y.Scale);
                u279.Top.BottomLine.Text = "<i>" .. string.upper(u280) .. "</i>";
                u279.Top.BottomLine.Size = UDim2.fromScale(u279.Top.Headline.Size.X.Scale, u279.Top.BottomLine.Size.Y.Scale);
            end;

            setHeadline(nil, Color3.fromRGB(255, 255, 255));

            for _, child in pairs(u279:GetChildren()) do
                if child.Name == "Place" then
                    child:Destroy();
                end;
            end;

            u278 = function(p284) -- Line: 1569, Name: addPlace
                -- upvalues: u10 (ref), u279 (copy), LocalPlayer (ref), setHeadline (copy)
                local v285 = u10.clone(u279.PlacePreview);
                v285.Visible = true;
                v285.Name = "Place";
                v285.Highlight.Visible = p284.Place % 2 == 1;
                v285.LayoutOrder = p284.Place;
                v285.Place.Text = p284.Place;

                if p284.Username == LocalPlayer.Name then
                    setHeadline(p284.Place, p284.Color or Color3.fromRGB(255, 255, 255));
                end;

                for _, child in pairs(v285:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = p284.Color or Color3.fromRGB(255, 255, 255);
                    end;
                end;

                p284.Color = nil;

                for i, v in pairs(p284) do
                    if v285:FindFirstChild(i) then
                        v285[i].Text = v;
                    end;
                end;

                v285.Parent = u279;
            end;
        end;

        u10.guiTransition(u279, "Size", 0.9, u280);

        return u278;
    end;

    local u286 = nil;

    local function hideCharactersAndVehicles(p287) -- Line: 1588
        -- upvalues: u1 (ref), CharScope (ref), u286 (ref), PlayerEvent (ref), hideCharactersAndVehicles (copy)
        u1.DEBUG10303 = tick();
        CharScope.setConnectionsAndThreads("HideCharactersAndVehicles");

        if u286 then
            for _, child in pairs(u286:GetChildren()) do
                if child.PrimaryPart then
                    child.Parent = child.PrimaryPart.Name == "_Chassis" and workspace.Gameplay.Vehicles or workspace.Characters;
                else
                    PlayerEvent:FireServer("developmentLogs", "DEBUG 9393", child.Name, child:GetPivot().Position.X, child:GetPivot().Position.Y, child:GetPivot().Position.Z, "|", #child:GetChildren());
                    child.Parent = workspace;
                    task.delay(1, function() -- Line: 1596
                        -- upvalues: PlayerEvent (ref), child (copy)
                        PlayerEvent:FireServer("developmentLogs", "DEBUG 9394", child.Parent and "true" or "false", child.Name, child:GetPivot().Position.X, child:GetPivot().Position.Y, child:GetPivot().Position.Z, "|", #child:GetChildren());
                        child:Destroy();
                    end);
                end;
            end;

            u286:Destroy();
            u286 = nil;
        end;

        CharScope.setThreadOrCleanUpFunctionIndex("Global", "hideCharactersAndVehiclesCleanUp", p287 and hideCharactersAndVehicles or nil);

        if p287 then
            u286 = Instance.new("Folder");
            u286.Name = "HideCharactersAndVehicles";
            u286.Parent = game.ReplicatedStorage.Gameplay.Entities;

            for _, v in pairs({ workspace.Gameplay.Vehicles, workspace.Characters }) do
                for _, child in pairs(v:GetChildren()) do
                    child.Parent = u286;
                end;

                CharScope.buildSignalData("HideCharactersAndVehicles", { v.ChildAdded, function(p288) -- Line: 1612
                        -- upvalues: u286 (ref)
                        task.wait();
                        p288.Parent = u286;
                    end });
            end;
        end;
    end;

    local function isToggleCameraToggled() -- Line: 1618
        -- upvalues: UserInputService (ref)
        return UserInputService.MouseIcon == "rbxasset://textures/Cursors/CrossMouseIcon.png";
    end;

    local u289 = false;

    local function disableToggleCamera() -- Line: 1623
        -- upvalues: UserInputService (ref), u289 (ref), CharScope (ref)
        UserInputService.MouseIcon = "";

        if not u289 and workspace.Camera.CameraType == Enum.CameraType.Custom then
            u289 = true;
            local CameraType = workspace.Camera.CameraType;
            workspace.Camera.CameraType = Enum.CameraType.Follow;
            CharScope.taskDelay(0.03, function() -- Line: 1629
                -- upvalues: CameraType (copy), u289 (ref)
                workspace.Camera.CameraType = CameraType;
                u289 = false;
            end);
        end;
    end;

    function u1.disableToggleCameraIfToggled() -- Line: 1636
        -- upvalues: UserInputService (ref), disableToggleCamera (copy)
        if UserInputService.MouseIcon == "rbxasset://textures/Cursors/CrossMouseIcon.png" then
            disableToggleCamera();
        end;
    end;

    local Citation = ScreenGui.Center.Middle.Citation;

    function u1.citation(p290, p291) -- Line: 1642
        -- upvalues: u2 (ref), CharScope (ref), Citation (copy), u1 (ref), u10 (ref), HumanoidRootPart (copy), LocalPlayer (ref), u9 (ref)
        if p290 and (u2.openedGui and u2.openedGui ~= "Citation") then
            return;
        end;

        local u292 = p291 or {};
        CharScope.setConnectionsAndThreads("Citation");

        local function show(p293) -- Line: 1646
            -- upvalues: u2 (ref), CharScope (ref), Citation (ref), u1 (ref), u10 (ref)
            u2.openGui(p293 and "Citation");

            if p293 then
                CharScope.buildSignalData("Citation", u2.mouseButton(Citation.Close, function() -- Line: 1649
                    -- upvalues: u1 (ref)
                    u1.citation();
                end, {
                    addMobileButton = true
                }));
                CharScope.buildSignalData("Citation", u10.buttonHoverSignalData(Citation.Close));
            end;
        end;

        local function updateViolations(p294, p295) -- Line: 1655
            -- upvalues: Citation (ref), u10 (ref)
            for _, child in pairs(Citation.ReasonList:GetChildren()) do
                if child:IsA("ImageButton") and child.Visible then
                    child:Destroy();
                end;
            end;

            for i, v in pairs(p294) do
                local v296 = u10.clone(Citation.ReasonPreview);
                v296.Name = i;
                v296.Visible = true;
                local v297 = #v;
                v296.TextLabel.Text = i .. (v297 > 1 and " (x" .. v297 .. ")" or "");
                v296.Parent = Citation.ReasonList;
                v296.Size = UDim2.fromScale(u10.getTextBounds(v296.TextLabel).X / Citation.ReasonList.AbsoluteSize.X + 0.12, v296.Size.Y.Scale);

                if p295 then
                    p295(v296);
                end;
            end;
        end;

        if p290 == "police" then
            if not u10.invokeTraffic.cite then
                CharScope.addThreadOrCleanUpFunction("Citation", CharScope.taskDefer(function() -- Line: 1672
                    -- upvalues: u10 (ref), u292 (ref), Citation (ref), show (copy), u2 (ref), HumanoidRootPart (ref), updateViolations (copy), CharScope (ref), LocalPlayer (ref), u1 (ref)
                    local v298, v299 = u10.invokeServerTraffic("cite", u292.target);

                    if u10.typeOf(v298) ~= "table" then
                        if u10.typeOf(v298) == "string" then
                            u2.notify({
                                message = v298,
                                color = v299
                            });
                        end;

                        u1.citation();

                        return;
                    end;

                    local u300 = "fillOut";
                    u10.guiTransition(Citation, "Position", UDim2.fromScale(0, 0.2), true);
                    show(true);
                    u2.activateBlur("citation", true);
                    Citation.Button.Visible = true;
                    Citation.Board.Visible = true;
                    Citation.IssuedTo.Text = u292.target.DisplayName;
                    Citation.Location.Text = u10.getLocationStringAtPos(HumanoidRootPart.Position);
                    updateViolations(v298, function(u301) -- Line: 1683
                        -- upvalues: CharScope (ref), u2 (ref), u300 (ref)
                        CharScope.buildSignalData("Citation", u2.mouseButton(u301, function() -- Line: 1684
                            -- upvalues: u300 (ref), u301 (copy)
                            if u300 == "fillOut" then
                                u301.Checked.Button.ImageLabel.Visible = not u301.Checked.Button.ImageLabel.Visible;
                            end;
                        end, {
                            addMobileButton = true
                        }));
                    end);
                    Citation.Officer.Text = LocalPlayer.DisplayName;
                    Citation.Button.TextLabel.Text = "Fill Out";

                    for _, v in pairs({ "IssuedTo", "Officer", "Location", "Fine" }) do
                        Citation[v].MaxVisibleGraphemes = 0;
                    end;

                    CharScope.buildSignalData("Citation", u2.mouseButton(Citation.Button, function() -- Line: 1694
                        -- upvalues: CharScope (ref), u300 (ref), Citation (ref), u10 (ref), HumanoidRootPart (ref), u2 (ref), u1 (ref)
                        CharScope.setThreadOrCleanUpFunctionIndex("Citation", "button", CharScope.taskSpawn(function() -- Line: 1695
                            -- upvalues: u300 (ref), Citation (ref), u10 (ref), HumanoidRootPart (ref), u2 (ref), u1 (ref)
                            if u300 ~= "fillOut" then
                                if u300 == "approve" and not u10.invokeTraffic.cite then
                                    u300 = "approving";
                                    local v302, v303 = u10.invokeServerTraffic("cite");

                                    if v302 == true then
                                        u2.notify({
                                            message = "Ticket issued to the player",
                                            color = "green"
                                        });
                                        u1.citation();

                                        return;
                                    end;

                                    if u10.typeOf(v302) == "string" then
                                        u2.notify({
                                            message = v302,
                                            color = v303
                                        });
                                    end;

                                    u300 = "approve";
                                end;

                                return;
                            end;

                            u300 = "fillingOut";
                            local v304 = {};

                            for _, child in pairs(Citation.ReasonList:GetChildren()) do
                                if child:IsA("ImageButton") and (child.Visible and child.Checked.Button.ImageLabel.Visible) then
                                    table.insert(v304, child.Name);
                                end;
                            end;

                            local v305 = u10.invokeServerTraffic("cite", v304);

                            if u10.typeOf(v305) ~= "number" then
                                if u10.typeOf(v305) == "string" then
                                    u2.notify({
                                        color = "red",
                                        message = v305
                                    });
                                end;

                                u300 = "fillOut";

                                return;
                            end;

                            Citation.Fine.Text = "＄" .. v305;
                            u10.playSoundReplicate(HumanoidRootPart.WriteCitation);

                            for i, v in pairs({ "IssuedTo", "Officer", "Location", "Fine" }) do
                                if i ~= 1 then
                                    task.wait(0.2);
                                end;

                                local v306 = v;

                                for i2 = 1, string.len(Citation[v].Text) do
                                    Citation[v306].MaxVisibleGraphemes = i2;
                                    task.wait(0.05);
                                    local _ = i2;
                                end;
                            end;

                            u10.stopSoundReplicate(HumanoidRootPart.WriteCitation);
                            u300 = "approve";
                            Citation.Button.TextLabel.Text = "Approve";
                        end));
                    end));
                end));
            end;
        elseif p290 == "received" then
            for _, v in pairs({ "IssuedTo", "Officer", "Location", "Fine" }) do
                Citation[v].MaxVisibleGraphemes = -1;
            end;

            Citation.Button.Visible = false;
            Citation.IssuedTo.Text = LocalPlayer.DisplayName;
            Citation.Location.Text = u10.getLocationStringAtPos(HumanoidRootPart.Position);
            Citation.Officer.Text = u292.officer;
            Citation.Fine.Text = "＄" .. u292.fine;
            updateViolations(u292.violations, function(p307) -- Line: 1748
                p307.Checked.Button.ImageLabel.Visible = true;
            end);
            Citation.Board.Visible = false;
            u10.guiTransition(Citation, "Position", UDim2.fromScale(0, 0.2), true);
            show(true);
            u9.disabled(false, "openGui");
            CharScope.buildSignalData("Citation", u2.guiScreenDraggingSystem(Citation, Citation.Background));
        else
            u10.guiTransition(Citation, "Position", UDim2.fromScale(0, 0.2), false);
            u2.openGui(false);
            u2.activateBlur("citation", false);
        end;
    end;

    u1.allowToEnterLocationAgainIfCopPursuitsForSomeTime = nil;

    function u1.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc(u308) -- Line: 1767
        -- upvalues: u1 (ref), CharScope (ref), HumanoidRootPart (copy), u10 (ref)
        u1.allowToEnterLocationAgainIfCopPursuitsForSomeTime = nil;
        CharScope.setConnectionsAndThreads("AllowToEnterLocationAgainIfCopPursuitsForSomeTime");

        if u308 then
            CharScope.addThreadOrCleanUpFunction("AllowToEnterLocationAgainIfCopPursuitsForSomeTime", CharScope.taskSpawn(function() -- Line: 1771
                -- upvalues: HumanoidRootPart (ref), u308 (copy), u10 (ref), u1 (ref)
                local Vector2_new_ret2 = Vector2.new(HumanoidRootPart.Position.X, HumanoidRootPart.Position.Z);
                local v309;

                if u308.Name == "PropertyInside" then
                    u308:WaitForChild("Property", 5);
                    local InstanceAttribute = u10.getInstanceAttribute(u308, "Property");
                    u1.allowToEnterLocationAgainIfCopPursuitsForSomeTime = workspace.World.Housing[InstanceAttribute.Name];
                    v309 = 15;
                else
                    u1.allowToEnterLocationAgainIfCopPursuitsForSomeTime = u308;
                    v309 = 15;
                end;

                while v309 > 0 and (Vector2_new_ret2 - Vector2.new(HumanoidRootPart.Position.X, HumanoidRootPart.Position.Z)).Magnitude <= 100 do
                    v309 = v309 - task.wait(1);
                end;

                return u1.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc();
            end));
        end;
    end;

    local u310 = u10.raycastParamsNew();
    u310.IgnoreWater = true;
    u310.FilterDescendantsInstances = { u13 };
    u1.floor = nil;

    if GameRules.season == "Winter" then
        GameRules.materialTable.Sandstone = GameRules.materialTable.Snow;
        GameRules.materialTable.Asphalt = GameRules.materialTable.Snow;
        GameRules.materialTable.Salt = GameRules.materialTable.Snow;
        GameRules.materialTable.Grass = GameRules.materialTable.Snow;
        GameRules.materialTable.LeafyGrass = GameRules.materialTable.Snow;
        GameRules.materialTable.Sand = GameRules.materialTable.Snow;
    end;

    CharScope.taskSpawn(function() -- Line: 1803
        -- upvalues: u10 (ref), HumanoidRootPart (copy), u310 (copy), GameRules (ref), u1 (ref), PlayerEvent (ref), u13 (copy)
        while true do
            local v311 = u10.raycastVisible(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u310);

            if v311 then
                local v312 = GameRules.materialTable[v311.Instance.Name] and v311.Instance.Name or GameRules.materialTable[v311.Material.Name] and v311.Material.Name;

                if u1.floor ~= v312 then
                    u1.floor = v312;
                    PlayerEvent:FireServer("humFloor", v312);
                    u13:SetAttribute("HumanoidFloor", v312);
                end;
            end;

            task.wait(0.2);
        end;
    end);
    local u313 = nil;
    local u314 = {
        ["115734159282221"] = true
    };
    local u315 = false;

    local function footprints(p316) -- Line: 1822
        -- upvalues: u313 (ref), u10 (ref), CharScope (ref), u1 (ref), GameRules (ref), u314 (copy), HumanoidRootPart (copy), u315 (ref), u310 (copy), LocalPlayer (ref)
        if u313 then
            u10.taskCancel(u313);
        end;

        if p316 then
            u313 = CharScope.taskDefer(function() -- Line: 1825
                -- upvalues: u1 (ref), GameRules (ref), u314 (ref), HumanoidRootPart (ref), u10 (ref), u315 (ref), u310 (ref), LocalPlayer (ref)
                task.wait(0.7);

                while true do
                    while not (u1.floor and (GameRules.materialTable[u1.floor] and u314[GameRules.materialTable[u1.floor]])) do
                        task.wait(0.7);
                    end;

                    local v317 = -HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity).Z;
                    local math_abs_ret = math.abs(v317);
                    local v318 = math.clamp(math_abs_ret, 0, 18) / 18;

                    if v318 > 0.05 then
                        local v319 = u10.raycastVisible(HumanoidRootPart.Position + HumanoidRootPart.CFrame.RightVector * (u315 and 0.5 or -0.5) * (u1.isKid and 0.5 or 1), Vector3.new(0, -10, 0), u310);

                        if v319 then
                            u315 = not u315;
                            local _, v320, _ = HumanoidRootPart.CFrame:ToOrientation();
                            local v321 = CFrame.new(v319.Position, v319.Position + v319.Normal) * CFrame.Angles(0, 0, -v320 - 1.5707963267948966);
                            u10.selectiveObjReplicaSystem("footprint", LocalPlayer, nil, {
                                cframe = v321
                            });
                        end;

                        task.wait((0.55 - v318 * 0.35) * (u1.isKid and 0.65 or 1));
                    else
                        task.wait(0.7);
                    end;
                end;
            end);
        end;
    end;

    if u11 == "Civilian" then
        local function crewChanged(u322) -- Line: 1849
            -- upvalues: CharScope (ref), u1 (ref), u10 (ref)
            CharScope.setConnectionsAndThreads("crew");

            if u322 then
                CharScope.addThreadOrCleanUpFunction("crew", u1.grabFromVehicleThirdPartyPrompt("ArrestedHelpEscape", function(p323) -- Line: 1854
                    -- upvalues: u10 (ref), u322 (copy)
                    local v324 = u10.getVehicleInfo.inVehicle(p323);

                    if not (u10.lockedInPoliceCarCustodyEscapeAttempt(v324) and v324.Config.On.Value) then
                        local v325 = p323:GetAttribute("Arrested") and u322 == u10.getInstanceAttribute(p323, "Crew");

                        return v325;
                    end;
                end, function(p326) -- Line: 1861
                    -- upvalues: u10 (ref)
                    local v327 = u10.getVehicleInfo.inVehicle(p326.Target.Value);

                    if u10.lockedInPoliceCarCustodyEscapeAttempt(v327) then
                        p326.ObjectText = "Lockpick Device";

                        return;
                    end;

                    p326.ObjectText = "";
                end));
            end;
        end;

        local InstanceAttributeChangedSignal, v328 = u10.getInstanceAttributeChangedSignal(LocalPlayer, "Crew", crewChanged);
        CharScope.buildSignalData("Global", unpack(InstanceAttributeChangedSignal));
        CharScope.addThreadOrCleanUpFunction("Global", v328);
        crewChanged(u10.getInstanceAttribute(LocalPlayer, "Crew"));
    elseif u11 == "Police" then
        local MaxActivationDistance = game.ReplicatedStorage.Gameplay.Items.TowStolen.MaxActivationDistance;
        u2.displayProximityPromptOnObjects({
            promptTable = {},

            promptPreview = function() -- Line: 1881, Name: promptPreview
                -- upvalues: u10 (ref)
                return u10.clone(game.ReplicatedStorage.Gameplay.Items.TowStolen);
            end,

            getWorkspaceObject = function(p329) -- Line: 1882, Name: getWorkspaceObject
                return p329.PrimaryPart.VisualCenter;
            end,

            getTargets = function() -- Line: 1883, Name: getTargets
                -- upvalues: HumanoidRootPart (copy), MaxActivationDistance (copy), u10 (ref)
                local v330 = {};

                for _, child in pairs(workspace.Gameplay.Vehicles:GetChildren()) do
                    if (child.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= MaxActivationDistance and (not child.Config.On.Value and u10.getVehicleInfo.isStolen(child)) then
                        v330[child] = true;
                    end;
                end;

                return v330;
            end
        });
        u1.grabFromVehicleThirdPartyPrompt("Arrested", function(p331) -- Line: 1894
            -- upvalues: LocalPlayer (ref)
            return p331:GetAttribute("Arrested") == LocalPlayer.UserId;
        end);
    elseif u11 == "Medical" then
        local u332 = game.ReplicatedStorage.PlayerStuff.MedicalWaitCombat.MaxDistance + 10;
        u2.displayProximityPromptOnObjects({
            promptTable = {},

            promptPreview = function() -- Line: 1899, Name: promptPreview
                -- upvalues: u10 (ref)
                return u10.clone(game.ReplicatedStorage.PlayerStuff.MedicalWaitCombat);
            end,

            getWorkspaceObject = function(p333) -- Line: 1900, Name: getWorkspaceObject
                return p333.PrimaryPart;
            end,

            update = function(p334, p335) -- Line: 1901, Name: update
                -- upvalues: u10 (ref), GameRules (ref)
                local PlayerFromCharacter = u10.getPlayerFromCharacter(p335);
                local v336 = PlayerFromCharacter and u10.medicRestrictReviveWhenCombatModeOn(PlayerFromCharacter, PlayerFromCharacter.Character);

                if v336 then
                    u10.updateCircularHud({ p334.CircularProgressBar.Left.ImageLabel }, { p334.CircularProgressBar.Right.ImageLabel }, v336 / (GameRules.combatModeCountDown10s * 10));
                end;
            end,

            getTargets = function() -- Line: 1910, Name: getTargets
                -- upvalues: u10 (ref), LocalPlayer (ref), HumanoidRootPart (copy), u332 (copy)
                local v337 = {};

                for _, v in pairs(u10.getLoadedPlayers()) do
                    if v ~= LocalPlayer and (u10.isCharLoaded(v) and ((v.Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude <= u332 and u10.medicRestrictReviveWhenCombatModeOn(v, v.Character))) then
                        v337[v.Character] = true;
                    end;
                end;

                return v337;
            end
        });
    elseif u11 == "Chef" then
        CharScope.taskDelay(2, function() -- Line: 1923
            -- upvalues: u10 (ref), LocalPlayer (ref), u2 (ref)
            while true do
                if not (u10.isPlayerNearbyToLeaveJobTeam(LocalPlayer) or u10.invokeTraffic.selectTeam) then
                    task.defer(function() -- Line: 1926
                        -- upvalues: u10 (ref), u2 (ref)
                        if u10.invokeServerTraffic("selectTeam", "LeaveTeamAnywhere") == true then
                            return u2.notify({
                                message = "You went far away from the restaurant",
                                color = "red"
                            });
                        end;
                    end);
                end;

                task.wait(2);
            end;
        end);
    end;

    CharScope.taskDefer(function() -- Line: 1946
        -- upvalues: u2 (ref), u11 (ref)
        u2.joinIncidentsIfNear(u11);
    end);
    u2.debugLoadingClient("Character 3");
    local u338 = u10.raycastParamsNew();
    u338.FilterDescendantsInstances = { workspace.Characters };
    u338.IgnoreWater = true;
    local u339 = nil;
    local u340 = nil;
    local RoleplayScene = FrontGui.Center.Middle.MainBox.RoleplayScene;

    function u1.roleplaySceneInteractMouseUserInput(p341, p342) -- Line: 1960
        -- upvalues: u4 (ref), u2 (ref), workspace_CurrentCamera (ref), u10 (ref), LocalPlayer (ref), PlayerFunc (ref)
        if not (p341.UserInputType ~= Enum.UserInputType.MouseButton1 and p341.UserInputType ~= Enum.UserInputType.Touch or (p342 or u4.isAiming)) then
            for i, _ in pairs(u2.roleplayScenes) do
                if (workspace_CurrentCamera.CFrame.Position - i.Part.Position).Magnitude <= i.Part.BillboardGui.MaxDistance then
                    local v343 = workspace_CurrentCamera:WorldToViewportPoint(i.Part.Position);

                    if u10.isInFrame(u2.platform == "Mobile" and i.Part.BillboardGui.MobileButton or i.Part.BillboardGui.Background, nil, nil, Vector2.new(v343.X, v343.Y - u2.guiInset) - i.Part.BillboardGui.Background.AbsoluteSize / 2) then
                        if i.Parent.Name == LocalPlayer.Name then
                            PlayerFunc:InvokeServer("placeScene", {
                                removeScene = i
                            });

                            return;
                        end;

                        if u2.mainBox({
                            case = "Decision",
                            infoButton = "Enhance roleplay with Roleplay Scenes (\'+\' Key). Place a text or emoji somewhere to represent physical props or clues. Examples: oil leak, wet floor sign, dropped item, banana peel, gun casing, blood trail. Higher reputation allows you to put more scenes",
                            lockHumanoidState = true,
                            button2 = "CANCEL",
                            headline = "Do you want delete this Roleplay Scene?\nCreated by: @" .. i.Parent.Name,
                            button = { "DELETE", nil, 20 }
                        }) == 1 then
                            PlayerFunc:InvokeServer("placeScene", {
                                removeScene = i
                            });
                        end;

                        return;
                    end;
                end;
            end;
        end;
    end;

    function u1.activateRoleplayScene(p344) -- Line: 1982
        -- upvalues: u2 (ref), GameRules (ref), CharScope (ref), u10 (ref), u1 (ref), u339 (ref), LocalPlayer (ref), RoleplayScene (copy), u340 (ref), HumanoidRootPart (copy), RunService (ref), u338 (copy), PlayerFunc (ref), UserInputService (ref), Mobile (copy)
        if u2.openedGui and u2.openedGui ~= "roleplayScene" then
            return;
        end;

        if p344 and u2.readPlayerData("Reputation") < GameRules.minRoleplaySceneReputation then
            u2.notify({
                color = "red",
                message = "You need at least " .. GameRules.minRoleplaySceneReputation .. " reputation to use Roleplay Scenes"
            });

            return;
        end;

        u2.openGui(p344 and "roleplayScene");
        CharScope.setConnectionsAndThreads("RoleplayScene");
        u2.overwriteJump("roleplayScene", false);
        u10.contextAction("UnbindAction", "RoleplaySceneCancel");
        u1.keepMobileGuiTypePersistent("RoleplayScene", false);

        if u339 then
            u339:Destroy();
            u339 = nil;
        end;

        if not p344 then
            u1.displayBottomBarMessage("roleplayScene");

            return;
        end;

        local v345 = 0;

        for _, child in pairs(workspace.Gameplay.Entities[LocalPlayer.Name]:GetChildren()) do
            if child.Name == "_RoleplayScene" then
                v345 = v345 + 1;
            end;
        end;

        local v346 = GameRules.roleplaySceneAmount(u2.readPlayerData("Reputation")) * (u10.isPrivateServerConfigurationSettingEnabled("roleplayScenesLimit") or 1);
        local math_floor_ret = math.floor(v346);
        RoleplayScene.TextLabel.Text = "Place a Roleplay Scene (" .. v345 .. "/" .. math_floor_ret .. ")";
        local u347, v348 = u2.mainBox({
            case = "RoleplayScene",
            textPlaceholder = "Content",
            acceptContent = "Place",
            roleplaySceneColor = u340,
            infoButton = "Enhance roleplay with Roleplay Scenes. Place a text or emoji somewhere to represent physical props or clues. Examples: oil leak, wet floor sign, dropped item, banana peel, gun casing, blood trail. Higher reputation allows you to put more scenes. Current max " .. math_floor_ret
        });

        if not u347 then
            u1.activateRoleplayScene();

            return;
        end;

        if v348 then
            u340 = v348;
        end;

        local ImageColor3 = RoleplayScene.Colors[v348].ImageColor3;
        local u349 = nil;
        u1.displayBottomBarMessage("roleplayScene", 1, "Place a scene with your mouse. Press JUMP to cancel");
        u339 = u10.placeScene(LocalPlayer, ImageColor3, HumanoidRootPart.Position);

        if u339 then
            CharScope.addEntity(u339);
            u339.Content.Value = u347;
            u339.Part.BillboardGui.Background.Highlight.Visible = true;
            CharScope.buildSignalData("RoleplayScene", { RunService.Heartbeat, function(p350) -- Line: 2015
                    -- upvalues: u349 (ref), u2 (ref), u338 (ref), u339 (ref)
                    u349 = u2.getMouseProperty.raycast(u338, 25, "FreeSpacePersistent");

                    if (u349 and true or false) ~= u339.Part.BillboardGui.Enabled then
                        u339.Part.BillboardGui.Enabled = u349;
                    end;

                    if u349 then
                        u339.Part.CFrame = u339.Part.CFrame:Lerp(CFrame.new(u349.Position), 1 - 1e-9 ^ p350);
                    end;
                end });
            u2.overwriteJump("roleplayScene", function() -- Line: 2020
                -- upvalues: u1 (ref)
                u1.activateRoleplayScene();
            end);

            local function placeScene() -- Line: 2021
                -- upvalues: u349 (ref), u1 (ref), PlayerFunc (ref), u347 (copy), ImageColor3 (copy), u10 (ref), u2 (ref)
                if u349 then
                    u1.activateRoleplayScene();
                    local v351 = PlayerFunc:InvokeServer("placeScene", {
                        content = u347,
                        color = ImageColor3,
                        position = u349.Position
                    });

                    if tonumber(v351) then
                        if u10.getInstanceReference(v351, 20) then
                        end;
                    elseif u10.typeOf(v351) == "string" then
                        u2.notify({
                            color = "red",
                            message = v351
                        });
                    end;
                end;
            end;

            CharScope.buildSignalData("RoleplayScene", { UserInputService.InputBegan, function(p352, p353) -- Line: 2034
                    -- upvalues: u2 (ref), placeScene (copy)
                    if p352.UserInputType == Enum.UserInputType.MouseButton1 and not p353 then
                        if u2.isMouseObstructedByBlackBackground() then
                            return;
                        end;

                        placeScene();
                    end;
                end });
            u1.keepMobileGuiTypePersistent("RoleplayScene", true);
            CharScope.buildSignalData("RoleplayScene", u2.mouseButton(Mobile.RoleplayScene.RoleplayScene, function() -- Line: 2042
                -- upvalues: placeScene (copy)
                placeScene();
            end));
        end;
    end;

    u2.debugLoadingClient("Character 3.01");
    local u354 = {};

    for _, child in pairs(ScreenGui.Center.Middle.MinigameTrafficBox.Output:GetChildren()) do
        u354[tonumber(child.Name)] = Vector2.new(child.Position.X.Scale, child.Position.Y.Scale);
    end;

    local function enableMobileControls(p355) -- Line: 2056
        -- upvalues: GuiService (ref), u1 (ref), u10 (ref)
        GuiService.TouchControlsEnabled = p355;
        u1.displayMobileGuiType(p355 and (u10.typeOf(p355) == "string" and p355 and p355 or "Character") or true);
    end;

    function u1.startMinigame(u356, p357) -- Line: 2061
        -- upvalues: GameRules (ref), CharScope (ref), GuiService (ref), u1 (ref), u10 (ref), u2 (ref), ScreenGui (copy), UserInputService (ref), u354 (copy)
        if GameRules.disableMinigames then
            return true;
        end;

        local u358 = p357 or {};
        CharScope.setConnectionsAndThreads("Minigame");
        GuiService.TouchControlsEnabled = true;
        u1.displayMobileGuiType(u10.typeOf(true) == "string" and true or "Character");

        local function focusOnMinigame(p359, p360) -- Line: 2066
            -- upvalues: u2 (ref), u10 (ref), u1 (ref)
            if not u2.openedGui or u2.openedGui == "Minigame" then
                u2.openGui(p360 and "Minigame", true);
                u10.lockScroll("Minigame", p360);
                u1.lockHumanoidState("Minigame", p360 and -1);
                u2.activateBlur("minigame", p360);

                return true;
            end;
        end;

        if u358.start then
            u2.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "Minigame", function() -- Line: 2075
                -- upvalues: u1 (ref), u356 (copy)
                u1.startMinigame(u356);
            end);
        end;

        if u356 == 1 then
            local Minigame1 = ScreenGui.Center.Bottom.Minigame1;
            u10.guiTransition(Minigame1, "Position", UDim2.fromScale(0, 0.1), u358.start);
            u2.overwriteJump("minigame", false);

            if u358.start then
                local function start() -- Line: 2084
                    -- upvalues: u358 (ref), Minigame1 (copy), CharScope (ref), UserInputService (ref), u2 (ref)
                    local u361 = 0;
                    local v362 = math.random(1, 20) / 10;
                    local v363 = 0.7 - 0.5 * (u358.difficulty / 100);
                    local u364 = nil;
                    Minigame1.Title.Text = string.upper(u358.title);
                    Minigame1.Zone.Yellow.Enabled = true;
                    Minigame1.Zone.Green.Enabled = false;

                    local function handleAction() -- Line: 2094
                        -- upvalues: u361 (ref), Minigame1 (ref), u364 (ref)
                        if u361 > 2 then
                            if Minigame1.Pointer.Position.X.Scale >= 0.5 - Minigame1.Zone.Size.X.Scale / 2 and Minigame1.Pointer.Position.X.Scale <= 0.5 + Minigame1.Zone.Size.X.Scale / 2 then
                                u364 = true;
                            else
                                u364 = false;
                            end;

                            u361 = 12;
                        end;
                    end;

                    CharScope.buildSignalData("Minigame", { UserInputService.InputBegan, function(p365) -- Line: 2102
                            -- upvalues: u2 (ref), Minigame1 (ref), handleAction (copy)
                            if p365.UserInputType == Enum.UserInputType.MouseButton1 or p365.UserInputType == Enum.UserInputType.Touch then
                                if u2.isMouseObstructedByBlackBackground(Minigame1.ZIndex) then
                                    return;
                                end;

                                handleAction();
                            end;
                        end });
                    u2.overwriteJump("minigame", handleAction);
                    local v366 = 0;

                    while u361 < 12 do
                        u361 = u361 + v366;

                        if u361 > 2 and not Minigame1.Zone.Green.Enabled then
                            Minigame1.Zone.Yellow.Enabled = false;
                            Minigame1.Zone.Green.Enabled = true;
                        end;

                        v362 = (v362 + v366 * 2 * (0.25 + u358.difficulty / 100)) % 2;
                        Minigame1.Zone.Size = UDim2.fromScale(v363 * (1 - u361 / 12), Minigame1.Zone.Size.Y.Scale);
                        Minigame1.Pointer.Position = UDim2.fromScale(math.abs(v362 - 1) * 0.9 + 0.05, 0.5);
                        v366 = task.wait();
                    end;

                    return u364;
                end;

                for i = 1, u358.rounds or 1 do
                    if not start() then
                        u2.notify({
                            message = "Failed attempt",
                            color = "red"
                        });
                        u1.startMinigame(u356);

                        return;
                    end;

                    local _ = i;
                end;

                u1.startMinigame(u356);

                return true;
            end;
        elseif u356 == "trafficBox" then
            local MinigameTrafficBox = ScreenGui.Center.Middle.MinigameTrafficBox;
            u10.guiTransition(MinigameTrafficBox, "Position", UDim2.fromScale(0, 0.1), u358.start);
            u10.contextAction("UnbindAction", "Minigame");
            focusOnMinigame(MinigameTrafficBox, false);

            if u358.start then
                GuiService.TouchControlsEnabled = false;
                u1.displayMobileGuiType(true);
                focusOnMinigame(MinigameTrafficBox, true);

                for _, child in pairs(MinigameTrafficBox.OutputWires:GetChildren()) do
                    if child.Visible then
                        child:Destroy();
                    end;
                end;

                MinigameTrafficBox.Complete.Visible = false;
                local u367 = u10.shuffleList({ 1, 2, 3 });
                local u368 = { {}, {}, {} };

                local function createWireLine(p369, p370) -- Line: 2143
                    -- upvalues: u10 (ref), MinigameTrafficBox (copy), u368 (copy)
                    local v371 = u10.clone(MinigameTrafficBox.OutputWires.WirePreview);
                    v371.Name = "Wire";
                    v371.Visible = true;
                    v371.BackgroundColor3 = MinigameTrafficBox.Output[p369].BackgroundColor3;
                    v371.Parent = MinigameTrafficBox.OutputWires;
                    u368[p369][p370] = v371;

                    return v371;
                end;

                local function updateWire(p372, ...) -- Line: 2152
                    -- upvalues: u354 (ref), MinigameTrafficBox (copy), u10 (ref), u368 (copy)
                    local v373 = { u354[p372] + Vector2.new(0, 0.083), u354[p372] };

                    for _, v in pairs({ ... }) do
                        table.insert(v373, v);
                    end;

                    MinigameTrafficBox.Output[p372].Position = UDim2.fromScale(v373[#v373].X, v373[#v373].Y);
                    local v374 = u10.smoothPointBezier(v373, 2);

                    for i = 2, #v374 do
                        local v375 = u368[p372][i];

                        if not v375 then
                            v375 = u10.clone(MinigameTrafficBox.OutputWires.WirePreview);
                            v375.Name = "Wire";
                            v375.Visible = true;
                            v375.BackgroundColor3 = MinigameTrafficBox.Output[p372].BackgroundColor3;
                            v375.Parent = MinigameTrafficBox.OutputWires;
                            u368[p372][i] = v375;
                        end;

                        local v376 = v374[i - 1].X - v374[i].X;
                        local v377 = v374[i - 1].Y - v374[i].Y;
                        v375.Position = UDim2.fromScale((v374[i - 1].X + v374[i].X) / 2, (v374[i - 1].Y + v374[i].Y) / 2);
                        v375.Size = UDim2.fromScale(0.01, Vector2.new(v376, v377).Magnitude + 0.002, 0);
                        local math_atan2_ret = math.atan2(v377, v376);
                        v375.Rotation = math.deg(math_atan2_ret) - 90;
                        local _ = i;
                    end;

                    for i = #v374 + 1, #u368[p372] do
                        u368[p372][i]:Destroy();
                        u368[p372][i] = nil;
                        local _ = i;
                    end;
                end;

                local u378 = nil;
                local u379 = nil;
                local u380 = {};
                local u381 = false;
                local u382 = nil;

                for _, child in pairs(MinigameTrafficBox.Output:GetChildren()) do
                    updateWire((tonumber(child.Name)));
                end;

                CharScope.buildSignalData("Minigame", u10.buttonHoverSignalData(MinigameTrafficBox.Exit));
                CharScope.buildSignalData("Minigame", u2.mouseButton(MinigameTrafficBox.Exit, function(p383) -- Line: 2171
                    -- upvalues: u382 (ref), u1 (ref), u356 (copy)
                    if u382 == nil then
                        u382 = false;
                    end;

                    u1.startMinigame(u356);
                end));
                CharScope.buildSignalData("Minigame", { UserInputService.InputChanged, function(p384) -- Line: 2175
                        -- upvalues: u378 (ref), u379 (ref), u10 (ref), MinigameTrafficBox (copy), updateWire (copy)
                        if (p384.UserInputType == Enum.UserInputType.MouseMovement or p384.UserInputType == Enum.UserInputType.Touch) and u378 then
                            local Vector2_new_ret2 = Vector2.new(p384.Position.X, p384.Position.Y);

                            if not u379 or (u379 - Vector2_new_ret2).Magnitude > 5 then
                                u379 = Vector2_new_ret2;
                                local v385 = u10.guiPositionAtMouse(MinigameTrafficBox);
                                updateWire(u378, Vector2.new(v385.X.Scale, v385.Y.Scale + 0.083), Vector2.new(v385.X.Scale, v385.Y.Scale));
                            end;
                        end;
                    end });
                CharScope.buildSignalData("Minigame", { UserInputService.InputEnded, function(p386) -- Line: 2185
                        -- upvalues: u378 (ref), MinigameTrafficBox (copy), u10 (ref), u380 (copy), updateWire (copy), u379 (ref), u381 (ref), u382 (ref), u367 (copy)
                        if (p386.UserInputType == Enum.UserInputType.MouseButton1 or p386.UserInputType == Enum.UserInputType.Touch) and u378 then
                            for _, child in pairs(MinigameTrafficBox.Input:GetChildren()) do
                                if u10.isInFrame(child.MouseBound, nil, true) then
                                    local v387 = child;

                                    for i, v in pairs(u380) do
                                        if v == tonumber(v387.Name) then
                                            u380[i] = nil;
                                            updateWire(i);
                                        end;
                                    end;

                                    u380[u378] = tonumber(v387.Name);
                                    local Vector2_new_ret2 = Vector2.new(v387.Position.X.Scale, v387.Position.Y.Scale + (MinigameTrafficBox.Output[u378].Size.Y.Scale / 2 + v387.Size.Y.Scale / 2) * (v387.Rotation == 180 and -1 or 1));
                                    updateWire(u378, Vector2_new_ret2 + Vector2.new(0, 0.083 * (v387.Rotation == 180 and -1 or 1)), Vector2_new_ret2);
                                    u378 = nil;
                                    u379 = nil;

                                    if u10.indexedTableSize(u380) >= 3 then
                                        u381 = true;
                                        task.wait(0.5);
                                        u381 = false;
                                        u382 = true;

                                        for i, v in pairs(u367) do
                                            if u380[i] ~= v then
                                                updateWire(i);
                                                u380[i] = nil;
                                                u382 = nil;
                                            end;
                                        end;

                                        if u382 then
                                            MinigameTrafficBox.Complete.Visible = true;
                                            MinigameTrafficBox.Complete.Bottomline.Text = "REBOOTING TRAFFIC LIGHTS...";
                                            task.wait(2);
                                            MinigameTrafficBox.Complete.Bottomline.Text = "STATUS: OK";
                                        end;
                                    end;

                                    return;
                                end;
                            end;

                            updateWire(u378);
                            u378 = nil;
                            u379 = nil;
                        end;
                    end });

                for _, child in pairs(MinigameTrafficBox.Output:GetChildren()) do
                    CharScope.buildSignalData("Minigame", u2.mouseButton(child.MouseBound, function() -- Line: 2226
                        -- upvalues: u382 (ref), u381 (ref), u378 (ref), child (copy), u379 (ref), u380 (copy)
                        if not (u382 or u381) then
                            u378 = tonumber(child.Name);
                            u379 = nil;
                            u380[tonumber(child.Name)] = nil;
                        end;
                    end));
                end;

                for i = 1, u358.duration do
                    task.wait(1);

                    if u382 ~= nil then
                        break;
                    end;

                    local _ = i;
                end;

                return u382;
            end;
        end;
    end;

    local Objective = HackingMinigames.Standard.Center.Objective;
    local u388 = 0;
    local u389 = nil;
    local u390 = nil;
    local u391 = nil;

    function u1.hackingMinigame(u392, u393, u394) -- Line: 2248
        -- upvalues: GameRules (ref), u2 (ref), CharScope (ref), u388 (ref), u389 (ref), u390 (ref), u10 (ref), u1 (ref), HackingMinigames (copy), u391 (ref), u45 (ref), GuiService (ref), Objective (copy), Mobile (copy), ScreenGui (copy), PlayerGui (ref), UserInputService (ref), Mouse (ref)
        if GameRules.disableHacking then
            return true;
        end;

        if u2.openedGui and u2.openedGui ~= "Hacking" then
            return;
        end;

        u2.openGui(u392 and "Hacking", true);
        CharScope.setConnectionsAndThreads("HackingMinigame");
        CharScope.setConnectionsAndThreads("HackingMinigameRound");

        if game.SoundService.Hacking.Timer.IsPlaying then
            game.SoundService.Hacking.Timer:Stop();
        end;

        if game.SoundService.Hacking.StartUp.IsPlaying then
            game.SoundService.Hacking.StartUp:Stop();
        end;

        u388 = (u388 + 1) % 100;
        local v395 = u388;

        if u389 then
            u389();
            u389 = nil;
        end;

        if u390 then
            u390();
            u390 = nil;
        end;

        local function clearData() -- Line: 2260
            -- upvalues: CharScope (ref)
            CharScope.setConnectionsAndThreads("HackingMinigameRound");

            if game.SoundService.Hacking.Timer.IsPlaying then
                game.SoundService.Hacking.Timer:Stop();
            end;
        end;

        u10.lockScroll("Hacking", u392);
        u1.lockHumanoidState("Hacking", u392 and -1);
        u10.guiTransition(HackingMinigames, "Size", 0.95, u392);
        u2.activateBlur("hacking", u392);

        if u392 then
            u391 = u45;
            GuiService.TouchControlsEnabled = nil;
            u1.displayMobileGuiType(true);
        else
            local v396 = u391;
            GuiService.TouchControlsEnabled = v396;
            u1.displayMobileGuiType(v396 and (u10.typeOf(v396) == "string" and v396 or "Character") or true);
        end;

        if u392 then
            local u397 = nil;
            CharScope.buildSignalData("HackingMinigame", u10.buttonHoverSignalData(HackingMinigames.StartUp.Right.Close));
            CharScope.buildSignalData("HackingMinigame", u2.mouseButton(HackingMinigames.StartUp.Right.Close, function() -- Line: 2275
                -- upvalues: u397 (ref), u1 (ref)
                u397 = "notStarted";
                u1.hackingMinigame();
            end, {
                addMobileButton = true
            }));
            CharScope.buildSignalData("HackingMinigame", u10.buttonHoverSignalData(HackingMinigames.Standard.Right.Close));
            CharScope.buildSignalData("HackingMinigame", u2.mouseButton(HackingMinigames.Standard.Right.Close, function() -- Line: 2280
                -- upvalues: u397 (ref), u1 (ref)
                if u397 == nil then
                    u397 = false;
                end;

                u1.hackingMinigame();
            end, {
                addMobileButton = true
            }));
            CharScope.addThreadOrCleanUpFunction("HackingMinigame", CharScope.taskSpawn(function() -- Line: 2284
                -- upvalues: u2 (ref), CharScope (ref), u1 (ref), u394 (copy), u10 (ref), u393 (copy), HackingMinigames (ref), u392 (copy), u389 (ref), u397 (ref), u390 (ref), Objective (ref), Mobile (ref), ScreenGui (ref), PlayerGui (ref), UserInputService (ref), Mouse (ref)
                u2.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "HackingMinigame", function() -- Line: 2285
                    -- upvalues: u1 (ref)
                    u1.hackingMinigame();
                end);
                CharScope.buildSignalData("HackingMinigame", { u394.Destroying, function() -- Line: 2288
                        -- upvalues: u1 (ref)
                        u1.hackingMinigame();
                    end });
                local v398 = u10.isPrivateServerConfigurationSettingEnabled("hackingDifficulty");

                if v398 then
                    u393.totalTime = math.round(u393.totalTime * 0.5);

                    if v398 == "2" then
                        u393.totalRounds = u393.totalRounds * 2;
                    end;
                end;

                for _, child in pairs(HackingMinigames:GetChildren()) do
                    if child:IsA("Frame") and child.Name ~= "_Black" then
                        child.Visible = false;
                    end;
                end;

                HackingMinigames.StartUp.Visible = true;
                HackingMinigames.StartUp.Center.HackingDifficultyHard.Visible = u393.hard;
                HackingMinigames.StartUp.Center.Title.Text = string.upper(u393.title);
                local Value = (u393.layout and HackingMinigames[u392][u393.layout] or HackingMinigames[u392]).GuiWidth.Value;
                HackingMinigames.StartUp.Size = UDim2.fromScale(Value, HackingMinigames.StartUp.Size.Y.Scale);
                game.SoundService.Hacking.StartUp:Play();
                task.wait(3);
                game.SoundService.Hacking.StartUp:Stop();
                HackingMinigames.StartUp.Visible = false;
                HackingMinigames[u392].Visible = true;
                HackingMinigames.Standard.Visible = true;
                HackingMinigames.Standard.Size = UDim2.fromScale(Value, HackingMinigames.Standard.Size.Y.Scale);

                for _, child in pairs(HackingMinigames.Standard.Center.Rounds:GetChildren()) do
                    if child:IsA("ImageLabel") then
                        child.Visible = tonumber(child.Name) <= u393.totalRounds;
                        child.ImageColor3 = Color3.fromRGB(163, 163, 163);
                    end;
                end;

                for _, child in pairs(HackingMinigames.Standard.Right.DifficultyVisual:GetChildren()) do
                    if child:IsA("ImageLabel") then
                        child.Visible = tonumber(child.Name) >= 6 - u393.visualDifficulty;
                    end;
                end;

                local CustomTimer = HackingMinigames[u392]:FindFirstChild("CustomTimer");
                HackingMinigames.Standard.Left.Timer.Position = UDim2.fromScale(HackingMinigames.Standard.Left.Timer.Position.X.Scale, CustomTimer and 0.13 or 0.054);
                HackingMinigames.Standard.TimerBar.Position = UDim2.fromScale(HackingMinigames.Standard.TimerBar.Position.X.Scale, CustomTimer and 0.16 or 0.083);

                local function finish(p399) -- Line: 2316
                    -- upvalues: u389 (ref), CharScope (ref), HackingMinigames (ref), u10 (ref), u2 (ref), u1 (ref), u397 (ref)
                    if u389 then
                        u389();
                        u389 = nil;
                    end;

                    CharScope.setConnectionsAndThreads("HackingMinigameRound");

                    if game.SoundService.Hacking.Timer.IsPlaying then
                        game.SoundService.Hacking.Timer:Stop();
                    end;

                    game.SoundService.Hacking[p399 and "AccessGranted" or "AccessDenied"]:Play();
                    local u400 = p399 and HackingMinigames.Finish.Granted or HackingMinigames.Finish.Denied;
                    HackingMinigames.Finish.Visible = true;
                    HackingMinigames.Finish.TextLabel.Visible = false;
                    HackingMinigames.Finish.Granted.Visible = false;
                    HackingMinigames.Finish.Denied.Visible = false;
                    HackingMinigames.Finish.Outline.ImageColor3 = p399 and Color3.fromRGB(133, 255, 172) or Color3.fromRGB(255, 130, 130);
                    HackingMinigames.Finish.TextLabel.Text = p399 and "ACCESS GRANTED" or "ACCESS DENIED";
                    HackingMinigames.Finish.TextLabel.TextColor3 = p399 and Color3.fromRGB(133, 255, 172) or Color3.fromRGB(255, 130, 130);
                    CharScope.buildSignalData("HackingMinigameRound", u10.buttonHoverSignalData(HackingMinigames.Finish.Exit));
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(HackingMinigames.Finish.Exit, function() -- Line: 2329
                        -- upvalues: u1 (ref)
                        u1.hackingMinigame();
                    end));
                    CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(function() -- Line: 2330
                        -- upvalues: u400 (copy), HackingMinigames (ref)
                        while true do
                            u400.Visible = not u400.Visible;
                            HackingMinigames.Finish.TextLabel.Visible = u400.Visible;
                            task.wait(u400.Visible and 1 or 0.5);
                        end;
                    end));
                    u397 = p399;
                end;

                local function updateTimer(p401) -- Line: 2339
                    -- upvalues: HackingMinigames (ref), u393 (ref)
                    HackingMinigames.Standard.Left.Timer.Text = string.format("%.02d.%.02d", p401, (math.floor(p401 % 1 * 100)));
                    HackingMinigames.Standard.TimerBar.Bar.Size = UDim2.fromScale(p401 / u393.totalTime, 1);
                end;

                local function startTimer() -- Line: 2343
                    -- upvalues: u393 (ref), HackingMinigames (ref), finish (copy)
                    local totalTime = u393.totalTime;

                    while totalTime > 0 do
                        HackingMinigames.Standard.Left.Timer.Text = string.format("%.02d.%.02d", totalTime, (math.floor(totalTime % 1 * 100)));
                        HackingMinigames.Standard.TimerBar.Bar.Size = UDim2.fromScale(totalTime / u393.totalTime, 1);

                        if totalTime / u393.totalTime < 0.2 and not game.SoundService.Hacking.Timer.IsPlaying then
                            game.SoundService.Hacking.Timer:Play();
                        end;

                        totalTime = totalTime - task.wait();
                    end;

                    if totalTime <= 0 then
                        HackingMinigames.Standard.Left.Timer.Text = string.format("%.02d.%.02d", 0, 0);
                        HackingMinigames.Standard.TimerBar.Bar.Size = UDim2.fromScale(0 / u393.totalTime, 1);
                        finish(false);
                    end;
                end;

                local u402 = 0;

                local function nextRound() -- Line: 2353
                    -- upvalues: u402 (ref), HackingMinigames (ref), u390 (ref), CharScope (ref), u393 (ref), finish (copy), u392 (ref), u1 (ref), Objective (ref), startTimer (copy), nextRound (copy), u10 (ref), u2 (ref), Mobile (ref), ScreenGui (ref), PlayerGui (ref), UserInputService (ref), u389 (ref), Mouse (ref)
                    if u402 > 0 then
                        HackingMinigames.Standard.Center.Rounds[u402].ImageColor3 = Color3.fromRGB(255, 255, 255);
                    end;

                    u402 = u402 + 1;

                    if u390 then
                        u390();
                        u390 = nil;
                    end;

                    CharScope.setConnectionsAndThreads("HackingMinigameRound");

                    if game.SoundService.Hacking.Timer.IsPlaying then
                        game.SoundService.Hacking.Timer:Stop();
                    end;

                    if u402 > u393.totalRounds then
                        return finish(true);
                    end;

                    if u402 > 1 then
                        game.SoundService.Hacking.AccessGranted:Play();
                        task.wait(3);
                    end;

                    if u392 ~= "Virus Hack" then
                        if u392 == "Terminal Hack" then
                            Objective.Text = "";
                            CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));
                            local v403 = nil;
                            local v404 = u393.stringType[u402];

                            if v404 == "numbersAndLetters" then
                                v403 = function() -- Line: 2482, Name: generateString
                                    local v405 = "";

                                    for i = 1, 3 do
                                        local math_random_ret = math.random(0, 35);
                                        v405 = v405 .. (math_random_ret < 10 and math_random_ret and math_random_ret or string.char(math_random_ret + 55));
                                        local _ = i;
                                    end;

                                    return v405;
                                end;
                            elseif v404 == "math" then
                                local u406 = { "α", "β", "Γ", "π", "Σ", "σ", "µ", "τ", "Φ", "Ω", "δ", "φ", "ε", "≡", "±", "¿", "¥", "£", "¢", "Æ", "æ", "µ" };
                                local u407 = #u406;

                                v403 = function() -- Line: 2493, Name: generateString
                                    -- upvalues: u406 (copy), u407 (copy)
                                    return (("" .. u406[math.random(u407)]) .. u406[math.random(u407)]) .. u406[math.random(u407)];
                                end;
                            end;

                            local u408 = 0;
                            local v409 = { v403(), v403(), v403() };
                            HackingMinigames[u392].Sequence.Text = string.upper(table.concat(v409, " "));
                            local u410 = #HackingMinigames[u392].Grid:GetChildren() - 1;
                            local FillDirectionMaxCells = HackingMinigames[u392].Grid.UIGridLayout.FillDirectionMaxCells;
                            local math_random_ret = math.random(2, u410 - 1);
                            local u411 = nil;
                            local u412 = nil;

                            local function highlight(p413, u414) -- Line: 2507
                                -- upvalues: HackingMinigames (ref), u392 (ref), u412 (ref), FillDirectionMaxCells (copy)
                                local function highlightRow(p415, p416) -- Line: 2508
                                    -- upvalues: HackingMinigames (ref), u392 (ref), u414 (copy)
                                    for i = -1, 1 do
                                        HackingMinigames[u392].Grid[p415 + i].TextLabel.TextColor3 = p416 and (u414 or Color3.fromRGB(25, 167, 255)) or Color3.fromRGB(255, 255, 255);
                                        local _ = i;
                                    end;
                                end;

                                if u412 then
                                    highlightRow(u412, false);
                                    u412 = nil;
                                end;

                                if p413 then
                                    u412 = (math.ceil(p413 / FillDirectionMaxCells) - 1) * FillDirectionMaxCells + math.clamp((p413 - 1) % FillDirectionMaxCells + 1, 2, FillDirectionMaxCells - 1);
                                    highlightRow(u412, true);
                                end;
                            end;

                            for i = 1, u410 do
                                local v417 = HackingMinigames[u392].Grid[i];
                                v417.TextLabel.Text = string.upper(math_random_ret - 1 <= i and i <= math_random_ret + 1 and v409[i - math_random_ret + 2] or v403());
                                v417.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                                local _ = i;
                            end;

                            local function u419() -- Line: 2522
                                -- upvalues: u2 (ref), PlayerGui (ref), HackingMinigames (ref), u392 (ref), u411 (ref), highlight (copy)
                                local v418 = u2.getMouseProperty.position("Persistent");

                                for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(v418.X, v418.Y + (u2.platform == "Mobile" and -40 or 0))) do
                                    if v.Parent == HackingMinigames[u392].Grid then
                                        u411 = tonumber(v.Name);
                                        highlight(u411);

                                        return;
                                    end;
                                end;

                                if u411 then
                                    u411 = nil;
                                    highlight();
                                end;
                            end;

                            local function click() -- Line: 2536
                                -- upvalues: u411 (ref), u412 (ref), math_random_ret (ref), highlight (copy), nextRound (ref), u408 (ref), finish (ref)
                                if u411 then
                                    if u412 == math_random_ret then
                                        highlight(u411, Color3.fromRGB(87, 207, 95));
                                        nextRound();

                                        return;
                                    end;

                                    highlight(u411, Color3.fromRGB(207, 80, 82));
                                    u408 = u408 + 1;
                                    game.SoundService.Hacking.Error:Play();

                                    if u408 >= 3 then
                                        return finish(false);
                                    end;
                                end;
                            end;

                            CharScope.buildSignalData("HackingMinigameRound", { UserInputService.InputChanged, function(p420) -- Line: 2549
                                    -- upvalues: u419 (copy)
                                    if p420.UserInputType == Enum.UserInputType.MouseMovement or p420.UserInputType == Enum.UserInputType.Touch then
                                        u419();
                                    end;
                                end });
                            CharScope.buildSignalData("HackingMinigameRound", { UserInputService.InputBegan, function(p421) -- Line: 2554
                                    -- upvalues: u2 (ref), HackingMinigames (ref), u392 (ref), u10 (ref), click (copy), CharScope (ref), u419 (copy)
                                    if p421.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                        if p421.UserInputType == Enum.UserInputType.Touch then
                                            if u2.isMouseObstructedByBlackBackground(HackingMinigames[u392].ZIndex) then
                                                return;
                                            end;

                                            CharScope.taskDelay(0.03, u419);
                                            u2.mobileInputServiceClick();
                                            click();
                                        end;

                                        return;
                                    end;

                                    if u2.isMouseObstructedByBlackBackground(HackingMinigames[u392].ZIndex) or u10.isInFrame(HackingMinigames.Standard.Right.Close) then
                                        return;
                                    end;

                                    click();
                                end });
                            CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(function() -- Line: 2565
                                -- upvalues: HackingMinigames (ref), u392 (ref), u410 (copy), math_random_ret (ref), u393 (ref)
                                while true do
                                    local Text = HackingMinigames[u392].Grid[50].TextLabel.Text;

                                    for i = u410, 2, -1 do
                                        HackingMinigames[u392].Grid[i].TextLabel.Text = HackingMinigames[u392].Grid[(i - 2) % u410 + 1].TextLabel.Text;
                                        local _ = i;
                                    end;

                                    HackingMinigames[u392].Grid[1].TextLabel.Text = Text;
                                    math_random_ret = math_random_ret % u410 + 1;
                                    task.wait(u393.refreshSpeed);
                                end;
                            end));

                            return;
                        end;

                        if u392 ~= "ATM Hack" then
                            if u392 ~= "Pattern Hack" then
                                if u392 ~= "Number Hack" then
                                    if u392 == "Lockpick" then
                                        u1.keepMobileGuiTypePersistent("Lockpick", true);
                                        Objective.Text = "MATCH LINE COLOR WITH THE CIRCLE COLOR";
                                        CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));

                                        for _, child in pairs(HackingMinigames[u392]:GetChildren()) do
                                            if child:IsA("Frame") then
                                                child.Visible = child.Name == u393.layout;
                                            end;
                                        end;

                                        local u422 = HackingMinigames[u392][u393.layout];
                                        local v423 = {
                                            red = Color3.fromRGB(255, 108, 108),
                                            green = Color3.fromRGB(89, 216, 148),
                                            blue = Color3.fromRGB(106, 173, 255)
                                        };
                                        local string_sub_ret = string.sub(u393.layout, 1, 1);
                                        local u424 = tonumber(string_sub_ret);
                                        local u425 = {};
                                        local u426 = {};

                                        local function rotateCircle(p427, p428, p429) -- Line: 2775
                                            -- upvalues: u425 (copy), u426 (copy), u422 (copy)
                                            u425[p427] = ((u425[p427] or 0) + p428) % #u426[p427];

                                            if p429 then
                                                u422["Circle" .. p427].Rotation = u425[p427] * (360 / #u426[p427]);
                                            end;
                                        end;

                                        local v430 = { "red", "green", "blue" };

                                        for i = 1, u424 do
                                            u426[i] = {};
                                            local v431 = i;

                                            for i2 = 1, #u422["Circle" .. i].Dots:GetChildren() do
                                                local math_random_ret = math.random(#v430);
                                                u422["CircleTarget" .. v431][i2].Visible = false;
                                                u422["CircleTarget" .. v431][i2].Line.ImageColor3 = v423[v430[math_random_ret]];
                                                u422["Circle" .. v431].Dots[i2].ImageColor3 = v423[v430[math_random_ret]];
                                                u426[v431][i2] = math_random_ret;
                                                local _ = i2;
                                            end;

                                            local v432 = math.random(1, #u426[v431]) - 1;
                                            u425[v431] = ((u425[v431] or 0) + v432) % #u426[v431];
                                            u422["Circle" .. v431].Rotation = u425[v431] * (360 / #u426[v431]);
                                            local math_random_ret = math.random(3, 7);

                                            for i2, child in pairs(u10.shuffleList(u422["CircleTarget" .. v431]:GetChildren())) do
                                                child.Visible = true;

                                                if math_random_ret <= i2 then
                                                    break;
                                                end;
                                            end;
                                        end;

                                        CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(function() -- Line: 2795
                                            -- upvalues: u424 (copy), u422 (copy), u10 (ref), u425 (copy), u426 (copy)
                                            while true do
                                                for i = 1, u424 do
                                                    u422["Circle" .. i].Rotation = u10.lerpAngleDeg(u422["Circle" .. i].Rotation, u425[i] * (360 / #u426[i]), 0.2);
                                                    local _ = i;
                                                end;

                                                task.wait();
                                            end;
                                        end));

                                        u389 = function() -- Line: 2801, Name: finishFunc
                                            -- upvalues: u1 (ref), u10 (ref)
                                            u1.keepMobileGuiTypePersistent("Lockpick", false);
                                            u10.contextAction("UnbindAction", "LockpickHack");
                                        end;

                                        u10.contextAction("BindActionAtPriority", "LockpickHack", function() -- Line: 2805
                                            return Enum.ContextActionResult.Sink;
                                        end, false, Enum.ContextActionPriority.High.Value + 1, Enum.KeyCode.Left, Enum.KeyCode.Right);
                                        local u433 = 0;

                                        local function nextCircle() -- Line: 2808
                                            -- upvalues: u433 (ref), u426 (copy), u422 (copy), u425 (copy), finish (ref), u424 (copy), nextRound (ref)
                                            if u433 > 0 then
                                                local v434 = #u426[u433];

                                                for i, v in pairs(u426[u433]) do
                                                    if u422["CircleTarget" .. u433][i].Visible and v ~= u426[u433][(i - u425[u433] - 1) % v434 + 1] then
                                                        return finish(false);
                                                    end;
                                                end;

                                                game.SoundService.Hacking.Lock:Play();
                                            end;

                                            u433 = u433 + 1;

                                            for i = 1, u424 do
                                                local v435 = u433 ~= i;

                                                for _, descendant in pairs(u422["Circle" .. i]:GetDescendants()) do
                                                    if descendant.Name == "UIGradient" then
                                                        descendant.Enabled = v435;
                                                    end;
                                                end;

                                                for _, descendant in pairs(u422["CircleTarget" .. i]:GetDescendants()) do
                                                    if descendant.Name == "UIGradient" then
                                                        descendant.Enabled = v435;
                                                    end;
                                                end;
                                            end;

                                            if u424 < u433 then
                                                return nextRound();
                                            end;
                                        end;

                                        nextCircle();
                                        CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(Mobile.Lockpick.Unlock, function() -- Line: 2831
                                            -- upvalues: nextCircle (copy)
                                            nextCircle();
                                        end));
                                        CharScope.buildSignalData("HackingMinigameRound", { UserInputService.InputBegan, function(p436, p437) -- Line: 2832
                                                -- upvalues: u2 (ref), HackingMinigames (ref), u392 (ref), u10 (ref), Mobile (ref), u433 (ref), Mouse (ref), u425 (copy), u426 (copy), nextCircle (copy)
                                                if p436.UserInputType == Enum.UserInputType.MouseButton1 or p436.UserInputType == Enum.UserInputType.Touch then
                                                    if u2.isMouseObstructedByBlackBackground(HackingMinigames[u392].ZIndex) or u10.isInFrame(HackingMinigames.Standard.Right.Close) then
                                                        return;
                                                    end;

                                                    if not (p437 and (u2.platform ~= "Mobile" or u10.isInFrame(Mobile.Lockpick.Unlock))) then
                                                        local v438 = u433;
                                                        local v439 = u10.getMousePos().X < Mouse.ViewSizeX / 2 and -1 or 1;
                                                        u425[v438] = ((u425[v438] or 0) + v439) % #u426[v438];
                                                    end;
                                                elseif u2.canPressKey(p436.KeyCode) then
                                                    if p436.KeyCode == Enum.KeyCode.Left or p436.KeyCode == Enum.KeyCode.A then
                                                        local v440 = u433;
                                                        u425[v440] = ((u425[v440] or 0) + -1) % #u426[v440];

                                                        return;
                                                    end;

                                                    if p436.KeyCode == Enum.KeyCode.Right or p436.KeyCode == Enum.KeyCode.D then
                                                        local v441 = u433;
                                                        u425[v441] = ((u425[v441] or 0) + 1) % #u426[v441];

                                                        return;
                                                    end;

                                                    if p436.KeyCode == Enum.KeyCode.Space then
                                                        nextCircle();
                                                    end;
                                                end;
                                            end });
                                    end;

                                    return;
                                end;

                                Objective.Text = "SORT NUMBERS FROM 1 TO " .. #HackingMinigames[u392][u393.layout]:GetChildren() - 2;
                                CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));
                                local u442 = 0;
                                local u443 = 1;
                                local u444 = 0;

                                for _, child in pairs(HackingMinigames[u392]:GetChildren()) do
                                    if child:IsA("Frame") then
                                        child.Visible = child.Name == u393.layout;
                                    end;
                                end;

                                for _, child in pairs(u10.shuffleList(HackingMinigames[u392][u393.layout]:GetChildren())) do
                                    if child:IsA("ImageButton") then
                                        u442 = u442 + 1;
                                        local u445 = u442;
                                        child.TextLabel.Text = u445;
                                        child.ImageColor3 = Color3.fromRGB(74, 75, 93);
                                        CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(child, function() -- Line: 2748
                                            -- upvalues: u445 (copy), u443 (ref), child (copy), u442 (ref), nextRound (ref), u444 (ref), finish (ref)
                                            if u445 == u443 then
                                                child.ImageColor3 = Color3.fromRGB(60, 115, 166);
                                                u443 = u443 + 1;

                                                if u442 < u443 then
                                                    return nextRound();
                                                end;
                                            elseif child.ImageColor3 ~= Color3.fromRGB(60, 115, 166) then
                                                child.ImageColor3 = Color3.fromRGB(193, 145, 49);
                                                u444 = u444 + 1;
                                                game.SoundService.Hacking.Error:Play();

                                                if u444 >= 3 then
                                                    return finish(false);
                                                end;
                                            end;
                                        end));
                                    end;
                                end;

                                return;
                            end;

                            Objective.Text = "MEMORIZE PATTERN";
                            local totalTime = u393.totalTime;
                            HackingMinigames.Standard.Left.Timer.Text = string.format("%.02d.%.02d", totalTime, (math.floor(totalTime % 1 * 100)));
                            HackingMinigames.Standard.TimerBar.Bar.Size = UDim2.fromScale(totalTime / u393.totalTime, 1);
                            local v446 = {};
                            local u447 = false;
                            local u448 = 0;
                            local v449 = 0;
                            local u450 = {};

                            for _, child in pairs(HackingMinigames[u392]:GetChildren()) do
                                if child:IsA("Frame") then
                                    child.Visible = child.Name == u393.layout;
                                end;
                            end;

                            for _, child in pairs(u10.shuffleList(HackingMinigames[u392][u393.layout]:GetChildren())) do
                                if child:IsA("ImageButton") then
                                    if not v446[tonumber(child.Name)] then
                                        v446[tonumber(child.Name)] = {};
                                    end;

                                    local v451 = v446[tonumber(child.Name)];
                                    table.insert(v451, child);
                                    v449 = v449 + 1;
                                    child.ImageColor3 = Color3.fromRGB(74, 75, 93);

                                    if v449 <= u393.totalSquares then
                                        u450[child] = true;
                                    end;

                                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(child, function() -- Line: 2700
                                        -- upvalues: u447 (ref), u450 (copy), child (copy), u10 (ref), nextRound (ref), u448 (ref), finish (ref)
                                        if u447 then
                                            if u450[child] then
                                                child.ImageColor3 = Color3.fromRGB(102, 161, 84);
                                                u450[child] = nil;

                                                if u10.isTableEmpty(u450) then
                                                    return nextRound();
                                                end;
                                            elseif child.ImageColor3 == Color3.fromRGB(74, 75, 93) then
                                                child.ImageColor3 = Color3.fromRGB(167, 67, 67);
                                                u448 = u448 + 1;
                                                game.SoundService.Hacking.Error:Play();

                                                if u448 >= 3 then
                                                    return finish(false);
                                                end;
                                            end;
                                        end;
                                    end));
                                end;
                            end;

                            u390 = function() -- Line: 2716, Name: finishRoundFunc
                                -- upvalues: u450 (copy)
                                for i, _ in pairs(u450) do
                                    i.ImageColor3 = Color3.fromRGB(94, 130, 175);
                                end;
                            end;

                            local v452 = tick() + 5;

                            for i = 1, 18 do
                                local _ = i;

                                for i2, v in pairs(v446) do
                                    for _, v2 in pairs(v446[(i2 - 3) % #v446 + 1]) do
                                        if u450[v2] then
                                            v2.ImageColor3 = Color3.fromRGB(74, 75, 93);
                                        end;
                                    end;

                                    for _, v2 in pairs(v) do
                                        if u450[v2] then
                                            v2.ImageColor3 = Color3.fromRGB(94, 130, 175);
                                        end;
                                    end;

                                    task.wait(0.03);
                                end;

                                if v452 < tick() then
                                    break;
                                end;
                            end;

                            Objective.Text = "RECREATE THE PATTERN";

                            for i, _ in pairs(u450) do
                                i.ImageColor3 = Color3.fromRGB(74, 75, 93);
                            end;

                            CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));

                            return;
                        end;

                        Objective.Text = "";
                        CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));
                        local v453 = #HackingMinigames[u392].List[1]:GetChildren() - 1;
                        local v454 = {};

                        local function generateString() -- Line: 2577
                            local v455 = "";

                            for i = 1, 2 do
                                local math_random_ret = math.random(0, 35);
                                v455 = v455 .. (math_random_ret < 10 and math_random_ret and math_random_ret or string.char(math_random_ret + 55));
                                local _ = i;
                            end;

                            return v455;
                        end;

                        local u456 = {};
                        local u457 = {};

                        for i = 1, 3 do
                            v454[i] = {};
                            local math_random_ret = math.random(v453);
                            local v458 = i;

                            for i2 = 1, v453 do
                                local v459 = generateString();
                                v454[v458][i2] = v459;
                                HackingMinigames[u392].List[v458][i2].TextLabel.Text = v459;
                                HackingMinigames[u392].List[v458][i2].ImageColor3 = Color3.fromRGB(74, 75, 93);
                                HackingMinigames[u392].List[v458][i2].ImageTransparency = 0.5;
                                HackingMinigames[u392].List[v458][i2].TextLabel.TextColor3 = HackingMinigames[u392].List[v458][i2].Background.ImageColor3;
                                local v460;

                                if i2 == math_random_ret then
                                    u456[v458] = v459;
                                    u457[v458] = HackingMinigames[u392].List[v458][i2].TextLabel.TextColor3;
                                    v460 = i2;
                                else
                                    v460 = i2;
                                end;
                            end;
                        end;

                        local string_upper_ret = string.upper(table.concat(u456, " "));
                        HackingMinigames[u392].Sequence1.Text = string_upper_ret;
                        HackingMinigames[u392].Sequence2.Text = string_upper_ret;
                        HackingMinigames[u392].Sequence3.Text = string_upper_ret;
                        local u461 = nil;
                        local u462 = 0;
                        local u463 = nil;
                        local u464 = 0;
                        local u465 = u10.shuffleList({ { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }, { 1, 3, 2, 4, 3, 5, 4, 6, 5, 7, 6, 8, 7, 9, 8, 10, 9, 11, 10, 12, 11 }, { 1, 12, 2, 11, 3, 10, 4, 9, 5, 8, 6, 7 }, { 1, 3, 5, 7, 9, 11, 2, 4, 6, 8, 10, 12 }, { 1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }, { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 }, { 6, 5, 4, 3, 2, 1, 7, 8, 9, 10, 11, 12 } });

                        local function nextRow() -- Line: 2622
                            -- upvalues: u462 (ref), u463 (ref), u10 (ref), HackingMinigames (ref), u392 (ref), u457 (copy), u461 (ref), CharScope (ref), u465 (copy), u393 (ref)
                            u462 = u462 + 1;

                            if u463 then
                                u10.taskCancel(u463);
                            end;

                            HackingMinigames[u392].Sequence3.MaxVisibleGraphemes = (u462 - 1) * 3;
                            HackingMinigames[u392].Sequence2.MaxVisibleGraphemes = u462 * 3;
                            HackingMinigames[u392].Sequence2.TextColor3 = u457[u462];
                            u461 = nil;
                            u463 = CharScope.taskSpawn(function() -- Line: 2629
                                -- upvalues: u465 (ref), u462 (ref), u461 (ref), HackingMinigames (ref), u392 (ref), u393 (ref)
                                while true do
                                    for _, v in pairs(u465[u462]) do
                                        if u461 then
                                            u461.ImageColor3 = Color3.fromRGB(74, 75, 93);
                                            u461.ImageTransparency = 0.5;
                                            u461.TextLabel.TextColor3 = u461.Background.ImageColor3;
                                        end;

                                        u461 = HackingMinigames[u392].List[u462][v];
                                        u461.ImageColor3 = u461.Background.ImageColor3;
                                        u461.ImageTransparency = 0;
                                        u461.TextLabel.TextColor3 = Color3.fromRGB(88, 88, 88);
                                        task.wait(u393.refreshSpeed);
                                    end;
                                end;
                            end);
                            CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", u463);
                        end;

                        nextRow();

                        local function u467() -- Line: 2648
                            -- upvalues: u461 (ref), u456 (copy), u462 (ref), HackingMinigames (ref), u392 (ref), nextRound (ref), nextRow (copy), u464 (ref), finish (ref), CharScope (ref)
                            if u461 then
                                if u461.TextLabel.Text == u456[u462] then
                                    game.SoundService.Hacking.AccessGranted:Play();

                                    if u462 < 3 then
                                        nextRow();

                                        return;
                                    end;

                                    HackingMinigames[u392].Sequence3.MaxVisibleGraphemes = -1;
                                    nextRound();

                                    return;
                                end;

                                u464 = u464 + 1;
                                u461.ImageColor3 = Color3.fromRGB(143, 25, 25);
                                u461.ImageTransparency = 0.5;
                                u461.TextLabel.TextColor3 = u461.Background.ImageColor3;
                                game.SoundService.Hacking.Error:Play();

                                if u464 >= 3 then
                                    finish(false);

                                    return;
                                end;

                                local u466 = u461;
                                u461 = nil;
                                CharScope.taskDelay(0.5, function() -- Line: 2666
                                    -- upvalues: u466 (copy)
                                    if u466.ImageColor3 == Color3.fromRGB(143, 25, 25) then
                                        u466.ImageColor3 = Color3.fromRGB(74, 75, 93);
                                    end;
                                end);
                            end;
                        end;

                        CharScope.buildSignalData("HackingMinigameRound", { UserInputService.InputBegan, function(p468) -- Line: 2671
                                -- upvalues: u2 (ref), HackingMinigames (ref), u392 (ref), u10 (ref), u467 (copy)
                                if p468.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if u2.isMouseObstructedByBlackBackground(HackingMinigames[u392].ZIndex) or u10.isInFrame(HackingMinigames.Standard.Right.Close) then
                                        return;
                                    end;

                                    u467();

                                    return;
                                end;

                                if p468.UserInputType ~= Enum.UserInputType.Touch then
                                    if p468.KeyCode == Enum.KeyCode.Space then
                                        u467();
                                    end;

                                    return;
                                end;

                                if u2.isMouseObstructedByBlackBackground(HackingMinigames[u392].ZIndex) or u10.isInFrame(HackingMinigames.Standard.Right.Close) then
                                    return;
                                end;

                                u467();
                            end });

                        return;
                    end;

                    u1.displayMobileGuiType("VirusHack");
                    Objective.Text = "TRAP THE VIRUS";
                    CharScope.addThreadOrCleanUpFunction("HackingMinigameRound", CharScope.taskSpawn(startTimer));
                    local u469 = {};

                    local function setWall(p470) -- Line: 2369
                        -- upvalues: u469 (copy)
                        u469[p470][1].ImageColor3 = Color3.fromRGB(147, 142, 78);
                        u469[p470][2] = true;
                    end;

                    local v471 = {
                        Vector2.new(6, 7),
                        Vector2.new(7, 7),
                        Vector2.new(7, 8),
                        Vector2.new(8, 8),
                        Vector2.new(9, 8),
                        Vector2.new(9, 9),
                        Vector2.new(10, 9),
                        Vector2.new(11, 9),
                        Vector2.new(11, 10),
                        Vector2.new(12, 10),
                        Vector2.new(13, 10),
                        Vector2.new(13, 11),
                        Vector2.new(14, 11)
                    };
                    local u472 = v471[math.random(#v471)];

                    local function getBugPos(p473) -- Line: 2375
                        -- upvalues: HackingMinigames (ref), u392 (ref)
                        return (p473.AbsolutePosition.X + p473.AbsoluteSize.X / 2 - HackingMinigames[u392].AbsolutePosition.X) / HackingMinigames[u392].AbsoluteSize.X, (p473.AbsolutePosition.Y + p473.AbsoluteSize.Y / 2 - HackingMinigames[u392].AbsolutePosition.Y) / HackingMinigames[u392].AbsoluteSize.Y;
                    end;

                    local u474 = {
                        Vector2.new(0, 1),
                        Vector2.new(1, 1),
                        Vector2.new(1, 0),
                        Vector2.new(0, -1),
                        Vector2.new(-1, -1),
                        Vector2.new(-1, 0)
                    };
                    local u475 = #u474;
                    local u476 = {};
                    local Vector2_new_ret2 = Vector2.new(18, 16);
                    HackingMinigames[u392].Bug.ImageColor3 = Color3.fromRGB(99, 181, 98);

                    local function moveBug() -- Line: 2384
                        -- upvalues: u476 (copy), u472 (ref), Vector2_new_ret2 (copy), u475 (copy), u474 (copy), u469 (copy), HackingMinigames (ref), u392 (ref), getBugPos (copy), finish (ref), nextRound (ref)
                        for i, _ in pairs(u476) do
                            u476[i] = u476[i] + 1;
                        end;

                        local v477 = 99;
                        local u478;

                        if u472.X < v477 then
                            v477 = u472.X;
                            u478 = 6;
                        else
                            u478 = 0;
                        end;

                        if Vector2_new_ret2.X - u472.X < v477 then
                            v477 = Vector2_new_ret2.X - u472.X;
                            u478 = 3;
                        end;

                        if u472.Y < v477 then
                            v477 = u472.Y;
                            u478 = 4;
                        end;

                        if Vector2_new_ret2.Y - u472.Y < v477 then
                            local _ = Vector2_new_ret2.Y - u472.Y;
                            u478 = 1;
                        end;

                        local function calculate(p479) -- Line: 2391
                            -- upvalues: u478 (ref), u475 (ref), u472 (ref), u474 (ref)
                            local v480 = (u478 + p479 - 1) % u475 + 1;

                            return u472.X + u474[v480].X, u472.Y + u474[v480].Y;
                        end;

                        local v481 = 0;
                        local v482 = nil;

                        for _, v in pairs({ 0, 1, -1, -2, 2, 3 }) do
                            local v483 = (u478 + v - 1) % u475 + 1;
                            local v484 = u472.X + u474[v483].X;
                            local v485 = u472.Y + u474[v483].Y;

                            if not (u469[v484 .. "-" .. v485] and u469[v484 .. "-" .. v485][2]) then
                                if u469[v484 .. "-" .. v485] then
                                    local v486 = u476[v484 .. "-" .. v485];

                                    if not v486 then
                                        u472 = Vector2.new(v484, v485);
                                        u476[v484 .. "-" .. v485] = 1;
                                        HackingMinigames[u392].Bug:TweenPosition(UDim2.fromScale(getBugPos(u469[v484 .. "-" .. v485][1])), "Out", "Quint", 1, true);

                                        return;
                                    end;

                                    if v481 < v486 then
                                        v482 = Vector2.new(v484, v485);
                                        v481 = v486;
                                    end;
                                elseif not v482 then
                                    local v487 = (u478 + (v + 3) - 1) % u475 + 1;
                                    local v488 = u472.X + u474[v487].X;
                                    local v489 = u472.Y + u474[v487].Y;
                                    local UDim2_fromScale_ret = UDim2.fromScale(getBugPos(HackingMinigames[u392].Grid:FindFirstChild(v488 .. "-" .. v489) or HackingMinigames[u392].Grid2:FindFirstChild(v488 .. "-" .. v489)));
                                    HackingMinigames[u392].Bug:TweenPosition(HackingMinigames[u392].Bug.Position + HackingMinigames[u392].Bug.Position - UDim2_fromScale_ret, "Out", "Quint", 1, true);
                                    HackingMinigames[u392].Bug.ImageColor3 = Color3.fromRGB(181, 99, 99);

                                    return finish(false);
                                end;
                            end;
                        end;

                        if not v482 then
                            u469[u472.X .. "-" .. u472.Y][1].ImageColor3 = Color3.fromRGB(201, 204, 252);
                            nextRound();

                            return;
                        end;

                        u472 = v482;
                        u476[u472.X .. "-" .. u472.Y] = 1;
                        HackingMinigames[u392].Bug:TweenPosition(UDim2.fromScale(getBugPos(u469[u472.X .. "-" .. u472.Y][1])), "Out", "Quint", 1, true);
                    end;

                    local u490 = false;

                    for _, child in pairs(HackingMinigames[u392].Grid:GetChildren()) do
                        if child:IsA("ImageButton") then
                            u469[child.Name] = { child };
                        end;
                    end;

                    for _, child in pairs(HackingMinigames[u392].Grid2:GetChildren()) do
                        if child:IsA("ImageButton") then
                            u469[child.Name] = { child };
                        end;
                    end;

                    local function place(p491) -- Line: 2430
                        -- upvalues: u469 (copy), u472 (ref), u490 (ref), moveBug (copy)
                        if u469[p491.X .. "-" .. p491.Y] and not (u469[p491.X .. "-" .. p491.Y][2] or (p491 == u472 or u490)) then
                            u490 = true;
                            local v492 = p491.X .. "-" .. p491.Y;
                            u469[v492][1].ImageColor3 = Color3.fromRGB(147, 142, 78);
                            u469[v492][2] = true;
                            task.wait(0.4);
                            moveBug();
                            u490 = false;
                        end;
                    end;

                    local v493 = {};
                    local v494 = 0;

                    for i, v in pairs(u469) do
                        table.insert(v493, { i, v });
                    end;

                    for _, v in pairs(u10.shuffleList(v493)) do
                        local v495 = v[1];
                        local u496 = v[2];

                        if v494 < u393.wallAmount and v495 ~= u472.X .. "-" .. u472.Y then
                            v494 = v494 + 1;
                            u469[v495][1].ImageColor3 = Color3.fromRGB(147, 142, 78);
                            u469[v495][2] = true;
                        else
                            u496[1].ImageColor3 = Color3.fromRGB(74, 75, 93);
                            CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(u496[1], function() -- Line: 2451
                                -- upvalues: u496 (copy), place (copy)
                                local string_split_ret = string.split(u496[1].Name, "-");
                                place(Vector2.new(tonumber(string_split_ret[1]), (tonumber(string_split_ret[2]))));
                            end, {
                                mobileButtonType = true
                            }));
                        end;
                    end;

                    u476[u472.X .. "-" .. u472.Y] = 1;
                    HackingMinigames[u392].Bug.Position = UDim2.fromScale(getBugPos(u469[u472.X .. "-" .. u472.Y][1]));
                    local Vector2_new_ret3 = Vector2.new(10, 9);

                    local function updateMobilePosition(p497) -- Line: 2461
                        -- upvalues: Vector2_new_ret3 (ref), u469 (copy), u2 (ref)
                        local v498 = Vector2_new_ret3 + (p497 or Vector2.new());

                        if u469[v498.X .. "-" .. v498.Y] then
                            u469[Vector2_new_ret3.X .. "-" .. Vector2_new_ret3.Y][1].Outline.Visible = false;
                            Vector2_new_ret3 = v498;

                            if u2.platform == "Mobile" then
                                u469[v498.X .. "-" .. v498.Y][1].Outline.Visible = true;
                            end;
                        end;
                    end;

                    updateMobilePosition();
                    CharScope.buildSignalData("HackingMinigameRound", { u2.platformChangedEvent.Event, function() -- Line: 2470
                            -- upvalues: updateMobilePosition (copy)
                            updateMobilePosition();
                        end });
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(Mobile.VirusHack.Action, function() -- Line: 2471
                        -- upvalues: place (copy), Vector2_new_ret3 (ref)
                        place(Vector2_new_ret3);
                    end));
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.VirusHack.Left, function() -- Line: 2472
                        -- upvalues: updateMobilePosition (copy)
                        updateMobilePosition(Vector2.new(-1, 0));
                    end));
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.VirusHack.Right, function() -- Line: 2473
                        -- upvalues: updateMobilePosition (copy)
                        updateMobilePosition(Vector2.new(1, 0));
                    end));
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.VirusHack.Up, function() -- Line: 2474
                        -- upvalues: updateMobilePosition (copy)
                        updateMobilePosition(Vector2.new(0, 1));
                    end));
                    CharScope.buildSignalData("HackingMinigameRound", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.VirusHack.Down, function() -- Line: 2475
                        -- upvalues: updateMobilePosition (copy)
                        updateMobilePosition(Vector2.new(0, -1));
                    end));
                end;

                nextRound();
            end));

            while u397 == nil do
                if u388 ~= v395 then
                    return;
                end;

                task.wait(1);
            end;

            return u397;
        end;
    end;

    u2.debugLoadingClient("Character 3.02");
    local u499 = 1;
    local Health = ScreenGui.Left.Bottom.Health;
    local Damage = FullScreenGui.Damage;
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Saturation = u2.defaultSaturation;
    ColorCorrection.Contrast = u2.defaultContrast;
    local HeartBeat = game.SoundService.HeartBeat;
    local Volume = HeartBeat.Volume;
    local ImageColor3 = Health.CircularProgressBar.Right.ImageLabel.ImageColor3;
    local u500, v501 = u10.circularHudListener(Health.CircularProgressBar);
    CharScope.buildSignalData("Global", v501);
    u1.jumpingShootingSpread = false;

    local function healthChanged() -- Line: 2884
        -- upvalues: Humanoid (copy), u499 (ref), Damage (copy), TweenService (ref), u500 (copy), updateCircularHudColor (copy), Health (copy), ImageColor3 (copy), ColorCorrection (copy), u2 (ref), HeartBeat (copy), Volume (copy)
        local v502 = Humanoid.Health / Humanoid.MaxHealth;

        if v502 < u499 then
            Damage.ImageTransparency = 0.3;
            TweenService:Create(Damage, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
        end;

        u499 = math.max(v502, 0);
        u500(u499);
        updateCircularHudColor(Health.CircularProgressBar, u499, ImageColor3);

        if u499 < 0.15 then
            local v503 = 1 - u499 / 0.15;
            ColorCorrection.Saturation = u2.defaultSaturation - v503 * 0.5;
            ColorCorrection.Contrast = u2.defaultContrast + v503 * 0.5;
            HeartBeat.Volume = v503 * Volume;
            HeartBeat.PlaybackSpeed = 1.2 - v503 * 0.5;

            if not HeartBeat.IsPlaying then
                HeartBeat:Play();
            end;
        else
            ColorCorrection.Saturation = u2.defaultSaturation;
            ColorCorrection.Contrast = u2.defaultContrast;

            if HeartBeat.IsPlaying then
                HeartBeat:Stop();
            end;
        end;
    end;

    u2.debugLoadingClient("Character 3.08");
    healthChanged();
    CharScope.buildSignalData("Global", { Humanoid.HealthChanged, healthChanged });
    u2.debugLoadingClient("Character 3.09");
    local u504 = nil;
    local u505 = false;
    local Stamina = ScreenGui.Left.Bottom.Stamina;
    u2.debugLoadingClient("Character 3.1");
    local Running = HumanoidRootPart:WaitForChild("Running");
    u2.debugLoadingClient("Character 3.2");
    local Gasp = HumanoidRootPart:WaitForChild("Gasp");
    u2.debugLoadingClient("Character 3.3");
    local Volume2 = Gasp.Volume;
    local u506 = 0;
    local u507 = u10.loadAnimation(Animator, game.ReplicatedStorage.PlayerStuff.Animations.CrouchPart1);
    local u508 = u10.loadAnimation(Animator, game.ReplicatedStorage.PlayerStuff.Animations.CrouchPart2);
    local u509 = {};
    local ImageColor32 = Stamina.CircularProgressBar.Right.ImageLabel.ImageColor3;
    local u510, v511 = u10.circularHudListener(Stamina.CircularProgressBar);
    CharScope.buildSignalData("Global", v511);
    CharScope.addThreadOrCleanUpFunction("Global", function() -- Line: 2932
        -- upvalues: u10 (ref), Gasp (copy)
        u10.stopSoundReplicate(Gasp);
    end);

    function u1.canUseStaminaAgain() -- Line: 2937
        -- upvalues: u505 (ref), Humanoid (copy), GameRules (ref), u13 (copy)
        if u505 then
            u505 = false;
            Humanoid.JumpHeight = GameRules.jumpHeight[u13:GetAttribute("AgeLook")];
        end;
    end;

    function u1.changeStamina(p512) -- Line: 2943
        -- upvalues: u2 (ref), u505 (ref), CharScope (ref), Humanoid (copy), u1 (ref), u510 (copy), updateCircularHudColor (copy), Stamina (copy), ImageColor32 (copy)
        u2.setCoreStaminaOrFood("stamina", (math.clamp(u2.stamina + p512, 0, 100)));

        if u2.stamina == 0 and not u505 then
            u505 = true;
            CharScope.taskDelay(0.03, function() -- Line: 2947
                -- upvalues: u505 (ref), Humanoid (ref)
                if u505 then
                    Humanoid.JumpHeight = 0;
                end;
            end);
            CharScope.taskDelay(5, function() -- Line: 2950
                -- upvalues: u1 (ref)
                u1.canUseStaminaAgain();
            end);
        end;

        u510(u2.stamina / 100);
        updateCircularHudColor(Stamina.CircularProgressBar, u2.stamina / 100, ImageColor32);
    end;

    u1.changeStamina(0);

    local function speedTransition(p513) -- Line: 2959
        -- upvalues: u506 (ref), Humanoid (copy), u10 (ref)
        local v514 = u506;

        for i = 1, 15 do
            local task_wait_ret = task.wait(0.016);

            if v514 ~= u506 then
                return;
            end;

            Humanoid.WalkSpeed = u10.lerp(Humanoid.WalkSpeed, p513, 1 - 1e-6 ^ task_wait_ret);
            local _ = i;
        end;

        Humanoid.WalkSpeed = p513;
    end;

    u20 = function() -- Line: 2970, Name: setWalkspeed
        -- upvalues: Humanoid (copy), CharScope (ref), speedTransition (copy), u1 (ref), u22 (ref), GameRules (ref)
        if Humanoid:GetState() == Enum.HumanoidStateType.Swimming then
            CharScope.taskSpawn(speedTransition, ((u1.firstPerson or not u22) and 1 or 0.45) * (u1.isKid and 0.85 or 1) * (GameRules.humanoidStateParameters[u1.humanoidState].SwimSpeed or GameRules.humanoidStateParameters[2].SwimSpeed));

            return;
        end;

        CharScope.taskSpawn(speedTransition, (u1.isKid and 0.85 or 1) * GameRules.humanoidStateParameters[u1.humanoidState].WalkSpeed);
    end;

    local u515 = 0;
    local u516 = false;
    CharScope.addThreadOrCleanUpFunction("Global", CharScope.taskDefer(function() -- Line: 2982
        -- upvalues: Humanoid (copy), u2 (ref), u13 (copy), u516 (ref), u515 (ref), u1 (ref), PlayerEvent (ref)
        while true do
            local v517 = Humanoid:GetState() == Enum.HumanoidStateType.Swimming and "swimming" or u2.isSeated() and "seated";

            if v517 then
                v517 = u2.isCharUnderWater(u13, v517 == "seated");
            end;

            if v517 ~= u516 then
                u515 = 0;

                if not v517 then
                    u1.displayBottomBarMessage("oxygen");
                end;
            end;

            if v517 then
                u515 = u515 + 1;

                if u515 == 3 then
                    u1.displayBottomBarMessage("oxygen", 99, "Oxygen", 20, Color3.fromRGB(115, 199, 255), true);
                end;

                if u515 > 40 then
                    PlayerEvent:FireServer("takeDamage", 3, { { "Torso", 1 } }, 23);
                    task.wait(0.5);
                end;
            end;

            u516 = v517;
            task.wait(0.5);
        end;
    end));
    CharScope.buildSignalData("Global", { Humanoid.StateChanged, function(p518, p519) -- Line: 3000
            -- upvalues: u10 (ref), u1 (ref), GameRules (ref), CharScope (ref), u504 (ref), u506 (ref), u21 (ref), footprints (ref), u20 (ref), u86 (ref), swimmingLimitSpeedBugFix (copy)
            if p519 == Enum.HumanoidStateType.Jumping and not u10.rest("JumpStaminaPunishment", 0.4) then
                u1.changeStamina(-GameRules.jumpsStaminaCost);

                if u1.humanoidState < 3 then
                    CharScope.taskDefer(u504, u506);
                end;
            end;

            if u1.firstPerson then
                if p519 == Enum.HumanoidStateType.Jumping then
                    u21 = u21 + 0.07;
                elseif p519 == Enum.HumanoidStateType.Landed then
                    u21 = u21 - 0.07;
                end;
            end;

            if p518 == Enum.HumanoidStateType.Running then
                footprints(false);
            elseif p519 == Enum.HumanoidStateType.Running then
                footprints(true);
            end;

            if p518 == Enum.HumanoidStateType.Swimming then
                u20();
                CharScope.setConnectionsAndThreads("SwimmingLimitSpeedBugFix");

                if u86 then
                    u86:Destroy();
                    u86 = nil;
                end;
            elseif p519 == Enum.HumanoidStateType.Swimming then
                u20();
                swimmingLimitSpeedBugFix(true);
            end;

            if p519 == Enum.HumanoidStateType.Jumping then
                u1.jumpingShootingSpread = true;

                return;
            end;

            if p519 ~= Enum.HumanoidStateType.Freefall and u1.jumpingShootingSpread then
                u1.jumpingShootingSpread = false;
            end;
        end });
    local u520 = false;

    u504 = function(p521) -- Line: 3027, Name: regenStamina
        -- upvalues: u520 (ref), u506 (ref), u1 (ref), u2 (ref), Gasp (copy), PlayerEvent (ref), u13 (copy), u10 (ref), Volume2 (copy)
        if not u520 then
            u520 = true;

            while p521 == u506 do
                u1.changeStamina(1);
                task.wait(0.9 * (1 - (u2.readPlayerData("Buffs", "staminaRegen") or 0) / 100));

                if Gasp.IsPlaying then
                    if u2.stamina >= 15 then
                        PlayerEvent:FireServer("tired", u13, false);
                        u10.stopSoundReplicate(Gasp);
                    else
                        Gasp.Volume = Volume2 * (1 - u2.stamina / 15);
                    end;
                end;

                if u2.stamina >= 100 then
                    break;
                end;
            end;

            u520 = false;
        end;
    end;

    if u2.stamina < 100 then
        CharScope.taskDefer(u504, u506);
    end;

    local function changeHumanoidState(p522, u523, p524) -- Line: 3045
        -- upvalues: u1 (ref), u10 (ref), u509 (copy), u2 (ref), CharScope (ref), u506 (ref), PlayerEvent (ref), Running (copy), GameRules (ref), u20 (ref), Mobile (copy), u507 (copy), u508 (copy), updateCameraOffset (copy), Gasp (copy), u13 (copy), Volume2 (copy), Humanoid (copy), changeHumanoidState (ref), u504 (ref)
        if not (u1.humanoidState == p522 or not (p524 or u10.isTableEmpty(u509)) or u2.isSeated() and p522 ~= 2) then
            u1.humanoidState = p522;
            CharScope.setConnectionsAndThreads("HumanoidState");
            u506 = (u506 + 1) % 100;
            local u525 = u506;
            PlayerEvent:FireServer("humanoidState", p522);
            Running.PlaybackSpeed = GameRules.humanoidStateParameters[p522].PlaybackSpeed;
            u20();

            if GameRules.humanoidStateParameters[p522].JumpRestricted then
                u2.overwriteJump("humanoidState", function() -- Line: 3055
                    -- upvalues: u523 (copy), CharScope (ref)
                    if u523 then
                        CharScope.taskSpawn(u523);
                    end;
                end);
            else
                u2.overwriteJump("humanoidState", false);
            end;

            u10.mobileButtonPressed(Mobile.Character.Crouch, p522 == 0);

            if u507.animationTrack.IsPlaying then
                u10.playAnimation(u507, "stop");
                u10.playAnimation(u508, "stop");
                updateCameraOffset("crouch", Vector3.new(), true);
            end;

            if u1.humanoidState == 3 then
                while u525 == u506 do
                    u1.changeStamina(-1);
                    task.wait(0.4);

                    if u2.stamina <= 15 then
                        if not Gasp.IsPlaying then
                            u2.displayTip("stamina", 5);
                            PlayerEvent:FireServer("tired", u13, true);
                            u10.playSoundReplicate(Gasp);
                        end;

                        Gasp.Volume = Volume2 * (1 - u2.stamina / 15);
                    end;

                    if u2.stamina <= 0 or (Humanoid.MoveDirection == Vector3.new() or u2.isSeated()) then
                        return changeHumanoidState(2);
                    end;
                end;
            elseif u1.humanoidState < 3 then
                if u1.humanoidState == 0 then
                    if not u507.animationTrack.IsPlaying then
                        u10.playAnimation(u507, "play", GameRules.defaultCharacterAnimationFadeTime * 4, 4, u1.isKid and 1.45 or 1);
                        u10.playAnimation(u508, "play", GameRules.defaultCharacterAnimationFadeTime, nil, u1.isKid and 1.45 or 1);
                        updateCameraOffset("crouch", Vector3.new(0, -1, 0), true);
                    end;

                    CharScope.taskSpawn(function() -- Line: 3085
                        -- upvalues: u525 (copy), u506 (ref), u2 (ref), changeHumanoidState (ref), Humanoid (ref), u507 (ref), u1 (ref)
                        while u525 == u506 do
                            if u2.isSeated() then
                                return changeHumanoidState(2);
                            end;

                            if Humanoid.moveDirection == Vector3.new() then
                                if u507.animationTrack.Speed ~= 0 then
                                    u507.animationTrack:AdjustSpeed(0);
                                end;
                            elseif u507.animationTrack.Speed == 0 then
                                u507.animationTrack:AdjustSpeed(u1.isKid and 1.45 or 1);
                            end;

                            task.wait(0.03);
                        end;
                    end);
                end;

                task.wait(1);
                u504(u525);
            end;
        end;
    end;

    CharScope.taskSpawn(changeHumanoidState, GameRules.initialHumanoidState);

    function u1.runningUserInput(p526) -- Line: 3102
        -- upvalues: u1 (ref), u505 (ref), Humanoid (copy), changeHumanoidState (ref)
        if u1.humanoidState ~= 0 and not (u505 or not p526 and Humanoid.MoveDirection == Vector3.new()) then
            changeHumanoidState(3);
        end;
    end;

    function u1.stopRunningUserInput() -- Line: 3107
        -- upvalues: u1 (ref), changeHumanoidState (ref)
        if u1.humanoidState ~= 0 then
            changeHumanoidState(2);
        end;
    end;

    function u1.slowWalkingUserInput() -- Line: 3113
        -- upvalues: Humanoid (copy), u1 (ref), changeHumanoidState (ref)
        if Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming and (u1.humanoidState == 2 or (u1.humanoidState == -2 or u1.humanoidState == -1)) then
            changeHumanoidState(1, function() -- Line: 3115
                -- upvalues: changeHumanoidState (ref)
                changeHumanoidState(2);
            end);
        end;
    end;

    function u1.stopSlowWalkingUserInput() -- Line: 3119
        -- upvalues: u1 (ref), changeHumanoidState (ref)
        if u1.humanoidState == 1 then
            changeHumanoidState(2);
        end;
    end;

    function u1.crouchUserInput() -- Line: 3125
        -- upvalues: u1 (ref), Humanoid (copy), changeHumanoidState (ref)
        if u1.humanoidState == 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming then
            changeHumanoidState(2);

            return;
        end;

        if (u1.humanoidState == 2 or (u1.humanoidState == -2 or u1.humanoidState == -1)) and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            changeHumanoidState(0, function() -- Line: 3130
                -- upvalues: changeHumanoidState (ref)
                changeHumanoidState(2);
            end);
        end;
    end;

    function u1.lockHumanoidState(p527, p528, p529) -- Line: 3135
        -- upvalues: u509 (copy), CharScope (ref), changeHumanoidState (ref)
        local v530 = p528 or nil;

        if (u509[p527] and u509[p527][1]) ~= v530 then
            u509[p527] = v530 and { v530, p529 };
            local v531 = nil;

            for _, v in pairs(u509) do
                if not v531 or v[1] < v531 then
                    v531 = v[1];
                end;
            end;

            CharScope.taskSpawn(changeHumanoidState, v531 or 2, function() -- Line: 3143
                -- upvalues: u509 (ref)
                for _, v in pairs(u509) do
                    if v[2] then
                        v[2]();
                    end;
                end;
            end, true);
        end;
    end;

    CharScope.buildSignalData("Global", u2.mouseButton(Mobile.Character.Crouch, function() -- Line: 3150
        -- upvalues: u1 (ref)
        u1.crouchUserInput();
    end));
    CharScope.buildSignalData("Global", u2.mouseButton(Mobile.Character.Jump, function() -- Line: 3156
        -- upvalues: u2 (ref), RunService (ref), Humanoid (copy)
        if not u2.isJumpEnabled then
            u2.characterJumped();

            return;
        end;

        RunService.RenderStepped:Wait();
        Humanoid.Jump = true;
    end));
    local u532 = false;

    local function activateSprintMobile(p533) -- Line: 3165
        -- upvalues: u532 (ref), CharScope (ref), u1 (ref), u10 (ref), Mobile (copy), u2 (ref), activateSprintMobile (copy), Humanoid (copy)
        u532 = p533;
        CharScope.setConnectionsAndThreads("SprintMobile");

        if u1.humanoidState == 3 then
            CharScope.taskSpawn(u1.stopRunningUserInput);
        end;

        u10.mobileButtonPressed(Mobile.Character.Sprint, p533);

        if p533 then
            CharScope.addThreadOrCleanUpFunction("SprintMobile", CharScope.taskDefer(function() -- Line: 3171
                -- upvalues: u1 (ref), u2 (ref), CharScope (ref), activateSprintMobile (ref), Humanoid (ref), Mobile (ref), u10 (ref)
                while u1.humanoidState ~= 0 and (u2.stamina > 0 and (u2.stamina >= 10 or u1.humanoidState == 3)) do
                    if u1.humanoidState ~= 3 and Humanoid.MoveDirection ~= Vector3.new() then
                        CharScope.taskSpawn(u1.runningUserInput);
                    end;

                    if Mobile.Character.Sprint.OuterCircle.ImageTransparency ~= 0 then
                        u10.mobileButtonPressed(Mobile.Character.Sprint, true);
                    end;

                    task.wait(0.03);
                end;

                return CharScope.taskDefer(activateSprintMobile);
            end));
        end;
    end;

    CharScope.buildSignalData("Global", u2.mouseButton(Mobile.Character.Sprint, function() -- Line: 3181
        -- upvalues: activateSprintMobile (copy), u532 (ref)
        activateSprintMobile(not u532);
    end));
    local Food = ScreenGui.Left.Bottom.Food;
    local ImageColor33 = Food.CircularProgressBar.Right.ImageLabel.ImageColor3;
    u1.rainProtection = false;
    local u534, v535 = u10.circularHudListener(Food.CircularProgressBar);
    CharScope.buildSignalData("Global", v535);

    function u1.changeFood(p536) -- Line: 3191
        -- upvalues: u2 (ref), u534 (copy), updateCircularHudColor (copy), Food (copy), ImageColor33 (copy), u13 (copy), PlayerEvent (ref)
        u2.setCoreStaminaOrFood("food", (math.clamp(u2.food + p536, 0, 100)));
        u534(u2.food / 100);
        updateCircularHudColor(Food.CircularProgressBar, u2.food / 100, ImageColor33);

        if u2.food == 0 ~= u13:GetAttribute("Starving") then
            PlayerEvent:FireServer("starving", u13, u2.food == 0);
        end;
    end;

    u1.changeFood(0);
    local u537 = u10.raycastParamsNew();
    u537.FilterDescendantsInstances = { workspace.Characters };

    local function isPlayerInRain() -- Line: 3203
        -- upvalues: u10 (ref), HumanoidRootPart (copy), u537 (copy)
        return not u10.raycastVisible(HumanoidRootPart.Position, Vector3.new(0, 100, 0), u537);
    end;

    u2.debugLoadingClient("Character 3.4");
    local StomachGrowl = HumanoidRootPart:WaitForChild("StomachGrowl");
    u2.debugLoadingClient("Character 3.5");
    CharScope.taskDefer(function() -- Line: 3209
        -- upvalues: u10 (ref), u1 (ref), GameRules (ref), u2 (ref), Humanoid (copy), PlayerEvent (ref), StomachGrowl (copy), Animator (copy), HumanoidRootPart (copy), u537 (copy)
        task.wait(60);

        while true do
            if not u10.isPrivateServerConfigurationSettingEnabled("hunger") then
                u1.changeFood((GameRules.humanoidStateParameters[u1.humanoidState].FoodConsumption or 1) * -1);
            end;

            if u2.food == 0 and Humanoid.Health > 0 then
                PlayerEvent:FireServer("takeDamage", 5, { { "Torso", 1 } }, 3);

                if not u10.rest("Starving", 180) then
                    if u2.readPlayerData("Guide", "Food") then
                        u2.displayTip("hunger", 15);
                    else
                        u2.startGuide("Food", true);
                    end;

                    u10.playSoundReplicate(StomachGrowl);
                    u10.animationBuffer(Animator, "play", "StomachGrowl");
                    u2.notify({
                        message = "You need something to eat or you\'ll die soon"
                    });
                end;
            end;

            task.wait((u2.weatherParticleObjActive == "Thunderstorm" and not (u1.rainProtection or u10.raycastVisible(HumanoidRootPart.Position, Vector3.new(0, 100, 0), u537)) and 40 or 60) * (1 + (u2.readPlayerData("Buffs", "hungerResistance") or 0) / 100));
        end;
    end);
    u2.debugLoadingClient("Character 4");
    u1.chatModule = u2.createChat(Chat, {
        teamName = u11,
        radioEnabled = RADIO_CHANNEL
    });

    if RADIO_CHANNEL then
        local v538 = 0;

        for _, child in pairs(game.ReplicatedStorage.Gameplay.Missions.Active:GetChildren()) do
            if child.Name ~= "Preview" and isIncidentActive(child) then
                v538 = v538 + 1;
            end;
        end;

        if v538 > 0 then
            u1.chatModule.createMessage({
                username = "Dispatch",
                radio = true,
                openTablet = true,
                sendTo = u11,
                team = u11,
                text = "There " .. (v538 == 1 and "is 1 active incident" or "are " .. v538 .. " active incidents") .. ". Use your tablet to respond"
            });
        end;
    end;

    local u539 = {
        WalkSpeed = 22,
        MaxHealth = 100,
        HipHeight = 10,
        JumpPower = game.StarterPlayer.CharacterJumpPower,
        MaxSlopeAngle = game.StarterPlayer.CharacterMaxSlopeAngle
    };
    local u540 = {};
    CharScope.taskDefer(function() -- Line: 3249
        -- upvalues: u539 (copy), u540 (copy), LocalPlayer (ref), PlayerEvent (ref)
        while true do
            for i, v in pairs(u539) do
                if not u540[i] and v < LocalPlayer.Character.Humanoid[i] then
                    u540[i] = true;
                    local v541 = tostring(LocalPlayer.Character.Humanoid[i]);
                    task.wait(60 + math.random(15, 25));
                    PlayerEvent:FireServer("lodBias", i, v541);
                end;
            end;

            task.wait(5);
        end;
    end);

    if require(game.Teams[u11].Config).SMART_RADIO then
        local u542 = {
            nil,
            workspace.World,
            workspace.Characters,
            workspace.Terrain,
            workspace.Gameplay.Entities
        };
        local u543 = u10.raycastParamsNew();
        u543.IgnoreWater = true;
        u1.smartRadioGui.Screen._ScrollingList.Scroll.CheckPlate.Visible = u11 == "Police";
        u1.smartRadioGui.Screen._ScrollingList.Scroll.CheckPlayer.Visible = u11 == "Police";
        local u544 = 0;
        local u545 = nil;
        local u546 = false;

        local function _(p547, p548) -- Line: 3274
            -- upvalues: u545 (ref)
            p547.Background.Visible = p548;
            p547.TextLabel.TextColor3 = p548 == true and (p547:GetAttribute("Highlight") or Color3.fromRGB(157, 213, 255)) or (p548 == false and Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168));
            p547.Icon[p547.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = p547.TextLabel.TextColor3;
            u545 = p548 and p547;
        end;

        local function highlightButton(p549) -- Line: 3280
            -- upvalues: u545 (ref)
            if u545 then
                local v550 = u545;
                v550.Background.Visible = false;
                v550.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                v550.Icon[v550.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v550.TextLabel.TextColor3;
                u545 = false;
            end;

            if p549 then
                p549.Background.Visible = true;
                p549.TextLabel.TextColor3 = p549:GetAttribute("Highlight") or (Color3.fromRGB(157, 213, 255) or Color3.fromRGB(168, 168, 168));
                p549.Icon[p549.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = p549.TextLabel.TextColor3;
                u545 = p549;
            end;
        end;

        local function disableButton(p551, p552) -- Line: 3284
            -- upvalues: u545 (ref)
            if not p552 then
                p551.Background.Visible = false;
                p551.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                p551.Icon[p551.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = p551.TextLabel.TextColor3;
                u545 = false;

                return;
            end;

            if u545 == p551 and u545 then
                local v553 = u545;
                v553.Background.Visible = false;
                v553.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                v553.Icon[v553.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v553.TextLabel.TextColor3;
                u545 = false;
            end;

            p551.Background.Visible = nil;
            p551.TextLabel.TextColor3 = Color3.fromRGB(168, 168, 168);
            p551.Icon[p551.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = p551.TextLabel.TextColor3;
            u545 = nil;
        end;

        function u1.activateSmartRadio(u554) -- Line: 3290
            -- upvalues: u546 (ref), u1 (ref), u544 (ref), CharScope (ref), PlayerFunc (ref), u545 (ref), u11 (ref), u10 (ref), LocalPlayer (ref), PlayerStuff (ref), u2 (ref), GameRules (ref), PlayerEvent (ref), HumanoidRootPart (copy), u542 (copy), u543 (copy), u13 (copy), UserInputService (ref)
            u546 = u554;
            u1.smartRadioUserNumberInput = nil;
            u1.lastReceivedIncidentSmartRadioFunc = nil;
            u544 = (u544 + 1) % 100;
            local u555 = u544;
            CharScope.taskSpawn(function() -- Line: 3296
                -- upvalues: PlayerFunc (ref), u554 (copy)
                PlayerFunc:InvokeServer("equipSpecialItem", "Smart Radio", u554);
            end);
            local v556 = u554 and 0 or 7.6;
            u1.smartRadioGui:TweenPosition(UDim2.fromScale(0, v556), "Out", "Quint", math.abs(v556 - u1.smartRadioGui.Position.Y.Scale) / 8.3 * 0.4 + 0.4, true);
            CharScope.setConnectionsAndThreads("SmartRadio");
            u545 = nil;

            if u554 then
                local u557 = {};
                game.SoundService.SmartRadio.RadioOut:Play();
                local PanicButton = u1.smartRadioGui.Screen._ScrollingList.Scroll.PanicButton;
                local v558;

                if u11 == "Police" then
                    v558 = u10.isPrivateServerConfigurationSettingEnabled("panicButton");
                else
                    v558 = false;
                end;

                PanicButton.Visible = v558;
                u1.smartRadioGui.Screen._ScrollingList.Scroll.Pursuit.Visible = u11 == "Police";
                local SMART_RADIO = require(game.Teams[u11].Config).SMART_RADIO;

                if SMART_RADIO then
                    if SMART_RADIO == "NoVoiceRadio" then
                        SMART_RADIO = false;
                    else
                        SMART_RADIO = LocalPlayer:GetAttribute("VoiceChatEnabled");
                    end;
                end;

                u1.smartRadioGui.VoiceRadio.Visible = SMART_RADIO;
                u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Visible = SMART_RADIO;

                if SMART_RADIO then
                    local function updateScreen() -- Line: 3312
                        -- upvalues: LocalPlayer (ref), u1 (ref)
                        local Attribute = LocalPlayer:GetAttribute("EmergencyVoiceRadio");
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Transmit.ImageColor3 = Attribute and (u1.chatModule.transmit == "Voice" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(142, 191, 231)) or Color3.fromRGB(216, 216, 216);
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Channel.Text = Attribute and (string.format("%.02d", Attribute) or "OFF") or "OFF";
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Channel.TextColor3 = Attribute and Color3.fromRGB(142, 191, 231) or Color3.fromRGB(216, 216, 216);
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.PlayerIcon.Visible = Attribute;
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Players.Visible = Attribute;
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Volume.ImageColor3 = Attribute and Color3.fromRGB(142, 191, 231) or Color3.fromRGB(216, 216, 216);
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.TextLabel.TextColor3 = Attribute and Color3.fromRGB(142, 191, 231) or Color3.fromRGB(216, 216, 216);
                    end;

                    updateScreen();

                    local function updateVolumeGui() -- Line: 3324
                        -- upvalues: u1 (ref), LocalPlayer (ref)
                        u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Volume.UIGradient.Offset = Vector2.new(-0.76 + (LocalPlayer:GetAttribute("EmergencyVoiceRadioVolume") or 3) * 0.21, 0);
                    end;

                    local function updateVolume(p559) -- Line: 3327
                        -- upvalues: LocalPlayer (ref), PlayerStuff (ref), u1 (ref)
                        local Attribute = LocalPlayer:GetAttribute("EmergencyVoiceRadio");
                        local v560 = (LocalPlayer:GetAttribute("EmergencyVoiceRadioVolume") or 3) + p559;

                        if Attribute and (v560 < 7 and v560 > 0) then
                            if p559 ~= 0 then
                                game.SoundService.SmartRadio.Button:Play();
                            end;

                            local v561 = PlayerStuff.AudioAPI.ActiveGroupVoiceChats:FindFirstChild("PoliceRadio-" .. Attribute);

                            if v561 and v561:FindFirstChild(LocalPlayer.Name .. "-Listener") then
                                LocalPlayer:SetAttribute("EmergencyVoiceRadioVolume", v560);
                                v561[LocalPlayer.Name .. "-Listener"].Radio[2].AudioFader.Volume = ({ 0.1, 0.3, 0.7, 1, 1.3, 1.6 })[v560] * PlayerStuff.AudioAPI.Effects.Radio[2].AudioFader.Volume;
                                u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Volume.UIGradient.Offset = Vector2.new(-0.76 + (LocalPlayer:GetAttribute("EmergencyVoiceRadioVolume") or 3) * 0.21, 0);
                            end;
                        end;
                    end;

                    updateVolume(0);
                    u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Volume.UIGradient.Offset = Vector2.new(-0.76 + (LocalPlayer:GetAttribute("EmergencyVoiceRadioVolume") or 3) * 0.21, 0);
                    CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui.VoiceRadio.Buttons.VolumeUp, function() -- Line: 3344
                        -- upvalues: updateVolume (copy)
                        updateVolume(1);
                    end));
                    CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui.VoiceRadio.Buttons.VolumeDown, function() -- Line: 3347
                        -- upvalues: updateVolume (copy)
                        updateVolume(-1);
                    end));

                    local function updateChannelPlayerAmount() -- Line: 3350
                        -- upvalues: PlayerStuff (ref), LocalPlayer (ref), u1 (ref)
                        local v562 = PlayerStuff.AudioAPI.ActiveGroupVoiceChats:FindFirstChild("PoliceRadio-" .. (LocalPlayer:GetAttribute("EmergencyVoiceRadio") or 1));

                        if v562 then
                            local Players = u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Players;
                            local v563 = #v562:GetChildren() / 2;
                            Players.Text = math.round(v563);
                        end;
                    end;

                    CharScope.taskDefer(function() -- Line: 3354
                        -- upvalues: u544 (ref), u555 (copy), updateChannelPlayerAmount (copy)
                        while u544 == u555 do
                            updateChannelPlayerAmount();
                            task.wait(3);
                        end;
                    end);

                    local function updateChannel(p564) -- Line: 3360
                        -- upvalues: LocalPlayer (ref), u10 (ref), u1 (ref), updateChannelPlayerAmount (copy), updateVolume (copy)
                        if LocalPlayer:GetAttribute("EmergencyVoiceRadio") and (not u10.invokeTraffic.voiceRadio and u10.invokeServerTraffic("emergencyVoiceRadio", (LocalPlayer:GetAttribute("EmergencyVoiceRadio") or 1) + p564)) then
                            u1.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Channel.Text = string.format("%.02d", LocalPlayer:GetAttribute("EmergencyVoiceRadio"));
                            game.SoundService.SmartRadio.Button:Play();
                            updateChannelPlayerAmount();
                            updateVolume(0);
                        end;
                    end;

                    CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui.VoiceRadio.Buttons.ChannelLeft, function() -- Line: 3371
                        -- upvalues: updateChannel (copy)
                        updateChannel(-1);
                    end));
                    CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui.VoiceRadio.Buttons.ChannelRight, function() -- Line: 3374
                        -- upvalues: updateChannel (copy)
                        updateChannel(1);
                    end));
                    CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui.VoiceRadio.Buttons.Power, function() -- Line: 3377
                        -- upvalues: u10 (ref), LocalPlayer (ref), u2 (ref), updateScreen (copy)
                        if not (u10.invokeTraffic.voiceRadio or u10.rest("emergencyVoiceRadioPower", 1)) then
                            game.SoundService.SmartRadio.Button:Play();

                            if u10.invokeServerTraffic("emergencyVoiceRadio", not LocalPlayer:GetAttribute("EmergencyVoiceRadio") and 1) then
                                u2.displayTip("voiceChat", 15);
                            end;

                            updateScreen();
                        end;
                    end));
                end;

                for _, child in pairs(u1.smartRadioGui.Screen._ScrollingList.Scroll:GetChildren()) do
                    if child:IsA("ImageButton") and child.Visible then
                        child.Background.Visible = false;
                        child.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                        child.Icon[child.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = child.TextLabel.TextColor3;
                        u545 = false;
                        local u565 = true;
                        local u566 = nil;
                        CharScope.buildSignalData("SmartRadio", { child.MouseEnter, function() -- Line: 3391
                                -- upvalues: u565 (ref), child (copy), u545 (ref), u10 (ref)
                                if u565 then
                                    local v567 = child;

                                    if u545 then
                                        local v568 = u545;
                                        v568.Background.Visible = false;
                                        v568.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                        v568.Icon[v568.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v568.TextLabel.TextColor3;
                                        u545 = false;
                                    end;

                                    if v567 then
                                        v567.Background.Visible = true;
                                        v567.TextLabel.TextColor3 = v567:GetAttribute("Highlight") or (Color3.fromRGB(157, 213, 255) or Color3.fromRGB(168, 168, 168));
                                        v567.Icon[v567.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v567.TextLabel.TextColor3;
                                        u545 = v567;
                                    end;

                                    while u10.isInFrame(child) do
                                        task.wait(0.03);
                                    end;

                                    if u545 == child and u545 then
                                        local v569 = u545;
                                        v569.Background.Visible = false;
                                        v569.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                        v569.Icon[v569.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v569.TextLabel.TextColor3;
                                        u545 = false;
                                    end;
                                end;
                            end });

                        local function selected() -- Line: 3398
                            -- upvalues: u565 (ref), u1 (ref), child (copy), u566 (ref), u10 (ref), u11 (ref), GameRules (ref), PlayerFunc (ref), PlayerEvent (ref), LocalPlayer (ref), HumanoidRootPart (ref)
                            if u565 then
                                game.SoundService.SmartRadio.Button:Play();
                                u1.activateSmartRadio(false);

                                if child.Name == "CheckPlate" then
                                    if not u566.Parent then
                                        return;
                                    end;

                                    local v570 = u10.getVehicleInfo.belongsToPlayer(u566);
                                    local v571 = "The vehicle is " .. u10.getVehicleInfoAsText.colorDisplayNameAndCategoryString(u566) .. " (" .. u10.getVehicleInfoAsText.licensePlate(u566) .. ")" .. (v570 and v570 ~= true and (", belongs to " .. v570.DisplayName or "") or "");

                                    if u10.getVehicleInfo.isStolen(u566) then
                                        v571 = v571 .. ". The vehicle is stolen!";
                                    end;

                                    u1.chatModule.selectChannel(u11);
                                    u1.chatModule.createMessage({
                                        sendTo = "Police",
                                        username = "Dispatch",
                                        team = "Police",
                                        text = "Stand by...",
                                        radio = true
                                    });
                                    task.wait(7);
                                    u1.chatModule.createMessage({
                                        sendTo = "Police",
                                        username = "Dispatch",
                                        team = "Police",
                                        radio = true,
                                        text = v571
                                    });
                                elseif child.Name == "CheckPlayer" then
                                    if not u566.Parent then
                                        return;
                                    end;

                                    local PlayerFromCharacter = u10.getPlayerFromCharacter(u566);

                                    if PlayerFromCharacter then
                                        local v572 = "The player is " .. PlayerFromCharacter.DisplayName;
                                        local v573;

                                        if PlayerFromCharacter:GetAttribute("WantedLevel") then
                                            local Attribute = PlayerFromCharacter:GetAttribute("DirtyMoney");

                                            if Attribute then
                                                if Attribute >= 1000 then
                                                    Attribute = u10.commaValue(math.floor(Attribute / 1000) * 100);
                                                else
                                                    Attribute = false;
                                                end;
                                            end;

                                            v573 = v572 .. ". " .. GameRules.wantedLevelStars[PlayerFromCharacter:GetAttribute("WantedLevel")] .. " star wanted level" .. (Attribute and " with a $" .. Attribute .. " bounty!" or "!");
                                        else
                                            v573 = v572 .. (PlayerFromCharacter:GetAttribute("HasViolations") and ". Comitted some violations" or ". Clean");
                                        end;

                                        u1.chatModule.selectChannel(u11);
                                        u1.chatModule.createMessage({
                                            sendTo = "Police",
                                            username = "Dispatch",
                                            team = "Police",
                                            text = "Stand by...",
                                            radio = true
                                        });
                                        task.wait(7);
                                        u1.chatModule.createMessage({
                                            sendTo = "Police",
                                            username = "Dispatch",
                                            team = "Police",
                                            radio = true,
                                            text = v573
                                        });
                                    end;
                                elseif child.Name == "JoinLatest" then
                                    u1.chatModule.selectChannel(u11);
                                    local lastReceivedIncident = u1.lastReceivedIncident;
                                    u1.lastReceivedIncident = nil;

                                    if u1.lastReceivedIncidentSmartRadioFunc then
                                        u1.lastReceivedIncidentSmartRadioFunc();
                                    end;

                                    PlayerFunc:InvokeServer("talkToMission", lastReceivedIncident.ID.Value .. "join");
                                elseif child.Name == "NeedAssistance" then
                                    PlayerEvent:FireServer("sendMessagePreset", 1, u1.chatModule.currentChannel);
                                elseif child.Name == "Enroute" then
                                    PlayerEvent:FireServer("sendMessagePreset", 2, u1.chatModule.currentChannel);
                                elseif child.Name == "Available" then
                                    PlayerEvent:FireServer("sendMessagePreset", 3, u1.chatModule.currentChannel);
                                elseif child.Name == "OnScene" then
                                    PlayerEvent:FireServer("sendMessagePreset", 4, u1.chatModule.currentChannel);
                                elseif child.Name == "Pursuit" then
                                    PlayerEvent:FireServer("sendMessagePreset", 5, u1.chatModule.currentChannel);
                                elseif child.Name == "PanicButton" then
                                    PlayerEvent:FireServer("togglePanicButton", LocalPlayer.InsideLocation.Value and u10.getLocationOutsideCenter(LocalPlayer.InsideLocation.Value) or HumanoidRootPart.Position);
                                end;

                                return true;
                            end;
                        end;

                        if child:FindFirstChild("KeyCode") then
                            u557[child.KeyCode.Value] = { child, selected };
                        end;

                        CharScope.buildSignalData("SmartRadio", u2.mouseButton(child, selected, {
                            mobileButtonType = "MouseButton1Click"
                        }));

                        if child.Name == "CheckPlate" then
                            CharScope.taskSpawn(function() -- Line: 3459
                                -- upvalues: u555 (copy), u544 (ref), u10 (ref), LocalPlayer (ref), u542 (ref), u543 (ref), HumanoidRootPart (ref), u566 (ref), u565 (ref), child (copy), u545 (ref)
                                while u555 == u544 do
                                    local v574 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);
                                    u542[1] = v574;
                                    u543.FilterDescendantsInstances = u542;
                                    local v575 = v574 and v574.PrimaryPart or HumanoidRootPart;
                                    local v576 = workspace:Raycast(v575.Position, v575.CFrame.LookVector * (v574 and 26 or 7), u543);

                                    if v576 then
                                        v576 = u10.getAncestorsChild(workspace.Gameplay.Vehicles, v576.Instance);
                                    end;

                                    u566 = v576;

                                    if (u566 and true) ~= (u565 and true) then
                                        u565 = u566 and true;
                                        local v577 = child;

                                        if u566 then
                                            v577.Background.Visible = false;
                                            v577.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                            v577.Icon[v577.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v577.TextLabel.TextColor3;
                                            u545 = false;
                                        else
                                            if u545 == v577 and u545 then
                                                local v578 = u545;
                                                v578.Background.Visible = false;
                                                v578.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                                v578.Icon[v578.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v578.TextLabel.TextColor3;
                                                u545 = false;
                                            end;

                                            v577.Background.Visible = nil;
                                            v577.TextLabel.TextColor3 = Color3.fromRGB(168, 168, 168);
                                            v577.Icon[v577.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v577.TextLabel.TextColor3;
                                            u545 = nil;
                                        end;
                                    end;

                                    task.wait(1);
                                end;
                            end);
                        elseif child.Name == "CheckPlayer" then
                            CharScope.taskSpawn(function() -- Line: 3476
                                -- upvalues: u555 (copy), u544 (ref), u566 (ref), u13 (ref), HumanoidRootPart (ref), u565 (ref), child (copy), u545 (ref)
                                while u555 == u544 do
                                    local v579 = 5;
                                    u566 = nil;

                                    for _, child2 in pairs(workspace.Characters:GetChildren()) do
                                        if child2 ~= u13 then
                                            local Magnitude = (child2.PrimaryPart.Position - (HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 2)).Magnitude;

                                            if Magnitude < v579 then
                                                u566 = child2;
                                                v579 = Magnitude;
                                            end;
                                        end;
                                    end;

                                    if (u566 and true) ~= (u565 and true) then
                                        u565 = u566 and true;
                                        local v580 = child;

                                        if u566 then
                                            v580.Background.Visible = false;
                                            v580.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                            v580.Icon[v580.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v580.TextLabel.TextColor3;
                                            u545 = false;
                                        else
                                            if u545 == v580 and u545 then
                                                local v581 = u545;
                                                v581.Background.Visible = false;
                                                v581.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                                v581.Icon[v581.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v581.TextLabel.TextColor3;
                                                u545 = false;
                                            end;

                                            v580.Background.Visible = nil;
                                            v580.TextLabel.TextColor3 = Color3.fromRGB(168, 168, 168);
                                            v580.Icon[v580.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v580.TextLabel.TextColor3;
                                            u545 = nil;
                                        end;
                                    end;

                                    task.wait(1);
                                end;
                            end);
                        elseif child.Name == "JoinLatest" then
                            function u1.lastReceivedIncidentSmartRadioFunc(p582) -- Line: 3497
                                -- upvalues: u1 (ref), u565 (ref), child (copy), u545 (ref)
                                if p582 or (u1.lastReceivedIncident and true) ~= (u565 and true) then
                                    u565 = u1.lastReceivedIncident and true;
                                    local v583 = child;

                                    if not u1.lastReceivedIncident then
                                        if u545 == v583 and u545 then
                                            local v584 = u545;
                                            v584.Background.Visible = false;
                                            v584.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                            v584.Icon[v584.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v584.TextLabel.TextColor3;
                                            u545 = false;
                                        end;

                                        v583.Background.Visible = nil;
                                        v583.TextLabel.TextColor3 = Color3.fromRGB(168, 168, 168);
                                        v583.Icon[v583.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v583.TextLabel.TextColor3;
                                        u545 = nil;

                                        return;
                                    end;

                                    v583.Background.Visible = false;
                                    v583.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                    v583.Icon[v583.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v583.TextLabel.TextColor3;
                                    u545 = false;
                                end;
                            end;

                            u1.lastReceivedIncidentSmartRadioFunc(true);
                        elseif child.Name == "PanicButton" then
                            CharScope.taskSpawn(function() -- Line: 3505
                                -- upvalues: u555 (copy), u544 (ref), u10 (ref), LocalPlayer (ref), u565 (ref), child (copy), u545 (ref)
                                while u555 == u544 do
                                    local v585 = u10.rest("PanicButtonCooldown", nil, LocalPlayer) and true or false;

                                    if v585 == u565 then
                                        local v586 = child;

                                        if v585 then
                                            if u545 == v586 and u545 then
                                                local v587 = u545;
                                                v587.Background.Visible = false;
                                                v587.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                                v587.Icon[v587.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v587.TextLabel.TextColor3;
                                                u545 = false;
                                            end;

                                            v586.Background.Visible = nil;
                                            v586.TextLabel.TextColor3 = Color3.fromRGB(168, 168, 168);
                                            v586.Icon[v586.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v586.TextLabel.TextColor3;
                                            u545 = nil;
                                        else
                                            v586.Background.Visible = false;
                                            v586.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                                            v586.Icon[v586.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v586.TextLabel.TextColor3;
                                            u545 = false;
                                        end;

                                        u565 = not v585;
                                    end;

                                    task.wait(1);
                                end;
                            end);
                        end;
                    end;
                end;

                function u1.smartRadioUserNumberInput(p588) -- Line: 3518
                    -- upvalues: u557 (copy), u545 (ref)
                    if u557[p588] and u557[p588][2]() then
                        local v589 = u557[p588][1];

                        if u545 then
                            local v590 = u545;
                            v590.Background.Visible = false;
                            v590.TextLabel.TextColor3 = Color3.fromRGB(216, 216, 216) or Color3.fromRGB(168, 168, 168);
                            v590.Icon[v590.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v590.TextLabel.TextColor3;
                            u545 = false;
                        end;

                        if v589 then
                            v589.Background.Visible = true;
                            v589.TextLabel.TextColor3 = v589:GetAttribute("Highlight") or (Color3.fromRGB(157, 213, 255) or Color3.fromRGB(168, 168, 168));
                            v589.Icon[v589.Icon:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v589.TextLabel.TextColor3;
                            u545 = v589;
                        end;
                    end;
                end;

                local v591 = u10.scrollingListSystem(u1.smartRadioGui.Screen._ScrollingList.Scroll, 0.3, {
                    hideScrollBarWhenNotUsed = true,
                    scrollBar = u1.smartRadioGui.Screen.ScrollBar
                });
                CharScope.buildSignalData("SmartRadio", unpack(v591.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("SmartRadio", v591.cleanUp);

                for _, v in pairs({ "VoiceRadioClose", "Close" }) do
                    u1.smartRadioGui[v].Visible = (SMART_RADIO and "VoiceRadioClose" or "Close") == v;

                    if u1.smartRadioGui[v].Visible then
                        CharScope.buildSignalData("SmartRadio", u2.mouseButton(u1.smartRadioGui[v], function() -- Line: 3529
                            -- upvalues: u1 (ref)
                            u1.activateSmartRadio(false);
                        end));
                    end;
                end;

                CharScope.buildSignalData("SmartRadio", { UserInputService.InputBegan, function(p592) -- Line: 3531
                        -- upvalues: u10 (ref), u1 (ref)
                        if p592.UserInputType == Enum.UserInputType.MouseButton2 and u10.isInFrame(u1.smartRadioGui.Background) then
                            u1.activateSmartRadio(false);
                        end;
                    end });
                CharScope.buildSignalData("SmartRadio", u2.guiScreenDraggingSystem(u1.smartRadioGui, u1.smartRadioGui.DragClickArea, {
                    customBoundGui = u1.smartRadioGui.DragBoundArea
                }));
            end;
        end;

        function u1.smartRadioUserInput() -- Line: 3541
            -- upvalues: u1 (ref), u546 (ref)
            u1.activateSmartRadio(not u546);
        end;
    end;

    u2.debugLoadingClient("Character 5");

    if require(game.Teams[u11].Config).MDT then
        local MDT = ScreenGui.Center.Middle.MDT;
        local u593 = 0;
        local u594 = 0;
        local u595 = 0;
        local u596 = "Incident";
        local u597 = nil;
        local u598 = nil;
        local u599 = nil;
        local u600 = nil;
        MDT.Main.Team.Image = game.Teams[u11].Icon.Texture;

        if require(game.Teams[u11].Config).MDT == "NoProfiles" then
            MDT.Main.Buttons.Profile.Visible = false;
            MDT.Main.Buttons.Incident.Position = MDT.Main.Buttons.Profile.Position;
        else
            CharScope.taskDefer(function() -- Line: 3563
                -- upvalues: u10 (ref)
                while true do
                    local v601 = {};

                    for _, v in pairs(u10.getLoadedPlayers()) do
                        v601[v] = v:GetAttribute("CharacterPosition");
                    end;

                    task.wait(40);

                    for i, v in pairs(v601) do
                        if u10.isPlayerLoaded(i) then
                            i:SetAttribute("DelayedCharacterPosition", v);
                        end;
                    end;
                end;
            end);
        end;

        local function loadMDTPanel(p602, p603) -- Line: 3573
            -- upvalues: u593 (ref), u594 (ref), u595 (ref), CharScope (ref), u596 (ref), u597 (ref), MDT (copy), LocalPlayer (ref), u11 (ref), u10 (ref), u2 (ref), u599 (ref), u598 (ref), HumanoidRootPart (copy), u600 (ref), PlayerFunc (ref), loadMDTPanel (copy), u1 (ref), isIncidentActive (copy)
            u593 = (u593 + 1) % 100;
            u594 = (u594 + 1) % 100;
            local u604 = u593;
            local u605 = u594;
            local u606 = u595;
            CharScope.setConnectionsAndThreads("MDTPanel");
            CharScope.setConnectionsAndThreads("MDTIncident");

            if p602 then
                u596 = p602;
                u597 = p603;
                local u607 = nil;

                for _, v in pairs({ "Panel", "List", "Callsign" }) do
                    MDT[v].Visible = false;
                end;

                for _, child in pairs(MDT.Main.Buttons:GetChildren()) do
                    child.BackgroundColor3 = p602 == child.Name and Color3.fromRGB(62, 136, 200) or Color3.fromRGB(48, 108, 157);
                end;

                for _, child in pairs(MDT.List.List._ScrollingList:GetChildren()) do
                    if child:IsA("ImageButton") and (child.Name ~= "ProfilesPreview" and child.Name ~= "IncidentsPreview") then
                        child:Destroy();
                    end;
                end;

                MDT.Main.Buttons.Callsign.TextLabel.Text = "CALLSIGN " .. LocalPlayer:GetAttribute("Callsign");
                MDT.List.List._ScrollingList.AllGroup.Visible = false;
                MDT.List.List._ScrollingList.NearbyGroup.Visible = false;
                MDT.Main.TextLabel.Text = string.upper(u11) .. " TABLET";

                local function listEmptyMessage() -- Line: 3599
                    -- upvalues: MDT (ref)
                    local v608 = true;

                    for _, child in pairs(MDT.List.List._ScrollingList:GetChildren()) do
                        if child:IsA("GuiBase") and child.Visible then
                            v608 = false;
                            break;
                        end;
                    end;

                    MDT.List.EmptyMessage.Visible = v608;
                end;

                MDT.List.EmptyMessage.Visible = false;
                local u609, u610;

                if p602 == "Profile" or p602 == "Incident" then
                    MDT.List.EmptyMessage.Text = p602 == "Profile" and "No Profiles" or "No Incidents";
                    MDT.Panel.Visible = true;
                    MDT.List.Visible = true;
                    MDT.Panel.Profile.Visible = false;
                    MDT.Panel.Incident.Visible = false;
                    MDT.List.Headline.Text = p602 == "Profile" and "PROFILES" or (p602 == "Incident" and "ACTIVE INCIDENTS" or false);

                    u609 = function() -- Line: 3615, Name: updateSearch
                        -- upvalues: MDT (ref), listEmptyMessage (copy)
                        local string_lower_ret = string.lower(MDT.List.SearchBox.TextBoxFrame.TextBox.Text);

                        for _, child in pairs(MDT.List.List._ScrollingList:GetChildren()) do
                            if child:IsA("ImageButton") and (child.Name ~= "ProfilesPreview" and child.Name ~= "IncidentsPreview") then
                                local Attribute = child:GetAttribute("ExtraSearchFilter");

                                if string_lower_ret == "" then
                                    Attribute = true;
                                else
                                    local string_find_ret = string.find(string.lower(child.Title.Text), string_lower_ret, nil, true);

                                    if string_find_ret then
                                        Attribute = string_find_ret;
                                    elseif Attribute then
                                        Attribute = string.find(string.lower(Attribute), string_lower_ret, nil, true);
                                    end;
                                end;

                                child.Visible = Attribute;
                            end;
                        end;

                        listEmptyMessage();
                    end;

                    CharScope.buildSignalData("MDTPanel", { MDT.List.SearchBox.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), u609 });
                    u610 = u10.textBoxSystem(MDT.List.SearchBox.TextBoxFrame, {
                        enableScrolling = true
                    });
                    u610.freeze(true);
                    MDT.List.SearchBox.TextBoxFrame.TextBox.Text = "";
                    MDT.List.SearchBox.TextBoxFrame.TextBox.PlaceholderText = p602 == "Profile" and "Name Or Plate" or "Name Or Number";
                    CharScope.buildSignalData("MDTPanel", unpack(u610.multipleSignalData));
                    CharScope.addThreadOrCleanUpFunction("MDTPanel", u610.cleanUp);
                else
                    u610 = nil;
                    u609 = nil;
                end;

                if p602 == "Callsign" then
                    MDT.Callsign.Visible = true;
                    MDT.Callsign.Number.TextBoxFrame.TextBox.Text = LocalPlayer:GetAttribute("Callsign");
                    CharScope.buildSignalData("MDTPanel", { MDT.Callsign.Number.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), function() -- Line: 3637
                            -- upvalues: MDT (ref), u10 (ref)
                            local TextBox = MDT.Callsign.Number.TextBoxFrame.TextBox;
                            local v611 = u10.toOnlyNumbers(MDT.Callsign.Number.TextBoxFrame.TextBox.Text);
                            TextBox.Text = string.sub(v611, 1, 3);
                        end });
                    local v612 = u10.textBoxSystem(MDT.Callsign.Number.TextBoxFrame);
                    CharScope.buildSignalData("MDTPanel", unpack(v612.multipleSignalData));
                    CharScope.addThreadOrCleanUpFunction("MDTPanel", v612.cleanUp);
                    CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Callsign.Change, function() -- Line: 3643
                        -- upvalues: u10 (ref), MDT (ref), u2 (ref)
                        if not u10.invokeTraffic.setCallsign then
                            local v613 = u10.invokeServerTraffic("setCallsign", MDT.Callsign.Number.TextBoxFrame.TextBox.Text);

                            if v613 == true then
                                MDT.Main.Buttons.Callsign.TextLabel.Text = "CALLSIGN " .. MDT.Callsign.Number.TextBoxFrame.TextBox.Text;
                                u2.notify({
                                    message = "Callsign changed successfully",
                                    color = "green"
                                });

                                return;
                            end;

                            if u10.typeOf(v613) == "string" then
                                u2.notify({
                                    color = "red",
                                    message = v613
                                });
                            end;
                        end;
                    end));
                elseif p602 == "Profile" then
                    CharScope.addThreadOrCleanUpFunction("MDTPanel", CharScope.taskSpawn(function() -- Line: 3654
                        -- upvalues: u2 (ref), MDT (ref), u599 (ref), u605 (copy), u594 (ref), u610 (ref), u10 (ref), CharScope (ref), u598 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u607 (ref), u597 (ref), u600 (ref), u11 (ref), PlayerFunc (ref), u595 (ref), u606 (copy), u609 (ref), loadMDTPanel (ref), u596 (ref), u1 (ref), listEmptyMessage (copy)
                        local function updateStatus(p614, p615) -- Line: 3655
                            -- upvalues: u2 (ref)
                            p614.Status.Wanted.Visible = p615.wantedLevel;
                            p614.Status.Dead.Visible = p615.health and p615.health <= 0;
                            local health = p615.health;

                            if health then
                                if p615.health > 0 then
                                    health = p615.health < 100;
                                else
                                    health = false;
                                end;
                            end;

                            p614.Status.Hurt.Visible = health;
                            p614.Status.Callsign.Visible = p615.callsign;

                            if p615.wantedLevel then
                                u2.refreshWantedGui(p614.Status.Wanted, p615.wantedLevel);
                            end;

                            if p615.callsign then
                                p614.Status.Callsign.TextLabel.Text = p615.callsign;
                                p614.Status.Callsign.ImageColor3 = require(p615.team.Config).RADIO_CHANNEL.color;
                            end;

                            p614:SetAttribute("HasStatus", p615.wantedLevel and 3 or (p615.health and p615.health < 100 and 2 or (p615.callsign and 1 or nil)));
                        end;

                        MDT.List.Loading.Visible = true;

                        while not u599 do
                            task.wait(0.1);

                            if u605 ~= u594 then
                                return;
                            end;
                        end;

                        u610.freeze(false);
                        MDT.List.Loading.Visible = false;
                        local u616 = u10.scrollingListSystem(MDT.Panel.Profile._ScrollingList.Scroll, 0.3, {
                            hideScrollBarWhenNotUsed = true,
                            scrollBar = MDT.Panel.Profile.ScrollBar
                        });
                        CharScope.buildSignalData("MDTPanel", unpack(u616.multipleSignalData));
                        CharScope.addThreadOrCleanUpFunction("MDTPanel", u616.cleanUp);
                        local u617 = nil;

                        local function profile(p618, u619) -- Line: 3677
                            -- upvalues: u10 (ref), MDT (ref), u598 (ref), updateStatus (copy), LocalPlayer (ref), HumanoidRootPart (ref), u607 (ref), u594 (ref), u597 (ref), u600 (ref), u617 (ref), CharScope (ref), u11 (ref), u616 (copy), u2 (ref)
                            local u620 = u10.findLoadedPlayer(p618);

                            if u620 then
                                local u621 = u10.clone(MDT.List.List._ScrollingList.ProfilesPreview);
                                u621.Visible = true;
                                u621.Title.Text = u620.DisplayName;
                                u621.Title.AutoLocalize = false;
                                u621.Name = u620.Name;
                                u621.Parent = MDT.List.List._ScrollingList;

                                if u619.vehicle then
                                    u619.vehicle.fixedName = u10.getVehicleInfoAsText.displayName(u10.availableItems[u619.vehicle.typee][u619.vehicle.name]);
                                    u619.vehicle.fixedLicensePlate = u619.vehicle.customization and (u619.vehicle.customization.CustomLicensePlate or u619.vehicle.customization.LicensePlate);
                                    u621:SetAttribute("ExtraSearchFilter", table.concat({ u619.vehicle.fixedName, u619.vehicle.fixedLicensePlate }, ";"));
                                end;

                                u598.limitYScrollListener();
                                u619.wantedLevel = u620:GetAttribute("WantedLevel");
                                u619.callsign = u620:GetAttribute("Callsign");
                                u619.team = u620.Team;
                                updateStatus(u621, u619);

                                if u620 ~= LocalPlayer and (u620:GetAttribute("CharacterPosition") and (HumanoidRootPart.Position - u620:GetAttribute("CharacterPosition")).Magnitude < 100) then
                                    u621:SetAttribute("Nearby", true);
                                end;

                                local function loadProfile() -- Line: 3699
                                    -- upvalues: u607 (ref), u621 (copy), u594 (ref), u597 (ref), u620 (copy), u600 (ref), u617 (ref), MDT (ref), updateStatus (ref), u619 (copy), u10 (ref), CharScope (ref), LocalPlayer (ref), u11 (ref), u616 (ref)
                                    if u607 == u621 then
                                        return;
                                    end;

                                    if u607 then
                                        u607.BackgroundColor3 = Color3.fromRGB(154, 169, 182);
                                    end;

                                    u594 = (u594 + 1) % 100;
                                    local u622 = u594;
                                    u597 = u620.Name;
                                    u600 = nil;
                                    u621.BackgroundColor3 = Color3.fromRGB(136, 181, 223);
                                    u607 = u621;
                                    u617 = u620;
                                    MDT.Panel.Profile.Visible = true;
                                    MDT.Panel.Profile.PlayerName.Text = u620.DisplayName;
                                    updateStatus(MDT.Panel.Profile, u619);
                                    local v623 = MDT.Panel.Profile.PlayerName.Position.X.Scale + u10.getTextBounds(MDT.Panel.Profile.PlayerName).X / MDT.Panel.Profile.AbsoluteSize.X + 0.17;
                                    MDT.Panel.Profile.Status.Position = UDim2.fromScale(v623, MDT.Panel.Profile.Status.Position.Y.Scale);
                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.PlayerName.Content.Text = "@" .. u620.Name;
                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.LastSeen.Content.Text = "";
                                    CharScope.taskSpawn(function() -- Line: 3717
                                        -- upvalues: u622 (copy), u594 (ref), u620 (ref), MDT (ref), u10 (ref)
                                        while u622 == u594 do
                                            local v624 = u620:GetAttribute("DelayedCharacterPosition") or u620:GetAttribute("CharacterPosition");
                                            MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.LastSeen.Content.Text = v624 and u10.getLocationStringAtPos(v624, true) or "Unknown";
                                            task.wait(10);
                                        end;
                                    end);
                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.Reputation.Content.Text = u620.Reputation.Value;
                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.Team.Content.Text = u620.Team and u620.Team.Name or "";
                                    local v625;

                                    if u620 == LocalPlayer then
                                        v625 = false;
                                    else
                                        v625 = u11 == "Police";
                                    end;

                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.RadioPin.Visible = v625;
                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Area.Visible = u620 ~= LocalPlayer;
                                    local Attribute = u620:GetAttribute("DirtyMoney");

                                    if Attribute and Attribute < 1000 then
                                        Attribute = nil;
                                    end;

                                    if Attribute then
                                        MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.Bounty.Content.Text = "＄" .. u10.commaValue(math.floor(Attribute / 1000) * 100);
                                    end;

                                    MDT.Panel.Profile._ScrollingList.Scroll.Profile.Details.Bounty.Visible = Attribute;
                                    u10.createUpdatedAvatarThumbnail(MDT.Panel.Profile._ScrollingList.Scroll.Profile.PlayerIcon, u620, u619.avatar, u619.ageLook);
                                    MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Visible = u619.vehicle;
                                    MDT.Panel.Profile._ScrollingList.Scroll.VehicleTitle.Visible = u619.vehicle;

                                    if u619.vehicle then
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Viewport:ClearAllChildren();
                                        u600 = u10.clone(u10.getOriginalVehicle(u10.availableItems[u619.vehicle.typee][u619.vehicle.name]));
                                        u600:PivotTo(CFrame.new(0, -u600.PrimaryPart.VisualCenter.Position.Y / 2, 0) * CFrame.Angles(0, 3.141592653589793, 0));
                                        u600.Parent = MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Viewport;
                                        local v626 = u619.vehicle.customization or {};
                                        v626.CleanlinessDirt = nil;
                                        v626.CleanlinessSnow = nil;
                                        v626.Durability = nil;
                                        v626.CrashPointsDeformation = nil;
                                        u10.loadVehicleCustomization(u600, v626);
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.VehicleName.Content.Text = u619.vehicle.fixedName;
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.Color.Content.Text = not u600.Model.Color:FindFirstChild("TextureGloss") and u10.getColorNameRGB(u600.Model.Color.Color, true) or u10.getVehicleInfo.getVehicleTeam(u600) .. " Livery";
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.LicensePlate.Content.Text = u619.vehicle.fixedLicensePlate;
                                        local v627;

                                        if u620 == LocalPlayer then
                                            v627 = false;
                                        else
                                            v627 = u11 == "Police";
                                        end;

                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.RadioPin.Visible = v627;
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.Status.Content.Text = u619.vehicle.isStolen and "Stolen" or (u619.vehicle.belongsTo and u619.vehicle.belongsTo ~= u620 and ("Belongs To " .. u619.vehicle.belongsTo.DisplayName or "Clear") or "Clear");
                                        MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.Status.Content.TextColor3 = u619.vehicle.isStolen and Color3.fromRGB(255, 150, 129) or Color3.fromRGB(255, 255, 255);
                                    end;

                                    for _, v in pairs({ "Crimes", "CriminalHistory" }) do
                                        MDT.Panel.Profile._ScrollingList.Scroll[v].Visible = false;
                                        MDT.Panel.Profile._ScrollingList.Scroll[v .. "Title"].Visible = false;
                                        u10.setGuiTags(MDT.Panel.Profile._ScrollingList.Scroll[v].Grid, {
                                            reset = true
                                        });
                                        local v628 = u619[u10.firstToLower(v)];
                                        local v629 = v;

                                        for i, v2 in pairs(v628) do
                                            local v630 = u10.typeOf(v2) == "table" and #v2 or v2;
                                            u10.setGuiTags(MDT.Panel.Profile._ScrollingList.Scroll[v629].Grid, {
                                                addCustom = i .. (v630 > 1 and " (x" .. v630 .. ")" or "")
                                            });
                                        end;

                                        if u10.indexedTableSize(v628) > 0 then
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629].Size = UDim2.fromScale(1, 0.063);
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629].Grid.Size = UDim2.fromScale(1, 1);
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629].Visible = true;
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629 .. "Title"].Visible = true;
                                            local v631 = MDT.Panel.Profile._ScrollingList.Scroll[v629].Grid.UIGridLayout.AbsoluteContentSize.Y / MDT.Panel.Profile._ScrollingList.Scroll.AbsoluteSize.Y;
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629].Size = UDim2.fromScale(1, v631);
                                            MDT.Panel.Profile._ScrollingList.Scroll[v629].Grid.Size = UDim2.fromScale(1, 0.063 / v631);
                                            u616.limitYScrollListener();
                                        end;
                                    end;

                                    u616.limitYScrollListener();
                                end;

                                CharScope.buildSignalData("MDTPanel", u2.mouseButton(u621, loadProfile, {
                                    mobileButtonType = "MouseButton1Click"
                                }));

                                if u597 == u620.Name then
                                    loadProfile();
                                end;
                            end;
                        end;

                        for i, v in pairs(u599) do
                            profile(i, v);
                        end;

                        local function sortList() -- Line: 3796
                            -- upvalues: MDT (ref)
                            local v632 = {};

                            for _, child in pairs(MDT.List.List._ScrollingList:GetChildren()) do
                                if child:IsA("ImageButton") and child.Visible then
                                    table.insert(v632, child);
                                end;
                            end;

                            table.sort(v632, function(p633, p634) -- Line: 3801
                                local v635 = p633:GetAttribute("Nearby") and true or false;

                                if v635 ~= (p634:GetAttribute("Nearby") and true or false) then
                                    return v635;
                                end;

                                local v636 = p633:GetAttribute("HasStatus") or 0;
                                local v637 = p634:GetAttribute("HasStatus") or 0;

                                if v636 == v637 then
                                    return string.lower(p633.Name) < string.lower(p634.Name);
                                end;

                                return v637 < v636;
                            end);
                            local v638 = false;

                            for i, v in pairs(v632) do
                                local Attribute = v:GetAttribute("Nearby");
                                v.LayoutOrder = (Attribute and 0 or 100) + i;
                                v638 = Attribute and true or v638;
                            end;

                            MDT.List.List._ScrollingList.AllGroup.Visible = v638;
                            MDT.List.List._ScrollingList.NearbyGroup.Visible = v638;
                        end;

                        sortList();
                        u10.loadedPlayerAdded(CharScope.buildSignalData, "MDTPanel", nil, function(p639) -- Line: 3820
                            -- upvalues: PlayerFunc (ref), u595 (ref), u606 (ref), u599 (ref), profile (copy), sortList (copy), u609 (ref)
                            local v640 = PlayerFunc:InvokeServer("readProfileDataMDT", { p639 });
                            local Name = p639.Name;

                            if u595 == u606 and v640[Name] then
                                u599[Name] = v640[Name];
                                profile(Name, u599[Name]);
                                sortList();
                                u609();
                            end;
                        end);
                        CharScope.buildSignalData("MDTPanel", { game.Players.PlayerRemoving, function(p641) -- Line: 3830
                                -- upvalues: MDT (ref), u599 (ref), u607 (ref), CharScope (ref), loadMDTPanel (ref), u596 (ref)
                                if MDT.List.List._ScrollingList:FindFirstChild(p641.Name) then
                                    MDT.List.List._ScrollingList[p641.Name]:Destroy();
                                end;

                                u599[p641.Name] = nil;

                                if u607 and p641.Name == u607.Name then
                                    CharScope.taskDefer(function() -- Line: 3833
                                        -- upvalues: loadMDTPanel (ref), u596 (ref)
                                        loadMDTPanel(u596);
                                    end);
                                end;
                            end });
                        CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Panel.Profile._ScrollingList.Scroll.Profile.RadioPin, function() -- Line: 3837
                            -- upvalues: u617 (ref), u1 (ref), u11 (ref)
                            if u617 then
                                u1.chatModule.createMessage({
                                    username = "Dispatch",
                                    radio = true,
                                    sendTo = u11,
                                    team = u11,
                                    text = "The player is " .. u617.DisplayName
                                });
                            end;
                        end));
                        CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.RadioPin, function() -- Line: 3843
                            -- upvalues: u617 (ref), u1 (ref), u11 (ref), u10 (ref), u600 (ref), MDT (ref)
                            if u617 then
                                u1.chatModule.createMessage({
                                    username = "Dispatch",
                                    radio = true,
                                    sendTo = u11,
                                    team = u11,
                                    text = "The vehicle is " .. u10.getVehicleInfoAsText.colorDisplayNameAndCategoryString(u600) .. " (" .. MDT.Panel.Profile._ScrollingList.Scroll.Vehicle.Details.LicensePlate.Content.Text .. ")"
                                });
                            end;
                        end));
                        CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Panel.Profile._ScrollingList.Scroll.Profile.Area, function() -- Line: 3849
                            -- upvalues: u617 (ref), u10 (ref), u1 (ref)
                            local v642 = u617 and (u617:GetAttribute("DelayedCharacterPosition") or u617:GetAttribute("CharacterPosition"));

                            if v642 then
                                local Area = u10.getArea(v642);
                                u1.activateMap(true, game.ReplicatedStorage.Gameplay.Areas[Area].Position);
                            end;
                        end));
                        listEmptyMessage();
                    end));
                elseif p602 == "Incident" then
                    u610.freeze(false);
                    MDT.List.Loading.Visible = false;
                    local u643 = nil;

                    local function incidentfunc(u644) -- Line: 3866
                        -- upvalues: isIncidentActive (ref), u10 (ref), MDT (ref), u598 (ref), LocalPlayer (ref), u607 (ref), u594 (ref), CharScope (ref), u597 (ref), u643 (ref), u11 (ref), u2 (ref), listEmptyMessage (copy), loadMDTPanel (ref), u596 (ref)
                        if isIncidentActive(u644) then
                            local u645 = u10.clone(MDT.List.List._ScrollingList.IncidentsPreview);
                            u645.Visible = true;
                            u645.Title.Text = u644.Name;
                            u645.Name = "Incident";
                            u645:SetAttribute("StartTime", u644.StartTime.Value);
                            u645:SetAttribute("ExtraSearchFilter", u644:WaitForChild("Code").Value);
                            u645.Parent = MDT.List.List._ScrollingList;
                            u598.limitYScrollListener();
                            local u646 = u644.Players:FindFirstChild(LocalPlayer.Name);
                            u645.Code.Checkmark.Visible = u646;
                            u645.Code.TextLabel.Visible = not u646;
                            local Value = u644:WaitForChild("Priority").Value;

                            if u646 then
                                u645.Code.ImageColor3 = Color3.fromRGB(103, 191, 85);
                            else
                                u645.Code.ImageColor3 = Value == 1 and Color3.fromRGB(255, 232, 101) or (Value == 2 and Color3.fromRGB(255, 173, 90) or Color3.fromRGB(255, 111, 85));
                                u645.Code.TextLabel.Text = u644:WaitForChild("Code").Value;
                            end;

                            local function loadIncident() -- Line: 3886
                                -- upvalues: u607 (ref), u645 (copy), u594 (ref), CharScope (ref), u597 (ref), u644 (copy), u643 (ref), MDT (ref), u646 (copy), Value (copy), u10 (ref), u11 (ref)
                                if u607 == u645 then
                                    return;
                                end;

                                if u607 then
                                    u607.BackgroundColor3 = Color3.fromRGB(154, 169, 182);
                                end;

                                u594 = (u594 + 1) % 100;
                                local u647 = u594;
                                CharScope.setConnectionsAndThreads("MDTIncident");
                                u597 = u644.Code.Value;
                                u645.BackgroundColor3 = Color3.fromRGB(136, 181, 223);
                                u607 = u645;
                                u643 = u644;
                                MDT.Panel.Incident.Visible = true;
                                MDT.Panel.Incident.Join.TextLabel.Text = u646 and "LEAVE" or "JOIN";
                                MDT.Panel.Incident.Title.Text = u644.Name;
                                MDT.Panel.Incident.Code.Visible = u645.Code.Visible;
                                MDT.Panel.Incident.Code.Checkmark.Visible = u645.Code.Checkmark.Visible;
                                MDT.Panel.Incident.Code.TextLabel.Visible = u645.Code.TextLabel.Visible;
                                MDT.Panel.Incident.Code.ImageColor3 = u645.Code.ImageColor3;
                                MDT.Panel.Incident.Priority.Visible = Value > 1;

                                if Value > 1 then
                                    MDT.Panel.Incident.Priority.TextColor3 = Value == 2 and Color3.fromRGB(255, 173, 90) or Color3.fromRGB(255, 111, 85);
                                    MDT.Panel.Incident.Priority.Text = Value == 2 and "MEDIUM PRIORITY" or "HIGH PRIORITY";
                                end;

                                MDT.Panel.Incident.Code.TextLabel.Text = u645.Code.TextLabel.Text;

                                if u645.Code.Visible then
                                    MDT.Panel.Incident.Code.Position = UDim2.fromScale(MDT.Panel.Incident.Title.Position.X.Scale + u10.getTextBounds(MDT.Panel.Incident.Title).X / MDT.Panel.Incident.AbsoluteSize.X + 0.17, MDT.Panel.Incident.Code.Position.Y.Scale);
                                end;

                                MDT.Panel.Incident.Details.Description.TextLabel.Text = u644.Value;
                                MDT.Panel.Incident.Details.Description2Lines.TextLabel.Text = u644.Value;
                                local _, u648 = u10.getTextBounds(MDT.Panel.Incident.Details.Description.TextLabel);
                                MDT.Panel.Incident.Details.Description.Visible = u648 <= 1;
                                MDT.Panel.Incident.Details.Description2Lines.Visible = u648 > 1;
                                u10.waitForTextFilterResultText(CharScope.buildSignalData, "MDTIncident", u644, function(p649) -- Line: 3915
                                    -- upvalues: MDT (ref), u648 (copy)
                                    MDT.Panel.Incident.Details[u648 > 1 and "Description2Lines" or "Description"].TextLabel.Text = p649;
                                end);
                                local u650 = nil;

                                local function setLocation(p651, p652) -- Line: 3919
                                    -- upvalues: u650 (ref), MDT (ref), u10 (ref)
                                    if u650 ~= p651 then
                                        u650 = p651;
                                        MDT.Panel.Incident.Details.Location.TextLabel.Text = u10.getLocationStringAtPos(u10.getVectorFromLocation(p651), nil, {
                                            streetName = p652 or false
                                        });
                                    end;
                                end;

                                CharScope.taskDefer(function() -- Line: 3925
                                    -- upvalues: u594 (ref), u647 (copy), setLocation (copy), u644 (ref), u11 (ref)
                                    while u594 == u647 do
                                        setLocation(u644.Team[u11].Location.Value, u644.Team[u11].Location:GetAttribute("StreetName"));
                                        task.wait(2);
                                    end;
                                end);
                                setLocation(u644.Team[u11].Location.Value, u644.Team[u11].Location:GetAttribute("StreetName"));

                                local function setObjective(p653) -- Line: 3932
                                    -- upvalues: MDT (ref), u10 (ref)
                                    MDT.Panel.Incident.Details.Objective.Visible = p653 ~= "";
                                    MDT.Panel.Incident.Details.Objective.TextLabel.Text = p653;
                                    MDT.Panel.Incident.Details.Objective2Lines.TextLabel.Text = p653;
                                    local _, v654 = u10.getTextBounds(MDT.Panel.Incident.Details.Objective.TextLabel);
                                    MDT.Panel.Incident.Details.Objective.Visible = v654 <= 1;
                                    MDT.Panel.Incident.Details.Objective2Lines.Visible = v654 > 1;
                                end;

                                setObjective(u644.Team[u11].Objective.Value);
                                CharScope.buildSignalData("MDTIncident", { u644.Team[u11].Objective.Changed, setObjective });

                                for _, child in pairs(MDT.Panel.Incident.Details.Unit.Units:GetChildren()) do
                                    if child.Name ~= "Preview" and child:IsA("ImageLabel") then
                                        child:Destroy();
                                    end;
                                end;

                                local function addUnit(p655) -- Line: 3946
                                    -- upvalues: u10 (ref), MDT (ref)
                                    if p655 and p655:GetAttribute("Callsign") then
                                        local v656 = u10.clone(MDT.Panel.Incident.Details.Unit.Units.Preview);
                                        v656.Name = p655.Name;
                                        v656.Visible = true;
                                        v656.TextLabel.Text = p655:GetAttribute("Callsign");
                                        v656.ImageColor3 = require(p655.Team.Config).RADIO_CHANNEL.color;
                                        v656.Parent = MDT.Panel.Incident.Details.Unit.Units;
                                    end;
                                end;

                                for _, child in pairs(u644.Players:GetChildren()) do
                                    addUnit(child.Value);
                                end;

                                CharScope.buildSignalData("MDTIncident", { u644.Players.ChildAdded, function(p657) -- Line: 3957
                                        -- upvalues: addUnit (copy)
                                        addUnit(p657.Value);
                                    end });
                                CharScope.buildSignalData("MDTIncident", { u644.Players.ChildRemoved, function(p658) -- Line: 3958
                                        -- upvalues: MDT (ref)
                                        if MDT.Panel.Incident.Details.Unit.Units:FindFirstChild(p658.Name) then
                                            MDT.Panel.Incident.Details.Unit.Units[p658.Name]:Destroy();
                                        end;
                                    end });
                                CharScope.taskDefer(function() -- Line: 3961
                                    -- upvalues: u644 (ref), u594 (ref), u647 (copy), u10 (ref), MDT (ref)
                                    local StartTime = u644:WaitForChild("StartTime");

                                    while u594 == u647 do
                                        local v659 = (u10.getDistributedGameTime() - StartTime.Value) / 60;
                                        local math_floor_ret = math.floor(v659);
                                        MDT.Panel.Incident.Details.Time.TextLabel.Text = math_floor_ret <= 0 and "Seconds Ago" or (math_floor_ret == 1 and "1 Minute Ago" or math_floor_ret .. " Minutes Ago");
                                        task.wait(10);
                                    end;
                                end);
                            end;

                            CharScope.buildSignalData("MDTPanel", u2.mouseButton(u645, loadIncident, {
                                mobileButtonType = "MouseButton1Click"
                            }));

                            if u597 == u644.Code.Value then
                                loadIncident();
                            end;

                            CharScope.buildSignalData("MDTPanel", { u644.Team[u11].Solo.Changed, function(p660) -- Line: 3972
                                    -- upvalues: u645 (copy), u644 (copy), LocalPlayer (ref), u598 (ref), listEmptyMessage (ref), u643 (ref), loadMDTPanel (ref), u596 (ref)
                                    if u645.Parent and (p660 and not u644.Players:FindFirstChild(LocalPlayer.Name)) then
                                        u645:Destroy();
                                        u598.limitYScrollListener();
                                        listEmptyMessage();

                                        if u644 == u643 then
                                            loadMDTPanel(u596);
                                        end;
                                    end;
                                end });
                            CharScope.buildSignalData("MDTPanel", { u644.Team[u11].Destroying, function() -- Line: 3980
                                    -- upvalues: u645 (copy), u598 (ref), listEmptyMessage (ref), u644 (copy), u643 (ref), loadMDTPanel (ref), u596 (ref)
                                    u645:Destroy();
                                    u598.limitYScrollListener();
                                    listEmptyMessage();

                                    if u644 == u643 then
                                        loadMDTPanel(u596);
                                    end;
                                end });
                        end;
                    end;

                    for _, child in pairs(game.ReplicatedStorage.Gameplay.Missions.Active:GetChildren()) do
                        if child.Name ~= "Preview" then
                            incidentfunc(child);
                        end;
                    end;

                    local function u664() -- Line: 3991
                        -- upvalues: MDT (ref)
                        local v661 = {};

                        for _, child in pairs(MDT.List.List._ScrollingList:GetChildren()) do
                            if child.Name == "Incident" then
                                table.insert(v661, child);
                            end;
                        end;

                        table.sort(v661, function(p662, p663) -- Line: 3996
                            return p662:GetAttribute("StartTime") > p663:GetAttribute("StartTime");
                        end);

                        for i, v in pairs(v661) do
                            v.LayoutOrder = i;
                        end;
                    end;

                    u664();
                    CharScope.buildSignalData("MDTPanel", { game.ReplicatedStorage.Gameplay.Missions.Active.ChildAdded, function(p665) -- Line: 4002
                            -- upvalues: incidentfunc (copy), u664 (copy), listEmptyMessage (copy)
                            incidentfunc(p665);
                            u664();
                            listEmptyMessage();
                        end });
                    CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Panel.Incident.Locate, function() -- Line: 4009
                        -- upvalues: u1 (ref), u10 (ref), u643 (ref), u11 (ref)
                        u1.activateMap(true, u10.typeOf(u643.Team[u11].Location.Value) == "Instance" and u643.Team[u11].Location.Value.Position or u643.Team[u11].Location.Value);
                    end));
                    CharScope.buildSignalData("MDTPanel", u2.mouseButton(MDT.Panel.Incident.Join, function() -- Line: 4014
                        -- upvalues: u10 (ref), MDT (ref), u643 (ref), u604 (copy), u593 (ref), LocalPlayer (ref)
                        if not u10.invokeTraffic.talkToMission then
                            local v666 = MDT.Panel.Incident.Join.TextLabel.Text == "JOIN";
                            MDT.Panel.Incident.Join.TextLabel.Text = "PENDING...";
                            u10.invokeServerTraffic("talkToMission", v666 and u643.ID.Value .. "join" or "leave");

                            if u643 == u643 and u604 == u593 then
                                MDT.Panel.Incident.Join.TextLabel.Text = u643.Players:FindFirstChild(LocalPlayer.Name) and "LEAVE" or "JOIN";
                            end;
                        end;
                    end));
                    local activeMission = u2.activeMission;
                    CharScope.taskDefer(function() -- Line: 4026
                        -- upvalues: u604 (copy), u593 (ref), activeMission (ref), u2 (ref), u596 (ref), loadMDTPanel (ref), u597 (ref)
                        while u604 == u593 do
                            if activeMission ~= u2.activeMission then
                                activeMission = u2.activeMission;

                                if u596 == "Incident" then
                                    loadMDTPanel(u596, u597);
                                end;
                            end;

                            task.wait(0.2);
                        end;
                    end);
                    listEmptyMessage();
                end;
            end;
        end;

        local u667 = false;

        function u1.activateMDT(p668, p669, p670) -- Line: 4042
            -- upvalues: u2 (ref), u667 (ref), u595 (ref), CharScope (ref), u599 (ref), PlayerFunc (ref), MDT (copy), u1 (ref), UserInputService (ref), u10 (ref), loadMDTPanel (copy), u598 (ref), Mouse (ref), u596 (ref), u597 (ref)
            if u2.openedGui and u2.openedGui ~= "MDT" then
                return;
            end;

            if p668 == nil then
                p668 = not u667 or p668;
            end;

            u667 = p668;
            u595 = (u595 + 1) % 100;
            local u671 = u595;
            CharScope.setConnectionsAndThreads("MDT");
            u2.openGui(u667 and "MDT");
            u2.activateBlur("mdt", u667);
            u599 = nil;

            if u667 then
                CharScope.taskSpawn(function() -- Line: 4052
                    -- upvalues: PlayerFunc (ref), u595 (ref), u671 (copy), u599 (ref)
                    local v672 = PlayerFunc:InvokeServer("readProfileDataMDT");

                    if u595 == u671 then
                        u599 = v672;
                    end;
                end);
                CharScope.buildSignalData("MDT", u2.mouseButton(MDT.Main.Close, function() -- Line: 4056
                    -- upvalues: u1 (ref)
                    u1.activateMDT(false);
                end, {
                    addMobileButton = true
                }));
                local u673 = false;
                CharScope.taskDelay(0.03, function() -- Line: 4060
                    -- upvalues: u673 (ref)
                    u673 = true;
                end);
                CharScope.buildSignalData("MDT", { UserInputService.InputBegan, function(p674) -- Line: 4061
                        -- upvalues: u2 (ref), MDT (ref), u10 (ref), u673 (ref), u1 (ref)
                        if p674.UserInputType == Enum.UserInputType.MouseButton1 or p674.UserInputType == Enum.UserInputType.Touch then
                            if u2.isMouseObstructedByBlackBackground(MDT.Main.Tablet.ZIndex) then
                                return;
                            end;

                            if not u10.isInFrame(MDT.Main.Tablet) and u673 then
                                u1.activateMDT(false);
                            end;
                        end;
                    end });

                for _, child in pairs(MDT.Main.Buttons:GetChildren()) do
                    CharScope.buildSignalData("MDT", u2.mouseButton(child, function() -- Line: 4070
                        -- upvalues: loadMDTPanel (ref), child (copy)
                        loadMDTPanel(child.Name);
                    end));
                end;

                u598 = u10.scrollingListSystem(MDT.List.List._ScrollingList, 0.3, {
                    hideScrollBarWhenNotUsed = true,
                    scrollBar = MDT.List.ScrollBar
                });
                CharScope.buildSignalData("MDT", unpack(u598.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("MDT", u598.cleanUp);
            else
                Mouse.Icon = "";
                u10.createUpdatedAvatarThumbnail(MDT.Panel.Profile._ScrollingList.Scroll.Profile.PlayerIcon);
            end;

            CharScope.taskSpawn(function() -- Line: 4081
                -- upvalues: PlayerFunc (ref), u667 (ref)
                PlayerFunc:InvokeServer("equipSpecialItem", "MDT", u667);
            end);
            loadMDTPanel(u667 and (p669 or u596), u667 and (p670 or u597));
            u10.guiTransition(MDT, "Position", UDim2.fromScale(0, 1), u667);
        end;
    end;

    function u1.arrestedEscort(p675, p676) -- Line: 4088
        -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), u9 (ref)
        local PlayerFromCharacter = u10.getPlayerFromCharacter(p675.Parent.Parent);

        if PlayerFromCharacter then
            print("DEBUG2 - 2");

            if u10.getInstanceAttribute(PlayerFromCharacter, "EscortedBy") == LocalPlayer then
                u1.escortPlayer();
                u10.waitForFunc(function() -- Line: 4095
                    -- upvalues: u10 (ref), PlayerFromCharacter (copy)
                    return not u10.getInstanceAttribute(PlayerFromCharacter, "EscortedBy");
                end);
                u9.refreshDisplayedPrompts();

                return;
            end;

            if not u10.getVehicleInfo.inVehicle(PlayerFromCharacter) then
                print("DEBUG2 - 3");
                u1.escortPlayer(p676, PlayerFromCharacter);
                u9.refreshDisplayedPrompts();
            end;
        end;
    end;

    function u1.arrestedJail(p677) -- Line: 4105
        -- upvalues: u10 (ref)
        local Parent = p677.Parent.Parent;
        local PlayerFromCharacter = u10.getPlayerFromCharacter(Parent);

        if PlayerFromCharacter and (u10.isPointInJailPlayerArea(Parent.PrimaryPart.Position) and not u10.invokeTraffic.arrestClient) then
            u10.invokeServerTraffic("arrestClient", "jailArrestedPlayer", {
                player = PlayerFromCharacter
            });
        end;
    end;

    function u1.activateSelectionWheel(...) -- Line: 4118
        -- upvalues: u2 (ref), u10 (ref), SelectionWheel (copy), u1 (ref), selectionWheelSystem (copy)
        local v678 = ... and true;

        if u2.openedGui and u2.openedGui ~= "SelectionWheel" then
            return;
        end;

        if not (v678 and u2.openedGui) then
            u10.lockScroll("selectionWheel", v678);
            u2.activateBlur("selectionWheel", v678);
        end;

        selectionWheelSystem(SelectionWheel, {
            radius = 0.365,

            createButton = function(p679) -- Line: 4128, Name: createButton
                -- upvalues: u10 (ref), SelectionWheel (ref)
                local v680 = u10.clone(SelectionWheel.Slots[p679.icon and "Preview" or "TextPreview"]);
                v680.TextLabel.Text = p679.id;

                if p679.icon then
                    v680.Image = p679.icon;

                    return v680;
                end;

                v680.MainText.Text = p679.name;

                return v680;
            end,

            close = function() -- Line: 4134, Name: close
                -- upvalues: u1 (ref)
                u1.activateSelectionWheel();
            end,

            mouseEnter = function(p681) -- Line: 4137, Name: mouseEnter
                -- upvalues: SelectionWheel (ref)
                SelectionWheel.Shortcut.Visible = p681.key;
                SelectionWheel.Description.Text = p681.description or "";

                if p681.key then
                    SelectionWheel.Shortcut.Button.ButtonText.Text = p681.key;
                end;

                SelectionWheel.MiddleText.Text = p681.name;
            end,

            mouseLeave = function() -- Line: 4145, Name: mouseLeave
                -- upvalues: SelectionWheel (ref)
                SelectionWheel.Shortcut.Visible = false;
                SelectionWheel.Description.Text = "";
                SelectionWheel.MiddleText.Text = "";
            end
        }, ...);

        if not (v678 and u2.openedGui) then
            u10.guiTransition(SelectionWheel, "Size", 0.9, v678);
        end;

        u2.openGui(v678 and "SelectionWheel");
    end;

    function u1.selectionWheelUserInput() -- Line: 4156
        -- upvalues: u1 (ref), u5 (ref), u4 (ref), u2 (ref), u11 (ref), u10 (ref), LocalPlayer (ref), GameRules (ref)
        u1.activateSelectionWheel({
            name = "Phone",
            icon = "rbxassetid://104446651924586",
            key = "X",
            close = true,

            call = function() -- Line: 4159, Name: call
                -- upvalues: u5 (ref)
                u5.pullOutPhoneUserInput();
            end
        }, {
            name = "Map",
            icon = "rbxassetid://14091097075",
            key = "M",
            close = true,

            call = function() -- Line: 4160, Name: call
                -- upvalues: u1 (ref)
                u1.activateMap(true);
            end
        }, {
            name = "Inventory",
            icon = "rbxassetid://6719884688",
            key = "B",
            close = true,

            call = function() -- Line: 4161, Name: call
                -- upvalues: u4 (ref)
                u4.activateInventory(true);
            end
        }, {
            name = "Emotes",
            icon = "rbxassetid://6720006292",
            key = ".",
            close = true,

            call = function() -- Line: 4162, Name: call
                -- upvalues: u1 (ref)
                u1.emoteMenu(true);
            end
        }, {
            name = "Leaderboard",
            icon = "rbxassetid://10813847426",
            key = "~",
            close = true,

            call = function() -- Line: 4163, Name: call
                -- upvalues: u2 (ref)
                u2.activateMenu("Leaderboard");
            end
        }, u1.activateMDT and {
            icon = "rbxassetid://6954862147",
            key = "N",
            close = true,
            name = u11 .. " Tablet",

            call = function() -- Line: 4164, Name: call
                -- upvalues: u1 (ref)
                u1.activateMDT(true);
            end
        } or nil, u1.activateSmartRadio and {
            name = "Smart Radio",
            icon = "rbxassetid://10019743613",
            key = ",",
            close = true,

            call = function() -- Line: 4165, Name: call
                -- upvalues: u1 (ref)
                u1.smartRadioUserInput();
            end
        } or nil, u10.getInstanceAttribute(LocalPlayer, "Pet") and {
            name = "Pet",
            icon = "rbxassetid://8397350995",

            call = function() -- Line: 4166, Name: call
                -- upvalues: u1 (ref)
                u1.activatePetOptions();
            end
        } or nil, (u10.isCommunityServer() and u10.serverStaff(LocalPlayer) or not u10.isCommunityServer() and u10.gameStaff(LocalPlayer)) and ({
            icon = "rbxassetid://16288380368",
            key = "\\",
            close = true,
            name = u10.isCommunityServer() and "Server Panel" or "Game Staff Panel",

            call = function() -- Line: 4167, Name: call
                -- upvalues: u10 (ref), u2 (ref)
                if u10.isCommunityServer() then
                    u2.privateServerPanel(true);

                    return;
                end;

                u2.gameStaffPanel(true);
            end
        } or nil) or nil, u2.readPlayerData("Reputation") >= GameRules.minRoleplaySceneReputation and u2.platform == "Mobile" and ({
            name = "Roleplay Scene",
            icon = "rbxassetid://102616063535687",
            close = true,

            call = function() -- Line: 4168, Name: call
                -- upvalues: u1 (ref)
                u1.activateRoleplayScene(true);
            end
        } or nil) or nil);
    end;

    function u1.stopSelectionWheelUserInput() -- Line: 4171
        -- upvalues: u2 (ref), u1 (ref)
        if u2.openedGui == "SelectionWheel" then
            u1.activateSelectionWheel();
        end;
    end;

    CharScope.buildSignalData("Global", u2.mouseButton(FrontGui:WaitForChild("TopBarButtons").SelectionWheel, function() -- Line: 4174
        -- upvalues: u2 (ref), u1 (ref)
        if u2.openedGui == "SelectionWheel" then
            u1.activateSelectionWheel();

            return;
        end;

        if u2.openedGui == "EmoteMenu" then
            u1.emoteMenu();

            return;
        end;

        u1.selectionWheelUserInput();
    end));
    CharScope.buildSignalData("Global", u10.buttonHoverSignalData(FrontGui.TopBarButtons.SelectionWheel, {
        intensity = 1
    }));
    local Emotes = u1.getHumanoidDescription():GetEmotes();
    local v682 = {};
    local v683 = nil;

    for _, v in pairs(u1.getHumanoidDescription():GetEquippedEmotes()) do
        if Emotes[v.Name] then
            local v684 = {
                close = true,
                name = v.Name,

                call = function() -- Line: 4185, Name: call
                    -- upvalues: u1 (ref), v (copy)
                    u1.playEmote(v.Name, true);
                end,

                robloxEmote = tostring(Emotes[v.Name][1])
            };
            table.insert(v682, v684);
        end;
    end;

    table.sort(v682, function(p685, p686) -- Line: 4186
        return p685.name < p686.name;
    end);
    local v687;

    if u11 == "Police" then
        v687 = {
            {
                name = "Hands On Belt",
                close = true,

                call = function() -- Line: 4189, Name: call
                    -- upvalues: u1 (ref)
                    u1.playEmote("Hands On Belt");
                end
            }
        };
    elseif u11 == "Medical" or u11 == "Fire" then
        v687 = {
            {
                name = "Healing Somebody",
                close = true,

                call = function() -- Line: 4194, Name: call
                    -- upvalues: u1 (ref)
                    u1.playEmote("Healing Somebody");
                end
            },
            {
                name = "Healing Somebody Standing",
                close = true,

                call = function() -- Line: 4195, Name: call
                    -- upvalues: u1 (ref)
                    u1.playEmote("Healing Somebody Standing");
                end
            }
        };
    else
        v687 = u11 == "Chef" and {
            {
                name = "Preparing Food",
                close = true,

                call = function() -- Line: 4199, Name: call
                    -- upvalues: u1 (ref)
                    u1.playEmote("Preparing Food");
                end
            }
        } or v683;
    end;

    local u688 = {
        General = {
            {
                {
                    name = "Bring Player",
                    close = true,
                    sharedEmote = true,

                    call = function() -- Line: 4206, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Bring Player");
                    end
                },
                {
                    name = "Depressed",
                    close = true,

                    call = function() -- Line: 4207, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Depressed");
                    end
                },
                {
                    name = "Face Palm",
                    close = true,

                    call = function() -- Line: 4208, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Face Palm");
                    end
                },
                {
                    name = "Gangster",
                    close = true,

                    call = function() -- Line: 4209, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Gangster");
                    end
                },
                {
                    name = "Ground Sit",
                    close = true,

                    call = function() -- Line: 4210, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Ground Sit");
                    end
                },
                {
                    name = "Hands On Hips",
                    close = true,

                    call = function() -- Line: 4211, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Hands On Hips");
                    end
                },
                {
                    name = "Hands Up",
                    close = true,

                    call = function() -- Line: 4212, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Hands Up");
                    end
                },
                {
                    name = "Hurt In Leg",
                    close = true,

                    call = function() -- Line: 4213, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Hurt In Leg");
                    end
                },
                {
                    name = "Lay Down",
                    close = true,

                    call = function() -- Line: 4214, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Lay Down");
                    end
                },
                {
                    name = "Pushups",
                    close = true,

                    call = function() -- Line: 4215, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Pushups");
                    end
                },
                {
                    name = "Think",
                    close = true,

                    call = function() -- Line: 4216, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Think");
                    end
                },
                {
                    name = "Wave",
                    close = true,

                    call = function() -- Line: 4217, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Wave");
                    end
                }
            },
            {
                {
                    name = "Crossed Arms",
                    close = true,

                    call = function() -- Line: 4220, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Crossed Arms");
                    end
                },
                {
                    name = "Ground Sit2",
                    close = true,

                    call = function() -- Line: 4221, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Ground Sit2");
                    end
                },
                {
                    name = "Lay Down2",
                    close = true,

                    call = function() -- Line: 4222, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Lay Down2");
                    end
                },
                {
                    name = "Situps",
                    close = true,

                    call = function() -- Line: 4223, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Situps");
                    end
                },
                {
                    name = "Sad Sit",
                    close = true,

                    call = function() -- Line: 4224, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Sad Sit");
                    end
                },
                {
                    name = "Take Photo",
                    close = true,

                    call = function() -- Line: 4225, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Take Photo");
                    end
                },
                {
                    name = "Wait",
                    close = true,

                    call = function() -- Line: 4226, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Wait");
                    end
                },
                {
                    name = "Blow Kiss",
                    close = true,

                    call = function() -- Line: 4228, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Blow Kiss");
                    end
                },
                {
                    name = "Cheer On",
                    close = true,

                    call = function() -- Line: 4229, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Cheer On");
                    end
                },
                {
                    name = "Clap Hands",
                    close = true,

                    call = function() -- Line: 4230, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Clap Hands");
                    end
                },
                {
                    name = "Concerned",
                    close = true,

                    call = function() -- Line: 4231, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Concerned");
                    end
                },
                {
                    name = "Don\'t Know",
                    close = true,

                    call = function() -- Line: 4232, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Don\'t Know");
                    end
                }
            },
            {
                {
                    name = "Grrr",
                    close = true,

                    call = function() -- Line: 4235, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Grrr");
                    end
                },
                {
                    name = "Headphones",
                    close = true,

                    call = function() -- Line: 4236, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Headphones");
                    end
                },
                {
                    name = "Mock",
                    close = true,

                    call = function() -- Line: 4237, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Mock");
                    end
                },
                {
                    name = "No",
                    close = true,

                    call = function() -- Line: 4238, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("No");
                    end
                },
                {
                    name = "Salute",
                    close = true,

                    call = function() -- Line: 4239, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Salute");
                    end
                },
                {
                    name = "Welcome",
                    close = true,

                    call = function() -- Line: 4240, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Welcome");
                    end
                },
                {
                    name = "Yes",
                    close = true,

                    call = function() -- Line: 4241, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Yes");
                    end
                },
                {
                    name = "Dance",
                    close = true,

                    call = function() -- Line: 4242, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Dance");
                    end
                },
                {
                    name = "Dance2",
                    close = true,

                    call = function() -- Line: 4243, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Dance2");
                    end
                },
                {
                    name = "Dance3",
                    close = true,

                    call = function() -- Line: 4244, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Dance3");
                    end
                },
                {
                    name = "Dance4",
                    close = true,

                    call = function() -- Line: 4245, Name: call
                        -- upvalues: u1 (ref)
                        u1.playEmote("Dance4");
                    end
                }
            }
        },
        Team = v687,
        ["Roblox Emotes"] = #v682 > 0 and v682 or nil
    };

    local function updateFavoriteEmoteTable(p689) -- Line: 4252
        -- upvalues: u688 (ref), u10 (ref)
        if #p689 > 0 then
            u688.Favorite = {};

            for _, v in pairs(p689) do
                local v692 = (function(p690, p691) -- Line: 4256, Name: findEmoteTable
                    -- upvalues: u688 (ref), u10 (ref)
                    for i, v2 in pairs(u688) do
                        if i ~= "Favorite" and not ((not p691 or i ~= "Roblox Emotes") and (p691 or i == "Roblox Emotes")) then
                            for _, v3 in pairs(v2) do
                                if u10.typeOf(v3[1]) == "table" then
                                    for _, v4 in pairs(v3) do
                                        if v4.name == p690 then
                                            return v4;
                                        end;
                                    end;
                                elseif v3.name == p690 then
                                    return v3;
                                end;
                            end;
                        end;
                    end;
                end)(v[1], v[2]);

                if v692 then
                    table.insert(u688.Favorite, v692);
                end;
            end;

            if #u688.Favorite <= 0 then
                u688.Favorite = nil;
            end;
        else
            u688.Favorite = nil;
        end;
    end;

    updateFavoriteEmoteTable(u2.readPlayerData("FavoriteEmotes"));

    function u1.emoteBindUserInput(p693) -- Line: 4279
        -- upvalues: u688 (ref), UserInputService (ref), u1 (ref)
        if u688.Favorite and (u688.Favorite[p693] and (UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt))) then
            u1.playEmote(u688.Favorite[p693].name, u688.Favorite[p693].robloxEmote and true);

            return true;
        end;
    end;

    function u1.stopEmoteMenuUserInput() -- Line: 4286
        -- upvalues: u2 (ref), u1 (ref)
        if u2.openedGui == "EmoteMenu" then
            u1.emoteMenu();
        end;
    end;

    local u694 = nil;
    local u695 = nil;

    function u1.emoteMenu(p696) -- Line: 4292
        -- upvalues: u2 (ref), u10 (ref), CharScope (ref), u694 (ref), PlayerFunc (ref), updateFavoriteEmoteTable (copy), u1 (ref), EmoteMenu (copy), PlayerStuff (ref), GameRules (ref), u688 (ref), u695 (ref), u11 (ref), selectionWheelSystem (copy)
        if u2.openedGui and u2.openedGui ~= "EmoteMenu" then
            return;
        end;

        if not (p696 and u2.openedGui) then
            u10.lockScroll("emoteMenu", p696);
            u2.activateBlur("emoteMenu", p696);
        end;

        CharScope.setConnectionsAndThreads("EmoteMenu");

        if p696 then
            local u706 = {
                minRadius = 0.29,
                radius = 0.397,

                buttonHoldEvent = function(p697) -- Line: 4305, Name: buttonHoldEvent
                    -- upvalues: u694 (ref), PlayerFunc (ref), u10 (ref), updateFavoriteEmoteTable (ref), u2 (ref), u1 (ref)
                    if u694 == "Favorite" then
                        local v698 = PlayerFunc:InvokeServer("favoriteEmotes", p697.name, p697.robloxEmote and true or nil, false);

                        if u10.typeOf(v698) == "table" then
                            updateFavoriteEmoteTable(v698);
                            u2.notify({
                                color = "green",
                                message = "Removed " .. p697.name .. " emote from favorites"
                            });

                            if u2.openedGui == "EmoteMenu" then
                                u1.emoteMenu(true);
                            end;

                            if u694 == "Favorite" then
                            end;
                        elseif u10.typeOf(v698) == "string" then
                            u2.notify({
                                color = "red",
                                message = v698
                            });
                        end;
                    else
                        local v699 = PlayerFunc:InvokeServer("favoriteEmotes", p697.name, p697.robloxEmote and true or nil, true);

                        if u10.typeOf(v699) == "table" then
                            updateFavoriteEmoteTable(v699);
                            u2.notify({
                                color = "green",
                                message = "Added " .. p697.name .. " emote to favorites"
                            });

                            if u2.openedGui == "EmoteMenu" then
                                u1.emoteMenu(true);
                            end;
                        elseif u10.typeOf(v699) == "string" then
                            u2.notify({
                                color = "red",
                                message = v699
                            });
                        end;
                    end;
                end,

                createButton = function(u700) -- Line: 4332, Name: createButton
                    -- upvalues: u10 (ref), EmoteMenu (ref), CharScope (ref), PlayerStuff (ref), GameRules (ref)
                    local u701 = u10.clone(EmoteMenu.Slots.Preview);
                    u701.SharedEmote.Visible = u700.sharedEmote;
                    u701.TextLabel.Text = u700.id .. ". " .. u700.name;

                    if not u700.robloxEmote then
                        CharScope.taskDefer(function() -- Line: 4341
                            -- upvalues: u10 (ref), u701 (copy), PlayerStuff (ref), u700 (copy), GameRules (ref)
                            local v702 = u10.loadAnimation(u701.WorldModel.Man.Humanoid.Animator, PlayerStuff.Emotes:FindFirstChild(u700.name, true));
                            v702.animationTrack.Looped = true;
                            u10.playAnimation(v702, "play", GameRules.defaultCharacterAnimationFadeTime, 100, 0);
                            v702.animationTrack.TimePosition = v702.animationTrack.Length / 3;
                            u700.animationTrack = v702.animationTrack;
                        end);

                        return u701;
                    end;

                    u701.WorldModel:Destroy();
                    u701.RobloxEmote.Visible = true;
                    u701.RobloxEmote.Image = "rbxthumb://type=Asset&id=" .. u700.robloxEmote .. "&w=150&h=150";

                    return u701;
                end,

                close = function() -- Line: 4351, Name: close
                    -- upvalues: u1 (ref)
                    u1.emoteMenu();
                end,

                mouseEnter = function(p703) -- Line: 4354, Name: mouseEnter
                    -- upvalues: EmoteMenu (ref), u694 (ref)
                    if p703.animationTrack then
                        p703.animationTrack:AdjustSpeed(1);
                        p703.animationTrack.TimePosition = 0;
                    end;

                    local v704;

                    if u694 == "Favorite" then
                        v704 = p703.id < 11;
                    else
                        v704 = false;
                    end;

                    EmoteMenu.Shortcut.Visible = v704;

                    if u694 == "Favorite" and EmoteMenu.Shortcut.Visible then
                        EmoteMenu.MouseDeleteInfo.Visible = false;
                    end;

                    if EmoteMenu.Shortcut.Visible then
                        EmoteMenu.Shortcut.ButtonImage.ButtonText.Text = p703.id;
                    end;
                end,

                mouseLeave = function(p705) -- Line: 4364, Name: mouseLeave
                    -- upvalues: EmoteMenu (ref), u694 (ref)
                    EmoteMenu.Shortcut.Visible = false;

                    if u694 == "Favorite" then
                        EmoteMenu.MouseDeleteInfo.Visible = true;
                    end;

                    if p705 and p705.animationTrack then
                        p705.animationTrack:AdjustSpeed(0);
                        p705.animationTrack.TimePosition = p705.animationTrack.Length / 3;
                    end;
                end
            };

            for _, child in pairs(EmoteMenu.Buttons:GetChildren()) do
                if child:IsA("ImageButton") then
                    child.Visible = u688[child.Name];
                end;
            end;

            local function u708(p707) -- Line: 4376
                for _, child in pairs(p707.Parent:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.Highlight.Visible = child == p707;

                        if child:FindFirstChild("Icon") then
                            child.Icon.ImageColor3 = child == p707 and Color3.fromRGB(23, 24, 27) or Color3.fromRGB(255, 255, 255);
                        else
                            child.TextLabel.TextColor3 = child == p707 and Color3.fromRGB(23, 24, 27) or Color3.fromRGB(255, 255, 255);
                        end;
                    end;
                end;
            end;

            local u709 = 0;

            local function loadEmoteGroup(p710, p711, p712) -- Line: 4386
                -- upvalues: u694 (ref), u695 (ref), EmoteMenu (ref), u11 (ref), u10 (ref), u688 (ref), u709 (ref), selectionWheelSystem (ref), u706 (copy), u708 (copy)
                if u694 ~= p710 or (u695 ~= p711 or p712) then
                    local v713;

                    if p710 == "Team" then
                        v713 = u11 or p710;
                    else
                        v713 = p710;
                    end;

                    EmoteMenu.Group.Text = string.upper(v713);
                    EmoteMenu.MouseDeleteInfo.Visible = p710 == "Favorite";
                    EmoteMenu.MouseFavoriteInfo.Visible = p710 ~= "Favorite";
                    EmoteMenu.Shortcut.Visible = false;
                    u694 = p710;
                    local v714 = not p711 and u10.typeOf(u688[u694][1][1]) == "table" and "1" or p711;
                    u695 = v714;
                    local v715 = u695 and u688[u694][tonumber(u695)] or u688[u694];
                    u709 = selectionWheelSystem(EmoteMenu, u706, unpack(v715));
                    u708(EmoteMenu.Buttons[p710]);
                    EmoteMenu.Pages.Visible = v714 and true or false;

                    if u695 then
                        local v716 = #u688[u694];

                        for _, child in pairs(EmoteMenu.Pages:GetChildren()) do
                            if child:IsA("ImageButton") then
                                child.Visible = tonumber(child.Name) <= v716;
                            end;
                        end;

                        u708(EmoteMenu.Pages[u695]);
                    end;
                end;
            end;

            for _, child in pairs(EmoteMenu.Buttons:GetChildren()) do
                if child:IsA("ImageButton") then
                    CharScope.buildSignalData("EmoteMenu", u2.mouseButton(child, function() -- Line: 4409
                        -- upvalues: loadEmoteGroup (ref), child (copy)
                        loadEmoteGroup(child.Name);
                    end));
                end;
            end;

            for _, child in pairs(EmoteMenu.Pages:GetChildren()) do
                if child:IsA("ImageButton") then
                    CharScope.buildSignalData("EmoteMenu", u2.mouseButton(child, function() -- Line: 4416
                        -- upvalues: loadEmoteGroup (ref), u694 (ref), child (copy)
                        loadEmoteGroup(u694, child.Name);
                    end));
                end;
            end;

            if u694 and EmoteMenu.Buttons[u694].Visible then
                loadEmoteGroup(u694, u695, true);
            else
                loadEmoteGroup(EmoteMenu.Buttons.Favorite.Visible and "Favorite" or "General", nil, true);
            end;
        else
            selectionWheelSystem();
        end;

        if not (p696 and u2.openedGui) then
            u10.guiTransition(EmoteMenu, "Size", 0.9, p696);
        end;

        u2.openGui(p696 and "EmoteMenu");
    end;

    u1.playingEmote = nil;
    u1.isSharedEmote = false;
    u1.emoteFreezePlayer = false;
    local u717 = false;
    local u718 = {};

    local function activateEmoteCollision(p719) -- Line: 4438
        -- upvalues: u10 (ref), u13 (copy), CharScope (ref), u1 (ref), Humanoid (copy)
        local function u720() -- Line: 4439
            -- upvalues: u10 (ref), u13 (ref), CharScope (ref)
            u10.charCollisionGroup(u13, nil);

            if CharScope.getConnectionsAndThreads("Global").emoteDestroying then
                CharScope.getConnectionsAndThreads("Global").emoteDestroying[1]:Disconnect();
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteDestroying", nil);
            end;

            if CharScope.getConnectionsAndThreads("Global").emoteStopped then
                CharScope.getConnectionsAndThreads("Global").emoteStopped[1]:Disconnect();
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteStopped", nil);
            end;

            if CharScope.getConnectionsAndThreads("Global").emoteEnded then
                u10.taskCancel(CharScope.getConnectionsAndThreads("Global").emoteEnded[1]);
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteEnded", nil);
            end;

            if CharScope.getConnectionsAndThreads("Global").emoteRagdoll then
                CharScope.getConnectionsAndThreads("Global").emoteRagdoll[1]:Disconnect();
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteRagdoll", nil);
            end;
        end;

        u720();

        if p719 then
            u10.charCollisionGroup(u13, "NonCollide");
            u13.PrimaryPart.CollisionGroup = "Character";

            local function stopped() -- Line: 4463
                -- upvalues: stopped (ref), CharScope (ref), u720 (copy)
                stopped = nil;
                CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteEnded", CharScope.taskDelay(0.4, u720));
            end;

            local v721 = { u1.playingEmote.animationTrack.Destroying:Connect(function() -- Line: 4467
                    -- upvalues: stopped (ref)
                    if stopped then
                        stopped();
                    end;
                end), true };
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteDestroying", v721);
            local v722 = { u1.playingEmote.animationTrack.Stopped:Connect(function() -- Line: 4469
                    -- upvalues: stopped (ref)
                    if stopped then
                        stopped();
                    end;
                end), true };
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteStopped", v722);
            local v725 = { Humanoid.StateChanged:Connect(function(p723, p724) -- Line: 4471
                    -- upvalues: u720 (copy)
                    if p724 == Enum.HumanoidStateType.Ragdoll then
                        u720();
                    end;
                end), true };
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "emoteRagdoll", v725);
        end;
    end;

    function u1.lockEmotes(p726, p727) -- Line: 4477
        -- upvalues: u718 (copy), u1 (ref)
        u718[p726] = p727 and true or nil;

        if p727 and u1.playingEmote then
            u1.playEmote();
        end;
    end;

    function u1.playEmote(p728, u729, p730, p731) -- Line: 4481
        -- upvalues: Humanoid (copy), u1 (ref), u10 (ref), GameRules (ref), PlayerEvent (ref), u2 (ref), LocalPlayer (ref), PlayerStuff (ref), CharScope (ref), u718 (copy), u717 (ref), PlayerFunc (ref), u13 (copy), HumanoidRootPart (copy), updateCameraOffset (copy), Animator (copy), activateEmoteCollision (copy), Ragdoll (ref)
        if u729 and Humanoid.MoveDirection ~= Vector3.new() then
            return;
        end;

        if u1.playingEmote then
            if u1.playingEmote.animationTrack.IsPlaying then
                u10.playAnimation(u1.playingEmote, "stop", GameRules.defaultCharacterAnimationFadeTime);
            end;

            u1.playingEmote = nil;
        end;

        if u1.isSharedEmote then
            u1.setCharRotType("sharedEmote");
            PlayerEvent:FireServer("getRidOfPlayerSittingOnYou");

            if u10.isCharLoaded(u1.isSharedEmote) and u2.checkIfBothPositionsGoThroughWall(u1.isSharedEmote.Character.PrimaryPart.Position, LocalPlayer.Character.PrimaryPart.Position) then
                u10.charPivotTo(LocalPlayer.Character, u1.isSharedEmote.Character.PrimaryPart.CFrame);
            end;

            u1.isSharedEmote = nil;
        end;

        local v732 = u729 and p728;

        if not v732 then
            v732 = p728;

            if v732 then
                if Humanoid.Health > 0 then
                    v732 = PlayerStuff.Emotes:FindFirstChild(p728, true);
                else
                    v732 = false;
                end;
            end;
        end;

        local u733 = v732;
        CharScope.setConnectionsAndThreads("Emote");

        if u733 and (p730 or not u10.rest("PlayEmote", 1)) then
            if u10.isTableEmpty(u718) and not ((u729 or u733:FindFirstChild("FreezePlayer")) and u10.getInstanceAttribute(LocalPlayer, "Seat")) then
                local v734 = u729 or u733:FindFirstChild("FreezePlayer");

                if v734 and Humanoid:GetState() == Enum.HumanoidStateType.Swimming then
                    return;
                end;

                local function v735() -- Line: 4506
                    -- upvalues: u1 (ref), PlayerEvent (ref), u729 (copy), u733 (ref), u717 (ref), CharScope (ref), PlayerFunc (ref)
                    u1.displayBottomBarMessage("playEmote", 0, "Press JUMP to stop emote");
                    PlayerEvent:FireServer("playEmote");

                    if not u729 and u733:FindFirstChild("EmoteTool") then
                        u717 = true;
                        CharScope.taskSpawn(function() -- Line: 4511
                            -- upvalues: PlayerFunc (ref), u733 (ref)
                            PlayerFunc:InvokeServer("equipSpecialItem", u733.EmoteTool, true);
                        end);
                    end;
                end;

                if not u729 and u733:FindFirstChild("SharedEmote") then
                    if not p730 then
                        if not u10.invokeTraffic.shareEmote then
                            local function v738(p736) -- Line: 4527
                                -- upvalues: u10 (ref), u733 (ref), u1 (ref), u2 (ref)
                                local v737 = u10.invokeServerTraffic("shareEmote", u733, p736);

                                if u10.typeOf(v737) == "Instance" then
                                    u1.playEmote(u733.Name, false, v737);

                                    return;
                                end;

                                if u10.typeOf(v737) == "string" then
                                    u2.notify({
                                        color = "red",
                                        message = v737
                                    });
                                end;
                            end;

                            if p731 then
                                v738(p731);
                            else
                                local v739 = {};

                                for _, child in pairs(workspace.Characters:GetChildren()) do
                                    if child ~= u13 then
                                        table.insert(v739, child.PrimaryPart);
                                    end;
                                end;

                                local v740, _, v741 = u10.findClosestFromTable(HumanoidRootPart.Position, v739);

                                if v740 then
                                    v740 = u10.getPlayerFromCharacter(v740.Parent);
                                end;

                                if v740 and v741 < 5 then
                                    v738(v740);
                                else
                                    u2.notify({
                                        message = "You have to be near a player",
                                        color = "red"
                                    });
                                end;
                            end;
                        end;

                        return;
                    end;

                    v735();
                    u1.setCharRotType("sharedEmote", {
                        priority = 2,
                        client = 0,
                        server = 0
                    });
                    u1.isSharedEmote = p730;
                    local InstanceAttributeChangedSignal, v743 = u10.getInstanceAttributeChangedSignal(p730, "ReceivingEmoteFrom", function(p742) -- Line: 4519
                        -- upvalues: LocalPlayer (ref), u1 (ref)
                        if p742 ~= LocalPlayer then
                            u1.isSharedEmote = nil;
                            u1.setCharRotType("sharedEmote");
                            u1.playEmote();
                        end;
                    end);
                    CharScope.buildSignalData("Emote", unpack(InstanceAttributeChangedSignal));
                    CharScope.addThreadOrCleanUpFunction("Emote", v743);
                    CharScope.addThreadOrCleanUpFunction("Emote", u1.putInVehicleThirdPartyPrompt("SharedEmote", p730));
                end;

                v735();

                if not u729 and u733:FindFirstChild("CameraOffset") then
                    updateCameraOffset("emote", Vector3.new(0, u733.CameraOffset.Value * Humanoid.HipHeight, 0), true);
                end;

                if v734 then
                    u1.emoteFreezePlayer = true;
                    Humanoid.AutoRotate = false;
                    u1.lockHumanoidState("emote", -1, function() -- Line: 4550
                        -- upvalues: u1 (ref)
                        u1.playEmote();

                        return Enum.ContextActionResult.Sink;
                    end);
                    u1.setCharRotType("emote", {
                        priority = 1,
                        client = 0,
                        server = 0
                    });
                else
                    u2.overwriteJump("emote", u1.playEmote);
                end;

                if u729 then
                    CharScope.buildSignalData("Emote", { Animator.AnimationPlayed, function(p744) -- Line: 4567
                            -- upvalues: u1 (ref), CharScope (ref), Ragdoll (ref), Humanoid (ref), activateEmoteCollision (ref)
                            if not u1.playingEmote then
                                u1.playingEmote = {
                                    animationTrack = p744
                                };
                                CharScope.buildSignalData("Emote", { u1.playingEmote.animationTrack.Destroying, function() -- Line: 4570
                                        -- upvalues: u1 (ref)
                                        u1.playEmote();
                                    end });
                                CharScope.buildSignalData("Emote", { u1.playingEmote.animationTrack.Stopped, function() -- Line: 4573
                                        -- upvalues: u1 (ref), Ragdoll (ref), Humanoid (ref)
                                        u1.playEmote();

                                        if not Ragdoll.isActive then
                                            Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding);
                                        end;
                                    end });
                                activateEmoteCollision(true);
                            end;
                        end });
                    Humanoid:PlayEmoteAsync(u733);
                else
                    local loadAnimation = u10.loadAnimation;
                    local v745 = u1.isSharedEmote and u10.isCharLoaded(u1.isSharedEmote);
                    u1.playingEmote = loadAnimation(Animator, u733, v745);
                    u1.playingEmote.animationTrack.Priority = Enum.AnimationPriority.Action2;
                    u10.playAnimation(u1.playingEmote, "play", GameRules.defaultCharacterAnimationFadeTime);
                    CharScope.buildSignalData("Emote", { u1.playingEmote.animationTrack.Stopped, function() -- Line: 4558
                            -- upvalues: u1 (ref)
                            u1.playEmote();
                        end });

                    if u733:FindFirstChild("SharedEmote") then
                        activateEmoteCollision();
                    else
                        activateEmoteCollision(true);
                    end;
                end;

                if not u1.isSharedEmote then
                    u2.displayTip("favoriteEmotes", 15);
                end;
            end;
        else
            u1.displayBottomBarMessage("playEmote");

            if u1.emoteFreezePlayer then
                u1.emoteFreezePlayer = false;
                Humanoid.AutoRotate = true;
                updateCameraOffset("emote", Vector3.new(), true);
                u1.lockHumanoidState("emote");
                u1.setCharRotType("emote");
            end;

            if u717 then
                u717 = false;
                CharScope.taskSpawn(function() -- Line: 4597
                    -- upvalues: PlayerFunc (ref)
                    PlayerFunc:InvokeServer("equipSpecialItem", "EmoteTool", false);
                end);
            end;

            u2.overwriteJump("emote", false);
        end;
    end;

    u2.debugLoadingClient("Character 6");

    function u1.takePictureEffect() -- Line: 4606
        -- upvalues: CharScope (ref), TweenService (ref)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = game.Lighting;
        CharScope.addEntity(ColorCorrectionEffect);
        local v746 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
            Brightness = 0.6
        });
        v746:Play();
        v746.Completed:Wait();
        ColorCorrectionEffect:Destroy();
    end;

    function u1.objViolation(p747, p748) -- Line: 4616
        -- upvalues: u10 (ref), LocalPlayer (ref), PlayerEvent (ref), u1 (ref)
        local v749 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);

        if not (v749.Config:FindFirstChild("ELS") and (require(game.Teams[u10.getVehicleInfo.getVehicleTeam(v749)].Config).EMERGENCY and v749.Config.ELS.Value ~= 0)) then
            PlayerEvent:FireServer("violation", p748);
            game.SoundService.TakePicture:Play();
            u1.takePictureEffect();

            return true;
        end;
    end;

    local MapResolution = game.ReplicatedStorage.Gameplay.MapResolution;
    local u750 = {
        X = MapResolution.Position.X,
        Z = MapResolution.Position.Z,
        SizeX = MapResolution.Size.X * 1000,
        SizeY = MapResolution.Size.Y * 1000
    };

    local function realPositionToMap(p751) -- Line: 4630
        -- upvalues: u750 (copy)
        return (u750.SizeX / 2 + p751.Z - u750.Z) / u750.SizeX, (u750.SizeY / 2 - p751.X + u750.X) / u750.SizeY;
    end;

    local function mapPositionToReal(p752) -- Line: 4634
        -- upvalues: u750 (copy)
        return p752.X * u750.SizeX - u750.SizeX / 2 + u750.Z, u750.SizeY / 2 - p752.Y * u750.SizeY + u750.X;
    end;

    local Minimap = ScreenGui.Left.Bottom.Minimap;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 30;
    Camera.Parent = Minimap;
    Minimap.VisualMap3D.CurrentCamera = Camera;
    local X = Minimap.VisualMap3D.Map.Center.Size.X;
    local u753 = 150 / u750.SizeX * X;
    local Vector2_new_ret2 = Vector2.new(0, 0);
    local u754 = 0;

    local function realPositionToMinimap(p755) -- Line: 4651
        -- upvalues: realPositionToMap (ref), X (copy)
        local v756, v757 = realPositionToMap(p755);

        return (v756 - 0.5) * X, (v757 - 0.5) * X;
    end;

    CharScope.buildSignalData("Global", { RunService.Heartbeat, function(p758) -- Line: 4656
            -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), realPositionToMap (ref), workspace_CurrentCamera (ref), u754 (ref), u3 (ref), Vector2_new_ret2 (ref), realPositionToMinimap (ref), Camera (copy), Minimap (copy)
            local v759 = LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot() or HumanoidRootPart.CFrame;
            local _, _ = realPositionToMap(v759.Position);
            local _, v760, _ = v759:ToOrientation();
            local _, v761, _ = workspace_CurrentCamera.CFrame:ToOrientation();
            u754 = v761;
            local v762 = u3.seat and CFrame.new(0, 1.9, 3.05) * CFrame.Angles(-0.4363323129985824, 0, 0) or CFrame.new(0, 5, -0.3) * CFrame.Angles(-1.5707963267948966, 0, 0);
            Vector2_new_ret2 = Vector2.new(realPositionToMinimap(v759.Position));
            Camera.CFrame = CFrame.new(Vector2_new_ret2.X, 0, Vector2_new_ret2.Y) * CFrame.Angles(0, u754 + 1.5707963267948966, 0) * v762;

            if Minimap.Cursor.Position.Y.Scale ~= (u3.seat and 0.7 or 0.6) then
                Minimap.Cursor.Position = UDim2.fromScale(Minimap.Cursor.Position.X.Scale, u3.seat and 0.7 or 0.6);
            end;

            Minimap.Cursor.Rotation = math.deg(u754 - v760);
            Minimap.DirectionMarker.Position = UDim2.fromScale(math.cos(u754) * 0.5 + 0.5, math.sin(u754) * 0.5 + 0.5);
        end });

    local function updateMinimapIconVisibility(u763) -- Line: 4670
        -- upvalues: Vector2_new_ret2 (ref), Minimap (copy), CharScope (ref), Camera (copy), u754 (ref)
        if (Vector2.new(u763.Position.X, u763.Position.Z) - Vector2_new_ret2).Magnitude < 6.5 then
            if not u763:GetAttribute("Visible") and u763:FindFirstChild("Frame") then
                u763:SetAttribute("Visible", true);
                local Frame = u763.Frame;
                Frame.Parent = Minimap.Icons2D;
                local Attribute = u763:GetAttribute("Rotation");
                CharScope.taskSpawn(function() -- Line: 4677
                    -- upvalues: u763 (copy), Camera (ref), Frame (copy), Attribute (copy), u754 (ref)
                    while u763.Parent and u763:GetAttribute("Visible") do
                        local v764 = Camera:WorldToViewportPoint(u763.Position);

                        if (Vector2.new(v764.X, v764.Y) - Vector2.new(0.5, 0.5)).Magnitude < 0.5 then
                            if not Frame.Visible then
                                Frame.Visible = true;
                            end;

                            Frame.Position = UDim2.fromScale(v764.X, v764.Y);

                            if Attribute then
                                Frame.Rotation = math.deg(u754) - u763:GetAttribute("Rotation");
                            end;
                        elseif Frame.Visible then
                            Frame.Visible = false;
                        end;

                        task.wait();
                    end;

                    if u763.Parent then
                        Frame.Parent = u763;

                        return;
                    end;

                    Frame:Destroy();
                end);
            end;
        elseif u763:GetAttribute("Visible") then
            u763:SetAttribute("Visible", nil);
        end;
    end;

    CharScope.taskDefer(function() -- Line: 4698
        -- upvalues: Vector2_new_ret2 (ref), u753 (ref), Minimap (copy), updateMinimapIconVisibility (copy)
        local Vector2_new_ret3 = Vector2.new(-10000, -10000);

        while true do
            if u753 < (Vector2_new_ret2 - Vector2_new_ret3).magnitude then
                for _, child in pairs(Minimap.VisualMap3D.Locations:GetChildren()) do
                    updateMinimapIconVisibility(child);
                end;

                Vector2_new_ret3 = Vector2_new_ret2;
            end;

            task.wait(0.03);
        end;
    end);
    local MapLocations = game.ReplicatedStorage.Gameplay.MapLocations;
    local Map = MapGui.Center.Middle.Map;
    local u765 = 0;
    local u766 = false;
    local u767 = {};
    local u768 = nil;
    local u769 = nil;
    local u770 = nil;
    local u771 = nil;
    local u772 = nil;
    local u773 = nil;
    local u774 = false;
    local u775 = 0;

    local function highlightLocation(p776) -- Line: 4725
        -- upvalues: u767 (copy), u775 (ref), CharScope (ref), u10 (ref), MapLocations (copy), MapGui (copy), u769 (ref), u774 (ref)
        local function v782(p777, p778) -- Line: 4726
            -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
            if not u767[p777] then
                return;
            end;

            local u779 = u767[p777][1];
            local v780 = #u767[p777][2];
            local v781 = p778 and u767[p777][4][u775] or u767[p777][4][1].Parent;
            u779.TextLabel.Text = (v781:GetAttribute("DisplayName") or v781.Name) .. (v780 > 1 and (" (" .. (p778 and u775 .. "/" or "") .. v780 .. ")" or "") or "");
            CharScope.taskSpawn(function() -- Line: 4733
                -- upvalues: u779 (copy), u10 (ref)
                u779.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u779.TextLabel, true).X / u779.AbsoluteSize.X, 1);
            end);

            if MapLocations[p777]:GetAttribute("Blips") and MapLocations[p777]:GetAttribute("Blips") ~= "Civilian" then
                u779.Blip.ImageColor3 = p778 and Color3.fromRGB(22, 22, 22) or MapLocations[p777].Color3;
                u779.Blip.Arrow.ImageColor3 = p778 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                u779.Blip.Border.ImageColor3 = p778 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
            else
                u779.Icon.ImageColor3 = p778 and Color3.fromRGB(22, 22, 22) or MapLocations[p777].Color3;
            end;

            u779.Background.ImageTransparency = p778 and 0 or 0.5;
            u779.Background.ImageColor3 = p778 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
            u10.resetButtonColor(u779.Background, p778);
            u779.TextLabel.TextColor3 = p778 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

            if p778 then
                local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                u769.setScroll(-((u779.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
            end;
        end;

        if u774 then
            v782(u774, false);
        end;

        u774 = p776;

        if p776 then
            v782(p776, true);
        end;
    end;

    function u1.activateMap(p783, u784, u785) -- Line: 4759
        -- upvalues: u766 (ref), u765 (ref), CharScope (ref), Map (copy), u10 (ref), u9 (ref), u2 (ref), MapGui (copy), u768 (ref), u769 (ref), PlayerFunc (ref), u767 (copy), u775 (ref), MapLocations (copy), u774 (ref), realPositionToMap (ref), LocalPlayer (ref), HumanoidRootPart (copy), u771 (ref), u772 (ref), u773 (ref), UserInputService (ref), RunService (ref), mapPositionToReal (ref), u770 (ref), HttpService (ref), u1 (ref)
        if p783 == nil then
            p783 = not u766 or p783;
        end;

        u766 = p783;
        u765 = (u765 + 1) % 100;
        local u786 = u765;
        CharScope.setConnectionsAndThreads("Map");
        Map.Player.Visible = true;
        u10.lockScroll("map", u766);
        u9.disabled(u766, "map");
        u2.focusOnScreenGui(MapGui.Parent, u766);
        u2.activateBlur("map", u766);
        u768 = nil;
        u769 = nil;
        CharScope.taskSpawn(function() -- Line: 4772
            -- upvalues: PlayerFunc (ref), u766 (ref)
            PlayerFunc:InvokeServer("equipSpecialItem", "Map", u766);
        end);

        local function v792(p787, p788) -- Line: 4726
            -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
            if not u767[p787] then
                return;
            end;

            local u789 = u767[p787][1];
            local v790 = #u767[p787][2];
            local v791 = p788 and u767[p787][4][u775] or u767[p787][4][1].Parent;
            u789.TextLabel.Text = (v791:GetAttribute("DisplayName") or v791.Name) .. (v790 > 1 and (" (" .. (p788 and u775 .. "/" or "") .. v790 .. ")" or "") or "");
            CharScope.taskSpawn(function() -- Line: 4733
                -- upvalues: u789 (copy), u10 (ref)
                u789.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u789.TextLabel, true).X / u789.AbsoluteSize.X, 1);
            end);

            if MapLocations[p787]:GetAttribute("Blips") and MapLocations[p787]:GetAttribute("Blips") ~= "Civilian" then
                u789.Blip.ImageColor3 = p788 and Color3.fromRGB(22, 22, 22) or MapLocations[p787].Color3;
                u789.Blip.Arrow.ImageColor3 = p788 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                u789.Blip.Border.ImageColor3 = p788 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
            else
                u789.Icon.ImageColor3 = p788 and Color3.fromRGB(22, 22, 22) or MapLocations[p787].Color3;
            end;

            u789.Background.ImageTransparency = p788 and 0 or 0.5;
            u789.Background.ImageColor3 = p788 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
            u10.resetButtonColor(u789.Background, p788);
            u789.TextLabel.TextColor3 = p788 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

            if p788 then
                local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                u769.setScroll(-((u789.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
            end;
        end;

        if u774 then
            v792(u774, false);
        end;

        u774 = nil;

        if u766 then
            if u2.questFunctions.activateMap then
                u2.questFunctions.activateMap();
            end;

            u775 = 0;
            u769 = u10.scrollingListSystem(MapGui.Right.Top.Locations._ScrollingList.Scroll, 0.1, {
                upButton = MapGui.Right.Top.ListControl.Up,
                downButton = MapGui.Right.Top.ListControl.Down
            });
            CharScope.buildSignalData("Map", unpack(u769.multipleSignalData));
            CharScope.addThreadOrCleanUpFunction("Map", u769.cleanUp);
            Map.StreetNames.Visible = false;
            local Vector2_new_ret3 = Vector2.new();
            local Vector2_new_ret4 = Vector2.new();

            local function highlightOnStart(p793) -- Line: 4785
                -- upvalues: u767 (ref), u784 (copy), u10 (ref), realPositionToMap (ref), u775 (ref), CharScope (ref), MapLocations (ref), MapGui (ref), u769 (ref), u774 (ref)
                if p793 then
                    local v794 = {};
                    local v795 = {};

                    for i, v in pairs(u767) do
                        local v796 = i;
                        local v797 = v;

                        for i2, v2 in pairs(v[4]) do
                            if v2.Name == u784[1] then
                                table.insert(v794, Vector2.new(v797[2][i2].Position.X.Scale, v797[2][i2].Position.Y.Scale));
                                table.insert(v795, { v796, i2 });
                            end;
                        end;
                    end;

                    if #v794 > 0 then
                        local v798, v799 = u10.findClosestFromTable(Vector2.new(realPositionToMap(u784[2])), v794);
                        u775 = v795[v799][2];
                        local v800 = v795[v799][1];

                        local function v806(p801, p802) -- Line: 4726
                            -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                            if not u767[p801] then
                                return;
                            end;

                            local u803 = u767[p801][1];
                            local v804 = #u767[p801][2];
                            local v805 = p802 and u767[p801][4][u775] or u767[p801][4][1].Parent;
                            u803.TextLabel.Text = (v805:GetAttribute("DisplayName") or v805.Name) .. (v804 > 1 and (" (" .. (p802 and u775 .. "/" or "") .. v804 .. ")" or "") or "");
                            CharScope.taskSpawn(function() -- Line: 4733
                                -- upvalues: u803 (copy), u10 (ref)
                                u803.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u803.TextLabel, true).X / u803.AbsoluteSize.X, 1);
                            end);

                            if MapLocations[p801]:GetAttribute("Blips") and MapLocations[p801]:GetAttribute("Blips") ~= "Civilian" then
                                u803.Blip.ImageColor3 = p802 and Color3.fromRGB(22, 22, 22) or MapLocations[p801].Color3;
                                u803.Blip.Arrow.ImageColor3 = p802 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                u803.Blip.Border.ImageColor3 = p802 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                            else
                                u803.Icon.ImageColor3 = p802 and Color3.fromRGB(22, 22, 22) or MapLocations[p801].Color3;
                            end;

                            u803.Background.ImageTransparency = p802 and 0 or 0.5;
                            u803.Background.ImageColor3 = p802 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                            u10.resetButtonColor(u803.Background, p802);
                            u803.TextLabel.TextColor3 = p802 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                            if p802 then
                                local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                                u769.setScroll(-((u803.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                            end;
                        end;

                        if u774 then
                            v806(u774, false);
                        end;

                        u774 = v800;

                        if v800 then
                            v806(v800, true);
                        end;

                        return v798;
                    end;
                else
                    for i, v in pairs(u767) do
                        local v807 = v;
                        local v808 = i;

                        for i2, v2 in pairs(v[4]) do
                            if v2.Name == u784 then
                                u775 = i2;

                                local function v814(p809, p810) -- Line: 4726
                                    -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                                    if not u767[p809] then
                                        return;
                                    end;

                                    local u811 = u767[p809][1];
                                    local v812 = #u767[p809][2];
                                    local v813 = p810 and u767[p809][4][u775] or u767[p809][4][1].Parent;
                                    u811.TextLabel.Text = (v813:GetAttribute("DisplayName") or v813.Name) .. (v812 > 1 and (" (" .. (p810 and u775 .. "/" or "") .. v812 .. ")" or "") or "");
                                    CharScope.taskSpawn(function() -- Line: 4733
                                        -- upvalues: u811 (copy), u10 (ref)
                                        u811.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u811.TextLabel, true).X / u811.AbsoluteSize.X, 1);
                                    end);

                                    if MapLocations[p809]:GetAttribute("Blips") and MapLocations[p809]:GetAttribute("Blips") ~= "Civilian" then
                                        u811.Blip.ImageColor3 = p810 and Color3.fromRGB(22, 22, 22) or MapLocations[p809].Color3;
                                        u811.Blip.Arrow.ImageColor3 = p810 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                        u811.Blip.Border.ImageColor3 = p810 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                    else
                                        u811.Icon.ImageColor3 = p810 and Color3.fromRGB(22, 22, 22) or MapLocations[p809].Color3;
                                    end;

                                    u811.Background.ImageTransparency = p810 and 0 or 0.5;
                                    u811.Background.ImageColor3 = p810 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                                    u10.resetButtonColor(u811.Background, p810);
                                    u811.TextLabel.TextColor3 = p810 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                                    if p810 then
                                        local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                                        u769.setScroll(-((u811.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                                    end;
                                end;

                                if u774 then
                                    v814(u774, false);
                                end;

                                u774 = v808;

                                if v808 then
                                    v814(v808, true);
                                end;

                                return Vector2.new(v807[2][i2].Position.X.Scale, v807[2][i2].Position.Y.Scale);
                            end;
                        end;
                    end;
                end;

                return Vector2.new(0.5, 0.5);
            end;

            local u815 = u784 and (u10.typeOf(u784) == "Vector3" and Vector2.new(realPositionToMap(u784)) or u10.typeOf(u784) == "string" and highlightOnStart() or (u10.typeOf(u784) == "table" and highlightOnStart(true) or u784)) or Vector2.new(realPositionToMap(LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot().Position or HumanoidRootPart.Position));
            local u816 = 30;
            local Vector2_new_ret5 = Vector2.new(12, 140);
            Map.Size = UDim2.fromScale(u816, u816);
            Map.AnchorPoint = u815;
            local u817 = u815;
            local u818 = false;

            for _, v in pairs(u2.activeNavigations) do
                u771(v, v.canvas, u772, u773);
            end;

            local u819 = false;

            local function begin(p820, p821) -- Line: 4825
                -- upvalues: u2 (ref), Vector2_new_ret3 (ref), Vector2_new_ret4 (ref), Map (ref), u819 (ref)
                if u2.isMouseButton1Pressed() and (not p821 or u2.platform == "Mobile") then
                    Vector2_new_ret3 = p820.Position;
                    Vector2_new_ret4 = Map.AnchorPoint;
                    u819 = true;
                end;
            end;

            local function zoom(p822) -- Line: 4832
                -- upvalues: u816 (ref), Vector2_new_ret5 (copy), Map (ref)
                u816 = math.clamp(u816 + p822 * (0.7 + u816 / Vector2_new_ret5.Y * 12), Vector2_new_ret5.X, Vector2_new_ret5.Y);
                Map:TweenSize(UDim2.fromScale(u816, u816), "Out", "Quint", 0.5, true);
                local v823 = u816 > 50;

                if Map.StreetNames.Visible ~= v823 then
                    Map.StreetNames.Visible = v823;
                end;
            end;

            local u825 = u10.touchPinch(function(p824) -- Line: 4838
                -- upvalues: zoom (copy), u2 (ref), Vector2_new_ret3 (ref), Vector2_new_ret4 (ref), Map (ref), u819 (ref)
                zoom(p824);
                local mobileTouch = u2.getMouseProperty.mobileTouch;

                if u2.isMouseButton1Pressed() then
                    Vector2_new_ret3 = mobileTouch.Position;
                    Vector2_new_ret4 = Map.AnchorPoint;
                    u819 = true;
                end;
            end);
            CharScope.buildSignalData("Map", u825.signalData);
            CharScope.buildSignalData("Map", { UserInputService.InputChanged, function(p826) -- Line: 4843
                    -- upvalues: u819 (ref), u825 (copy), u10 (ref), u2 (ref), u817 (ref), Vector2_new_ret4 (ref), Vector2_new_ret3 (ref), Map (ref), u774 (ref), u767 (ref), u775 (ref), CharScope (ref), MapLocations (ref), MapGui (ref), u769 (ref), u818 (ref), zoom (copy)
                    if (p826.UserInputType == Enum.UserInputType.MouseMovement or p826.UserInputType == Enum.UserInputType.Touch) and (u819 and not (u825.active or u10.isTouchingScrollingListMobile)) then
                        if u2.getMouseProperty.checkIfInputIsntTheLatestMobileTouch(p826) then
                            return;
                        end;

                        u817 = Vector2.new(math.clamp(Vector2_new_ret4.X - (p826.Position.X - Vector2_new_ret3.X) / Map.AbsoluteSize.X, 0, 1), (math.clamp(Vector2_new_ret4.Y - (p826.Position.Y - Vector2_new_ret3.Y) / Map.AbsoluteSize.Y, 0, 1)));

                        if u774 and (p826.Position - Vector2_new_ret3).magnitude > 2 then
                            local function v832(p827, p828) -- Line: 4726
                                -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                                if not u767[p827] then
                                    return;
                                end;

                                local u829 = u767[p827][1];
                                local v830 = #u767[p827][2];
                                local v831 = p828 and u767[p827][4][u775] or u767[p827][4][1].Parent;
                                u829.TextLabel.Text = (v831:GetAttribute("DisplayName") or v831.Name) .. (v830 > 1 and (" (" .. (p828 and u775 .. "/" or "") .. v830 .. ")" or "") or "");
                                CharScope.taskSpawn(function() -- Line: 4733
                                    -- upvalues: u829 (copy), u10 (ref)
                                    u829.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u829.TextLabel, true).X / u829.AbsoluteSize.X, 1);
                                end);

                                if MapLocations[p827]:GetAttribute("Blips") and MapLocations[p827]:GetAttribute("Blips") ~= "Civilian" then
                                    u829.Blip.ImageColor3 = p828 and Color3.fromRGB(22, 22, 22) or MapLocations[p827].Color3;
                                    u829.Blip.Arrow.ImageColor3 = p828 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                    u829.Blip.Border.ImageColor3 = p828 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                else
                                    u829.Icon.ImageColor3 = p828 and Color3.fromRGB(22, 22, 22) or MapLocations[p827].Color3;
                                end;

                                u829.Background.ImageTransparency = p828 and 0 or 0.5;
                                u829.Background.ImageColor3 = p828 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                                u10.resetButtonColor(u829.Background, p828);
                                u829.TextLabel.TextColor3 = p828 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                                if p828 then
                                    local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                                    u769.setScroll(-((u829.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                                end;
                            end;

                            if u774 then
                                v832(u774, false);
                            end;

                            u774 = nil;
                        end;
                    elseif p826.UserInputType == Enum.UserInputType.MouseWheel and not u818 then
                        zoom(p826.Position.Z);

                        if u2.isMouseButton1Pressed() then
                            Vector2_new_ret3 = p826.Position;
                            Vector2_new_ret4 = Map.AnchorPoint;
                            u819 = true;
                        end;
                    end;
                end });
            CharScope.buildSignalData("Map", { UserInputService.InputBegan, function(p833, p834) -- Line: 4856
                    -- upvalues: u2 (ref), Vector2_new_ret3 (ref), Vector2_new_ret4 (ref), Map (ref), u819 (ref)
                    if (p833.UserInputType == Enum.UserInputType.MouseButton1 or p833.UserInputType == Enum.UserInputType.Touch) and (u2.isMouseButton1Pressed() and (not p834 or u2.platform == "Mobile")) then
                        Vector2_new_ret3 = p833.Position;
                        Vector2_new_ret4 = Map.AnchorPoint;
                        u819 = true;
                    end;
                end });
            CharScope.buildSignalData("Map", { UserInputService.InputEnded, function(p835) -- Line: 4861
                    -- upvalues: u819 (ref), u2 (ref)
                    if (p835.UserInputType == Enum.UserInputType.MouseButton1 or p835.UserInputType == Enum.UserInputType.Touch) and u819 then
                        if u2.getMouseProperty.checkIfInputIsntTheLatestMobileTouch(p835) then
                            return;
                        end;

                        u819 = false;
                    end;
                end });
            CharScope.addThreadOrCleanUpFunction("Map", function() -- Line: 4867
                if game.SoundService.MapScroll.IsPlaying then
                    game.SoundService.MapScroll:Stop();
                end;
            end);
            CharScope.buildSignalData("Map", { RunService.Heartbeat, function(p836) -- Line: 4870
                    -- upvalues: u817 (ref), Map (ref), u10 (ref), realPositionToMap (ref), LocalPlayer (ref), HumanoidRootPart (ref)
                    if math.abs(u817.X - Map.AnchorPoint.X) + math.abs(u817.Y - Map.AnchorPoint.Y) > 0.01 then
                        if not game.SoundService.MapScroll.IsPlaying then
                            game.SoundService.MapScroll:Play();
                        end;

                        game.SoundService.MapScroll.PlaybackSpeed = (math.abs(u817.X - Map.AnchorPoint.X) + math.abs(u817.Y - Map.AnchorPoint.Y)) * 20 + 2;
                    elseif game.SoundService.MapScroll.IsPlaying then
                        game.SoundService.MapScroll:Stop();
                    end;

                    Map.AnchorPoint = Vector2.new(u10.lerp(Map.AnchorPoint.X, u817.X, 1 - 1e-9 ^ p836), u10.lerp(Map.AnchorPoint.Y, u817.Y, 1 - 1e-9 ^ p836));
                    Map.Player.Position = UDim2.fromScale(realPositionToMap(LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot().Position or HumanoidRootPart.Position));
                    Map.Player.Rotation = 270 - HumanoidRootPart.Orientation.Y;
                end });
            CharScope.buildSignalData("Map", u2.mouseButton(MapGui.Right.Bottom.Bar.FindYourself, function() -- Line: 4880
                -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref), u774 (ref), u817 (ref), Map (ref)
                local function v842(p837, p838) -- Line: 4726
                    -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                    if not u767[p837] then
                        return;
                    end;

                    local u839 = u767[p837][1];
                    local v840 = #u767[p837][2];
                    local v841 = p838 and u767[p837][4][u775] or u767[p837][4][1].Parent;
                    u839.TextLabel.Text = (v841:GetAttribute("DisplayName") or v841.Name) .. (v840 > 1 and (" (" .. (p838 and u775 .. "/" or "") .. v840 .. ")" or "") or "");
                    CharScope.taskSpawn(function() -- Line: 4733
                        -- upvalues: u839 (copy), u10 (ref)
                        u839.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u839.TextLabel, true).X / u839.AbsoluteSize.X, 1);
                    end);

                    if MapLocations[p837]:GetAttribute("Blips") and MapLocations[p837]:GetAttribute("Blips") ~= "Civilian" then
                        u839.Blip.ImageColor3 = p838 and Color3.fromRGB(22, 22, 22) or MapLocations[p837].Color3;
                        u839.Blip.Arrow.ImageColor3 = p838 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                        u839.Blip.Border.ImageColor3 = p838 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                    else
                        u839.Icon.ImageColor3 = p838 and Color3.fromRGB(22, 22, 22) or MapLocations[p837].Color3;
                    end;

                    u839.Background.ImageTransparency = p838 and 0 or 0.5;
                    u839.Background.ImageColor3 = p838 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                    u10.resetButtonColor(u839.Background, p838);
                    u839.TextLabel.TextColor3 = p838 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                    if p838 then
                        local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                        u769.setScroll(-((u839.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                    end;
                end;

                if u774 then
                    v842(u774, false);
                end;

                u774 = nil;
                u817 = Vector2.new(Map.Player.Position.X.Scale, Map.Player.Position.Y.Scale);
            end));
            CharScope.buildSignalData("Map", u2.mouseButton(MapGui.Right.Bottom.Bar.Navigation, function() -- Line: 4884
                -- upvalues: u2 (ref), u767 (ref), u817 (ref), u774 (ref), u775 (ref), mapPositionToReal (ref), Map (ref), PlayerFunc (ref), u770 (ref), CharScope (ref), u815 (copy), u785 (copy), HttpService (ref), u10 (ref)
                if u2.createWaypoint then
                    if not u767.Navigation or (Vector2.new(u767.Navigation[2][1].Position.X.Scale, u767.Navigation[2][1].Position.Y.Scale) - u817).Magnitude > 0.005 then
                        local function getNavigationPoint() -- Line: 4887
                            -- upvalues: u774 (ref), u767 (ref), u775 (ref), mapPositionToReal (ref), Map (ref), PlayerFunc (ref)
                            if not (u774 and u767[u774]) then
                                local v843, v844 = mapPositionToReal(Map.AnchorPoint);

                                return PlayerFunc:InvokeServer("getNavigationPoint", v843, v844);
                            end;

                            local v845 = u767[u774][4][u775];

                            if not v845:IsA("ObjectValue") then
                                return v845.Position, true;
                            end;

                            if not v845.Value then
                                return Vector3.new(), true;
                            end;

                            if v845.Value:IsA("Player") then
                                return v845.Value:GetAttribute("CharacterPosition") or Vector3.new(), true;
                            end;

                            return v845.Value.Position, true;
                        end;

                        u770 = CharScope.taskSpawn(function() -- Line: 4906
                            -- upvalues: u774 (ref), u767 (ref), u775 (ref), u815 (ref), u817 (ref), mapPositionToReal (ref), Map (ref), u785 (ref), HttpService (ref), u2 (ref), getNavigationPoint (copy)
                            local v846 = u774 and u767[u774] and u767[u774][4][u775];
                            local v847 = (u815 - u817).Magnitude < 0.005;
                            local v848, v849 = mapPositionToReal(Map.AnchorPoint);
                            local v850 = v847 and (u785 and u785.showRadius);

                            if not v850 then
                                if v846 then
                                    v850 = v846:GetAttribute("whenNavigatedShowRadius");
                                else
                                    v850 = v846;
                                end;
                            end;

                            local v851 = u785 and u785.showMessageWhenCloseForSomeTime or v846 and v846:GetAttribute("whenNavigatedShowMessageWhenCloseForSomeTime") and HttpService:JSONDecode(v846:GetAttribute("whenNavigatedShowMessageWhenCloseForSomeTime"));
                            u2.createWaypoint({
                                hideOnScreen = true,
                                name = "Navigation",
                                image = "rbxassetid://14091097075",
                                create = true,
                                location = Vector3.new(v849, 0, v848),
                                color = Color3.fromRGB(87, 196, 255),
                                hasRadius = v850,
                                showMessageWhenCloseForSomeTime = v851
                            });
                            u2.navigationPoint = getNavigationPoint();
                            u2.createWaypoint({
                                name = "Navigation",
                                image = "rbxassetid://14091097075",
                                create = true,
                                navigation = true,
                                destroyWhenClose = 30,
                                location = u2.navigationPoint,
                                color = Color3.fromRGB(87, 196, 255),
                                hasRadius = v850,
                                showMessageWhenCloseForSomeTime = v851
                            });
                        end);

                        return;
                    end;

                    if u770 then
                        u10.taskCancel(u770);
                        u770 = nil;
                    end;

                    u2.navigationPoint = nil;
                    u2.createWaypoint({
                        name = "Navigation"
                    });
                end;
            end));
            CharScope.buildSignalData("Map", u2.mouseButton(MapGui.Right.Bottom.Bar.Exit, function() -- Line: 4926
                -- upvalues: u1 (ref)
                u1.activateMap(false);
            end));
            CharScope.buildSignalData("Map", u10.buttonHoverSignalData(MapGui.Right.Bottom.Bar.FindYourself));
            CharScope.buildSignalData("Map", u10.buttonHoverSignalData(MapGui.Right.Bottom.Bar.Navigation));
            CharScope.buildSignalData("Map", u10.buttonHoverSignalData(MapGui.Right.Bottom.Bar.Exit));

            u768 = function(u852, u853) -- Line: 4934, Name: connectMapLocation
                -- upvalues: u10 (ref), u817 (ref), u775 (ref), u767 (ref), CharScope (ref), MapLocations (ref), MapGui (ref), u769 (ref), u774 (ref), u2 (ref)
                u10.clearConnectionsAndThreads(u853[5]);
                local v854 = {};

                local function u862() -- Line: 4937
                    -- upvalues: u817 (ref), u853 (copy), u775 (ref), u852 (copy), u767 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref), u774 (ref)
                    u817 = Vector2.new(u853[2][u775].Position.X.Scale, u853[2][u775].Position.Y.Scale);
                    local v855 = u852;

                    local function v861(p856, p857) -- Line: 4726
                        -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                        if not u767[p856] then
                            return;
                        end;

                        local u858 = u767[p856][1];
                        local v859 = #u767[p856][2];
                        local v860 = p857 and u767[p856][4][u775] or u767[p856][4][1].Parent;
                        u858.TextLabel.Text = (v860:GetAttribute("DisplayName") or v860.Name) .. (v859 > 1 and (" (" .. (p857 and u775 .. "/" or "") .. v859 .. ")" or "") or "");
                        CharScope.taskSpawn(function() -- Line: 4733
                            -- upvalues: u858 (copy), u10 (ref)
                            u858.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u858.TextLabel, true).X / u858.AbsoluteSize.X, 1);
                        end);

                        if MapLocations[p856]:GetAttribute("Blips") and MapLocations[p856]:GetAttribute("Blips") ~= "Civilian" then
                            u858.Blip.ImageColor3 = p857 and Color3.fromRGB(22, 22, 22) or MapLocations[p856].Color3;
                            u858.Blip.Arrow.ImageColor3 = p857 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                            u858.Blip.Border.ImageColor3 = p857 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                        else
                            u858.Icon.ImageColor3 = p857 and Color3.fromRGB(22, 22, 22) or MapLocations[p856].Color3;
                        end;

                        u858.Background.ImageTransparency = p857 and 0 or 0.5;
                        u858.Background.ImageColor3 = p857 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                        u10.resetButtonColor(u858.Background, p857);
                        u858.TextLabel.TextColor3 = p857 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                        if p857 then
                            local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                            u769.setScroll(-((u858.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                        end;
                    end;

                    if u774 then
                        v861(u774, false);
                    end;

                    u774 = v855;

                    if v855 then
                        v861(v855, true);
                    end;
                end;

                table.insert(v854, u10.buttonHoverSignalData(u853[1].Background, {
                    intensity = 6
                }));
                table.insert(v854, u2.mouseButton(u853[1].Background, function() -- Line: 4942
                    -- upvalues: u775 (ref), u774 (ref), u852 (copy), u853 (copy), u817 (ref), u767 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                    u775 = u774 == u852 and u775 % #u853[2] + 1 or 1;
                    u817 = Vector2.new(u853[2][u775].Position.X.Scale, u853[2][u775].Position.Y.Scale);
                    local v863 = u852;

                    local function v869(p864, p865) -- Line: 4726
                        -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                        if not u767[p864] then
                            return;
                        end;

                        local u866 = u767[p864][1];
                        local v867 = #u767[p864][2];
                        local v868 = p865 and u767[p864][4][u775] or u767[p864][4][1].Parent;
                        u866.TextLabel.Text = (v868:GetAttribute("DisplayName") or v868.Name) .. (v867 > 1 and (" (" .. (p865 and u775 .. "/" or "") .. v867 .. ")" or "") or "");
                        CharScope.taskSpawn(function() -- Line: 4733
                            -- upvalues: u866 (copy), u10 (ref)
                            u866.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u866.TextLabel, true).X / u866.AbsoluteSize.X, 1);
                        end);

                        if MapLocations[p864]:GetAttribute("Blips") and MapLocations[p864]:GetAttribute("Blips") ~= "Civilian" then
                            u866.Blip.ImageColor3 = p865 and Color3.fromRGB(22, 22, 22) or MapLocations[p864].Color3;
                            u866.Blip.Arrow.ImageColor3 = p865 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                            u866.Blip.Border.ImageColor3 = p865 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                        else
                            u866.Icon.ImageColor3 = p865 and Color3.fromRGB(22, 22, 22) or MapLocations[p864].Color3;
                        end;

                        u866.Background.ImageTransparency = p865 and 0 or 0.5;
                        u866.Background.ImageColor3 = p865 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                        u10.resetButtonColor(u866.Background, p865);
                        u866.TextLabel.TextColor3 = p865 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                        if p865 then
                            local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                            u769.setScroll(-((u866.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                        end;
                    end;

                    if u774 then
                        v869(u774, false);
                    end;

                    u774 = v863;

                    if v863 then
                        v869(v863, true);
                    end;
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));

                for _, v in pairs(u853[2]) do
                    table.insert(v854, u10.buttonHoverSignalData(v.Button));
                    table.insert(v854, u2.mouseButton(v.Button, function() -- Line: 4948
                        -- upvalues: u853 (copy), v (copy), u775 (ref), u862 (copy)
                        for i, v2 in pairs(u853[2]) do
                            if v2 == v then
                                u775 = i;

                                return u862();
                            end;
                        end;
                    end, {
                        mobileButtonType = "MouseButton1Click"
                    }));
                end;

                u853[5] = CharScope.buildSignalData("Map", unpack(v854));
            end;

            for i, v in pairs(u767) do
                u768(i, v);
            end;

            CharScope.buildSignalData("Map", { MapGui.Right.Top.Locations._ScrollingList.MouseEnter, function() -- Line: 4962
                    -- upvalues: u818 (ref), u10 (ref), MapGui (ref)
                    u818 = true;

                    while u10.isInFrame(MapGui.Right.Top.Locations._ScrollingList) do
                        task.wait(0.03);
                    end;

                    u818 = false;
                end });
            CharScope.taskDefer(function() -- Line: 4968
                -- upvalues: Map (ref), u765 (ref), u786 (copy)
                while true do
                    Map.Player.Visible = true;
                    task.wait(1);

                    if u765 ~= u786 then
                        break;
                    end;

                    Map.Player.Visible = false;
                    task.wait(0.5);

                    if u765 ~= u786 then
                        return;
                    end;
                end;
            end);

            if u785 then
                if u785.attachToClosestPoint then
                    local u870 = u10.clone(Map.LocationIconPreview);
                    u870.Name = "ClosestPoint";
                    u870.Visible = true;
                    u870.Button.Icon.Image = u785.closestPointIcon;
                    u870.Button.ImageColor3 = u785.closestPointColor;
                    u870.Parent = Map.LocationIcons;
                    local u871 = nil;

                    local function selectLocation() -- Line: 4986
                        -- upvalues: mapPositionToReal (ref), u817 (ref), u871 (ref), u10 (ref), u785 (copy), u870 (copy), realPositionToMap (ref)
                        local v872, v873 = mapPositionToReal(u817);
                        u871 = u10.findClosestFromTable(Vector3.new(v873, 0, v872), u785.attachToClosestPoint);
                        u870.Position = UDim2.fromScale(realPositionToMap(u871.Position));
                    end;

                    local v874, v875 = mapPositionToReal(u817);
                    u871 = u10.findClosestFromTable(Vector3.new(v875, 0, v874), u785.attachToClosestPoint);
                    u870.Position = UDim2.fromScale(realPositionToMap(u871.Position));
                    CharScope.taskSpawn(function() -- Line: 4992
                        -- upvalues: u765 (ref), u786 (copy), mapPositionToReal (ref), u817 (ref), u871 (ref), u10 (ref), u785 (copy), u870 (copy), realPositionToMap (ref)
                        while u765 == u786 do
                            local v876, v877 = mapPositionToReal(u817);
                            u871 = u10.findClosestFromTable(Vector3.new(v877, 0, v876), u785.attachToClosestPoint);
                            u870.Position = UDim2.fromScale(realPositionToMap(u871.Position));
                            task.wait(0.1);
                        end;

                        u870:Destroy();
                        u785.selectedLocation(u871);
                    end);
                end;

                if u785.onClose then
                    CharScope.addThreadOrCleanUpFunction("Map", u785.onClose);
                end;
            end;
        end;

        u10.guiTransition(MapGui, "Size", 0.9, u766);
    end;

    u773 = function(p878, p879) -- Line: 5013, Name: drawMapCircle
        -- upvalues: u10 (ref), Map (copy), realPositionToMap (ref)
        local v880 = u10.clone(Map.Navigation.CirclePreview);
        v880.Name = "Circle";
        v880.Visible = true;
        v880.Position = UDim2.fromScale(realPositionToMap(p879));
        v880.ZIndex = Map.Navigation.ZIndex + p878.navigationZIndex;
        v880.ImageColor3 = p878.color;

        return v880;
    end;

    u772 = function(p881, p882, p883) -- Line: 5022, Name: drawMapLine
        -- upvalues: realPositionToMap (ref), u10 (ref), Map (copy)
        local UDim2_fromScale_ret = UDim2.fromScale(realPositionToMap(p882));
        local UDim2_fromScale_ret2 = UDim2.fromScale(realPositionToMap(p883));
        local v884 = p883 - p882;
        local v885 = u10.clone(Map.Navigation.LinePreview);
        v885.Name = "Line";
        v885.Visible = true;
        v885.Size = UDim2.fromScale(v885.Size.X.Scale, (Vector2.new(UDim2_fromScale_ret.X.Scale, UDim2_fromScale_ret.Y.Scale) - Vector2.new(UDim2_fromScale_ret2.X.Scale, UDim2_fromScale_ret2.Y.Scale)).Magnitude);
        v885.Position = UDim2_fromScale_ret:Lerp(UDim2_fromScale_ret2, 0.5);
        local math_atan2_ret = math.atan2(v884.Z, v884.X);
        v885.Rotation = math.deg(math_atan2_ret);
        v885.ZIndex = Map.Navigation.ZIndex + p881.navigationZIndex;
        v885.BackgroundColor3 = p881.color;

        return v885;
    end;

    local function drawMinimapCircle(p886, p887) -- Line: 5036
        -- upvalues: u10 (ref), Minimap (copy), realPositionToMinimap (ref)
        local v888 = u10.clone(Minimap.VisualMap3D.Navigation.CirclePreview);
        v888.Name = "Circle";
        v888.Transparency = 0;
        local v889, v890 = realPositionToMinimap(p887);
        v888.Position = Vector3.new(v889, 0.01 + p886.navigationZIndex * 0.0001, v890);
        v888.Color = p886.color;

        return v888;
    end;

    local function drawMinimapLine(p891, p892, p893) -- Line: 5045
        -- upvalues: realPositionToMinimap (ref), u10 (ref), Minimap (copy)
        local Vector2_new_ret3 = Vector2.new(realPositionToMinimap(p892));
        local Vector2_new_ret4 = Vector2.new(realPositionToMinimap(p893));
        local v894 = p893 - p892;
        local v895 = u10.clone(Minimap.VisualMap3D.Navigation.LinePreview);
        v895.Name = "Line";
        v895.Transparency = 0;
        v895.Size = Vector3.new(v895.Size.X, v895.Size.Y, (Vector2_new_ret3 - Vector2_new_ret4).Magnitude);
        local v896 = Vector2_new_ret3:Lerp(Vector2_new_ret4, 0.5);
        v895.CFrame = CFrame.new(v896.X, 0.01 + p891.navigationZIndex * 0.0001, v896.Y) * CFrame.Angles(0, -math.atan2(v894.Z, v894.X), 0);
        v895.Color = p891.color;

        return v895;
    end;

    u771 = function(p897, p898, p899, p900) -- Line: 5059, Name: drawNavigation
        p898:ClearAllChildren();
        local pathPoints = p897.navigator.pathPoints;

        if pathPoints and #pathPoints > 2 then
            for i = 2, #pathPoints - 1 do
                p899(p897, pathPoints[i].position, pathPoints[i + 1].position).Parent = p898;
                local v901;

                if pathPoints[i].imaginary and i ~= 2 then
                    v901 = i;
                else
                    p900(p897, pathPoints[i].position).Parent = p898;
                    v901 = i;
                end;
            end;

            p900(p897, pathPoints[#pathPoints].position).Parent = p898;
        end;
    end;

    local u902 = 0;

    function u1.startCharacterNavigation(p903, u904) -- Line: 5076
        -- upvalues: Map (copy), Minimap (copy), u902 (ref), u10 (ref), u2 (ref), CharScope (ref), HumanoidRootPart (copy), u771 (ref), drawMinimapLine (ref), drawMinimapCircle (ref), MapGui (copy), u772 (ref), u773 (ref)
        if Map.Navigation:FindFirstChild(p903) then
            Map.Navigation[p903]:Destroy();
        end;

        if Minimap.VisualMap3D.Navigation:FindFirstChild(p903) then
            Minimap.VisualMap3D.Navigation[p903]:Destroy();
        end;

        if u904 then
            u902 = (u902 + 1) % 50;
            local u905 = u10.clone(Map.Navigation.GroupPreview);
            u905.Name = p903;
            u905.Visible = true;
            u905.Parent = Map.Navigation;
            local u906 = u10.clone(Minimap.VisualMap3D.Navigation.GroupPreview);
            u906.Name = p903;
            u906.Parent = Minimap.VisualMap3D.Navigation;
            u2.activeNavigations[p903].navigationZIndex = u902;
            u2.activeNavigations[p903].canvas = u905;
            u2.activeNavigations[p903].minimapCanvas = u906;
            u2.activeNavigations[p903].thread = CharScope.taskDefer(function() -- Line: 5091
                -- upvalues: u904 (copy), HumanoidRootPart (ref), u771 (ref), drawMinimapLine (ref), drawMinimapCircle (ref), MapGui (ref), u772 (ref), u773 (ref), u905 (copy), u906 (copy)
                while true do
                    local v907 = u904.navigator.update(HumanoidRootPart, u904.target);

                    if v907 then
                        if v907 == "changed" then
                            u771(u904, u904.minimapCanvas, drawMinimapLine, drawMinimapCircle);

                            if MapGui.Visible then
                                u771(u904, u904.canvas, u772, u773);
                            end;
                        end;
                    else
                        if MapGui.Visible then
                            u905:ClearAllChildren();
                        end;

                        u906:ClearAllChildren();
                    end;

                    task.wait(1);
                end;
            end);
        end;
    end;

    for i, v in pairs(u2.activeNavigations) do
        u1.startCharacterNavigation(i, v);
    end;

    local function loadLocation(u908, p909) -- Line: 5111
        -- upvalues: u10 (ref), u11 (ref), u767 (copy), MapGui (copy), Map (copy), u750 (copy), realPositionToMap (ref), Minimap (copy), X (copy), realPositionToMinimap (ref), updateMinimapIconVisibility (copy), CharScope (ref), TweenService (ref), u774 (ref), u775 (ref), MapLocations (copy), u769 (ref), u768 (ref), PlayerEvent (ref)
        if not u10.isTeamWhitelisted(u908.Parent, u11) then
            return;
        end;

        local Name = u908.Parent.Name;

        if p909 then
            local Color32 = u908.Parent.Color3;

            local function setImageSize(p910) -- Line: 5117
                -- upvalues: u908 (copy)
                if u908.Parent:GetAttribute("ImageSize") then
                    p910.Size = UDim2.fromScale(p910.Size.X.Scale * u908.Parent:GetAttribute("ImageSize"), p910.Size.Y.Scale * u908.Parent:GetAttribute("ImageSize"));
                end;
            end;

            local function renderPriority(p911, p912) -- Line: 5120
                if p912 then
                    p911.ZIndex = p911.ZIndex + 2 * p912;
                    p911.Icon.ZIndex = p911.Icon.ZIndex + 2 * p912;
                end;
            end;

            local Attribute = u908.Parent:GetAttribute("Blips");
            local v913;

            if u767[u908.Parent.Name] then
                v913 = false;
            else
                v913 = true;
                local v914 = u10.clone(MapGui.Right.Top.Locations._ScrollingList.LocationPreview);
                v914.Name = (Attribute and "~" or "") .. (u908.Parent:GetAttribute("DisplayName") or u908.Parent.Name);
                v914.Visible = true;

                if Attribute and Attribute ~= "Civilian" then
                    v914.Blip.Visible = true;
                else
                    v914.Icon.Visible = true;
                    v914.Icon.Image = u908.Parent.Texture;
                    setImageSize(v914.Icon);
                end;

                v914.Parent = MapGui.Right.Top.Locations._ScrollingList.Scroll;
                u767[u908.Parent.Name] = {
                    v914,
                    {},
                    {},
                    {},
                    {}
                };
            end;

            table.insert(u767[u908.Parent.Name][4], u908);
            local u915;

            if Attribute then
                u915 = u10.clone(Attribute == "Civilian" and Map.CivilianBlipPreview or Map.BlipPreview);
            else
                u915 = u10.clone(Map.LocationIconPreview);
                u915.Button.Icon.Image = u908.Parent.Texture;
                local Button = u915.Button;
                local Attribute2 = u908.Parent:GetAttribute("RenderPriority");

                if Attribute2 then
                    Button.ZIndex = Button.ZIndex + 2 * Attribute2;
                    Button.Icon.ZIndex = Button.Icon.ZIndex + 2 * Attribute2;
                end;

                setImageSize(u915.Button.Icon);
            end;

            u915.Name = u908.Name;
            u915.Button.ImageColor3 = Color32;
            local Attribute2 = u908:GetAttribute("hasRadius");

            if Attribute2 then
                u915.Radius.Visible = true;
                u915.Radius.ImageColor3 = Color32;
                u915.Radius.Size = UDim2.fromScale(Attribute2 * 2 / u750.SizeX * (1 / u915.Size.X.Scale), Attribute2 * 2 / u750.SizeY * (1 / u915.Size.Y.Scale));
            end;

            if u908:IsA("BasePart") then
                u915.Position = UDim2.fromScale(realPositionToMap(u908.Position));
            end;

            u915.Visible = true;
            u915.Parent = Map.LocationIcons;
            table.insert(u767[u908.Parent.Name][2], u915);
            local u916;

            if Attribute then
                u916 = u10.clone(Attribute == "Civilian" and Minimap.Icons2D.CivilianBlipPreview or Minimap.Icons2D.BlipPreview);
                u916:SetAttribute("Rotation", 0);
            else
                u916 = u10.clone(Minimap.Icons2D.LocationIconPreview);
                u916.Frame.Button.Icon.Image = u908.Parent.Texture;
                local Button = u916.Frame.Button;
                local Attribute3 = u908.Parent:GetAttribute("RenderPriority");

                if Attribute3 then
                    Button.ZIndex = Button.ZIndex + 2 * Attribute3;
                    Button.Icon.ZIndex = Button.Icon.ZIndex + 2 * Attribute3;
                end;

                setImageSize(u916.Frame.Button.Icon);
            end;

            u916.Name = u908.Name;
            u916.Frame.Button.ImageColor3 = Color32;
            local Frame = u916.Frame;
            local Attribute3 = u908:GetAttribute("hasRadius");

            if Attribute3 then
                u916.Radius.Transparency = 0.5;
                u916.Radius.Color3 = Color32;
                u916.Size = Vector3.new(Attribute3 * 2 / u750.SizeX * X, u916.Size.Y, Attribute3 * 2 / u750.SizeY * X);
            end;

            if u908:IsA("BasePart") then
                local v917, v918 = realPositionToMinimap(u908.Position);
                u916.CFrame = CFrame.new(v917, 0, v918);
            end;

            u916.Parent = Minimap.VisualMap3D.Locations;
            table.insert(u767[u908.Parent.Name][3], u916);
            updateMinimapIconVisibility(u916);

            if u908:IsA("ObjectValue") then
                if Attribute then
                    if Attribute == "Emergency" or Attribute == "NonEmergency" then
                        local u919 = false;
                        CharScope.taskDefer(function() -- Line: 5201
                            -- upvalues: u908 (copy), Attribute (copy), u919 (ref), u915 (ref), Frame (copy), MapGui (ref), TweenService (ref), u916 (ref)
                            while u908.Parent do
                                local v920 = Attribute == "Emergency" and {
                                    {
                                        ImageColor3 = Color3.fromRGB(0, 123, 255)
                                    },
                                    {
                                        ImageColor3 = Color3.fromRGB(255, 83, 83)
                                    }
                                } or {
                                    {
                                        ImageTransparency = 1,
                                        ImageColor3 = Color3.fromRGB(255, 202, 138)
                                    },
                                    {
                                        ImageTransparency = 0.3,
                                        ImageColor3 = Color3.fromRGB(255, 202, 138)
                                    }
                                };

                                if u908.Value:GetAttribute("EmergencyLightsOn") then
                                    if not u919 then
                                        u919 = true;
                                        u915.Button.EmergencyLights.Visible = true;
                                        Frame.Button.EmergencyLights.Visible = true;
                                    end;

                                    for i = 1, 2 do
                                        if MapGui.Visible then
                                            TweenService:Create(u915.Button.EmergencyLights, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), v920[i]):Play();
                                        end;

                                        if u916:GetAttribute("Visible") then
                                            TweenService:Create(Frame.Button.EmergencyLights, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), v920[i]):Play();
                                        end;

                                        task.wait(0.6);

                                        if not u908.Parent then
                                            return;
                                        end;

                                        local _ = i;
                                    end;
                                else
                                    if u919 then
                                        u919 = false;
                                        u915.Button.EmergencyLights.Visible = false;
                                        Frame.Button.EmergencyLights.Visible = false;
                                    end;

                                    task.wait(2);
                                end;
                            end;
                        end);
                    end;

                    CharScope.taskSpawn(function() -- Line: 5226
                        -- upvalues: u908 (copy), u10 (ref), u915 (ref), u916 (ref), realPositionToMap (ref), realPositionToMinimap (ref), updateMinimapIconVisibility (ref)
                        local v921 = u908.Value:GetAttribute("CharacterRotation") or 0;
                        local v922 = u908.Value:GetAttribute("CharacterPosition") or Vector3.new();
                        local v923 = nil;

                        while u908.Parent do
                            local Attribute4 = u908.Value:GetAttribute("CharacterRotation");

                            if Attribute4 then
                                v921 = u10.lerpAngleDeg(v921, Attribute4, 0.09);
                                u915.Button.Rotation = 270 - v921;
                                u916:SetAttribute("Rotation", v921);
                            end;

                            local Attribute5 = u908.Value:GetAttribute("CharacterPosition");
                            local v924;

                            if Attribute5 then
                                v924 = u908.Value:GetAttribute("CharacterId");

                                if v923 == v924 then
                                    v924 = v923;
                                else
                                    v922 = Attribute5;
                                end;

                                v922 = v922:Lerp(Attribute5, 0.09);
                                local v925, v926 = realPositionToMap(v922);
                                u915.Position = UDim2.fromScale(v925, v926);
                                local v927, v928 = realPositionToMinimap(v922);
                                u916.CFrame = CFrame.new(v927, 0, v928);
                            else
                                v924 = v923;
                            end;

                            updateMinimapIconVisibility(u916);
                            task.wait(0.03);
                            v923 = v924;
                        end;
                    end);
                else
                    local u929 = u908.Value:IsA("Attachment") and "WorldPosition" or "Position";
                    CharScope.taskSpawn(function() -- Line: 5256
                        -- upvalues: u908 (copy), realPositionToMap (ref), u929 (copy), u915 (ref), realPositionToMinimap (ref), u916 (ref), updateMinimapIconVisibility (ref)
                        while u908.Parent do
                            local v930, v931 = realPositionToMap(u908.Value[u929]);
                            u915.Position = UDim2.fromScale(v930, v931);
                            local v932, v933 = realPositionToMinimap(u908.Value[u929]);
                            u916.CFrame = CFrame.new(v932, 0, v933);
                            updateMinimapIconVisibility(u916);
                            task.wait(0.4);
                        end;
                    end);
                end;
            end;

            if v913 then
                local v934 = u774;
                u774 = Name;

                local function v940(p935, p936) -- Line: 4726
                    -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                    if not u767[p935] then
                        return;
                    end;

                    local u937 = u767[p935][1];
                    local v938 = #u767[p935][2];
                    local v939 = p936 and u767[p935][4][u775] or u767[p935][4][1].Parent;
                    u937.TextLabel.Text = (v939:GetAttribute("DisplayName") or v939.Name) .. (v938 > 1 and (" (" .. (p936 and u775 .. "/" or "") .. v938 .. ")" or "") or "");
                    CharScope.taskSpawn(function() -- Line: 4733
                        -- upvalues: u937 (copy), u10 (ref)
                        u937.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u937.TextLabel, true).X / u937.AbsoluteSize.X, 1);
                    end);

                    if MapLocations[p935]:GetAttribute("Blips") and MapLocations[p935]:GetAttribute("Blips") ~= "Civilian" then
                        u937.Blip.ImageColor3 = p936 and Color3.fromRGB(22, 22, 22) or MapLocations[p935].Color3;
                        u937.Blip.Arrow.ImageColor3 = p936 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                        u937.Blip.Border.ImageColor3 = p936 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                    else
                        u937.Icon.ImageColor3 = p936 and Color3.fromRGB(22, 22, 22) or MapLocations[p935].Color3;
                    end;

                    u937.Background.ImageTransparency = p936 and 0 or 0.5;
                    u937.Background.ImageColor3 = p936 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                    u10.resetButtonColor(u937.Background, p936);
                    u937.TextLabel.TextColor3 = p936 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                    if p936 then
                        local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                        u769.setScroll(-((u937.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                    end;
                end;

                if u774 then
                    v940(u774, false);
                end;

                u774 = nil;
                u774 = v934;
            end;

            if u768 then
                u768(u908.Parent.Name, u767[u908.Parent.Name]);
            end;
        else
            if not u767[Name] then
                print("DEBUG26", Name);
            end;

            u10.waitForFunc(function() -- Line: 5277
                -- upvalues: u767 (ref), Name (copy)
                return u767[Name];
            end);

            if not u908.Parent then
                PlayerEvent:FireServer("developmentLogs", "DEBUG25");
            end;

            for i, v in pairs(u767[Name][4]) do
                if v == u908 then
                    u767[Name][2][i]:Destroy();
                    u767[Name][3][i]:Destroy();
                    table.remove(u767[Name][4], i);
                    table.remove(u767[Name][3], i);
                    table.remove(u767[Name][2], i);

                    if #u767[Name][2] == 0 then
                        u767[Name][1]:Destroy();
                        u767[Name] = nil;
                    end;

                    if u774 == Name then
                        if i < u775 then
                            u775 = u775 - 1;
                            local v941 = u767[Name] and Name or nil;

                            local function v947(p942, p943) -- Line: 4726
                                -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                                if not u767[p942] then
                                    return;
                                end;

                                local u944 = u767[p942][1];
                                local v945 = #u767[p942][2];
                                local v946 = p943 and u767[p942][4][u775] or u767[p942][4][1].Parent;
                                u944.TextLabel.Text = (v946:GetAttribute("DisplayName") or v946.Name) .. (v945 > 1 and (" (" .. (p943 and u775 .. "/" or "") .. v945 .. ")" or "") or "");
                                CharScope.taskSpawn(function() -- Line: 4733
                                    -- upvalues: u944 (copy), u10 (ref)
                                    u944.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u944.TextLabel, true).X / u944.AbsoluteSize.X, 1);
                                end);

                                if MapLocations[p942]:GetAttribute("Blips") and MapLocations[p942]:GetAttribute("Blips") ~= "Civilian" then
                                    u944.Blip.ImageColor3 = p943 and Color3.fromRGB(22, 22, 22) or MapLocations[p942].Color3;
                                    u944.Blip.Arrow.ImageColor3 = p943 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                    u944.Blip.Border.ImageColor3 = p943 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                else
                                    u944.Icon.ImageColor3 = p943 and Color3.fromRGB(22, 22, 22) or MapLocations[p942].Color3;
                                end;

                                u944.Background.ImageTransparency = p943 and 0 or 0.5;
                                u944.Background.ImageColor3 = p943 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                                u10.resetButtonColor(u944.Background, p943);
                                u944.TextLabel.TextColor3 = p943 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                                if p943 then
                                    local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                                    u769.setScroll(-((u944.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                                end;
                            end;

                            if u774 then
                                v947(u774, false);
                            end;

                            u774 = v941;

                            if v941 then
                                v947(v941, true);
                            end;
                        elseif i == u775 then
                            local function v953(p948, p949) -- Line: 4726
                                -- upvalues: u767 (ref), u775 (ref), CharScope (ref), u10 (ref), MapLocations (ref), MapGui (ref), u769 (ref)
                                if not u767[p948] then
                                    return;
                                end;

                                local u950 = u767[p948][1];
                                local v951 = #u767[p948][2];
                                local v952 = p949 and u767[p948][4][u775] or u767[p948][4][1].Parent;
                                u950.TextLabel.Text = (v952:GetAttribute("DisplayName") or v952.Name) .. (v951 > 1 and (" (" .. (p949 and u775 .. "/" or "") .. v951 .. ")" or "") or "");
                                CharScope.taskSpawn(function() -- Line: 4733
                                    -- upvalues: u950 (copy), u10 (ref)
                                    u950.Background.Size = UDim2.fromScale(0.23 + u10.getTextBounds(u950.TextLabel, true).X / u950.AbsoluteSize.X, 1);
                                end);

                                if MapLocations[p948]:GetAttribute("Blips") and MapLocations[p948]:GetAttribute("Blips") ~= "Civilian" then
                                    u950.Blip.ImageColor3 = p949 and Color3.fromRGB(22, 22, 22) or MapLocations[p948].Color3;
                                    u950.Blip.Arrow.ImageColor3 = p949 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                    u950.Blip.Border.ImageColor3 = p949 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);
                                else
                                    u950.Icon.ImageColor3 = p949 and Color3.fromRGB(22, 22, 22) or MapLocations[p948].Color3;
                                end;

                                u950.Background.ImageTransparency = p949 and 0 or 0.5;
                                u950.Background.ImageColor3 = p949 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(22, 22, 22);
                                u10.resetButtonColor(u950.Background, p949);
                                u950.TextLabel.TextColor3 = p949 and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(255, 255, 255);

                                if p949 then
                                    local _ = MapGui.Right.Top.Locations._ScrollingList.Scroll.UIListLayout.AbsoluteContentSize.Y / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y - 1;
                                    u769.setScroll(-((u950.AbsolutePosition.Y - MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsolutePosition.Y) / MapGui.Right.Top.Locations._ScrollingList.Scroll.AbsoluteSize.Y) + 0.5, 0.5);
                                end;
                            end;

                            if u774 then
                                v953(u774, false);
                            end;

                            u774 = nil;
                        end;
                    end;

                    break;
                end;
            end;
        end;

        if u769 then
            u769.limitYScrollListener();
        end;
    end;

    for _, child in pairs(MapLocations:GetChildren()) do
        for _, child2 in pairs(child:GetChildren()) do
            if child2:IsA("Part") or child2:IsA("ObjectValue") then
                loadLocation(child2, true);
            end;
        end;
    end;

    CharScope.buildSignalData("Global", { MapLocations.DescendantAdded, function(p954) -- Line: 5321
            -- upvalues: loadLocation (copy)
            if p954:IsA("Part") or p954:IsA("ObjectValue") then
                loadLocation(p954, true);
            end;
        end });
    CharScope.buildSignalData("Global", { MapLocations.DescendantRemoving, function(p955) -- Line: 5324
            -- upvalues: loadLocation (copy)
            if p955:IsA("Part") or p955:IsA("ObjectValue") then
                loadLocation(p955, false);
            end;
        end });

    for _, child in pairs(game.ReplicatedStorage.Gameplay.Areas:GetChildren()) do
        local v956 = u10.clone(Map.AreaPreview);
        v956.Text = child.Name;
        v956.Shadow.Text = child.Name;
        v956.Name = child.Name;
        v956.Visible = true;
        v956.Position = UDim2.fromScale(realPositionToMap(child.Position));
        v956.Parent = Map.Areas;
    end;

    CharScope.buildSignalData("Global", u2.mouseButton(Minimap.Button, function() -- Line: 5339
        -- upvalues: u1 (ref)
        u1.activateMap(true);
    end));

    local function trackTeamCharacters(p957, u958, p959) -- Line: 5344
        -- upvalues: MapLocations (copy), CharScope (ref), u2 (ref), u10 (ref)
        local Decal = Instance.new("Decal");
        Decal.Name = p957.Name .. " Team";
        Decal.Color3 = p959;

        if u958 == "Civilian" then
            Decal.Texture = "rbxassetid://4931198485";
            Decal:SetAttribute("ImageSize", 0.6);
        end;

        Decal:SetAttribute("Blips", u958);
        Decal.Parent = MapLocations;
        CharScope.addThreadOrCleanUpFunction("Global", function() -- Line: 5354
            -- upvalues: u2 (ref), Decal (copy)
            local v960 = nil;

            while true do
                local v961;
                v960, v961 = next(u2.trackedCharacters, v960);

                if not v960 then
                    break;
                end;

                if v961.Parent == Decal then
                    u2.trackedCharacters[v960] = nil;
                end;
            end;

            Decal:Destroy();
        end);
        u10.loadedPlayerAdded(CharScope.buildSignalData, "Global", p957, function(p962) -- Line: 5367
            -- upvalues: u2 (ref), u958 (copy), Decal (copy)
            if not u2.trackedCharacters[p962] or u2.trackedCharacters[p962].Parent.Name ~= "Crew Members" then
                u2.trackCharacterOnMap(p962, u958 == "Civilian" and true or "Callsign", Decal);
            end;
        end);
        CharScope.buildSignalData("Global", { p957.PlayerRemoved, function(p963) -- Line: 5368
                -- upvalues: u2 (ref)
                if not u2.trackedCharacters[p963] or u2.trackedCharacters[p963].Parent.Name ~= "Crew Members" then
                    u2.trackCharacterOnMap(p963);
                end;
            end });

        for _, v in pairs(u10.getLoadedPlayers(p957)) do
            if not u2.trackedCharacters[v] or u2.trackedCharacters[v].Parent.Name ~= "Crew Members" then
                CharScope.taskSpawn(function() -- Line: 5369
                    -- upvalues: u2 (ref), v (copy), u958 (copy), Decal (copy)
                    u2.trackCharacterOnMap(v, u958 == "Civilian" and true or "Callsign", Decal);
                end);
            end;
        end;
    end;

    if require(game.Teams[u11].Config).MDT then
        for _, child in pairs(game.Teams:GetChildren()) do
            local Config = require(child.Config);

            if Config.MDT then
                trackTeamCharacters(child, child.Name == "Road Service" and "NonEmergency" or "Emergency", Config.BLIP_COLOR or Config.COLOR);
            end;
        end;

        local Config = require(game.Teams.Chef.Config);
        trackTeamCharacters(game.Teams.Chef, "Civilian", Config.BLIP_COLOR or Config.COLOR);
    else
        for _, child in pairs(game.Teams:GetChildren()) do
            local Config = require(child.Config);

            if not Config.MDT then
                trackTeamCharacters(child, "Civilian", Config.BLIP_COLOR or Config.COLOR);
            end;
        end;
    end;

    local function activateDisplayLocation(p964) -- Line: 5391
        -- upvalues: CharScope (ref), ScreenGui (copy), HumanoidRootPart (copy), u10 (ref)
        CharScope.setConnectionsAndThreads("DisplayLocation");
        ScreenGui.Left.Bottom.StreetNames.Visible = false;

        if p964 then
            CharScope.addThreadOrCleanUpFunction("DisplayLocation", CharScope.taskDefer(function() -- Line: 5395
                -- upvalues: HumanoidRootPart (ref), u10 (ref), ScreenGui (ref)
                local Vector2_new_ret3 = Vector2.new(-10000, -10000);

                while true do
                    local Vector2_new_ret4 = Vector2.new(HumanoidRootPart.Position.X, HumanoidRootPart.Position.Z);

                    if (Vector2_new_ret4 - Vector2_new_ret3).magnitude > 25 then
                        local LocationInfoAtPos, v965, v966, _ = u10.getLocationInfoAtPos(HumanoidRootPart.Position, nil, {
                            maxStreetDist = 13
                        });

                        if v965 and v966 then
                            if not ScreenGui.Left.Bottom.StreetNames.Visible then
                                ScreenGui.Left.Bottom.StreetNames.Visible = true;
                            end;

                            ScreenGui.Left.Bottom.StreetNames.Location.Text = (LocationInfoAtPos == "near" and "Near " or "") .. v965;
                            ScreenGui.Left.Bottom.StreetNames.Area.Text = v966;
                        elseif ScreenGui.Left.Bottom.StreetNames.Visible then
                            ScreenGui.Left.Bottom.StreetNames.Visible = false;
                        end;
                    else
                        Vector2_new_ret4 = Vector2_new_ret3;
                    end;

                    task.wait(0.03);
                    Vector2_new_ret3 = Vector2_new_ret4;
                end;
            end));
        end;
    end;

    u2.debugLoadingClient("Character 7");
    local CharacterSelectionWheel = ScreenGui.Center.Middle.CharacterSelectionWheel;
    local u967 = {};
    local u968 = false;
    local u969 = false;
    local u970 = nil;
    u1.giveItemId = 0;

    local function canShowCharacterSelectionWheel() -- Line: 5424
        -- upvalues: UserInputService (ref), ScreenGui (copy), u2 (ref), u23 (ref)
        return UserInputService.MouseIconEnabled and (ScreenGui.Enabled and not u2.openedGui) and not u23;
    end;

    local function canShowCharacterSelectionWheelWithTarget(p971) -- Line: 5427
        -- upvalues: PlayerEvent (ref), u13 (copy), HumanoidRootPart (copy)
        if not p971.PrimaryPart then
            PlayerEvent:FireServer("developmentLogs", "DEBUG224", u13:GetPivot().Position, "|", p971:GetPivot().Position, #p971:GetChildren());
            task.delay(10, function() -- Line: 5430
                -- upvalues: PlayerEvent (ref)
                PlayerEvent:FireServer("developmentLogs", "DEBUG224-2");
            end);
        end;

        local v972;

        if p971 == u13 then
            v972 = false;
        else
            v972 = (p971.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude < 20;
        end;

        return v972;
    end;

    local function characterSelectionWheelSystem(u973, ...) -- Line: 5437
        -- upvalues: CharScope (ref), u969 (ref), u967 (copy), u970 (ref), CharacterSelectionWheel (copy), u10 (ref), u2 (ref), characterSelectionWheelSystem (copy), UserInputService (ref), ScreenGui (copy), u23 (ref), canShowCharacterSelectionWheelWithTarget (copy), u968 (ref), workspace_CurrentCamera (ref), RunService (ref)
        local u974 = { ... };
        u973 = u973;

        if u973 then
            if #u974 <= 0 then
                u974 = false;
            end;
        end;

        CharScope.setConnectionsAndThreads("CharacterSelectionWheel");
        u969 = u974;

        if u974 then
            u970 = u973;

            for _, child in pairs(CharacterSelectionWheel.Slots:GetChildren()) do
                if child.Visible then
                    child:Destroy();
                end;
            end;

            u974 = {};

            for _, v in pairs(u974) do
                table.insert(u974, v);
            end;

            for i, v in pairs(u974) do
                local v975 = u10.clone(CharacterSelectionWheel.Slots.Preview);
                v975.Background.TextLabel.Text = v.name;
                v975.Name = i;
                v975.Visible = true;
                local v976 = i / #u974 * 360 - 90;
                v975.Position = UDim2.fromScale(math.cos(v976 * 3.141592653589793 / 180) * 2.13 + 0.5, math.sin(v976 * 3.141592653589793 / 180) * 1 + 0.5);
                v975.Parent = CharacterSelectionWheel.Slots;
                CharScope.buildSignalData("CharacterSelectionWheel", u10.buttonHoverSignalData(v975.Background, {
                    intensity = 4
                }));
                CharScope.buildSignalData("CharacterSelectionWheel", u2.mouseButton(v975.ImageButton, function() -- Line: 5462
                    -- upvalues: u2 (ref), v (copy), characterSelectionWheelSystem (ref), u967 (ref), u974 (ref)
                    if u2.platform == "Mobile" then
                        task.wait();
                    end;

                    if v.close then
                        characterSelectionWheelSystem();
                    else
                        table.insert(u967, u974);
                    end;

                    v.call();
                end, {
                    addMobileButton = true
                }));
            end;

            CharacterSelectionWheel.ReturnBack.Visible = false;

            if not u10.isTableEmpty(u967) then
                CharacterSelectionWheel.ReturnBack.Visible = true;
                CharScope.buildSignalData("CharacterSelectionWheel", u10.buttonHoverSignalData(CharacterSelectionWheel.ReturnBack.Background, {
                    intensity = 4
                }));
                CharScope.buildSignalData("CharacterSelectionWheel", u2.mouseButton(CharacterSelectionWheel.ReturnBack.ImageButton, function() -- Line: 5472
                    -- upvalues: u967 (ref), characterSelectionWheelSystem (ref), u973 (copy)
                    local v977 = u967[#u967];
                    table.remove(u967, #u967);
                    characterSelectionWheelSystem(u973, unpack(v977));
                end, {
                    addMobileButton = true
                }));
            end;

            CharScope.buildSignalData("CharacterSelectionWheel", u10.instanceDestroyed(u973, function() -- Line: 5478
                -- upvalues: characterSelectionWheelSystem (ref)
                characterSelectionWheelSystem();
            end));
            CharScope.addThreadOrCleanUpFunction("CharacterSelectionWheel", CharScope.taskDefer(function() -- Line: 5479
                -- upvalues: UserInputService (ref), ScreenGui (ref), u2 (ref), u23 (ref), canShowCharacterSelectionWheelWithTarget (ref), u973 (copy), characterSelectionWheelSystem (ref)
                while true do
                    if not (UserInputService.MouseIconEnabled and (ScreenGui.Enabled and not u2.openedGui) and not u23 and canShowCharacterSelectionWheelWithTarget(u973)) then
                        return characterSelectionWheelSystem();
                    end;

                    task.wait(0.1);
                end;
            end));
        else
            table.clear(u967);
        end;

        if CharacterSelectionWheel.Visible ~= (u974 and true or false) then
            u10.guiTransition(CharacterSelectionWheel, "Size", 0.6, u974);
        end;

        if u974 then
            CharScope.taskSpawn(function() -- Line: 5488
                -- upvalues: u968 (ref), CharacterSelectionWheel (ref), u970 (ref), workspace_CurrentCamera (ref), u969 (ref), characterSelectionWheelSystem (ref), ScreenGui (ref), u2 (ref), RunService (ref)
                if not u968 then
                    u968 = true;

                    while CharacterSelectionWheel.Visible and (u970 and u970.Parent) do
                        local v978, v979 = workspace_CurrentCamera:WorldToViewportPoint(u970.PrimaryPart.Position);

                        if u969 and not v979 then
                            characterSelectionWheelSystem();
                        end;

                        CharacterSelectionWheel.Position = UDim2.fromOffset(v978.X - ScreenGui.Center.Middle.AbsolutePosition.X, v978.Y - ScreenGui.Center.Middle.AbsolutePosition.Y - u2.guiInset);
                        RunService.RenderStepped:Wait();
                    end;

                    u968 = false;
                end;
            end);
        end;
    end;

    local u980 = u10.raycastParamsNew();
    u980.IgnoreWater = true;
    u10.contextAction("BindActionAtPriority", "CharacterSelectionWheel", function(p981, p982) -- Line: 5505
        -- upvalues: u969 (ref), characterSelectionWheelSystem (copy), UserInputService (ref), ScreenGui (copy), u2 (ref), u23 (ref), u980 (copy), u10 (ref), canShowCharacterSelectionWheelWithTarget (copy), LocalPlayer (ref), CharScope (ref), u1 (ref), Animator (copy), u4 (ref), HumanoidRootPart (copy), GameRules (ref), u688 (ref), PlayerFunc (ref)
        if p981 == Enum.UserInputState.Begin and (p982.UserInputType == Enum.UserInputType.MouseButton1 or p982.UserInputType == Enum.UserInputType.Touch) then
            if u969 then
                characterSelectionWheelSystem();

                if p982.UserInputType == Enum.UserInputType.MouseButton1 then
                    return Enum.ContextActionResult.Sink;
                end;
            elseif UserInputService.MouseIconEnabled and (ScreenGui.Enabled and not u2.openedGui) and not u23 then
                if p982.UserInputType == Enum.UserInputType.Touch then
                    u2.updateMobileTouchInput(p982, false);
                end;

                local v983 = u2.getMouseProperty.raycast(u980, 100, "FreeSpace", {
                    character = true
                });

                if v983 then
                    local u984 = v983.Instance.Parent:GetAttribute("Pet") and v983.Instance.Parent or v983.Instance:IsDescendantOf(workspace.Characters) and u10.getAncestorsChild(workspace.Characters, v983.Instance);

                    if u984 and canShowCharacterSelectionWheelWithTarget(u984) then
                        local function u1014() -- Line: 5519
                            -- upvalues: u984 (copy), u10 (ref), LocalPlayer (ref), u2 (ref), characterSelectionWheelSystem (ref), CharScope (ref), u1 (ref), Animator (ref), u4 (ref), HumanoidRootPart (ref), GameRules (ref), u688 (ref), PlayerFunc (ref)
                            if u984:GetAttribute("Pet") then
                                local v985 = u10.getInstanceAttribute(LocalPlayer, "Pet") == u984;
                                local u986;

                                if v985 then
                                    u986 = u2.currentPetStatus ~= "Sit";
                                else
                                    u986 = v985;
                                end;

                                characterSelectionWheelSystem(u984, {
                                    name = "Pet",
                                    close = true,

                                    call = function() -- Line: 5525, Name: call
                                        -- upvalues: CharScope (ref), u1 (ref), u984 (ref), u10 (ref), Animator (ref)
                                        CharScope.taskDefer(function() -- Line: 5526
                                            -- upvalues: u1 (ref), u984 (ref), u10 (ref), Animator (ref)
                                            u1.rotateTowards(u984.PrimaryPart, true);
                                            u10.animationBuffer(Animator, "play", "PetPet");
                                            task.wait(1);
                                            u1.rotateTowards();
                                        end);
                                    end
                                }, v985 and (u4.equippedItem and require(u4.equippedItem.Config).CATEGORY == "Food") and ({
                                    name = "Feed",
                                    close = true,

                                    call = function() -- Line: 5533, Name: call
                                        -- upvalues: u10 (ref), CharScope (ref), Animator (ref), u984 (ref)
                                        if not u10.invokeTraffic.pet then
                                            CharScope.taskDefer(function() -- Line: 5535
                                                -- upvalues: u10 (ref), Animator (ref), u984 (ref)
                                                if u10.invokeServerTraffic("pet", "feed") then
                                                    u10.animationBuffer(Animator, "play", "PlaceGive");
                                                    u10.animationBuffer(u984.AnimationController.Animator, "play", "OpenMouth");
                                                end;
                                            end);
                                        end;
                                    end
                                } or nil) or nil, v985 and ({
                                    close = true,
                                    name = u986 and "Sit" or "Follow Me",

                                    call = function() -- Line: 5543, Name: call
                                        -- upvalues: CharScope (ref), u984 (ref), u2 (ref), u986 (copy), HumanoidRootPart (ref)
                                        CharScope.taskDefer(function() -- Line: 5544
                                            -- upvalues: u984 (ref), u2 (ref), u986 (ref), HumanoidRootPart (ref)
                                            if u984.Parent then
                                                u2.setPetStatus(u984, u986 and "Sit" or "Follow", HumanoidRootPart);
                                            end;
                                        end);
                                    end
                                } or nil) or nil);

                                return;
                            end;

                            local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "InProperty");
                            local PlayerFromCharacter = u10.getPlayerFromCharacter(u984);

                            if PlayerFromCharacter then
                                local v987 = u10.isCharLoaded(PlayerFromCharacter, {
                                    isAlive = true
                                });
                                local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);
                                local v988;

                                if PlayerFromCharacter then
                                    if BelongingVehicle then
                                        v988 = BelongingVehicle.Config.CanDrive:FindFirstChild(PlayerFromCharacter.UserId) and "Remove Car Keys" or ((BelongingVehicle.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude < 30 and "Give Car Keys" or false);
                                    else
                                        v988 = BelongingVehicle;
                                    end;
                                else
                                    v988 = PlayerFromCharacter;
                                end;

                                characterSelectionWheelSystem(u984, v987 and ({
                                    name = "Give Cash",
                                    close = true,

                                    call = function() -- Line: 5556, Name: call
                                        -- upvalues: u10 (ref), PlayerFromCharacter (copy), u2 (ref), GameRules (ref), CharScope (ref)
                                        if not u10.invokeTraffic.giveCash and PlayerFromCharacter then
                                            if u2.readPlayerData("Verified") == 2 then
                                                local u989 = GameRules.giveCashPerPlayerLimit - (u2.readPlayerData("GiveCashAndItemLimits", "giftedPerPlayer", (tostring(PlayerFromCharacter.UserId))) or 0);

                                                if u989 <= 0 then
                                                    u2.notify({
                                                        color = "red",
                                                        message = "You can’t give cash. This player has received ＄" .. u10.commaValue(GameRules.giveCashPerPlayerLimit) .. " from you today"
                                                    });

                                                    return;
                                                end;

                                                if (u2.readPlayerData("GiveCashAndItemLimits", "gifted") or 0) >= GameRules.giveCashLimit then
                                                    u2.notify({
                                                        color = "red",
                                                        message = "You can’t give cash. You’ve hit your ＄" .. u10.commaValue(GameRules.giveCashLimit) .. " daily gift limit"
                                                    });

                                                    return;
                                                end;

                                                local u993 = u2.mainBox({
                                                    case = "Text",
                                                    textPlaceholder = "Amount",
                                                    acceptContent = "GIVE",
                                                    headline = "Give cash to " .. PlayerFromCharacter.DisplayName .. "\n(Daily player limit: ＄" .. u10.commaValue(u989) .. " / ＄" .. u10.commaValue(GameRules.giveCashPerPlayerLimit) .. ")",

                                                    formatTextFunc = function(p990) -- Line: 5563, Name: formatTextFunc
                                                        -- upvalues: u10 (ref), u989 (copy)
                                                        local v991 = u10.toOnlyNumbers(p990);

                                                        return v991 ~= "" and math.clamp(v991, 0, u989) or "";
                                                    end,

                                                    acceptTextFunc = function(p992) -- Line: 5563, Name: acceptTextFunc
                                                        if #p992 > 0 and tonumber(p992) > 0 then
                                                            return true;
                                                        end;
                                                    end
                                                });

                                                if u993 then
                                                    CharScope.taskSpawn(function() -- Line: 5565
                                                        -- upvalues: u10 (ref), u993 (copy), PlayerFromCharacter (ref), u2 (ref)
                                                        local v994 = u10.invokeServerTraffic("giveCash", tonumber(u993), PlayerFromCharacter);

                                                        if u10.typeOf(v994) == "string" then
                                                            u2.notify({
                                                                color = "red",
                                                                message = v994
                                                            });
                                                        end;
                                                    end);
                                                end;
                                            else
                                                u2.notify({
                                                    message = "Verify your ID/phone number on Roblox to be able to give money",
                                                    color = "red"
                                                });
                                            end;
                                        end;
                                    end
                                } or nil) or nil, v987 and ({
                                    name = "Shared Emote",

                                    call = function() -- Line: 5576, Name: call
                                        -- upvalues: u10 (ref), PlayerFromCharacter (copy), u1 (ref), u688 (ref), characterSelectionWheelSystem (ref), u984 (ref)
                                        local u995 = {};

                                        local function addEmote(p996) -- Line: 5578
                                            -- upvalues: u10 (ref), PlayerFromCharacter (ref), u1 (ref), u995 (copy)
                                            local u997 = u10.deepCopyTable(p996);

                                            function u997.call() -- Line: 5580
                                                -- upvalues: PlayerFromCharacter (ref), u1 (ref), u997 (copy)
                                                if PlayerFromCharacter then
                                                    u1.playEmote(u997.name, nil, nil, PlayerFromCharacter);
                                                end;
                                            end;

                                            table.insert(u995, u997);
                                        end;

                                        for _, v in pairs(u688) do
                                            for _, v2 in pairs(v) do
                                                local v998;

                                                if u10.typeOf(v2[1]) == "table" then
                                                    v998 = v2;

                                                    for _, v3 in pairs(v2) do
                                                        if v3.sharedEmote then
                                                            local u999 = u10.deepCopyTable(v3);

                                                            function u999.call() -- Line: 5580
                                                                -- upvalues: PlayerFromCharacter (ref), u1 (ref), u999 (copy)
                                                                if PlayerFromCharacter then
                                                                    u1.playEmote(u999.name, nil, nil, PlayerFromCharacter);
                                                                end;
                                                            end;

                                                            table.insert(u995, u999);
                                                        end;
                                                    end;
                                                else
                                                    v998 = v2;
                                                end;

                                                if v998.sharedEmote then
                                                    local u1000 = u10.deepCopyTable(v998);

                                                    function u1000.call() -- Line: 5580
                                                        -- upvalues: PlayerFromCharacter (ref), u1 (ref), u1000 (copy)
                                                        if PlayerFromCharacter then
                                                            u1.playEmote(u1000.name, nil, nil, PlayerFromCharacter);
                                                        end;
                                                    end;

                                                    table.insert(u995, u1000);
                                                end;
                                            end;
                                        end;

                                        characterSelectionWheelSystem(u984, unpack(u995));
                                    end
                                } or nil) or nil, v987 and u4.equippedItem and ({
                                    name = "Give Item",
                                    close = true,

                                    call = function() -- Line: 5595, Name: call
                                        -- upvalues: u4 (ref), u10 (ref), PlayerFromCharacter (copy), u1 (ref), CharScope (ref), u2 (ref)
                                        if u4.equippedItem and (not u10.invokeTraffic.giveItem and PlayerFromCharacter) then
                                            u1.giveItemId = (u1.giveItemId + 1) % 100;
                                            local Attribute = u4.equippedItem:GetAttribute("Id");
                                            CharScope.taskSpawn(function() -- Line: 5600
                                                -- upvalues: u10 (ref), Attribute (copy), PlayerFromCharacter (ref), u2 (ref)
                                                local v1001 = u10.invokeServerTraffic("giveItem", Attribute, PlayerFromCharacter);

                                                if v1001 == true then
                                                    u2.notify({
                                                        message = "Item given",
                                                        color = "green"
                                                    });

                                                    return;
                                                end;

                                                if u10.typeOf(v1001) == "string" then
                                                    u2.notify({
                                                        color = "red",
                                                        message = v1001
                                                    });
                                                end;
                                            end);
                                        end;
                                    end
                                } or nil) or nil, v987 and v988 and ({
                                    close = true,
                                    name = v988,

                                    call = function() -- Line: 5609, Name: call
                                        -- upvalues: BelongingVehicle (copy), PlayerFromCharacter (copy), u10 (ref), CharScope (ref), u2 (ref)
                                        local u1002 = not BelongingVehicle.Config.CanDrive:FindFirstChild(PlayerFromCharacter.UserId);

                                        if not u10.invokeTraffic.giveCarKeys and PlayerFromCharacter then
                                            CharScope.taskSpawn(function() -- Line: 5613
                                                -- upvalues: u10 (ref), PlayerFromCharacter (ref), u1002 (copy), u2 (ref)
                                                local v1003 = u10.invokeServerTraffic("giveCarKeys", PlayerFromCharacter, u1002);

                                                if v1003 == true then
                                                    u2.notify({
                                                        color = "green",
                                                        message = u1002 and "Vehicle keys given" or "Vehicle keys removed"
                                                    });

                                                    return;
                                                end;

                                                if u10.typeOf(v1003) == "string" then
                                                    u2.notify({
                                                        color = "red",
                                                        message = v1003
                                                    });
                                                end;
                                            end);
                                        end;
                                    end
                                } or nil) or nil, InstanceAttribute and InstanceAttribute.Owner.Value == LocalPlayer.UserId and ({
                                    name = "Kick",
                                    close = true,

                                    call = function() -- Line: 5622, Name: call
                                        -- upvalues: u10 (ref), PlayerFromCharacter (copy), u2 (ref)
                                        if not u10.invokeTraffic.housing and PlayerFromCharacter then
                                            local v1004 = u10.invokeServerTraffic("housing", "ownerKick", {
                                                target = PlayerFromCharacter
                                            });

                                            if v1004 == true then
                                                u2.notify({
                                                    color = "green",
                                                    message = PlayerFromCharacter.DisplayName .. " was kicked"
                                                });

                                                return;
                                            end;

                                            if u10.typeOf(v1004) == "string" then
                                                u2.notify({
                                                    color = "red",
                                                    message = v1004
                                                });
                                            end;
                                        end;
                                    end
                                } or nil) or nil, v987 and (PlayerFromCharacter and (PlayerFromCharacter:GetAttribute("Arrested") == LocalPlayer.UserId and {
                                    name = "Arrested",

                                    call = function() -- Line: 5635, Name: call
                                        -- upvalues: characterSelectionWheelSystem (ref), u984 (ref), PlayerFromCharacter (copy), u10 (ref), u4 (ref), CharScope (ref), PlayerFunc (ref), u2 (ref)
                                        characterSelectionWheelSystem(u984, {
                                            name = "Search",
                                            close = true,

                                            call = function() -- Line: 5637, Name: call
                                                -- upvalues: PlayerFromCharacter (ref), u10 (ref), u4 (ref), CharScope (ref), PlayerFunc (ref), u2 (ref)
                                                local u1005 = PlayerFromCharacter and (not u10.invokeTraffic.arrestClient and u10.invokeServerTraffic("arrestClient", "searchPlayer", {
                                                    player = PlayerFromCharacter
                                                }));

                                                if u1005 then
                                                    local function areAllIllegalAndWeaponsConfiscated() -- Line: 5641
                                                        -- upvalues: u1005 (copy), u10 (ref)
                                                        for _, v in pairs(u1005) do
                                                            if u10.canConfiscateItem(v) then
                                                                return false;
                                                            end;
                                                        end;

                                                        return true;
                                                    end;

                                                    local u1006 = {};

                                                    local function slotClicked(p1007, p1008, p1009) -- Line: 5648
                                                        -- upvalues: u10 (ref), u1005 (copy), u1006 (copy), u4 (ref), CharScope (ref), PlayerFunc (ref), PlayerFromCharacter (ref), u2 (ref)
                                                        if p1009 then
                                                            if u10.canConfiscateItem(p1009) then
                                                                u1005[p1008] = nil;
                                                                table.insert(u1006, p1009[3]);
                                                                u4.renderInventory(u1005);
                                                                local v1010 = true;

                                                                for _, v in pairs(u1005) do
                                                                    if u10.canConfiscateItem(v) then
                                                                        v1010 = false;
                                                                        break;
                                                                    end;
                                                                end;

                                                                if v1010 then
                                                                    u4.updateInventoryBottomMessage("All illegal items confiscated!");
                                                                    CharScope.taskSpawn(function() -- Line: 5656
                                                                        -- upvalues: PlayerFunc (ref), PlayerFromCharacter (ref)
                                                                        PlayerFunc:InvokeServer("arrestClient", "searchPlayerConfiscateItems", {
                                                                            confiscate = true,
                                                                            player = PlayerFromCharacter
                                                                        });
                                                                    end);
                                                                end;
                                                            else
                                                                u2.notify({
                                                                    message = "You can\'t confiscate this item",
                                                                    color = "red"
                                                                });
                                                            end;
                                                        end;
                                                    end;

                                                    local function closed() -- Line: 5661
                                                        -- upvalues: u1006 (copy), CharScope (ref), PlayerFunc (ref), PlayerFromCharacter (ref)
                                                        if #u1006 > 0 then
                                                            CharScope.taskSpawn(function() -- Line: 5663
                                                                -- upvalues: PlayerFunc (ref), PlayerFromCharacter (ref), u1006 (ref)
                                                                PlayerFunc:InvokeServer("arrestClient", "searchPlayerConfiscateItems", {
                                                                    player = PlayerFromCharacter,
                                                                    confiscate = u1006
                                                                });
                                                            end);
                                                        end;
                                                    end;

                                                    local activateInventory = u4.activateInventory;
                                                    local v1011 = {
                                                        customName = PlayerFromCharacter.DisplayName .. "\'s Inventory"
                                                    };
                                                    local v1012 = true;

                                                    for _, v in pairs(u1005) do
                                                        if u10.canConfiscateItem(v) then
                                                            v1012 = false;
                                                            break;
                                                        end;
                                                    end;

                                                    v1011.bottomMessage = v1012 and "No items to confiscate" or "Click to confiscate weapons and illegal items";
                                                    v1011.slotClicked = slotClicked;
                                                    v1011.closed = closed;
                                                    activateInventory(u1005, v1011);
                                                end;
                                            end
                                        }, {
                                            name = "Request Transport",
                                            close = true,

                                            call = function() -- Line: 5670, Name: call
                                                -- upvalues: PlayerFromCharacter (ref), u10 (ref), u2 (ref)
                                                if PlayerFromCharacter and not u10.invokeTraffic.arrestClient then
                                                    local v1013 = u10.invokeServerTraffic("arrestClient", "requestTransport", {
                                                        player = PlayerFromCharacter
                                                    });

                                                    if u10.typeOf(v1013) == "string" then
                                                        u2.notify({
                                                            color = "red",
                                                            message = v1013
                                                        });
                                                    end;
                                                end;
                                            end
                                        }, u10.isPrivateServerConfigurationSettingEnabled("elevatedPolicePermissions") and {
                                            name = "Release",
                                            close = true,

                                            call = function() -- Line: 5676, Name: call
                                                -- upvalues: PlayerFromCharacter (ref), u10 (ref)
                                                if PlayerFromCharacter and not u10.invokeTraffic.arrestClient then
                                                    u10.invokeServerTraffic("arrestClient", "jailArrestedPlayer", {
                                                        releasePrivateServer = true,
                                                        player = PlayerFromCharacter
                                                    });
                                                end;
                                            end
                                        } or nil);
                                    end
                                })) or nil);
                            end;
                        end;

                        if p982.UserInputType == Enum.UserInputType.MouseButton1 then
                            u1014();

                            return Enum.ContextActionResult.Sink;
                        end;

                        CharScope.taskSpawn(function() -- Line: 5691
                            -- upvalues: u2 (ref), u1014 (copy)
                            if u2.mobileInputServiceClick() then
                                u1014();
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end, false, Enum.ContextActionPriority.High.Value + 2, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch);
    local Vehicle = ScreenGui.Right.Bottom.Vehicle;
    local SpeedLimit = ScreenGui.Left.Bottom.Minimap.SpeedLimit;
    local RadioPanel = Vehicle.RadioPanel;
    local u1015 = {};
    local ELS = ScreenGui.Right.Bottom.ELS;
    local u1016 = { Color3.fromRGB(204, 133, 112), Color3.fromRGB(76, 76, 76), Color3.fromRGB(255, 255, 255) };
    local u1017 = {
        Manual = 1,
        LongManual = 1,
        Pcall = 2,
        Hilo = 2,
        Yelp = 2,
        Wail = 2,
        Phsr = 2,
        Auto = 2,
        Q2B = 3
    };
    u1.mobileELSActive = false;

    function u1.refreshELSGuiVisibility() -- Line: 5713
        -- upvalues: LocalPlayer (ref), ScreenGui (copy), u2 (ref), u1 (ref)
        local Value = LocalPlayer.InsideLocation.Value;

        if Value then
            Value = Value.Name == "Auto Shop" and true or Value.Name == "Boat Repair Shop";
        end;

        ScreenGui.Right.Bottom.ELS.Visible = not Value and (u2.platform ~= "Mobile" and true or u1.mobileELSActive);
    end;

    local u1018 = false;

    function u1.vehicleStallsEffect() -- Line: 5720
        -- upvalues: u1018 (ref), u2 (ref), CharScope (ref), u10 (ref), ScreenGui (copy)
        if not u1018 then
            u1018 = true;
            u2.changeFOV(-6);
            CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Left, false, 0.12);
            CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Center.Bottom, false, 0.12);
            CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Center.Top, false, 0.12);
            CharScope.taskSpawn(function() -- Line: 5727
                -- upvalues: u10 (ref), ScreenGui (ref), u2 (ref), CharScope (ref), u1018 (ref)
                u10.transparencyFade(ScreenGui.Right, false, 0.12);
                task.wait(1);
                u2.changeFOV(6);
                CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Left, true, 0.12);
                CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Center.Bottom, true, 0.12);
                CharScope.taskSpawn(u10.transparencyFade, ScreenGui.Center.Top, true, 0.12);
                u10.transparencyFade(ScreenGui.Right, true, 0.12);
                u1018 = false;
            end);

            return true;
        end;
    end;

    CharScope.buildSignalData("Global", u2.mouseButton(Mobile.VehiclePassenger.Exit, function() -- Line: 5741
        -- upvalues: u3 (ref)
        u3.enterVehicle(false, {
            playerInput = true
        });
    end));

    function u1.passengerRadio(p1019, p1020) -- Line: 5759
        -- upvalues: CharScope (ref), u1 (ref), u2 (ref)
        CharScope.setConnectionsAndThreads("VehicleGui");
        u1.setVolume = nil;

        if not p1020 then
            u2.radioActivate();

            return;
        end;

        local Radio = p1019.Config.Radio;

        local function getChannel() -- Line: 5764
            -- upvalues: Radio (copy)
            return Radio.Channel.Value == "" and "Radio San Aurie" or Radio.Channel.Value;
        end;

        u1.radioBaseVolume = 0;

        function u1.setVolume() -- Line: 5766
            -- upvalues: Radio (copy), u1 (ref)
            game.SoundService.Radio.Volume = Radio.Volume.Value / 3 * u1.radioBaseVolume;
        end;

        if Radio.Value then
            u2.radioActivate(Radio.Channel.Value == "" and "Radio San Aurie" or Radio.Channel.Value, nil, true, true);
            u1.setVolume();
        end;

        CharScope.buildSignalData("VehicleGui", { Radio.Changed, function(p1021) -- Line: 5774
                -- upvalues: u2 (ref), Radio (copy)
                if p1021 then
                    p1021 = Radio.Channel.Value == "" and "Radio San Aurie" or Radio.Channel.Value;
                end;

                u2.radioActivate(p1021, nil, true, true);
            end });
        CharScope.buildSignalData("VehicleGui", { Radio.Channel.Changed, function(p1022) -- Line: 5777
                -- upvalues: u2 (ref), Radio (copy)
                u2.radioActivate(Radio.Channel.Value == "" and "Radio San Aurie" or Radio.Channel.Value, nil, true, true);
            end });
        CharScope.buildSignalData("VehicleGui", { Radio.Volume.Changed, u1.setVolume });
    end;

    u1.vehicleRadio = nil;
    local u1023 = nil;
    local u1024 = {};

    function u1.activateVehicleGui(u1025, p1026) -- Line: 5787
        -- upvalues: CharScope (ref), u1023 (ref), u1024 (copy), u1 (ref), SpeedLimit (copy), Vehicle (copy), u2 (ref), u10 (ref), activateDisplayLocation (ref), GameRules (ref), u1015 (copy), u3 (ref), HumanoidRootPart (copy), RadioPanel (copy), PlayerEvent (ref), LocalPlayer (ref), PlayerGui (ref), u11 (ref), u13 (copy), UserInputService (ref), ScreenGui (copy), Mobile (copy), EmergencyLightingSystem (ref), ELS (copy), u1016 (copy), u1017 (copy)
        CharScope.setConnectionsAndThreads("VehicleGui");

        if u1023 then
            u1023(false);
        end;

        for _, v in pairs(u1024) do
            v();
        end;

        table.clear(u1024);
        u1.setDashboardIcon = nil;
        u1.vehicleRadio = nil;
        u1.activateELSLightsUserInput = nil;
        u1.activateELSManualUserInput = nil;
        u1.activateELSAutoUserInput = nil;
        u1.setVolume = nil;
        u1.radioBaseVolume = nil;
        SpeedLimit.Visible = false;
        local v1027 = u1025.Parent and u1025.Config:FindFirstChild("ELS");
        local v1028 = u1025.Parent and require(u1025.Config);
        Vehicle:SetAttribute("TransitionTweenType", u2.platform == "Mobile" and UDim2.new(0, 0, 0, -50) or UDim2.fromScale(0, v1027 and -1.8 or 0));
        u10.guiTransition(Vehicle, "Position", UDim2.fromScale(0, 1), p1026);

        if not p1026 or v1027 then
            activateDisplayLocation(p1026);
        end;

        if p1026 then
            local u1029 = u2.readPlayerData("Settings", "SpeedUnit") and GameRules.mphToKmh or 1;
            Vehicle.Visible = true;

            local function vehicleGuiBar(u1030, u1031) -- Line: 5809
                -- upvalues: u1015 (ref), Vehicle (ref), CharScope (ref), u10 (ref), u1025 (copy)
                u1015[u1030] = {};

                local function v1034(p1032) -- Line: 5811
                    -- upvalues: Vehicle (ref), u1030 (copy), u1031 (copy), u1015 (ref), CharScope (ref), u10 (ref)
                    Vehicle[u1030].UIGradient.Offset = Vector2.new(0, 1 - p1032 / u1031);
                    u1015[u1030].low = p1032 / u1031 < 0.25;

                    if u1015[u1030].lowOn ~= u1015[u1030].low then
                        u1015[u1030].lowOn = u1015[u1030].low;
                        local u1033 = false;

                        if u1015[u1030].low then
                            CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", u1030 .. "bar", CharScope.taskSpawn(function() -- Line: 5818
                                -- upvalues: Vehicle (ref), u1030 (ref), u1033 (ref)
                                while true do
                                    Vehicle[u1030 .. "Circle"].Icon.ImageColor3 = u1033 and Vehicle[u1030].ImageColor3 or Color3.fromRGB(255, 255, 255);
                                    u1033 = not u1033;
                                    task.wait(1);
                                end;
                            end));
                        elseif CharScope.getConnectionsAndThreads("VehicleGui")[u1030 .. "bar"] then
                            u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui")[u1030 .. "bar"][1]);
                        end;
                    end;
                end;

                CharScope.buildSignalData("VehicleGui", { u1025:WaitForChild("Config"):WaitForChild(u1030).Changed, v1034 });
                v1034(u1025.Config[u1030].Value);
            end;

            vehicleGuiBar("Durability", u3.maxDurability);
            vehicleGuiBar("Fuel", u3.maxFuel);
            local u1035 = {};

            for i = 1, 10 do
                local v1036;

                if Vehicle["Button" .. i]:FindFirstChild("Icon") then
                    Vehicle["Button" .. i].Icon:Destroy();
                    Vehicle["Button" .. i].Visible = false;
                    v1036 = i;
                else
                    v1036 = i;
                end;
            end;

            local function addVehicleButton(p1037, u1038, p1039) -- Line: 5844
                -- upvalues: Vehicle (ref), u10 (ref), u1035 (copy), CharScope (ref), u2 (ref)
                local v1040 = Vehicle["Button" .. u10.indexedTableSize(u1035) + 1];
                u1035[p1037] = v1040;
                v1040.Visible = true;
                local v1041 = u10.clone(Vehicle.ButtonIcons[p1037]);
                v1041.Name = "Icon";

                if v1041:IsA("TextLabel") then
                    v1041.TextColor3 = Color3.fromRGB(85, 85, 85);
                else
                    v1041.ImageColor3 = Color3.fromRGB(85, 85, 85);
                end;

                v1041.Parent = v1040;
                CharScope.buildSignalData("VehicleGui", u2.mouseButton(v1040, function() -- Line: 5852
                    -- upvalues: u1038 (copy)
                    u1038();
                end, {
                    addMobileButton = true
                }));
                CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(v1040.Circle));

                if p1039 then
                    CharScope.buildSignalData("VehicleGui", u2.displayGuiDetails(v1040, p1039));
                end;

                return v1040;
            end;

            function u1.vehicleButtonPressed(p1042, p1043) -- Line: 5857
                -- upvalues: u1035 (copy)
                if u1035[p1042] then
                    u1035[p1042].Icon[u1035[p1042].Icon:IsA("TextLabel") and "TextColor3" or "ImageColor3"] = p1043 and Color3.fromRGB(110, 144, 204) or Color3.fromRGB(85, 85, 85);
                end;
            end;

            CharScope.addThreadOrCleanUpFunction("VehicleGui", CharScope.taskSpawn(function() -- Line: 5861
                -- upvalues: Vehicle (ref), u2 (ref), u3 (ref), u10 (ref), u1025 (copy), GameRules (ref), u1029 (copy)
                Vehicle.SpeedUnit.Text = u2.readPlayerData("Settings", "SpeedUnit") and "KMH" or "MPH";
                local v1044 = 0;

                while true do
                    Vehicle.Tachometer.Text = u3.gear;
                    Vehicle.TachometerIndicator.UIGradient.Rotation = u10.lerp(Vehicle.TachometerIndicator.UIGradient.Rotation, (u1025:GetAttribute("EngineSpeed") or u3.absSpeed / u3.gearChange[u3.gear + 1]) * 110 + 115, 1 - 0.001 ^ v1044);
                    Vehicle.Speedmeter.Text = math.round(GameRules.velocityToMph * u3.absSpeed * u1029);
                    v1044 = task.wait();
                end;
            end));

            for _, child in pairs(Vehicle.Dashboard:GetChildren()) do
                child.Visible = false;
            end;

            function u1.setDashboardIcon(p1045, p1046, p1047) -- Line: 5873
                -- upvalues: Vehicle (ref)
                Vehicle.Dashboard[p1045].Visible = p1046;

                if p1046 and p1047 then
                    for i, v in pairs(p1047) do
                        Vehicle.Dashboard[p1045][i].Text = v;
                    end;
                end;
            end;

            u1.setDashboardIcon("NoSeatbelt", u10.isPrivateServerConfigurationSettingEnabled("ejectOnCrash"));

            if u1025.Config:FindFirstChild("Headlights") then
                CharScope.buildSignalData("VehicleGui", { u1025.Config.Headlights.Changed, function(p1048) -- Line: 5882
                        -- upvalues: u1 (ref)
                        u1.setDashboardIcon("Headlights", p1048);
                    end });
            end;

            local setDashboardIcon = u1.setDashboardIcon;
            local v1049 = u1025.Config:FindFirstChild("Headlights") and u1025.Config.Headlights.Value;
            setDashboardIcon("Headlights", v1049);
            addVehicleButton("Help", function() -- Line: 5886
                -- upvalues: u2 (ref)
                u2.activateMenu("Help", "Vehicle");
            end, "Help");

            if u10.getVehicleInfo.getVehicleTeam(u1025) ~= "Transit" then
                addVehicleButton("Lock", function() -- Line: 5889
                    -- upvalues: u3 (ref)
                    u3.actionBegan("lock");
                end, "Door Lock");
                u1.vehicleButtonPressed("Lock", u1025.Config.Locked.Value);
            end;

            addVehicleButton("SpeedLimiter", function() -- Line: 5893
                -- upvalues: u3 (ref)
                u3.actionBegan("speedLimiter");
            end, "Speed Limiter");
            u1.vehicleButtonPressed("SpeedLimiter", u1025.Config.SpeedLimiter.Value ~= 0);
            u1.setDashboardIcon("SpeedLimiter", u1025.Config.SpeedLimiter.Value ~= 0, {
                Limit = math.round(GameRules.velocityToMph * u1025.Config.SpeedLimiter.Value * u1029)
            });
            local Vector3_new_ret2 = Vector3.new();
            CharScope.addThreadOrCleanUpFunction("VehicleGui", CharScope.taskSpawn(function() -- Line: 5898
                -- upvalues: Vector3_new_ret2 (ref), HumanoidRootPart (ref), u10 (ref), SpeedLimit (ref), u1029 (copy)
                while true do
                    if (Vector3_new_ret2 - HumanoidRootPart.Position).Magnitude > 15 then
                        Vector3_new_ret2 = HumanoidRootPart.Position;
                        local SpeedLimitAtPos = u10.getSpeedLimitAtPos(Vector3_new_ret2);
                        SpeedLimit.Visible = SpeedLimitAtPos;

                        if SpeedLimitAtPos then
                            SpeedLimit.Limit.Text = math.round(SpeedLimitAtPos * u1029);
                        end;
                    end;

                    task.wait(2);
                end;
            end));
            u1.radioBaseVolume = 0;
            local Radio = u1025.Config.Radio;
            local Value = Radio.Volume.Value;

            local function highlightChannel(p1050) -- Line: 5914
                -- upvalues: RadioPanel (ref), u10 (ref)
                for _, child in pairs(RadioPanel.Channels.Offset:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.ImageColor3 = child.Name == (p1050 or "Off") and Color3.fromRGB(123, 126, 141) or Color3.fromRGB(92, 94, 106);
                        u10.resetButtonColor(child, child.Name == (p1050 or "Off"));
                    end;
                end;
            end;

            function u1.setVolume(p1051) -- Line: 5923
                -- upvalues: Value (ref), PlayerEvent (ref), u1 (ref), RadioPanel (ref)
                Value = math.clamp(Value + p1051, 1, 5);
                PlayerEvent:FireServer("vehicle", "radioVolume", Value);
                game.SoundService.Radio.Volume = Value / 3 * u1.radioBaseVolume;
                RadioPanel.Volume.Current.Text = Value;
            end;

            function u1.vehicleRadio(u1052, p1053, p1054) -- Line: 5930
                -- upvalues: Radio (copy), u1 (ref), CharScope (ref), u10 (ref), PlayerEvent (ref), highlightChannel (copy), Value (ref), u2 (ref)
                if u1052 == nil then
                    u1052 = not Radio.Value;
                end;

                local u1055 = p1053 or (Radio.Channel.Value == "" and "Radio San Aurie" or Radio.Channel.Value);

                if u1052 and (game.SoundService.Radio.IsPlaying and Radio.Channel.Value == u1055) then
                    return;
                end;

                u1.vehicleButtonPressed("Radio", u1052);

                if CharScope.getConnectionsAndThreads("VehicleGui").vehicleRadio then
                    u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").vehicleRadio[1]);
                end;

                if u1052 ~= Radio.Value then
                    Radio.Value = u1052;
                    PlayerEvent:FireServer("vehicle", "radio", u1052);
                end;

                if u1052 then
                    highlightChannel(u1055);
                    Radio.Channel.Value = u1055;
                    PlayerEvent:FireServer("vehicle", "radioChannel", u1055);

                    if game.SoundService.Radio.Tuning.TimeLength == 0 or p1054 then
                        u2.radioActivate(u1052 and u1055, nil, true, true);
                    else
                        game.SoundService.Radio.Tuning:Play();
                        game.SoundService.Radio.Volume = Value / 3 * u1.radioBaseVolume * 0.3;
                        CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "vehicleRadio", CharScope.taskDelay(game.SoundService.Radio.Tuning.TimeLength, function() -- Line: 5947
                            -- upvalues: u2 (ref), u1052 (ref), u1055 (ref)
                            u2.radioActivate(u1052 and u1055, nil, true, true);
                        end));
                    end;
                else
                    game.SoundService.Radio.Tuning:Stop();
                    highlightChannel();
                    u2.radioActivate(u1052 and u1055, nil, true, true);
                end;
            end;

            local function showRadioGui() -- Line: 5958
                -- upvalues: RadioPanel (ref), u10 (ref)
                RadioPanel.Visible = true;

                while u10.isInFrame(RadioPanel.Mouse, nil, true) do
                    task.wait(0.03);
                end;

                RadioPanel.Visible = false;
            end;

            local v1056 = addVehicleButton("Radio", function() -- Line: 5963
                -- upvalues: u2 (ref), CharScope (ref), showRadioGui (copy)
                if u2.platform == "Mobile" then
                    CharScope.taskDefer(showRadioGui);
                end;
            end);
            RadioPanel.Position = v1056.Position;
            RadioPanel.Visible = false;
            u1.setVolume(0);

            if u2.platform ~= "Mobile" then
                CharScope.buildSignalData("VehicleGui", { v1056.MouseEnter, function() -- Line: 5971
                        -- upvalues: showRadioGui (copy)
                        showRadioGui();
                    end });
            end;

            for _, child in pairs(game.ReplicatedStorage.Gameplay.Radio.Stations:GetChildren()) do
                CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(RadioPanel.Channels.Offset[child.Name]));
                CharScope.buildSignalData("VehicleGui", u2.mouseButton(RadioPanel.Channels.Offset[child.Name], function() -- Line: 5977
                    -- upvalues: u1 (ref), child (copy)
                    u1.vehicleRadio(true, child.Name);
                end));
            end;

            CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(RadioPanel.Channels.Offset.Off));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(RadioPanel.Channels.Offset.Off, function() -- Line: 5982
                -- upvalues: Radio (copy), u1 (ref)
                if Radio.Value then
                    u1.vehicleRadio();
                    game.SoundService.Vehicle.Click2:Play();
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(RadioPanel.Volume.Up));
            CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(RadioPanel.Volume.Down));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(RadioPanel.Volume.Up, function() -- Line: 5990
                -- upvalues: u1 (ref)
                u1.setVolume(1);
                game.SoundService.Vehicle.Click2:Play();
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(RadioPanel.Volume.Down, function() -- Line: 5991
                -- upvalues: u1 (ref)
                u1.setVolume(-1);
                game.SoundService.Vehicle.Click2:Play();
            end));
            u2.radioActivate();

            if Radio.Value then
                CharScope.taskSpawn(u1.vehicleRadio, true, Radio.Channel.Value, true);
            else
                highlightChannel();
                u1.vehicleButtonPressed("Radio", false);
            end;

            local function checkIfWantsToKickPassengerTaxiDriver(p1057) -- Line: 6000
                -- upvalues: LocalPlayer (ref)
                if LocalPlayer.Team.Name == "Transit" then
                    local v1058 = game.ReplicatedStorage.Gameplay.Missions.Active:FindFirstChild("Taxi Order By " .. p1057.Name);

                    if v1058 and v1058.Players:FindFirstChild(LocalPlayer.Name) then
                        return true;
                    end;
                end;
            end;

            local u1059 = nil;
            local u1060 = false;

            u1023 = function(p1061) -- Line: 6010, Name: kickPassengers
                -- upvalues: u1060 (ref), CharScope (ref), u1 (ref), u1059 (ref), u10 (ref), Vehicle (ref), PlayerGui (ref), LocalPlayer (ref), u1025 (copy), u2 (ref), PlayerEvent (ref), u1023 (ref)
                u1060 = p1061 and true or false;
                CharScope.setConnectionsAndThreads("VehicleKickPassengers");
                u1.vehicleButtonPressed("KickPassengers", p1061 and true or false);

                if u1059 then
                    u1059:Destroy();
                    u1059 = nil;
                end;

                if p1061 then
                    local v1062 = 0;
                    u1059 = u10.clone(Vehicle.KickPassengersPreview.KickScreenGui);
                    u1059.Enabled = true;
                    u1059.Parent = PlayerGui;
                    local u1063 = {};

                    for _, v in pairs(u10.getLoadedPlayers()) do
                        if v ~= LocalPlayer then
                            local v1064 = u10.isCharLoaded(v);
                            local v1065 = u10.getVehicleInfo.inVehicle(v);

                            if v1064 and (v1065 and v1065 == u1025) then
                                u1063[v] = true;
                                local v1066 = u10.clone(Vehicle.KickPassengersPreview.Kick);
                                v1066.Adornee = v1064.Seat.Part1;
                                v1066.Enabled = true;
                                v1066.Parent = u1059;
                                v1062 = v1062 + 1;
                                CharScope.buildSignalData("VehicleKickPassengers", u2.mouseButton(v1066.ImageButton, function() -- Line: 6033
                                    -- upvalues: v (copy), LocalPlayer (ref), PlayerEvent (ref), u2 (ref)
                                    local v1067 = v;
                                    local v1068;

                                    if LocalPlayer.Team.Name == "Transit" then
                                        local v1069 = game.ReplicatedStorage.Gameplay.Missions.Active:FindFirstChild("Taxi Order By " .. v1067.Name);
                                        v1068 = v1069 and v1069.Players:FindFirstChild(LocalPlayer.Name) and true or nil;
                                    else
                                        v1068 = nil;
                                    end;

                                    if v1068 then
                                        u2.notify({
                                            message = "You can\'t kick out your client",
                                            color = "red"
                                        });

                                        return;
                                    end;

                                    PlayerEvent:FireServer("vehicle", "kickPassenger", v);
                                end));
                            end;

                            local InstanceAttributeChangedSignal, v1070 = u10.getInstanceAttributeChangedSignal(v, "InVehicle", function() -- Line: 6040
                                -- upvalues: u10 (ref), v (copy), u1025 (ref), u1063 (copy), u1023 (ref)
                                if u10.getVehicleInfo.inVehicle(v) == u1025 ~= (u1063[v] == true) then
                                    u1023(true);
                                end;
                            end);
                            CharScope.buildSignalData("VehicleKickPassengers", unpack(InstanceAttributeChangedSignal));
                            CharScope.addThreadOrCleanUpFunction("VehicleKickPassengers", v1070);
                        end;
                    end;

                    if v1062 <= 0 then
                        u1023(false);

                        return "noPassengers";
                    end;
                end;
            end;

            addVehicleButton("KickPassengers", function() -- Line: 6055
                -- upvalues: u1023 (ref), u1060 (ref), u10 (ref), u2 (ref)
                local v1071 = u1023(not u1060);

                if u10.typeOf(v1071) == "string" then
                    u2.notify({
                        color = "red",
                        message = v1071 == "noPassengers" and "You don\'t have any passengers" or (v1071 == "transitTeam" and "Transit team can\'t kick out passengers" or false)
                    });
                end;
            end, "Kick Passengers");

            if u11 == "Police" and LocalPlayer:GetAttribute("VoiceChatEnabled") then
                local u1072 = false;

                function u1.vehiclePoliceSpeaker() -- Line: 6064
                    -- upvalues: u1072 (ref), u1 (ref), PlayerEvent (ref), u13 (ref)
                    u1072 = not u1072;
                    u1.vehicleButtonPressed("PoliceSpeaker", u1072);
                    PlayerEvent:FireServer("vehicle", "policeVehicleSpeaker", u13, u1072);
                    game.SoundService.PoliceSpeaker:Play();
                end;

                addVehicleButton("PoliceSpeaker", u1.vehiclePoliceSpeaker, "Police Speaker (Voice Chat)");
                u1.vehicleButtonPressed("PoliceSpeaker", u1072);
            end;

            local v1073;

            if u2.platform == "Mobile" then
                v1073 = UserInputService.GyroscopeEnabled and u2.readPlayerData("Settings", "TiltDeviceToSteerVehicle");
            else
                v1073 = false;
            end;

            ScreenGui.Left.Bottom.Mobile.Vehicle.Left.Visible = not v1073;
            ScreenGui.Left.Bottom.Mobile.Vehicle.Right.Visible = not v1073;
            CharScope.buildSignalData("VehicleGui", { u1025.Config.Indicator.Changed, function(p1074) -- Line: 6077
                    -- upvalues: u10 (ref), ScreenGui (ref), u1 (ref)
                    u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.LeftIndicator, p1074 == 1);
                    u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.RightIndicator, p1074 == 2);
                    u1.vehicleButtonPressed("Hazards", p1074 == 3);
                end });
            u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.LeftIndicator, u1025.Config.Indicator.Value == 1);
            u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.RightIndicator, u1025.Config.Indicator.Value == 2);
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.LeftIndicator, function() -- Line: 6084
                -- upvalues: u3 (ref)
                u3.actionBegan("leftIndicator");
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.RightIndicator, function() -- Line: 6085
                -- upvalues: u3 (ref)
                u3.actionBegan("rightIndicator");
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(Mobile.Vehicle.Exit, function() -- Line: 6086
                -- upvalues: u3 (ref)
                u3.enterVehicle(false, {
                    playerInput = true
                });
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(Mobile.Vehicle.Handbrake, function() -- Line: 6087
                -- upvalues: u3 (ref), u10 (ref), Mobile (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("handbrake") then
                    u10.mobileButtonPressed(Mobile.Vehicle.Handbrake, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "handbrakeMobileButton", CharScope.taskSpawn(function() -- Line: 6090
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), Mobile (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("handbrake") then
                            u10.mobileButtonPressed(Mobile.Vehicle.Handbrake, false);
                        end;
                    end));
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.Horn, function() -- Line: 6096
                -- upvalues: u3 (ref), u10 (ref), ScreenGui (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("horn") then
                    u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.Horn, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "hornMobileButton", CharScope.taskSpawn(function() -- Line: 6099
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), ScreenGui (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("horn") then
                            u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Options.Horn, false);
                        end;
                    end));
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.Vehicle.Left, function() -- Line: 6105
                -- upvalues: u3 (ref), u10 (ref), ScreenGui (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("left") then
                    u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Left, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "leftMobileButton", CharScope.taskSpawn(function() -- Line: 6108
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), ScreenGui (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("left") then
                            u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Left, false);
                        end;
                    end));
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(ScreenGui.Left.Bottom.Mobile.Vehicle.Right, function() -- Line: 6114
                -- upvalues: u3 (ref), u10 (ref), ScreenGui (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("right") then
                    u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Right, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "rightMobileButton", CharScope.taskSpawn(function() -- Line: 6117
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), ScreenGui (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("right") then
                            u10.mobileButtonPressed(ScreenGui.Left.Bottom.Mobile.Vehicle.Right, false);
                        end;
                    end));
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(Mobile.Vehicle.Gas, function() -- Line: 6123
                -- upvalues: u3 (ref), u10 (ref), Mobile (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("forward") then
                    u10.mobileButtonPressed(Mobile.Vehicle.Gas, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "gasMobileButton", CharScope.taskSpawn(function() -- Line: 6126
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), Mobile (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("forward") then
                            u10.mobileButtonPressed(Mobile.Vehicle.Gas, false);
                        end;
                    end));
                end;
            end));
            CharScope.buildSignalData("VehicleGui", u2.mouseButton(Mobile.Vehicle.Brake, function() -- Line: 6132
                -- upvalues: u3 (ref), u10 (ref), Mobile (ref), CharScope (ref), u2 (ref)
                if u3.actionBegan("reverse") then
                    u10.mobileButtonPressed(Mobile.Vehicle.Brake, true);
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "brakeMobileButton", CharScope.taskSpawn(function() -- Line: 6135
                        -- upvalues: u2 (ref), u3 (ref), u10 (ref), Mobile (ref)
                        u2.mobileInputServiceClick();

                        if u3.actionEnded("reverse") then
                            u10.mobileButtonPressed(Mobile.Vehicle.Brake, false);
                        end;
                    end));
                end;
            end));

            if u2.platform == "Mobile" then
                if u1025.Config:FindFirstChild("Headlights") then
                    addVehicleButton("Lights", function() -- Line: 6143
                        -- upvalues: u3 (ref)
                        u3.actionBegan("lights");
                    end, "Lights");
                    u1.vehicleButtonPressed("Lights", u1025.Config.Headlights.Value);
                end;

                if u1025.Config:FindFirstChild("Indicator") then
                    addVehicleButton("Hazards", function() -- Line: 6147
                        -- upvalues: u3 (ref)
                        u3.actionBegan("hazards");
                    end, "Hazards");
                    u1.vehicleButtonPressed("Hazards", u1025.Config.Indicator.Value == 3);
                end;

                if u10.isPrivateServerConfigurationSettingEnabled("ejectOnCrash") then
                    addVehicleButton("Seatbelt", function() -- Line: 6151
                        -- upvalues: u1 (ref), u3 (ref)
                        u1.vehicleButtonPressed("Seatbelt", u3.wearSeatbelt());
                    end, "Seatbelt");
                end;

                addVehicleButton("SwitchCamera", function() -- Line: 6153
                    -- upvalues: u1 (ref), u3 (ref)
                    u1.vehicleButtonPressed("SwitchCamera", u3.activateFirstPersonCameraVehicle());
                end, "Switch Camera");
                u1.vehicleButtonPressed("SwitchCamera", u1.firstPerson);

                if u10.hasCustomizationPart.Neon(u1025) and u1025.PrimaryPart.Neon:GetAttribute("IsPurchased") then
                    addVehicleButton("Neon", function() -- Line: 6156
                        -- upvalues: u1 (ref), u3 (ref)
                        u1.vehicleButtonPressed("Neon", u3.switchNeon());
                    end, "Neon");
                    u1.vehicleButtonPressed("Neon", true);
                end;

                if u1025.Config:FindFirstChild("ELS") then
                    u1.ELSMobileVehicleButton = addVehicleButton("ELS", function() -- Line: 6160
                        -- upvalues: u1 (ref)
                        u1.mobileELSActive = not u1.mobileELSActive;
                        u1.vehicleButtonPressed("ELS", u1.mobileELSActive);
                        u1.refreshELSGuiVisibility();
                    end, "Emergency Lights");
                    u1.vehicleButtonPressed("ELS", u1.mobileELSActive);
                    u1.refreshELSGuiVisibility();
                end;
            end;
        else
            if game.SoundService.Radio.Tuning.IsPlaying then
                game.SoundService.Radio.Tuning:Stop();
            end;

            u2.radioActivate();
        end;

        if not v1027 then
            function u1.activateVehicleTakedownOrAdivsor(p1075) -- Line: 6176
                -- upvalues: EmergencyLightingSystem (ref), u1025 (copy), PlayerEvent (ref)
                if EmergencyLightingSystem["activate" .. p1075](u1025) then
                    local v1076 = u1025.Config[p1075];
                    v1076.Value = not v1076.Value;
                    PlayerEvent:FireServer("vehicle", "ELS", {
                        activate = v1076.Value,
                        case = p1075
                    });
                    game.SoundService.Vehicle.Click3:Play();
                end;
            end;

            return;
        end;

        local u1077 = ELS[v1028.ELS_GUI];

        for _, child in pairs(ELS:GetChildren()) do
            local v1078;

            if p1026 then
                v1078 = child == u1077;
            else
                v1078 = p1026;
            end;

            child.Visible = v1078;
        end;

        local function setButtonColor(p1079, p1080) -- Line: 6188
            -- upvalues: u1016 (ref), u10 (ref)
            p1079.Background.ImageColor3 = p1080 and u1016[1] or u1016[3];

            if p1079:FindFirstChild("TextLabel") then
                p1079.TextLabel.TextColor3 = p1080 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(255, 255, 255);
            elseif p1079:FindFirstChild("Icon") then
                p1079.Icon.ImageColor3 = p1080 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(255, 255, 255);
            end;

            p1079.Background.ImageTransparency = p1080 and 0 or 0.8;
            u10.resetButtonColor(p1079.Background, p1080);
        end;

        function u1.activateVehicleTakedownOrAdivsor(p1081) -- Line: 6197
            -- upvalues: EmergencyLightingSystem (ref), u1025 (copy), PlayerEvent (ref), setButtonColor (copy), u1077 (copy)
            if EmergencyLightingSystem["activate" .. p1081](u1025) then
                local v1082 = u1025.Config[p1081];
                v1082.Value = not v1082.Value;
                PlayerEvent:FireServer("vehicle", "ELS", {
                    activate = v1082.Value,
                    case = p1081
                });
                setButtonColor(u1077[p1081], u1025.Config[p1081].Value);
                game.SoundService.Vehicle.SwitchELS:Play();
            end;
        end;

        local function playSiren(p1083, p1084) -- Line: 6207
            -- upvalues: u1025 (copy), u1017 (ref), u10 (ref), setButtonColor (copy), u1077 (copy), u11 (ref), PlayerEvent (ref)
            for _, child in pairs(u1025._Chassis:GetChildren()) do
                if u1017[child.Name] and (u1025._Chassis[child.Name].IsPlaying and p1084[u1017[child.Name]]) then
                    u10.stopSoundReplicate(u1025._Chassis[child.Name]);
                    setButtonColor(child.Name == "Manual" and u1077:FindFirstChild("ManualPitched") or u1077[child.Name], false);

                    if u11 == "Police" then
                        PlayerEvent:FireServer("vehicle", "policeCanPullOverPlayer", false);
                    end;
                end;
            end;

            if p1083 and not u1025._Chassis[p1083].IsPlaying then
                u10.playSoundReplicate(u1025._Chassis[p1083]);
                setButtonColor(u1077[p1083], true);

                if u11 == "Police" then
                    PlayerEvent:FireServer("vehicle", "policeCanPullOverPlayer", true);
                end;
            end;
        end;

        local function remeberPlayingSirenVehicleActivates(p1085) -- Line: 6221
            -- upvalues: u1025 (copy), u1017 (ref), playSiren (copy)
            if p1085 then
                for _, child in pairs(u1025._Chassis:GetChildren()) do
                    if u1017[child.Name] and (u1025._Chassis[child.Name].IsPlaying and (u1017[child.Name] == 2 or u1017[child.Name] == 3)) then
                        child:SetAttribute("PlaySirenVehicleStart", true);
                    end;
                end;

                return;
            end;

            for _, child in pairs(u1025._Chassis:GetChildren()) do
                if u1017[child.Name] and child:GetAttribute("PlaySirenVehicleStart") then
                    child:SetAttribute("PlaySirenVehicleStart", nil);
                    playSiren(child.Name, {});
                end;
            end;
        end;

        if not p1026 then
            remeberPlayingSirenVehicleActivates(true);
            playSiren(nil, { true, true, true });

            return;
        end;

        local function emergencyLightsOnGui(p1086) -- Line: 6240
            -- upvalues: CharScope (ref), u10 (ref), setButtonColor (copy), u1077 (copy), u1025 (copy), u1016 (ref)
            if CharScope.getConnectionsAndThreads("VehicleGui").emergencyLightsOnGui then
                u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").emergencyLightsOnGui[1]);
            end;

            setButtonColor(u1077.Lights, p1086);
            local u1087 = {};
            local u1088 = {};

            for _, child in pairs(u1077.LightPattern:GetChildren()) do
                local v1089 = u1025.Model:FindFirstChild(child.Name, true);

                if v1089 then
                    u1087[child] = v1089;

                    if v1089:FindFirstChild("MeshPart") then
                        u1088[child] = true;
                    end;
                end;
            end;

            if p1086 then
                CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "emergencyLightsOnGui", CharScope.taskSpawn(function() -- Line: 6253
                    -- upvalues: u1087 (copy), u1016 (ref), u1088 (copy)
                    while true do
                        for i, v in pairs(u1087) do
                            local v1090;

                            if u1088[i] then
                                v1090 = v.MeshPart.Material == Enum.Material.Neon and 1 or 2;
                            else
                                v1090 = v.Gui.B.Light.Size.X.Scale > 0 and 1 or 2;
                            end;

                            i.BackgroundColor3 = u1016[v1090];
                        end;

                        task.wait(0.03);
                    end;
                end));

                return;
            end;

            for i, _ in pairs(u1087) do
                i.BackgroundColor3 = u1016[2];
            end;
        end;

        local v1091 = u2.readPlayerData("Ranks", u1025.Config.Type.Value) or 1;
        local u1092 = {};

        for i, v in pairs(require(game.Teams[u10.getVehicleInfo.getVehicleTeam(u1025)].Config).VEHICLE_LIGHTING_PATTERNS_RANK) do
            if i <= u1025.Config.ELS.Total.Value and (v <= v1091 or u2.readPlayerData("UnlockEarly", u1025.Config.Type.Value, "ELS Pattern " .. i)) then
                table.insert(u1092, i);
            end;
        end;

        local function pattern(p1093, p1094) -- Line: 6269
            -- upvalues: u1025 (copy), u1092 (copy), u1077 (copy), PlayerEvent (ref)
            local v1095 = ((u1025.Config.ELS:GetAttribute("StoredPattern") or 1) + p1093 - 1) % #u1092 + 1;
            local v1096 = u1092[v1095];
            u1077.Pattern.TextLabel.Text = "P-" .. v1096;

            if p1094 then
                u1025.Config.ELS.Value = v1096;
                u1025.Config.ELS:SetAttribute("StoredPattern", v1095);
                PlayerEvent:FireServer("vehicle", "ELS", {
                    case = "Lights",
                    activate = v1096
                });
                game.SoundService.Vehicle.SwitchELS:Play();
            end;
        end;

        local u1097 = nil;
        local u1098 = nil;
        local u1099 = nil;

        local function activateButton(u1100, u1101) -- Line: 6284
            -- upvalues: setButtonColor (copy), u1025 (copy), u1092 (copy), playSiren (copy), emergencyLightsOnGui (copy), PlayerEvent (ref), u10 (ref), u2 (ref), pattern (copy), CharScope (ref), UserInputService (ref), u1 (ref), u1098 (ref), u1099 (ref), u1097 (ref), ELS (ref), u1017 (ref)
            if u1100.Name == "Lights" then
                game.SoundService.Vehicle.SwitchELS:Play();
                setButtonColor(u1100, u1025.Config.ELS.Value == 0);

                if u1025.Config.ELS.Value == 0 then
                    u1025.Config.ELS.Value = u1092[u1025.Config.ELS:GetAttribute("StoredPattern") or 1];
                else
                    u1025.Config.ELS.Value = 0;
                    playSiren(nil, { true, true, true });
                end;

                emergencyLightsOnGui(u1025.Config.ELS.Value ~= 0);
                PlayerEvent:FireServer("vehicle", "ELS", {
                    case = "Lights",
                    activate = u1025.Config.ELS.Value
                });

                return;
            end;

            if u1100.Name == "LeftPattern" or u1100.Name == "RightPattern" then
                if u1025.Config.ELS.Value == 0 then
                    return;
                end;

                if #u1092 == 1 and not u10.rest("moreLightingPatternsNotification", 30) then
                    u2.notify({
                        message = "See vehicle customization for emergency lights patterns"
                    });
                end;

                pattern(u1100.Name == "RightPattern" and 1 or -1, true);

                return;
            end;

            if u1100.Name == "Manual" or u1100.Name == "ManualPitched" then
                if u10.getInstanceAttribute(u1025, "InsideVehicle") then
                    return;
                end;

                if u1100.Name == "Manual" then
                    playSiren(u1100.Name, {});
                else
                    playSiren(nil, {
                        [3] = true
                    });
                    setButtonColor(u1100, true);
                    PlayerEvent:FireServer("vehicle", "manualPitchedSiren", true);
                end;

                local function u1102() -- Line: 6311
                    -- upvalues: u1100 (copy), playSiren (ref), PlayerEvent (ref), setButtonColor (ref)
                    if u1100.Name == "Manual" then
                        playSiren(nil, { true });

                        return;
                    end;

                    PlayerEvent:FireServer("vehicle", "manualPitchedSiren", false);
                    setButtonColor(u1100, false);
                end;

                if u2.platform == "Mobile" then
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "manualSiren", CharScope.taskSpawn(function() -- Line: 6320
                        -- upvalues: u2 (ref), u1102 (copy)
                        u2.mobileInputServiceClick();
                        u1102();
                    end));

                    return;
                end;

                local u1103 = {};
                u1103 = CharScope.buildSignalData("VehicleGui", { UserInputService.InputEnded, function(p1104) -- Line: 6326
                        -- upvalues: u1101 (copy), u1102 (copy), u1103 (ref)
                        if not u1101 and p1104.UserInputType == Enum.UserInputType.MouseButton1 or u1101 and p1104.KeyCode == u1101 then
                            u1102();
                            u1103[1]:Disconnect();
                        end;
                    end });

                return;
            end;

            if u1100.Name == "Takedown" or u1100.Name == "Advisor" then
                u1.activateVehicleTakedownOrAdivsor(u1100.Name);

                return;
            end;

            if u1100.Name == "SpeedRadar" then
                u1098(not u1025.Config.SpeedRadar.Value);
                game.SoundService.Vehicle.SwitchELS:Play();

                return;
            end;

            if u1100.Name == "SpeedRadarDash" then
                u1099(not u10.getInstanceAttribute(u1025.Config.SpeedRadar, "SpeedRadarLocked"));
                game.SoundService.Vehicle.SwitchELS:Play();

                return;
            end;

            if u1100.Name == "Ladder" then
                u1097(not u1025.Ladder.Active.Value);
                game.SoundService.Vehicle.SwitchELS:Play();

                return;
            end;

            if u1100.Parent == ELS.AdditionLadder then
                setButtonColor(u1100, true);
                local u1105 = true;
                CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "ladder", CharScope.taskSpawn(function() -- Line: 6347
                    -- upvalues: u1105 (ref), PlayerEvent (ref), u1100 (copy)
                    while u1105 do
                        PlayerEvent:FireServer("vehicle", "ladder", u1100.Name);
                        task.wait(0.2);
                    end;
                end));

                local function _() -- Line: 6353
                    -- upvalues: setButtonColor (ref), u1100 (copy), u1105 (ref)
                    setButtonColor(u1100, false);
                    u1105 = false;
                end;

                if u2.platform == "Mobile" then
                    CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "ladder2", CharScope.taskSpawn(function() -- Line: 6358
                        -- upvalues: u2 (ref), setButtonColor (ref), u1100 (copy), u1105 (ref)
                        u2.mobileInputServiceClick();
                        setButtonColor(u1100, false);
                        u1105 = false;
                    end));
                else
                    local u1106 = {};
                    u1106 = CharScope.buildSignalData("VehicleGui", { UserInputService.InputEnded, function(p1107) -- Line: 6364
                            -- upvalues: setButtonColor (ref), u1100 (copy), u1105 (ref), u1106 (ref)
                            if p1107.UserInputType == Enum.UserInputType.MouseButton1 then
                                setButtonColor(u1100, false);
                                u1105 = false;
                                u1106[1]:Disconnect();
                            end;
                        end });
                end;

                game.SoundService.Vehicle.SwitchELS:Play();

                return;
            end;

            if u10.getInstanceAttribute(u1025, "InsideVehicle") then
                return;
            end;

            if u1025.Config.ELS.Value == 0 then
                return;
            end;

            playSiren(not u1025._Chassis[u1100.Name].IsPlaying and u1100.Name, {
                [u1017[u1100.Name]] = true
            });
            game.SoundService.Vehicle.SwitchELS:Play();
        end;

        local function loadButton(u1108) -- Line: 6379
            -- upvalues: setButtonColor (copy), CharScope (ref), u10 (ref), u1025 (copy), u1092 (copy), u1077 (copy), u3 (ref), PlayerEvent (ref), ELS (ref), u2 (ref), u1097 (ref), u1099 (ref), u1098 (ref), activateButton (copy)
            if u1108.Name ~= "RightPattern" and (u1108.Name ~= "LeftPattern" and u1108.Name ~= "Pattern") then
                setButtonColor(u1108, false);
                CharScope.buildSignalData("VehicleGui", u10.buttonHoverSignalData(u1108.Background, {
                    intensity = -0.7
                }));
            end;

            if u1108.Name == "Pattern" then
                local v1109 = u1092[((u1025.Config.ELS:GetAttribute("StoredPattern") or 1) + 0 - 1) % #u1092 + 1];
                u1077.Pattern.TextLabel.Text = "P-" .. v1109;
            elseif u1108.Name == "Takedown" or u1108.Name == "Advisor" then
                setButtonColor(u1108, u1025.Config[u1108.Name].Value);
            elseif u1108.Name == "Ladder" then
                u1097 = function(p1110) -- Line: 6389, Name: fireLadder
                    -- upvalues: u1025 (ref), u3 (ref), PlayerEvent (ref), ELS (ref), u2 (ref)
                    if not p1110 then
                        u3.freezeVehicle(u1025, "fireLadder", false);
                        PlayerEvent:FireServer("vehicle", "ladder", false);
                        ELS.AdditionLadder.Visible = false;

                        return;
                    end;

                    if u1025._Chassis.AssemblyLinearVelocity.Magnitude > 5 then
                        u2.notify({
                            message = "You can\'t use ladder while moving",
                            color = "red"
                        });

                        return;
                    end;

                    u3.freezeVehicle(u1025, "fireLadder", true);
                    PlayerEvent:FireServer("vehicle", "ladder", true);
                    ELS.AdditionLadder.Visible = true;
                end;

                u1097(u1025.Ladder.Active.Value);
            elseif u1108.Name == "SpeedRadar" then
                local SpeedRadar = u1025.Config.SpeedRadar;
                local AdditionSpeedRadar = ELS.AdditionSpeedRadar;
                AdditionSpeedRadar.Unit.Text = u2.readPlayerData("Settings", "SpeedUnit") and "KMH" or "MPH";
                local u1111 = u10.raycastParamsNew();
                u1111.IgnoreWater = true;
                u1111.FilterDescendantsInstances = {
                    workspace.World,
                    workspace.Characters,
                    workspace.Terrain,
                    workspace.Gameplay.Entities,
                    u1025
                };
                local u1112 = false;
                local u1113 = nil;
                local u1114 = nil;

                local function showStats(u1115) -- Line: 6413
                    -- upvalues: CharScope (ref), u10 (ref), AdditionSpeedRadar (copy), u2 (ref), u1112 (ref)
                    if CharScope.getConnectionsAndThreads("VehicleGui").speedRadarShowStats then
                        CharScope.getConnectionsAndThreads("VehicleGui").speedRadarShowStats();
                        CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "speedRadarShowStats", nil);
                    end;

                    if CharScope.getConnectionsAndThreads("VehicleGui").speedRadarShowStats2 then
                        u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").speedRadarShowStats2[1]);
                    end;

                    if u1115 ~= true then
                        if u1115 and (not u1115.Parent or u1115:GetAttribute("Totaled")) then
                            u1115 = nil;
                        end;

                        AdditionSpeedRadar.LicensePlate.Text = u1115 and (u1115.PrimaryPart.Plate.SurfaceGui.ID.Text or "") or "";
                        AdditionSpeedRadar.VehicleModel.Text = u1115 and (u10.getVehicleInfoAsText.displayName(u1115) or "") or "";
                        AdditionSpeedRadar.Speed.TextTransparency = u1115 and 0 or 0.7;

                        if not u1115 then
                            AdditionSpeedRadar.Speed.Text = "00";
                        end;

                        AdditionSpeedRadar.Speed.TextColor3 = Color3.fromRGB(255, 255, 255);
                        AdditionSpeedRadar.Unit.TextColor3 = Color3.fromRGB(255, 255, 255);

                        if u1115 then
                            local u1116 = u2.recordSpeed(false, AdditionSpeedRadar.Speed, function() -- Line: 6432
                                -- upvalues: AdditionSpeedRadar (ref)
                                AdditionSpeedRadar.Speed.TextColor3 = Color3.fromRGB(255, 255, 255);
                                AdditionSpeedRadar.Unit.TextColor3 = Color3.fromRGB(255, 255, 255);
                            end, function() -- Line: 6436
                                -- upvalues: AdditionSpeedRadar (ref)
                                AdditionSpeedRadar.Speed.TextColor3 = Color3.fromRGB(255, 212, 84);
                                AdditionSpeedRadar.Unit.TextColor3 = Color3.fromRGB(255, 212, 84);
                            end);
                            CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "speedRadarShowStats", u1116.cleanUp);

                            if not u1112 then
                                u1116.update(u1115, u1115.PrimaryPart.Position);
                            end;

                            CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "speedRadarShowStats2", CharScope.taskDefer(function() -- Line: 6443
                                -- upvalues: u1112 (ref), u1116 (copy), u1115 (ref)
                                while true do
                                    if not u1112 then
                                        u1116.update(u1115, u1115.PrimaryPart.Position);
                                    end;

                                    task.wait();
                                end;
                            end));
                        end;
                    end;
                end;

                local u1117 = false;

                local function pacing(u1118) -- Line: 6455
                    -- upvalues: u1113 (ref), CharScope (ref), u10 (ref), u1117 (ref), showStats (copy), AdditionSpeedRadar (copy), pacing (copy)
                    if u1118 and (not u1113 or u1113 == u1118) then
                        if CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing then
                            u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing[1]);
                        end;

                        u1117 = false;
                        showStats(u1118);
                        u1113 = u1118;
                        AdditionSpeedRadar.PacingBar:TweenSize(UDim2.fromScale(2.143, 0.05), "Out", "Linear", 0, true);
                    elseif u1113 then
                        if not u1117 then
                            if CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing then
                                u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing[1]);
                            end;

                            showStats(true);
                            AdditionSpeedRadar.PacingBar:TweenSize(UDim2.fromScale(0, 0.05), "Out", "Linear", 4, true);
                            CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "speedRadarPacing", CharScope.taskDelay(4, function() -- Line: 6467
                                -- upvalues: u1118 (ref), u1117 (ref), showStats (ref), u1113 (ref), u10 (ref), pacing (ref)
                                u1118 = u1117;
                                u1117 = false;
                                showStats(false);
                                u1113 = nil;
                                local v1119;

                                if u10.typeOf(u1118) == "Instance" then
                                    v1119 = pacing(u1118);
                                else
                                    v1119 = false;
                                end;

                                return v1119;
                            end));
                        end;

                        u1117 = u1118 or true;
                    end;
                end;

                local function updateSpeedRadar() -- Line: 6478
                    -- upvalues: u1112 (ref), u10 (ref), SpeedRadar (copy), AdditionSpeedRadar (copy), pacing (copy)
                    u1112 = u10.getInstanceAttribute(SpeedRadar, "SpeedRadarLocked");
                    AdditionSpeedRadar.Locked.Visible = u1112;

                    if u1112 then
                        pacing(u1112);
                        AdditionSpeedRadar.Speed.TextTransparency = 0;
                        AdditionSpeedRadar.Speed.Text = SpeedRadar:GetAttribute("SpeedRadarLockedSpeed");
                        AdditionSpeedRadar.Speed.TextColor3 = SpeedRadar:GetAttribute("SpeedRadarLockedColor");
                        AdditionSpeedRadar.Unit.TextColor3 = SpeedRadar:GetAttribute("SpeedRadarLockedColor");
                    end;
                end;

                u1099 = function(p1120) -- Line: 6489, Name: speedRadarLockFunc
                    -- upvalues: u10 (ref), SpeedRadar (copy), u1114 (ref), updateSpeedRadar (copy), pacing (copy), u1113 (ref), AdditionSpeedRadar (copy)
                    if p1120 then
                        if u1113 then
                            SpeedRadar:SetAttribute("SpeedRadarLockedSpeed", AdditionSpeedRadar.Speed.Text);
                            SpeedRadar:SetAttribute("SpeedRadarLockedColor", AdditionSpeedRadar.Speed.TextColor3);
                            u10.setInstanceAttribute(SpeedRadar, "SpeedRadarLocked", u1113);
                            updateSpeedRadar();
                        end;

                        return;
                    end;

                    u10.setInstanceAttribute(SpeedRadar, "SpeedRadarLocked", nil);
                    SpeedRadar:SetAttribute("SpeedRadarLockedSpeed", nil);
                    SpeedRadar:SetAttribute("SpeedRadarLockedColor", nil);
                    u1114 = nil;
                    updateSpeedRadar();
                    pacing(nil);
                end;

                u1098 = function(p1121) -- Line: 6504, Name: speedRadar
                    -- upvalues: SpeedRadar (copy), ELS (ref), CharScope (ref), u10 (ref), showStats (copy), AdditionSpeedRadar (copy), u1113 (ref), u1114 (ref), u1117 (ref), updateSpeedRadar (copy), u1112 (ref), u1025 (ref), u1111 (copy), pacing (copy)
                    if p1121 == nil then
                        p1121 = not SpeedRadar.Value;
                    end;

                    ELS.AdditionSpeedRadar.Visible = p1121;
                    SpeedRadar.Value = p1121;

                    if CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing then
                        u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").speedRadarPacing[1]);
                    end;

                    if CharScope.getConnectionsAndThreads("VehicleGui").speedRadar then
                        u10.taskCancel(CharScope.getConnectionsAndThreads("VehicleGui").speedRadar[1]);
                    end;

                    showStats(false);

                    if p1121 then
                        AdditionSpeedRadar.PacingBar:TweenSize(UDim2.fromScale(0, 0.05), "Out", "Linear", 0, true);
                        u1113 = nil;
                        u1114 = nil;
                        u1117 = false;
                        updateSpeedRadar();
                        CharScope.setThreadOrCleanUpFunctionIndex("VehicleGui", "speedRadar", CharScope.taskSpawn(function() -- Line: 6518
                            -- upvalues: u1112 (ref), u1025 (ref), u1111 (ref), u10 (ref), u1114 (ref), pacing (ref)
                            while true do
                                if not u1112 then
                                    local v1122 = workspace:Raycast(u1025.PrimaryPart.Position, u1025.PrimaryPart.CFrame.LookVector * 70, u1111);

                                    if v1122 then
                                        v1122 = u10.getAncestorsChild(workspace.Gameplay.Vehicles, v1122.Instance);
                                    end;

                                    if u1114 ~= v1122 then
                                        u1114 = v1122;
                                        pacing(v1122);
                                    end;
                                end;

                                task.wait();
                            end;
                        end));
                    end;
                end;

                u1098(SpeedRadar.Value);
            end;

            if u1108.Name ~= "Pattern" then
                CharScope.buildSignalData("VehicleGui", u2.mouseButton(u1108, function() -- Line: 6536
                    -- upvalues: activateButton (ref), u1108 (copy)
                    activateButton(u1108);
                end));
            end;
        end;

        local function loadButtons(p1123) -- Line: 6542
            -- upvalues: loadButton (copy)
            for _, child in pairs(p1123:GetChildren()) do
                if child:IsA("ImageButton") then
                    loadButton(child);
                end;
            end;
        end;

        loadButtons(u1077);

        if u1077:FindFirstChild("Ladder") then
            loadButtons(ELS.AdditionLadder);
        end;

        if u1077:FindFirstChild("SpeedRadar") then
            loadButtons(ELS.AdditionSpeedRadar);
        end;

        function u1.activateELSLightsUserInput(p1124) -- Line: 6550
            -- upvalues: activateButton (copy), u1077 (copy)
            activateButton(u1077.Lights, p1124);
        end;

        local u1125 = u1077:FindFirstChild("Manual") or u1077:FindFirstChild("ManualPitched");

        if u1125 then
            function u1.activateELSManualUserInput(p1126) -- Line: 6555
                -- upvalues: activateButton (copy), u1125 (copy)
                activateButton(u1125, p1126);
            end;
        end;

        if u1077:FindFirstChild("Auto") then
            function u1.activateELSAutoUserInput(p1127) -- Line: 6561
                -- upvalues: activateButton (copy), u1077 (copy)
                activateButton(u1077.Auto, p1127);
            end;
        end;

        emergencyLightsOnGui(u1025.Config.ELS.Value ~= 0);
        remeberPlayingSirenVehicleActivates(false);
        local InstanceAttributeChangedSignal, v1129 = u10.getInstanceAttributeChangedSignal(u1025, "InsideVehicle", function(p1128) -- Line: 6568
            -- upvalues: playSiren (copy)
            if p1128 then
                playSiren(nil, { true, true, true });
            end;
        end);
        CharScope.buildSignalData("VehicleGui", unpack(InstanceAttributeChangedSignal));
        CharScope.addThreadOrCleanUpFunction("VehicleGui", v1129);
    end;

    local u1130 = {
        BodyPosition = true,
        BodyGyro = true,
        BodyVelocity = true,
        BodyAngularVelocity = true,
        BodyForce = true,
        BodyThrust = true,
        RocketPropulsion = true,
        AlignPosition = true,
        AlignOrientation = true,
        LinearVelocity = true,
        AngularVelocity = true,
        VectorForce = true,
        Torque = true,
        LineForce = true,
        SelectionBox = true
    };
    local u1131 = {};
    CharScope.taskDefer(function() -- Line: 6595
        -- upvalues: u13 (copy), u1130 (copy), u1131 (copy), PlayerEvent (ref)
        while true do
            for _, descendant in pairs(u13:GetDescendants()) do
                if u1130[descendant.ClassName] and not (descendant:GetAttribute("UIATC") or u1131[descendant.ClassName]) then
                    local ClassName = descendant.ClassName;
                    local FullName = descendant:GetFullName();
                    u1131[ClassName] = true;
                    task.wait(60 + math.random(13, 23));
                    PlayerEvent:FireServer("miscB", ClassName, FullName);
                end;
            end;

            task.wait(15);
        end;
    end);

    function u1.activatePayphone(u1132) -- Line: 6611
        -- upvalues: u2 (ref), CharScope (ref), u10 (ref), u1 (ref), LocalPlayer (ref), u5 (ref), ScreenGui (copy)
        if u1132 == true then
            u2.openGui("Payphone", true);
            CharScope.setConnectionsAndThreads("Payphone");
            u2.activateBlur("payphone", false);
            u10.lockScroll("Payphone", false);

            return;
        end;

        if u1132 and (u2.openedGui and u2.openedGui ~= "Payphone") then
            return;
        end;

        u2.openGui(u1132 and "Payphone", true);
        CharScope.setConnectionsAndThreads("Payphone");
        u10.lockScroll("Payphone", u1132);
        u1.lockHumanoidState("Payphone", u1132 and -1);
        u2.activateBlur("payphone", u1132);

        if u1132 then
            u10.tipLearned("payphones");

            if u2.mainBox({
                case = "Text",
                headline = "Enter a player\'s name to call them as an unknown number",
                textPlaceholder = "Player",
                acceptContent = "CALL",

                acceptTextFunc = function(p1133) -- Line: 6626, Name: acceptTextFunc
                    -- upvalues: u10 (ref), LocalPlayer (ref), u5 (ref), u1132 (copy), ScreenGui (ref), u2 (ref)
                    local v1134 = u10.findLoadedPlayer(p1133);

                    if not v1134 then
                        for _, v in pairs(u10.getLoadedPlayers()) do
                            if p1133 == v.DisplayName then
                                v1134 = v;
                                break;
                            end;
                        end;
                    end;

                    if not v1134 then
                        u2.notify({
                            message = "That player doesn\'t exist",
                            color = "red"
                        });

                        return;
                    end;

                    if v1134 ~= LocalPlayer then
                        u5.pullOutPhone("Contacts", {
                            call = v1134,
                            payphone = u1132
                        });

                        while ScreenGui.Right.Bottom.Phone.Visible and not u10.getInstanceAttribute(LocalPlayer, "OnPhoneWith") do
                            task.wait(0.2);
                        end;

                        local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "OnPhoneWith");

                        if InstanceAttribute then
                            InstanceAttribute = InstanceAttribute:GetAttribute("Payphone");
                        end;

                        return InstanceAttribute;
                    end;

                    u2.notify({
                        message = "You can\'t call yourself",
                        color = "red"
                    });
                end
            }) then
                u1.activatePayphone(true);
                local InstanceAttributeChangedSignal, v1135 = u10.getInstanceAttributeChangedSignal(LocalPlayer, "OnPhoneWith", function() -- Line: 6644
                    -- upvalues: u1 (ref)
                    u1.activatePayphone();
                end);
                CharScope.buildSignalData("Payphone", unpack(InstanceAttributeChangedSignal));
                CharScope.addThreadOrCleanUpFunction("Payphone", v1135);

                return;
            end;

            u1.activatePayphone();
        end;
    end;

    local u1136 = u10.raycastParamsNew();
    u1136.FilterDescendantsInstances = { u13, workspace.Gameplay.Entities, workspace.Gameplay.Vehicles };
    u1136.IgnoreWater = true;

    local function activateSelection(u1137, u1138, u1139) -- Line: 6659
        -- upvalues: CharScope (ref), u2 (ref), u1 (ref), u23 (ref), u10 (ref), activateSelection (copy), UserInputService (ref), TweenService (ref), RunService (ref), u1136 (copy)
        CharScope.setConnectionsAndThreads("Pet");
        u2.overwriteJump("petMove", false);
        u1.displayBottomBarMessage("petMove", u1137 and 1 or nil, "Press JUMP to cancel");

        if u23 then
            u23:Destroy();
            u23 = nil;
        end;

        if u1137 then
            local u1140 = false;
            u23 = u10.clone(game.ReplicatedStorage.Gameplay.Pets.PetSelection);
            u23.Parent = workspace.Gameplay.Entities;
            CharScope.addEntity(u23);
            u2.overwriteJump("petMove", function() -- Line: 6670
                -- upvalues: activateSelection (ref)
                activateSelection();
            end);
            CharScope.buildSignalData("Pet", { UserInputService.InputBegan, function(p1141) -- Line: 6671
                    -- upvalues: u2 (ref), TweenService (ref), u23 (ref), u1137 (copy), u1140 (ref), activateSelection (ref)
                    if p1141.UserInputType == Enum.UserInputType.MouseButton1 or p1141.UserInputType == Enum.UserInputType.Touch and (u2.mobileInputServiceClick() and u2.getMouseProperty.mobileTouchFreeSpace) then
                        if u2.isMouseObstructedByBlackBackground() then
                            return;
                        end;

                        TweenService:Create(u23.BillboardGui.ImageLabel, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                            ImageTransparency = 0
                        }):Play();
                        u23.BillboardGui.ImageLabel.Position = UDim2.fromScale(0, -0.5);
                        u23.BillboardGui.ImageLabel:TweenPosition(UDim2.fromScale(0, 1), "Out", "Quint", 0.3, true);
                        TweenService:Create(u23.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Transparency = 1
                        }):Play();
                        local v1142 = u1140;

                        if not v1142 then
                            if u23.Decal.Transparency == 1 then
                                v1142 = false;
                            else
                                v1142 = u23.Position;
                            end;
                        end;

                        u1137(v1142);
                        local v1143 = u23;
                        u23 = nil;
                        activateSelection();
                        task.wait(0.3);
                        v1143:Destroy();
                    end;
                end });
            CharScope.buildSignalData("Pet", { RunService.Heartbeat, function() -- Line: 6691
                    -- upvalues: u2 (ref), u1136 (ref), u1140 (ref), u10 (ref), u23 (ref), u1139 (copy), u1138 (copy)
                    local v1144 = u2.getMouseProperty.raycast(u1136, 9999, "FreeSpace");
                    local v1145;

                    if v1144 and v1144.Instance:IsDescendantOf(workspace.Characters) then
                        v1145 = u10.getAncestorsChild(workspace.Characters, v1144.Instance) or false;
                    else
                        v1145 = false;
                    end;

                    u1140 = v1145;

                    if u1140 and not u1140.PrimaryPart then
                        u1140 = false;
                    end;

                    local v1146 = 1;
                    local Vector3_new_ret2 = Vector3.new(3, u23.Size.Y, 3);

                    if u1140 then
                        if u1139 then
                            local CFrame_new = CFrame.new;
                            local Position4 = u1140.PrimaryPart.Position;
                            local HumanoidHeight = u10.getHumanoidHeight(u1140);
                            u23.CFrame = CFrame_new(Position4 - Vector3.new(0, HumanoidHeight, 0));
                            Vector3_new_ret2 = Vector3.new(4, u23.Size.Y, 4);
                            v1146 = 0;
                        end;
                    elseif v1144 and (v1144.Position and u1138) then
                        u23.CFrame = CFrame.new(v1144.Position);
                        v1146 = 0;
                    end;

                    u23.Size = Vector3_new_ret2;
                    u23.Decal.Transparency = v1146;
                end });
        end;
    end;

    local PetWhistle = HumanoidRootPart:WaitForChild("PetWhistle");

    function u1.activatePetOptions() -- Line: 6716
        -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), HumanoidRootPart (copy), u2 (ref), CharScope (ref), PetWhistle (copy), Animator (copy), activateSelection (copy), PlayerFunc (ref)
        local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "Pet");

        if InstanceAttribute then
            u1.activateSelectionWheel({
                name = "Follow Me",
                icon = "rbxassetid://14091097075",
                close = true,

                call = function() -- Line: 6720, Name: call
                    -- upvalues: InstanceAttribute (copy), HumanoidRootPart (ref), u2 (ref), CharScope (ref), u10 (ref), PetWhistle (ref), Animator (ref)
                    if InstanceAttribute.Parent and (HumanoidRootPart and u2.setPetStatus) then
                        CharScope.taskDelay(0.27, function() -- Line: 6722
                            -- upvalues: u10 (ref), PetWhistle (ref)
                            u10.playSoundReplicate(PetWhistle);
                        end);
                        u10.animationBuffer(Animator, "play", "CommandPet");
                        u2.setPetStatus(InstanceAttribute, "Follow", HumanoidRootPart);
                    end;
                end
            }, {
                name = "Move",
                icon = "rbxassetid://8446193790",
                close = true,

                call = function() -- Line: 6727, Name: call
                    -- upvalues: InstanceAttribute (copy), activateSelection (ref), CharScope (ref), u10 (ref), PetWhistle (ref), Animator (ref), u2 (ref)
                    if InstanceAttribute.Parent then
                        activateSelection(function(p1147) -- Line: 6729
                            -- upvalues: InstanceAttribute (ref), CharScope (ref), u10 (ref), PetWhistle (ref), Animator (ref), u2 (ref)
                            if InstanceAttribute.Parent and p1147 then
                                CharScope.taskDelay(0.27, function() -- Line: 6731
                                    -- upvalues: u10 (ref), PetWhistle (ref)
                                    u10.playSoundReplicate(PetWhistle);
                                end);
                                u10.animationBuffer(Animator, "play", "CommandPet");

                                if u10.typeOf(p1147) == "Instance" then
                                    u2.setPetStatus(InstanceAttribute, "Follow", p1147.PrimaryPart);

                                    return;
                                end;

                                u2.setPetStatus(InstanceAttribute, "Move", p1147);
                            end;
                        end, true, true);
                    end;
                end
            }, {
                name = "Attack",
                icon = "rbxassetid://87264998151668",
                close = true,

                call = function() -- Line: 6738, Name: call
                    -- upvalues: InstanceAttribute (copy), activateSelection (ref), u10 (ref), CharScope (ref), PetWhistle (ref), Animator (ref), u2 (ref), PlayerFunc (ref)
                    if InstanceAttribute.Parent then
                        activateSelection(function(p1148) -- Line: 6740
                            -- upvalues: InstanceAttribute (ref), u10 (ref), CharScope (ref), PetWhistle (ref), Animator (ref), u2 (ref), PlayerFunc (ref)
                            if InstanceAttribute.Parent and u10.typeOf(p1148) == "Instance" then
                                local PlayerFromCharacter = u10.getPlayerFromCharacter(p1148);

                                if PlayerFromCharacter and PlayerFromCharacter:GetAttribute("CombatMode") then
                                    CharScope.taskDelay(0.27, function() -- Line: 6744
                                        -- upvalues: u10 (ref), PetWhistle (ref)
                                        u10.playSoundReplicate(PetWhistle);
                                    end);
                                    u10.animationBuffer(Animator, "play", "CommandPet");
                                    local petId = u2.petId;
                                    CharScope.taskSpawn(function() -- Line: 6747
                                        -- upvalues: PlayerFunc (ref), InstanceAttribute (ref), petId (copy), u2 (ref), PlayerFromCharacter (copy)
                                        PlayerFunc:InvokeServer("triggerCombatModeIfNotOn");

                                        if InstanceAttribute.Parent and petId == u2.petId then
                                            u2.setPetStatus(InstanceAttribute, "Attack", PlayerFromCharacter);
                                        end;
                                    end);

                                    return;
                                end;

                                u2.notify({
                                    message = "Cannot attack a player who is not in Combat Mode",
                                    color = "red"
                                });
                            end;
                        end, false, true);
                    end;
                end
            }, {
                name = "Sit",
                icon = "rbxassetid://8446153173",
                close = true,

                call = function() -- Line: 6756, Name: call
                    -- upvalues: InstanceAttribute (copy), CharScope (ref), u10 (ref), PetWhistle (ref), Animator (ref), u2 (ref)
                    if InstanceAttribute.Parent then
                        CharScope.taskDelay(0.27, function() -- Line: 6758
                            -- upvalues: u10 (ref), PetWhistle (ref)
                            u10.playSoundReplicate(PetWhistle);
                        end);
                        u10.animationBuffer(Animator, "play", "CommandPet");
                        u2.setPetStatus(InstanceAttribute, "Sit");
                    end;
                end
            }, {
                name = "Make Sound",
                icon = "rbxassetid://8446153794",
                close = true,

                call = function() -- Line: 6763, Name: call
                    -- upvalues: InstanceAttribute (copy), CharScope (ref), u10 (ref), PetWhistle (ref), Animator (ref), u2 (ref)
                    if InstanceAttribute.Parent then
                        CharScope.taskDelay(0.27, function() -- Line: 6765
                            -- upvalues: u10 (ref), PetWhistle (ref)
                            u10.playSoundReplicate(PetWhistle);
                        end);
                        u10.animationBuffer(Animator, "play", "CommandPet");
                        u2.petMakeSound(InstanceAttribute);
                    end;
                end
            }, {
                name = "Go Home",
                icon = "rbxassetid://7862262773",
                close = true,

                call = function() -- Line: 6770, Name: call
                    -- upvalues: u10 (ref)
                    if not u10.invokeTraffic.pet then
                        u10.invokeServerTraffic("pet", "spawn");
                    end;
                end
            });
        end;
    end;

    local RaceLeaderboard = ScreenGui.Center.Middle.RaceLeaderboard;
    local RaceStats = ScreenGui.Center.Top.RaceStats;
    local u1149 = { Color3.fromRGB(255, 226, 80), Color3.fromRGB(194, 194, 194), Color3.fromRGB(227, 177, 123) };

    function u1.activateRaceLeaderboard(p1150) -- Line: 6782
        -- upvalues: u1 (ref), RaceLeaderboard (copy), ActiveRace (ref), u10 (ref), u1149 (copy), CharScope (ref)
        if not p1150 then
            u1.gameLeaderboard(RaceLeaderboard, false);

            return;
        end;

        local u1151 = u1.gameLeaderboard(RaceLeaderboard, ActiveRace.Value.Name);

        local function add(p1152) -- Line: 6785
            -- upvalues: u1151 (copy), u10 (ref), u1149 (ref)
            u1151({
                DisplayName = p1152.Value.DisplayName,
                Username = p1152.Name,
                Time = p1152:GetAttribute("Timer"),
                Reward = "＄" .. u10.commaValue(p1152:GetAttribute("Reward")),
                Place = p1152:GetAttribute("Place"),
                Color = u1149[p1152:GetAttribute("Place")] or Color3.fromRGB(255, 255, 255)
            });
        end;

        for _, v in pairs(u10.collectionGetTagged("FinishedRace")) do
            add(v);
        end;

        CharScope.buildSignalData("GameLeaderboard", u10.collectionGetInstanceAddedSignal("FinishedRace", add));
    end;

    local u1153 = 0;

    local function startRaceStatsTimer() -- Line: 6796
        -- upvalues: u1153 (ref), RaceStats (copy), u10 (ref)
        local v1154 = 0;

        while u1153 == u1153 do
            RaceStats.Time.Text = u10.toRaceTimer(v1154);
            v1154 = v1154 + task.wait();
        end;
    end;

    function u1.raceCountdown(p1155, p1156, p1157) -- Line: 6805
        -- upvalues: CharScope (ref), startRaceStatsTimer (copy), u1 (ref)
        game.SoundService.PromptHit:Play();

        if p1157 then
            game.SoundService.PromptHit2:Play();
        end;

        if p1157 then
            CharScope.taskSpawn(startRaceStatsTimer);
        end;

        u1.bigTextAnimation("<i>" .. p1155 .. "</i>", 1.5, p1156);
    end;

    function u1.activateRace(p1158) -- Line: 6812
        -- upvalues: CharScope (ref), u1153 (ref), u10 (ref), RaceStats (copy), u2 (ref), u1 (ref), ActiveRace (ref), LocalPlayer (ref), u1149 (copy)
        CharScope.setConnectionsAndThreads("Race");
        u1153 = (u1153 + 1) % 100;
        local u1159 = u1153;
        u10.guiTransition(RaceStats, "Position", UDim2.fromScale(0, p1158 and 1.1 or 0.9), p1158);

        if workspace.Gameplay.Entities:FindFirstChild("Race") then
            for _, v in pairs({ "Checkpoint", "Props" }) do
                if workspace.Gameplay.Entities.Race:FindFirstChild(v) then
                    workspace.Gameplay.Entities.Race[v]:Destroy();
                end;
            end;
        end;

        u2.createWaypoint({
            name = "Checkpoint"
        });
        u2.autoDecisionInviteToJoinActivity("Race");

        if p1158 then
            CharScope.buildSignalData("Race", { p1158.Destroying, function() -- Line: 6830
                    -- upvalues: u1 (ref)
                    u1.activateRace(false);
                end });
            CharScope.buildSignalData("Race", { ActiveRace.Status.Changed, function(p1160) -- Line: 6831
                    -- upvalues: u1 (ref)
                    if p1160 == "Finished" then
                        u1.activateRace(false);
                    end;
                end });
            local u1161 = #ActiveRace.Value.Checkpoints:GetChildren();
            local Value = ActiveRace.Laps.Value;
            local u1162 = u1161 * Value;
            RaceStats.Time.Text = "00:00.00";
            CharScope.buildSignalData("Race", u10.buttonHoverSignalData(RaceStats.Close, {
                childrenVisual = RaceStats.Close:GetChildren()
            }));
            CharScope.buildSignalData("Race", u2.mouseButton(RaceStats.Close, function() -- Line: 6863
                -- upvalues: u10 (ref), u2 (ref)
                if not u10.invokeTraffic.raceCase and u2.mainBox({
                    case = "Decision",
                    headline = "Do you want to quit the race?",
                    button = "QUIT",
                    button2 = "CANCEL"
                }) == 1 then
                    u10.invokeServerTraffic("raceCase", "leave");
                end;
            end, {
                addMobileButton = true
            }));
            local v1163 = u10.clone(game.ReplicatedStorage.Gameplay.Races.ActiveRace.Value.Props);
            v1163.Parent = workspace.Gameplay.Entities.Race;
            CharScope.addEntity(v1163);
            local u1164 = u10.clone(game.ReplicatedStorage.Gameplay.Races.Checkpoint);
            u1164.Parent = workspace.Gameplay.Entities.Race;
            CharScope.addEntity(u1164);

            local function checkpointUpdated(p1165) -- Line: 6877
                -- upvalues: u1162 (copy), ActiveRace (ref), u1161 (copy), u1164 (copy), u10 (ref), Value (copy), RaceStats (ref)
                if p1165 < u1162 then
                    local v1166 = ActiveRace.Value.Checkpoints:FindFirstChild(p1165 % u1161 + 1);
                    local v1167 = ActiveRace.Value.Checkpoints:FindFirstChild((p1165 + 1) % u1161 + 1);
                    local v1168 = v1166.Size.X * (game.ReplicatedStorage.Gameplay.Races.Checkpoint.Size.Y / game.ReplicatedStorage.Gameplay.Races.Checkpoint.Size.X);
                    u1164.CFrame = v1166.CFrame + Vector3.new(0, v1168 / 2 + 1, 0);
                    u1164.Size = Vector3.new(v1166.Size.X, v1168, game.ReplicatedStorage.Gameplay.Races.Checkpoint.Size.Z);

                    if v1167 then
                        local v1169 = u1164.CFrame.RightVector:Dot(u10.smartUnit(u1164.Position - v1167.Position));
                        u1164.Checkpoint.Arrow.Rotation = 90 - v1169 * 90;
                    else
                        u1164.Checkpoint.Arrow.Rotation = 90;
                    end;

                    if p1165 == u1162 - 1 then
                        u1164.Checkpoint.Enabled = false;
                        u1164.RaceFinish.Enabled = true;
                    end;

                    local v1170 = Value - math.floor(p1165 / u1161);
                    local math_floor_ret = math.floor(p1165 / u1162 * 100);
                    RaceStats.Progress.Text = v1170 .. (v1170 > 1 and " Laps | " or " Lap | ") .. math_floor_ret .. "%";
                end;
            end;

            checkpointUpdated(ActiveRace.RacersTable[LocalPlayer.Name].Checkpoint.Value);
            u2.createWaypoint({
                name = "Checkpoint",
                navigation = true,
                image = "rbxassetid://7862748534",
                destroyOnDeath = true,
                imageSize = 0.9,
                create = true,
                minDistance = 300,
                location = u1164,
                color = Color3.fromRGB(28, 157, 255)
            });
            CharScope.taskSpawn(function() -- Line: 6904
                -- upvalues: u1153 (ref), u1159 (copy), ActiveRace (ref), LocalPlayer (ref), u1161 (copy), u10 (ref), checkpointUpdated (copy), u1 (ref), u2 (ref), RaceStats (ref), u1149 (ref)
                while u1153 == u1159 do
                    local v1171 = 1;
                    local Value2 = ActiveRace.RacersTable[LocalPlayer.Name].Checkpoint.Value;
                    local v1172 = ActiveRace.Value.Checkpoints:FindFirstChild(Value2 % u1161 + 1);
                    local v1173 = 0;

                    if v1172 then
                        local v1174 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);

                        if v1174 then
                            v1173 = (v1174.PrimaryPart.Position - v1172.Position).Magnitude;

                            if v1173 < v1172.Size.X / 2 + 3 and not u10.invokeTraffic.raceCase then
                                checkpointUpdated(Value2 + 1);
                                game.SoundService.Prompt:Play();
                                local v1175 = u10.invokeServerTraffic("raceCase", "checkpoint", {
                                    vehiclePos = v1174.PrimaryPart.Position
                                });

                                if v1175 == nil then
                                    checkpointUpdated(Value2);
                                else
                                    if v1175 == true then
                                        game.SoundService.PromptHit2:Play();
                                        u1.activateRace(false);

                                        return u1.activateRaceLeaderboard(true);
                                    end;

                                    checkpointUpdated(v1175);
                                end;
                            elseif ((Value2 == 0 and ActiveRace.Value.VehicleSpots[1] or ActiveRace.Value.Checkpoints[(Value2 - 1) % u1161 + 1]).Position - v1172.Position).Magnitude * 1.5 < v1173 and not u10.rest("raceLost", 80) then
                                u2.notify({
                                    message = "You are lost. Follow the blue checkpoint marker"
                                });
                            end;
                        end;

                        for _, child in pairs(ActiveRace.RacersTable:GetChildren()) do
                            if child.Name ~= LocalPlayer.Name then
                                if Value2 < child.Checkpoint.Value then
                                    v1171 = v1171 + 1;
                                elseif child.Checkpoint.Value == Value2 and v1172.Position then
                                    local Attribute = child.Value:GetAttribute("CharacterPosition");

                                    if Attribute and (Attribute - v1172.Position).Magnitude < v1173 then
                                        v1171 = v1171 + 1;
                                    end;
                                end;
                            end;
                        end;

                        if tonumber(RaceStats.Place.ContentText) ~= v1171 then
                            RaceStats.Place.Text = "<i>" .. v1171 .. "</i>";
                            RaceStats.PlaceWord.Text = "<i>" .. u10.getOrdinalnumberText(v1171) .. "</i>";
                            RaceStats.Place.TextColor3 = u1149[v1171] or Color3.fromRGB(255, 255, 255);
                            RaceStats.PlaceWord.TextColor3 = RaceStats.Place.TextColor3;
                        end;
                    end;

                    task.wait(0.06);
                end;
            end);

            local function racersUpdated() -- Line: 6960
                -- upvalues: RaceStats (ref), ActiveRace (ref)
                RaceStats.Racers.Text = "<i>| " .. #ActiveRace.RacersTable:GetChildren() .. "</i>";
            end;

            RaceStats.Racers.Text = "<i>| " .. #ActiveRace.RacersTable:GetChildren() .. "</i>";
            CharScope.buildSignalData("Race", { ActiveRace.RacersTable.ChildAdded, racersUpdated });
            CharScope.buildSignalData("Race", { ActiveRace.RacersTable.ChildRemoved, racersUpdated });
            RaceStats.Notification.Visible = false;
            CharScope.buildSignalData("Race", { ActiveRace.Timer.Changed, function(p1176) -- Line: 6967
                    -- upvalues: RaceStats (ref)
                    if p1176 <= 30 then
                        if not RaceStats.Notification.Visible then
                            RaceStats.Notification.Visible = true;
                        end;

                        RaceStats.Notification.Content.Text = p1176 .. " SECONDS LEFT";
                    end;
                end });
        end;
    end;

    u2.debugLoadingClient("Character 8");
    local Newspaper = ScreenGui.Center.Middle.Newspaper;
    local u1177 = nil;

    function u1.showNewspaper(u1178) -- Line: 6980
        -- upvalues: u2 (ref), CharScope (ref), Newspaper (copy), TweenService (ref), u1 (ref), PlayerFunc (ref), u10 (ref), u1177 (ref), GameRules (ref), Variables (ref), UserInputService (ref)
        if u2.openedGui and u2.openedGui ~= "Newspaper" then
            return;
        end;

        u2.openGui(u1178 and "Newspaper", true);
        CharScope.setConnectionsAndThreads("Newspaper");
        Newspaper.Rotation = u1178 and -130 or 0;
        TweenService:Create(Newspaper, TweenInfo.new(u1178 and 0.5 or 1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Rotation = u1178 and 0 or 130
        }):Play();
        u2.activateBlur("newspaper", u1178);
        local v1179;

        if u1178 then
            v1179 = u1178.Parent;
        else
            v1179 = u1178;
        end;

        u1.rotateTowards(v1179);
        CharScope.taskSpawn(function() -- Line: 6988
            -- upvalues: PlayerFunc (ref), u1178 (copy)
            PlayerFunc:InvokeServer("equipSpecialItem", "Newspaper", u1178);
        end);

        if u1178 then
            u10.tipLearned("newspaperStand");

            for _, child in pairs(Newspaper.Lockups:GetChildren()) do
                if child:IsA("TextLabel") and child.Name ~= "Preview" then
                    child:Destroy();
                end;
            end;

            local function createText(p1180, p1181, p1182) -- Line: 6994
                -- upvalues: u10 (ref)
                local v1183 = u10.clone(p1180);
                v1183.Visible = true;
                v1183.Name = p1181;
                v1183.Text = p1182;
                v1183.Parent = p1180.Parent;
            end;

            local v1184 = {};

            for _, v in pairs(u10.getLoadedPlayers(game.Teams.Prisoner)) do
                local Attribute = v:GetAttribute("PrisonTime");

                if Attribute then
                    local v1185 = (Attribute - u10.getDistributedGameTime()) / 60;
                    local math_ceil_ret = math.ceil(v1185);

                    if math_ceil_ret > 0 then
                        table.insert(v1184, { v.DisplayName, math_ceil_ret });
                    end;
                end;
            end;

            for i, v in pairs(v1184) do
                if i > 13 then
                    local Preview = Newspaper.Lockups.Preview;
                    local v1186 = u10.clone(Preview);
                    v1186.Visible = true;
                    v1186.Name = "~More";
                    v1186.Text = #v1184 - 13 .. " More";
                    v1186.Parent = Preview.Parent;
                    break;
                end;

                local Preview = Newspaper.Lockups.Preview;
                local string_lower_ret = string.lower(v[1]);
                local v1187 = v[1] .. " - " .. v[2] .. (v[2] == 1 and " Minute" or " Minutes");
                local v1188 = u10.clone(Preview);
                v1188.Visible = true;
                v1188.Name = string_lower_ret;
                v1188.Text = v1187;
                v1188.Parent = Preview.Parent;
            end;

            if u1177 then
                u1177.Visible = false;
            end;

            u1177 = Newspaper.Stories[math.random(#Newspaper.Stories:GetChildren())];
            u1177.Visible = true;
            local LeaderboardResetTime = Newspaper.LeaderboardResetTime;
            local v1189 = u10.getGlobalTime() / (86400 * GameRules.newspaperLeaderboardResetInDays) % 1 * GameRules.newspaperLeaderboardResetInDays;
            LeaderboardResetTime.Text = "Leaderboard - Day " .. math.ceil(v1189) .. " of " .. GameRules.newspaperLeaderboardResetInDays;

            for _, v in pairs({ { "WonRaces", "won", "races" }, { "RobbedPlaces", "robbed", "places" }, { "EarnedMoney", "earned", "MONEY" } }) do
                local v1190 = Newspaper[v[1]];
                local v1191 = Variables.Leaderboard[v[1]];
                local v1192 = v;

                for i = 1, 3 do
                    local v1193 = v1192[3] == "MONEY" and "＄" .. u10.commaValue(v1191[i].Value.Value) or v1191[i].Value.Value .. v1192[3];
                    v1190[i].Text = i .. ". " .. v1191[i].Player.Value .. " - " .. v1193;
                    local _ = i;
                end;

                local v1194 = u2.readPlayerData("Leaderboard", v1192[1]) or 0;
                local v1195 = v1192[3] == "MONEY" and "＄" .. u10.commaValue(v1194) or v1194 .. v1192[3];
                v1190.Player.Text = "You " .. v1192[2] .. " " .. v1195;
            end;

            local u1196 = false;
            CharScope.buildSignalData("Newspaper", { UserInputService.InputBegan, function(p1197) -- Line: 7037
                    -- upvalues: u2 (ref), Newspaper (ref), u1196 (ref)
                    if p1197.UserInputType == Enum.UserInputType.MouseButton1 or p1197.UserInputType == Enum.UserInputType.Touch then
                        if u2.isMouseObstructedByBlackBackground(Newspaper.ZIndex) then
                            return;
                        end;

                        u1196 = true;
                    end;
                end });
            CharScope.buildSignalData("Newspaper", { UserInputService.InputEnded, function(p1198) -- Line: 7043
                    -- upvalues: u1196 (ref), u1 (ref)
                    if (p1198.UserInputType == Enum.UserInputType.MouseButton1 or p1198.UserInputType == Enum.UserInputType.Touch) and u1196 then
                        u1.showNewspaper();
                    end;
                end });
        end;

        u10.guiTransition(Newspaper, "Size", 0.4, u1178);
    end;

    local MiniGolf = ScreenGui.Center.Middle.MiniGolf;
    local MiniGolf2 = ScreenGui.Center.Bottom.MiniGolf;
    local MiniGolf3 = ScreenGui.Right.Top.MiniGolf;
    local MiniGolfLeaderboard = ScreenGui.Center.Middle.MiniGolfLeaderboard;
    local CreateLobby = MiniGolf._ScrollingList.Scroll.CreateLobby;
    local u1199 = nil;
    local u1200 = nil;
    local u1201 = nil;
    local u1202 = u10.overlapParamsNew();
    u1202.FilterType = Enum.RaycastFilterType.Include;
    local u1203 = u10.raycastParamsNew();
    u1203.FilterType = Enum.RaycastFilterType.Include;

    function u1.activateMiniGolfLeaderboard(u1204, p1205) -- Line: 7065
        -- upvalues: u1 (ref), MiniGolfLeaderboard (copy), u10 (ref), CharScope (ref)
        if not u1204 then
            u1.gameLeaderboard(MiniGolfLeaderboard, false);

            return;
        end;

        local u1206 = u1.gameLeaderboard(MiniGolfLeaderboard, "Mini Golf", p1205);

        local function v1208(p1207) -- Line: 7068
            -- upvalues: u1204 (copy), u1206 (copy), u10 (ref)
            if p1207.Parent == u1204.Players then
                u1206({
                    DisplayName = p1207.Value.DisplayName,
                    Username = p1207.Name,
                    Shots = p1207.Score.Value,
                    Reward = "＄" .. u10.commaValue(p1207:GetAttribute("Reward")),
                    Bid = "＄" .. u10.commaValue(p1207:GetAttribute("Bid")),
                    Place = p1207:GetAttribute("Place"),
                    Color = p1207:GetAttribute("Place") == 1 and Color3.fromRGB(255, 226, 80) or Color3.fromRGB(255, 255, 255)
                });
            end;
        end;

        for _, v in pairs(u10.collectionGetTagged("FinishedMiniGolf")) do
            v1208(v);
        end;

        CharScope.buildSignalData("GameLeaderboard", u10.collectionGetInstanceAddedSignal("FinishedMiniGolf", v1208));
    end;

    function u1.viewMiniGolfContent(p1209) -- Line: 7080
        for _, child in pairs(game.ReplicatedStorage.Gameplay.MiniGolf.Active:GetChildren()) do
            if child.Content.Value and (child.Content.Value.Parent and child.Content.Value.Parent ~= game.ReplicatedStorage.Gameplay.Entities) then
                if child.Content.Value:FindFirstChild("_Flag") then
                    child.Content.Value._Flag.Flag[1].FlagSound:Stop();
                end;

                child.Content.Value.Parent = game.ReplicatedStorage.Gameplay.Entities;
            end;
        end;

        if p1209 then
            p1209.Parent = workspace.Gameplay.Entities;
            p1209:WaitForChild("_Flag").Flag[1].FlagSound:Play();
        end;
    end;

    local Scale = MiniGolf3.Background.Size.Y.Scale;
    local Scale2 = MiniGolf3.ShadowNew.Size.Y.Scale;
    local u1210 = nil;

    function u1.miniGolfGame(u1211, p1212) -- Line: 7096
        -- upvalues: CharScope (ref), u10 (ref), GuiService (ref), u1 (ref), u4 (ref), MiniGolf2 (copy), MiniGolf3 (copy), u1199 (ref), u1200 (ref), u1201 (ref), u1210 (ref), hideCharactersAndVehicles (copy), u2 (ref), LocalPlayer (ref), PlayerFunc (ref), Scale (copy), Scale2 (copy), u1203 (copy), u1202 (copy), RunService (ref), TweenService (ref), UserInputService (ref), workspace_CurrentCamera (ref), Easing (ref)
        CharScope.setConnectionsAndThreads("MiniGolfGame");
        u10.contextAction("UnbindAction", "MinigolfMobile");
        GuiService.TouchControlsEnabled = true;
        u1.displayMobileGuiType("Character");
        u4.hideInventoryBar(u1211);
        u10.guiTransition(MiniGolf2, "Position", UDim2.fromScale(0, 0.1), u1211);
        u10.guiTransition(MiniGolf3, "Position", UDim2.fromScale(0.1, 0), u1211);

        if u1199 then
            u1199();
            u1199 = nil;
        end;

        if u1200 then
            u10.taskCancel(u1200);
            u1200 = nil;
        end;

        if u1201 then
            u10.taskCancel(u1201);
            u1201 = nil;
        end;

        if u1210 then
            u1210:Destroy();
            u1210 = nil;
        end;

        u10.setCameraProperties("3");
        hideCharactersAndVehicles(u1211);
        u10.resetPlrCameraZoom();
        u1.viewMiniGolfContent(p1212);
        u2.autoDecisionInviteToJoinActivity("Minigolf");

        if u1211 then
            GuiService.TouchControlsEnabled = false;
            u1.displayMobileGuiType(true);
            local InstanceAttributeChangedSignal, v1214 = u10.getInstanceAttributeChangedSignal(LocalPlayer, "MiniGolf", function(p1213) -- Line: 7117
                -- upvalues: u1211 (copy), u1 (ref)
                if p1213 ~= u1211 then
                    return u1.miniGolfGame();
                end;
            end);
            CharScope.buildSignalData("MiniGolfGame", unpack(InstanceAttributeChangedSignal));
            CharScope.addThreadOrCleanUpFunction("MiniGolfGame", v1214);
            u1.activateMiniGolfPanel(false);
            local u1215 = true;
            CharScope.buildSignalData("MiniGolfGame", { u1211.Time.Changed, function(p1216) -- Line: 7125
                    -- upvalues: MiniGolf2 (ref), u1215 (ref)
                    MiniGolf2.Time.Text = string.format("%02d:%02d", math.floor(p1216 / 60), (math.floor(p1216 % 60)));

                    if p1216 <= 10 ~= u1215 then
                        u1215 = not u1215;
                        MiniGolf2.Time.TextColor3 = u1215 and Color3.fromRGB(255, 121, 25) or Color3.fromRGB(255, 255, 255);
                    end;
                end });
            CharScope.buildSignalData("MiniGolfGame", u2.mouseButton(MiniGolf2.Exit, function() -- Line: 7132
                -- upvalues: u2 (ref), PlayerFunc (ref)
                if u2.mainBox({
                    case = "Decision",
                    headline = "Do you want to quit the game?",
                    button = "QUIT",
                    button2 = "CANCEL"
                }) == 1 then
                    PlayerFunc:InvokeServer("miniGolf", "leave");
                end;
            end));

            local function u1220() -- Line: 7136
                -- upvalues: MiniGolf3 (ref)
                local v1217 = {};

                for _, child in pairs(MiniGolf3.List:GetChildren()) do
                    if child:IsA("Frame") and child.Visible then
                        table.insert(v1217, child);
                    end;
                end;

                table.sort(v1217, function(p1218, p1219) -- Line: 7141
                    return tonumber(p1218.TotalShots.Text) < tonumber(p1219.TotalShots.Text);
                end);

                for i, v in pairs(v1217) do
                    v.Nickname.Text = i .. ". " .. v:GetAttribute("DisplayName");
                    v.LayoutOrder = i;
                end;
            end;

            for _, child in pairs(MiniGolf3.List:GetChildren()) do
                if child:IsA("Frame") and child.Visible then
                    child:Destroy();
                end;
            end;

            for _, child in pairs(u1211.Players:GetChildren()) do
                local u1221 = u10.clone(MiniGolf3.List.PlayerPreview);
                u1221.Visible = true;
                u1221.Name = child.Name;
                u1221.Nickname.Text = child.Value.DisplayName;
                u1221:SetAttribute("DisplayName", child.Value.DisplayName);
                u1221.TotalShots.Text = child.Score.Value;

                if child.Value == LocalPlayer then
                    u1221.Finished.ImageColor3 = Color3.fromRGB(130, 238, 113);
                    u1221.Nickname.TextColor3 = Color3.fromRGB(130, 238, 113);
                    u1221.TotalShots.TextColor3 = Color3.fromRGB(130, 238, 113);
                    MiniGolf2.Shots.Text = child.RoundScore.Value;
                    CharScope.buildSignalData("MiniGolfGame", { child.RoundScore.Changed, function(p1222) -- Line: 7160
                            -- upvalues: MiniGolf2 (ref)
                            MiniGolf2.Shots.Text = p1222;
                        end });
                end;

                u1221.Parent = MiniGolf3.List;
                u1220();
                CharScope.buildSignalData("MiniGolfGame", { child.Variable.Changed, function(p1223) -- Line: 7164
                        -- upvalues: u1221 (copy)
                        u1221.Finished.Visible = p1223;
                    end });
                CharScope.buildSignalData("MiniGolfGame", { child.Score.Changed, function(p1224) -- Line: 7167
                        -- upvalues: u1221 (copy), u1220 (copy)
                        u1221.TotalShots.Text = p1224;
                        u1220();
                    end });
            end;

            local function adjustLeaderboardSize() -- Line: 7172
                -- upvalues: MiniGolf3 (ref), Scale (ref), Scale2 (ref)
                MiniGolf3.Background.Size = UDim2.fromScale(MiniGolf3.Background.Size.X.Scale, Scale + MiniGolf3.List.UIListLayout.AbsoluteContentSize.Y / MiniGolf3.AbsoluteSize.Y);
                MiniGolf3.ShadowNew.Size = UDim2.fromScale(MiniGolf3.Background.Size.X.Scale, Scale2 + MiniGolf3.List.UIListLayout.AbsoluteContentSize.Y / MiniGolf3.AbsoluteSize.Y);
            end;

            CharScope.buildSignalData("MiniGolfGame", { u1211.Players.ChildRemoved, function(p1225) -- Line: 7176
                    -- upvalues: MiniGolf3 (ref), u1220 (copy), adjustLeaderboardSize (copy)
                    MiniGolf3.List[p1225.Name]:Destroy();
                    u1220();
                    adjustLeaderboardSize();
                end });
            adjustLeaderboardSize();
            local u1226 = p1212:WaitForChild(LocalPlayer.Name);
            u1226:WaitForChild("NameDisplay"):Destroy();
            local HitSound = u1226:WaitForChild("HitSound");
            local Volume3 = HitSound.Volume;
            local Frame = u1226:WaitForChild("MiniGolfDrag").Frame;
            Frame.Parent.Enabled = true;
            local u1227 = nil;
            local u1228 = nil;
            local u1229 = false;
            local u1230 = true;
            local u1231 = false;
            local u1232 = nil;
            local u1233 = nil;

            local function adjustBallStoppedPosition() -- Line: 7196
                -- upvalues: u1210 (ref), u1226 (copy)
                if u1210 then
                    u1210.CFrame = CFrame.new(u1226.Position - Vector3.new(0, 0.24, 0));
                end;
            end;

            local function round(u1234) -- Line: 7199
                -- upvalues: u1 (ref), u1211 (copy), LocalPlayer (ref), u10 (ref), u1226 (copy), u1203 (ref), u1199 (ref), CharScope (ref), u1227 (ref), u1202 (ref), u1228 (ref), u1210 (ref), PlayerFunc (ref)
                if u1234 == -1 then
                    u1.activateMiniGolfLeaderboard(u1211);

                    return;
                end;

                LocalPlayer.CameraMinZoomDistance = 10;
                LocalPlayer.CameraMaxZoomDistance = 10;
                u10.setCameraProperties("3", {
                    CameraMinZoomDistance = 3,
                    CameraSubject = u1226,
                    CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
                });
                local u1235 = game.ReplicatedStorage.Gameplay.MiniGolf.Maps.Value[u1211.CurrentMap.Value];
                local v1236 = game.ReplicatedStorage.Gameplay.MiniGolf.MapsData[u1211.CurrentMap.Value];
                u1203.FilterDescendantsInstances = { u1235 };
                local u1237 = false;

                for _, child in pairs(u1235:WaitForChild("Walls"):GetChildren()) do
                    child.CanCollide = true;
                end;

                u1199 = function() -- Line: 7213
                    -- upvalues: u1235 (copy)
                    for _, child in pairs(u1235.Walls:GetChildren()) do
                        child.CanCollide = false;
                    end;
                end;

                CharScope.addThreadOrCleanUpFunction("MiniGolfGame", u1199);

                if u1227 then
                    u10.taskCancel(u1227);
                    u1227 = nil;
                end;

                local Finish = v1236:WaitForChild("Finish");
                u1202.FilterDescendantsInstances = { u1226 };
                u1228 = u1226.CFrame.Position;
                u1226.AssemblyLinearVelocity = Vector3.new();
                u1226.AssemblyAngularVelocity = Vector3.new();

                if u1210 then
                    u1210.CFrame = CFrame.new(u1226.Position - Vector3.new(0, 0.24, 0));
                end;

                u1227 = CharScope.taskDefer(function() -- Line: 7226
                    -- upvalues: Finish (copy), u1202 (ref), u1237 (ref), u10 (ref), u1226 (ref), PlayerFunc (ref), u1234 (copy)
                    while true do
                        if #workspace:GetPartBoundsInBox(Finish.CFrame, Finish.Size, u1202) ~= 0 then
                            if not u1237 then
                                u1237 = true;
                                u10.emitAtPosition(game.ReplicatedStorage.Gameplay.MiniGolf.HoleConfetti:GetChildren(), Finish.Position, Vector3.new(1, 0.5, 1));
                                u10.setCameraProperties("3", {
                                    CameraMinZoomDistance = 25,
                                    CameraMaxZoomDistance = 25,
                                    CameraType = Enum.CameraType.Orbital,
                                    CameraSubject = Finish
                                });
                                u1226.CollisionGroup = "CharacterNonCollide";
                            end;

                            if PlayerFunc:InvokeServer("miniGolf", "hole", {
                                round = u1234
                            }) then
                                return;
                            end;
                        end;

                        task.wait(0.2);
                    end;
                end);
                task.wait(1);
                u1.bigTextAnimation("<i>Round " .. u1234 .. "</i>", 1.1);
            end;

            local function isWithinMapBounds() -- Line: 7244
                -- upvalues: u1226 (copy), u1203 (ref)
                return workspace:Raycast(u1226.Position, Vector3.new(0, -20, 0), u1203) and true;
            end;

            CharScope.buildSignalData("MiniGolfGame", { u1211.Round.Changed, round });

            if u1211.Round.Value > 0 then
                round(u1211.Round.Value);
            end;

            u1201 = CharScope.taskDefer(function() -- Line: 7249
                -- upvalues: u1226 (copy), u1203 (ref), u1228 (ref), u1210 (ref)
                while true do
                    local v1238 = 0;

                    while true do
                        if v1238 == 0 then
                            v1238 = -1;

                            for i = 1, 5 do
                                if workspace:Raycast(u1226.Position, Vector3.new(0, -20, 0), u1203) and true then
                                    task.wait(1);
                                    v1238 = 0;
                                    break;
                                end;

                                if i == 5 then
                                    u1226.CFrame = CFrame.new(u1228);
                                    u1226.AssemblyLinearVelocity = Vector3.new();
                                    u1226.AssemblyAngularVelocity = Vector3.new();

                                    if u1210 then
                                        u1210.CFrame = CFrame.new(u1226.Position - Vector3.new(0, 0.24, 0));
                                    end;
                                end;

                                task.wait(1);
                                local _ = i;
                            end;

                            if v1238 ~= -1 then
                                continue;
                            end;

                            task.wait(1);
                            break;
                        else
                            break;
                        end;
                    end;
                end;
            end);
            CharScope.buildSignalData("MiniGolfGame", { RunService.Heartbeat, function() -- Line: 7264
                    -- upvalues: u1226 (copy), u1210 (ref), Frame (copy), u1229 (ref), u1230 (ref), u10 (ref), u1203 (ref), CharScope (ref), TweenService (ref), u1228 (ref)
                    if u1226.AssemblyLinearVelocity.Magnitude > 0.01 then
                        if u1210 then
                            Frame.Visible = false;
                            u1229 = true;
                            u1230 = false;
                            u1210:Destroy();
                            u1210 = nil;
                        end;
                    elseif not (u1210 or u10.rest("IsWithinMapBounds", 1)) then
                        u1229 = false;

                        if workspace:Raycast(u1226.Position, Vector3.new(0, -20, 0), u1203) and true then
                            u1210 = u10.clone(game.ReplicatedStorage.Gameplay.MiniGolf.Preview.BallStopped);
                            CharScope.addEntity(u1210);
                            u1210.Size = Vector3.new(0.05, 0.043, 0.05);
                            u1210.Parent = workspace.Gameplay.Entities;
                            TweenService:Create(u1210, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                Size = Vector3.new(0.9, 0.043, 0.9)
                            }):Play();
                            u1230 = true;
                            u1228 = u1226.Position;
                        else
                            u1226.CFrame = CFrame.new(u1228);
                            u1226.AssemblyLinearVelocity = Vector3.new();
                            u1226.AssemblyAngularVelocity = Vector3.new();
                        end;

                        if u1210 then
                            u1210.CFrame = CFrame.new(u1226.Position - Vector3.new(0, 0.24, 0));
                        end;
                    end;
                end });
            CharScope.buildSignalData("MiniGolfGame", { UserInputService.InputEnded, function(p1239) -- Line: 7291
                    -- upvalues: u1200 (ref), u10 (ref), u1231 (ref), Frame (copy), CharScope (ref), PlayerFunc (ref), workspace_CurrentCamera (ref), u1226 (copy), u1232 (ref), Easing (ref), u1233 (ref), HitSound (copy), Volume3 (copy)
                    if p1239.UserInputType == Enum.UserInputType.MouseButton1 or p1239.UserInputType == Enum.UserInputType.Touch then
                        if u1200 then
                            u10.taskCancel(u1200);
                            u1200 = nil;
                        end;

                        if u1231 then
                            u1231 = false;

                            if Frame.Visible then
                                CharScope.taskDefer(function() -- Line: 7297
                                    -- upvalues: PlayerFunc (ref)
                                    PlayerFunc:InvokeServer("miniGolf", "shot");
                                end);
                                Frame.Visible = false;
                                local math_atan2_ret = math.atan2(-workspace_CurrentCamera.CFrame.LookVector.Z, -workspace_CurrentCamera.CFrame.LookVector.X);
                                u1226:ApplyImpulse((CFrame.Angles(0, -math_atan2_ret - math.atan2(u1232.Y, u1232.X), 0) * CFrame.new(0, 0, Easing.inQuad(u1233, 0, 1, 1) * 210 * u1226.AssemblyMass)).Position);
                                HitSound.Volume = Volume3 * (0.2 + u1233 * 1.3);
                                u10.playSoundReplicate(HitSound, {
                                    volume = HitSound.Volume
                                });
                            end;
                        end;
                    end;
                end });

            local function inputBegan(p1240) -- Line: 7307
                -- upvalues: u1230 (ref), u1226 (copy), u1200 (ref), CharScope (ref), u1231 (ref), u10 (ref), Frame (copy), u2 (ref), workspace_CurrentCamera (ref), u1232 (ref), u1233 (ref)
                if u1230 and u1226.CollisionGroup ~= "CharacterNonCollide" then
                    local Vector2_new_ret3 = Vector2.new(p1240.Position.X, p1240.Position.Y);
                    u1200 = CharScope.taskSpawn(function() -- Line: 7310
                        -- upvalues: u1231 (ref), Vector2_new_ret3 (copy), u10 (ref), Frame (ref), u2 (ref), u1226 (ref), workspace_CurrentCamera (ref), u1232 (ref), u1233 (ref)
                        while true do
                            if not u1231 and (Vector2_new_ret3 - u10.getMousePos()).magnitude > 30 then
                                u1231 = true;
                                Frame.Visible = true;
                            end;

                            if u1231 then
                                local unitRay = u2.getMouseProperty.unitRay;
                                local v1241;

                                if u2.platform == "Mobile" then
                                    v1241 = Vector2.new(0, -40);
                                else
                                    v1241 = false;
                                end;

                                local v1242 = unitRay("Persistent", v1241);
                                local v1243 = u10.intersectLineWithPlane(v1242.Origin, v1242.Direction, u1226.Position, workspace_CurrentCamera.CFrame.LookVector);
                                u1232 = u10.getMousePos() + Vector2.new(0, u2.platform == "Mobile" and -40 or 0) - Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2 - u2.guiInset);
                                u1233 = math.min(1, (v1243 - u1226.Position).Magnitude * 0.3);

                                if Frame.Visible ~= (u1233 > 0.1) then
                                    Frame.Visible = not Frame.Visible;
                                end;

                                local Color3_fromHSV_ret = Color3.fromHSV(math.min(1, (1 - u1233) * 0.4), 0.62, 1);
                                local math_atan2_ret = math.atan2(u1232.Y, u1232.X);
                                Frame.Rotation = math.deg(math_atan2_ret);
                                Frame.Size = UDim2.fromScale(u1233 * 0.16, 0.11);
                                Frame.Drag.ImageColor3 = Color3_fromHSV_ret;
                                Frame.Arrow.ImageColor3 = Color3_fromHSV_ret;
                            end;

                            task.wait();
                        end;
                    end);
                end;
            end;

            CharScope.buildSignalData("MiniGolfGame", { UserInputService.InputBegan, function(p1244, p1245) -- Line: 7333
                    -- upvalues: u2 (ref), u1230 (ref), u1226 (copy), u1200 (ref), CharScope (ref), u1231 (ref), u10 (ref), Frame (copy), workspace_CurrentCamera (ref), u1232 (ref), u1233 (ref)
                    if not p1245 and p1244.UserInputType == Enum.UserInputType.MouseButton1 then
                        if u2.isMouseObstructedByBlackBackground() then
                            return;
                        end;

                        if u1230 and u1226.CollisionGroup ~= "CharacterNonCollide" then
                            local Vector2_new_ret3 = Vector2.new(p1244.Position.X, p1244.Position.Y);
                            u1200 = CharScope.taskSpawn(function() -- Line: 7310
                                -- upvalues: u1231 (ref), Vector2_new_ret3 (copy), u10 (ref), Frame (ref), u2 (ref), u1226 (ref), workspace_CurrentCamera (ref), u1232 (ref), u1233 (ref)
                                while true do
                                    if not u1231 and (Vector2_new_ret3 - u10.getMousePos()).magnitude > 30 then
                                        u1231 = true;
                                        Frame.Visible = true;
                                    end;

                                    if u1231 then
                                        local unitRay = u2.getMouseProperty.unitRay;
                                        local v1246;

                                        if u2.platform == "Mobile" then
                                            v1246 = Vector2.new(0, -40);
                                        else
                                            v1246 = false;
                                        end;

                                        local v1247 = unitRay("Persistent", v1246);
                                        local v1248 = u10.intersectLineWithPlane(v1247.Origin, v1247.Direction, u1226.Position, workspace_CurrentCamera.CFrame.LookVector);
                                        u1232 = u10.getMousePos() + Vector2.new(0, u2.platform == "Mobile" and -40 or 0) - Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2 - u2.guiInset);
                                        u1233 = math.min(1, (v1248 - u1226.Position).Magnitude * 0.3);

                                        if Frame.Visible ~= (u1233 > 0.1) then
                                            Frame.Visible = not Frame.Visible;
                                        end;

                                        local Color3_fromHSV_ret = Color3.fromHSV(math.min(1, (1 - u1233) * 0.4), 0.62, 1);
                                        local math_atan2_ret = math.atan2(u1232.Y, u1232.X);
                                        Frame.Rotation = math.deg(math_atan2_ret);
                                        Frame.Size = UDim2.fromScale(u1233 * 0.16, 0.11);
                                        Frame.Drag.ImageColor3 = Color3_fromHSV_ret;
                                        Frame.Arrow.ImageColor3 = Color3_fromHSV_ret;
                                    end;

                                    task.wait();
                                end;
                            end);
                        end;
                    end;
                end });
            u10.contextAction("BindActionAtPriority", "MinigolfMobile", function(p1249, p1250) -- Line: 7339
                -- upvalues: u2 (ref), workspace_CurrentCamera (ref), u1226 (copy), u10 (ref), u1230 (ref), u1200 (ref), CharScope (ref), u1231 (ref), Frame (copy), u1232 (ref), u1233 (ref)
                if p1249 == Enum.UserInputState.Begin then
                    if u2.isMouseObstructedByBlackBackground() then
                        return;
                    end;

                    local v1251, _ = workspace_CurrentCamera:WorldToViewportPoint(u1226.Position);

                    if (u10.getMousePos() - Vector2.new(v1251.X, v1251.Y - u2.guiInset)).Magnitude < 40 then
                        if u1230 and u1226.CollisionGroup ~= "CharacterNonCollide" then
                            local Vector2_new_ret3 = Vector2.new(p1250.Position.X, p1250.Position.Y);
                            u1200 = CharScope.taskSpawn(function() -- Line: 7310
                                -- upvalues: u1231 (ref), Vector2_new_ret3 (copy), u10 (ref), Frame (ref), u2 (ref), u1226 (ref), workspace_CurrentCamera (ref), u1232 (ref), u1233 (ref)
                                while true do
                                    if not u1231 and (Vector2_new_ret3 - u10.getMousePos()).magnitude > 30 then
                                        u1231 = true;
                                        Frame.Visible = true;
                                    end;

                                    if u1231 then
                                        local unitRay = u2.getMouseProperty.unitRay;
                                        local v1252;

                                        if u2.platform == "Mobile" then
                                            v1252 = Vector2.new(0, -40);
                                        else
                                            v1252 = false;
                                        end;

                                        local v1253 = unitRay("Persistent", v1252);
                                        local v1254 = u10.intersectLineWithPlane(v1253.Origin, v1253.Direction, u1226.Position, workspace_CurrentCamera.CFrame.LookVector);
                                        u1232 = u10.getMousePos() + Vector2.new(0, u2.platform == "Mobile" and -40 or 0) - Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2 - u2.guiInset);
                                        u1233 = math.min(1, (v1254 - u1226.Position).Magnitude * 0.3);

                                        if Frame.Visible ~= (u1233 > 0.1) then
                                            Frame.Visible = not Frame.Visible;
                                        end;

                                        local Color3_fromHSV_ret = Color3.fromHSV(math.min(1, (1 - u1233) * 0.4), 0.62, 1);
                                        local math_atan2_ret = math.atan2(u1232.Y, u1232.X);
                                        Frame.Rotation = math.deg(math_atan2_ret);
                                        Frame.Size = UDim2.fromScale(u1233 * 0.16, 0.11);
                                        Frame.Drag.ImageColor3 = Color3_fromHSV_ret;
                                        Frame.Arrow.ImageColor3 = Color3_fromHSV_ret;
                                    end;

                                    task.wait();
                                end;
                            end);
                        end;

                        return Enum.ContextActionResult.Sink;
                    end;
                end;
            end, false, Enum.ContextActionPriority.High.Value + 2, Enum.UserInputType.Touch);
        end;
    end;

    function u1.activateMiniGolfPanel(p1255) -- Line: 7352
        -- upvalues: u2 (ref), CharScope (ref), u10 (ref), u1 (ref), MiniGolf (copy), CreateLobby (copy), PlayerFunc (ref), LocalPlayer (ref), GameRules (ref)
        if u2.openedGui and u2.openedGui ~= "MiniGolf" then
            return;
        end;

        CharScope.setConnectionsAndThreads("MiniGolf");
        u2.activateBlur("miniGolf", p1255);
        u10.lockScroll("miniGolf", p1255);
        u1.lockHumanoidState("miniGolf", p1255 and -1);
        CharScope.setConnectionsAndThreads("MiniGolfPanel");

        for _, child in pairs(MiniGolf.Buttons:GetChildren()) do
            if child:IsA("ImageButton") then
                child.Visible = false;
            end;
        end;

        if p1255 then
            CharScope.buildSignalData("MiniGolf", u10.buttonHoverSignalData(CreateLobby, {
                intensity = 4
            }));
            CharScope.buildSignalData("MiniGolf", u2.mouseButton(CreateLobby, function() -- Line: 7364
                -- upvalues: u10 (ref)
                if not u10.invokeTraffic.miniGolf then
                    u10.invokeServerTraffic("miniGolf", "createLobby");
                end;
            end));
            CharScope.buildSignalData("MiniGolf", u10.buttonHoverSignalData(MiniGolf.Close));
            CharScope.buildSignalData("MiniGolf", u2.mouseButton(MiniGolf.Close, function() -- Line: 7368
                -- upvalues: u1 (ref)
                u1.activateMiniGolfPanel(false);
            end, {
                addMobileButton = true
            }));
            CharScope.buildSignalData("MiniGolf", u10.buttonHoverSignalData(MiniGolf.Buttons.Ready));
            CharScope.buildSignalData("MiniGolf", u2.mouseButton(MiniGolf.Buttons.Ready, function() -- Line: 7372
                -- upvalues: u10 (ref)
                if not u10.invokeTraffic.miniGolf then
                    u10.invokeServerTraffic("miniGolf", "setLobbyReady");
                end;
            end));
            CharScope.buildSignalData("MiniGolf", u10.buttonHoverSignalData(MiniGolf.Buttons.Leave));
            CharScope.buildSignalData("MiniGolf", u2.mouseButton(MiniGolf.Buttons.Leave, function() -- Line: 7376
                -- upvalues: u10 (ref)
                if not u10.invokeTraffic.miniGolf then
                    u10.invokeServerTraffic("miniGolf", "joinLobby");
                end;
            end));
            CharScope.buildSignalData("MiniGolf", u10.buttonHoverSignalData(MiniGolf.Buttons.Bid));
            CharScope.buildSignalData("MiniGolf", u2.mouseButton(MiniGolf.Buttons.Bid, function() -- Line: 7380
                -- upvalues: u2 (ref), u10 (ref), PlayerFunc (ref)
                local v1258 = u2.mainBox({
                    case = "Text",
                    headline = "Set the game\'s bid. All players pay and the winner gets 70% of all the money",
                    textPlaceholder = "＄0 - ＄500",
                    acceptContent = "SET",

                    acceptTextFunc = function(p1256) -- Line: 7381, Name: acceptTextFunc
                        -- upvalues: u10 (ref)
                        local v1257 = u10.toOnlyNumbers(p1256);
                        local string_sub_ret = string.sub(v1257, 1, 4);

                        return string_sub_ret == "" and string_sub_ret and string_sub_ret or math.min(1000, string_sub_ret);
                    end
                });
                PlayerFunc:InvokeServer("miniGolf", "setLobbyBid", {
                    bid = tonumber(v1258)
                });
            end));
            local u1259 = u10.scrollingListSystem(MiniGolf._ScrollingList.Scroll, 0.3, {
                scrollBar = MiniGolf.ScrollBar
            });
            CharScope.buildSignalData("MiniGolf", unpack(u1259.multipleSignalData));
            CharScope.addThreadOrCleanUpFunction("MiniGolf", u1259.cleanUp);

            local function gameJoined(p1260, p1261, p1262) -- Line: 7387
                -- upvalues: u10 (ref), MiniGolf (ref), LocalPlayer (ref), u2 (ref)
                p1261.Background.ImageColor3 = p1262 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 30);
                p1261.Background.ImageTransparency = p1262 and 0 or 0.7;
                p1261.Bid.TextColor3 = p1262 and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(120, 229, 128);
                local v1263 = {
                    p1261.GameName,
                    p1261.PlayerAmount,
                    p1261.ImageLabel,
                    p1261.Starting
                };

                for _, child in pairs(p1261.Players:GetChildren()) do
                    if child:IsA("Frame") then
                        table.insert(v1263, child.Host);
                        table.insert(v1263, child.Icon);
                        table.insert(v1263, child.Kick);
                        table.insert(v1263, child.Ready);
                        table.insert(v1263, child.TextLabel);
                    end;
                end;

                for _, v in pairs(v1263) do
                    v[(v:IsA("ImageLabel") or v:IsA("ImageButton")) and "ImageColor3" or "TextColor3"] = p1262 and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(255, 255, 255);
                end;

                u10.resetButtonColor(p1261.Background, p1262 or nil);

                for _, child in pairs(MiniGolf.Buttons:GetChildren()) do
                    if child:IsA("ImageButton") then
                        local v1264;

                        if p1262 then
                            v1264 = child.Name ~= "Bid" and true or p1260.Host.Value == LocalPlayer;
                        else
                            v1264 = p1262;
                        end;

                        child.Visible = v1264;
                    end;
                end;

                if p1262 then
                    u2.autoDecisionInviteToJoinActivity("Minigolf", "⛳ Come and join me in a mini golf game!");
                end;
            end;

            local function refreshGames() -- Line: 7414
                -- upvalues: MiniGolf (ref), u10 (ref), LocalPlayer (ref), CreateLobby (ref), CharScope (ref), u1 (ref), u2 (ref), GameRules (ref), gameJoined (copy), u1259 (copy), refreshGames (copy)
                for _, child in pairs(MiniGolf._ScrollingList.Scroll:GetChildren()) do
                    if child.Visible and child.Name ~= "CreateLobby" then
                        child:Destroy();
                    end;
                end;

                local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "MiniGolf");
                CreateLobby.Visible = false;
                CharScope.setConnectionsAndThreads("MiniGolfPanel");
                local u1265 = {};
                local u1266 = nil;

                local function spectate(p1267, p1268) -- Line: 7423
                    -- upvalues: u1266 (ref), u10 (ref), u1 (ref)
                    if u1266 then
                        u1266.ImageColor3 = Color3.fromRGB(159, 159, 159);
                        u10.resetButtonColor(u1266, false);
                        u1266 = nil;
                    end;

                    local v1269;

                    if p1267 then
                        v1269 = p1267.Content.Value;
                    else
                        v1269 = p1267;
                    end;

                    u1.viewMiniGolfContent(v1269);

                    if p1267 then
                        p1268.Spectate.ImageColor3 = Color3.fromRGB(115, 140, 173);
                        u10.resetButtonColor(p1268.Spectate, true);
                        u1266 = p1268.Spectate;
                    end;
                end;

                local function createGameGui(u1270) -- Line: 7436
                    -- upvalues: u10 (ref), MiniGolf (ref), LocalPlayer (ref), u1265 (copy), CharScope (ref), u2 (ref), GameRules (ref), gameJoined (ref), InstanceAttribute (copy), spectate (copy), u1266 (ref), u1 (ref), u1259 (ref), CreateLobby (ref), refreshGames (ref)
                    local u1271 = u10.clone(MiniGolf._ScrollingList.Scroll.GamePreview);
                    u1271.Name = u1270.Value == "Open" and "Lobby" or "Game";
                    u1271.Visible = true;
                    u1271.GameName.Text = u1270.Name;
                    u1271.Parent = MiniGolf._ScrollingList.Scroll;
                    local u1272 = 0;

                    local function addPlayer(u1273, p1274) -- Line: 7443
                        -- upvalues: u10 (ref), u1271 (copy), u1270 (copy), LocalPlayer (ref), MiniGolf (ref), u1265 (ref), CharScope (ref), u2 (ref), u1272 (ref), GameRules (ref), gameJoined (ref)
                        if p1274 then
                            u1273:WaitForChild("Variable");

                            if not (u1273.Parent and (u1273.Value and (u10.isPlayerLoaded(u1273.Value) and u1271.Parent))) then
                                return true;
                            end;

                            local u1275 = u10.clone(u1271.Players.PlayerPreview);
                            u1275.Name = string.lower(u1273.Value.DisplayName) .. u1273.Value.UserId;
                            u1275.TextLabel.Text = u1273.Value.DisplayName;
                            u1275.Host.Visible = false;
                            u1275.Visible = true;
                            u1275.Parent = u1271.Players;

                            if u1270.Value == "Open" then
                                if u1273.Value == u1270:WaitForChild("Host").Value then
                                    u1275.Host.Visible = true;
                                    u1275.Host.Position = UDim2.fromScale(u1275.TextLabel.Position.X.Scale + u10.getTextBounds(u1275.TextLabel).X / u1275.AbsoluteSize.X + 0.05, u1275.Host.Position.Y.Scale);
                                end;

                                local function ready(p1276) -- Line: 7458
                                    -- upvalues: u1275 (copy), u1273 (copy), LocalPlayer (ref), MiniGolf (ref)
                                    u1275.Ready.Visible = p1276;
                                    u1275.Icon.Visible = not p1276;

                                    if u1273.Value == LocalPlayer then
                                        MiniGolf.Buttons.Ready.TextLabel.Text = p1276 and "NOT READY" or "READY";
                                    end;
                                end;

                                local Value = u1273.Variable.Value;
                                u1275.Ready.Visible = Value;
                                u1275.Icon.Visible = not Value;

                                if u1273.Value == LocalPlayer then
                                    MiniGolf.Buttons.Ready.TextLabel.Text = Value and "NOT READY" or "READY";
                                end;

                                u1265[u1275] = CharScope.buildSignalData("MiniGolfPanel", { u1273.Variable.Changed, ready }, u10.buttonHoverSignalData(u1275.Kick, {
                                    intensity = 4
                                }), u2.mouseButton(u1275.Kick, function() -- Line: 7469
                                    -- upvalues: u10 (ref), u1273 (copy)
                                    if not u10.invokeTraffic.miniGolf then
                                        u10.invokeServerTraffic("miniGolf", "kickFromLobby", {
                                            player = u1273.Value
                                        });
                                    end;
                                end));

                                if u1270.Host.Value == LocalPlayer and u1273.Value ~= LocalPlayer then
                                    u1275.Kick.Visible = true;
                                    u1275.Kick.Position = UDim2.fromScale(u1275.TextLabel.Position.X.Scale + u10.getTextBounds(u1275.TextLabel).X / u1275.AbsoluteSize.X + 0.05, u1275.Kick.Position.Y.Scale);
                                end;
                            end;
                        else
                            local v1277 = u1271.Players:FindFirstChild(string.lower(u1273.Value.DisplayName) .. u1273.Value.UserId);

                            if v1277 then
                                if u1270.Value == "Open" then
                                    u10.clearConnectionsAndThreads(u1265[v1277]);
                                    u1265[v1277] = nil;
                                end;

                                v1277:Destroy();
                            end;
                        end;

                        u1272 = u1272 + (p1274 and 1 or -1);
                        u1271.PlayerAmount.Text = u1272 .. "/" .. GameRules.miniGolfMaxPlayers;
                        u1271.Background.Size = UDim2.fromScale(1, 1.21 + u1271.Players.UIListLayout.AbsoluteContentSize.Y / u1271.AbsoluteSize.Y);

                        if u1273.Value == LocalPlayer and u1270.Value == "Open" then
                            gameJoined(u1270, u1271, p1274);
                        end;
                    end;

                    if u1270.Value == "Started" then
                        if not InstanceAttribute or InstanceAttribute.Value == "Open" then
                            if u1270:WaitForChild("Content").Value and u1270.Content.Value.Parent == workspace.Gameplay.Entities then
                                spectate(u1270, u1271);
                            end;

                            u1271.Spectate.Visible = true;
                            CharScope.buildSignalData("MiniGolfPanel", u10.buttonHoverSignalData(u1271.Spectate));
                            CharScope.buildSignalData("MiniGolfPanel", u2.mouseButton(u1271.Spectate, function() -- Line: 7498
                                -- upvalues: spectate (ref), u1266 (ref), u1271 (copy), u1270 (copy)
                                local v1278;

                                if u1266 and u1266 == u1271.Spectate then
                                    v1278 = false;
                                else
                                    v1278 = u1270;
                                end;

                                spectate(v1278, u1271);
                            end));
                        end;
                    elseif u1270.Value == "Finished" then
                        u1271.Leaderboard.Visible = true;
                        CharScope.buildSignalData("MiniGolfPanel", u10.buttonHoverSignalData(u1271.Leaderboard));
                        CharScope.buildSignalData("MiniGolfPanel", u2.mouseButton(u1271.Leaderboard, function() -- Line: 7505
                            -- upvalues: u1 (ref), u1270 (copy)
                            u1.activateMiniGolfLeaderboard(u1270, true);
                        end));
                    else
                        CharScope.buildSignalData("MiniGolfPanel", { u1270:WaitForChild("Bid").Changed, function(p1279) -- Line: 7509
                                -- upvalues: u1271 (copy)
                                u1271.Bid.Text = "＄" .. p1279;
                            end });
                        CharScope.buildSignalData("MiniGolfPanel", { u1270:WaitForChild("Players").ChildAdded, function(p1280) -- Line: 7512
                                -- upvalues: addPlayer (copy), u10 (ref), u1271 (copy), u1259 (ref), CreateLobby (ref)
                                if addPlayer(p1280, true) then
                                    return;
                                end;

                                u10.UIListLayout(u1271, UDim2.fromScale(0, u1271.Size.Y.Scale * (u1271.Players.Size.Y.Scale + u1271.Players.UIListLayout.Padding.Scale)), false);
                                u1259.limitYScrollListener(CreateLobby.Position.Y.Scale + CreateLobby.Size.Y.Scale);
                            end });
                        CharScope.buildSignalData("MiniGolfPanel", u10.buttonHoverSignalData(u1271.Background, {
                            intensity = 4
                        }));
                        CharScope.buildSignalData("MiniGolfPanel", u2.mouseButton(u1271.Background, function() -- Line: 7518
                            -- upvalues: u1270 (copy), LocalPlayer (ref), u10 (ref)
                            if not (u1270.Players:FindFirstChild(LocalPlayer.Name) or u10.invokeTraffic.miniGolf) then
                                u10.invokeServerTraffic("miniGolf", "joinLobby", {
                                    lobby = u1270
                                });
                            end;
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                        CharScope.buildSignalData("MiniGolfPanel", { u1270:GetAttributeChangedSignal("IsStarting"), function() -- Line: 7521
                                -- upvalues: u1270 (copy), u1271 (copy)
                                local Attribute = u1270:GetAttribute("IsStarting");
                                u1271.Starting.Text = Attribute and "Starting in " .. Attribute .. "s..." or "";
                            end });
                    end;

                    u1271.Bid.Text = "＄" .. u1270.Bid.Value;
                    CharScope.buildSignalData("MiniGolfPanel", { u1270.Players.ChildRemoved, function(p1281) -- Line: 7527
                            -- upvalues: addPlayer (copy), u10 (ref), u1271 (copy), u1259 (ref), CreateLobby (ref)
                            if addPlayer(p1281) then
                                return;
                            end;

                            u10.UIListLayout(u1271, UDim2.fromScale(0, -u1271.Size.Y.Scale * (u1271.Players.Size.Y.Scale + u1271.Players.UIListLayout.Padding.Scale)), false);
                            u1259.limitYScrollListener(CreateLobby.Position.Y.Scale + CreateLobby.Size.Y.Scale);
                        end });
                    CharScope.buildSignalData("MiniGolfPanel", { u1270.Changed, refreshGames });

                    for _, child in pairs(u1270.Players:GetChildren()) do
                        CharScope.taskSpawn(addPlayer, child, true);
                    end;

                    u10.UIListLayout(u1271, UDim2.fromScale(0, u1271.Size.Y.Scale * u1271.Background.Size.Y.Scale + 0.01), true);
                    u1259.limitYScrollListener(CreateLobby.Position.Y.Scale + CreateLobby.Size.Y.Scale);
                end;

                local function createGroupGui(p1282) -- Line: 7537
                    -- upvalues: u10 (ref), MiniGolf (ref)
                    local v1283 = u10.clone(MiniGolf._ScrollingList.Scroll[p1282]);
                    v1283.Name = "Group";
                    v1283.Visible = true;
                    v1283.Parent = MiniGolf._ScrollingList.Scroll;
                    u10.UIListLayout(v1283, UDim2.fromScale(0, v1283.Size.Y.Scale + 0.01), true);
                end;

                CreateLobby.Position = UDim2.fromScale(0, 0);
                local v1284 = {};
                local v1285 = {};

                for _, child in pairs(game.ReplicatedStorage.Gameplay.MiniGolf.Active:GetChildren()) do
                    if child.Value == "Open" then
                        local string_sub_ret = string.sub(child.Name, 6);
                        v1285[tonumber(string_sub_ret)] = child;
                    elseif child.Value == "Finished" then
                        table.insert(v1284, 1, child);
                    else
                        table.insert(v1284, child);
                    end;
                end;

                for _, v in pairs(v1284) do
                    createGameGui(v);
                end;

                if #v1284 > 0 then
                    createGroupGui("GamesGroupPreview");
                end;

                CreateLobby.Position = UDim2.fromScale(0, 0);
                CreateLobby.Visible = true;
                u10.UIListLayout(CreateLobby, UDim2.fromScale(0, CreateLobby.Size.Y.Scale + 0.01), true);

                for _, v in pairs(v1285) do
                    createGameGui(v);
                end;

                createGroupGui("LobbyGroupPreview");
            end;

            CharScope.buildSignalData("MiniGolf", { game.ReplicatedStorage.Gameplay.MiniGolf.Active.ChildAdded, function(p1286) -- Line: 7560
                    -- upvalues: refreshGames (copy)
                    p1286:WaitForChild("Players");
                    refreshGames();
                end });
            CharScope.buildSignalData("MiniGolf", { game.ReplicatedStorage.Gameplay.MiniGolf.Active.ChildRemoved, refreshGames });
            refreshGames();
        else
            CharScope.taskSpawn(function() -- Line: 7567
                -- upvalues: PlayerFunc (ref)
                PlayerFunc:InvokeServer("miniGolf", "joinLobby");
            end);
        end;

        u10.guiTransition(MiniGolf, "Size", 0.9, p1255);
        u2.openGui(p1255 and "MiniGolf", true);
    end;

    local SecurityCamera = ScreenGui.Right.HideGuiBottom.SecurityCamera;
    local u1287 = nil;
    local u1288 = nil;

    local function charVisibilityExceptArms(p1289, p1290) -- Line: 7579
        -- upvalues: u10 (ref)
        local EquippedTool = u10.toolSystem.getEquippedTool(p1289);

        for _, descendant in pairs(p1289:GetDescendants()) do
            if descendant:IsA("BasePart") and (descendant.Name ~= "HumanoidRootPart" and (descendant.Name ~= "RightUpperArm" and (descendant.Name ~= "RightLowerArm" and (descendant.Name ~= "RightHand" and (descendant.Name ~= "LeftUpperArm" and (descendant.Name ~= "LeftLowerArm" and (descendant.Name ~= "LeftHand" and descendant.Parent ~= EquippedTool))))))) then
                descendant.LocalTransparencyModifier = p1290 and 0 or 1;
            end;
        end;
    end;

    function u1.activateTeamCameras(u1291) -- Line: 7588
        -- upvalues: ScreenGui (copy), CharScope (ref), SecurityCamera (copy), TeamCameras (copy), u2 (ref), u1287 (ref), u1288 (ref), charVisibilityExceptArms (copy), LocalPlayer (ref), GameRules (ref), u10 (ref), u1 (ref), workspace_CurrentCamera (ref), Chat (copy), UserInputService (ref), PlayerFunc (ref)
        ScreenGui.Center.HideGuiMiddle.TeamCameras.Black.Visible = false;
        CharScope.setConnectionsAndThreads("TeamCameras");
        CharScope.setConnectionsAndThreads("CurrentTeamCameras");
        SecurityCamera.Visible = false;

        for _, child in pairs(TeamCameras._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") and child.Visible then
                child:Destroy();
            end;
        end;

        if u1291 then
            if u2.sit(u1291.Parent.Parent, {
                manualExit = true,
                lockRotation = true,
                animation = "Sit",
                offset = CFrame.new(0, 0.2, 0)
            }) then
                u1287 = u1291.Name;
                local u1292 = nil;
                local u1293 = {};
                local u1294 = nil;

                local function selectCamera(p1295) -- Line: 7602
                    -- upvalues: u1294 (ref), TeamCameras (ref), ScreenGui (ref), CharScope (ref), u1288 (ref), charVisibilityExceptArms (ref), u1293 (copy)
                    if p1295 ~= u1294 then
                        local function buttonVisual(p1296, p1297) -- Line: 7604
                            p1296.ImageColor3 = p1297 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 30);
                            p1296.TextLabel.TextColor3 = p1297 and Color3.fromRGB(0, 0, 0) or (p1296.TextLabel:GetAttribute("Color") or Color3.fromRGB(255, 255, 255));
                            p1296.ImageTransparency = p1297 and 0 or 0.7;
                        end;

                        for _, child in pairs(TeamCameras._ScrollingList.Scroll:GetChildren()) do
                            if child:IsA("ImageButton") and child.Visible then
                                child.ImageColor3 = Color3.fromRGB(30, 30, 30);
                                child.TextLabel.TextColor3 = child.TextLabel:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);
                                child.ImageTransparency = 0.7;
                            end;
                        end;

                        u1294 = p1295;
                        p1295.ImageColor3 = Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 30);
                        p1295.TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0) or (p1295.TextLabel:GetAttribute("Color") or Color3.fromRGB(255, 255, 255));
                        p1295.ImageTransparency = 0;

                        return u1293[p1295](function() -- Line: 7614, Name: clearFunc
                            -- upvalues: ScreenGui (ref), CharScope (ref), u1288 (ref), charVisibilityExceptArms (ref)
                            ScreenGui.Center.HideGuiMiddle.TeamCameras.Black.Visible = false;
                            CharScope.setConnectionsAndThreads("CurrentTeamCameras");

                            if u1288 then
                                if u1288.Parent then
                                    charVisibilityExceptArms(u1288, true);
                                end;

                                u1288 = nil;
                            end;
                        end);
                    end;
                end;

                local function getButtons() -- Line: 7625
                    -- upvalues: TeamCameras (ref)
                    local v1298 = {};

                    for _, child in pairs(TeamCameras._ScrollingList.Scroll:GetChildren()) do
                        if child:IsA("ImageButton") and child.Visible then
                            table.insert(v1298, child);
                        end;
                    end;

                    table.sort(v1298, function(p1299, p1300) -- Line: 7630
                        return p1299.Name < p1300.Name;
                    end);

                    return v1298;
                end;

                if u1291.Name == "Dashcam" then
                    TeamCameras.TopBar.Headline.Text = "Dashcams";

                    local function u1312(u1301, p1302) -- Line: 7635
                        -- upvalues: LocalPlayer (ref), GameRules (ref), u10 (ref), TeamCameras (ref), CharScope (ref), u2 (ref), selectCamera (copy), u1293 (copy), u1291 (copy), u1288 (ref), charVisibilityExceptArms (ref), getButtons (copy), u1 (ref), ScreenGui (ref), workspace_CurrentCamera (ref)
                        if p1302 then
                            if u1301 and (u1301 ~= LocalPlayer and (GameRules.teamsWithCamera[u1301.Team.Name] and u1301:GetAttribute("Callsign"))) then
                                local u1303 = u10.clone(TeamCameras._ScrollingList.Scroll.Preview);
                                u1303.TextLabel.Text = u1301:GetAttribute("Callsign") .. " - " .. u1301.DisplayName;
                                u1303.TextLabel:SetAttribute("Color", require(u1301.Team.Config).RADIO_CHANNEL.color);
                                u1303.TextLabel.TextColor3 = u1303.TextLabel:GetAttribute("Color");
                                u1303.Name = "Element_" .. string.lower(u1301.DisplayName) .. u1301.UserId;
                                u1303.Visible = true;
                                u1303.Parent = TeamCameras._ScrollingList.Scroll;
                                CharScope.buildSignalData("TeamCameras", u2.mouseButton(u1303, function() -- Line: 7645
                                    -- upvalues: selectCamera (ref), u1303 (copy)
                                    selectCamera(u1303);
                                end));

                                u1293[u1303] = function(p1304) -- Line: 7648
                                    -- upvalues: u10 (ref), u1291 (ref), u1301 (copy), u1288 (ref), charVisibilityExceptArms (ref), getButtons (ref), selectCamera (ref), u2 (ref), u1 (ref), ScreenGui (ref), CharScope (ref), u1303 (copy), workspace_CurrentCamera (ref)
                                    if not u10.invokeTraffic.teamCamerasFocus then
                                        local v1305 = u10.invokeServerTraffic("teamCamerasFocus", u1291, u1301);
                                        local u1306 = v1305 and u10.getInstanceReference(v1305, 20);

                                        if u1306 then
                                            p1304();
                                            u1288 = u1306;
                                            charVisibilityExceptArms(u1288, false);

                                            local function nextCamera() -- Line: 7657
                                                -- upvalues: getButtons (ref), selectCamera (ref), u2 (ref), u1 (ref)
                                                local v1307 = getButtons()[1];

                                                if v1307 then
                                                    return selectCamera(v1307);
                                                end;

                                                u2.notify({
                                                    message = "No dashcams available",
                                                    color = "red"
                                                });

                                                return u1.activateTeamCameras();
                                            end;

                                            local function blackScreen() -- Line: 7666
                                                -- upvalues: ScreenGui (ref), u1306 (copy)
                                                ScreenGui.Center.HideGuiMiddle.TeamCameras.Black.Visible = not u1306:IsDescendantOf(workspace);
                                            end;

                                            ScreenGui.Center.HideGuiMiddle.TeamCameras.Black.Visible = not u1306:IsDescendantOf(workspace);
                                            CharScope.buildSignalData("CurrentTeamCameras", { u1306.AncestryChanged, function() -- Line: 7668
                                                    -- upvalues: u1306 (copy), CharScope (ref), blackScreen (copy), ScreenGui (ref)
                                                    if u1306:IsDescendantOf(workspace) then
                                                        CharScope.setThreadOrCleanUpFunctionIndex("CurrentTeamCameras", "blackScreenDelay", CharScope.taskDelay(1, blackScreen));

                                                        return;
                                                    end;

                                                    ScreenGui.Center.HideGuiMiddle.TeamCameras.Black.Visible = not u1306:IsDescendantOf(workspace);
                                                end });
                                            CharScope.buildSignalData("CurrentTeamCameras", u10.instanceDestroyed(u1303, function() -- Line: 7673
                                                -- upvalues: nextCamera (copy)
                                                nextCamera();
                                            end));
                                            local u1308 = 0;
                                            CharScope.addThreadOrCleanUpFunction("CurrentTeamCameras", CharScope.taskSpawn(function() -- Line: 7677
                                                -- upvalues: u10 (ref), u1301 (ref), workspace_CurrentCamera (ref), u1288 (ref), u1308 (ref)
                                                while true do
                                                    local v1309 = u10.getVehicleInfo.inVehicle(u1301);

                                                    if v1309 and (v1309.PrimaryPart and v1309.PrimaryPart:FindFirstChild("FirstPersonCamera")) then
                                                        workspace_CurrentCamera.CFrame = v1309.PrimaryPart.FirstPersonCamera.WorldCFrame;
                                                    else
                                                        local _, v1310, _ = u1288.UpperTorso.Waist.Transform:ToOrientation();
                                                        u1308 = u10.lerp(u1308, v1310, 0.04);
                                                        workspace_CurrentCamera.CFrame = u1288.PrimaryPart.CFrame * CFrame.Angles(0, u1308, 0) * CFrame.new(0, 0.658, -0.23);
                                                    end;

                                                    task.wait();
                                                end;
                                            end));

                                            return true;
                                        end;
                                    end;
                                end;
                            end;
                        else
                            local v1311 = TeamCameras._ScrollingList.Scroll:FindFirstChild("Element_" .. string.lower(u1301.DisplayName) .. u1301.UserId);

                            if v1311 then
                                v1311:Destroy();
                            end;
                        end;
                    end;

                    for _, v in pairs({ "Police", "Medical", "Fire" }) do
                        u10.loadedPlayerAdded(CharScope.buildSignalData, "TeamCameras", game.Teams[v], function(p1313) -- Line: 7702
                            -- upvalues: u1312 (copy), u1292 (ref)
                            u1312(p1313, true);
                            u1292.limitYScrollListener();
                        end);
                        CharScope.buildSignalData("TeamCameras", { game.Teams[v].PlayerRemoved, function(p1314) -- Line: 7706
                                -- upvalues: TeamCameras (ref), u1292 (ref)
                                local v1315 = TeamCameras._ScrollingList.Scroll:FindFirstChild("Element_" .. string.lower(p1314.DisplayName) .. p1314.UserId);

                                if v1315 then
                                    v1315:Destroy();
                                end;

                                u1292.limitYScrollListener();
                            end });

                        for _, v2 in pairs(u10.getLoadedPlayers(game.Teams[v])) do
                            u1312(v2, true);
                        end;
                    end;

                    local v1316 = getButtons()[1];

                    if not v1316 then
                        u2.notify({
                            message = "No dashcams available",
                            color = "red"
                        });

                        return u1.activateTeamCameras();
                    end;

                    if not selectCamera(v1316) then
                        return u1.activateTeamCameras();
                    end;

                    u10.setCameraProperties("4", {
                        CameraType = Enum.CameraType.Scriptable
                    });
                    u2.hideGui("TeamCameras", { Chat });
                    CharScope.addThreadOrCleanUpFunction("TeamCameras", function() -- Line: 7728
                        -- upvalues: u1288 (ref), charVisibilityExceptArms (ref)
                        if u1288.Parent then
                            charVisibilityExceptArms(u1288, true);
                        end;

                        u1288 = nil;
                    end);
                elseif u1291.Name == "SecurityCamera" then
                    TeamCameras.TopBar.Headline.Text = "Security Cameras";
                    local Children2 = workspace.World.Interactive.TeamCameras.SecurityCameras:GetChildren();
                    table.sort(Children2, function(p1317, p1318) -- Line: 7734
                        return p1317.Name < p1318.Name;
                    end);

                    for i, v in pairs(Children2) do
                        local u1319 = u10.clone(TeamCameras._ScrollingList.Scroll.Preview);
                        u1319.Visible = true;
                        u1319.Name = v.Name;
                        u1319.Parent = TeamCameras._ScrollingList.Scroll;
                        u1319.TextLabel.Text = u10.cutTextBeyondBounds(u1319.TextLabel, i .. ". " .. v.Name);
                        CharScope.buildSignalData("TeamCameras", u2.mouseButton(u1319, function() -- Line: 7741
                            -- upvalues: selectCamera (copy), u1319 (copy)
                            selectCamera(u1319);
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));

                        u1293[u1319] = function(p1320) -- Line: 7744
                            -- upvalues: u10 (ref), u1291 (copy), v (copy), SecurityCamera (ref), CharScope (ref)
                            if not u10.invokeTraffic.teamCamerasFocus and u10.invokeServerTraffic("teamCamerasFocus", u1291, v) then
                                p1320();
                                workspace.Camera.CFrame = v.CFrame;
                                SecurityCamera.Visible = true;
                                SecurityCamera.Location.TextLabel.Text = string.upper(v.Name);
                                SecurityCamera.Location.Size = UDim2.fromScale(20, SecurityCamera.Location.Size.Y.Scale);
                                SecurityCamera.Location.Size = UDim2.fromScale(u10.getTextBounds(SecurityCamera.Location.TextLabel).X / SecurityCamera.AbsoluteSize.X + 0.3, SecurityCamera.Location.Size.Y.Scale);

                                local function updateDate() -- Line: 7753
                                    -- upvalues: SecurityCamera (ref), v (ref)
                                    local v1321 = DateTime.now():ToUniversalTime();
                                    SecurityCamera.Date.TextLabel.Text = string.format("%02d", v1321.Hour) .. " : " .. string.format("%02d", v1321.Minute) .. " : " .. string.format("%02d", v1321.Second) .. "    " .. v.Serial.Value;
                                end;

                                updateDate();
                                SecurityCamera.Date.Size = UDim2.fromScale(20, SecurityCamera.Date.Size.Y.Scale);
                                SecurityCamera.Date.Size = UDim2.fromScale(u10.getTextBounds(SecurityCamera.Date.TextLabel).X / SecurityCamera.AbsoluteSize.X + 0.3, SecurityCamera.Date.Size.Y.Scale);
                                CharScope.addThreadOrCleanUpFunction("CurrentTeamCameras", CharScope.taskSpawn(function() -- Line: 7760
                                    -- upvalues: updateDate (copy)
                                    while true do
                                        updateDate();
                                        task.wait(1);
                                    end;
                                end));

                                return true;
                            end;
                        end;
                    end;

                    if not selectCamera(getButtons()[1]) then
                        return u1.activateTeamCameras();
                    end;

                    game.Lighting.SecurityCameraCorrection.Enabled = true;
                    CharScope.addThreadOrCleanUpFunction("TeamCameras", function() -- Line: 7773
                        game.Lighting.SecurityCameraCorrection.Enabled = false;
                    end);
                    SecurityCamera.Visible = true;
                    u10.setCameraProperties("4", {
                        CameraType = Enum.CameraType.Scriptable
                    });
                    u2.hideGui("TeamCameras", { Chat });
                    ScreenGui.Right.HideGuiBottom.SecurityCamera.Visible = true;
                end;

                local function getNextButton(p1322) -- Line: 7781
                    -- upvalues: getButtons (copy), u1294 (ref)
                    local v1323 = nil;
                    local v1324 = getButtons();

                    if #v1324 ~= 0 then
                        for i, v in pairs(v1324) do
                            if v == u1294 then
                                v1323 = i;
                            end;
                        end;

                        return v1324[(v1323 + p1322 - 1) % #v1324 + 1];
                    end;
                end;

                CharScope.buildSignalData("TeamCameras", { UserInputService.InputBegan, function(p1325) -- Line: 7788
                        -- upvalues: u2 (ref), selectCamera (copy), getNextButton (copy)
                        if u2.canPressKey(p1325.KeyCode) then
                            if p1325.KeyCode == Enum.KeyCode.A or p1325.KeyCode == Enum.KeyCode.Left then
                                selectCamera(getNextButton(-1));

                                return;
                            end;

                            if p1325.KeyCode == Enum.KeyCode.D or p1325.KeyCode == Enum.KeyCode.Right then
                                selectCamera(getNextButton(1));
                            end;
                        end;
                    end });
                CharScope.buildSignalData("TeamCameras", u2.mouseButton(TeamCameras.Close, function() -- Line: 7797
                    -- upvalues: u1 (ref)
                    u1.activateTeamCameras();
                end, {
                    addMobileButton = true
                }));
                local v1326 = u10.scrollingListSystem(TeamCameras._ScrollingList.Scroll, 0.2, {
                    scrollBar = TeamCameras.ScrollBar
                });
                CharScope.buildSignalData("TeamCameras", unpack(v1326.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("TeamCameras", v1326.cleanUp);
                u10.guiTransition(TeamCameras, "Position", UDim2.fromScale(-0.5, 0), true);
            end;
        elseif u1287 then
            u2.sit();
            u2.hideGui();
            u10.setCameraProperties("4");
            CharScope.taskSpawn(function() -- Line: 7809
                -- upvalues: PlayerFunc (ref)
                PlayerFunc:InvokeServer("teamCamerasFocus");
            end);

            if u1287 ~= "Dashcam" then
                local _ = u1287 == "SecurityCamera";
            end;

            u1287 = nil;
            u10.guiTransition(TeamCameras, "Position", UDim2.fromScale(-0.5, 0), false);
        end;
    end;

    u2.debugLoadingClient("Character 9");
    local Arcade = ScreenGui.Center.Bottom.Arcade;
    local ArcadeGames = ScreenGui.Center.Middle.ArcadeGames;
    local u1327 = {};
    local u1328 = false;
    local u1329 = false;

    for _, descendant in pairs(ArcadeGames["Arcade Machine"].Icons:GetDescendants()) do
        if descendant:IsA("Decal") then
            table.insert(u1327, descendant);
        end;
    end;

    function u1.arcadeGame(u1330, p1331) -- Line: 7826
        -- upvalues: u2 (ref), PlayerFunc (ref), u4 (ref), u10 (ref), Arcade (copy), CharScope (ref), ArcadeGames (copy), u9 (ref), u1 (ref), u1329 (ref), u1328 (ref), u1327 (copy), Easing (ref), UserInputService (ref), GameRules (ref), RunService (ref)
        if u2.openedGui and u2.openedGui ~= "ArcadeGames" then
            return;
        end;

        if not PlayerFunc:InvokeServer("arcadeGame", {
            prompt = u1330,
            enter = p1331
        }) then
            return;
        end;

        u2.openGui(p1331 and "ArcadeGames", true);
        u4.hideInventoryBar(p1331);
        u10.guiTransition(Arcade, "Position", UDim2.fromScale(0, 0.1), p1331);
        CharScope.setConnectionsAndThreads("ArcadeGame");

        for _, child in pairs(ArcadeGames:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false;
            end;
        end;

        local v1332;

        if p1331 then
            v1332 = u1330.Camera;
        else
            v1332 = p1331;
        end;

        u10.focusCamera(v1332);
        u9.disabled(p1331, "arcade");

        local function clearGame() -- Line: 7837
            -- upvalues: u1330 (copy), ArcadeGames (ref)
            if u1330.Game.Value == "Arcade Machine" then
                ArcadeGames[u1330.Game.Value].Visible = true;

                for i = 1, 3 do
                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 1].Visible = false;
                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 2].Visible = false;
                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel.ItemFinal.Image = "";
                    local _ = i;
                end;
            end;
        end;

        if u1330.Game.Value == "Fortune Wheel" then
            u1.lockHumanoidState("fortuneWheel", p1331 and -1);
        end;

        if p1331 then
            if string.sub(u1330.Game.Value, 1, 11) == "Tic-Tac-Toe" then
                u2.autoDecisionInviteToJoinActivity("TicTacToe", "⭕❌ Come and join me in a X\'s and O\'s!");
            end;

            u2.listenToInmobileActivityInterrupted(CharScope.buildSignalData, "ArcadeGame", function() -- Line: 7854
                -- upvalues: u1 (ref), u1330 (copy)
                u1.arcadeGame(u1330, false);
            end);
            clearGame();

            local function arcadeStatus(p1333, p1334) -- Line: 7858
                -- upvalues: Arcade (ref), u1330 (copy), u10 (ref), u1329 (ref), u1328 (ref)
                Arcade.WinMessage.Text = p1334 and (p1334[1] or "") or "";
                Arcade.WinMessage2.Text = p1334 and (p1334[2] or "") or "";
                Arcade.Message.Text = p1334 and "" or u1330.Game.Value;
                Arcade.Play.ImageColor3 = p1333 and Color3.fromRGB(167, 167, 167) or Color3.fromRGB(70, 167, 81);
                u10.resetButtonColor(Arcade.Play);
                u1329 = p1333;
                u1328 = not p1333;
            end;

            Arcade.WinMessage.Text = "";
            Arcade.WinMessage2.Text = "";
            Arcade.Message.Text = u1330.Game.Value;
            Arcade.Play.ImageColor3 = Color3.fromRGB(70, 167, 81);
            u10.resetButtonColor(Arcade.Play);
            u1329 = false;
            u1328 = true;
            Arcade.Play.TextLabel.Text = u1330.Tokens.Value;
            CharScope.buildSignalData("ArcadeGame", u10.buttonHoverSignalData(Arcade.Exit));
            CharScope.buildSignalData("ArcadeGame", u2.mouseButton(Arcade.Exit, function() -- Line: 7870
                -- upvalues: u1328 (ref), u1 (ref), u1330 (copy)
                if not u1328 then
                    return;
                end;

                u1.arcadeGame(u1330, false);
            end));
            CharScope.buildSignalData("ArcadeGame", u10.buttonHoverSignalData(Arcade.Play));
            CharScope.buildSignalData("ArcadeGame", u2.mouseButton(Arcade.Play, function() -- Line: 7875
                -- upvalues: u10 (ref), u1329 (ref), CharScope (ref), clearGame (copy), Arcade (ref), u1330 (copy), u1328 (ref), u2 (ref), arcadeStatus (copy), ArcadeGames (ref), u1327 (ref), Easing (ref), UserInputService (ref), GameRules (ref), RunService (ref)
                if u10.invokeTraffic.arcadeGame or u1329 then
                    return;
                end;

                CharScope.setConnectionsAndThreads("ArcadeGamePlay");
                clearGame();
                Arcade.WinMessage.Text = "";
                Arcade.WinMessage2.Text = "";
                Arcade.Message.Text = u1330.Game.Value;
                Arcade.Play.ImageColor3 = Color3.fromRGB(167, 167, 167) or Color3.fromRGB(70, 167, 81);
                u10.resetButtonColor(Arcade.Play);
                u1329 = true;
                u1328 = false;
                local u1335 = u10.invokeServerTraffic("arcadeGame", {
                    play = true,
                    prompt = u1330
                });

                if u1335 and u10.typeOf(u1335) ~= "string" then
                    local function gameFinished(p1336) -- Line: 7885
                        -- upvalues: arcadeStatus (ref), u1335 (copy), u2 (ref)
                        arcadeStatus(false, p1336);

                        if u1335.moneyReward then
                            u2.loadMoney(u1335.moneyReward);
                        end;
                    end;

                    if u1330.Game.Value == "Arcade Machine" then
                        local u1337 = {};

                        if u1335.win == "Lost" then
                            u1337[1] = math.random(#u1327);
                            u1337[2] = math.random(#u1327);
                            u1337[3] = math.random(#u1327);

                            if u1337[1] == u1337[2] and u1337[1] == u1337[3] then
                                local math_random_ret = math.random(3);
                                u1337[math_random_ret] = (u1337[math_random_ret] + math.random(#u1327 - 1) - 1) % #u1327 + 1;
                            end;

                            u1337[1] = u1327[u1337[1]];
                            u1337[2] = u1327[u1337[2]];
                            u1337[3] = u1327[u1337[3]];
                        else
                            local v1338 = ArcadeGames["Arcade Machine"].Icons[u1335.win]:GetChildren()[math.random(#ArcadeGames["Arcade Machine"].Icons[u1335.win]:GetChildren())];
                            u1337[1] = v1338;
                            u1337[2] = v1338;
                            u1337[3] = v1338;
                        end;

                        for i = 1, 3 do
                            CharScope.taskSpawn(function() -- Line: 7905
                                -- upvalues: ArcadeGames (ref), i (copy), u1327 (ref), u1337 (copy), gameFinished (copy), u1335 (copy)
                                ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 1].Visible = true;
                                ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 2].Visible = true;

                                for i2 = 1, i * 10 + 20 do
                                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. i2 % 2 + 1].Image = u1327[math.random(#u1327)].Texture;
                                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. i2 % 2 + 1].Position = UDim2.fromScale(0.5, -0.2);
                                    ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. i2 % 2 + 1]:TweenPosition(UDim2.fromScale(0.5, 1.2), "Out", "Linear", 0.12, true);
                                    task.wait(0.06);
                                    local _ = i2;
                                end;

                                ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 1].Visible = false;
                                ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel["Item" .. 2].Visible = false;
                                ArcadeGames["Arcade Machine"]["Slot" .. i].ImageLabel.ItemFinal.Image = u1337[i].Texture;

                                if i == 3 then
                                    return gameFinished(u1335.winMessage);
                                end;
                            end);
                            local _ = i;
                        end;
                    elseif u1330.Game.Value == "Fortune Wheel" then
                        local u1339 = u1330.Wheel:GetAttribute("LastRotation") or 0;
                        local v1340 = 25.132741228718345 + 0.3141592653589793 * (u1335.win - 1) + math.random(31.41592653589793) / 100;
                        u1330.Wheel:SetAttribute("LastRotation", math.floor(v1340 % 6.283185307179586 * 100) / 100);
                        local u1341 = v1340 - u1339;
                        local u1342 = 0;
                        CharScope.taskSpawn(function() -- Line: 7927
                            -- upvalues: u1342 (ref), u1330 (ref), Easing (ref), u1339 (copy), u1341 (copy), u1335 (copy), arcadeStatus (ref), u2 (ref)
                            while u1342 < 9 do
                                u1330.Wheel:PivotTo(u1330.WheelBase.CFrame * CFrame.Angles(Easing.inOutQuint(u1342 + 1, u1339, u1341, 11), 0, 0));
                                u1342 = u1342 + task.wait();
                            end;

                            arcadeStatus(false, u1335.winMessage);

                            if u1335.moneyReward then
                                u2.loadMoney(u1335.moneyReward);
                            end;
                        end);
                    elseif string.sub(u1330.Game.Value, 1, 11) == "Tic-Tac-Toe" then
                        local u1343 = u10.clone(game.ReplicatedStorage.Gameplay.Arcade[u1330.Game.Value][u1335.side]);
                        u1343.Parent = workspace.Gameplay.Entities;
                        CharScope.addEntity(u1343);
                        local u1344 = u10.raycastParamsNew();
                        u1344.FilterType = Enum.RaycastFilterType.Include;
                        u1344.FilterDescendantsInstances = { u1330.Board.Fields };
                        local u1345 = false;
                        local u1346 = nil;

                        if u1335.message then
                            Arcade.Message.Text = u1335.message;
                        end;

                        CharScope.buildSignalData("ArcadeGamePlay", { UserInputService.InputBegan, function(p1347, p1348) -- Line: 7947
                                -- upvalues: u2 (ref), u10 (ref), u1345 (ref), u1346 (ref)
                                if not (p1347.UserInputType ~= Enum.UserInputType.MouseButton1 and p1347.UserInputType ~= Enum.UserInputType.Touch or p1348) then
                                    if u2.isMouseObstructedByBlackBackground() then
                                        return;
                                    end;

                                    if p1347.UserInputType == Enum.UserInputType.Touch then
                                        u2.mobileInputServiceClick();
                                    end;

                                    if not u10.invokeTraffic.ticTacToeTurn and (u1345 and u1346) then
                                        u1345 = false;
                                        u1345 = not u10.invokeServerTraffic("ticTacToeTurn", u1346);
                                    end;
                                end;
                            end });
                        u1328 = true;
                        local u1349 = 0;

                        local function turnChanged(p1350, p1351) -- Line: 7961
                            -- upvalues: u1349 (ref), u1330 (ref), u1335 (copy), arcadeStatus (ref), u2 (ref), u1328 (ref), u1345 (ref), GameRules (ref), Arcade (ref), u1329 (ref)
                            u1349 = (u1349 + 1) % 100;
                            local v1352 = u1349;

                            if p1350 ~= "" then
                                if #p1350 > 1 then
                                    if not p1351 then
                                        arcadeStatus(false, { "Game ended", p1350 == "Draw" and "Draw (" .. u1330.Tokens.Value .. " Token)" or (string.sub(p1350, 1, 1) == u1335.side and "You won! (" .. u1330.Tokens.Value * 2 .. " Tokens)" or "You lost") });

                                        if u1335.moneyReward then
                                            u2.loadMoney(u1335.moneyReward);
                                            p1351 = nil;
                                        else
                                            p1351 = nil;
                                        end;
                                    end;

                                    return p1351;
                                end;

                                if u1328 then
                                    u1328 = false;
                                    u2.autoDecisionInviteToJoinActivity("TicTacToe");
                                end;

                                u1345 = u1335.side == p1350;
                                local v1353 = (u1345 and "Your turn - " or "Opponent\'s turn - ") .. p1350 .. " (";

                                for i = GameRules.arcadeTicTacToeTurnTime, 1, -1 do
                                    Arcade.Message.Text = v1353 .. i .. ")";
                                    task.wait(1);

                                    if v1352 ~= u1349 or not u1329 then
                                        return;
                                    end;

                                    local _ = i;
                                end;
                            end;
                        end;

                        CharScope.buildSignalData("ArcadeGamePlay", { u1330.Turn.Changed, turnChanged });
                        CharScope.taskSpawn(turnChanged, u1330.Turn.Value, true);
                        local u1354 = u1343.CFrame - u1343.Position;
                        local _, u1355, _ = u1330.Parent.CFrame:ToOrientation();
                        local Vector3_new_ret2 = Vector3.new();

                        local function getPropCFrame() -- Line: 7987
                            -- upvalues: Vector3_new_ret2 (ref), u1355 (copy), u1354 (copy)
                            return CFrame.new(Vector3_new_ret2) * CFrame.Angles(0, u1355, 0) * u1354;
                        end;

                        CharScope.buildSignalData("ArcadeGamePlay", { RunService.Heartbeat, function(p1356) -- Line: 7990
                                -- upvalues: u1343 (copy), Vector3_new_ret2 (ref), u1355 (copy), u1354 (copy)
                                u1343.CFrame = u1343.CFrame:Lerp(CFrame.new(Vector3_new_ret2) * CFrame.Angles(0, u1355, 0) * u1354, 1 - 1e-8 ^ p1356);
                            end });
                        CharScope.taskSpawn(function() -- Line: 7994
                            -- upvalues: u1329 (ref), u1345 (ref), u2 (ref), u1344 (copy), u1346 (ref), Vector3_new_ret2 (ref), u1343 (copy), u1355 (copy), u1354 (copy)
                            while u1329 do
                                if u1345 then
                                    local v1357 = u2.getMouseProperty.unitRay();

                                    if v1357 then
                                        local v1358 = workspace:Raycast(v1357.Origin, v1357.Direction * 25, u1344);
                                        local v1359;

                                        if v1358 then
                                            v1359 = tonumber(v1358.Instance.Name) or tonumber(v1358.Instance.Parent.Name);
                                        else
                                            v1359 = v1358;
                                        end;

                                        u1346 = v1359;

                                        if v1358 then
                                            if #v1358.Instance:GetChildren() == 0 then
                                                Vector3_new_ret2 = v1358.Instance.Position;

                                                if u1343.Transparency ~= 0.5 then
                                                    u1343.Transparency = 0.5;
                                                    u1343.CFrame = CFrame.new(Vector3_new_ret2) * CFrame.Angles(0, u1355, 0) * u1354;
                                                end;
                                            end;
                                        elseif u1343.Transparency ~= 1 then
                                            u1343.Transparency = 1;
                                        end;
                                    elseif u1343.Transparency ~= 1 then
                                        u1343.Transparency = 1;
                                    end;
                                elseif u1343.Transparency ~= 1 then
                                    u1343.Transparency = 1;
                                end;

                                task.wait(0.06);
                            end;

                            u1343:Destroy();
                        end);
                    end;

                    for _, v in pairs(CharScope.getConnectionsAndThreads("ArcadeGamePlay")) do
                        local ConnectionsAndThreads = CharScope.getConnectionsAndThreads("ArcadeGame");
                        table.insert(ConnectionsAndThreads, v);
                    end;

                    return;
                end;

                if u10.typeOf(u1335) == "string" then
                    u2.notify({
                        color = "red",
                        message = u1335
                    });
                end;

                Arcade.WinMessage.Text = "";
                Arcade.WinMessage2.Text = "";
                Arcade.Message.Text = u1330.Game.Value;
                Arcade.Play.ImageColor3 = Color3.fromRGB(70, 167, 81);
                u10.resetButtonColor(Arcade.Play);
                u1329 = false;
                u1328 = true;
            end));
        end;
    end;

    local AvatarShop = ScreenGui.Right.Middle.AvatarShop;
    local AvatarEditorService = game:GetService("AvatarEditorService");
    local u1360 = {
        Accessories = {
            All = {
                1,
                Enum.AvatarAssetType.Hat,
                Enum.AvatarAssetType.FaceAccessory,
                Enum.AvatarAssetType.NeckAccessory,
                Enum.AvatarAssetType.ShoulderAccessory,
                Enum.AvatarAssetType.FrontAccessory,
                Enum.AvatarAssetType.BackAccessory,
                Enum.AvatarAssetType.WaistAccessory
            },
            Head = { 2, Enum.AvatarAssetType.Hat },
            Face = { 3, Enum.AvatarAssetType.FaceAccessory },
            Neck = { 4, Enum.AvatarAssetType.NeckAccessory },
            Shoulder = { 5, Enum.AvatarAssetType.ShoulderAccessory },
            Front = { 6, Enum.AvatarAssetType.FrontAccessory },
            Back = { 7, Enum.AvatarAssetType.BackAccessory },
            Waist = { 8, Enum.AvatarAssetType.WaistAccessory }
        },
        Shirts = {
            All = {
                1,
                Enum.AvatarAssetType.Shirt,
                Enum.AvatarAssetType.ShirtAccessory,
                Enum.AvatarAssetType.JacketAccessory,
                Enum.AvatarAssetType.SweaterAccessory,
                Enum.AvatarAssetType.TShirtAccessory,
                Enum.AvatarAssetType.TShirt
            },
            ["Classic Shirts"] = { 2, Enum.AvatarAssetType.Shirt, Enum.AvatarAssetType.TShirt },
            Shirts = { 3, Enum.AvatarAssetType.ShirtAccessory },
            Jackets = { 4, Enum.AvatarAssetType.JacketAccessory },
            Sweaters = { 5, Enum.AvatarAssetType.SweaterAccessory },
            TShirts = { 6, Enum.AvatarAssetType.TShirtAccessory }
        },
        Pants = {
            All = {
                1,
                Enum.AvatarAssetType.Pants,
                Enum.AvatarAssetType.PantsAccessory,
                Enum.AvatarAssetType.ShortsAccessory,
                Enum.BundleType.Shoes
            },
            ["Classic Pants"] = { 2, Enum.AvatarAssetType.Pants },
            Pants = { 3, Enum.AvatarAssetType.PantsAccessory },
            Shorts = { 4, Enum.AvatarAssetType.ShortsAccessory },
            Shoes = { 5, Enum.BundleType.Shoes },
            ["Dresses & Skirts"] = { 6, Enum.AvatarAssetType.DressSkirtAccessory }
        },
        Heads = {
            All = {
                1,
                Enum.AvatarAssetType.Head,
                Enum.AvatarAssetType.DynamicHead,
                Enum.BundleType.DynamicHead,
                Enum.AvatarAssetType.HairAccessory,
                Enum.AvatarAssetType.Face,
                Enum.AvatarAssetType.MoodAnimation,
                Enum.AvatarAssetType.EyebrowAccessory,
                Enum.AvatarAssetType.EyelashAccessory
            },
            Heads = {
                2,
                Enum.AvatarAssetType.Head,
                Enum.AvatarAssetType.DynamicHead,
                Enum.BundleType.DynamicHead
            },
            Hair = { 3, Enum.AvatarAssetType.HairAccessory },
            Faces = {
                4,
                Enum.AvatarAssetType.Face,
                Enum.AvatarAssetType.MoodAnimation,
                Enum.AvatarAssetType.EyebrowAccessory,
                Enum.AvatarAssetType.EyelashAccessory
            }
        }
    };
    local u1361 = {};
    local u1362 = nil;

    for i, v in pairs(u10.humanoidDescriptionAvatarProperties) do
        if v == "accessory" or v == "id" then
            local v1363 = Enum.AvatarAssetType[u10.convertHumanoidDescriptionPropertiesToAssetType(i)];
            table.insert(u1361, v1363);
        end;
    end;

    local u1364 = {
        {
            BodyColor = Color3.fromRGB(90, 76, 66)
        },
        {
            BodyColor = Color3.fromRGB(124, 92, 70)
        },
        {
            BodyColor = Color3.fromRGB(175, 148, 131)
        },
        {
            BodyColor = Color3.fromRGB(204, 142, 105)
        },
        {
            BodyColor = Color3.fromRGB(234, 184, 146)
        },
        {
            BodyColor = Color3.fromRGB(86, 66, 54)
        },
        {
            BodyColor = Color3.fromRGB(99, 95, 98)
        },
        {
            BodyColor = Color3.fromRGB(205, 205, 205)
        },
        {
            BodyColor = Color3.fromRGB(248, 248, 248)
        }
    };

    local function purchaseAvatarAssetOnRoblox(p1365) -- Line: 8067
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        if p1365.AssetType then
            MarketplaceService:PromptPurchase(LocalPlayer, p1365.Id);

            return;
        end;

        MarketplaceService:PromptBundlePurchase(LocalPlayer, p1365.Id);
    end;

    local function purchaseAvatarAssets(p1366, u1367, u1368) -- Line: 8075
        -- upvalues: u10 (ref), u1 (ref)
        local v1369, v1370, v1371, v1372 = u10.avatarShopPurchaseCost(nil, p1366);

        if v1370 <= 0 then
            return false, v1370, v1371, v1372;
        end;

        u1.payment("Purchase", v1370 .. "x Avatar Assets", -v1369, false, function(p1373, p1374) -- Line: 8078
            -- upvalues: u1367 (copy), u1368 (copy)
            if not p1373 then
                if u1367() == true then
                    p1374("Purchased a product", true);

                    if u1368 then
                        u1368();
                    end;

                    return true;
                end;

                p1374();
            end;
        end);

        return true, v1370, v1371, v1372;
    end;

    local function activateAvatarShopServer(p1375, p1376, u1377) -- Line: 8093
        -- upvalues: u10 (ref), u13 (copy), u2 (ref), u1 (ref)
        if p1375 then
            local v1378 = u10.invokeServerTraffic("avatarShop", u13, "activate", {
                on = true,
                prompt = p1376.prompt
            });
            local v1379 = u10.typeOf(v1378) == "string" and u10.getInstanceReference(v1378, 20);

            if v1379 then
                u1377(v1379);
            end;
        else
            local function serverLeave(p1380) -- Line: 8101
                -- upvalues: u10 (ref), u13 (ref), u2 (ref)
                local v1381 = u10.invokeServerTraffic("avatarShop", u13, "activate", {
                    on = false,
                    updateAvatar = p1380 or nil
                });

                if v1381 == true then
                    return true;
                end;

                if u10.typeOf(v1381) == "string" then
                    u2.notify({
                        color = "red",
                        message = v1381
                    });
                end;
            end;

            local v1382, v1383, v1384;

            if p1376.updateAvatar then
                local function u1385() -- Line: 8108
                    -- upvalues: serverLeave (copy)
                    return serverLeave(true);
                end;

                local v1386, v1387;
                v1386, v1387, v1382, v1383 = u10.avatarShopPurchaseCost(nil, p1376.avatarShopCharacter);

                if v1387 > 0 then
                    u1.payment("Purchase", v1387 .. "x Avatar Assets", -v1386, false, function(p1388, p1389) -- Line: 8078
                        -- upvalues: u1385 (copy), u1377 (copy)
                        if not p1388 then
                            if u1385() == true then
                                p1389("Purchased a product", true);

                                if u1377 then
                                    u1377();
                                end;

                                return true;
                            end;

                            p1389();
                        end;
                    end);
                    v1384 = true;
                else
                    v1384 = false;
                end;
            else
                v1384 = nil;
                v1382 = nil;
                v1383 = nil;
            end;

            if not v1384 then
                if v1382 then
                    v1383 = v1382 > 0 and true or v1383;
                end;

                if serverLeave(v1383) then
                    u1377();
                end;
            end;
        end;
    end;

    local function getAssetImage(p1390) -- Line: 8114
        if p1390.AssetType then
            return "rbxthumb://type=Asset&id=" .. p1390.Id .. "&w=150&h=150";
        end;

        return "rbxthumb://type=BundleThumbnail&id=" .. p1390.Id .. "&w=150&h=150";
    end;

    local function findWornAssets() -- Line: 8119
        -- upvalues: u1362 (ref), u10 (ref)
        local u1391 = nil;
        u1391 = {
            ids = {},

            update = function() -- Line: 8123, Name: update
                -- upvalues: u1391 (ref), u1362 (ref), u10 (ref)
                u1391.bodyColor = u1362.HeadColor;
                u1391.ids = {};

                for i, v in pairs(u10.humanoidDescriptionAvatarProperties) do
                    if v == "id" then
                        u1391.ids[u1362[i]] = true;
                    elseif v == "color" and (u1391.bodyColor and u1391.bodyColor ~= u1362[i]) then
                        u1391.bodyColor = nil;
                    end;
                end;

                for _, v in pairs(u1362:GetAccessories(true)) do
                    u1391.ids[v.AssetId] = true;
                end;
            end,

            isWearing = function(p1392) -- Line: 8136, Name: isWearing
                -- upvalues: u1391 (ref)
                return u1391.ids[p1392];
            end,

            isColored = function(p1393) -- Line: 8139, Name: isColored
                -- upvalues: u1391 (ref)
                return u1391.bodyColor == p1393;
            end
        };

        return u1391;
    end;

    local function clearPanelSlots() -- Line: 8146
        -- upvalues: AvatarShop (copy)
        for _, child in pairs(AvatarShop.Panel.Assets._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") and child.Visible then
                child:Destroy();
            end;
        end;
    end;

    local function clearWornSlots() -- Line: 8151
        -- upvalues: AvatarShop (copy)
        for _, child in pairs(AvatarShop.Worn._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") and child.Visible then
                child:Destroy();
            end;
        end;
    end;

    local function clearBundleSlots() -- Line: 8156
        -- upvalues: AvatarShop (copy)
        for _, child in pairs(AvatarShop.BundleDetails.Assets._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") and child.Visible then
                child:Destroy();
            end;
        end;
    end;

    local u1394 = nil;
    local u1395 = {
        Bestselling = Enum.CatalogSortType.Bestselling,
        ["Most Favorited"] = Enum.CatalogSortType.MostFavorited,
        ["Recently Created"] = Enum.CatalogSortType.RecentlyCreated,
        Relevance = Enum.CatalogSortType.Relevance,
        ["Price High"] = Enum.CatalogSortType.PriceHighToLow,
        ["Price Low"] = Enum.CatalogSortType.PriceLowToHigh
    };
    local u1396 = {
        sortType = nil,
        includeOffSale = true,
        creatorName = nil,
        minPrice = nil,
        maxPrice = nil
    };
    OffsetCamera.Position = UDim2.fromScale(-0.25, 0);
    OffsetCamera.Size = UDim2.fromScale(1, 1);

    function u1.activateAvatarShop(u1397) -- Line: 8169
        -- upvalues: u2 (ref), CharScope (ref), LocalPlayer (ref), u10 (ref), u1394 (ref), ScreenGui (copy), clearPanelSlots (copy), clearWornSlots (copy), clearBundleSlots (copy), OffsetCamera (ref), AvatarShop (copy), u13 (copy), u1 (ref), u1362 (ref), u1396 (copy), findWornAssets (copy), TweenService (ref), AvatarEditorService (copy), MarketplaceService (ref), AssetService (ref), UserInputService (ref), PlayerGui (ref), FrontGui (copy), u1360 (copy), u1395 (copy), Stuff (ref), AvatarAssets (ref), u1361 (copy), u1364 (copy)
        if u2.openedGui and u2.openedGui ~= "AvatarShop" then
            return;
        end;

        local function u1398() -- Line: 8171
            -- upvalues: CharScope (ref), LocalPlayer (ref), u1397 (copy), u2 (ref), u10 (ref), u1394 (ref), ScreenGui (ref), clearPanelSlots (ref), clearWornSlots (ref), clearBundleSlots (ref)
            CharScope.setConnectionsAndThreads("AvatarShop");
            CharScope.setConnectionsAndThreads("AvatarShopPanel");
            CharScope.setConnectionsAndThreads("AvatarShopUpdate");
            LocalPlayer.CameraMinZoomDistance = u1397 and 4 or game.StarterPlayer.CameraMinZoomDistance;
            u2.activateDepthOfFieldDynamicFocus(u1397);
            u10.setCameraProperties("3", u1397 and {
                CameraSubject = u1394
            });
            ScreenGui.Center.Bottom.Visible = not u1397;
            ScreenGui.Center.Top.Visible = not u1397;
            clearPanelSlots();
            clearWornSlots();
            clearBundleSlots();
        end;

        if u1397 then
            local function v1516(p1399) -- Line: 8196
                -- upvalues: u1394 (ref), u1362 (ref), u1398 (copy), OffsetCamera (ref), u10 (ref), u1396 (ref), findWornAssets (ref), u2 (ref), AvatarShop (ref), CharScope (ref), u13 (ref), TweenService (ref), clearPanelSlots (ref), clearWornSlots (ref), u1397 (copy), AvatarEditorService (ref), MarketplaceService (ref), LocalPlayer (ref), clearBundleSlots (ref), AssetService (ref), UserInputService (ref), PlayerGui (ref), FrontGui (ref), u1360 (ref), u1395 (ref), Stuff (ref), AvatarAssets (ref), u1 (ref), u1361 (ref), u1364 (ref)
                u1394 = p1399;
                u1362 = u1394.CurrentDescription;
                u1398();
                OffsetCamera.Start();
                local u1400 = nil;
                local u1401 = nil;
                local u1402 = nil;
                local u1403 = u10.deepCopyTable(u1396);
                local u1404 = findWornAssets();
                local u1405 = {};
                local u1406 = nil;
                local u1407 = nil;
                local u1408 = nil;
                local u1409 = nil;
                local u1410 = nil;
                local u1411 = false;

                local function makeSureUnsavedOutfitDoesntGetLost() -- Line: 8213
                    -- upvalues: u2 (ref), u1411 (ref)
                    return u2.readPlayerData("SelectedAvatarOutfit") ~= "_Unsaved" and not u1411 and true or u2.mainBox({
                        case = "Decision",
                        headline = "Are you sure you want to continue? Your current outfit isn\'t saved",
                        button = "CONTINUE",
                        button2 = "CANCEL"
                    }) == 1;
                end;

                local u1416 = u10.scrollingListSystem(AvatarShop.Panel.Assets._ScrollingList.Scroll, 0.25, {
                    dynEntireTableLoaded = function() -- Line: 8256, Name: dynEntireTableLoaded
                        -- upvalues: u1400 (ref)
                        if u1400 then
                            u1400();
                        end;
                    end,

                    scrollBar = AvatarShop.Panel.Assets.ScrollBar,

                    dynamicallyLoadListElementsFromTable = function(p1412, u1413) -- Line: 8221, Name: dynamicallyLoadListElementsFromTable
                        -- upvalues: AvatarShop (ref), u10 (ref), u1405 (ref), u1404 (copy), CharScope (ref), u13 (ref), u2 (ref)
                        AvatarShop.Panel.Assets._ScrollingList.Scroll.SlotPreview.Viewport.Archivable = u1413.Outfit;
                        local u1414 = u10.clone(AvatarShop.Panel.Assets._ScrollingList.Scroll.SlotPreview);
                        u1405[u1414] = u1413;
                        u1414.Name = "Slot";
                        u1414.Visible = true;
                        u1414.Parent = AvatarShop.Panel.Assets._ScrollingList.Scroll;

                        if u1413.BodyColor then
                            u10.fitText(u1414.TextLabel, "Body Color", 3);
                            u1414.More.Visible = false;
                            u1414.ImageColor3 = u1413.BodyColor;

                            if u1404.isColored(u1413.BodyColor) then
                                u1414.Selection.Visible = true;
                            end;
                        elseif u1413.Outfit then
                            u1414.More.Visible = false;
                            u10.fitText(u1414.TextLabel, u1413.Name == "_Unsaved" and "Unsaved" or u1413.Name, 3);
                            local Dummy = u1414.Viewport.Dummy;

                            if u1413.CantDelete then
                                u1414:SetAttribute("CantDelete", true);
                            end;

                            CharScope.taskSpawn(function() -- Line: 8238
                                -- upvalues: u10 (ref), Dummy (copy), u1413 (copy), u13 (ref), u1414 (copy)
                                u10.applyDescription(Dummy.Humanoid, u1413.Outfit, u13:GetAttribute("AgeLook"));

                                if u1414.Parent then
                                    Dummy.Parent = workspace;
                                    task.wait();

                                    if u1414.Parent then
                                        Dummy.Parent = u1414.Viewport;

                                        return;
                                    end;

                                    Dummy:Destroy();
                                end;
                            end);

                            if u2.readPlayerData("SelectedAvatarOutfit") == u1413.Name then
                                u1414.Selection.Visible = true;
                            end;
                        else
                            u10.fitText(u1414.TextLabel, u1413.Name, 3);
                            local v1415;

                            if u1413.AssetType then
                                v1415 = "rbxthumb://type=Asset&id=" .. u1413.Id .. "&w=150&h=150";
                            else
                                v1415 = "rbxthumb://type=BundleThumbnail&id=" .. u1413.Id .. "&w=150&h=150";
                            end;

                            u1414.Icon.Image = v1415;

                            if u1404.isWearing(u1413.Id) then
                                u1414.Selection.Visible = true;
                            end;
                        end;
                    end
                });
                CharScope.buildSignalData("AvatarShop", unpack(u1416.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", u1416.cleanUp);
                local u1417 = u10.scrollingListSystem(AvatarShop.Panel.SubMenu._ScrollingList.Scroll, 0.1, {
                    horizontal = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(u1417.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", u1417.cleanUp);
                local u1418 = u10.scrollingListSystem(AvatarShop.Worn._ScrollingList.Scroll, 0.15, {});
                CharScope.buildSignalData("AvatarShop", unpack(u1418.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", u1418.cleanUp);
                local u1419 = u10.scrollingListSystem(AvatarShop.BundleDetails.Assets._ScrollingList.Scroll, 0.25, {
                    scrollBar = AvatarShop.BundleDetails.Assets.ScrollBar
                });
                CharScope.buildSignalData("AvatarShop", unpack(u1419.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", u1419.cleanUp);

                local function mouseOverSlot(u1420) -- Line: 8268
                    -- upvalues: TweenService (ref), u10 (ref)
                    local function on(p1421) -- Line: 8269
                        -- upvalues: TweenService (ref), u1420 (copy)
                        TweenService:Create(u1420.TextLabel, TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            TextTransparency = p1421 and 0 or 1
                        }):Play();
                    end;

                    on(true);

                    while u10.isInFrame(u1420) do
                        task.wait(0.03);

                        if not u1420.Parent then
                            return;
                        end;
                    end;

                    on(false);
                end;

                local function updateOutfitSlots() -- Line: 8276
                    -- upvalues: u2 (ref), u10 (ref), u1416 (copy)
                    local v1422 = {};

                    for i, v in pairs(u2.readPlayerData("AvatarOutfits")) do
                        local HumanoidDescription = Instance.new("HumanoidDescription");
                        u10.serializeHumanoidDescription(HumanoidDescription, v);
                        local v1423 = {
                            Outfit = HumanoidDescription,
                            Name = i,
                            CantDelete = i == "_Unsaved" and true or nil
                        };

                        if i == "_Unsaved" then
                            table.insert(v1422, 1, v1423);
                        else
                            table.insert(v1422, v1423);
                        end;
                    end;

                    u1416.dynSetTable(v1422);
                end;

                local function updateAllSlotsSelection() -- Line: 8286
                    -- upvalues: CharScope (ref), u1404 (copy), u1408 (ref), clearPanelSlots (ref), updateOutfitSlots (copy), AvatarShop (ref), u1405 (ref), u2 (ref), u1406 (ref), clearWornSlots (ref), u10 (ref), u1410 (ref), u1401 (ref), u1362 (ref), u1418 (copy), u1394 (ref), u1411 (ref)
                    CharScope.setConnectionsAndThreads("AvatarShopUpdate");
                    u1404.update();

                    local function _(p1424, p1425) -- Line: 8289
                        if p1424.Selection.Visible ~= (p1425 or false) then
                            p1424.Selection.Visible = not p1424.Selection.Visible;
                        end;
                    end;

                    if u1408 == "Outfits" then
                        clearPanelSlots();
                        updateOutfitSlots();
                    else
                        for _, child in pairs(AvatarShop.Panel.Assets._ScrollingList.Scroll:GetChildren()) do
                            if u1405[child] then
                                if u1405[child].BodyColor then
                                    local v1426 = u1404.isColored(u1405[child].BodyColor);

                                    if child.Selection.Visible ~= (v1426 or false) then
                                        child.Selection.Visible = not child.Selection.Visible;
                                    end;
                                elseif u1405[child].Outfit then
                                    local v1427 = u2.readPlayerData("SelectedAvatarOutfit") == u1405[child].Name;

                                    if child.Selection.Visible ~= (v1427 or false) then
                                        child.Selection.Visible = not child.Selection.Visible;
                                    end;
                                else
                                    local v1428 = u1404.isWearing(u1405[child].Id);

                                    if child.Selection.Visible ~= (v1428 or false) then
                                        child.Selection.Visible = not child.Selection.Visible;
                                    end;
                                end;
                            end;
                        end;
                    end;

                    if u1406 then
                        for _, child in pairs(AvatarShop.BundleDetails.Assets._ScrollingList.Scroll:GetChildren()) do
                            if u1406[child] then
                                local v1429 = u1404.isWearing(u1406[child].Id);

                                if child.Selection.Visible ~= (v1429 or false) then
                                    child.Selection.Visible = not child.Selection.Visible;
                                end;
                            end;
                        end;
                    end;

                    clearWornSlots();
                    local u1430 = 0;

                    local function createSlot(u1431) -- Line: 8316
                        -- upvalues: u1430 (ref), u10 (ref), AvatarShop (ref), CharScope (ref), u2 (ref), u1410 (ref), u1401 (ref)
                        u1430 = u1430 + 1;
                        local v1432 = u10.clone(AvatarShop.Worn._ScrollingList.Scroll.SlotPreview);
                        v1432.Name = "Slot";
                        v1432.Visible = true;
                        v1432.LayoutOrder = u1431.LayoutOrder;
                        local v1433;

                        if u1431.AssetType then
                            v1433 = "rbxthumb://type=Asset&id=" .. u1431.Id .. "&w=150&h=150";
                        else
                            v1433 = "rbxthumb://type=BundleThumbnail&id=" .. u1431.Id .. "&w=150&h=150";
                        end;

                        v1432.Icon.Image = v1433;
                        v1432.Parent = AvatarShop.Worn._ScrollingList.Scroll;
                        CharScope.buildSignalData("AvatarShopUpdate", u2.mouseButton(v1432.More, function() -- Line: 8324
                            -- upvalues: u1410 (ref), u1431 (copy)
                            u1410(u1431.Id);
                        end, {
                            addMobileButton = true
                        }));
                        CharScope.buildSignalData("AvatarShopUpdate", u2.mouseButton(v1432, function() -- Line: 8327
                            -- upvalues: u1401 (ref), u1431 (copy)
                            u1401("wear", {
                                wear = false,
                                assets = { u1431 }
                            });
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    end;

                    local v1434 = 0;
                    local v1435 = {};

                    for i, v in pairs(u10.humanoidDescriptionAvatarProperties) do
                        if v == "id" and u1362[i] ~= 0 then
                            createSlot({
                                LayoutOrder = 100,
                                AssetType = true,
                                Id = u1362[i]
                            });
                            v1434 = 1;
                        end;
                    end;

                    local Accessories = u1362:GetAccessories(true);

                    if #Accessories > 0 then
                        for _, v in pairs(Accessories) do
                            v1434 = v1434 == 1 and 2 or v1434;
                            createSlot({
                                LayoutOrder = 0,
                                AssetType = true,
                                Id = v.AssetId
                            });
                        end;
                    end;

                    table.sort(v1435, function(p1436, p1437) -- Line: 8346
                        return p1436.Name < p1437.Name;
                    end);

                    for _, v in pairs(v1435) do
                        v.LayoutOrder = v.LayoutOrder + 1;
                        createSlot(v);
                    end;

                    AvatarShop.Worn._ScrollingList.Scroll.Separator.Visible = v1434 == 2;
                    u1418.limitYScrollListener();
                    local v1438, _ = u10.avatarShopPurchaseCost(nil, u1394);
                    AvatarShop.Panel.Buttons.Save.TextLabel.Text = v1438 > 0 and ("SAVE (＄" .. u10.commaValue(v1438) .. ")" or "SAVE") or "SAVE";
                    u1411 = v1438 > 0;
                end;

                u1401 = function(p1439, p1440) -- Line: 8358, Name: avatarShopServer
                    -- upvalues: u1402 (ref), u10 (ref), u1397 (ref), u13 (ref), updateAllSlotsSelection (copy), u2 (ref)
                    local v1441 = p1440 or {};

                    if p1439 == "wear" then
                        local v1442 = {};

                        for _, v in pairs(v1441.assets) do
                            if v.BundleType then
                                return u1402(v.Id);
                            end;

                            table.insert(v1442, v.BodyColor or v.Id);
                        end;

                        v1441.assets = v1442;
                    end;

                    if not u10.invokeTraffic.avatarShop then
                        v1441.prompt = u1397;
                        local v1443 = u10.invokeServerTraffic("avatarShop", u13, p1439, v1441);

                        if v1443 == true then
                            updateAllSlotsSelection();

                            return true;
                        end;

                        if u10.typeOf(v1443) == "string" then
                            u2.notify({
                                color = "red",
                                message = v1443
                            });
                        end;
                    end;
                end;

                local u1444 = nil;

                u1410 = function(u1445) -- Line: 8381, Name: showItemDetails
                    -- upvalues: u1416 (copy), u1417 (copy), u1418 (copy), u1444 (ref), u10 (ref), AvatarEditorService (ref), AvatarShop (ref), u1404 (copy)
                    u1416.freezed = u1445 and true or false;
                    u1417.freezed = u1445 and true or false;
                    u1418.freezed = u1445 and true or false;

                    if u1445 then
                        local v1446;

                        if u10.typeOf(u1445) == "number" then
                            local v1447;
                            v1447, v1446 = pcall(function() -- Line: 8390
                                -- upvalues: AvatarEditorService (ref), u1445 (copy)
                                return AvatarEditorService:GetItemDetailsAsync(u1445, Enum.AvatarItemType.Asset);
                            end);

                            if not v1447 then
                                return;
                            end;
                        else
                            v1446 = u1445;
                        end;

                        u1444 = v1446;
                        AvatarShop.ItemDetails.AssetName.Text = v1446.Name;
                        AvatarShop.ItemDetails.CreatorName.Visible = v1446.CreatorName;
                        AvatarShop.ItemDetails.TextLabel.Visible = v1446.CreatorName;

                        if v1446.CreatorName then
                            AvatarShop.ItemDetails.CreatorName.Text = v1446.CreatorName;
                        end;

                        local v1448;

                        if v1446.AssetType then
                            v1448 = "rbxthumb://type=Asset&id=" .. v1446.Id .. "&w=150&h=150";
                        else
                            v1448 = "rbxthumb://type=BundleThumbnail&id=" .. v1446.Id .. "&w=150&h=150";
                        end;

                        AvatarShop.ItemDetails.Slot.Icon.Image = v1448;
                        AvatarShop.ItemDetails.Wear.TextLabel.Text = u1404.isWearing(v1446.Id) and "TAKE OFF" or "WEAR";
                        local v1449 = {};

                        if v1446.IsPurchasable == false or v1446.PriceStatus == "Off Sale" then
                            table.insert(v1449, "<font color=\'rgb(255, 232, 147)\'>Not available on roblox</font>");
                        end;

                        if v1446.TotalQuantity and (v1446.TotalQuantity > 0 and v1446.UnitsAvailableForConsumption) then
                            table.insert(v1449, "<font color=\'rgb(155, 255, 158)\'>Limited (" .. v1446.UnitsAvailableForConsumption .. " left)</font>");
                        end;

                        AvatarShop.ItemDetails.MoreDetails.Text = table.concat(v1449, ", ");
                    else
                        u1444 = nil;
                    end;

                    u10.guiTransition(AvatarShop.ItemDetails, "Size", 0.9, u1445);

                    return true;
                end;

                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.ItemDetails.Close, function() -- Line: 8410
                    -- upvalues: u1410 (ref)
                    u1410();
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.ItemDetails.Wear, function() -- Line: 8413
                    -- upvalues: AvatarShop (ref), u1401 (ref), u1444 (ref)
                    local v1450 = AvatarShop.ItemDetails.Wear.TextLabel.Text == "WEAR";

                    if u1401("wear", {
                        assets = { u1444 },
                        wear = v1450
                    }) then
                        AvatarShop.ItemDetails.Wear.TextLabel.Text = v1450 and "TAKE OFF" or "WEAR";
                    end;
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.ItemDetails.BuyOnRoblox, function() -- Line: 8420
                    -- upvalues: u1444 (ref), MarketplaceService (ref), LocalPlayer (ref)
                    local v1451 = u1444;

                    if v1451.AssetType then
                        MarketplaceService:PromptPurchase(LocalPlayer, v1451.Id);

                        return;
                    end;

                    MarketplaceService:PromptBundlePurchase(LocalPlayer, v1451.Id);
                end));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.ItemDetails.Wear));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.ItemDetails.Close));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.ItemDetails.BuyOnRoblox));

                u1402 = function(u1452) -- Line: 8427, Name: showBundleDetails
                    -- upvalues: u1416 (copy), u1417 (copy), u1418 (copy), clearBundleSlots (ref), u1406 (ref), AssetService (ref), AvatarShop (ref), u10 (ref), u1404 (copy), CharScope (ref), u2 (ref), u1401 (ref), u1410 (ref), mouseOverSlot (copy), u1402 (ref), u1419 (copy)
                    u1416.freezed = u1452 and true or false;
                    u1417.freezed = u1452 and true or false;
                    u1418.freezed = u1452 and true or false;
                    clearBundleSlots();

                    if u1452 then
                        local success, result = pcall(function() -- Line: 8435
                            -- upvalues: AssetService (ref), u1452 (copy)
                            return AssetService:GetBundleDetailsAsync(u1452);
                        end);

                        if not success then
                            return;
                        end;

                        u1406 = {};
                        AvatarShop.BundleDetails.TextLabel.Text = result.Name;

                        for _, v in pairs(result.Items) do
                            if v.Type == "Asset" then
                                v.AssetType = true;
                                local u1453 = u10.clone(AvatarShop.BundleDetails.Assets._ScrollingList.Scroll.SlotPreview);
                                u1406[u1453] = v;
                                u1453.Name = "Slot";
                                u1453.Visible = true;
                                local v1454;

                                if v.AssetType then
                                    v1454 = "rbxthumb://type=Asset&id=" .. v.Id .. "&w=150&h=150";
                                else
                                    v1454 = "rbxthumb://type=BundleThumbnail&id=" .. v.Id .. "&w=150&h=150";
                                end;

                                u1453.Icon.Image = v1454;

                                if u1404.isWearing(v.Id) then
                                    u1453.Selection.Visible = true;
                                end;

                                u1453.Parent = AvatarShop.BundleDetails.Assets._ScrollingList.Scroll;
                                u10.fitText(u1453.TextLabel, v.Name or "", 3);
                                CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(u1453, function() -- Line: 8452
                                    -- upvalues: u1401 (ref), v (copy), u1453 (copy)
                                    u1401("wear", {
                                        assets = { v },
                                        wear = not u1453.Selection.Visible
                                    });
                                end));
                                CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(u1453.More, function() -- Line: 8455
                                    -- upvalues: u1410 (ref), v (copy)
                                    u1410(v.Id);
                                end));
                                CharScope.buildSignalData("AvatarShopPanel", { u1453.MouseEnter, function() -- Line: 8458
                                        -- upvalues: mouseOverSlot (ref), u1453 (copy)
                                        mouseOverSlot(u1453);
                                    end });
                            end;
                        end;

                        CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(AvatarShop.BundleDetails.Close, function() -- Line: 8463
                            -- upvalues: u1402 (ref)
                            u1402();
                        end));
                        CharScope.buildSignalData("AvatarShopPanel", u10.buttonHoverSignalData(AvatarShop.BundleDetails.Close));
                        u1419.limitYScrollListener();
                    else
                        u1406 = nil;
                    end;

                    u10.guiTransition(AvatarShop.BundleDetails, "Size", 0.9, u1452);

                    return true;
                end;

                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.BundleDetails.WearAll, function() -- Line: 8472
                    -- upvalues: u1401 (ref), u1406 (ref)
                    u1401("wear", {
                        wear = true,
                        assets = u1406
                    });
                end));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.BundleDetails.WearAll));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.SearchSettings.Close));

                local function showSearchSettings(p1455) -- Line: 8478
                    -- upvalues: u1416 (copy), u1417 (copy), u1418 (copy), AvatarShop (ref), u1403 (ref), u10 (ref)
                    u1416.freezed = p1455 and true or false;
                    u1417.freezed = p1455 and true or false;
                    u1418.freezed = p1455 and true or false;

                    if p1455 then
                        AvatarShop.SearchSettings.Creator.TextBoxFrame.TextBox.Text = u1403.creatorName or "";
                        AvatarShop.SearchSettings.MaxPrice.TextBoxFrame.TextBox.Text = u1403.maxPrice or "";
                        AvatarShop.SearchSettings.MinPrice.TextBoxFrame.TextBox.Text = u1403.minPrice or "";
                        AvatarShop.SearchSettings.Sort.Text.TextLabel.Text = u1403.sortType or "Relevance";
                    end;

                    if (p1455 and true or false) ~= AvatarShop.SearchSettings.Visible then
                        u10.guiTransition(AvatarShop.SearchSettings, "Size", 0.9, p1455);
                    end;
                end;

                local v1456 = u10.textBoxSystem(AvatarShop.SearchSettings.Creator.TextBoxFrame, {
                    enableScrolling = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1456.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", v1456.cleanUp);
                local v1457 = u10.textBoxSystem(AvatarShop.SearchSettings.MaxPrice.TextBoxFrame, {
                    enableScrolling = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1457.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", v1457.cleanUp);
                local v1458 = u10.textBoxSystem(AvatarShop.SearchSettings.MinPrice.TextBoxFrame, {
                    enableScrolling = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1458.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", v1458.cleanUp);
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.SearchSettings.Close, function() -- Line: 8501
                    -- upvalues: showSearchSettings (copy)
                    showSearchSettings();
                end));
                CharScope.buildSignalData("AvatarShop", { AvatarShop.SearchSettings.MaxPrice.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), function() -- Line: 8504
                        -- upvalues: AvatarShop (ref), u10 (ref)
                        AvatarShop.SearchSettings.MaxPrice.TextBoxFrame.TextBox.Text = u10.toOnlyNumbers(AvatarShop.SearchSettings.MaxPrice.TextBoxFrame.TextBox.Text);
                    end });
                CharScope.buildSignalData("AvatarShop", { AvatarShop.SearchSettings.MinPrice.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), function() -- Line: 8507
                        -- upvalues: AvatarShop (ref), u10 (ref)
                        AvatarShop.SearchSettings.MinPrice.TextBoxFrame.TextBox.Text = u10.toOnlyNumbers(AvatarShop.SearchSettings.MinPrice.TextBoxFrame.TextBox.Text);
                    end });
                local v1459 = u2.addFunctionalityToOptionMenuGui(AvatarShop.SearchSettings.Sort, {
                    startOption = "Relevance"
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1459));
                local v1460 = u2.addFunctionalityToSwitchGui(AvatarShop.SearchSettings.IncludeOffset, {
                    isOn = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1460));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.SearchSettings.Apply, function() -- Line: 8514
                    -- upvalues: AvatarShop (ref), u1403 (ref), showSearchSettings (copy), u1407 (ref), u1408 (ref), u1409 (ref)
                    local Text = AvatarShop.SearchSettings.Creator.TextBoxFrame.TextBox.Text;

                    if Text == "" or not Text then
                        Text = nil;
                    end;

                    u1403.creatorName = Text;
                    local Text2 = AvatarShop.SearchSettings.MaxPrice.TextBoxFrame.TextBox.Text;

                    if Text2 == "" or not Text2 then
                        Text2 = nil;
                    end;

                    u1403.maxPrice = Text2;
                    local Text3 = AvatarShop.SearchSettings.MinPrice.TextBoxFrame.TextBox.Text;

                    if Text3 == "" or not Text3 then
                        Text3 = nil;
                    end;

                    u1403.minPrice = Text3;
                    u1403.includeOffSale = AvatarShop.SearchSettings.IncludeOffset:GetAttribute("On") or nil;
                    u1403.sortType = AvatarShop.SearchSettings.Sort.Text.TextLabel.Text;
                    showSearchSettings();
                    u1407(u1408, {
                        subPanel = u1409
                    });
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.SearchSettings.Reset, function() -- Line: 8526
                    -- upvalues: u1403 (ref), u10 (ref), u1396 (ref), showSearchSettings (copy)
                    u1403 = u10.deepCopyTable(u1396);
                    showSearchSettings(true);
                end));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.SearchSettings.Reset));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.SearchSettings.Close));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.SearchSettings.Apply));

                local function connectCatalogSlots() -- Line: 8534
                    -- upvalues: u1405 (ref), CharScope (ref), UserInputService (ref), u2 (ref), u10 (ref), PlayerGui (ref), AvatarShop (ref), FrontGui (ref), u1410 (ref), makeSureUnsavedOutfitDoesntGetLost (copy), u1401 (ref), mouseOverSlot (copy), clearPanelSlots (ref)
                    u1405 = {};
                    CharScope.setConnectionsAndThreads("AvatarShopPanel");
                    CharScope.buildSignalData("AvatarShopPanel", { UserInputService.InputBegan, function(p1461) -- Line: 8538
                            -- upvalues: u2 (ref), u10 (ref), PlayerGui (ref), AvatarShop (ref), FrontGui (ref), u1405 (ref), u1410 (ref), makeSureUnsavedOutfitDoesntGetLost (ref), u1401 (ref)
                            if p1461.UserInputType == Enum.UserInputType.MouseButton1 or p1461.UserInputType == Enum.UserInputType.Touch and u2.mobileInputServiceClick() then
                                local MousePos = u10.getMousePos();

                                for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
                                    if v:IsDescendantOf(AvatarShop.Panel.Assets._ScrollingList.Scroll) and not (FrontGui.Center.Middle.MainBox.Visible or (AvatarShop.BundleDetails.Visible or (AvatarShop.SearchSettings.Visible or AvatarShop.ItemDetails.Visible))) then
                                        if v.Name == "MoreMobileButton" and p1461.UserInputType == Enum.UserInputType.Touch then
                                            local v1462 = u1405[v.Parent.Parent];
                                            u1410(v1462.CreatorName and v1462 and v1462 or v1462.Id);

                                            return;
                                        end;

                                        if v.Name == "More" and p1461.UserInputType == Enum.UserInputType.MouseButton1 then
                                            local v1463 = u1405[v.Parent];
                                            u1410(v1463.CreatorName and v1463 and v1463 or v1463.Id);

                                            return;
                                        end;

                                        if v.Name == "Slot" then
                                            local v1464 = u1405[v];

                                            if not v1464.Outfit then
                                                u1401("wear", {
                                                    assets = { v1464 },
                                                    wear = not v.Selection.Visible
                                                });

                                                return;
                                            end;

                                            if v:GetAttribute("DeleteOutfit") then
                                                if u2.mainBox({
                                                    case = "Decision",
                                                    button = "DELETE",
                                                    button2 = "CANCEL",
                                                    headline = "Do you want to delete the outfit " .. v1464.Name .. "?"
                                                }) ~= 1 then
                                                    return;
                                                end;
                                            elseif v.Selection.Visible or not makeSureUnsavedOutfitDoesntGetLost() then
                                                return;
                                            end;

                                            u1401("manageOutfit", {
                                                outfitName = v1464.Name,
                                                delete = v:GetAttribute("DeleteOutfit")
                                            });

                                            return;
                                        end;
                                    end;
                                end;
                            end;
                        end });
                    CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", CharScope.taskDefer(function() -- Line: 8565
                        -- upvalues: u10 (ref), PlayerGui (ref), AvatarShop (ref), mouseOverSlot (ref)
                        while true do
                            local MousePos = u10.getMousePos();

                            for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
                                if v:IsDescendantOf(AvatarShop.Panel.Assets._ScrollingList.Scroll) and not (AvatarShop.BundleDetails.Visible or (AvatarShop.SearchSettings.Visible or (AvatarShop.ItemDetails.Visible or v.Name ~= "Slot"))) then
                                    mouseOverSlot(v);
                                end;
                            end;

                            task.wait(0.1);
                        end;
                    end));
                    clearPanelSlots();
                end;

                local function dynamicLoadAssetsOrInventory(u1465, u1466) -- Line: 8579
                    -- upvalues: u1400 (ref), CharScope (ref), u10 (ref)
                    u1400 = nil;

                    return CharScope.taskDefer(function() -- Line: 8581
                        -- upvalues: u10 (ref), u1465 (copy), CharScope (ref), u1466 (copy), u1400 (ref)
                        while u10.rest("avatarShopSearchCatalog", 1) do
                            task.wait(0.5);
                        end;

                        local u1467;

                        while true do
                            local success, result = pcall(function() -- Line: 8585
                                -- upvalues: u1465 (ref)
                                return u1465();
                            end);
                            u1467 = result;

                            if success then
                                break;
                            end;

                            task.wait(6);
                        end;

                        local u1468 = false;

                        u1400 = function() -- Line: 8589, Name: dynEntireTableLoaded
                            -- upvalues: u1468 (ref), CharScope (ref), u10 (ref), u1466 (ref), u1467 (ref)
                            if not u1468 then
                                u1468 = true;
                                CharScope.setThreadOrCleanUpFunctionIndex("AvatarShopPanel", "dynEntireTableLoaded", CharScope.taskDefer(function() -- Line: 8592
                                    -- upvalues: u10 (ref), u1466 (ref), u1467 (ref), u1468 (ref)
                                    while u10.rest("avatarShopSearchCatalog", 1) do
                                        task.wait(0.5);
                                    end;

                                    u1466(u1467);
                                    u1468 = false;
                                end));
                            end;
                        end;

                        u1466(u1467, true);
                    end);
                end;

                local function loadSubMenu(p1469, p1470, p1471) -- Line: 8603
                    -- upvalues: AvatarShop (ref), u10 (ref), CharScope (ref), u2 (ref), u1407 (ref), u1408 (ref), u1417 (copy)
                    for _, child in pairs(AvatarShop.Panel.SubMenu._ScrollingList.Scroll:GetChildren()) do
                        if child:IsA("ImageButton") and child.Visible then
                            child:Destroy();
                        end;
                    end;

                    for i, v in pairs(p1469) do
                        local v1472 = u10.clone(AvatarShop.Panel.SubMenu._ScrollingList.Scroll.ElementPreview);
                        v1472.TextLabel.Text = i;
                        v1472.LayoutOrder = v[1];
                        v1472.Name = "Element";
                        v1472.Visible = true;

                        if not p1471 and v[1] == 1 or p1471 == i then
                            v1472.ImageTransparency = 0;
                            v1472.TextLabel.TextColor3 = Color3.fromRGB(47, 47, 47);
                        end;

                        v1472.Parent = AvatarShop.Panel.SubMenu._ScrollingList.Scroll;
                        CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(v1472, function() -- Line: 8620
                            -- upvalues: u1407 (ref), u1408 (ref), i (copy)
                            u1407(u1408, {
                                subPanel = i
                            });
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    end;

                    u1417.limitYScrollListener();
                end;

                local function activatePanelButton(p1473, p1474) -- Line: 8627
                    -- upvalues: AvatarShop (ref), u10 (ref)
                    if p1474 then
                        AvatarShop.Panel.Menu[p1473].ImageColor3 = Color3.fromRGB(255, 255, 255);

                        for _, child in pairs(AvatarShop.Panel.Menu[p1473]:GetChildren()) do
                            child.ImageColor3 = Color3.fromRGB(47, 47, 47);
                        end;

                        u10.resetButtonColor(AvatarShop.Panel.Menu[p1473], true);

                        return;
                    end;

                    AvatarShop.Panel.Menu[p1473].ImageColor3 = AvatarShop.Panel.Menu[p1473]:GetAttribute("ButtonColor");

                    for _, child in pairs(AvatarShop.Panel.Menu[p1473]:GetChildren()) do
                        child.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    end;

                    u10.resetButtonColor(AvatarShop.Panel.Menu[p1473], false);
                end;

                u1407 = function(p1475, p1476) -- Line: 8638, Name: loadPanel
                    -- upvalues: u1400 (ref), u1408 (ref), activatePanelButton (copy), u1409 (ref), u1360 (ref), connectCatalogSlots (ref), loadSubMenu (copy), AvatarShop (ref), u1403 (ref), u1395 (ref), CharScope (ref), dynamicLoadAssetsOrInventory (copy), AvatarEditorService (ref), u1416 (copy), Stuff (ref), AvatarAssets (ref), u10 (ref), updateOutfitSlots (copy), u2 (ref), u1394 (ref), u1401 (ref), u1 (ref), u1361 (ref), u1410 (ref), u1402 (ref), u1364 (ref)
                    local v1477 = p1476 or {};
                    u1400 = nil;

                    if u1408 then
                        activatePanelButton(u1408, false);
                    end;

                    activatePanelButton(p1475, true);
                    u1408 = p1475;
                    u1409 = v1477.subPanel;

                    if not u1360[p1475] then
                        if p1475 == "Body" then
                            connectCatalogSlots();
                            loadSubMenu({
                                Characters = { 1, Enum.BundleType.BodyParts },
                                Animations = { 2, Enum.BundleType.Animations },
                                ["Team Clothes"] = { 3, Enum.AssetType.Shirt }
                            }, p1475, u1409 or "Characters");
                            AvatarShop.Panel.SubMenu.Visible = true;
                            AvatarShop.Panel.Outfits.Visible = false;
                            AvatarShop.Panel.Inventory.Visible = false;
                            local v1478 = {};

                            if u1409 == "Team Clothes" then
                                for _, child in pairs(Stuff.Clothing:GetChildren()) do
                                    local Children2 = child:GetChildren();
                                    table.sort(Children2, function(p1479, p1480) -- Line: 8698
                                        return p1479.Name < p1480.Name;
                                    end);

                                    for _, v in pairs(Children2) do
                                        local v1481 = v:FindFirstChildOfClass("Folder");

                                        if v1481 then
                                            if v1481:FindFirstChild("Shirt") then
                                                table.insert(v1478, v1481.Shirt.Value);
                                            end;

                                            if v1481:FindFirstChild("Pants") then
                                                table.insert(v1478, v1481.Pants.Value);
                                            end;
                                        end;
                                    end;
                                end;
                            else
                                for i, _ in pairs(((not u1409 or u1409 == "Characters") and true or false) and AvatarAssets.whitelistedCharacterBundles or AvatarAssets.whitelistedAnimationBundles) do
                                    local v1482 = tonumber(i);
                                    table.insert(v1478, v1482);
                                end;
                            end;

                            local u1483 = u10.splitTable(v1478, 100);
                            local u1484 = 1;
                            CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", dynamicLoadAssetsOrInventory(function() -- Line: 8715
                                -- upvalues: u1483 (copy)
                                return u1483;
                            end, function(u1485, p1486) -- Line: 8716
                                -- upvalues: u1484 (ref), AvatarEditorService (ref), u1409 (ref), AvatarShop (ref), u1416 (ref)
                                if p1486 then
                                    u1416.dynSetTable({});
                                elseif u1484 <= #u1485 then
                                    local v1487;

                                    while true do
                                        local v1488;
                                        v1488, v1487 = pcall(function() -- Line: 8721
                                            -- upvalues: AvatarEditorService (ref), u1485 (copy), u1484 (ref), u1409 (ref)
                                            return AvatarEditorService:GetBatchItemDetailsAsync(u1485[u1484], u1409 == "Team Clothes" and Enum.AvatarItemType.Asset or Enum.AvatarItemType.Bundle);
                                        end);

                                        if v1488 then
                                            break;
                                        end;

                                        task.wait(6);
                                    end;

                                    local v1489;

                                    if AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text == "" then
                                        v1489 = false;
                                    else
                                        v1489 = string.lower(AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text);
                                    end;

                                    if v1489 then
                                        for i = #v1487, 1, -1 do
                                            local v1490;

                                            if string.find(string.lower(v1487[i].Name), v1489, nil, true) then
                                                v1490 = i;
                                            else
                                                table.remove(v1487, i);
                                                v1490 = i;
                                            end;
                                        end;
                                    end;

                                    u1416.dynSetTable(v1487, true);
                                    u1484 = u1484 + 1;
                                end;
                            end));

                            return;
                        end;

                        if p1475 ~= "Outfits" then
                            if p1475 == "Inventory" then
                                if pcall(function() -- Line: 8765
                                    -- upvalues: AvatarEditorService (ref)
                                    AvatarEditorService:PromptAllowInventoryReadAccess();
                                end) and AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Wait() == Enum.AvatarPromptResult.Success then
                                    connectCatalogSlots();
                                    AvatarShop.Panel.SubMenu.Visible = false;
                                    AvatarShop.Panel.Outfits.Visible = false;
                                    AvatarShop.Panel.Inventory.Visible = true;
                                    CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", dynamicLoadAssetsOrInventory(function() -- Line: 8773
                                        -- upvalues: AvatarEditorService (ref), u1361 (ref)
                                        return AvatarEditorService:GetInventoryAsync(u1361);
                                    end, function(u1491, p1492) -- Line: 8774
                                        -- upvalues: AvatarShop (ref), u1416 (ref)
                                        local function getAssets() -- Line: 8775
                                            -- upvalues: u1491 (copy), AvatarShop (ref)
                                            local CurrentPage = u1491:GetCurrentPage();
                                            local v1493;

                                            if AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text == "" then
                                                v1493 = false;
                                            else
                                                v1493 = string.lower(AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text);
                                            end;

                                            for i = #CurrentPage, 1, -1 do
                                                local v1494;

                                                if v1493 and not string.find(string.lower(CurrentPage[i].Name), v1493, nil, true) then
                                                    table.remove(CurrentPage, i);
                                                    v1494 = i;
                                                else
                                                    CurrentPage[i].Id = CurrentPage[i].AssetId;
                                                    v1494 = i;
                                                end;
                                            end;

                                            return CurrentPage;
                                        end;

                                        if p1492 then
                                            u1416.dynSetTable((getAssets()));
                                        elseif not u1491.IsFinished then
                                            while not pcall(function() -- Line: 8785
                                                -- upvalues: u1491 (copy)
                                                u1491:AdvanceToNextPageAsync();
                                            end) do
                                                task.wait(6);
                                            end;

                                            u1416.dynSetTable(getAssets(), true);
                                        end;
                                    end));
                                    AvatarShop.Panel.Inventory.TextBox.TextBoxFrame.TextBox.Text = "";
                                    local v1495 = u10.textBoxSystem(AvatarShop.Panel.Inventory.TextBox.TextBoxFrame, {
                                        enableScrolling = true
                                    });
                                    CharScope.buildSignalData("AvatarShopPanel", unpack(v1495.multipleSignalData));
                                    CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", v1495.cleanUp);
                                    CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(AvatarShop.Panel.Inventory.ImportId, function() -- Line: 8795
                                        -- upvalues: AvatarShop (ref), u1410 (ref), u1402 (ref)
                                        if tonumber(AvatarShop.Panel.Inventory.TextBox.TextBoxFrame.TextBox.Text) then
                                            local v1496 = tonumber(AvatarShop.Panel.Inventory.TextBox.TextBoxFrame.TextBox.Text);

                                            if not u1410(v1496) then
                                                u1402(v1496);
                                            end;
                                        end;
                                    end));
                                    CharScope.buildSignalData("AvatarShopPanel", u10.buttonHoverSignalData(AvatarShop.Panel.Inventory.ImportId));
                                    local v1497 = u10.textBoxSystem(AvatarShop.Panel.Menu.SearchBox.TextBoxFrame, {
                                        enableScrolling = true
                                    });
                                    CharScope.buildSignalData("AvatarShopPanel", unpack(v1497.multipleSignalData));
                                    CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", v1497.cleanUp);

                                    return;
                                end;
                            elseif p1475 == "Color" then
                                connectCatalogSlots();
                                AvatarShop.Panel.SubMenu.Visible = false;
                                AvatarShop.Panel.Outfits.Visible = false;
                                AvatarShop.Panel.Inventory.Visible = false;
                                u1416.dynSetTable(u1364);
                            end;

                            return;
                        end;

                        connectCatalogSlots();
                        updateOutfitSlots();
                        AvatarShop.Panel.SubMenu.Visible = false;
                        AvatarShop.Panel.Outfits.Visible = true;
                        AvatarShop.Panel.Inventory.Visible = false;
                        CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(AvatarShop.Panel.Outfits.CreateOutfit, function() -- Line: 8742
                            -- upvalues: u2 (ref), u10 (ref), u1394 (ref), u1401 (ref), u1 (ref)
                            local u1501 = u2.mainBox({
                                case = "Text",
                                headline = "Create an outfit and name it",
                                textPlaceholder = "Outfit Name",
                                acceptContent = "CREATE",

                                formatTextFunc = function(p1498) -- Line: 8743, Name: formatTextFunc
                                    -- upvalues: u10 (ref)
                                    local v1499 = u10.toSimpleString(p1498);

                                    return string.sub(v1499, 1, 20);
                                end,

                                acceptTextFunc = function(p1500) -- Line: 8743, Name: acceptTextFunc
                                    -- upvalues: u2 (ref)
                                    if #p1500 >= 1 then
                                        return true;
                                    end;

                                    u2.notify({
                                        message = "The name must be at least 1 character long",
                                        color = "red"
                                    });
                                end
                            });

                            if u1501 and not u10.invokeTraffic.avatarShop then
                                local function u1502() -- Line: 8746
                                    -- upvalues: u1401 (ref), u1501 (copy)
                                    return u1401("manageOutfit", {
                                        save = true,
                                        outfitName = u1501
                                    });
                                end;

                                local v1503, v1504, _, _ = u10.avatarShopPurchaseCost(nil, u1394);
                                local v1505;

                                if v1504 > 0 then
                                    local u1506 = nil;
                                    u1.payment("Purchase", v1504 .. "x Avatar Assets", -v1503, false, function(p1507, p1508) -- Line: 8078
                                        -- upvalues: u1502 (copy), u1506 (copy)
                                        if not p1507 then
                                            if u1502() == true then
                                                p1508("Purchased a product", true);

                                                if u1506 then
                                                    u1506();
                                                end;

                                                return true;
                                            end;

                                            p1508();
                                        end;
                                    end);
                                    v1505 = true;
                                else
                                    v1505 = false;
                                end;

                                if not v1505 then
                                    u1401("manageOutfit", {
                                        save = true,
                                        outfitName = u1501
                                    });
                                end;
                            end;
                        end));
                        CharScope.buildSignalData("AvatarShopPanel", u10.buttonHoverSignalData(AvatarShop.Panel.Outfits.CreateOutfit));
                        local u1509 = false;
                        CharScope.buildSignalData("AvatarShopPanel", u2.mouseButton(AvatarShop.Panel.Outfits.Delete, function() -- Line: 8754
                            -- upvalues: u1509 (ref), AvatarShop (ref)
                            u1509 = not u1509;

                            for _, child in pairs(AvatarShop.Panel.Assets._ScrollingList.Scroll:GetChildren()) do
                                if child:IsA("ImageButton") and (child.Visible and not child:GetAttribute("CantDelete")) then
                                    child.ImageColor3 = u1509 and Color3.fromRGB(127, 69, 69) or Color3.fromRGB(31, 31, 31);
                                    child:SetAttribute("DeleteOutfit", u1509 or nil);
                                end;
                            end;
                        end));
                        CharScope.buildSignalData("AvatarShopPanel", u10.buttonHoverSignalData(AvatarShop.Panel.Outfits.Delete));

                        return;
                    end;

                    if not u1409 then
                        for i, v in pairs(u1360[p1475]) do
                            if v[1] == 1 then
                                v1477.subPanel = i;
                                break;
                            end;
                        end;

                        u1409 = v1477.subPanel;
                    end;

                    connectCatalogSlots();
                    loadSubMenu(u1360[p1475], p1475, u1409);
                    AvatarShop.Panel.SubMenu.Visible = true;
                    AvatarShop.Panel.Outfits.Visible = false;
                    AvatarShop.Panel.Inventory.Visible = false;
                    local CatalogSearchParams_new_ret = CatalogSearchParams.new();

                    if u1403.maxPrice then
                        CatalogSearchParams_new_ret.MaxPrice = u1403.maxPrice;
                    end;

                    if u1403.minPrice then
                        CatalogSearchParams_new_ret.MinPrice = u1403.minPrice;
                    end;

                    CatalogSearchParams_new_ret.SearchKeyword = AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text;
                    local v1510 = {};
                    local v1511 = {};

                    for i, v in pairs(u1360[p1475][v1477.subPanel]) do
                        if i > 1 then
                            table.insert(v.EnumType == Enum.AvatarAssetType and v1510 and v1510 or v1511, v);
                        end;
                    end;

                    CatalogSearchParams_new_ret.AssetTypes = v1510;
                    CatalogSearchParams_new_ret.BundleTypes = v1511;

                    if u1403.sortType then
                        CatalogSearchParams_new_ret.SortType = u1395[u1403.sortType];
                    end;

                    if u1403.includeOffSale then
                        CatalogSearchParams_new_ret.IncludeOffSale = u1403.includeOffSale;
                    end;

                    if u1403.creatorName then
                        CatalogSearchParams_new_ret.CreatorName = u1403.creatorName;
                    end;

                    CharScope.addThreadOrCleanUpFunction("AvatarShopPanel", dynamicLoadAssetsOrInventory(function() -- Line: 8671
                        -- upvalues: AvatarEditorService (ref), CatalogSearchParams_new_ret (copy)
                        return AvatarEditorService:SearchCatalogAsync(CatalogSearchParams_new_ret);
                    end, function(u1512, p1513) -- Line: 8672
                        -- upvalues: u1416 (ref)
                        if p1513 then
                            u1416.dynSetTable(u1512:GetCurrentPage());
                        elseif not u1512.IsFinished then
                            while not pcall(function() -- Line: 8675
                                -- upvalues: u1512 (copy)
                                u1512:AdvanceToNextPageAsync();
                            end) do
                                task.wait(6);
                            end;

                            u1416.dynSetTable(u1512:GetCurrentPage(), true);
                        end;
                    end));
                end;

                for _, child in pairs(AvatarShop.Panel.Menu:GetChildren()) do
                    if child.Name ~= "SearchBox" then
                        AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text = "";

                        if not child:GetAttribute("ButtonColor") then
                            child:SetAttribute("ButtonColor", child.ImageColor3);
                        end;

                        activatePanelButton(child.Name, false);
                        CharScope.buildSignalData("AvatarShop", u2.mouseButton(child, function() -- Line: 8820
                            -- upvalues: child (copy), u1408 (ref), u1407 (ref)
                            if child.Name ~= u1408 then
                                u1407(child.Name);
                            end;
                        end));
                        CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(child));
                    end;
                end;

                AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.Text = "";
                CharScope.taskSpawn(u1407, "Accessories", {
                    subPanel = "All"
                });
                CharScope.buildSignalData("AvatarShop", { AvatarShop.Panel.Menu.SearchBox.TextBoxFrame.TextBox.FocusLost, function(p1514) -- Line: 8828
                        -- upvalues: u1407 (ref), u1408 (ref), u1409 (ref)
                        u1407(u1408, {
                            subPanel = u1409
                        });
                    end });
                local v1515 = u10.textBoxSystem(AvatarShop.Panel.Menu.SearchBox.TextBoxFrame, {
                    enableScrolling = true
                });
                CharScope.buildSignalData("AvatarShop", unpack(v1515.multipleSignalData));
                CharScope.addThreadOrCleanUpFunction("AvatarShop", v1515.cleanUp);
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.Panel.Buttons.Save, function() -- Line: 8835
                    -- upvalues: u1 (ref)
                    u1.activateAvatarShop(false);
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.Panel.Buttons.Exit, function() -- Line: 8838
                    -- upvalues: u1 (ref)
                    u1.activateAvatarShop(nil);
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.Panel.Buttons.ResetAvatar, function() -- Line: 8841
                    -- upvalues: makeSureUnsavedOutfitDoesntGetLost (copy), u1401 (ref)
                    if makeSureUnsavedOutfitDoesntGetLost() then
                        u1401("reset");
                    end;
                end));
                CharScope.buildSignalData("AvatarShop", u2.mouseButton(AvatarShop.Panel.Buttons.SearchSettings, function() -- Line: 8844
                    -- upvalues: showSearchSettings (copy)
                    showSearchSettings(true);
                end));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.Panel.Buttons.Save));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.Panel.Buttons.ResetAvatar));
                CharScope.buildSignalData("AvatarShop", u10.buttonHoverSignalData(AvatarShop.Panel.Buttons.SearchSettings));
                updateAllSlotsSelection();
                u10.guiTransition(AvatarShop, "Position", UDim2.fromScale(3.8, 0), true);
                u2.openGui("AvatarShop", true);
            end;

            local v1517 = u10.invokeServerTraffic("avatarShop", u13, "activate", {
                on = true,
                prompt = ({
                    prompt = u1397
                }).prompt
            });
            local v1518 = u10.typeOf(v1517) == "string" and u10.getInstanceReference(v1517, 20);

            if v1518 then
                v1516(v1518);
            end;
        else
            if not (u2.readPlayerData("TipLearned", "clothingStoreOutfits") or u2.readPlayerData("Guide", "Outfits")) then
                u2.startGuide("Outfits", true);
            end;

            local v1519 = {
                updateAvatar = u1397 == false,
                avatarShopCharacter = u1394
            };

            local function u1520() -- Line: 8188
                -- upvalues: u1398 (copy), u1394 (ref), OffsetCamera (ref), u10 (ref), AvatarShop (ref), u2 (ref)
                u1398();
                u1394 = nil;
                OffsetCamera.Stop();
                u10.guiTransition(AvatarShop, "Position", UDim2.fromScale(3.8, 0), false);
                u2.openGui(false);
            end;

            local function u1523(p1521) -- Line: 8101
                -- upvalues: u10 (ref), u13 (ref), u2 (ref)
                local v1522 = u10.invokeServerTraffic("avatarShop", u13, "activate", {
                    on = false,
                    updateAvatar = p1521 or nil
                });

                if v1522 == true then
                    return true;
                end;

                if u10.typeOf(v1522) == "string" then
                    u2.notify({
                        color = "red",
                        message = v1522
                    });
                end;
            end;

            local v1524, v1525, v1526;

            if v1519.updateAvatar then
                local function u1527() -- Line: 8108
                    -- upvalues: u1523 (copy)
                    return u1523(true);
                end;

                local v1528, v1529;
                v1528, v1529, v1524, v1525 = u10.avatarShopPurchaseCost(nil, v1519.avatarShopCharacter);

                if v1529 > 0 then
                    u1.payment("Purchase", v1529 .. "x Avatar Assets", -v1528, false, function(p1530, p1531) -- Line: 8078
                        -- upvalues: u1527 (copy), u1520 (copy)
                        if not p1530 then
                            if u1527() == true then
                                p1531("Purchased a product", true);

                                if u1520 then
                                    u1520();
                                end;

                                return true;
                            end;

                            p1531();
                        end;
                    end);
                    v1526 = true;
                else
                    v1526 = false;
                end;
            else
                v1526 = nil;
                v1524 = nil;
                v1525 = nil;
            end;

            if not v1526 then
                if v1524 then
                    v1525 = v1524 > 0 and true or v1525;
                end;

                if u1523(v1525) then
                    u1398();
                    u1394 = nil;
                    OffsetCamera.Stop();
                    u10.guiTransition(AvatarShop, "Position", UDim2.fromScale(3.8, 0), false);
                    u2.openGui(false);
                end;
            end;
        end;
    end;

    u2.debugLoadingClient("Character 9");
    local v1532 = u10.raycastParamsNew();
    v1532.IgnoreWater = true;
    v1532.FilterDescendantsInstances = { u13 };
    local u1533 = {};

    if GameRules.season == "Winter" then
        u10.animationBuffer(Animator, "load", PlayerStuff.Items.Animations:WaitForChild("MakeSnowball"));

        function u1.makeSmowballUserInput(p1534) -- Line: 8869
            -- upvalues: u4 (ref), u1 (ref), u2 (ref), GameRules (ref), u10 (ref), u1533 (copy), CharScope (ref), HumanoidRootPart (copy), Animator (copy), PlayerEvent (ref)
            if not (p1534 or (u4.equippedItem or (not u1.floor or (u2.openedGui or (game.Lighting.Blur.Enabled or (u2.isSeated() or not (GameRules.materialTable[u1.floor] and (GameRules.materialTable[u1.floor] == "115734159282221" and not (u2.dragging or u10.rest("MakeSnowballClient", nil)))))))))) then
                table.insert(u1533, CharScope.taskDelay(0.7, function() -- Line: 8872
                    -- upvalues: u10 (ref), HumanoidRootPart (ref)
                    u10.playSoundReplicate(HumanoidRootPart.MakeSnowball);
                end));
                table.insert(u1533, CharScope.taskDelay(0.2, function() -- Line: 8875
                    -- upvalues: u10 (ref), Animator (ref), u1 (ref)
                    u10.animationBuffer(Animator, "play", "MakeSnowball");
                    u1.setCharRotType("makeSnowball", {
                        priority = 4,
                        client = 0,
                        server = 0
                    });
                end));
                u1.displayBottomBarMessage("makeSnowball", 10, nil, 2.2, Color3.fromRGB(222, 222, 222));
                u1.lockHumanoidState("MakeSnowball", -1);

                local function v1535() -- Line: 8881
                    -- upvalues: u1 (ref), u10 (ref), Animator (ref), u1533 (ref)
                    u1.displayBottomBarMessage("makeSnowball");
                    u1.lockHumanoidState("MakeSnowball");
                    u1.setCharRotType("makeSnowball");
                    u10.animationBuffer(Animator, "stop", "MakeSnowball");

                    for _, v in pairs(u1533) do
                        u10.taskCancel(v);
                    end;

                    table.clear(u1533);
                end;

                local v1536 = 2.2;

                while v1536 > 0 do
                    v1536 = v1536 - task.wait();

                    if not u2.isMouseButton1Pressed() then
                        return v1535();
                    end;
                end;

                v1535();
                PlayerEvent:FireServer("makeSnowball");
                u10.rest("MakeSnowballClient", 0.5);
            end;
        end;
    end;

    u1.lastRootCFrame = nil;
    CharScope.taskDefer(function() -- Line: 8904
        -- upvalues: u1 (ref), HumanoidRootPart (copy)
        while true do
            u1.lastRootCFrame = HumanoidRootPart.CFrame;
            task.wait();
        end;
    end);
    local u1537 = u10.raycastParamsNew();
    u1537.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities };

    local function fellInWater() -- Line: 8915
        -- upvalues: u10 (ref), HumanoidRootPart (copy), u1537 (copy)
        local v1538 = u10.raycastVisible(HumanoidRootPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -8, 0), u1537);

        if v1538 then
            if v1538.Instance == workspace.Terrain then
                v1538 = v1538.Material == Enum.Material.Water;
            else
                v1538 = false;
            end;
        end;

        return v1538;
    end;

    u1.characterFalling = false;

    local function fallDamageListener() -- Line: 8921
        -- upvalues: u1 (ref), HumanoidRootPart (copy), u2 (ref), PlayerEvent (ref)
        u1.characterFalling = true;
        local v1539 = nil;
        local v1540 = 0;

        while not v1539 or v1539 > 5 do
            v1539 = math.abs(HumanoidRootPart.AssemblyLinearVelocity.Y);
            v1540 = math.max(v1539, v1540);
            task.wait();

            if not u1.fallRagdollEnabled then
                u1.characterFalling = false;

                return;
            end;
        end;

        u1.characterFalling = false;

        if u2.checkBodyPartMaterial(HumanoidRootPart) ~= Enum.Material.Water then
            PlayerEvent:FireServer("takeDamage", math.round((v1540 - 100) / 100 * 50) + 5, nil, 21);
        end;
    end;

    CharScope.taskDefer(function() -- Line: 8939
        -- upvalues: u10 (ref), HumanoidRootPart (copy)
        u10.antiFling(HumanoidRootPart, 300, 50);
    end);
    local u1541 = nil;
    local u1542 = nil;
    local u1543 = u10.raycastParamsNew();
    u1543.FilterDescendantsInstances = { workspace.Characters, workspace.Terrain.Ground, workspace.Gameplay };
    u1543.IgnoreWater = true;
    local u1544 = u10.raycastParamsNew();
    u1544.FilterDescendantsInstances = { workspace.Characters, workspace.Terrain.Ground, workspace.Gameplay.Entities };
    u1544.IgnoreWater = true;
    local u1545 = false;

    local function runMovingFunc() -- Line: 8955
        -- upvalues: u1545 (ref), u2 (ref), CharScope (ref), HumanoidRootPart (copy), u1543 (copy), u1542 (ref), u1541 (ref)
        if not (u1545 or u2.isSeated()) then
            u1545 = true;
            local u1546 = 10;
            CharScope.taskDefer(function() -- Line: 8959
                -- upvalues: u1546 (ref), u2 (ref), HumanoidRootPart (ref), u1543 (ref), u1542 (ref), u1541 (ref), u1545 (ref)
                while u1546 > 0 and not u2.isSeated() do
                    local v1547 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1543);

                    if v1547 and v1547.Instance.Name == "_Moving" then
                        u1546 = 10;

                        if v1547.Instance ~= u1542 then
                            u1541 = v1547.Instance.CFrame;
                            u1542 = v1547.Instance;
                        end;

                        HumanoidRootPart.CFrame = v1547.Instance.CFrame * u1541:Inverse() * HumanoidRootPart.CFrame;
                        u1541 = v1547.Instance.CFrame;
                        u1542 = v1547.Instance;
                    elseif u1542 then
                        u1541 = nil;
                        u1542 = nil;
                    end;

                    u1546 = u1546 - task.wait();
                end;

                u1545 = false;
            end);
        end;
    end;

    local u1548 = false;

    local function standingOnMovingVehicleRagdoll() -- Line: 8980
        -- upvalues: u1548 (ref), CharScope (ref), HumanoidRootPart (copy), u1544 (copy), u2 (ref), u10 (ref), GameRules (ref), Ragdoll (ref), u13 (copy)
        if not u1548 then
            u1548 = true;
            local u1549 = 10;
            CharScope.taskDefer(function() -- Line: 8984
                -- upvalues: u1549 (ref), HumanoidRootPart (ref), u1544 (ref), u2 (ref), u10 (ref), GameRules (ref), Ragdoll (ref), u13 (ref), u1548 (ref)
                while u1549 > 0 do
                    local v1550 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1544);

                    if v1550 and not (u2.isSeated() or (not v1550.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) or (u10.getAncestorsChild(workspace.Gameplay.Vehicles, v1550.Instance):GetAttribute("AllowStandingOnVehicle") or u2.allowStandingVehicle))) then
                        u1549 = 10;

                        if v1550.Instance.AssemblyRootPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph > GameRules.standingOnMovingVehicleSpeedRagdollMph and not Ragdoll.isActive then
                            Ragdoll.activate(u13, true, true);
                        end;
                    end;

                    u1549 = u1549 - task.wait(0.2);
                end;

                u1548 = false;
            end);
        end;
    end;

    u1.fallRagdollEnabled = true;

    local function ragdollFallListener() -- Line: 9006
        -- upvalues: CharScope (ref), u1 (ref), u2 (ref), HumanoidRootPart (copy), Ragdoll (ref), u13 (copy), fallDamageListener (copy)
        CharScope.taskDefer(function() -- Line: 9007
            -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), Ragdoll (ref), u13 (ref), CharScope (ref), fallDamageListener (ref)
            while true do
                if u1.fallRagdollEnabled and not (u2.isSeated() or (HumanoidRootPart.AssemblyLinearVelocity.Y >= -100 or Ragdoll.isActive)) then
                    Ragdoll.activate(u13, true, true);
                    CharScope.taskSpawn(fallDamageListener);
                end;

                task.wait(0.2);
            end;
        end);
    end;

    CharScope.taskDefer(function() -- Line: 9019
        -- upvalues: HumanoidRootPart (copy), u1543 (copy), PlayerEvent (ref)
        while true do
            if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1543) and HumanoidRootPart.Position.Y > -200 then
                PlayerEvent:FireServer("charCheckpoint", HumanoidRootPart.Position);
            end;

            task.wait(5);
        end;
    end);
    CharScope.taskDefer(function() -- Line: 9026
        -- upvalues: HumanoidRootPart (copy), u1544 (copy), u1545 (ref), u2 (ref), CharScope (ref), u1543 (copy), u1542 (ref), u1541 (ref), u1548 (ref), u10 (ref), GameRules (ref), Ragdoll (ref), u13 (copy)
        while true do
            local v1551 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1544);

            if v1551 then
                if v1551.Instance.Name == "_Moving" then
                    if not (u1545 or u2.isSeated()) then
                        u1545 = true;
                        local u1552 = 10;
                        CharScope.taskDefer(function() -- Line: 8959
                            -- upvalues: u1552 (ref), u2 (ref), HumanoidRootPart (ref), u1543 (ref), u1542 (ref), u1541 (ref), u1545 (ref)
                            while u1552 > 0 and not u2.isSeated() do
                                local v1553 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1543);

                                if v1553 and v1553.Instance.Name == "_Moving" then
                                    u1552 = 10;

                                    if v1553.Instance ~= u1542 then
                                        u1541 = v1553.Instance.CFrame;
                                        u1542 = v1553.Instance;
                                    end;

                                    HumanoidRootPart.CFrame = v1553.Instance.CFrame * u1541:Inverse() * HumanoidRootPart.CFrame;
                                    u1541 = v1553.Instance.CFrame;
                                    u1542 = v1553.Instance;
                                elseif u1542 then
                                    u1541 = nil;
                                    u1542 = nil;
                                end;

                                u1552 = u1552 - task.wait();
                            end;

                            u1545 = false;
                        end);
                    end;
                elseif v1551.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) and not (u2.isSeated() or u1548) then
                    u1548 = true;
                    local u1554 = 10;
                    CharScope.taskDefer(function() -- Line: 8984
                        -- upvalues: u1554 (ref), HumanoidRootPart (ref), u1544 (ref), u2 (ref), u10 (ref), GameRules (ref), Ragdoll (ref), u13 (ref), u1548 (ref)
                        while u1554 > 0 do
                            local v1555 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1544);

                            if v1555 and not (u2.isSeated() or (not v1555.Instance:IsDescendantOf(workspace.Gameplay.Vehicles) or (u10.getAncestorsChild(workspace.Gameplay.Vehicles, v1555.Instance):GetAttribute("AllowStandingOnVehicle") or u2.allowStandingVehicle))) then
                                u1554 = 10;

                                if v1555.Instance.AssemblyRootPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph > GameRules.standingOnMovingVehicleSpeedRagdollMph and not Ragdoll.isActive then
                                    Ragdoll.activate(u13, true, true);
                                end;
                            end;

                            u1554 = u1554 - task.wait(0.2);
                        end;

                        u1548 = false;
                    end);
                end;
            end;

            task.wait(1);
        end;
    end);
    CharScope.buildSignalData("Global", { u13.AncestryChanged, function(p1556, p1557) -- Line: 9037
            -- upvalues: u9 (ref), u1 (ref)
            local disabled = u9.disabled;
            local v1558;

            if p1557 then
                v1558 = not p1557:IsDescendantOf(workspace);
            else
                v1558 = p1557;
            end;

            disabled(v1558, "characterNotWorkspace");
            local lockEmotes = u1.lockEmotes;

            if p1557 then
                p1557 = not p1557:IsDescendantOf(workspace);
            end;

            lockEmotes("characterNotWorkspace", p1557);
        end });
    CharScope.buildSignalData("Global", { u2.platformChangedEvent.Event, loadPlatform });
    loadPlatform(u2.platform);
    u13:SetAttribute("Loaded", true);
    u1.loaded = true;
    PlayerEvent:FireServer("loaded", u13);

    if u15.enterVehicleReference then
        CharScope.taskDefer(function() -- Line: 9047
            -- upvalues: u10 (ref), u15 (copy), u3 (ref)
            local InstanceReference = u10.getInstanceReference(u15.enterVehicleReference, 20);

            if InstanceReference then
                u10.collectionAddTag(InstanceReference.Parent, "IgnoreCamera");
                u3.enterVehicle(InstanceReference);
            end;
        end);
    end;

    if u2.longLoadingGui then
        local task_wait = task.wait;
        local v1559 = 3.5 - tick() + v16;
        task_wait((math.max(0, v1559)));
    end;

    local v1560 = u10.raycastParamsNew();
    v1560.FilterDescendantsInstances = { workspace.Characters, workspace.Terrain.Ground };
    v1560.IgnoreWater = true;
    u2.waitForCharGround(HumanoidRootPart, v1560, {
        excludeMap = true
    });
    CharScope.taskDefer(function() -- Line: 9007
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (copy), Ragdoll (ref), u13 (copy), CharScope (ref), fallDamageListener (copy)
        while true do
            if u1.fallRagdollEnabled and not (u2.isSeated() or (HumanoidRootPart.AssemblyLinearVelocity.Y >= -100 or Ragdoll.isActive)) then
                Ragdoll.activate(u13, true, true);
                CharScope.taskSpawn(fallDamageListener);
            end;

            task.wait(0.2);
        end;
    end);
    u2.debugLoadingClient("Character 10");
    u2.activateLoading();

    if u15.playAnimation then
        u10.playAnimation(u10.loadAnimation(Animator, u15.playAnimation), "play");
    end;
end;

return CharScope.addToCharacterModule(u1);
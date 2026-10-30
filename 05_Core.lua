-- Decompiled with Potassium's decompiler.

local u1 = {
    teleporting = false,
    wantedLevel = 0,
    voiceRadioChannel = nil,
    voiceRadioVolume = nil,
    longLoadingGui = true,
    chatHistory = {},
    scriptedObjects = {},
    questFunctions = {},
    mutedPlayerId = {}
};
local ModuleLoader = require(game.ReplicatedStorage.Modules.ModuleLoader);
local u2 = ModuleLoader.assign(script.Parent:WaitForChild("Character"));
local u3 = ModuleLoader.assign(script.Parent:WaitForChild("Vehicle"));
local u4 = ModuleLoader.assign(script.Parent.Character:WaitForChild("Inventory"));
local u5 = ModuleLoader.assign(script.Parent.Character:WaitForChild("Phone"));
local u6 = ModuleLoader.assign(script.Parent.Character:WaitForChild("Housing"));
local u7 = ModuleLoader.assign(script.Parent:WaitForChild("Interaction"));
ModuleLoader.assign(script.Parent:WaitForChild("Events"));
local u8 = ModuleLoader.assign(script.Parent.Character:WaitForChild("AutoShop"));
local CharScope = require(game.ReplicatedStorage.Modules:WaitForChild("CharScope"));
local Ragdoll = require(game.ReplicatedStorage.Modules:WaitForChild("Ragdoll"));
local HttpService = game:GetService("HttpService");
local OffsetCamera = require(game.ReplicatedStorage.Modules.OffsetCamera);
local v9 = ModuleLoader.assign(game.ReplicatedStorage.Modules.Algorithms);
local NavigationSystem = require(game.ReplicatedStorage.Modules.NavigationSystem);
local HandshakeSystem = require(game.ReplicatedStorage.Modules:WaitForChild("HandshakeSystem"));
local game_Players = game.Players;
local LocalPlayer = game_Players.LocalPlayer;
local GuiService = game:GetService("GuiService");
local StarterGui = game:GetService("StarterGui");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
v9.playerScreenGuiSystem("createPlayer", LocalPlayer);
local GlobalGui = PlayerGui:WaitForChild("GlobalGui");
local FullScreenGui = PlayerGui:WaitForChild("FullScreenGui");
local FrontGui = PlayerGui:WaitForChild("FrontGui");
local MenuGui = PlayerGui:WaitForChild("MenuGui");
local u10 = ModuleLoader.assign(game.ReplicatedStorage.Modules.Algorithms);
local GameRules = require(game.ReplicatedStorage.Modules.GameRules);
local UserInputService = game:GetService("UserInputService");
LocalPlayer:GetMouse();
local MarketplaceService = game:GetService("MarketplaceService");
local ContentProvider = game:GetService("ContentProvider");
local workspace_CurrentCamera = workspace.CurrentCamera;
local RunService = game:GetService("RunService");
local Heartbeat = RunService.Heartbeat;
local game_Lighting = game.Lighting;
local Easing = require(game.ReplicatedStorage.Modules.Easing);
local Variables = game.ReplicatedStorage.Variables;
local TweenService = game:GetService("TweenService");
local PlayerEvent = game.ReplicatedStorage.Remote.PlayerEvent;
game:GetService("PhysicsService");
game:GetService("CollectionService");
local PlayerFunc = game.ReplicatedStorage.Remote.PlayerFunc;
local Stuff = game.ReplicatedStorage.Stuff;
local TextChatService = game:GetService("TextChatService");
local LocalizationService = game:GetService("LocalizationService");
local GroupService = game:GetService("GroupService");
local PolicyService = game:GetService("PolicyService");
local Weather = game.ReplicatedStorage.Gameplay.Weather;
local Missions = game.ReplicatedStorage.Gameplay.Missions;
local Leaderboard = MenuGui.MenuGui.Center.Middle.Leaderboard;
u1.guideGui = FrontGui.Center.Middle.Guide;
u1.prisonLocation = Stuff.Locations.Prison;
u1.isMenuActive = false;
currentScreenGuis = nil;
local u11 = {};
local u12 = nil;
LocalPlayer:WaitForChild("VoiceChatRadioInput");
local v13 = game.ReplicatedStorage.PlayerStuff.AudioAPI.VoiceChatListener:Clone();
local u14 = false;
game.ReplicatedFirst:WaitForChild("AntiCheat"):GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 76
    -- upvalues: u14 (ref), PlayerEvent (copy)
    if not (u14 or game.ReplicatedFirst.AntiCheat.Enabled) then
        u14 = true;
        PlayerEvent:FireServer("loadAreaContent", "Disabled");
    end;
end);
u1.initialFOV = workspace.Camera.FieldOfView;
u10.setCameraProperties("0", {
    CameraType = Enum.CameraType.Custom,
    FieldOfView = u1.initialFOV
});
v13.Parent = workspace_CurrentCamera;
u1.notificationsGui = FrontGui.Left.Bottom.Notifications;
u1.notificationsGuiLowDisplayOrder = GlobalGui.Left.Bottom.NotificationsLowDisplayOrder;
u1.guiInset = 0;
HandshakeSystem.watch("Core", "r7bx0jmd");
task.spawn(function() -- Line: 89
    -- upvalues: u1 (copy)
    while game.GuiService:GetGuiInset() == Vector2.new() do
        task.wait();
    end;

    u1.guiInset = game.GuiService:GetGuiInset().Y;
end);
FrontGui.TopBarButtons.Menu.Visible = false;

function u1.updateTopBarButtonsVisibility() -- Line: 94
    -- upvalues: FrontGui (copy), u1 (copy), u10 (copy)
    local TopBarButtons = FrontGui.TopBarButtons;
    local v15 = not u1.isMenuActive;

    if v15 then
        if u1.platform == "Mobile" then
            if u10.indexedTableSize(currentScreenGuis) <= 0 then
                v15 = not u1.openedGui or u1.openedGui == "SelectionWheel";
            else
                v15 = false;
            end;
        else
            v15 = true;
        end;
    end;

    TopBarButtons.Visible = v15;
end;

GuiService.MenuOpened:Connect(function() -- Line: 97
    -- upvalues: LocalPlayer (copy), u1 (copy)
    if LocalPlayer:GetAttribute("CombatMode") or LocalPlayer:GetAttribute("Pursuit") then
        u1.displayTip("gameQuit", 1);
    end;

    if LocalPlayer:GetAttribute("PoliceCustodyEscapeAttempt") then
        u1.notify({
            message = "Your arrested player is attempting custody escape! Don\'t quit or you will lose XP",
            color = "red"
        });

        return;
    end;

    if LocalPlayer:GetAttribute("Pursuit") then
        u1.notify({
            message = "Police can see you! Don\'t quit or you will be sent to jail",
            color = "red"
        });

        return;
    end;

    if u1.readPlayerData("DirtyMoney") > 0 then
        u1.notify({
            message = "You have Dirty Money! Don\'t quit or you will lose some",
            color = "red"
        });

        return;
    end;

    if LocalPlayer:GetAttribute("LeftWhileInCombat") then
        u1.notify({
            message = "You are in combat! Don\'t quit or you will lose your weapon",
            color = "red"
        });
    end;
end);
task.defer(function() -- Line: 111
    -- upvalues: GameRules (copy), PolicyService (copy), LocalPlayer (copy)
    GameRules.policyInfo = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
end);
task.defer(function() -- Line: 117
    -- upvalues: PlayerGui (copy)
    local Freecam = PlayerGui:WaitForChild("Freecam", 30);

    if Freecam then
        Freecam:Destroy();
    end;
end);

function u1.canPressKey(p16) -- Line: 122
    -- upvalues: u1 (copy), GameRules (copy), u7 (copy)
    local v17;

    if u1.loadingActivated == nil then
        v17 = GameRules.focus and (not (p16 and u7.holdBegan) or u7.holdBegan.KeyboardKeyCode ~= p16);
    else
        v17 = false;
    end;

    return v17;
end;

if GameRules.debugLoadingClient then
    function u1.debugLoadingClient(p18) -- Line: 127
        print("[DEBUG LOADING] " .. p18);
    end;
else
    function u1.debugLoadingClient() -- Line: 130
    end;
end;

u1.debugLoadingClient("Core 1");
local u19 = u10.raycastParamsNew();
u19.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities, workspace.Gameplay.Vehicles };

function u1.checkIfBothPositionsGoThroughWall(p20, p21) -- Line: 146
    -- upvalues: u10 (copy), u19 (copy)
    if u10.raycastVisible(p20, p21 - p20, u19, {
        customRequirements = function(p22) -- Line: 147, Name: customRequirements
            return p22.Instance.CanCollide and p22;
        end
    }) then
        return true;
    end;
end;

function u1.keepWithinGuiAbsolute(p23, p24) -- Line: 158
    -- upvalues: workspace_CurrentCamera (copy), u1 (copy)
    local function axis(p25, p26, p27, p28, p29, p30) -- Line: 159
        local v31 = -p30;
        local v32 = p27 - p30;
        local v33;

        if p28 then
            v31 = math.max(p28, v31);
            v33 = math.min(p28 + p29, v32) - p26;
        else
            v33 = v32 - p26;
        end;

        if v31 <= v33 then
            return math.clamp(p25, v31, v33);
        end;

        return v31;
    end;

    local Vector2_new = Vector2.new;
    local X = p23.AbsolutePosition.X;
    local X2 = p23.AbsoluteSize.X;
    local v34;

    if p24 then
        v34 = p24.AbsolutePosition.X;
    else
        v34 = p24;
    end;

    local v35;

    if p24 then
        v35 = p24.AbsoluteSize.X;
    else
        v35 = p24;
    end;

    local v36 = workspace_CurrentCamera.ViewportSize.X - 0;
    local v37, v38;

    if v34 then
        v37 = math.max(v34, -0);
        v38 = math.min(v34 + v35, v36) - X2;
    else
        v38 = v36 - X2;
        v37 = -0;
    end;

    if v37 <= v38 then
        v37 = math.clamp(X, v37, v38);
    end;

    local Y = p23.AbsolutePosition.Y;
    local Y2 = p23.AbsoluteSize.Y;
    local v39;

    if p24 then
        v39 = p24.AbsolutePosition.Y;
    else
        v39 = p24;
    end;

    if p24 then
        p24 = p24.AbsoluteSize.Y;
    end;

    local guiInset = u1.guiInset;
    local v40 = -guiInset;
    local v41 = workspace_CurrentCamera.ViewportSize.Y - guiInset;
    local v42;

    if v39 then
        v40 = math.max(v39, v40);
        v42 = math.min(v39 + p24, v41) - Y2;
    else
        v42 = v41 - Y2;
    end;

    if v40 <= v42 then
        v40 = math.clamp(Y, v40, v42);
    end;

    return Vector2_new(v37, v40);
end;

function u1.guiScreenDraggingSystem(u43, u44, u45) -- Line: 175
    -- upvalues: UserInputService (copy), u1 (copy), GameRules (copy), u10 (copy)
    return { UserInputService.InputBegan, function(p46) -- Line: 177
            -- upvalues: u1 (ref), u44 (copy), GameRules (ref), u10 (ref), u45 (copy), u43 (copy)
            if p46.UserInputType == Enum.UserInputType.MouseButton1 or p46.UserInputType == Enum.UserInputType.Touch then
                if u1.isMouseObstructedByBlackBackground(u44.ZIndex) or not GameRules.focus then
                    return;
                end;

                if u10.isInFrame(u44) then
                    local v47 = u45 and u45.customBoundGui;
                    local AbsolutePosition = (v47 or u44).AbsolutePosition;
                    local Position = u43.Position;
                    local MousePos = u10.getMousePos();

                    while u1.isMouseButton1Pressed() and not u10.isTouchingScrollingListMobile and (u45 and u45.ignoreFocus or GameRules.focus) do
                        local v48 = u1.getMouseProperty.mobileTouch and u1.getMouseProperty.mobileTouch.Position or u10.getMousePos();

                        if (Vector2.new(MousePos.X, MousePos.Y) - Vector2.new(v48.X, v48.Y)).Magnitude > 90 then
                            local v49;

                            if u45 and u45.startedFunc then
                                u45.startedFunc();
                                v49 = 0.2;
                            else
                                v49 = 0.2;
                            end;

                            while u1.isMouseButton1Pressed() do
                                local v50 = u1.getMouseProperty.mobileTouch and u1.getMouseProperty.mobileTouch.Position or u10.getMousePos();
                                local v51 = u1.keepWithinGuiAbsolute({
                                    AbsolutePosition = Vector2.new(AbsolutePosition.X + (v50.X - MousePos.X), AbsolutePosition.Y + (v50.Y - MousePos.Y)),
                                    AbsoluteSize = (v47 or u44).AbsoluteSize
                                });
                                u43.Position = u43.Position:Lerp(UDim2.fromScale(Position.X.Scale + (v51.X - AbsolutePosition.X) / u43.Parent.AbsoluteSize.X, Position.Y.Scale + (v51.Y - AbsolutePosition.Y) / u43.Parent.AbsoluteSize.Y), v49);
                                local task_wait_ret = task.wait();

                                if v49 < 1 then
                                    v49 = math.min(v49 + task_wait_ret * 60 * 0.1, 1);
                                end;
                            end;

                            if u45 and u45.endedFunc then
                                u45.endedFunc();

                                return;
                            end;

                            break;
                        end;

                        task.wait();
                    end;
                end;
            end;
        end };
end;

function u1.checkBodyPartMaterial(p52, p53) -- Line: 211
    local v54 = p53 or Vector3.new();
    local v55 = Region3.new(p52.Position + v54 - 0.5 * p52.Size, p52.Position + v54 + 0.5 * p52.Size):ExpandToGrid(4);
    local v56 = workspace.Terrain:ReadVoxels(v55, 4)[1];

    return v56 and v56[1][1] or Enum.Material.Air;
end;

local u57 = u10.raycastParamsNew();
u57.IgnoreWater = false;
u57.FilterType = Enum.RaycastFilterType.Include;
u57.FilterDescendantsInstances = { workspace.Terrain };

function u1.isCharUnderWater(u58, p59) -- Line: 224
    -- upvalues: u1 (copy), u10 (copy), u57 (copy)
    local v60;

    if p59 then
        v60 = function() -- Line: 227, Name: checkFunc
            -- upvalues: u1 (ref), u58 (copy)
            local v61;

            if u1.checkBodyPartMaterial(u58.Head, Vector3.new(0, 6, 0)) == Enum.Material.Air then
                v61 = false;
            else
                v61 = u1.checkBodyPartMaterial(u58.PrimaryPart, (Vector3.new())) ~= Enum.Material.Air;
            end;

            return v61;
        end;
    else
        v60 = function() -- Line: 231, Name: checkFunc
            -- upvalues: u58 (copy), u1 (ref)
            local v62;

            if u58.Humanoid:GetState() == Enum.HumanoidStateType.Swimming and u1.checkBodyPartMaterial(u58.Head, Vector3.new(0, 1, 0)) ~= Enum.Material.Air then
                v62 = u1.checkBodyPartMaterial(u58.PrimaryPart, (Vector3.new())) ~= Enum.Material.Air;
            else
                v62 = false;
            end;

            return v62;
        end;
    end;

    if v60() then
        local v63 = u10.raycastVisible(u58.Head.Position + Vector3.new(0, 0.7, 0), Vector3.new(0, -3, 0), u57);

        if not v63 or v63.Material ~= Enum.Material.Water then
            return true;
        end;
    end;
end;

local GUIInteractionIndicator = FrontGui.Center.Middle.GUIInteractionIndicator;

local function guiInteractionIndicator(p64, u65) -- Line: 242
    -- upvalues: u10 (copy), GUIInteractionIndicator (copy)
    if u65 then
        local u66 = {};
        local u67 = u10.clone(GUIInteractionIndicator.CirclePreview);
        u67.Name = "Circle";
        u67.Parent = GUIInteractionIndicator;
        table.insert(p64, function() -- Line: 248
            -- upvalues: u67 (copy)
            u67:Destroy();
        end);
        table.insert(u66, p64[#p64]);
        table.insert(p64, task.spawn(function() -- Line: 252
            -- upvalues: u10 (ref), u67 (copy)
            while true do
                u10.tweenServiceSet(u67, {
                    ImageTransparency = 0.4
                });
                u10.tweenServiceSet(u67, {
                    Size = UDim2.fromScale(0.15, 0.15)
                });
                u10.tweenServiceStart(u67, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                });
                task.wait(0.25);
                u10.tweenServiceStart(u67, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                });
                task.wait(1);
            end;
        end));
        table.insert(u66, p64[#p64]);
        table.insert(p64, task.spawn(function() -- Line: 263
            -- upvalues: u65 (copy), u67 (copy), u10 (ref), GUIInteractionIndicator (ref)
            while true do
                local v68 = u65();
                local Visible = u67.Visible;
                local v69;

                if v68 then
                    v69 = u10.isGuiTrulyVisible(v68) or false;
                else
                    v69 = false;
                end;

                if Visible ~= v69 then
                    u67.Visible = not u67.Visible;
                end;

                if v68 then
                    u67.Position = UDim2.fromScale((v68.AbsolutePosition.X + v68.AbsoluteSize.X / 2 - GUIInteractionIndicator.AbsolutePosition.X) / GUIInteractionIndicator.AbsoluteSize.X, (v68.AbsolutePosition.Y + v68.AbsoluteSize.Y / 2 - GUIInteractionIndicator.AbsolutePosition.Y) / GUIInteractionIndicator.AbsoluteSize.Y);
                end;

                task.wait();
            end;
        end));
        table.insert(u66, p64[#p64]);

        return function() -- Line: 279
            -- upvalues: u10 (ref), u66 (copy)
            u10.clearConnectionsAndThreads(u66);
        end;
    end;
end;

local u70 = {};

local function autoDecisionInviteToJoinActivityCleanUp() -- Line: 286
    -- upvalues: u70 (copy)
    for _, v in pairs(u70) do
        v();
    end;

    table.clear(u70);
end;

function u1.autoDecisionInviteToJoinActivity(u71, u72, u73) -- Line: 290
    -- upvalues: u70 (copy), u10 (copy), CharScope (copy), u5 (copy), u1 (copy)
    if u70[u71] then
        u70[u71]();
    end;

    if u72 and not u10.rest(u71 .. "InvitePost", nil) then
        CharScope.taskDelay(7, function() -- Line: 293
            -- upvalues: u10 (ref), u71 (copy), u5 (ref), u72 (copy), u70 (ref), u73 (copy), u1 (ref)
            if not u10.rest(u71 .. "InvitePost", nil) then
                u10.rest(u71 .. "InvitePost", 60);

                local function buttonResult1() -- Line: 296
                    -- upvalues: u5 (ref), u72 (ref)
                    u5.pullOutPhone("Share It", {
                        createPostLocation = true,
                        important = true,
                        createPost = u72
                    });
                end;

                local function destroyedFunc() -- Line: 299
                    -- upvalues: u70 (ref), u71 (ref)
                    u70[u71] = nil;
                end;

                local v74 = u10.typeOf(u73) == "function";
                local _, v75 = u1.notify({
                    button1 = "Invite",
                    button2 = "Dismiss",
                    custom = "Decision",
                    lifetime = 20,
                    message = v74 and u73() or (v74 and "Do you want to invite people in the server?" or (u73 or "Do you want to invite people in the server?")),
                    buttonResult1 = buttonResult1,
                    destroyedFunc = destroyedFunc
                });
                u70[u71] = v75;
            end;
        end);
    end;
end;

function u1.updateFavoritePropertyWaypoint() -- Line: 310
    -- upvalues: u10 (copy), u1 (copy)
    local FavoriteProperty = u10.getFavoriteProperty();

    if not FavoriteProperty then
        u1.createWaypoint({
            name = "Your House"
        });
        u1.createWaypoint({
            name = "Your Apartment"
        });

        return;
    end;

    local Config = require(workspace.World.Housing[FavoriteProperty].Config);
    workspace.World.Housing[FavoriteProperty]:WaitForChild("ScriptedPersistent");
    u1.createWaypoint({
        image = "rbxassetid://7862262773",
        create = true,
        hideOnScreen = true,
        name = Config.CATEGORY == "House" and "Your House" or "Your Apartment",
        location = workspace.World.Housing[FavoriteProperty].ScriptedPersistent.CenterPosition.Position,
        color = Color3.fromRGB(106, 197, 78)
    });
end;

ModuleLoader.onLoaded(u1.updateFavoritePropertyWaypoint);
local DepthOfField = game_Lighting.DepthOfField;
local u76 = nil;

function u1.activateDepthOfFieldDynamicFocus(p77, p78, u79) -- Line: 335
    -- upvalues: DepthOfField (copy), u76 (ref), u10 (copy), CharScope (copy), workspace_CurrentCamera (copy)
    DepthOfField.Enabled = p77;

    if u76 then
        u10.taskCancel(u76);
    end;

    if p77 then
        local u80 = p78 or 0;
        u76 = CharScope.taskSpawn(function() -- Line: 340
            -- upvalues: u79 (copy), workspace_CurrentCamera (ref), DepthOfField (ref), u80 (ref)
            while true do
                DepthOfField.FocusDistance = ((u79 and u79() or workspace_CurrentCamera.Focus.Position) - workspace_CurrentCamera.CFrame.Position).Magnitude + u80;
                task.wait();
            end;
        end);
    end;
end;

local function adjustValue(p81, p82, p83, p84, p85) -- Line: 350
    -- upvalues: Easing (copy), u10 (copy)
    local v86 = p85 or 0;
    local v87 = Easing[p84];
    local v88 = u10.inverseLerp(p81, p82, p83);

    return (v86 + v87(math.clamp(v88, 0, 1), 0, 1, 1)) / (1 + v86);
end;

local function propertyFormat(p89, p90) -- Line: 355
    -- upvalues: GameRules (copy), Easing (copy), u10 (copy)
    if p89 == "CATEGORY" then
        return "Category", p90;
    end;

    if p89 == "ITEM_CONDITION_CONSUMPTION" then
        return "Uses", math.ceil(p90 / 1000 * 100) .. " %", nil, "2";
    end;

    if p89 == "ITEM_CONDITION_DURABILITY" then
        return "Durability", math.ceil(p90 / 1000 * 100) .. " %", nil, "2";
    end;

    if p89 == "ITEM_CONDITION_FRESHNESS" then
        return "Expiration", math.round(p90 / 1000 * GameRules.foodAndDrinkShelfLifeInHours) .. " Hours", nil, "2";
    end;

    if p89 == "ENERGY" then
        local v91 = nil or 0;
        local linear = Easing.linear;
        local v92 = u10.inverseLerp(0, 70, p90);

        return "Energy", (v91 + linear(math.clamp(v92, 0, 1), 0, 1, 1)) / (1 + v91), "Bar", "3";
    end;

    if p89 == "HUNGER" then
        local v93 = nil or 0;
        local linear = Easing.linear;
        local v94 = u10.inverseLerp(0, 100, p90);

        return "Hunger", (v93 + linear(math.clamp(v94, 0, 1), 0, 1, 1)) / (1 + v93), "Bar", "3";
    end;

    if p89 == "COST" then
        return "Cost", "＄" .. u10.commaValue(p90), nil, "4";
    end;

    if p89 == "RANK" then
        local RANKS = require(game.Teams[p90[1]].Config).RANKS;

        return "Required Rank", RANKS[p90[2]][2] and RANKS[p90[2]][2] .. " (" .. p90[2] .. ")" or p90[2];
    end;

    if p89 == "SPAWN_AMOUNT" then
        local v95 = p90 * (u10.isPrivateServerConfigurationSettingEnabled("placeableObjectsLimit") or 1);

        return "Total Amount", math.floor(v95);
    end;

    if p89 == "DAMAGE_PROTECTION" then
        return "Damage Protection", p90 .. " %";
    end;

    if p89 == "KNOCKBACK" then
        return "Knockback", p90;
    end;

    if p89 == "STAT_REQUIREMENT" then
        return "Requirement", string.gsub(p90[3], "XX", p90[2]);
    end;

    if p89 == "MAX_HEALTH_PET" then
        local v96 = 0.2 or 0;
        local linear = Easing.linear;
        local v97 = u10.inverseLerp(0, 120, p90);

        return "Health", (v96 + linear(math.clamp(v97, 0, 1), 0, 1, 1)) / (1 + v96), "Bar", "3";
    end;

    if p89 == "PET_DAMAGE" then
        local v98 = 0.2 or 0;
        local linear = Easing.linear;
        local v99 = u10.inverseLerp(0, 12, p90);

        return "Damage", (v98 + linear(math.clamp(v99, 0, 1), 0, 1, 1)) / (1 + v98), "Bar", "3";
    end;

    if p89 == "_GAMEPASS" then
        return "Gamepass", p90;
    end;

    if p89 == "Fuel" then
        return "Current Fuel", p90, "Bar", "1";
    end;

    if p89 == "MAX_SPEED" then
        local v100 = 0.1 or 0;
        local linear = Easing.linear;
        local v101 = u10.inverseLerp(50, 160, p90);

        return "Top Speed", (v100 + linear(math.clamp(v101, 0, 1), 0, 1, 1)) / (1 + v100), "Bar", "3";
    end;

    if p89 == "ACCELERATION" then
        local v102 = 0.1 or 0;
        local linear = Easing.linear;
        local v103 = u10.inverseLerp(0.17, 0.4, p90);

        return "Acceleration", (v102 + linear(math.clamp(v103, 0, 1), 0, 1, 1)) / (1 + v102), "Bar", "3";
    end;

    if p89 == "SecurityLevel" then
        return "Security Level", p90;
    end;

    if p89 == "ENGINE_TYPE" then
        return "Type", p90;
    end;

    if p89 == "Ammo" then
        return "Current Ammo", p90[1] .. " / " .. p90[2];
    end;

    if p89 == "MagazineSize" then
        local v104 = 0.1 or 0;
        local linear = Easing.linear;
        local v105 = u10.inverseLerp(7, 50, p90);

        return "Magazine Size", (v104 + linear(math.clamp(v105, 0, 1), 0, 1, 1)) / (1 + v104), "Bar", "3";
    end;

    if p89 == "RPM" then
        local v106 = 0.1 or 0;
        local linear = Easing.linear;
        local v107 = u10.inverseLerp(200, 860, p90);

        return "RPM", (v106 + linear(math.clamp(v107, 0, 1), 0, 1, 1)) / (1 + v106), "Bar", "3";
    end;

    if p89 == "DAMAGE" then
        local v108 = nil or 0;
        local outQuad = Easing.outQuad;
        local v109 = u10.inverseLerp(0, 18.2, p90);

        return "Damage", (v108 + outQuad(math.clamp(v109, 0, 1), 0, 1, 1)) / (1 + v108), "Bar", "3";
    end;

    if p89 == "DAMAGE_MELEE" then
        local v110 = nil or 0;
        local outQuad = Easing.outQuad;
        local v111 = u10.inverseLerp(20, 48, p90);

        return "Damage", (v110 + outQuad(math.clamp(v111, 0, 1), 0, 1, 1)) / (1 + v110), "Bar", "3";
    end;

    if p89 == "FISHING_LUCK_BUFF" then
        return "Fishing Luck", "+" .. p90 .. " %";
    end;

    if p89 == "STRENGTH_BUFF" then
        return "Strength", "+" .. p90 .. " %";
    end;

    if p89 == "HACK_TIME_BUFF" then
        return "Hack Duration", "+" .. p90 .. " %";
    end;

    if p89 == "HUNGER_RESISTANCE_BUFF" then
        return "Hunger Resistance", "+" .. p90 .. " %";
    end;

    if p89 == "HEALTH_REGEN_BUFF" then
        return "Health Regeneration", "+" .. p90 .. " %";
    end;

    if p89 == "STAMINA_REGEN_BUFF" then
        return "Stamina Regeneration", "+" .. p90 .. " %";
    end;

    if p89 == "LUCK_BUFF" then
        return "Luck", "+" .. p90 .. " %";
    end;

    if p89 == "SLOWER_TOOL_DEGRADATION_BUFF" then
        return "Slower Tool Degradation", "+" .. p90 .. " %";
    end;
end;

function u1.createProperty(p112, p113, p114) -- Line: 396
    -- upvalues: propertyFormat (copy), u10 (copy)
    local v115, v116, v117, v118 = propertyFormat(p112, p113);

    if v116 then
        local v119 = u10.clone(p114);
        v119.Visible = true;
        v119.Name = (v118 or "") .. v115;
        v119.Property.Text = v115;
        v119[v117 or "Value"].Visible = true;

        if v117 == "Bar" then
            v119.Bar.Fill.Size = UDim2.fromScale(v116, 1);
            v119.Bar.Fill.BackgroundColor3 = Color3.fromHSV(u10.lerp(23, 110, v116) / 359, 0.5490196078431373, 1);
        elseif v117 == "Color" then
            v119.Color.BackgroundColor3 = v116;
        else
            v119.Value.Text = v116;
        end;

        v119.Parent = p114.Parent;

        return v119;
    end;
end;

function u1.listenToInmobileActivityInterrupted(p120, p121, u122) -- Line: 415
    -- upvalues: u10 (copy), LocalPlayer (copy)
    local InstanceAttributeChangedSignal = u10.getInstanceAttributeChangedSignal(LocalPlayer, "Seat", function(p123) -- Line: 416
        -- upvalues: u122 (copy)
        u122();
    end);
    p120(p121, unpack(InstanceAttributeChangedSignal));
    p120(p121, { LocalPlayer:GetAttributeChangedSignal("Arrested"), function() -- Line: 420
            -- upvalues: u122 (copy)
            u122();
        end });
end;

function u1.getProductRobuxString(p124) -- Line: 424
    -- upvalues: u10 (copy)
    return p124.Robux.Value == 0 and "" or u10.commaValue(p124.Robux.Value);
end;

local function loadRobloxProductDyanamicPrices(u125, u126) -- Line: 428
    -- upvalues: MarketplaceService (copy)
    if u125:FindFirstChild("Robux") then
        task.defer(function() -- Line: 430
            -- upvalues: MarketplaceService (ref), u125 (copy), u126 (copy)
            local function run() -- Line: 431
                -- upvalues: MarketplaceService (ref), u125 (ref), u126 (ref)
                local success, result = pcall(function() -- Line: 432
                    -- upvalues: MarketplaceService (ref), u125 (ref), u126 (ref)
                    return MarketplaceService:GetProductInfo(u125.ID.Value, u126);
                end);

                if success then
                    u125.Robux.Value = result.PriceInRobux;

                    return true;
                end;
            end;

            for i = 1, 3 do
                local success, result = pcall(function() -- Line: 432
                    -- upvalues: MarketplaceService (ref), u125 (ref), u126 (ref)
                    return MarketplaceService:GetProductInfo(u125.ID.Value, u126);
                end);
                local v127;

                if success then
                    u125.Robux.Value = result.PriceInRobux;
                    v127 = true;
                else
                    v127 = nil;
                end;

                if v127 then
                    return;
                end;

                task.wait(10);
                local _ = i;
            end;

            while true do
                local success, result = pcall(function() -- Line: 432
                    -- upvalues: MarketplaceService (ref), u125 (ref), u126 (ref)
                    return MarketplaceService:GetProductInfo(u125.ID.Value, u126);
                end);
                local v128;

                if success then
                    u125.Robux.Value = result.PriceInRobux;
                    v128 = true;
                else
                    v128 = nil;
                end;

                if v128 then
                    return;
                end;

                task.wait(600);
            end;
        end);
    end;
end;

local function searchProducts(p129, u130) -- Line: 451
    -- upvalues: MarketplaceService (copy)
    for _, child in pairs(p129:GetChildren()) do
        if child:FindFirstChild("ID") then
            if child:FindFirstChild("Robux") then
                task.defer(function() -- Line: 430
                    -- upvalues: MarketplaceService (ref), child (copy), u130 (copy)
                    local function _() -- Line: 431
                        -- upvalues: MarketplaceService (ref), child (ref), u130 (ref)
                        local success, result = pcall(function() -- Line: 432
                            -- upvalues: MarketplaceService (ref), child (ref), u130 (ref)
                            return MarketplaceService:GetProductInfo(child.ID.Value, u130);
                        end);

                        if success then
                            child.Robux.Value = result.PriceInRobux;

                            return true;
                        end;
                    end;

                    for i = 1, 3 do
                        local success, result = pcall(function() -- Line: 432
                            -- upvalues: MarketplaceService (ref), child (ref), u130 (ref)
                            return MarketplaceService:GetProductInfo(child.ID.Value, u130);
                        end);
                        local v131;

                        if success then
                            child.Robux.Value = result.PriceInRobux;
                            v131 = true;
                        else
                            v131 = nil;
                        end;

                        if v131 then
                            return;
                        end;

                        task.wait(10);
                        local _ = i;
                    end;

                    while true do
                        local success, result = pcall(function() -- Line: 432
                            -- upvalues: MarketplaceService (ref), child (ref), u130 (ref)
                            return MarketplaceService:GetProductInfo(child.ID.Value, u130);
                        end);
                        local v132;

                        if success then
                            child.Robux.Value = result.PriceInRobux;
                            v132 = true;
                        else
                            v132 = nil;
                        end;

                        if v132 then
                            return;
                        end;

                        task.wait(600);
                    end;
                end);
            end;
        else
            for _, child2 in pairs(child:GetChildren()) do
                if child2:FindFirstChild("Robux") then
                    task.defer(function() -- Line: 430
                        -- upvalues: MarketplaceService (ref), child2 (copy), u130 (copy)
                        local function _() -- Line: 431
                            -- upvalues: MarketplaceService (ref), child2 (ref), u130 (ref)
                            local success, result = pcall(function() -- Line: 432
                                -- upvalues: MarketplaceService (ref), child2 (ref), u130 (ref)
                                return MarketplaceService:GetProductInfo(child2.ID.Value, u130);
                            end);

                            if success then
                                child2.Robux.Value = result.PriceInRobux;

                                return true;
                            end;
                        end;

                        for i = 1, 3 do
                            local success, result = pcall(function() -- Line: 432
                                -- upvalues: MarketplaceService (ref), child2 (ref), u130 (ref)
                                return MarketplaceService:GetProductInfo(child2.ID.Value, u130);
                            end);
                            local v133;

                            if success then
                                child2.Robux.Value = result.PriceInRobux;
                                v133 = true;
                            else
                                v133 = nil;
                            end;

                            if v133 then
                                return;
                            end;

                            task.wait(10);
                            local _ = i;
                        end;

                        while true do
                            local success, result = pcall(function() -- Line: 432
                                -- upvalues: MarketplaceService (ref), child2 (ref), u130 (ref)
                                return MarketplaceService:GetProductInfo(child2.ID.Value, u130);
                            end);
                            local v134;

                            if success then
                                child2.Robux.Value = result.PriceInRobux;
                                v134 = true;
                            else
                                v134 = nil;
                            end;

                            if v134 then
                                return;
                            end;

                            task.wait(600);
                        end;
                    end);
                end;
            end;
        end;
    end;
end;

searchProducts(Stuff.Gamepasses, Enum.InfoType.GamePass);
searchProducts(Stuff.DeveloperProducts, Enum.InfoType.Product);
local u135 = {};

function u1.teamChanged(p136) -- Line: 464
    -- upvalues: u10 (copy), u135 (copy), u1 (copy), GameRules (copy)
    u10.clearConnectionsAndThreads(u135);
    local Config = require(game.Teams[p136].Config);

    if p136 == "Police" then
        if not u1.readPlayerData("Guide", "Police") then
            u1.startGuide("Police", true);
        end;
    elseif Config.MDT then
        if not u1.readPlayerData("Guide", "Emergency Jobs") then
            u1.startGuide("Emergency Jobs", true);
        end;
    elseif Config.RANKS and not u1.readPlayerData("Guide", "Jobs") then
        u1.startGuide("Jobs", true);
    end;

    if not GameRules.disableGuideAndQuests then
        if u1.currentQuest and game.ReplicatedStorage.Gameplay.Quests.Content:FindFirstChild(u1.currentQuest):FindFirstChild("IsTutorial") then
            u1.startQuest();
        end;

        if not u1.currentQuest and p136 ~= "Civilian" then
            local v137 = p136 .. " Vehicle Spawner";

            if game.ReplicatedStorage.Gameplay.Quests.Content:FindFirstChild(v137) and not u1.readPlayerData("Quests", v137) then
                u1.startQuest(v137);
            end;
        end;
    end;
end;

local u138 = nil;

function u1.isSeated() -- Line: 493
    -- upvalues: u2 (copy)
    return u2.seatWeld and u2.seatWeld.Part1;
end;

local u139 = 0;

function u1.sit(u140, u141, p142) -- Line: 498
    -- upvalues: u10 (copy), LocalPlayer (copy), u139 (ref), u1 (copy), CharScope (copy), u2 (copy), u138 (ref), u7 (copy), Ragdoll (copy), u4 (copy), PlayerFunc (copy)
    if not p142 and (u10.invokeTraffic.sit or LocalPlayer:GetAttribute("PartOfBiggerSystemForSeat")) then
        return;
    end;

    u139 = (u139 + 1) % 100;
    local v143 = u139;

    local function v144() -- Line: 502
        -- upvalues: u141 (ref), u140 (ref), u1 (ref), u10 (ref), LocalPlayer (ref), CharScope (ref), u2 (ref)
        local function func() -- Line: 503
            -- upvalues: u141 (ref), u140 (ref), u1 (ref)
            if not (u141 and u141.manualExit or u140:FindFirstChild("ManualExit")) then
                u1.sit();
            end;
        end;

        if not (u141 and u141.keepAssemblyPriority) and u10.isCharLoaded(LocalPlayer) then
            u10.charMassless(LocalPlayer.Character, u140);
        end;

        CharScope.setConnectionsAndThreads("Sit");

        if u140 then
            u1.overwriteJump("sit", func);
        else
            u1.overwriteJump("sit", false);
        end;

        u2.fallRagdollEnabled = not u140;
    end;

    if u138 then
        u10.playAnimation(u138, "stop");
        u138 = nil;
    end;

    if not u140 then
        local v145 = u10.keepCharacterContext(LocalPlayer, u141 and u141.charContextFromServer or LocalPlayer.Character);
        local v146;

        if v145 then
            v146 = LocalPlayer.Character:FindFirstChild("Seat");
        else
            v146 = v145;
        end;

        local u147 = v146 and v146.Part1 or u10.getInstanceAttribute(LocalPlayer, "Seat");

        if not p142 then
            CharScope.taskSpawn(function() -- Line: 574
                -- upvalues: PlayerFunc (ref)
                PlayerFunc:InvokeServer("sit");
            end);
        end;

        if v145 then
            if not (u141 and u141.sentFromServer) then
                if not Ragdoll.isActive and u2.loaded then
                    u2.hum.Sit = false;
                end;

                LocalPlayer.Character.MovementSounds.Volume = 1;

                if v146 then
                    v146.Enabled = false;
                    v146.Part1 = nil;
                end;
            end;

            if u147 then
                local v148 = nil;

                if u147:IsDescendantOf(workspace.Characters) then
                    v148 = u10.getAncestorsChild(workspace.Characters, u147).PrimaryPart;
                elseif u147:IsDescendantOf(game.Players) then
                    v148 = u10.getAncestorsChild(game.Players, u147).Character.PrimaryPart;
                end;

                if v148 and u1.checkIfBothPositionsGoThroughWall(v148.Position, LocalPlayer.Character.PrimaryPart.Position) then
                    u141 = u141 or {};
                    u141.pivotToOnExit = v148.CFrame;
                end;

                u10.charPivotTo(LocalPlayer.Character, u141 and u141.pivotToOnExit or ((function() -- Line: 601, Name: getGetOutAttachmentCFrame
                    -- upvalues: u147 (copy), u10 (ref)
                    if u147 and (u147.Name == "_Seat" and u147:FindFirstChild("GetOut")) then
                        local v149 = u10.raycastParamsNew();
                        v149.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay.Entities, u147.Parent };

                        for _, child in pairs(u147:GetChildren()) do
                            if child.Name == "GetOut" and not u10.raycastVisible(u147.Position, child.WorldPosition - u147.Position, v149) then
                                return child.WorldCFrame;
                            end;
                        end;
                    end;
                end)() or LocalPlayer.Character.PrimaryPart.CFrame + Vector3.new(0, 2, 0)), nil);
            end;
        end;

        if v145 and u2.loaded then
            if u4.equipSlotEnabled ~= true then
                u4.canEquipSlot(true);
            end;

            u2.lockEmotes("sit", false);
            u2.setCharRotType("sit");
            u2.displayBottomBarMessage("sit");
        end;

        u7.disabled(false, "sit");
        u7.disabled(false, "vehicle");
        v144();

        return true;
    end;

    local v150 = u10.keepCharacterContext(LocalPlayer, u141 and u141.charContextFromServer or LocalPlayer.Character, "sit");

    if not (v150 and u2.loaded) then
        return;
    end;

    if u141.sentFromServer then
        u140 = u10.getInstanceReference(u140, 20);
    end;

    if not (u10.keepCharacterContext(LocalPlayer, v150, "sit") and (u2.loaded and (u140 and v143 == u139))) then
        return;
    end;

    local v151 = u140:FindFirstChild("Attachment") and (u140.Attachment:FindFirstChild("EnterDriver") or u140.Attachment:FindFirstChild("EnterPassenger"));

    if u141 and u141.lockEmotes then
        u2.lockEmotes("sit", true);
    end;

    u7.disabled(true, v151 and "vehicle" or "sit");
    local v152;

    if p142 then
        v152 = true;
    else
        local invokeServerTraffic = u10.invokeServerTraffic;
        local Character = LocalPlayer.Character;
        local v153 = {
            newSeat = u140
        };
        local v154;

        if u141 then
            v154 = u141.offset or nil;
        else
            v154 = nil;
        end;

        v153.offset = v154;
        v152 = invokeServerTraffic("sit", Character, v153);
    end;

    if v143 ~= u139 then
        return;
    end;

    if v152 == true and (u10.keepCharacterContext(LocalPlayer, v150, "sit") and u2.loaded) then
        if Ragdoll.isActive then
            Ragdoll.activate(LocalPlayer.Character, false);
        end;

        if u141 and u141.disableSeatedState then
            u2.hum.PlatformStand = false;
        end;

        if u4.isAiming and u4.shoulderCam then
            u4.shoulderCam(false);
        end;

        if u2.emoteFreezePlayer then
            u2.playEmote();
        end;

        local v155 = (v151 and u140.Attachment or u140):FindFirstChildOfClass("ProximityPrompt");
        local v156 = v155 and v155:FindFirstChild("Animation") and v155.Animation.Value or u141 and u141.animation;

        if v156 then
            u138 = u10.loadAnimation(u2.animator, u10.typeOf(v156) == "Instance" and v156 and v156 or game.ReplicatedStorage.PlayerStuff.Animations[v156]);
            u10.playAnimation(u138, "play", 0.01);
        end;

        if u141 and u141.displayBottomMessage then
            u2.displayBottomBarMessage("sit", 0, u141.displayBottomMessage);
        end;

        if u141 and u141.lockInventory or v155 and v155:FindFirstChild("LockInventory") then
            local canEquipSlot = u4.canEquipSlot;
            local v157;

            if u10.typeOf(u141.lockInventory) == "string" then
                v157 = u141.lockInventory or false;
            else
                v157 = false;
            end;

            canEquipSlot(v157);
        end;

        local v158 = u141 and u141.lockRotation;

        if v158 then
            v155 = v158;
        elseif v155 then
            v155 = v155:FindFirstChild("LockRotation");
        end;

        u2.setCharRotType("sit", {
            priority = 2,
            client = v155 and 0 or 3,
            server = v155 and 0 or 1
        });
        v144();

        return true;
    end;

    if u10.typeOf(v152) == "string" then
        u1.notify({
            color = "red",
            message = v152
        });
    end;

    u7.disabled(false, v151 and "vehicle" or "sit");

    if u2.loaded then
        u2.lockEmotes("sit", false);
    end;
end;

local u159 = nil;
task.spawn(function() -- Line: 636
    -- upvalues: LocalizationService (copy), LocalPlayer (copy), u159 (ref)
    local v160;

    while true do
        local v161;
        v161, v160 = pcall(function() -- Line: 638
            -- upvalues: LocalizationService (ref), LocalPlayer (ref)
            return LocalizationService:GetTranslatorForPlayerAsync(LocalPlayer);
        end);

        if v161 then
            break;
        end;

        task.wait(60);
    end;

    u159 = v160;
end);

function u1.translateText(p162, p163) -- Line: 648
    -- upvalues: u159 (ref)
    if u159 then
        p162.Text = u159:Translate(p163, p162.Text);
    end;
end;

u1.userTips = {};
local u164 = 0;

function u1.generateUserTips(p165) -- Line: 671
    -- upvalues: u1 (copy), u164 (ref), u10 (copy)
    table.clear(u1.userTips);
    u164 = 0;
    local v166 = u1.readPlayerData("TipLearned");

    for i, _ in pairs(u10.gameplayTips) do
        if v166[i] ~= true and not (u10.displayGameplayTipWhenInTeam[i] and (u10.displayGameplayTipWhenInTeam[i] ~= p165 and (u10.typeOf(u10.displayGameplayTipWhenInTeam[i]) ~= "table" or not u10.displayGameplayTipWhenInTeam[i][p165]))) then
            table.insert(u1.userTips, i);
        end;
    end;

    u1.userTips = u10.shuffleList(u1.userTips);
end;

function u1.displayTip(u167, p168) -- Line: 680
    -- upvalues: u1 (copy), u10 (copy), CharScope (copy), u164 (ref)
    if not u1.readPlayerData("Settings", "TipsDuringGameplay") then
        local v169 = u1.readPlayerData("Stats", "timeInGame");

        if v169 and (v169 > 5 and not u1.guideGui.Visible) then
            if u167 then
                if not (u1.readPlayerData("TipLearned", u167) or (u10.rest("SpecificTip_" .. u167, 3600) or u10.rest("SpecificTip", 240))) then
                    local function v170() -- Line: 687
                        -- upvalues: u1 (ref), u10 (ref), u167 (copy)
                        u1.notify({
                            custom = "Tip",
                            maxLines = 4,
                            lifetime = 20,
                            destroyOnCharRemoving = true,
                            message = u10.gameplayTips[u167]
                        });
                        u10.tipLearned(u167);
                    end;

                    if p168 then
                        CharScope.taskDelay(p168, v170);

                        return;
                    end;

                    u1.notify({
                        custom = "Tip",
                        maxLines = 4,
                        lifetime = 20,
                        destroyOnCharRemoving = true,
                        message = u10.gameplayTips[u167]
                    });
                    u10.tipLearned(u167);
                end;
            elseif not u1.isNotification("Tip") and #u1.userTips >= 2 then
                u164 = u164 % #u1.userTips + 1;
                u1.notify({
                    custom = "Tip",
                    maxLines = 4,
                    lifetime = 20,
                    destroyOnCharRemoving = true,
                    message = u10.gameplayTips[u1.userTips[u164]]
                });
                u10.tipLearned(u1.userTips[u164], nil, true);
            end;
        end;
    end;
end;

local function hideBubble() -- Line: 703
    local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties");
    BubbleChatMessageProperties.BackgroundTransparency = 10;
    BubbleChatMessageProperties.Text = " ";

    return BubbleChatMessageProperties;
end;

function TextChatService.OnBubbleAdded(p171, p172) -- Line: 710
    -- upvalues: u10 (copy), TextChatService (copy)
    local v173 = p171.TextSource and u10.getPlayerInGameByUserId(p171.TextSource.UserId);

    if v173 then
        if p171.Status == Enum.TextChatMessageStatus.Success then
            local InstanceAttribute = u10.getInstanceAttribute(v173, "ChatTarget");

            if InstanceAttribute and InstanceAttribute:IsDescendantOf(workspace) then
                TextChatService:DisplayBubble(InstanceAttribute, p171.Text);
                local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties");
                BubbleChatMessageProperties.BackgroundTransparency = 10;
                BubbleChatMessageProperties.Text = " ";

                return BubbleChatMessageProperties;
            end;

            if not (v173.Character and v173.Character:IsDescendantOf(workspace)) then
                local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties");
                BubbleChatMessageProperties.BackgroundTransparency = 10;
                BubbleChatMessageProperties.Text = " ";

                return BubbleChatMessageProperties;
            end;
        end;

        if v173:GetAttribute("CustomBubbleChat") then
            local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties");

            for _, child in pairs(game.ReplicatedStorage.Gameplay.CustomBubbleChat[v173:GetAttribute("CustomBubbleChat")]:GetChildren()) do
                BubbleChatMessageProperties[child.Name] = child.Value;
            end;

            return BubbleChatMessageProperties;
        end;
    end;
end;

function u1.getHousingSideEntranceSecondPrompt(p174, p175) -- Line: 735
    for _, child in pairs(p174:GetChildren()) do
        if child.HousingSideEnter.LocationId.Value == p175.LocationId.Value then
            return child.HousingSideEnter;
        end;
    end;
end;

u1.housingSideEntrancesProperty = nil;
local u176 = {};

function u1.createHousingSideEntrances(p177) -- Line: 743
    -- upvalues: u1 (copy), u10 (copy), u176 (copy), Stuff (copy)
    if u1.housingSideEntrancesProperty then
        u10.clearConnectionsAndThreads(u176);
        workspace.World.Housing[u1.housingSideEntrancesProperty.Name].ScriptedPersistent.SideEntrances.Parent = Stuff.Housing.SideEntrances;
        u1.housingSideEntrancesProperty = nil;
    end;

    if p177 then
        local v178 = nil;

        for _, child in pairs(Stuff.Housing.SideEntrances:GetChildren()) do
            if child:GetAttribute("Property") == p177.Name then
                v178 = child;
                break;
            end;
        end;

        if v178 then
            u1.housingSideEntrancesProperty = p177;
            v178.Parent = workspace.World.Housing[p177.Name].ScriptedPersistent;
            table.insert(u176, p177.Destroying:Connect(function() -- Line: 760
                -- upvalues: u1 (ref)
                u1.createHousingSideEntrances();
            end));
        end;
    end;
end;

u1.activeNavigations = {};

function u1.startNavigation(p179, p180, p181) -- Line: 769
    -- upvalues: u1 (copy), u10 (copy), NavigationSystem (copy), u2 (copy)
    if u1.activeNavigations[p179] and u1.activeNavigations[p179].thread then
        u10.taskCancel(u1.activeNavigations[p179].thread);
    end;

    u1.activeNavigations[p179] = p180 and ({
        target = p180,
        color = p181,
        navigator = NavigationSystem.create(true, false)
    } or nil) or nil;

    if u2.loaded then
        if p180 then
            p180 = u1.activeNavigations[p179];
        end;

        u2.startCharacterNavigation(p179, p180);
    end;
end;

local u182 = {};
local u183 = {};
local LoadingGui = PlayerGui:WaitForChild("LoadingGui");
LoadingGui.Enabled = true;
LoadingGui.Right.Visible = false;
CharScope.taskSpawn(u10.transparencyFade, LoadingGui.Background, false, 0);
u10.tweenServiceSet(LoadingGui.Black, {
    BackgroundTransparency = 1
});
u1.loadingActivated = nil;
local u184 = nil;
local u185 = nil;
local u186 = nil;

function u1.activateLoading(p187) -- Line: 787
    -- upvalues: u1 (copy), LoadingGui (copy), GameRules (copy), u186 (ref), u184 (ref), u10 (copy), GuiService (copy), u7 (copy), u183 (copy), Heartbeat (copy), u182 (copy), workspace_CurrentCamera (copy), u185 (ref), CharScope (copy), u3 (copy), LocalPlayer (copy)
    if u1.loadingActivated == nil and p187 then
        LoadingGui.Right.Bottom.TextLabel.Text = "";
    end;

    if GameRules.disablePlayerLoadingScreen then
        return;
    end;

    if p187 and u186 then
        u186(p187);
    end;

    if (u1.loadingActivated and true or false) ~= (p187 and true or false) then
        u1.loadingActivated = p187 and true or false;

        if p187 then
            if u184 then
                u184(true);
            end;

            u10.contextAction("BindActionAtPriority", "LoadingGuiNoResetOnDeath", function() -- Line: 796
                return Enum.ContextActionResult.Sink;
            end, false, Enum.ContextActionPriority.High.Value + 3, Enum.PlayerActions.CharacterJump, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward);
            GuiService.TouchControlsEnabled = false;
            u7.disabled(true, "loadingGuiNoResetOnDeath");
            u1.focusOnScreenGui(LoadingGui, true);
            u10.guiTransition(LoadingGui.Right, "Position", UDim2.fromScale(0, 0.03), true, 1);
            table.insert(u183, Heartbeat:Connect(function(p188) -- Line: 802
                -- upvalues: LoadingGui (ref)
                LoadingGui.Right.Bottom.Image.Rotation = LoadingGui.Right.Bottom.Image.Rotation + 3 * p188 * 60;
            end));

            local function globalCleanUp(p189) -- Line: 805
                -- upvalues: u10 (ref), u183 (ref), u182 (ref), u1 (ref), LoadingGui (ref), GuiService (ref), u7 (ref), workspace_CurrentCamera (ref), u186 (ref), u184 (ref)
                u10.clearConnectionsAndThreads(u183);
                u10.clearConnectionsAndThreads(u182);
                u1.focusOnScreenGui(LoadingGui, false);
                u10.contextAction("UnbindAction", "LoadingGuiNoResetOnDeath");
                GuiService.TouchControlsEnabled = true;
                u7.disabled(false, "loadingGuiNoResetOnDeath");
                u10.resetPlrCameraZoom();
                task.defer(function() -- Line: 814
                    -- upvalues: workspace_CurrentCamera (ref)
                    for i = 1, 10 do
                        if workspace_CurrentCamera.CameraSubject and workspace_CurrentCamera.CameraSubject.Parent then
                            workspace_CurrentCamera.CFrame = (workspace_CurrentCamera.CameraSubject:IsA("Humanoid") and workspace_CurrentCamera.CameraSubject.Parent or workspace_CurrentCamera.CameraSubject):GetPivot() * CFrame.Angles(-0.2617993877991494, 0, 0);
                        end;

                        task.wait();
                        local _ = i;
                    end;
                end);
                u186 = nil;
                u184 = nil;

                if not p189 then
                    u1.loadingActivated = nil;
                end;
            end;

            if not u1.longLoadingGui then
                u185 = function() -- Line: 826, Name: loadingGuiEnd
                    -- upvalues: u184 (ref)
                    u184();
                end;

                u184 = function(p190) -- Line: 829, Name: loadingGuiCleanUp
                    -- upvalues: u10 (ref), LoadingGui (ref), globalCleanUp (copy)
                    u10.tweenServiceStart(LoadingGui.Black, TweenInfo.new(0.42, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    });
                    globalCleanUp(p190);
                end;

                u10.tweenServiceSet(LoadingGui.Black, {
                    BackgroundTransparency = 1
                });
                u10.tweenServiceStart(LoadingGui.Black, TweenInfo.new(0.42, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0
                });

                return;
            end;

            local u191 = nil;
            local u192 = false;
            local u193 = nil;
            local u194 = u10.clone(LoadingGui.LoadingBlur);
            u194.Enabled = true;
            u194.Parent = game.Lighting;

            u185 = function() -- Line: 842, Name: loadingGuiEnd
                -- upvalues: u10 (ref), u183 (ref), CharScope (ref), LoadingGui (ref), u194 (copy), u192 (ref), u182 (ref), u193 (ref), u184 (ref)
                u10.clearConnectionsAndThreads(u183);
                CharScope.taskSpawn(u10.transparencyFade, LoadingGui.Background, false, 0.5);
                u10.tweenServiceStart(u194, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = 0
                });
                table.insert(u182, task.spawn(function() -- Line: 848
                    -- upvalues: u192 (ref), u193 (ref), u10 (ref), u184 (ref)
                    if u192 then
                        task.wait(2.6);
                    else
                        local u195 = u193;
                        task.wait(1.2);
                        u10.easingLoop(0.7, "inCubic", 0, -50, function(p196) -- Line: 854
                            -- upvalues: u193 (ref), u195 (copy)
                            u193 = u195 + Vector3.new(0, p196, 0);
                        end);
                        u10.easingLoop(0.56, "linear", -50, -130, function(p197) -- Line: 857
                            -- upvalues: u193 (ref), u195 (copy)
                            u193 = u195 + Vector3.new(0, p197, 0);
                        end);
                    end;

                    u184();
                end));
            end;

            u184 = function(p198) -- Line: 864, Name: loadingGuiCleanUp
                -- upvalues: u10 (ref), u194 (copy), u191 (ref), u3 (ref), globalCleanUp (copy)
                u10.setCameraProperties("99");
                u194:Destroy();

                if u191 then
                    u3.freezeVehicle(u191, "loadingGui", false);
                end;

                globalCleanUp(p198);
            end;

            u186 = function(u199) -- Line: 872, Name: loadingGuiEachActivation
                -- upvalues: u10 (ref), u193 (ref), u192 (ref), u183 (ref), LoadingGui (ref)
                local function setCameraCFrame(p200) -- Line: 873
                    -- upvalues: u10 (ref), u193 (ref), u192 (ref)
                    local LocationInsideAtPos = u10.getLocationInsideAtPos(p200);

                    if not LocationInsideAtPos then
                        u193 = CFrame.new(p200 + Vector3.new(0, 200, 0)) * CFrame.Angles(-1.5707963267948966, 0, 0);
                        u192 = false;

                        return;
                    end;

                    local InstanceAttribute = u10.getInstanceAttribute(LocationInsideAtPos, "Property");
                    local v201 = InstanceAttribute and workspace.World.Housing[InstanceAttribute.Name].ScriptedPersistent.CameraOutsideAngle.CFrame or LocationInsideAtPos:FindFirstChild("CameraOutsideAngle") and LocationInsideAtPos.CameraOutsideAngle.CFrame;
                    u193 = v201;
                    u192 = true;
                end;

                setCameraCFrame(u10.typeOf(u199) == "Instance" and u199.PrimaryPart and u199.PrimaryPart.Position or (u10.typeOf(u199) == "Position" and u199 and u199 or workspace.Camera.CFrame.Position));

                if u10.typeOf(u199) == "Instance" then
                    table.insert(u183, task.spawn(function() -- Line: 888
                        -- upvalues: u199 (copy), setCameraCFrame (copy), LoadingGui (ref), u10 (ref)
                        local HumanoidRootPart = u199:WaitForChild("HumanoidRootPart", 10);

                        if HumanoidRootPart then
                            setCameraCFrame(HumanoidRootPart.Position);
                            LoadingGui.Right.Bottom.TextLabel.Text = u10.getLocationStringAtPos(HumanoidRootPart.Position);
                        end;
                    end));
                end;
            end;

            u186(p187);
            CharScope.taskSpawn(u10.transparencyFade, LoadingGui.Background, true, 0);
            u10.tweenServiceSet(u194, {
                Size = 15
            });
            u10.setCameraProperties("99", {
                FieldOfView = 40,
                CameraType = Enum.CameraType.Scriptable
            });
            local u202 = u10.handHeldCamera();

            for _, v in pairs(u202.threads) do
                table.insert(u182, v);
            end;

            local u203 = 0;
            table.insert(u182, task.spawn(function() -- Line: 925
                -- upvalues: u191 (ref), u10 (ref), LocalPlayer (ref), u3 (ref), u202 (copy), u203 (ref), u193 (ref)
                while true do
                    u191 = not u191 and u10.getVehicleInfo.controlledVehicle(LocalPlayer);

                    if u191 then
                        u3.freezeVehicle(u191, "loadingGui", true);
                    end;

                    u202.update(u203, u193);
                    u203 = task.wait();
                end;
            end));

            return;
        end;

        u185();
        u185 = nil;
        task.spawn(function() -- Line: 940
            -- upvalues: u10 (ref), LoadingGui (ref)
            u10.guiTransition(LoadingGui.Right, "Position", UDim2.fromScale(0, 0.03), false, 4);
        end);
    end;
end;

u1.playerDataVersion = 0;
local u204 = nil;
game.ReplicatedStorage.Remote.AccessData.OnClientEvent:Connect(function(p205) -- Line: 951
    -- upvalues: u1 (copy), u204 (ref), u10 (copy)
    u1.playerDataVersion = u1.playerDataVersion + 1;
    u204 = p205;
    u10.deepFreezeTable(u204);
end);

function u1.readPlayerData(...) -- Line: 957
    -- upvalues: u204 (ref)
    while not u204 do
        task.wait(0.03);
    end;

    local v206 = u204;

    for _, v in pairs({ ... }) do
        if v206[v] == nil then
            return;
        end;

        v206 = v206[v];
    end;

    return v206;
end;

u1.stamina = u1.readPlayerData("Stamina") or 100;
u1.food = u1.readPlayerData("Food") or 100;

function u1.setCoreStaminaOrFood(p207, p208) -- Line: 970
    -- upvalues: u1 (copy), PlayerEvent (copy)
    u1[p207] = p208;
    PlayerEvent:FireServer("setStaminaOrFood", p207, p208);
end;

local function setMobileButtonConstraint(p209) -- Line: 975
    -- upvalues: u1 (copy)
    p209.MinSize = u1.platform == "Mobile" and Vector2.new(20, 20) or Vector2.new();
end;

u1.defaultSaturation = game_Lighting.ColorCorrection.Saturation;
u1.defaultContrast = game_Lighting.ColorCorrection.Contrast;
u1.inventory = u10.deepCopyTable(u1.readPlayerData("Inventory"));
u1.overwriteJumpTable = {};
u1.isJumpEnabled = true;

function u1.characterJumped(p210, p211) -- Line: 985
    -- upvalues: u1 (copy)
    if not p211 or p211.UserInputState == Enum.UserInputState.Begin then
        for _, v in pairs(u1.overwriteJumpTable) do
            v[1]();
        end;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function overwriteJumpNewCharacter() -- Line: 991
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.overwriteJumpTable) do
        if not v[2] then
            u1.overwriteJump(i);
        end;
    end;
end;

function u1.overwriteJump(p212, p213, p214) -- Line: 996
    -- upvalues: u1 (copy), u10 (copy)
    u1.overwriteJumpTable[p212] = p213 and { p213, p214 } or nil;

    if u10.isTableEmpty(u1.overwriteJumpTable) ~= u1.isJumpEnabled then
        u1.isJumpEnabled = not u1.isJumpEnabled;
        u10.contextAction(u1.isJumpEnabled and "UnbindAction" or "BindActionAtPriority", "OverwriteJump", u1.characterJumped, false, Enum.ContextActionPriority.High.Value + 2, Enum.PlayerActions.CharacterJump, Enum.KeyCode.ButtonA);
    end;
end;

local u215 = {
    Default = {
        RenderDistance = 200,
        MaxRefreshRate = 0.04,
        GlobalWind = workspace.GlobalWind
    },
    Blizzard = {
        RenderDistance = 350,
        MaxRefreshRate = 0.02,
        GlobalWind = nil
    },
    Thunderstorm = {
        RenderDistance = 350,
        MaxRefreshRate = 0.02,
        GlobalWind = nil
    },
    Windy = {
        RenderDistance = 350,
        MaxRefreshRate = 0.02,
        GlobalWind = nil
    }
};

function u1.setGlobalWind(p216) -- Line: 1014
    -- upvalues: u1 (copy), u215 (copy)
    u1.windShake.RenderDistance = u215[p216].RenderDistance;
    u1.windShake.MaxRefreshRate = u215[p216].MaxRefreshRate;
    workspace.GlobalWind = u215[p216].GlobalWind;
end;

u1.windShake = require(game.ReplicatedStorage.Modules:WaitForChild("WindShake"));
u1.setGlobalWind("Default");
u1.windShake:Init({
    MatchWorkspaceWind = true
});
FrontGui.TopBarButtons.Position = UDim2.fromOffset(GuiService.TopbarInset.Min.X + 11, GuiService.TopbarInset.Max.Y - 46);
GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 1024, Name: updateTopBarButtonsPosition
    -- upvalues: FrontGui (copy), GuiService (copy)
    FrontGui.TopBarButtons.Position = UDim2.fromOffset(GuiService.TopbarInset.Min.X + 11, GuiService.TopbarInset.Max.Y - 46);
end);

function u1.createDeveloperProductListener(p217) -- Line: 1030
    -- upvalues: u1 (copy)
    u1.developerProductListener = p217;

    return function() -- Line: 1032
        -- upvalues: u1 (ref)
        u1.developerProductListener = nil;
    end;
end;

function u1.entranceSwitch(p218, p219, p220) -- Line: 1035
    -- upvalues: u10 (copy), PlayerFunc (copy)
    local Attribute = p218:GetAttribute("Open");
    u10.entrance(p218, not Attribute, nil, p219, nil, p220);
    PlayerFunc:InvokeServer("entranceSwitch", p218, not Attribute);
end;

function u1.entranceOpenAndClose(p221, p222, p223, p224) -- Line: 1041
    -- upvalues: u10 (copy), PlayerFunc (copy)
    PlayerFunc:InvokeServer("entranceOpenAndClose", p221, (u10.entrance(p221, p222, nil, p223, nil, p224)));
end;

function u1.adjustBodyAngle(p225, p226, p227, p228) -- Line: 1046
    if not p225.EvaluationThrottled then
        if p228 == 1 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(math.max(p227.X * 0.5, 0), -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 3, -p227.Y / 1.8, 0);

            return;
        end;

        if p228 == 2 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(math.max(p227.X * 0.5, 0), -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 3, -p227.Y / 1.8, 0);

            return;
        end;

        if p228 == 3 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(math.max(p227.X * 0.7, 0), -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 2, -p227.Y / 1.8, 0);

            return;
        end;

        if p228 == 4 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(math.max(p227.X * 0.7, 0), -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 2, -p227.Y / 1.8, 0);

            return;
        end;

        if p228 == 5 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(p227.X, -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 2, -p227.Y / 1.8, 0);

            return;
        end;

        if p228 == 6 then
            p226.UpperTorso.Transform = p226.UpperTorso.Transform * CFrame.Angles(p227.X * 0.5, -p227.Y / 2, 0);
            p226.Head.Transform = p226.Head.Transform * CFrame.Angles(p227.X / 2, -p227.Y / 1.8, 0);
        end;
    end;
end;

task.defer(function() -- Line: 1075
    -- upvalues: ContentProvider (copy), u10 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;

    ContentProvider:PreloadAsync(u10.collectionGetTagged("PreloadContent"));
end);
local u229 = true;
local u230 = nil;
local u231 = 0;
local u232 = nil;
local u233 = nil;
local u234 = nil;
u1.bubbleChatTextColor = TextChatService.BubbleChatConfiguration.TextColor3;
u1.bubbleChatBackgroundColor = TextChatService.BubbleChatConfiguration.BackgroundColor3;

if u1.readPlayerData("Settings", "ChatCloud") then
    TextChatService.BubbleChatConfiguration.TextColor3 = Color3.fromRGB(250, 250, 250);
    TextChatService.BubbleChatConfiguration.BackgroundColor3 = Color3.fromRGB(57, 59, 61);
end;

if u1.readPlayerData("Settings", "MuteMusicAmbience") then
    game.SoundService.SoundGroups.MusicAmbience.Volume = 0;
end;

UserInputService.TextBoxFocused:Connect(function() -- Line: 1100
    -- upvalues: GameRules (copy)
    GameRules.focus = false;
end);
UserInputService.TextBoxFocusReleased:Connect(function() -- Line: 1101
    -- upvalues: GameRules (copy)
    GameRules.focus = true;
end);
task.defer(function() -- Line: 1102
    -- upvalues: GameRules (copy), UserInputService (copy)
    pcall(function() -- Line: 1103
        -- upvalues: GameRules (ref), UserInputService (ref)
        local v235 = false;

        while true do
            if game.StarterGui:GetCore("DevConsoleVisible") ~= v235 then
                v235 = game.StarterGui:GetCore("DevConsoleVisible");
                local v236 = not v235 and not UserInputService:GetFocusedTextBox();
                GameRules.focus = v236;
            end;

            task.wait(0.5);
        end;
    end);
end);

function u1.isPlayerMutedOrBlockedByThisPlayer(p237) -- Line: 1116
    -- upvalues: u1 (copy)
    if p237 then
        p237 = u1.mutedPlayerId[p237.UserId] or p237:GetAttribute("Blocked");
    end;

    return p237;
end;

function u1.isOnIncomingMessageMuted(p238) -- Line: 1120
    if p238.TextSource and p238.Text == "" then
        return true;
    end;
end;

function TextChatService.OnIncomingMessage(p239) -- Line: 1124
    -- upvalues: u10 (copy), u1 (copy)
    if p239.TextSource then
        local PlayerInGameByUserId = u10.getPlayerInGameByUserId(p239.TextSource.UserId);

        if u1.isPlayerMutedOrBlockedByThisPlayer(PlayerInGameByUserId) then
            p239.Text = "";
        end;
    end;
end;

local u240 = false;

function u1.screenFade(p241, p242) -- Line: 1132
    -- upvalues: u240 (ref), u10 (copy), FullScreenGui (copy)
    if u240 ~= p241 then
        u240 = p241;

        if p242 == 0 then
            u10.tweenServiceSet(FullScreenGui.Black, {
                BackgroundTransparency = p241 and 0 or 1
            });

            return;
        end;

        u10.tweenServiceStart(FullScreenGui.Black, TweenInfo.new(p242 or 0.42, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = p241 and 0 or 1
        });
        task.wait(p242 or 0.42);
    end;
end;

function u1.addFunctionalityToOptionMenuGui(u243, u244) -- Line: 1145
    -- upvalues: u1 (copy), u10 (copy)
    local v245 = {};
    table.insert(v245, u1.mouseButton(u243.Expand, function() -- Line: 1147
        -- upvalues: u244 (copy), u243 (copy)
        if u244 and u244.optionsExpanded then
            u244.optionsExpanded();
        end;

        u243.List.Visible = not u243.List.Visible;
    end));
    u243.List.Visible = false;
    local u246 = nil;

    local function setOption(p247) -- Line: 1153
        -- upvalues: u244 (copy), u246 (ref), u243 (copy), u10 (ref)
        if u244 and u244.optionSet then
            u244.optionSet(p247);
        end;

        if u246 then
            u243.List[u246].BackgroundColor3 = Color3.fromRGB(89, 89, 89);
            u10.resetButtonColor(u243.List[u246]);
        end;

        local v248 = u243.List[p247];
        u246 = p247;
        v248.BackgroundColor3 = Color3.fromRGB(108, 108, 108);
        u10.resetButtonColor(v248, true);
        u243.Text.TextLabel.Text = v248.TextLabel.Text;
    end;

    for _, child in pairs(u243.List:GetChildren()) do
        if child:IsA("ImageButton") then
            child.BackgroundColor3 = Color3.fromRGB(89, 89, 89);
            u10.resetButtonColor(child);
            table.insert(v245, u10.buttonHoverSignalData(child));
            table.insert(v245, u1.mouseButton(child, function() -- Line: 1167
                -- upvalues: setOption (copy), child (copy), u243 (copy)
                setOption(child.Name);
                u243.List.Visible = false;
            end));
        end;
    end;

    if u244 and u244.startOption then
        setOption(u244.startOption);
    end;

    return v245;
end;

function u1.addFunctionalityToSwitchGui(u249, u250) -- Line: 1174
    -- upvalues: u10 (copy), u1 (copy)
    local v251 = {};
    local u252 = false;

    local function setSwitch(p253, p254) -- Line: 1177
        -- upvalues: u250 (copy), u252 (ref), u249 (copy), u10 (ref)
        if u250 and u250.switchSet then
            u250.switchSet(p253);
        end;

        u252 = p253;
        u249:SetAttribute("On", u252 or nil);
        u249.Circle:TweenPosition(UDim2.fromScale(u252 and 0.77 or 0.23, 0.5), "Out", "Linear", p254 and 0.06 or 0, true);
        u249.ImageColor3 = u252 and Color3.fromRGB(74, 136, 55) or Color3.fromRGB(136, 136, 136);
        u10.resetButtonColor(u249);
    end;

    setSwitch(u250.isOn or false, false);
    table.insert(v251, u1.mouseButton(u249, function() -- Line: 1186
        -- upvalues: setSwitch (copy), u252 (ref)
        setSwitch(not u252, true);
    end));
    table.insert(v251, u10.buttonHoverSignalData(u249));

    return v251, function(p255) -- Line: 1190
        -- upvalues: setSwitch (copy)
        setSwitch(p255, true);
    end;
end;

local u256 = {};

function u1.onRagdoll(p257) -- Line: 1195
    -- upvalues: u10 (copy), u256 (copy), u2 (copy), u7 (copy), u4 (copy), u3 (copy), u1 (copy), u5 (copy)
    u10.clearConnectionsAndThreads(u256);

    if u2.loaded then
        u2.lockEmotes("ragdoll", p257);
        u2.escortPlayer();
    end;

    u7.disabled(p257, "ragdoll");

    if p257 and (u4.isAiming and (u2.loaded and u4.shoulderCam)) then
        u4.shoulderCam(false);
    end;

    u3.enterVehicle(false);

    if u1.openedGui == "PhoneCamera" and u2.loaded then
        u5.activatePhoneCamera();
    end;

    if p257 then
        local u258 = nil;
        table.insert(u256, task.defer(function() -- Line: 1207
            -- upvalues: u1 (ref), u10 (ref), u258 (ref)
            while true do
                local v259 = u1.rootPersistent and u1.rootPersistent.Parent and u10.isTerrainInPart(u1.rootPersistent, false) == Enum.Material.Water;

                if (u258 and true or false) ~= v259 then
                    if v259 then
                        u258 = u10.clone(game.ReplicatedStorage.Gameplay.FloatPlayerOnWaterRagdoll);
                        u258:SetAttribute("UIATC", true);
                        u258.Attachment0 = u10.getCharAttachment(u1.rootPersistent, "RootAttachment");
                        u258.Force = Vector3.new(0, u1.rootPersistent.Mass * 196.2, 0);
                        u258.Parent = u1.rootPersistent;
                    elseif u258 then
                        u258:Destroy();
                        u258 = nil;
                    end;
                end;

                task.wait(1);
            end;
        end));
        table.insert(u256, function() -- Line: 1225
            -- upvalues: u258 (ref)
            if u258 and u258.Parent then
                u258:Destroy();
            end;
        end);
    end;
end;

function u1.createDriversLicense(p260) -- Line: 1232
    -- upvalues: u10 (copy)
    local v261 = u10.clone(game.ReplicatedStorage.PlayerStuff.DriversLicenseGui);
    v261.Frame.Namee.Text = p260.DisplayName .. " (@" .. p260.Name .. ")";
    u10.createUpdatedAvatarThumbnail(v261.Frame.PlayerIcon, p260, p260.Character.CurrentDescription, p260.Character:GetAttribute("AgeLook"));
    v261.Frame.Address.Text = p260:GetAttribute("DriversLicenseAddress");
    v261.Frame.ID.Text = p260.UserId;
    v261.Frame.Issued.Text = p260:GetAttribute("DriversLicenseIssued");
    v261.Frame.Exp.Text = p260:GetAttribute("DriversLicenseExp");

    if game.ReplicatedStorage.Variables.IsPrivateServer.Value == 1 then
        local v262 = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[u10.privateServerAvailableConfiguration.language.display[game.ReplicatedStorage.Variables.IsPrivateServer:GetAttribute("language")] or "English (United States)"];
        v261.Frame.Flag.Image = v262.Texture;
        v261.Frame.CountryCode.Text = string.upper(game.ReplicatedStorage.Variables.IsPrivateServer:GetAttribute("language") or "USA");
    end;

    return v261;
end;

local u263 = {};
u1.isMouseFirstPersonUnlocked = false;

function u1.unlockMouseFirstPerson(p264, p265) -- Line: 1251
    -- upvalues: u263 (copy), u1 (copy), u10 (copy)
    if p264 == "clear" then
        table.clear(u263);
    end;

    u263[p264] = p265 or nil;
    u1.isMouseFirstPersonUnlocked = not u10.isTableEmpty(u263);
    u1.activateMouseIcon();
end;

u1.openedGui = nil;
u1.openedGuiDontResetOnDeath = nil;
local u266 = false;

function u1.openGui(p267, p268, p269, p270) -- Line: 1261
    -- upvalues: u1 (copy), GlobalGui (copy), u7 (copy), u4 (copy), u2 (copy), u266 (ref)
    u1.openedGuiDontResetOnDeath = p270;
    u1.openedGui = p267;
    GlobalGui.Waypoints.Visible = not p267;
    u1.updateTopBarButtonsVisibility();
    u7.disabled(p267, "openGui");

    if u4.isAiming and (u2.loaded and u4.shoulderCam) then
        u4.shoulderCam(false);
    end;

    if not p269 then
        u1.unlockMouseFirstPerson("openGui", p267);
    end;

    if u1.openedGui and not u266 then
        u266 = true;
        task.defer(function() -- Line: 1271
            -- upvalues: u1 (ref), u2 (ref), u266 (ref)
            while u1.openedGui do
                if u2.disableToggleCameraIfToggled then
                    u2.disableToggleCameraIfToggled();
                end;

                task.wait(0.1);
            end;

            u266 = false;
        end);
    end;

    if p268 and u2.loaded then
        u4.equipSlot();
    end;
end;

local u271 = nil;

function u1.lockMouseBahavior(p272) -- Line: 1285
    -- upvalues: u271 (ref), UserInputService (copy), u2 (copy), u1 (copy)
    u271 = p272;
    UserInputService.MouseBehavior = p272 and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default;
    task.spawn(function() -- Line: 1288
        -- upvalues: u271 (ref), UserInputService (ref), u2 (ref), u1 (ref)
        while u271 do
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter and not (u2.firstPerson or u1.isMouseFirstPersonUnlocked) then
                UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
            end;

            task.wait();
        end;
    end);
end;

function u1.canHideCharacterClient(p273, p274) -- Line: 1298
    -- upvalues: u10 (copy), u1 (copy)
    if u10.isCharLoaded(p273) then
        if not p273:GetAttribute("Pursuit") then
            return true;
        end;

        if p274.pursuit then
            u1.notify({
                color = "red",
                message = p274.pursuit
            });
        end;

        return false;
    end;
end;

local u275 = {};

function u1.hideGui(u276, p277) -- Line: 1310
    -- upvalues: u275 (copy), u2 (copy), GlobalGui (copy), FrontGui (copy)
    local function screenGui(p278) -- Line: 1311
        -- upvalues: u276 (copy)
        for _, child in pairs(p278:GetChildren()) do
            if child.Name == "Center" or (child.Name == "Left" or child.Name == "Right") then
                for _, child2 in pairs(child:GetChildren()) do
                    if child2:IsA("Frame") and child2.Name ~= "__FakeFrame" then
                        if string.sub(child2.Name, 1, 7) == "HideGui" then
                            child2.Visible = u276;

                            for _, child3 in pairs(child2:GetChildren()) do
                                if child3:IsA("Frame") then
                                    child3.Visible = child3.Name == u276;
                                end;
                            end;
                        else
                            child2.Visible = not u276;
                        end;
                    end;
                end;
            elseif child.Name ~= "Inventory" then
                child.Visible = not u276;
            end;
        end;
    end;

    for _, v in pairs(u275) do
        if v[1].Parent then
            v[1].Parent = v[2];
        end;
    end;

    table.clear(u275);

    if u2.screenGui then
        screenGui(u2.screenGui);
    end;

    screenGui(GlobalGui);
    screenGui(FrontGui);

    if p277 then
        for _, v in pairs(p277) do
            table.insert(u275, { v, v.Parent });
            v.Parent = v.Parent.Parent["HideGui" .. v.Parent.Name];
        end;
    end;
end;

local u279 = u10.raycastParamsNew();
u279.IgnoreWater = true;

function u1.throwPhysicsObject(p280, p281, p282, p283) -- Line: 1348
    -- upvalues: LocalPlayer (copy), PlayerEvent (copy), CharScope (copy), u10 (copy), u279 (copy), RunService (copy)
    if LocalPlayer.PhysicsObjects:FindFirstChild(p280) then
        local v284 = 0.2 + (p282 - p281.Position).Magnitude * 0.004;
        local Vector3_new_ret = Vector3.new(0, -game.Workspace.Gravity, 0);
        local v285 = p281 * (p283 or Vector3.new(0, 1, -2));
        PlayerEvent:FireServer("throwPhysicsObject", p280);
        local u286 = LocalPlayer.PhysicsObjects[p280];
        u286.Parent = workspace.Gameplay.Entities;
        u286.PrimaryPart.CFrame = CFrame.new(v285);
        u286.PrimaryPart.AssemblyLinearVelocity = (p282 - v285 - Vector3_new_ret * 0.5 * v284 * v284) / v284;
        local u287 = nil;
        local u288 = nil;
        CharScope.taskDefer(function() -- Line: 1363
            -- upvalues: u286 (copy), u287 (ref), u10 (ref), u288 (ref), u279 (ref), RunService (ref)
            while u286.Parent do
                if u287 and u10.smartUnit(u287):Dot(u10.smartUnit(u286.PrimaryPart.AssemblyLinearVelocity)) < 0.95 then
                    local function customRaycast(p289, p290, p291) -- Line: 1367
                        -- upvalues: u286 (ref)
                        return workspace:Spherecast(p289, u286.PrimaryPart.Size.X, p290, p291);
                    end;

                    local v293 = u10.raycastVisible(u288, u10.smartUnit(u287) * 5, u279, {
                        customRaycast = customRaycast,

                        customRequirements = function(p292) -- Line: 1370, Name: customRequirements
                            if p292.Instance.Transparency == 1 then
                                p292 = false;
                            end;

                            return p292;
                        end
                    });
                    local v294 = v293 and v293.Instance:IsDescendantOf(workspace.Characters) and u10.getAncestorsChild(workspace.Characters, v293.Instance);
                    u286:Destroy();
                    local v295 = v293 and v293.Position or u288;
                    local selectiveObjReplicaSystem = u10.selectiveObjReplicaSystem;
                    local v296 = {};

                    if v294 then
                        v294 = u10.getPlayerFromCharacter(v294);
                    end;

                    v296.target = v294;
                    v296.hitPos = v295;
                    selectiveObjReplicaSystem("destroyPhysicsObject", u286, true, v296);

                    return;
                end;

                u287 = u286.PrimaryPart.AssemblyLinearVelocity;
                u288 = u286.PrimaryPart.Position;
                RunService.RenderStepped:Wait();
            end;
        end);
    end;
end;

u1.debugLoadingClient("Core 2");
local u297 = {
    Trunk = true
};

function u1.spawnLocalVehicleInsideLocation(p298, p299, p300, p301, p302, p303) -- Line: 1390
    -- upvalues: u1 (copy), u10 (copy), LocalPlayer (copy), u297 (copy)
    if u1.locationVehicle and not p302 then
        for _, v in pairs(u1.locationVehicle) do
            v:Destroy();
        end;

        u1.locationVehicle = nil;
    end;

    if p298 then
        local v304 = p300 and (u10.deepCopyTable(u1.readPlayerData("Vehicles", p298.Config.Type.Value, p298.Name)) or {}) or {};
        require(p298.Config);
        local Attribute = LocalPlayer:GetAttribute("Callsign");

        if Attribute then
            v304.Callsign = Attribute;
        end;

        if p301 then
            for i, v in pairs(p301) do
                v304[i] = v;
            end;
        end;

        if not u1.locationVehicle then
            u1.locationVehicle = {};
        end;

        table.insert(u1.locationVehicle, 1, u10.clone(p298));
        u10.setVehicleAnchored(u1.locationVehicle[1], true);
        u10.setVehicleAtSpawnPoint(u1.locationVehicle[1], p299, p303);
        u1.locationVehicle[1].Parent = workspace.Gameplay.Entities;
        u10.loadVehicleCustomization(u1.locationVehicle[1], v304);

        for _, descendant in pairs(u1.locationVehicle[1]:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") and not u297[descendant.Name] then
                descendant.Enabled = false;
            end;
        end;

        return u1.locationVehicle[1];
    end;
end;

local u305 = nil;
local u306 = nil;

function u1.teamWorldContent() -- Line: 1434
    -- upvalues: LocalPlayer (copy), u305 (ref), u306 (ref)
    if LocalPlayer.Team ~= u305 then
        if u306 then
            u306.Parent = u305;
            u306 = nil;
        end;

        if LocalPlayer.Team:FindFirstChild("TeamWorldContent") then
            u306 = LocalPlayer.Team.TeamWorldContent;
            u306.Parent = workspace.World;
        end;

        u305 = LocalPlayer.Team;
    end;
end;

local u307 = {
    red = Color3.fromRGB(204, 79, 79),
    blue = Color3.fromRGB(85, 131, 204)
};
local MainBox = FrontGui.Center.Middle.MainBox;
local u308 = 0;

function u1.disableMainBox() -- Line: 1453
    -- upvalues: u2 (copy), u7 (copy), u1 (copy), CharScope (copy), u308 (ref), u10 (copy), MainBox (copy)
    if u2.loaded then
        u2.lockHumanoidState("mainBox", false);
    end;

    u7.disabled(false, "mainBox");
    u1.unlockMouseFirstPerson("mainBox", false);
    CharScope.setConnectionsAndThreads("MainBox");
    u308 = (u308 + 1) % 100;
    u10.guiTransition(MainBox, "Size", 0.95, false);
end;

function u1.mainBox(u309) -- Line: 1462
    -- upvalues: MainBox (copy), u10 (copy), CharScope (copy), u2 (copy), u7 (copy), u1 (copy), u308 (ref), u307 (copy), GameRules (copy)
    if MainBox.Visible then
        return;
    end;

    for _, child in pairs(MainBox:GetChildren()) do
        child.Visible = u309.case == child.Name;
    end;

    u10.guiTransition(MainBox, "Size", 0.95, true);
    CharScope.setConnectionsAndThreads("MainBox");

    if u309.lockHumanoidState and u2.loaded then
        u2.lockHumanoidState("mainBox", -1);
    end;

    u7.disabled(true, "mainBox");
    u1.unlockMouseFirstPerson("mainBox", true);

    if u2.disableToggleCameraIfToggled then
        u2.disableToggleCameraIfToggled();
    end;

    u308 = (u308 + 1) % 100;
    local u310 = u308;

    if u309.infoButton then
        MainBox[u309.case].Info.Visible = true;
        CharScope.buildSignalData("MainBox", u1.displayGuiDetails(MainBox[u309.case].Info, u309.infoButton));
    elseif u309.case and MainBox[u309.case]:FindFirstChild("Info") then
        MainBox[u309.case].Info.Visible = false;
    end;

    if u309.case == "Info" or u309.case == "BigInfo" then
        local v311 = u10.fitText(u309.case == "Info" and MainBox.Info.Content or MainBox.BigInfo._ScrollingList.Scroll.Content, u309.content, u309.maxLines or (u309.case == "Info" and 8 or false));
        CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(MainBox[u309.case].Close));
        CharScope.buildSignalData("MainBox", u1.mouseButton(MainBox[u309.case].Close, function() -- Line: 1483
            -- upvalues: u1 (ref)
            u1.disableMainBox();
        end, {
            addMobileButton = true
        }));

        if u309.case == "BigInfo" then
            MainBox.BigInfo._ScrollingList.Scroll.Content.LineHeight = u309.lineHeight or 1;
            MainBox.BigInfo._ScrollingList.Scroll.Content.TextXAlignment = u309.textXAlignment or Enum.TextXAlignment.Center;
            MainBox.BigInfo._ScrollingList.Scroll.Content.RichText = u309.richText or false;

            if v311 <= 15 then
                MainBox.BigInfo._ScrollingList.Scroll.Content.AnchorPoint = Vector2.new(0.5, 0.5);
                MainBox.BigInfo._ScrollingList.Scroll.Content.Position = UDim2.fromScale(0.5, 0.5);
                MainBox[u309.case].ScrollBar.Visible = false;

                return;
            end;

            MainBox.BigInfo._ScrollingList.Scroll.Content.AnchorPoint = Vector2.new(0.5, 0);
            MainBox.BigInfo._ScrollingList.Scroll.Content.Position = UDim2.fromScale(0.5, 0);
            MainBox[u309.case].ScrollBar.Visible = true;
            local v312 = u10.scrollingListSystem(MainBox.BigInfo._ScrollingList.Scroll, 0.3, {
                scrollBar = MainBox.BigInfo.ScrollBar,
                limitY = MainBox.BigInfo._ScrollingList.Scroll.Content.Size.Y.Scale - 1
            });
            CharScope.buildSignalData("MainBox", unpack(v312.multipleSignalData));
            CharScope.addThreadOrCleanUpFunction("MainBox", v312.cleanUp);
        end;
    else
        if u309.case == "Decision" then
            local u313 = nil;
            local u314 = 0;
            u10.fitText(MainBox.Decision.TopBar.Headline, u309.headline, 4);

            local function setButton(u315, u316, u317) -- Line: 1505
                -- upvalues: CharScope (ref), u10 (ref), u1 (ref), u313 (ref), u307 (ref), u314 (ref)
                u315.Visible = true;

                local function createConnection() -- Line: 1507
                    -- upvalues: CharScope (ref), u10 (ref), u315 (copy), u1 (ref), u313 (ref), u317 (copy)
                    CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(u315));
                    CharScope.buildSignalData("MainBox", u1.mouseButton(u315, function() -- Line: 1509
                        -- upvalues: u313 (ref), u317 (ref)
                        u313 = u317;
                    end));
                end;

                if u10.typeOf(u316) == "table" then
                    u315.TextLabel.Text = u316[1];

                    if u316[2] then
                        u315.ImageColor3 = u307[u316[2]];
                        u10.resetButtonColor(u315);
                    end;

                    if u316[3] then
                        u314 = u316[3];

                        return CharScope.taskSpawn(function() -- Line: 1519
                            -- upvalues: u316 (copy), u315 (copy), u313 (ref), createConnection (copy)
                            for i = u316[3], 1, -1 do
                                u315.TextLabel.Text = "WAIT " .. i;
                                task.wait(1);

                                if u313 then
                                    return;
                                end;

                                local _ = i;
                            end;

                            u315.TextLabel.Text = u316[1];
                            createConnection();
                        end);
                    end;
                else
                    u315.TextLabel.Text = u316;
                end;

                createConnection();
            end;

            MainBox.Decision.Button1.ImageColor3 = u307.blue;
            u10.resetButtonColor(MainBox.Decision.Button1);
            setButton(MainBox.Decision.Button1, u309.button, 1);
            setButton(MainBox.Decision.Button2, u309.button2, 2);
            CharScope.taskDelay(GameRules.mainGuiBoxTimeOut + u314, function() -- Line: 1535
                -- upvalues: u313 (ref)
                u313 = false;
            end);

            while not u313 do
                task.wait(0.03);
            end;

            u1.disableMainBox();

            return u313;
        end;

        if u309.case == "Text" or (u309.case == "LongText" or u309.case == "RoleplayScene") then
            local u318 = MainBox[u309.case];
            local u319 = nil;
            local u320 = nil;
            local u321 = u10.textBoxSystem(u318.Content.TextBoxFrame, {
                enableScrolling = true
            });
            CharScope.buildSignalData("MainBox", unpack(u321.multipleSignalData));
            CharScope.addThreadOrCleanUpFunction("MainBox", u321.cleanUp);

            if u309.case == "RoleplayScene" then
                local u322 = nil;

                local function selectColor(p323) -- Line: 1547
                    -- upvalues: u322 (ref), u318 (copy), u320 (ref)
                    if u322 then
                        u322.Selection.Visible = false;
                        u322 = nil;
                    end;

                    if p323 then
                        u322 = u318.Colors[p323];
                        u322.Selection.Visible = true;
                        u320 = p323;
                    end;
                end;

                for _, child in pairs(u318.Colors:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.Selection.Visible = false;
                        CharScope.buildSignalData("MainBox", u1.mouseButton(child, function() -- Line: 1561
                            -- upvalues: child (copy), u322 (ref), u318 (copy), u320 (ref)
                            local Name = child.Name;

                            if u322 then
                                u322.Selection.Visible = false;
                                u322 = nil;
                            end;

                            if Name then
                                u322 = u318.Colors[Name];
                                u322.Selection.Visible = true;
                                u320 = Name;
                            end;
                        end));
                    end;
                end;

                local v324 = u309.roleplaySceneColor or "1";

                if u322 then
                    u322.Selection.Visible = false;
                    u322 = nil;
                end;

                if v324 then
                    u322 = u318.Colors[v324];
                    u322.Selection.Visible = true;
                    u320 = v324;
                end;
            else
                u318.Content.TextBoxFrame.TextBox.TextEditable = not u309.lockEdit;
                u10.fitText(u318.Headline, u309.headline, 4);

                if u309.case == "LongText" then
                    CharScope.buildSignalData("MainBox", u1.mouseButton(u318.Content, function() -- Line: 1569
                        -- upvalues: u321 (copy)
                        u321.captureFocus();
                    end));
                    local u325 = nil;
                    CharScope.taskSpawn(function() -- Line: 1573
                        -- upvalues: u308 (ref), u310 (copy), u325 (ref), u318 (copy), u10 (ref)
                        while u308 == u310 do
                            if u325 ~= u318.Content.TextBoxFrame.TextBox.Text then
                                u318.Content.TextBoxFrame.TextBox.Size = u318.Content.Preview.Size;
                                local CursorPosition = u318.Content.TextBoxFrame.TextBox.CursorPosition;
                                local _, _ = u10.fitText(u318.Content.TextBoxFrame.TextBox, u318.Content.TextBoxFrame.TextBox.Text, 9);
                                u325 = u318.Content.TextBoxFrame.TextBox.Text;
                                u318.Content.TextBoxFrame.TextBox.CursorPosition = CursorPosition;
                            end;

                            task.wait();
                        end;
                    end);
                end;
            end;

            u318.Content.TextBoxFrame.TextBox.PlaceholderText = u309.textPlaceholder or "Empty";
            u321.captureFocus();
            u318.Content.TextBoxFrame.TextBox.Text = u309.startText or "";

            if u309.startText then
                u318.Content.TextBoxFrame.TextBox.CursorPosition = string.len(u309.startText) + 1;
            end;

            CharScope.taskDelay(0.03, function() -- Line: 1591
                -- upvalues: u318 (copy), u309 (copy)
                u318.Content.TextBoxFrame.TextBox.Text = u309.startText or "";
            end);
            u318.Accept.TextLabel.Text = u309.acceptContent or "CONFIRM";
            CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(u318.Accept));
            CharScope.buildSignalData("MainBox", u1.mouseButton(u318.Accept, function() -- Line: 1594
                -- upvalues: u309 (copy), u318 (copy), u319 (ref)
                if u309.textCanBeEmpty or u318.Content.TextBoxFrame.TextBox.Text ~= "" then
                    u318.Content.TextBoxFrame.TextBox:ReleaseFocus();
                    local v326;

                    if u309.acceptTextFunc and not u309.acceptTextFunc(u318.Content.TextBoxFrame.TextBox.Text) then
                        v326 = nil;
                    else
                        v326 = u318.Content.TextBoxFrame.TextBox.Text or nil;
                    end;

                    u319 = v326;
                end;
            end));
            CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(u318.Close));
            CharScope.buildSignalData("MainBox", u1.mouseButton(u318.Close, function() -- Line: 1601
                -- upvalues: u319 (ref)
                u319 = false;
            end, {
                addMobileButton = true
            }));

            if u309.formatTextFunc then
                CharScope.buildSignalData("MainBox", { u318.Content.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text"), function() -- Line: 1603
                        -- upvalues: u318 (copy), u309 (copy)
                        u318.Content.TextBoxFrame.TextBox.Text = u309.formatTextFunc(u318.Content.TextBoxFrame.TextBox.Text);
                    end });
            end;

            while u319 == nil do
                task.wait(0.03);
            end;

            u318.Content.TextBoxFrame.TextBox:ReleaseFocus();
            u1.disableMainBox();

            return u319, u320;
        end;

        if u309.case == "List" then
            CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(MainBox.Info.Close));
            CharScope.buildSignalData("MainBox", u1.mouseButton(MainBox.List.Close, function() -- Line: 1613
                -- upvalues: u1 (ref)
                u1.disableMainBox();
            end, {
                addMobileButton = true
            }));
            local u327 = nil;

            for _, child in pairs(MainBox.List._ScrollingList.Scroll.List:GetChildren()) do
                if child:IsA("ImageButton") and child.Visible then
                    child:Destroy();
                end;
            end;

            local u328 = nil;
            local u329 = nil;

            for i, v in pairs(u309.list) do
                local u330 = u10.clone(MainBox.List._ScrollingList.Scroll.List.ElementPreview);
                u330.Name = "Element";
                u330.Visible = true;
                u330.TextLabel.Text = v;
                u330.Parent = MainBox.List._ScrollingList.Scroll.List;
                CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(u330));

                local function pressed() -- Line: 1624
                    -- upvalues: u330 (copy), u328 (ref), u10 (ref), u329 (ref), i (copy)
                    if u330 ~= u328 then
                        if u328 then
                            u328.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                            u328.ImageTransparency = 0.9;
                            u328.ImageColor3 = Color3.fromRGB(255, 255, 255);
                            u10.resetButtonColor(u328, false);
                        end;

                        u330.TextLabel.TextColor3 = Color3.fromRGB(85, 85, 85);
                        u330.ImageTransparency = 0;
                        u330.ImageColor3 = Color3.fromRGB(255, 255, 255);
                        u10.resetButtonColor(u330, true);
                        u329 = i;
                        u328 = u330;
                    end;
                end;

                CharScope.buildSignalData("MainBox", u1.mouseButton(u330, function() -- Line: 1640
                    -- upvalues: pressed (copy)
                    pressed();
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));

                if u309.startValue == i then
                    pressed();
                end;
            end;

            CharScope.buildSignalData("MainBox", u10.buttonHoverSignalData(MainBox.List.Accept));
            CharScope.buildSignalData("MainBox", u1.mouseButton(MainBox.List.Accept, function() -- Line: 1644
                -- upvalues: u329 (ref), u327 (ref)
                if u329 then
                    u327 = u329;
                end;
            end));
            CharScope.taskDelay(GameRules.mainGuiBoxTimeOut + (u309.timeOut or 0), function() -- Line: 1647
                -- upvalues: u327 (ref)
                u327 = false;
            end);
            local v331 = u10.scrollingListSystem(MainBox.List._ScrollingList.Scroll, 0.3, {
                scrollBar = MainBox.List.ScrollBar
            });
            CharScope.buildSignalData("MainBox", unpack(v331.multipleSignalData));
            CharScope.addThreadOrCleanUpFunction("MainBox", v331.cleanUp);

            while not u327 do
                task.wait(0.03);
            end;

            u1.disableMainBox();

            return u327;
        end;
    end;
end;

local u332 = {};

function u1.activateBlur(p333, p334) -- Line: 1659
    -- upvalues: u332 (copy), u10 (copy), game_Lighting (copy)
    if p333 == "clear" then
        table.clear(u332);
    else
        u332[p333] = typeof(p334) == "number" and p334 and p334 or (p334 and 10 or nil);
    end;

    if u10.isTableEmpty(u332) then
        game_Lighting.Blur.Enabled = false;

        return;
    end;

    local v335 = 0;

    for _, v in pairs(u332) do
        if v335 < v then
            v335 = v;
        end;
    end;

    game_Lighting.Blur.Size = v335;
    game_Lighting.Blur.Enabled = true;
end;

function u1.arcadeTokensRenewTime() -- Line: 1678
    -- upvalues: u1 (copy), GameRules (copy), u10 (copy)
    if u1.readPlayerData("ArcadeTokens") ~= GameRules.maxArcadeTokens then
        local v336 = u1.readPlayerData("ArcadeTokensCooldown") - u10.getGlobalHour();

        if v336 < 0 then
            v336 = GameRules.arcadeTokensResetCooldownInHours or v336;
        end;

        return v336;
    end;
end;

function u1.createCharacterDummy(p337) -- Line: 1686
    -- upvalues: u2 (copy), u10 (copy), LocalPlayer (copy)
    if u2.hum then
        local v338 = u10.clone(game.ReplicatedStorage.Gameplay.Dummy);
        v338.Parent = game.ReplicatedStorage.Gameplay.Entities;

        if LocalPlayer.UserId > 0 then
            u10.applyDescription(v338.Humanoid, p337 or u2.hum:GetAppliedDescription());
        end;

        return v338;
    end;
end;

function u1.emitBlood(p339, p340) -- Line: 1698
    -- upvalues: u1 (copy), u10 (copy)
    if not u1.readPlayerData("Settings", "ShowBlood") and p339 then
        if p339:IsA("Player") or not p339 then
            p339 = p339.Character;
        end;

        if p339 and p339.Parent then
            local v341 = u10.clone(game.ReplicatedStorage.PlayerStuff.Blood);
            v341.CFrame = p340 and CFrame.new(p340) or CFrame.new(p339.PrimaryPart.Position);
            v341.Parent = workspace.Gameplay.Entities;

            for _, child in pairs(v341:GetChildren()) do
                u10.emit(child, child.Rate);
            end;
        end;
    end;
end;

local BindableEvent = Instance.new("BindableEvent");
u10.pcallLoad(function() -- Line: 1713
    -- upvalues: StarterGui (copy), BindableEvent (copy)
    StarterGui:SetCore("ResetButtonCallback", BindableEvent);
end);
BindableEvent.Event:Connect(function() -- Line: 1716
    -- upvalues: u10 (copy), LocalPlayer (copy), u1 (copy)
    if not u10.invokeTraffic.selectTeam and LocalPlayer.Team then
        local v342 = u10.invokeServerTraffic("selectTeam", LocalPlayer.Team.Name);

        if u10.typeOf(v342) == "string" then
            u1.notify({
                color = "red",
                message = v342
            });
        end;
    end;
end);

function u1.displayProximityPromptOnObjects(u343) -- Line: 1723
    -- upvalues: CharScope (copy), u10 (copy)
    local u346 = CharScope.taskSpawn(function() -- Line: 1724
        -- upvalues: u343 (copy), CharScope (ref), u10 (ref)
        while true do
            local Targets = u343.getTargets();

            if Targets then
                for i, v in pairs(Targets) do
                    if not u343.promptTable[i] then
                        local v344 = u343.promptPreview(i);
                        local v345;

                        if u343.getWorkspaceObject then
                            v345 = u343.getWorkspaceObject(i) or i;
                        else
                            v345 = i;
                        end;

                        v344.Parent = v345;
                        CharScope.addEntity(v344);
                        u343.promptTable[i] = v344;

                        if u10.typeOf(v) == "function" then
                            v(v344);
                        end;
                    end;
                end;
            end;

            for i, v in pairs(u343.promptTable) do
                if i.Parent then
                    if Targets and Targets[i] then
                        if u343.update then
                            u343.update(v, i);
                        end;
                    else
                        u343.promptTable[i]:Destroy();
                        u343.promptTable[i] = nil;
                    end;
                else
                    u343.promptTable[i] = nil;
                end;
            end;

            task.wait(0.2);
        end;
    end);

    return function() -- Line: 1750
        -- upvalues: u10 (ref), u346 (copy), u343 (copy)
        u10.taskCancel(u346);

        for i, _ in pairs(u343.promptTable) do
            u343.promptTable[i]:Destroy();
            u343.promptTable[i] = nil;
        end;
    end;
end;

function u1.initiateIdleAnimationCFrame() -- Line: 1760
    local v347 = {};
    local IdleAnimation = require(game.ReplicatedStorage.Modules.IdleAnimation);
    local u348 = #IdleAnimation.LeftLowerArm - 1;

    function v347.loadMotors(u349) -- Line: 1764
        -- upvalues: IdleAnimation (copy), u348 (copy)
        local Animator = u349.Humanoid.Animator;
        local u350 = {};

        for i, _ in pairs(IdleAnimation) do
            u350[i] = u349[i]:FindFirstChildOfClass("AnimationConstraint");
        end;

        local u351 = 0;

        return u350, function(p352) -- Line: 1769
            -- upvalues: u349 (copy), Animator (copy), u351 (ref), u348 (ref), u350 (copy), IdleAnimation (ref)
            if not (u349:GetAttribute("FreezeIdleAnimation") or Animator.EvaluationThrottled) then
                u351 = (u351 + p352 / 0.016666666666666666) % u348;
                local v353 = math.round(u351) + 1;

                for i, v in pairs(u350) do
                    v.Transform = v.Transform * CFrame.new(unpack(IdleAnimation[i][v353]));
                end;

                return true;
            end;
        end;
    end;

    return v347;
end;

local u354 = {};
currentScreenGuis = {};

function u1.focusOnScreenGui(u355, p356) -- Line: 1784
    -- upvalues: u10 (copy), u354 (copy), PlayerGui (copy), u1 (copy), u2 (copy)
    local function clear() -- Line: 1785
        -- upvalues: u10 (ref), u354 (ref)
        u10.clearConnectionsAndThreads(u354);
    end;

    local function hideWithLowerDisplayOrder() -- Line: 1788
        -- upvalues: PlayerGui (ref)
        local v357 = -1;

        for i, _ in pairs(currentScreenGuis) do
            if v357 < i.DisplayOrder then
                v357 = i.DisplayOrder;
            end;
        end;

        for _, child in pairs(PlayerGui:GetChildren()) do
            if child:IsA("ScreenGui") and not child:GetAttribute("IgnoreGuiMainScript") then
                child.Enabled = child.DisplayOrder == v357 and currentScreenGuis[child] or v357 < child.DisplayOrder;
            end;
        end;
    end;

    if p356 then
        if u10.isTableEmpty(currentScreenGuis) then
            u10.clearConnectionsAndThreads(u354);

            if u1.unlockMouseFirstPerson then
                u1.unlockMouseFirstPerson("focusOnScreenGui", true);
            end;

            if u2.disableToggleCameraIfToggled then
                u2.disableToggleCameraIfToggled();
            end;

            table.insert(u354, PlayerGui.ChildAdded:Connect(hideWithLowerDisplayOrder));
            table.insert(u354, u355.Destroying:Connect(function() -- Line: 1803
                -- upvalues: u1 (ref), u355 (copy)
                u1.focusOnScreenGui(u355);
            end));
        end;
    elseif currentScreenGuis[u355] and u10.indexedTableSize(currentScreenGuis) == 1 then
        u10.clearConnectionsAndThreads(u354);

        if u1.unlockMouseFirstPerson then
            u1.unlockMouseFirstPerson("focusOnScreenGui", false);
        end;
    end;

    currentScreenGuis[u355] = p356 and true or nil;
    u1.updateTopBarButtonsVisibility();
    hideWithLowerDisplayOrder();
end;

u1.mouseIconGui = GlobalGui.Center.Middle.MouseIcon;
local u358 = nil;

function u1.activateMouseIcon(p359) -- Line: 1817
    -- upvalues: u358 (ref), u1 (copy), u2 (copy), UserInputService (copy)
    if p359 ~= nil then
        u358 = p359;
    end;

    for _, child in pairs(u1.mouseIconGui:GetChildren()) do
        if child.Name ~= "TargetHit" then
            child.Visible = false;
        end;
    end;

    if not (u358 or not u1.isMouseFirstPersonUnlocked and u2.firstPerson) then
        UserInputService.MouseIconEnabled = true;

        return;
    end;

    u1.mouseIconGui[u358 or u2.firstPerson and "Dot"].Visible = true;
    UserInputService.MouseIconEnabled = false;
end;

local RedBlueTransition = GlobalGui.Center.Middle.RedBlueTransition;
local u360 = 0;

function u1.redBlueTransition(p361) -- Line: 1835
    -- upvalues: u360 (ref), RedBlueTransition (copy), u10 (copy)
    u360 = (u360 + 1) % 100;
    local u362 = u360;

    if not p361 then
        for _, child in pairs(RedBlueTransition:GetChildren()) do
            u10.tweenServiceSet(child, {
                ImageTransparency = 1
            });
        end;

        RedBlueTransition.Visible = false;

        return;
    end;

    local u363 = 0;
    RedBlueTransition.Visible = true;
    task.spawn(function() -- Line: 1841
        -- upvalues: u10 (ref), RedBlueTransition (ref), u362 (copy), u360 (ref), u363 (ref)
        for i = 1, 9 do
            local u364 = i * 0.2 + 0.4;
            task.spawn(function() -- Line: 1844
                -- upvalues: u10 (ref), RedBlueTransition (ref), i (copy), u364 (copy), u362 (ref), u360 (ref), u363 (ref)
                while true do
                    u10.tweenServiceStart(RedBlueTransition["Flare" .. i], TweenInfo.new(u364, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    });
                    task.wait(u364);

                    if u362 ~= u360 then
                        break;
                    end;

                    u10.tweenServiceStart(RedBlueTransition["Flare" .. i], TweenInfo.new(u364, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageTransparency = u10.lerp(1, 0.5, u363 / 3)
                    });
                    task.wait(u364);

                    if u362 ~= u360 then
                        return;
                    end;
                end;
            end);
            task.wait(0.2);
            local _ = i;
        end;
    end);

    while u363 < 3 do
        u363 = u363 + task.wait();
    end;
end;

function u1.recordSpeed(u365, u366, u367, u368, u369) -- Line: 1862
    -- upvalues: u1 (copy), GameRules (copy), u10 (copy), LocalPlayer (copy), CharScope (copy)
    local u370 = {
        overSpeedLimit = nil,
        speedLimit = nil,
        lastPos = Vector3.new()
    };
    local u371 = nil;
    local u372 = u1.readPlayerData("Settings", "SpeedUnit") and GameRules.mphToKmh or 1;

    function u370.update(p373, p374) -- Line: 1866
        -- upvalues: u370 (copy), u10 (ref), u369 (copy), GameRules (ref), LocalPlayer (ref), u365 (copy), u368 (copy), u366 (copy), u372 (copy), u371 (ref), CharScope (ref), u367 (copy)
        if (u370.lastPos - p374).Magnitude > 15 then
            u370.lastPos = p374;
            u370.speedLimit = u10.getSpeedLimitAtPos(u370.lastPos);

            if u369 then
                u369();
            end;
        end;

        if p373 then
            local math_round_ret = math.round(p373.PrimaryPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph);

            if u370.speedLimit and u370.speedLimit + 5 <= math_round_ret then
                if not u370.overSpeedLimit then
                    local v375 = u10.getVehicleInfo.controlledBy(p373);

                    if not (u10.invokeTraffic.radarCaughtSpeeding or (u10.rest("RadarCaughtSpeeding_" .. LocalPlayer.Name, nil, v375) or not u10.invokeServerTraffic("radarCaughtSpeeding", v375, u365))) then
                        u10.rest("RadarCaughtSpeeding_" .. LocalPlayer.Name, 60, v375);
                    end;

                    if u368 then
                        u368();
                    end;
                end;

                if (u370.overSpeedLimit or 0) < math_round_ret then
                    u370.overSpeedLimit = math_round_ret;
                    u366.Text = math.round(math_round_ret * u372);

                    if u371 then
                        u10.taskCancel(u371);
                    end;

                    u371 = CharScope.taskDelay(8, function() -- Line: 1890
                        -- upvalues: u370 (ref), math_round_ret (copy), u367 (ref)
                        if u370.overSpeedLimit == math_round_ret then
                            u370.overSpeedLimit = nil;
                            u367();
                        end;
                    end);
                end;
            elseif not u370.overSpeedLimit then
                u366.Text = math.round(math_round_ret * u372);
            end;
        end;
    end;

    function u370.cleanUp() -- Line: 1900
        -- upvalues: u371 (ref), u10 (ref)
        if u371 then
            u10.taskCancel(u371);
        end;
    end;

    return u370;
end;

local function checkForType(p376, p377) -- Line: 1907
    -- upvalues: u1 (copy)
    if p377 ~= "shopAssistantInRadius" or u1.openedGui ~= "Panel" then
        return true;
    end;

    task.wait(40);

    return false;
end;

local Details = FrontGui.Center.Middle.Details;

local function isGuiObstructed(p378) -- Line: 1941
    -- upvalues: PlayerGui (copy), u10 (copy)
    for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(p378.AbsolutePosition.X + p378.AbsoluteSize.X / 2, p378.AbsolutePosition.Y + p378.AbsoluteSize.Y / 2)) do
        if v == p378 then
            return;
        end;

        if u10.isGuiNon1Transparency(v) and not (v:IsDescendantOf(p378) or v:GetAttribute("IgnoredByDetails")) then
            return true;
        end;
    end;
end;

local u379 = nil;

local function destroyGuiDetails(p380) -- Line: 1948
    -- upvalues: u379 (ref), TweenService (copy), u10 (copy)
    u379 = nil;
    TweenService:Create(p380.Background, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(p380.TextLabel, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    u10.debrisServiceAddItem(p380, 0.09);
end;

function u1.displayGuiDetails(u381, u382, u383) -- Line: 1955
    -- upvalues: isGuiObstructed (copy), u379 (ref), destroyGuiDetails (copy), u10 (copy), Details (copy), CharScope (copy), u1 (copy), TweenService (copy)
    return { u381.MouseEnter, function() -- Line: 1956
            -- upvalues: isGuiObstructed (ref), u381 (copy), u379 (ref), destroyGuiDetails (ref), u10 (ref), Details (ref), u382 (copy), CharScope (ref), u1 (ref), u383 (copy), TweenService (ref)
            if not isGuiObstructed(u381) then
                if u379 then
                    if u379[2] == u381 then
                        u379[1]:Destroy();
                    else
                        destroyGuiDetails(u379[1]);
                    end;
                end;

                local u384 = u10.clone(Details.DetailsPreview);
                u379 = { u384, u381 };
                u384.Visible = true;
                u384.Name = "Details";
                local v385 = u10.typeOf(u382) == "function" and u382() or u382;
                u384.TextLabel.Text = v385;
                u384.Parent = Details;
                local v386 = u10.fitText(u384.TextLabel, v385, 20);
                u384.Background.Size = UDim2.fromScale(u10.getTextBounds(u384.TextLabel).X / u384.AbsoluteSize.X + 0.2, v386 * 0.45 + 0.55);
                CharScope.taskSpawn(function() -- Line: 1972
                    -- upvalues: u384 (copy), u1 (ref), u381 (ref), u383 (ref), Details (ref)
                    while u384.Parent do
                        local v387 = u1.keepWithinGuiAbsolute({
                            AbsolutePosition = Vector2.new(u381.AbsolutePosition.X + u381.AbsoluteSize.X / 2 - u384.Background.AbsoluteSize.X / 2, u381.AbsolutePosition.Y - u384.Background.AbsoluteSize.Y - 4),
                            AbsoluteSize = u384.Background.AbsoluteSize
                        }, u383);
                        u384.Position = UDim2.fromScale((v387.X - Details.AbsolutePosition.X + u384.Background.AbsoluteSize.X / 2) / Details.AbsoluteSize.X, (v387.Y - Details.AbsolutePosition.Y) / Details.AbsoluteSize.Y);
                        task.wait();
                    end;
                end);
                TweenService:Create(u384.Background, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                TweenService:Create(u384.TextLabel, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                CharScope.taskSpawn(function() -- Line: 1984
                    -- upvalues: u10 (ref), u381 (ref), u384 (copy), u1 (ref), u379 (ref), destroyGuiDetails (ref)
                    while u10.isInFrame(u381) and u10.isGuiTrulyVisible(u381) do
                        task.wait(0.03);

                        if not u384.Parent then
                            return;
                        end;
                    end;

                    if u1.platform == "Mobile" then
                        task.wait(1);
                    end;

                    if not u379 or u379[1] ~= u384 then
                        return;
                    end;

                    destroyGuiDetails(u384);
                end);
            end;
        end };
end;

local MapLocations = game.ReplicatedStorage.Gameplay.MapLocations;
u1.trackedCharacters = {};

function u1.trackCharacterOnMap(p388, p389, p390) -- Line: 1997
    -- upvalues: LocalPlayer (copy), u1 (copy)
    if p388 ~= LocalPlayer then
        if u1.trackedCharacters[p388] then
            u1.trackedCharacters[p388]:Destroy();
            u1.trackedCharacters[p388] = nil;
        end;

        if p389 and p388 then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Value = p388;
            u1.trackedCharacters[p388] = ObjectValue;

            if p389 == "Callsign" then
                ObjectValue.Name = p388:GetAttribute("Callsign") .. " - " .. p388.DisplayName;
            else
                ObjectValue.Name = p388.DisplayName;
            end;

            ObjectValue.Value = p388;
            ObjectValue.Parent = p390;
        end;
    end;
end;

u1.propertyGarageInteractions = {};

function u1.parentPropertyGarageInteraction(p391, p392) -- Line: 2021
    -- upvalues: u1 (copy)
    local v393 = u1.readPlayerData("Housing", p391) and workspace.World.Housing[p391].ScriptedPersistent or game.ReplicatedStorage.Gameplay.Entities;

    for _, v in pairs(p392) do
        if v393 ~= v.Parent then
            v.Parent = v393;
        end;
    end;
end;

function u1.parentPropertyGarageInteractions() -- Line: 2025
    -- upvalues: u1 (copy)
    u1.readPlayerData("Housing");

    for i, v in pairs(u1.propertyGarageInteractions or {}) do
        u1.parentPropertyGarageInteraction(i, v);
    end;
end;

function u1.waitForCharGround(p394, p395, p396) -- Line: 2041
    -- upvalues: u1 (copy)
    while not (u1.isSeated() or p396 and (p396.excludeMap and p394.Position.Y > -100) or workspace:Raycast(p394.Position, Vector3.new(0, -15, 0), p395)) do
        local v397;

        if p394 then
            v397 = p394.Parent;
        else
            v397 = p394;
        end;

        print("NO GROUND", p394, v397);
        task.wait(0.1);
    end;

    return true;
end;

local u398 = {};

local function charInlocationSpecificModifications(p399, u400) -- Line: 2050
    -- upvalues: u10 (copy), LocalPlayer (copy), u8 (copy), u398 (copy), u1 (copy), u2 (copy), u6 (copy), CharScope (copy)
    if u400.Name == "Auto Shop" or u400.Name == "Boat Repair Shop" then
        if p399 then
            local InstanceAttributeChangedSignal = u10.getInstanceAttributeChangedSignal(LocalPlayer, "InVehicle", function(p401) -- Line: 2053, Name: kickOut
                -- upvalues: u10 (ref), LocalPlayer (ref), u8 (ref), u400 (copy)
                if not (p401 or (not u10.isCharLoaded(LocalPlayer) or u8.enteringVehicleAutoShop)) then
                    u10.charPivotTo(LocalPlayer.Character, u400.MainExit.CFrame + u400.MainExit.CFrame.LookVector * 4);
                end;
            end);
            u10.buildSignalData(u398, unpack(InstanceAttributeChangedSignal));

            if not (u10.getInstanceAttribute(LocalPlayer, "InVehicle") or (not u10.isCharLoaded(LocalPlayer) or u8.enteringVehicleAutoShop)) then
                u10.charPivotTo(LocalPlayer.Character, u400.MainExit.CFrame + u400.MainExit.CFrame.LookVector * 4);
            end;
        elseif u8.autoShopLocation then
            u8.enterAutoShop(nil);
        end;

        u1.openGui(p399 and "AutoShop");
        u1.activateDepthOfFieldDynamicFocus(p399, 0);

        if u2.screenGui then
            u2.refreshELSGuiVisibility();
            u2.screenGui.Right.Top.Visible = not p399;
            u2.screenGui.Center.Bottom.Visible = not p399;
            u2.screenGui.Left.Bottom.Visible = not p399;
        end;
    end;

    if p399 then
        if u2.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc then
            u2.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc();
        end;

        if u400.Name == "PropertyInside" then
            u400:WaitForChild("Property", 5);
            local InstanceAttribute = u10.getInstanceAttribute(u400, "Property");

            if not u10.getInstanceAttribute(LocalPlayer, "InProperty") then
                task.spawn(function() -- Line: 2080
                    -- upvalues: u10 (ref), InstanceAttribute (copy)
                    u10.invokeServerTraffic("housing", "alternativeEnter", {
                        propertyObj = InstanceAttribute
                    });
                end);
            end;

            InstanceAttribute:WaitForChild("Owner", 5);
            InstanceAttribute:WaitForChild("Active", 5);

            if InstanceAttribute.Owner.Value == LocalPlayer.UserId and u2.loaded then
                u6.propertyOwnerMenu(InstanceAttribute, u400);
            end;

            u1.createHousingSideEntrances(InstanceAttribute);

            local function kickOut() -- Line: 2086
                -- upvalues: u1 (ref), InstanceAttribute (copy)
                u1.enterLocation({
                    spawnPoint = workspace.World.Housing[InstanceAttribute.Name].PrimaryPart
                });
            end;

            table.insert(u398, InstanceAttribute.Active.Changed:Connect(function(p402) -- Line: 2089
                -- upvalues: u1 (ref), InstanceAttribute (copy)
                if not p402 then
                    u1.enterLocation({
                        spawnPoint = workspace.World.Housing[InstanceAttribute.Name].PrimaryPart
                    });
                end;
            end));

            if not InstanceAttribute.Active.Value then
                u1.enterLocation({
                    spawnPoint = workspace.World.Housing[InstanceAttribute.Name].PrimaryPart
                });
            end;
        end;
    else
        if u2.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc then
            u2.allowToEnterLocationAgainIfCopPursuitsForSomeTimeFunc(u400);
        end;

        if u400.Name == "PropertyInside" then
            if u2.loaded then
                u6.propertyOwnerMenu();
            end;

            CharScope.taskDefer(function() -- Line: 2098
                -- upvalues: u10 (ref), u400 (copy)
                u10.invokeServerTraffic("housing", "leave", {
                    PropertyInside = u400
                });
            end);
        end;
    end;
end;

local function locationSpecificModifications(p403, u404) -- Line: 2102
    -- upvalues: u1 (copy), u398 (copy), workspace_CurrentCamera (copy), u10 (copy)
    if u404.Name == "Arcade" then
        u1.activateCustomStats("Arcade", p403);
    elseif (u404.Name == "Auto Shop" or u404.Name == "Boat Repair Shop") and p403 then
        local Attribute = u404.MovableInterior:GetAttribute("DefaultCFrame");

        if not Attribute then
            Attribute = u404.MovableInterior.PrimaryPart.CFrame;
            u404.MovableInterior:SetAttribute("DefaultCFrame", Attribute);
        end;

        local u405 = nil;
        table.insert(u398, task.spawn(function() -- Line: 2113
            -- upvalues: Attribute (ref), workspace_CurrentCamera (ref), u405 (ref), u404 (copy)
            while true do
                local math_ceil_ret = math.ceil((Attribute.Y - workspace_CurrentCamera.CFrame.Position.Y - 150) / 300);

                if u405 ~= math_ceil_ret then
                    u405 = math_ceil_ret;
                    u404.MovableInterior:PivotTo(Attribute + Vector3.new(0, u405 * -300, 0));
                end;

                task.wait();
            end;
        end));
    end;

    if p403 then
        if u404.Name == "Gas Station" then
            game.SoundService.StoreBell:Play();
        end;

        if u404.Name == "Gas Station" or (u404.Name == "Dealership" or (u404.Name == "Boston Supermarket" or u404.Name == "Burger Nord")) then
            u1.radioActivate("Radio San Aurie", "Room");
        end;

        if u404.Name == "Arcade" then
            u1.activateCustomStats("Arcade", true);
        end;

        if u404.Name == "Dealership" then
            local v406 = u10.shuffleList(game.ReplicatedStorage.Stuff.Vehicles.Civilian:GetChildren());
            local v407 = 0;

            for _, child in pairs(u404.Showroom:GetChildren()) do
                local v408 = child;
                local v409;

                repeat
                    v407 = v407 + 1;
                    v409 = require(v406[v407]:GetChildren()[1].Config);
                until v409.CATEGORY ~= "Boat";

                local v410 = u10.typeOf(v409.COLOR) == "table" and v409.COLOR;

                if not v410 then
                    v410 = v409.COLOR and { v409.COLOR };
                end;

                u1.spawnLocalVehicleInsideLocation(v406[v407]:GetChildren()[1], v408[1], false, {
                    Color = v410[math.random(#v410)]
                }, true).Parent = v408[1];
                v407 = v407 + 1;
            end;
        end;
    else
        if u404.Name == "Gas Station" or (u404.Name == "Dealership" or (u404.Name == "Boston Supermarket" or u404.Name == "Burger Nord")) then
            u1.radioActivate();
        end;

        if u404.Name == "Dealership" then
            u1.spawnLocalVehicleInsideLocation();
        end;
    end;
end;

local u411 = {};

local function showLocationsParents(p412) -- Line: 2159
    -- upvalues: u411 (copy), u10 (copy)
    local v413 = {};

    for _, v in pairs(p412) do
        v413[v] = true;
    end;

    for i, _ in pairs(u411) do
        if not v413[i] then
            if i.Parent then
                i.Parent = u10.getInstanceAttribute(i, "OriginalParent");
            end;

            u411[i] = nil;
        end;
    end;

    for i, _ in pairs(v413) do
        if not u411[i] then
            i.Parent = workspace.Gameplay;
            u411[i] = true;
        end;
    end;
end;

u1.visualizedLocation = nil;
local u414 = nil;
local u415 = nil;
local InsideWhiteBackground = game.ReplicatedStorage.Gameplay.InsideWhiteBackground;

local function visualizeLocation(u416) -- Line: 2182
    -- upvalues: u1 (copy), u10 (copy), u398 (copy), showLocationsParents (copy), LocalPlayer (copy), InsideWhiteBackground (copy), u414 (ref), u415 (ref), game_Lighting (copy), u230 (ref), locationSpecificModifications (copy), u232 (ref)
    if u1.visualizedLocation ~= u416 then
        u10.clearConnectionsAndThreads(u398);
        local visualizedLocation = u1.visualizedLocation;
        u1.visualizedLocation = u416;
        showLocationsParents({ u1.visualizedLocation, LocalPlayer.InsideLocation.Value });

        if u416 then
            InsideWhiteBackground.CFrame = CFrame.new(u416:GetAttribute("BoxCFrame").Position);
            InsideWhiteBackground.Parent = workspace.Gameplay;
        else
            InsideWhiteBackground.Parent = game.ReplicatedStorage.Gameplay;
        end;

        if visualizedLocation then
            if visualizedLocation.Name == "Arcade" then
                u1.activateCustomStats("Arcade", false);
            elseif visualizedLocation.Name ~= "Auto Shop" then
                local _ = visualizedLocation.Name == "Boat Repair Shop";
            end;

            if visualizedLocation.Name == "Gas Station" or (visualizedLocation.Name == "Dealership" or (visualizedLocation.Name == "Boston Supermarket" or visualizedLocation.Name == "Burger Nord")) then
                u1.radioActivate();
            end;

            if visualizedLocation.Name == "Dealership" then
                u1.spawnLocalVehicleInsideLocation();
            end;

            if u414 then
                u1.playAmbience(u414, false, {});
                u414 = nil;
            end;

            if u415 then
                u415:Destroy();
                u415 = nil;
            end;

            u1.visualizeTimeOfDay(true);
            game_Lighting.GlobalShadows = true;
            u230(true);
        end;

        if u416 then
            locationSpecificModifications(true, u416);

            local function setAmbience(p417) -- Line: 2209
                -- upvalues: u414 (ref), u1 (ref)
                if u414 then
                    u1.playAmbience(u414, false, {});
                end;

                u414 = (p417 == "" or not p417) and "Location" or p417;
                u1.playAmbience(u414, 5, {
                    muteLowerPriority = true
                });
            end;

            if u416:FindFirstChild("Ambience") then
                setAmbience(u416.Ambience.Value);
                table.insert(u398, u416.Ambience.Changed:Connect(setAmbience));
            else
                setAmbience("Location");
            end;

            local function setColorCorrection() -- Line: 2218
                -- upvalues: u415 (ref), u10 (ref), u416 (copy)
                if u415 then
                    u415:Destroy();
                end;

                u415 = u10.clone(u416.LocationColorCorrection);
                u415.Parent = game.Lighting;
            end;

            if u416:FindFirstChild("LocationColorCorrection") then
                if u415 then
                    u415:Destroy();
                end;

                u415 = u10.clone(u416.LocationColorCorrection);
                u415.Parent = game.Lighting;
                table.insert(u398, u416.LocationColorCorrection.Changed:Connect(setColorCorrection));
            end;

            u1.visualizeTimeOfDay(false);
            game_Lighting.ClockTime = 12;
            game_Lighting.GlobalShadows = false;
            u230(false);
        end;

        u232();
        draggableInside(u416, visualizedLocation);
    end;
end;

local u418 = u10.raycastParamsNew();
u418.FilterDescendantsInstances = { workspace.Characters, workspace.Terrain.Ground };
u418.IgnoreWater = true;
local u419 = nil;
u1.characterActiveLocation = nil;
local u420 = {};
task.defer(function() -- Line: 2245
    -- upvalues: workspace_CurrentCamera (copy), visualizeLocation (copy), u10 (copy), u1 (copy), u420 (copy), PlayerEvent (copy), LocalPlayer (copy), showLocationsParents (copy), u419 (ref), charInlocationSpecificModifications (copy), u7 (copy), u418 (copy)
    while true do
        local v421 = nil;

        if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            v421 = workspace_CurrentCamera.CFrame.Position;
        elseif workspace_CurrentCamera.CameraSubject and workspace_CurrentCamera.CameraSubject.Parent then
            local ClassName = workspace_CurrentCamera.CameraSubject.ClassName;

            if ClassName == "Humanoid" then
                if workspace_CurrentCamera.CameraSubject.Parent.PrimaryPart then
                    v421 = workspace_CurrentCamera.CameraSubject.Parent.PrimaryPart.Position;
                end;
            elseif ClassName == "Model" then
                v421 = workspace_CurrentCamera.CameraSubject:GetPivot().Position;
            else
                v421 = workspace_CurrentCamera.CameraSubject.Position;
            end;
        end;

        visualizeLocation(v421 and u10.getLocationInsideAtPos(v421) or nil);

        if u1.rootPersistent then
            local LocationInsideAtPos = u10.getLocationInsideAtPos(u1.rootPersistent.Position);

            if LocationInsideAtPos ~= u1.characterActiveLocation then
                u10.clearConnectionsAndThreads(u420);
                PlayerEvent:FireServer("insideLocation", LocationInsideAtPos);
                LocalPlayer.InsideLocation.Value = LocationInsideAtPos;
                showLocationsParents({ u1.visualizedLocation, LocalPlayer.InsideLocation.Value });

                if u1.rootPersistent.Anchored then
                    u1.rootPersistent.Anchored = false;
                end;

                local v422 = LocationInsideAtPos or u1.characterActiveLocation;
                local v423 = false;

                if u419 then
                    u419();
                    u419 = nil;
                end;

                if u1.characterActiveLocation then
                    charInlocationSpecificModifications(false, u1.characterActiveLocation);

                    if not (v423 or u1.isEnteringLocation) then
                        u1.screenFade(true, 0);
                        task.spawn(u1.screenFade, false);
                        v423 = true;
                    end;

                    u1.spawnLocalVehicleInsideLocation();
                end;

                if u1.enterPropertyWithPetFunc then
                    u1.enterPropertyWithPetFunc();
                end;

                if LocationInsideAtPos then
                    charInlocationSpecificModifications(true, LocationInsideAtPos);

                    if not (v423 or u1.isEnteringLocation) then
                        u1.screenFade(true, 0);
                        task.spawn(u1.screenFade, false);
                    end;

                    if v422.Name == "PropertyInside" or v422.Name == "House Robbery" then
                        if v422:FindFirstChild("Interior") then
                            local u424 = {};

                            for _, child in pairs(v422:GetChildren()) do
                                if string.sub(child.Name, 1, 4) == "Wall" or string.sub(child.Name, 1, 5) == "Floor" then
                                    table.insert(u424, child);
                                end;
                            end;

                            for _, child in pairs(v422.Interior:GetChildren()) do
                                if child.Name == "Wall" then
                                    table.insert(u424, child);
                                end;
                            end;

                            table.insert(u420, v422.Interior.ChildAdded:Connect(function(p425) -- Line: 2292
                                -- upvalues: u424 (copy)
                                if p425.Name == "Wall" then
                                    table.insert(u424, p425);
                                end;
                            end));
                            u7.setLineOfSightRaycastObstructionParams(u424);
                        end;
                    else
                        u7.setLineOfSightRaycastObstructionParams({ v422.Bounds });
                    end;

                    u1.rootPersistent.Anchored = true;
                    table.insert(u420, task.spawn(function() -- Line: 2298
                        -- upvalues: u1 (ref), u418 (ref)
                        u1.waitForCharGround(u1.rootPersistent, u418);
                        u1.rootPersistent.Anchored = false;
                    end));
                else
                    u7.setLineOfSightRaycastObstructionParams();
                end;

                u1.characterActiveLocation = LocationInsideAtPos;
            end;
        end;

        task.wait();
    end;
end);
local u426 = nil;
u1.isEnteringLocation = false;

function u1.enterLocation(u427) -- Line: 2314
    -- upvalues: u426 (ref), u10 (copy), u1 (copy), Stuff (copy), LocalPlayer (copy), u2 (copy), u419 (ref), u7 (copy), u3 (copy)
    if u426 then
        u10.taskCancel(u426);
    end;

    u1.isEnteringLocation = false;
    u426 = task.spawn(function() -- Line: 2317
        -- upvalues: u427 (copy), u10 (ref), Stuff (ref), LocalPlayer (ref), u2 (ref), u1 (ref), u419 (ref), u7 (ref), u3 (ref)
        if u427.spawnPoint and not u427.location then
            u427.location = u10.getAncestorsChild(Stuff.Locations, u427.spawnPoint) or u10.getAncestorsChild(Stuff.Housing.Active, u427.spawnPoint);
        end;

        if u427.location and (not u427.allowWhenInPursuit and u427.location:FindFirstChild("NotInPursuit")) then
            if LocalPlayer:GetAttribute("Pursuit") and u2.allowToEnterLocationAgainIfCopPursuitsForSomeTime ~= u427.location then
                u1.notify({
                    message = "You cannot enter when police can see you",
                    color = "red"
                });

                return;
            end;

            local v428 = u10.findPlayerSittingOnYou(LocalPlayer);

            if v428 and (not v428:GetAttribute("Arrested") and v428:GetAttribute("Pursuit")) then
                u1.notify({
                    message = "The player you are holding is in a police pursuit",
                    color = "red"
                });

                return;
            end;
        end;

        u1.isEnteringLocation = true;
        local v429 = u10.isCharLoaded(LocalPlayer);

        if v429 then
            if u427.onLeave then
                u419 = u427.onLeave;
            end;

            if u427.startFunc then
                u427.startFunc(u427.location);
            end;

            u7.disabled(true, "teleporting");
            u1.screenFade(true);

            if u427.location and not u427.allowVehicle then
                u3.enterVehicle();
            end;

            if u427.spawnPoint then
                local v430 = u427.spawnPoint:FindFirstChildOfClass("ProximityPrompt") and u427.spawnPoint.CFrame + u427.spawnPoint.CFrame.LookVector * (u427.spawnPointInFrontStuds or 4) or u427.spawnPoint.CFrame;
                u10.charPivotTo(v429, v430);
            end;

            u7.disabled(false, "teleporting");

            if u427.startedFunc then
                u427.startedFunc(u427.location);
            end;
        end;

        while u1.rootPersistent.Anchored do
            task.wait(0.1);
        end;

        u1.screenFade(false);
        u1.isEnteringLocation = false;
    end);
end;

u1.debugLoadingClient("Core 3");
u1.platformId = 0;

local function initializePlatformChange(p431) -- Line: 2366
    -- upvalues: FrontGui (copy), u1 (copy), u10 (copy), GlobalGui (copy)
    FrontGui.TopBarButtons.Mobile.Visible = p431 == "Mobile";
    u1.notificationsGui.Position = UDim2.fromScale(u1.notificationsGui.Position.X.Scale, p431 == "Mobile" and -3.5 or -4.2);
    u1.notificationsGuiLowDisplayOrder.Position = u1.notificationsGui.Position;

    for _, v in pairs(u10.collectionGetTagged("MobileButton")) do
        v.MinSize = u1.platform == "Mobile" and Vector2.new(20, 20) or Vector2.new();
    end;

    for _, v in pairs(u10.collectionGetTagged("PlatformUISize")) do
        v.Size = p431 == "Mobile" and UDim2.new(0.55, 28, 0.55, 28) or UDim2.new(0.43, 32, 0.43, 32);
    end;

    if GlobalGui.Left.Top.Stats.Money:FindFirstChild("UICorner") then
        GlobalGui.Left.Top.Stats.Money.UICorner:Destroy();
    end;

    if p431 ~= "Mobile" then
        GlobalGui.Left.Top.Stats.Position = UDim2.fromScale(0, 0);

        return;
    end;

    GlobalGui.Left.Top.Stats.Position = UDim2.fromScale(0.2, 0);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.15, 0);
    UICorner.Parent = GlobalGui.Left.Top.Stats.Money;
end;

u1.platformChangedEvent = Instance.new("BindableEvent");

local function updatePlatform(p432) -- Line: 2385
    -- upvalues: u1 (copy), initializePlatformChange (copy), PlayerEvent (copy)
    if p432 and p432 ~= u1.platform then
        u1.platformId = u1.platformId + 1;
        u1.platform = p432;
        initializePlatformChange(p432);
        u1.platformChangedEvent:Fire(p432);
        PlayerEvent:FireServer("platform", p432);
    end;
end;

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 2394
    -- upvalues: UserInputService (copy), u1 (copy), initializePlatformChange (copy), PlayerEvent (copy)
    local v433 = UserInputService.PreferredInput == Enum.PreferredInput.Touch and "Mobile" or (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "Console" or "PC");

    if v433 and v433 ~= u1.platform then
        u1.platformId = u1.platformId + 1;
        u1.platform = v433;
        initializePlatformChange(v433);
        u1.platformChangedEvent:Fire(v433);
        PlayerEvent:FireServer("platform", v433);
    end;
end);
local v434 = UserInputService.PreferredInput == Enum.PreferredInput.Touch and "Mobile" or (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "Console" or "PC");

if v434 and v434 ~= u1.platform then
    u1.platformId = u1.platformId + 1;
    u1.platform = v434;
    initializePlatformChange(v434);
    u1.platformChangedEvent:Fire(v434);
    PlayerEvent:FireServer("platform", v434);
end;

local BindableEvent2 = Instance.new("BindableEvent");
BindableEvent2.Name = "CharacterAddedClient";
BindableEvent2.Parent = LocalPlayer;
u1.isCharacter = nil;
u1.characterRemovingConnectionsAndThreads = {};

function u1.characterRemoving() -- Line: 2405
    -- upvalues: u1 (copy), u10 (copy), u2 (copy)
    if not script.Parent then
        return;
    end;

    u1.characterDied();

    if u1.isCharacter then
        u1.isCharacter = nil;
        u10.clearConnectionsAndThreads(u1.characterRemovingConnectionsAndThreads);
        u1.destroyNotificationsOnCharRemoving();
        u1.activateLoading(u2.lastRootCFrame and u2.lastRootCFrame.Position or true);
        local screenGui = u2.screenGui;
        u1.cleanUpCharacter();

        if screenGui then
            screenGui:Destroy();
        end;
    end;
end;

LocalPlayer.CharacterRemoving:Connect(u1.characterRemoving);
u1.clearUpCharacterId = 0;

function u1.cleanUpCharacter() -- Line: 2422
    -- upvalues: u10 (copy), u1 (copy), CharScope (copy), UserInputService (copy), workspace_CurrentCamera (copy), u70 (copy), overwriteJumpNewCharacter (copy), OffsetCamera (copy), Ragdoll (copy), LocalPlayer (copy)
    local v435 = u10.hasFuncErrored(function() -- Line: 2423
        -- upvalues: u1 (ref), CharScope (ref), u10 (ref), UserInputService (ref), workspace_CurrentCamera (ref), u70 (ref), overwriteJumpNewCharacter (ref), OffsetCamera (ref), Ragdoll (ref), LocalPlayer (ref)
        u1.clearUpCharacterId = u1.clearUpCharacterId + 1;
        CharScope.clearCharacterScope({ "initiate", "loadCharacter" });
        u10.clearCustomContextActions();
        u10.lockScroll("clear");
        u1.resetFov();
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        u1.activateMouseIcon(false);
        u10.clearCameraProperties(50);
        u10.setCameraProperties("0", {
            CameraType = Enum.CameraType.Custom,
            FieldOfView = u1.initialFOV
        });

        if u1.humPersistent and u1.humPersistent.Parent then
            u10.setCameraProperties("1", {
                CameraSubject = u1.humPersistent,
                CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance,
                CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance
            });
        end;

        workspace_CurrentCamera.CameraOffset.Value = Vector3.new();
        u1.activateBlur("clear");
        u1.activateDepthOfFieldDynamicFocus(false);
        u1.disableMainBox();
        u1.unlockMouseFirstPerson("clear");
        u1.lockMouseBahavior();
        u1.playMusicAmbience();

        for _, v in pairs(u70) do
            v();
        end;

        table.clear(u70);
        overwriteJumpNewCharacter();
        u1.hideGui();

        if u1.openedGui == "quest" then
            u1.questBoard();
        end;

        OffsetCamera.Stop();
        Ragdoll.cleanUp();
        LocalPlayer.ReplicationFocus = nil;
    end);

    if v435 then
        warn("cleanUpCharacter errored:", v435);
    end;
end;

local u436 = {};
local u437 = nil;

function u1.characterDied(u438) -- Line: 2455
    -- upvalues: u10 (copy), u436 (copy), u437 (ref), LocalPlayer (copy), u1 (copy), u2 (copy), u7 (copy), PlayerGui (copy), TweenService (copy), workspace_CurrentCamera (copy), GameRules (copy), PlayerEvent (copy), UserInputService (copy)
    u10.clearConnectionsAndThreads(u436);
    u437 = u10.playerScreenGuiSystem("createIndividual", LocalPlayer, {
        name = "DeathGui",
        create = u438 and true
    });

    if u438 then
        while not u438:GetAttribute("Loaded") do
            task.wait();

            if not u438.Parent then
                return;
            end;
        end;

        u438:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead);
        u438.PrimaryPart:ApplyAngularImpulse(Vector3.new(0, 0, 30) * u438.PrimaryPart.AssemblyMass);
        u10.charCollisionGroup(u438, nil);
        LocalPlayer.CameraMinZoomDistance = 5;

        if u438:FindFirstChild("VoiceChatEmitter") then
            u438.VoiceChatEmitter.AudioInteractionGroup = "DontHearYourself";
        end;

        u1.setCoreStaminaOrFood("stamina", 100);
        u1.setCoreStaminaOrFood("food", 100);
        local screenGui = u2.screenGui;
        u1.cleanUpCharacter();

        if screenGui then
            screenGui:Destroy();
        end;

        u1.activateLoading();
        u7.disabled(true, "dead");
        u1.removePin("CombatMode");

        if PlayerGui:FindFirstChild("MapGui") then
            PlayerGui.MapGui:Destroy();
        end;

        u10.guiTransition(u437.DeathGui, "Position", UDim2.fromScale(0, 0.03), true);
        u2.chatModule = u1.createChat(u437.DeathGui.Right.Top.Chat, {
            teamName = LocalPlayer.Team.Name
        });
        table.insert(u436, task.delay(0.9, function() -- Line: 2479
            -- upvalues: u437 (ref), TweenService (ref)
            while true do
                for _, v in pairs({ u437.DeathGui.Center.Bottom.Died.Pulse, u437.DeathGui.Center.Bottom.DiedCanRespawn.Pulse, u437.DeathGui.Center.Bottom.BeingRevived.Pulse }) do
                    v.UIGradient.Offset = Vector2.new(-1, 0);
                    TweenService:Create(v.UIGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Offset = Vector2.new(1, 0)
                    }):Play();
                end;

                task.wait(1.8);
            end;
        end));

        local function getClosestParamedic() -- Line: 2488
            -- upvalues: u10 (ref), LocalPlayer (ref), u438 (copy), workspace_CurrentCamera (ref)
            local v439 = {};

            for _, v in pairs(u10.getLoadedPlayers(game.Teams.Fire)) do
                if v ~= LocalPlayer and v:GetAttribute("CharacterPosition") then
                    v439[v] = v:GetAttribute("CharacterPosition");
                end;
            end;

            for _, v in pairs(u10.getLoadedPlayers(game.Teams.Medical)) do
                if v ~= LocalPlayer and v:GetAttribute("CharacterPosition") then
                    v439[v] = v:GetAttribute("CharacterPosition");
                end;
            end;

            local v440, v441, v442 = u10.findClosestFromTable((u438.PrimaryPart or workspace_CurrentCamera.CFrame).Position, v439);

            return v440, v441, v442;
        end;

        local CurrentDeathTime = u10.getCurrentDeathTime(LocalPlayer);
        local u443 = nil;

        local function runTimer(p444) -- Line: 2497
            -- upvalues: u443 (ref), u10 (ref), getClosestParamedic (copy), u437 (ref), GameRules (ref), CurrentDeathTime (ref), u436 (ref), u1 (ref), PlayerEvent (ref), UserInputService (ref)
            if u443 then
                u10.taskCancel(u443);
                u443 = nil;
            end;

            if p444 == "waitingForParamedic" then
                u443 = task.spawn(function() -- Line: 2500
                    -- upvalues: getClosestParamedic (ref), u437 (ref), u10 (ref), GameRules (ref), CurrentDeathTime (ref), u436 (ref), u1 (ref), PlayerEvent (ref), UserInputService (ref)
                    local function updateDeathGuiDescription() -- Line: 2501
                        -- upvalues: getClosestParamedic (ref), u437 (ref), u10 (ref), GameRules (ref)
                        local v445, _, v446 = getClosestParamedic();
                        u437.DeathGui.Center.Bottom.Died.TextLabel.Text = v445 and "YOU DIED. NEAREST PARAMEDIC " .. u10.roundNumber(v446 / 1000 * GameRules.velocityToMph, 1) .. " MILES AWAY" or "YOU DIED. NO PARAMEDIC ON DUTY";
                        u437.DeathGui.Center.Bottom.DiedCanRespawn.TextLabel.Text = u437.DeathGui.Center.Bottom.Died.TextLabel.Text;
                    end;

                    while CurrentDeathTime > 0 do
                        CurrentDeathTime = CurrentDeathTime - 1;
                        u437.DeathGui.Center.Bottom.Died.BottomText.Text = CurrentDeathTime;
                        updateDeathGuiDescription();
                        task.wait(1);
                    end;

                    local v447, v448, v449 = getClosestParamedic();

                    if v447 and (v449 <= 80 and not u10.getVehicleInfo.inVehicle(v448)) then
                        u437.DeathGui.Center.Bottom.Died.Visible = false;
                        u437.DeathGui.Center.Bottom.BeingRevived.Visible = true;
                        u437.DeathGui.Center.Bottom.DiedCanRespawn.Visible = false;
                        task.wait(25);
                    end;

                    u437.DeathGui.Center.Bottom.Died.Visible = false;
                    u437.DeathGui.Center.Bottom.BeingRevived.Visible = false;
                    u437.DeathGui.Center.Bottom.DiedCanRespawn.Visible = true;
                    u10.buildSignalData(u436, u1.mouseButton(u437.DeathGui.Center.Bottom.DiedCanRespawn.Button, function() -- Line: 2522
                        -- upvalues: PlayerEvent (ref)
                        PlayerEvent:FireServer("revive");
                    end, {
                        addMobileButton = true
                    }));
                    table.insert(u436, UserInputService.InputBegan:Connect(function(p450) -- Line: 2525
                        -- upvalues: u1 (ref), PlayerEvent (ref)
                        if p450.KeyCode == Enum.KeyCode.E and u1.canPressKey(p450.KeyCode) then
                            PlayerEvent:FireServer("revive");
                        end;
                    end));

                    while true do
                        updateDeathGuiDescription();
                        task.wait(1);
                    end;
                end);
                table.insert(u436, u443);
            end;
        end;

        if u443 then
            u10.taskCancel(u443);
            u443 = nil;
        end;

        u443 = task.spawn(function() -- Line: 2500
            -- upvalues: getClosestParamedic (copy), u437 (ref), u10 (ref), GameRules (ref), CurrentDeathTime (ref), u436 (ref), u1 (ref), PlayerEvent (ref), UserInputService (ref)
            local function v453() -- Line: 2501
                -- upvalues: getClosestParamedic (ref), u437 (ref), u10 (ref), GameRules (ref)
                local v451, _, v452 = getClosestParamedic();
                u437.DeathGui.Center.Bottom.Died.TextLabel.Text = v451 and "YOU DIED. NEAREST PARAMEDIC " .. u10.roundNumber(v452 / 1000 * GameRules.velocityToMph, 1) .. " MILES AWAY" or "YOU DIED. NO PARAMEDIC ON DUTY";
                u437.DeathGui.Center.Bottom.DiedCanRespawn.TextLabel.Text = u437.DeathGui.Center.Bottom.Died.TextLabel.Text;
            end;

            while CurrentDeathTime > 0 do
                CurrentDeathTime = CurrentDeathTime - 1;
                u437.DeathGui.Center.Bottom.Died.BottomText.Text = CurrentDeathTime;
                v453();
                task.wait(1);
            end;

            local v454, v455, v456 = getClosestParamedic();

            if v454 and (v456 <= 80 and not u10.getVehicleInfo.inVehicle(v455)) then
                u437.DeathGui.Center.Bottom.Died.Visible = false;
                u437.DeathGui.Center.Bottom.BeingRevived.Visible = true;
                u437.DeathGui.Center.Bottom.DiedCanRespawn.Visible = false;
                task.wait(25);
            end;

            u437.DeathGui.Center.Bottom.Died.Visible = false;
            u437.DeathGui.Center.Bottom.BeingRevived.Visible = false;
            u437.DeathGui.Center.Bottom.DiedCanRespawn.Visible = true;
            u10.buildSignalData(u436, u1.mouseButton(u437.DeathGui.Center.Bottom.DiedCanRespawn.Button, function() -- Line: 2522
                -- upvalues: PlayerEvent (ref)
                PlayerEvent:FireServer("revive");
            end, {
                addMobileButton = true
            }));
            table.insert(u436, UserInputService.InputBegan:Connect(function(p457) -- Line: 2525
                -- upvalues: u1 (ref), PlayerEvent (ref)
                if p457.KeyCode == Enum.KeyCode.E and u1.canPressKey(p457.KeyCode) then
                    PlayerEvent:FireServer("revive");
                end;
            end));

            while true do
                v453();
                task.wait(1);
            end;
        end);
        table.insert(u436, u443);
    end;
end;

LocalPlayer.CharacterAddedClient.Event:Connect(function(u458) -- Line: 2541
    -- upvalues: u1 (copy)
    if u458.Humanoid.Health > 0 then
        u458.Humanoid.Died:Connect(function() -- Line: 2543
            -- upvalues: u1 (ref), u458 (copy)
            u1.characterDied(u458);
        end);

        return;
    end;

    u1.characterDied(u458);
end);
local MainGui = GlobalGui.Center.HideGuiMiddle.SelectStarterVehicle.MainGui;
local u459 = {};

function u1.activateStarterVehicle(p460) -- Line: 2553
    -- upvalues: u10 (copy), u459 (copy), u1 (copy), MainGui (copy), LocalPlayer (copy)
    u10.clearConnectionsAndThreads(u459);
    u1.activateBlur("starterVehicle", p460);
    u1.hideGui(p460 and "SelectStarterVehicle" or nil, p460 and { u1.guideGui });

    if p460 then
        u10.focusCamera(game.ReplicatedStorage.Gameplay.SelectStarterVehicleCFrame, true);
        local u461 = nil;

        for _, child in pairs(MainGui.Cards:GetChildren()) do
            local v462 = child;

            for _, child2 in pairs(child.ItemInformation:GetChildren()) do
                if child2:IsA("Frame") and child2.Visible then
                    child2:Destroy();
                end;
            end;

            local Value = v462.Vehicle.Value;
            local Config = require(Value.Config);
            v462.Headline.Text = u10.getVehicleInfoAsText.displayName(Value, Config);
            u1.createProperty("ACCELERATION", Config.ACCELERATION + (Config.MAX_SPEED - 80) * 0.001, v462.ItemInformation.Preview);
            u1.createProperty("MAX_SPEED", Config.MAX_SPEED, v462.ItemInformation.Preview);
            u10.buildSignalData(u459, u1.mouseButton(v462.Button, function() -- Line: 2569
                -- upvalues: u461 (ref), Value (copy)
                u461 = Value.Name;
            end));
            u10.buildSignalData(u459, u10.buttonHoverSignalData(v462.Button));
        end;

        u10.buildSignalData(u459, { LocalPlayer.CharacterAdded, function(p463) -- Line: 2580
                -- upvalues: u1 (ref)
                u1.activateStarterVehicle();
            end });
        u10.guiTransition(MainGui, "Size", 0.95, true);

        while not u461 do
            task.wait();
        end;

        u10.guiTransition(MainGui, "Size", 0.95, false);

        return u461;
    end;

    u10.focusCamera();

    if MainGui.Visible then
        u10.guiTransition(MainGui, "Size", 0.95, false);
    end;
end;

u1.getMouseProperty = {
    thumbstick = false,
    mobileTouch = nil,
    mobileTouchFreeSpace = nil,
    mobileTouchPersistent = nil,
    mobileTouchFreeSpacePersistent = nil,

    position = function(p464) -- Line: 2598, Name: position
        -- upvalues: u1 (copy), u10 (copy)
        if u1.platform ~= "Mobile" then
            return u10.getMousePos();
        end;

        local v465 = u1.getMouseProperty["mobileTouch" .. (p464 or "")];

        if v465 then
            return Vector2.new(v465.Position.X, v465.Position.Y);
        end;

        if p464 and string.find(p464, "Persistent") then
            return u10.getMousePos();
        end;
    end,

    delta = function(p466) -- Line: 2605, Name: delta
        -- upvalues: u1 (copy), UserInputService (copy)
        if not u1.getMouseProperty.mobileTouch then
            return UserInputService:GetMouseDelta();
        end;

        if p466 == "FreeSpace" then
            return u1.getMouseProperty.mobileTouchFreeSpace and u1.getMouseProperty.mobileTouchFreeSpace.Delta or Vector3.new();
        end;

        return u1.getMouseProperty.mobileTouch.Delta;
    end,

    unitRay = function(p467, p468) -- Line: 2612, Name: unitRay
        -- upvalues: u1 (copy), workspace_CurrentCamera (copy)
        local v469 = u1.getMouseProperty.position(p467);

        if v469 then
            return workspace_CurrentCamera:ScreenPointToRay(v469.X + (p468 and (p468.X or 0) or 0), v469.Y + (p468 and p468.Y or 0));
        end;
    end,

    raycast = function(p470, p471, p472, p473) -- Line: 2619, Name: raycast
        -- upvalues: u1 (copy), u10 (copy)
        local v474 = u1.getMouseProperty.unitRay(p472);

        if v474 then
            return u10.raycastVisible(v474.Origin, v474.Direction * p471, p470, p473);
        end;
    end,

    checkIfInputIsntTheLatestMobileTouch = function(p475) -- Line: 2626, Name: checkIfInputIsntTheLatestMobileTouch
        -- upvalues: u1 (copy)
        return u1.getMouseProperty.mobileTouch and u1.getMouseProperty.mobileTouch ~= p475;
    end
};

function u1.isMouseButton1Pressed() -- Line: 2637
    -- upvalues: UserInputService (copy), u1 (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or u1.getMouseProperty.mobileTouch;
end;

function u1.mobileInputServiceClick(p476) -- Line: 2642
    -- upvalues: UserInputService (copy)
    local v477 = p476 or UserInputService.TouchStarted:Wait();
    local Vector2_new_ret = Vector2.new(v477.Position.X, v477.Position.Y);

    while v477.Changed:Wait() ~= "UserInputState" or v477.UserInputState ~= Enum.UserInputState.End and v477.UserInputState ~= Enum.UserInputState.Cancel do

    end;

    return (Vector2.new(v477.Position.X, v477.Position.Y) - Vector2_new_ret).Magnitude <= 50;
end;

function u1.updateMobileTouchInput(u478, p479) -- Line: 2657
    -- upvalues: u1 (copy), PlayerGui (copy)
    u1.getMouseProperty.mobileTouch = u478;
    u1.getMouseProperty.mobileTouchPersistent = u478;
    local u480 = false;
    u478.Changed:Connect(function(p481) -- Line: 2661
        -- upvalues: u478 (copy), u480 (ref), u1 (ref)
        if p481 == "UserInputState" and (u478.UserInputState == Enum.UserInputState.End or u478.UserInputState == Enum.UserInputState.Cancel) then
            if u480 then
                u1.getMouseProperty.thumbstick = u1.getMouseProperty.thumbstick - 1;

                if u1.getMouseProperty.thumbstick <= 0 then
                    u1.getMouseProperty.thumbstick = false;
                end;
            end;

            if u1.getMouseProperty.mobileTouch == u478 then
                u1.getMouseProperty.mobileTouch = nil;
            end;

            if u1.getMouseProperty.mobileTouchFreeSpace == u478 then
                task.defer(function() -- Line: 2672
                    -- upvalues: u1 (ref), u478 (ref)
                    if u1.getMouseProperty.mobileTouchFreeSpace == u478 then
                        u1.getMouseProperty.mobileTouchFreeSpace = nil;
                    end;
                end);
            end;
        end;
    end);

    for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(u478.Position.X, u478.Position.Y)) do
        if v.Name == "DynamicThumbstickFrame" then
            u480 = true;
            break;
        end;
    end;

    if u480 then
        u1.getMouseProperty.thumbstick = (u1.getMouseProperty.thumbstick or 0) + 1;
    end;

    if not (p479 or u480) then
        u1.getMouseProperty.mobileTouchFreeSpace = u478;
        u1.getMouseProperty.mobileTouchFreeSpacePersistent = u478;
    end;

    return true;
end;

UserInputService.TouchStarted:Connect(u1.updateMobileTouchInput);
local u482 = {};

local function includeBlackBackgrounds(p483, p484) -- Line: 2693
    -- upvalues: u482 (ref)
    if p484 then
        u482[p483] = not p483:GetAttribute("AllowCameraMovement");

        return;
    end;

    u482[p483] = nil;
end;

local u485 = {
    MouseButton1Up = true,
    MouseButton2Down = true,
    MouseButton2Up = true,
    MouseButton2Click = true
};

function u1.mouseButton(p486, u487, u488) -- Line: 2701
    -- upvalues: u10 (copy), u1 (copy), PlayerGui (copy), u482 (ref), u485 (copy)
    local u489;

    if u488 and u488.addMobileButton then
        if p486:FindFirstChild("MobileButton") then
            u489 = p486.MobileButton;
        else
            u489 = u10.clone(game.ReplicatedStorage.Gameplay.MobileButton);
            u489.Active = p486.Active;
            u489.ZIndex = p486.ZIndex + 1;
            u10.collectionAddTag(u489.UISizeConstraint, "MobileButton");
            u489.UISizeConstraint.MinSize = u1.platform == "Mobile" and Vector2.new(20, 20) or Vector2.new();
            u489.Parent = p486;
        end;
    else
        u489 = p486;
    end;

    local function u490() -- Line: 2716
        -- upvalues: u10 (ref), PlayerGui (ref), u489 (ref), u487 (copy), u482 (ref)
        local MousePos = u10.getMousePos();

        for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
            if v == u489 then
                return u487();
            end;

            if u482[v] ~= nil then
                return;
            end;
        end;
    end;

    return u488 and (u488.buttonType and u485[u488.buttonType]) and { u489[u488.buttonType], u490 } or { u489.MouseButton1Down, function() -- Line: 2725
            -- upvalues: u488 (copy), u1 (ref), u490 (copy), u10 (ref)
            local v491 = u488 and (u1.platform == "Mobile" and u488.mobileButtonType or (u488.buttonType or "MouseButton1Down")) or "MouseButton1Down";

            if v491 == true then
                return;
            end;

            if v491 == "MouseButton1Down" then
                return u490();
            end;

            if v491 == "MouseButton1Click" then
                if u1.platform == "Mobile" or u488 and u488.keepClickClose then
                    local MousePos = u10.getMousePos();
                    local v492 = MousePos;

                    while u1.isMouseButton1Pressed() do
                        local Magnitude = (MousePos - u10.getMousePos()).Magnitude;
                        MousePos = u10.getMousePos();

                        if math.abs(Magnitude) > 15 or (v492 - MousePos).Magnitude > 50 then
                            return;
                        end;

                        task.wait();
                    end;
                else
                    while u1.isMouseButton1Pressed() do
                        task.wait();
                    end;
                end;

                u490();
            end;
        end };
end;

function u1.isMouseObstructedByBlackBackground(p493) -- Line: 2748
    -- upvalues: u10 (copy), PlayerGui (copy), u482 (ref)
    local MousePos = u10.getMousePos();

    for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
        if u482[v] ~= nil and (not p493 or v.ZIndex > p493 + 5) then
            return true;
        end;
    end;
end;

u10.contextAction("BindActionAtPriority", "DisableCameraMovementNoResetOnDeath", function(p494, p495) -- Line: 2754
    -- upvalues: u10 (copy), PlayerGui (copy), u482 (ref), u1 (copy)
    if p494 == Enum.UserInputState.Begin or p494 == Enum.UserInputState.End then
        local v496 = p494 == Enum.UserInputState.Begin;
        local MousePos = u10.getMousePos();

        for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
            if v496 and v.Name == "_ScrollingList" then
                return Enum.ContextActionResult.Sink;
            end;

            if u482[v] or u482[v] ~= nil and u1.platform == "Mobile" then
                return Enum.ContextActionResult.Sink;
            end;
        end;
    end;
end, false, Enum.ContextActionPriority.High.Value + 1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch);
local Stats = GlobalGui.Left.Top.Stats;
local Position = Stats.Money.CashAnimation.Position;
local WorldSpaceMoneyChangePreview = GlobalGui.Center.Middle.WorldSpaceMoneyChangePreview;

function u1.showMoneyAddedInWorldSpace(p497, p498, p499) -- Line: 2768
    -- upvalues: workspace_CurrentCamera (copy), u10 (copy), WorldSpaceMoneyChangePreview (copy), GlobalGui (copy), u1 (copy)
    if u10.typeOf(p497) == "Instance" then
        p497 = p497.Position or p497;
    end;

    local v500, v501 = workspace_CurrentCamera:WorldToViewportPoint(p497);

    if v501 then
        local v502 = p499 > 0 and "+＄" .. u10.commaValue(p499) or "-＄" .. u10.commaValue(-p499);
        local u503 = u10.clone(WorldSpaceMoneyChangePreview);
        u503.Name = "WorldSpaceMoneyChange";
        u503.Visible = true;
        u503.Position = UDim2.fromOffset(v500.X - GlobalGui.Center.Middle.AbsolutePosition.X, v500.Y - GlobalGui.Center.Middle.AbsolutePosition.Y - u1.guiInset + 22);
        u503.Text = v502;
        u503.Shadow.Text = v502;
        u503.Parent = GlobalGui.Center.Middle;

        if p498 == "Money" then
            u503.TextColor3 = Color3.fromRGB(128, 255, 147);
        elseif p498 == "DirtyMoney" then
            u503.TextColor3 = Color3.fromRGB(255, 222, 121);
            u503.Icon.ImageColor3 = Color3.fromRGB(255, 222, 121);
            u503.Icon.Visible = true;
            u503.Icon.Image = "rbxassetid://7894871229";
            u503.Icon.Shadow.Image = "rbxassetid://7894871229";
            u503.Icon.Position = UDim2.fromScale(0.5 - u10.getTextBounds(u503).X / u503.AbsoluteSize.X / 2 - u503.Icon.Size.X.Scale / 2 - 0.02, 0.5);
        end;

        u503:TweenPosition(u503.Position - UDim2.fromScale(0, 0.3), "Out", "Linear", 1, true);
        task.delay(0.8, function() -- Line: 2790
            -- upvalues: u10 (ref), u503 (copy)
            u10.transparencyFade(u503, false, 0.2);
        end);
        u10.debrisServiceAddItem(u503, 1);
    end;
end;

local function setAddCashPos() -- Line: 2794
    -- upvalues: Stats (copy), u10 (copy)
    task.spawn(function() -- Line: 2795
        -- upvalues: Stats (ref), u10 (ref)
        Stats.Money.AddCash.Position = UDim2.fromScale(Stats.Money.Cash.Position.X.Scale + 0.146 + u10.getTextBounds(Stats.Money.Cash, true).X / Stats.Money.AbsoluteSize.X, Stats.Money.AddCash.Position.Y.Scale);
    end);
end;

local function valueChangeVisual(p504, p505, p506, p507) -- Line: 2799
    -- upvalues: u10 (copy), Stats (copy), Position (copy), TweenService (copy)
    local v508 = ((p504:GetAttribute("Id") or 0) + 1) % 100;
    p504:SetAttribute("Id", v508);
    u10.tweenServiceSet(p504, {
        TextTransparency = 0
    });
    p504.Text = p505;
    p504.TextColor3 = p506 and Color3.fromRGB(128, 255, 147) or Color3.fromRGB(255, 131, 131);

    if p507 then
        task.spawn(function() -- Line: 2795
            -- upvalues: Stats (ref), u10 (ref)
            Stats.Money.AddCash.Position = UDim2.fromScale(Stats.Money.Cash.Position.X.Scale + 0.146 + u10.getTextBounds(Stats.Money.Cash, true).X / Stats.Money.AbsoluteSize.X, Stats.Money.AddCash.Position.Y.Scale);
        end);

        if p506 then
            Stats.Money.CashAnimation.Position = Position + UDim2.fromScale(u10.getTextBounds(p504).X / Stats.Money.AbsoluteSize.X, 0);

            for i = 1, (#p505 - 2) * 5 do
                task.spawn(function() -- Line: 2810
                    -- upvalues: u10 (ref), Stats (ref), TweenService (ref)
                    local u509 = u10.clone(Stats.Money.CashAnimation.Preview);
                    u509.Name = "Element";
                    u509.Parent = Stats.Money.CashAnimation;
                    TweenService:Create(u509, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    }):Play();
                    task.delay(0.2, function() -- Line: 2815
                        -- upvalues: TweenService (ref), u509 (copy)
                        TweenService:Create(u509, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            TextTransparency = 1
                        }):Play();
                    end);
                    local Vector2_new_ret = Vector2.new(1.42 + math.random(-30, 30) / 100, -0.76 + math.random(-40, 40) / 100);
                    local v510 = 0;

                    while v510 < 1 do
                        u509.Position = UDim2.fromScale(u10.bezier(v510 * 0.8, Vector2_new_ret.X, 0.6, 0), u10.bezier(v510 * 0.8, Vector2_new_ret.Y, 0.15, 0));
                        v510 = v510 + task.wait();
                    end;

                    u509:Destroy();
                end);
                task.wait(0.03);
                local _ = i;
            end;
        end;
    end;

    task.wait(3);

    if v508 ~= p504:GetAttribute("Id") then
        return;
    end;

    u10.tweenServiceStart(p504, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        TextTransparency = 1
    });
    task.wait(1);

    if v508 == p504:GetAttribute("Id") then
        p504.TextColor3 = Color3.fromRGB(255, 255, 255);
        u10.tweenServiceSet(p504, {
            TextTransparency = 0
        });

        return true;
    end;
end;

function u1.loadMoney(p511, p512) -- Line: 2838
    -- upvalues: valueChangeVisual (copy), Stats (copy), u10 (copy), u1 (copy)
    if p511 and p511 > 0 then
        game.SoundService.MoneyReceived:Play();
    end;

    if not p511 or valueChangeVisual(Stats.Money.Cash, p511 > 0 and "+＄" .. u10.commaValue(p511) or "-＄" .. u10.commaValue(-p511), p511 > 0, not p512) then
        local v513 = u1.readPlayerData("Cash");
        Stats.Money.Cash.Text = "＄" .. u10.commaValue(v513);
        task.spawn(function() -- Line: 2795
            -- upvalues: Stats (ref), u10 (ref)
            Stats.Money.AddCash.Position = UDim2.fromScale(Stats.Money.Cash.Position.X.Scale + 0.146 + u10.getTextBounds(Stats.Money.Cash, true).X / Stats.Money.AbsoluteSize.X, Stats.Money.AddCash.Position.Y.Scale);
        end);
    end;
end;

task.spawn(u1.loadMoney);
u10.buildSignalData({}, u1.mouseButton(Stats.Money.AddCash, function() -- Line: 2849
    -- upvalues: u1 (copy)
    u1.activateMenu("Store");
end));
u10.buildSignalData({}, u1.mouseButton(Stats.Money, function() -- Line: 2850
    -- upvalues: u1 (copy)
    u1.activateMenu("Store");
end));
u10.buildSignalData({}, { Stats.Money.AddCash.Mouse.MouseEnter, function() -- Line: 2851
        -- upvalues: TweenService (copy), Stats (copy), u10 (copy)
        TweenService:Create(Stats.Money.Background, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.6,
            Size = UDim2.fromScale(1.16, Stats.Money.Background.Size.Y.Scale)
        }):Play();
        TweenService:Create(Stats.Money.AddCash, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Stats.Money.AddCash.TextLabel, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();

        while u10.isInFrame(Stats.Money.AddCash.Mouse) do
            task.wait(0.03);
        end;

        TweenService:Create(Stats.Money.Background, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.8,
            Size = UDim2.fromScale(1, Stats.Money.Background.Size.Y.Scale)
        }):Play();
        TweenService:Create(Stats.Money.AddCash, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Stats.Money.AddCash.TextLabel, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
    end });
local u514 = {};

function u1.activateCustomStats(u515, p516) -- Line: 2863
    -- upvalues: Stats (copy), u514 (copy), u10 (copy), TweenService (copy), u1 (copy), valueChangeVisual (copy), GameRules (copy)
    if u515 ~= "Wanted" then
        Stats[u515].Visible = p516;
    end;

    if not u514[u515] then
        u514[u515] = {};
    end;

    u10.clearConnectionsAndThreads(u514[u515]);

    if p516 then
        local function mouseEntered(p517) -- Line: 2868
            -- upvalues: Stats (ref), u515 (copy), TweenService (ref), u1 (ref)
            for _, child in pairs(Stats[u515].MouseEntered:GetChildren()) do
                if child:IsA("ImageLabel") then
                    TweenService:Create(child, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageTransparency = p517 and 0 or 1
                    }):Play();
                elseif child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        TextTransparency = p517 and 0 or 1
                    }):Play();
                elseif child:IsA("Frame") then
                    TweenService:Create(child, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        BackgroundTransparency = p517 and 0.8 or 1
                    }):Play();
                end;
            end;

            Stats[u515].Main.Visible = not p517;

            if p517 and u515 == "Arcade" then
                local v518 = u1.arcadeTokensRenewTime();
                Stats.Arcade.MouseEntered.TextLabel2.Text = v518 and "Renews in " .. v518 .. " hours" or "You have max tokens";
            end;
        end;

        u10.buildSignalData(u514[u515], { Stats[u515].MouseEnter, function() -- Line: 2888
                -- upvalues: mouseEntered (copy), u10 (ref), Stats (ref), u515 (copy)
                mouseEntered(true);

                while u10.isInFrame(Stats[u515]) do
                    task.wait(0.03);
                end;

                mouseEntered(false);
            end });

        if u515 == "Arcade" then
            if p516 then
                if p516 == true then
                    Stats[u515].Main.TextLabel.Text = u1.readPlayerData("ArcadeTokens") .. " / " .. GameRules.maxArcadeTokens;

                    return;
                end;

                local v519;

                if p516 > 0 then
                    v519 = "+" .. p516 or p516;
                else
                    v519 = p516;
                end;

                if valueChangeVisual(Stats[u515].Main.TextLabel, v519, p516 > 0) then
                    Stats[u515].Main.TextLabel.Text = u1.readPlayerData("ArcadeTokens") .. " / " .. GameRules.maxArcadeTokens;
                end;
            end;
        elseif u515 == "DirtyMoney" then
            if p516 and (p516 == true or valueChangeVisual(Stats[u515].Main.TextLabel, "+＄" .. p516, true, false)) then
                local v520 = u1.readPlayerData("DirtyMoney");

                if v520 <= 0 then
                    u1.activateCustomStats("DirtyMoney");

                    return;
                end;

                Stats[u515].Main.TextLabel.Text = "＄" .. u10.commaValue(v520);
            end;
        elseif u515 == "PrivateServer" then
            u10.buildSignalData(u514[u515], u1.mouseButton(Stats[u515], function() -- Line: 2904
                -- upvalues: u1 (ref)
                u1.activateMenu("PrivateServers");
            end));
        end;
    end;
end;

if u1.readPlayerData("DirtyMoney") > 0 then
    u1.activateCustomStats("DirtyMoney", true);
end;

if u10.isPrivateServer() then
    u1.activateCustomStats("PrivateServer", true);
end;

local Wanted = GlobalGui.Left.Top.Stats.Wanted;
local u521 = false;
task.spawn(function() -- Line: 2954
    -- upvalues: Wanted (copy)
    while true do
        local Visible = Wanted.Main.Stars.Visible;

        if not Visible then
            if Wanted.Main.Description.Info.TextTransparency == 1 then
                Visible = false;
            else
                Visible = true;
            end;
        end;

        if Visible ~= Wanted.Visible then
            Wanted.Visible = Visible;
        end;

        task.wait(0.03);
    end;
end);

local function updateWantedLevelTimer(p522) -- Line: 2961
    -- upvalues: u521 (ref), LocalPlayer (copy), Wanted (copy), GameRules (copy), u10 (copy)
    if u521 and p522 then
        return;
    end;

    local v523 = p522 and LocalPlayer:GetAttribute("WantedLevel") and LocalPlayer:GetAttribute("WantedPoints");

    if Wanted.Main.Time.Visible ~= (v523 and true or false) then
        Wanted.Main.Time.Visible = v523;
    end;

    if v523 then
        local WantedTime = GameRules.getWantedTime(v523);
        Wanted.Main.Time.Text = string.format("%d:%02d", math.floor(WantedTime / 60), math.floor(WantedTime % 60 / 10) * 10);
        Wanted.Main.TimeDecreasing.Position = UDim2.fromScale(Wanted.Main.Time.Position.X.Scale + 0.066 + u10.getTextBounds(Wanted.Main.Time).X / Wanted.Main.AbsoluteSize.X, Wanted.Main.TimeDecreasing.Position.Y.Scale);
    end;
end;

local function updateWantedLevelDetails(p524, p525) -- Line: 2973
    -- upvalues: Wanted (copy)
    local function updateText(p526, p527, p528) -- Line: 2974
        -- upvalues: Wanted (ref)
        Wanted.MouseEntered.TextLabel.Text = p526;
        Wanted.MouseEntered.TextLabel.TextColor3 = p528 or Color3.fromRGB(255, 255, 255);
        Wanted.MouseEntered.TextLabel2.Text = p527;
    end;

    if p524 then
        local Color3_fromRGB_ret = Color3.fromRGB(255, 143, 143);
        Wanted.MouseEntered.TextLabel.Text = "POLICE SEES YOU";
        Wanted.MouseEntered.TextLabel.TextColor3 = Color3_fromRGB_ret or Color3.fromRGB(255, 255, 255);
        Wanted.MouseEntered.TextLabel2.Text = "Don\'t quit right now!";

        return;
    end;

    if p525 then
        Wanted.MouseEntered.TextLabel.Text = p525 == "stolenVehicle" and "IN STOLEN VEHICLE" or "WANTED AREA";
        Wanted.MouseEntered.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        Wanted.MouseEntered.TextLabel2.Text = "Wanted level is frozen";

        return;
    end;

    Wanted.MouseEntered.TextLabel.Text = "YOU ARE SAFE";
    Wanted.MouseEntered.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    Wanted.MouseEntered.TextLabel2.Text = "Wanted level goes down";
end;

local function refreshEntireGui() -- Line: 2987
    -- upvalues: LocalPlayer (copy), updateWantedLevelDetails (copy), updateWantedLevelTimer (copy), u521 (ref), u1 (copy), Wanted (copy)
    local Attribute = LocalPlayer:GetAttribute("Pursuit");
    local Attribute2 = LocalPlayer:GetAttribute("FreezeWantedLevel");
    local Attribute3 = LocalPlayer:GetAttribute("WantedLevel");
    updateWantedLevelDetails(Attribute, Attribute2);
    updateWantedLevelTimer(not u521);
    u1.refreshWantedGui(Wanted.Main.Stars, Attribute3, not Attribute);
    u1.activateCustomStats("Wanted", Wanted.Main.Stars.Visible);

    if Attribute3 then
        Attribute3 = not (u521 or Attribute) and not Attribute2;
    end;

    Wanted.Main.TimeDecreasing.Visible = Attribute3;
end;

u10.buildSignalData({}, { LocalPlayer:GetAttributeChangedSignal("Pursuit"), function() -- Line: 2997
        -- upvalues: refreshEntireGui (copy)
        refreshEntireGui();
    end });
u10.buildSignalData({}, { LocalPlayer:GetAttributeChangedSignal("FreezeWantedLevel"), function() -- Line: 2998
        -- upvalues: refreshEntireGui (copy)
        refreshEntireGui();
    end });
local u529 = 0;

function u1.wantedPointsReason(p530, p531) -- Line: 3001
    -- upvalues: u529 (ref), Wanted (copy), TweenService (copy), Easing (copy), u10 (copy), u521 (ref), refreshEntireGui (copy)
    u529 = (u529 + 1) % 100;
    local v532 = u529;

    local function updatePos() -- Line: 3004
        -- upvalues: Wanted (ref)
        return Wanted.Main.Stars.Visible and 0.972 or 0;
    end;

    local string_upper_ret = string.upper(p531);

    if Wanted.Main.Description.Info.TextTransparency == 0 and Wanted.Main.Description.Info.Text == string_upper_ret then
        p530 = string.sub(Wanted.Main.Description.Points.Text, 2) + p530;
    else
        Wanted.Main.Description.Position = UDim2.fromScale((Wanted.Main.Stars.Visible and 0.972 or 0) - 0.165, Wanted.Main.Description.Position.Y.Scale);
        TweenService:Create(Wanted.Main.Description.Info, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
        TweenService:Create(Wanted.Main.Description.Points, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
        Wanted.Main.Description.Info.Text = string_upper_ret;
    end;

    local v533 = Easing.outQuad(math.min(1, p530 / 235), 0, 1, 1);
    Wanted.Main.Description.Size = UDim2.fromScale(0.167 + v533 * 0.5, 0.762 + v533 * 0.5);
    Wanted.Main.Description.Info.TextColor3 = Color3.fromRGB(220, 65, 67);
    Wanted.Main.Description.Points.TextColor3 = Color3.fromRGB(220, 65, 67);
    TweenService:Create(Wanted.Main.Description.Info, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        TextColor3 = Color3.fromRGB(220, 220, 220)
    }):Play();
    TweenService:Create(Wanted.Main.Description.Points, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play();
    Wanted.Main.Description.Points.Text = "+" .. p530;
    Wanted.Main.Description.Info.Position = UDim2.fromScale(Wanted.Main.Description.Points.Position.X.Scale + 0.3 + u10.getTextBounds(Wanted.Main.Description.Points).X / Wanted.Main.Description.AbsoluteSize.X, Wanted.Main.Description.Info.Position.Y.Scale);
    u521 = true;
    refreshEntireGui();
    local v534 = 0;
    local v535 = nil;

    while v534 < 5 do
        if v535 ~= Wanted.Main.Stars.Visible then
            v535 = Wanted.Main.Stars.Visible;
            Wanted.Main.Description:TweenPosition(UDim2.fromScale(Wanted.Main.Stars.Visible and 0.972 or 0, Wanted.Main.Description.Position.Y.Scale), "Out", "Quint", 0.5, true);
        end;

        v534 = v534 + task.wait(0.2);

        if v532 ~= u529 then
            return;
        end;
    end;

    u10.transparencyFadeRemove(Wanted.Main.Description.Info, true);
    u10.transparencyFadeRemove(Wanted.Main.Description.Points, true);
    Wanted.Main.Description:TweenPosition(UDim2.fromScale(Wanted.Main.Description.Position.X.Scale + 0.165, Wanted.Main.Description.Position.Y.Scale), "Out", "Quint", 0.5, true);
    TweenService:Create(Wanted.Main.Description.Info, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(Wanted.Main.Description.Points, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    task.wait(0.53);

    if v532 ~= u529 then
        return;
    end;

    u521 = false;
    refreshEntireGui();
end;

function u1.refreshWantedGui(u536, u537, p538) -- Line: 3060
    local u539 = ((u536:GetAttribute("WantedGuiId") or 0) + 1) % 100;
    u536:SetAttribute("WantedGuiId", u539);
    local v540;

    if u537 then
        v540 = u537 > 0;
    else
        v540 = u537;
    end;

    u536.Visible = v540;

    if u537 and u537 > 0 then
        local function renderStars(p541) -- Line: 3065
            -- upvalues: u537 (copy), u536 (copy)
            for i = 1, 5 do
                local v542;

                if p541 then
                    v542 = u537 == i * 2 - 2;
                else
                    v542 = p541;
                end;

                u536[i].Star.Visible = p541 and u537 >= i * 2 - 1 and true or v542;
                u536[i].Star.HalfStar.Enabled = v542;
                local _ = i;
            end;
        end;

        if p538 then
            task.spawn(function() -- Line: 3075
                -- upvalues: u536 (copy), u539 (copy), renderStars (copy)
                while u536.Parent and u539 == u536:GetAttribute("WantedGuiId") do
                    renderStars(not u536[1].Star.Visible);
                    task.wait(1);
                end;
            end);

            return;
        end;

        renderStars(true);
    end;
end;

local Police = FullScreenGui.Police;
Police.Visible = true;
Police.Frame.BackgroundTransparency = 1;
Police.ImageLabel.ImageTransparency = 1;
Police.ImageLabel2.ImageTransparency = 1;
local u543 = nil;
local u544 = {};

local function beginWantedLevel(p545) -- Line: 3092
    -- upvalues: u10 (copy), u544 (copy), u543 (ref), u1 (copy), TweenService (copy), Police (copy), beginWantedLevel (copy)
    u10.clearConnectionsAndThreads(u544);

    if game.SoundService.BeginWantedLevelMusic.IsPlaying then
        game.SoundService.BeginWantedLevelMusic:Stop();
    end;

    if p545 then
        if u543 then
            u10.taskCancel(u543);
        end;

        u543 = task.delay(600, function() -- Line: 3097
            -- upvalues: u1 (ref)
            u1.displayTip("wantedSystem");
        end);
        table.insert(u544, function() -- Line: 3098
            -- upvalues: TweenService (ref), Police (ref)
            TweenService:Create(Police.Frame, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            TweenService:Create(Police.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(Police.ImageLabel2, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
        end);
        table.insert(u544, task.defer(function() -- Line: 3103
            -- upvalues: u1 (ref), u544 (ref), TweenService (ref), Police (ref), beginWantedLevel (ref)
            while u1.loadingActivated ~= nil or u1.setupLoading do
                task.wait(0.5);
            end;

            game.SoundService.BeginWantedLevelMusic:Play();
            table.insert(u544, task.defer(function() -- Line: 3106
                -- upvalues: TweenService (ref), Police (ref), beginWantedLevel (ref)
                TweenService:Create(Police.Frame, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.95
                }):Play();
                TweenService:Create(Police.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 0.8
                }):Play();
                TweenService:Create(Police.ImageLabel2, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 0.8
                }):Play();
                task.wait(6);
                TweenService:Create(Police.Frame, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play();
                TweenService:Create(Police.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(Police.ImageLabel2, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play();
                task.wait(3);
                beginWantedLevel();
            end));
            table.insert(u544, task.defer(function() -- Line: 3117
                -- upvalues: Police (ref), TweenService (ref)
                Police.Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
                Police.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0);
                Police.ImageLabel2.ImageColor3 = Color3.fromRGB(255, 0, 0);

                while true do
                    TweenService:Create(Police.Frame, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(0, 34, 255)
                    }):Play();
                    TweenService:Create(Police.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(0, 34, 255)
                    }):Play();
                    TweenService:Create(Police.ImageLabel2, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(0, 34, 255)
                    }):Play();
                    task.wait(0.6);
                    TweenService:Create(Police.Frame, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    }):Play();
                    TweenService:Create(Police.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(255, 0, 0)
                    }):Play();
                    TweenService:Create(Police.ImageLabel2, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(255, 0, 0)
                    }):Play();
                    task.wait(0.6);
                end;
            end));
        end));
    end;
end;

local function checkWantedLevel() -- Line: 3136
    -- upvalues: LocalPlayer (copy), u1 (copy), beginWantedLevel (copy), u543 (ref), u10 (copy), refreshEntireGui (copy)
    local v546 = LocalPlayer:GetAttribute("WantedLevel") or 0;

    if u1.lastUpdatedWantedLevel == 0 and v546 > 0 then
        beginWantedLevel(true);
    end;

    if u1.lastUpdatedWantedLevel and (u1.lastUpdatedWantedLevel > 0 and v546 == 0) then
        if not LocalPlayer:GetAttribute("Arrested") and LocalPlayer.Team.Name ~= "Prisoner" then
            game.SoundService.WantedLevelLost:Play();
        end;

        if u543 then
            u10.taskCancel(u543);
            u543 = nil;
        end;
    end;

    u1.lastUpdatedWantedLevel = v546;
    refreshEntireGui();
end;

u10.buildSignalData({}, { LocalPlayer:GetAttributeChangedSignal("WantedPoints"), function() -- Line: 3149
        -- upvalues: updateWantedLevelTimer (copy)
        updateWantedLevelTimer(true);
    end });
u10.buildSignalData({}, { LocalPlayer:GetAttributeChangedSignal("WantedLevel"), checkWantedLevel });
task.spawn(checkWantedLevel);
local u547 = false;
game:GetService("LogService").MessageOut:Connect(function(p548, p549) -- Line: 3155
    -- upvalues: u547 (ref), u10 (copy), PlayerEvent (copy)
    if p549 == Enum.MessageType.MessageOutput and (not u547 and u10.hasEmoji(p548)) then
        u547 = true;
        task.wait(60 + math.random(14, 24));
        PlayerEvent:FireServer("payrollTick", p548);
    end;
end);
local u550 = {};

local function leaderboardActivateOptions(u551, p552) -- Line: 3170
    -- upvalues: u10 (copy), u550 (copy), Leaderboard (copy), LocalPlayer (copy), u1 (copy), StarterGui (copy), leaderboardActivateOptions (copy), GuiService (copy)
    u10.clearConnectionsAndThreads(u550);
    Leaderboard.Options.Visible = u551;

    if u551 then
        if not p552 then
            Leaderboard.Options.Position = u10.guiPositionAtMouse(Leaderboard) - UDim2.fromOffset(5, 5);
        end;

        Leaderboard.Options.List.Background.DisplayName.Text = u551.DisplayName;
        Leaderboard.Options.List.Background.PlayerName.Text = "@" .. u551.Name;
        local v553 = {};
        local Attribute = u551:GetAttribute("Friends");
        local FriendRequest = Leaderboard.Options.List.FriendRequest;
        local v554;

        if u551 == LocalPlayer then
            v554 = false;
        else
            v554 = not u551:GetAttribute("Blocked");
        end;

        FriendRequest.Visible = v554;

        if Leaderboard.Options.List.FriendRequest.Visible then
            table.insert(v553, Leaderboard.Options.List.FriendRequest);
            Leaderboard.Options.List.FriendRequest.Text.Text = Attribute and "Unfriend" or "Friend Request";
            Leaderboard.Options.List.FriendRequest.Icon.Image = Attribute and "rbxassetid://10807506482" or "rbxassetid://10807506769";
            u10.buildSignalData(u550, u1.mouseButton(Leaderboard.Options.List.FriendRequest, function() -- Line: 3184
                -- upvalues: StarterGui (ref), u551 (copy), leaderboardActivateOptions (ref)
                pcall(function() -- Line: 3185
                    -- upvalues: StarterGui (ref), u551 (ref)
                    StarterGui:SetCore(u551:GetAttribute("Friends") and "PromptUnfriend" or "PromptSendFriendRequest", u551);
                end);
                leaderboardActivateOptions(u551, true);
            end));
        end;

        table.insert(v553, Leaderboard.Options.List.ExamineAvatar);
        u10.buildSignalData(u550, u1.mouseButton(Leaderboard.Options.List.ExamineAvatar, function() -- Line: 3190
            -- upvalues: u10 (ref), u551 (copy), GuiService (ref), leaderboardActivateOptions (ref)
            local v555 = u10.isCharLoaded(u551);

            if v555 then
                GuiService:InspectPlayerFromHumanoidDescription(v555.CurrentDescription, u551.DisplayName);
            end;

            leaderboardActivateOptions(u551, true);
        end));
        Leaderboard.Options.List.Block.Visible = u551 ~= LocalPlayer;

        if Leaderboard.Options.List.Block.Visible then
            table.insert(v553, Leaderboard.Options.List.Block);
            Leaderboard.Options.List.Block.Text.Text = u551:GetAttribute("Blocked") and "Unblock" or "Block";
            u10.buildSignalData(u550, u1.mouseButton(Leaderboard.Options.List.Block, function() -- Line: 3199
                -- upvalues: StarterGui (ref), u551 (copy), leaderboardActivateOptions (ref)
                pcall(function() -- Line: 3200
                    -- upvalues: StarterGui (ref), u551 (ref)
                    StarterGui:SetCore(u551:GetAttribute("Blocked") and "PromptUnblockPlayer" or "PromptBlockPlayer", u551);
                end);
                leaderboardActivateOptions(u551, true);
            end));
        end;

        Leaderboard.Options.Mouse.Size = UDim2.fromScale(Leaderboard.Options.Mouse.Size.X.Scale, #v553 * 0.793 + 0.976);

        for i, v in pairs(v553) do
            local v556 = i == #v553;
            v.ImageTransparency = v556 and 0 or 1;
            v.BackgroundTransparency = v556 and 1 or 0;
            u10.buildSignalData(u550, u10.buttonHoverSignalData(v));
        end;

        Leaderboard.Options.List.Background.PlayerIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. u551.UserId .. "&w=60&h=60";

        while u10.isInFrame(Leaderboard.Options.Mouse, nil, true) do
            task.wait(0.03);
        end;

        leaderboardActivateOptions(false);
    end;
end;

Leaderboard._ScrollingList.Scroll.PlayerPreview.PlayerIcon.Image = "";
local u557 = 0;
local u558 = nil;
local u559 = nil;
local u560 = nil;
local u561 = nil;
local TeamSelection = MenuGui.MenuGui.Center.Middle.TeamSelection;
local u562 = TeamSelection.List.Police.Size.X.Scale * 3 + TeamSelection.List.Civilian.Size.X.Scale;
local Size = TeamSelection.List.Police.Size;
local Size2 = TeamSelection.List.Civilian.Size;
TeamSelection.List.Civilian.Size = TeamSelection.List.Police.Size;
local Civilian = TeamSelection.List.Civilian;
local u563 = nil;
local TeamSelection2 = MenuGui.MenuGui.Center.Middle.TeamSelection;
local u564 = {};
local u565 = {};

function u1.menuPanel(u566, u567) -- Line: 3232
    -- upvalues: u10 (copy), u564 (copy), u2 (copy), TweenService (copy), u1 (copy), PlayerFunc (copy), MarketplaceService (copy), LocalPlayer (copy), u563 (ref), CharScope (copy), u565 (copy), Civilian (ref), Size2 (copy), Size (copy), u562 (copy), MapLocations (copy), UserInputService (copy), Heartbeat (copy), Leaderboard (copy), leaderboardActivateOptions (copy), TeamSelection2 (ref), u5 (copy), TextChatService (copy), u354 (copy), GameRules (copy), u558 (ref), u559 (ref), u560 (ref), u561 (ref), u557 (ref), LocalizationService (copy), GlobalGui (copy), u234 (ref), Variables (copy), Stuff (copy)
    u10.clearConnectionsAndThreads(u564);

    if u2.loaded then
        u2.lockHumanoidState("TeamSelection");
    end;

    if u566.Name == "Store" then
        local u568 = nil;

        local function displayPage(p569) -- Line: 3237
            -- upvalues: u566 (copy), u568 (ref)
            u566.Cash.Background.Visible = p569 == "Cash";
            u566.Cash.TextLabel.TextColor3 = p569 == "Cash" and Color3.fromRGB(63, 63, 63) or Color3.fromRGB(255, 255, 255);
            u566.Gamepasses.Background.Visible = p569 == "Gamepasses";
            u566.Gamepasses.TextLabel.TextColor3 = p569 == "Gamepasses" and Color3.fromRGB(63, 63, 63) or Color3.fromRGB(255, 255, 255);
            u566._ScrollingList.Cash.Visible = p569 == "Cash";
            u566._ScrollingList.Gamepasses.Visible = p569 == "Gamepasses";
            u566.ScrollBar.Visible = p569 == "Gamepasses";
            u568.limitYScrollListener();
        end;

        local function highlightListener(u570) -- Line: 3247
            -- upvalues: u564 (ref), TweenService (ref), u10 (ref)
            table.insert(u564, u570.MouseEnter:Connect(function() -- Line: 3248
                -- upvalues: TweenService (ref), u570 (copy), u10 (ref)
                TweenService:Create(u570.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Transparency = 0.92
                }):Play();

                while u10.isInFrame(u570) do
                    task.wait(0.03);

                    if not u570.Parent then
                        return;
                    end;
                end;

                TweenService:Create(u570.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end));
        end;

        for _, child in pairs(u566._ScrollingList.Cash:GetChildren()) do
            if child:IsA("ImageButton") then
                table.insert(u564, child.MouseEnter:Connect(function() -- Line: 3248
                    -- upvalues: TweenService (ref), child (copy), u10 (ref)
                    TweenService:Create(child.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Transparency = 0.92
                    }):Play();

                    while u10.isInFrame(child) do
                        task.wait(0.03);

                        if not child.Parent then
                            return;
                        end;
                    end;

                    TweenService:Create(child.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end));
                local u571 = game.ReplicatedStorage.Stuff.DeveloperProducts.Cash[child.Name];
                child.Robux.Text = u1.getProductRobuxString(u571) .. "";
                u10.buildSignalData(u564, u1.mouseButton(child, function() -- Line: 3259
                    -- upvalues: PlayerFunc (ref), u571 (copy), u10 (ref), u1 (ref)
                    local v572 = PlayerFunc:InvokeServer("promptProductPurchase", u571.ID.Value);

                    if u10.typeOf(v572) == "string" then
                        u1.notify({
                            color = "red",
                            message = v572
                        });
                    end;
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));
            end;
        end;

        for _, child in pairs(u566._ScrollingList.Gamepasses:GetChildren()) do
            if child:IsA("ImageButton") then
                table.insert(u564, child.MouseEnter:Connect(function() -- Line: 3248
                    -- upvalues: TweenService (ref), child (copy), u10 (ref)
                    TweenService:Create(child.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Transparency = 0.92
                    }):Play();

                    while u10.isInFrame(child) do
                        task.wait(0.03);

                        if not child.Parent then
                            return;
                        end;
                    end;

                    TweenService:Create(child.Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end));
                local u573 = game.ReplicatedStorage.Stuff.Gamepasses[child.Name];
                child.Robux.Text = u1.getProductRobuxString(u573) .. "";
                local v574 = u10.isGamepassOwned(child.Name);
                child.Robux.Visible = not v574;
                child.Owned.Visible = v574;
                u10.buildSignalData(u564, u1.mouseButton(child, function() -- Line: 3273
                    -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u573 (copy)
                    MarketplaceService:PromptGamePassPurchase(LocalPlayer, u573.ID.Value);
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));
                table.insert(u564, child.MouseEnter:Connect(function() -- Line: 3276
                    -- upvalues: TweenService (ref), child (copy), u10 (ref)
                    TweenService:Create(child.Description, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    }):Play();
                    TweenService:Create(child.Icon, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    }):Play();

                    while u10.isInFrame(child) do
                        task.wait(0.03);
                    end;

                    TweenService:Create(child.Description, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play();
                    TweenService:Create(child.Icon, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageTransparency = 0
                    }):Play();
                end));
            end;
        end;

        u568 = u10.scrollingListSystem(u566._ScrollingList.Gamepasses, 0.1, {
            scrollBar = u566.ScrollBar
        });
        u10.buildSignalData(u564, unpack(u568.multipleSignalData));
        table.insert(u564, u568.cleanUp);
        u10.buildSignalData(u564, u1.mouseButton(u566.Cash, function() -- Line: 3288
            -- upvalues: displayPage (copy)
            displayPage("Cash");
        end));
        u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Cash, {
            customFunc = function(p575, p576) -- Line: 3289, Name: customFunc
                p575.HoverHighlight.Visible = p576;
            end
        }));
        u10.buildSignalData(u564, u1.mouseButton(u566.Gamepasses, function() -- Line: 3292
            -- upvalues: displayPage (copy)
            displayPage("Gamepasses");
        end));
        u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Gamepasses, {
            customFunc = function(p577, p578) -- Line: 3293, Name: customFunc
                p577.HoverHighlight.Visible = p578;
            end
        }));
        displayPage("Cash");

        return;
    end;

    if u566.Name == "Help" then
        local u579 = u10.scrollingListSystem(u566.Main._ScrollingList.Scroll, 0.2, {
            scrollBar = u566.Main.ScrollBar
        });
        u10.buildSignalData(u564, unpack(u579.multipleSignalData));
        table.insert(u564, u579.cleanUp);

        local function expandTopic(p580) -- Line: 3302
            -- upvalues: u566 (copy), u10 (ref), u579 (copy)
            local function v584(p581, p582) -- Line: 3303
                -- upvalues: u566 (ref), u10 (ref)
                local v583 = u566.Main._ScrollingList.Scroll[p581 .. "Info"];

                if not v583:GetAttribute("SizeY") then
                    v583:SetAttribute("SizeY", v583.Size.Y.Scale);
                end;

                v583:GetAttribute("SizeY");
                u566.Main._ScrollingList.Scroll[p581].Arrow.Rotation = p582 and 270 or 90;
                v583.Visible = p582;

                if p582 then
                    task.spawn(u10.transparencyFade, v583, true, 0.12, 0);
                end;
            end;

            for _, child in pairs(u566.Main._ScrollingList.Scroll:GetChildren()) do
                if child:IsA("ImageButton") and child.Name ~= p580 then
                    local Name = child.Name;
                    local v585 = u566.Main._ScrollingList.Scroll[Name .. "Info"];

                    if not v585:GetAttribute("SizeY") then
                        v585:SetAttribute("SizeY", v585.Size.Y.Scale);
                    end;

                    v585:GetAttribute("SizeY");
                    u566.Main._ScrollingList.Scroll[Name].Arrow.Rotation = 90;
                    v585.Visible = false;
                end;
            end;

            if p580 then
                task.spawn(v584, p580, true);
            end;

            u579.limitYScrollListener();
        end;

        for _, child in pairs(u566.Main._ScrollingList.Scroll:GetChildren()) do
            if child:IsA("ImageButton") then
                u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Main._ScrollingList.Scroll[child.Name].Background, {
                    intensity = -0.5
                }));
                u10.buildSignalData(u564, u1.mouseButton(u566.Main._ScrollingList.Scroll[child.Name], function() -- Line: 3320
                    -- upvalues: expandTopic (copy), u566 (copy), child (copy)
                    local v586;

                    if u566.Main._ScrollingList.Scroll[child.Name].Arrow.Rotation == 90 then
                        v586 = child.Name;
                    else
                        v586 = false;
                    end;

                    expandTopic(v586);
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));
            end;
        end;

        expandTopic();
        local u587 = nil;
        local u588 = { "Police Ranks", "Medical Ranks", "Fire Ranks", "Road Service Ranks", "Delivery Ranks", "Transit Ranks", "Farmer Ranks" };

        local function changeRankPanel(p589) -- Line: 3329
            -- upvalues: u566 (copy), u587 (ref), u588 (copy)
            for _, child in pairs(u566.Ranks.Panels:GetChildren()) do
                child.Visible = false;
            end;

            u587 = (p589 - 1) % #u588 + 1;
            u566.Ranks.Panels[u588[u587]].Visible = true;
        end;

        local function displaySubGui(p590) -- Line: 3334
            -- upvalues: u566 (copy), u1 (ref), u587 (ref), u588 (copy), u10 (ref)
            u566.Main.Visible = false;
            u566[p590].Visible = true;

            if u566[p590]:FindFirstChild("PC") then
                u566[p590].PC.Visible = u1.platform ~= "Mobile";
                u566[p590].Mobile.Visible = u1.platform == "Mobile";
            end;

            if p590 == "Ranks" then
                for _, child in pairs(u566.Ranks.Panels:GetChildren()) do
                    child.Visible = false;
                end;

                u587 = 0 % #u588 + 1;
                u566.Ranks.Panels[u588[u587]].Visible = true;
            end;

            task.spawn(u10.transparencyFade, u566[p590], true, 0.12, 0);
        end;

        for _, v in pairs({ "Keybinds", "Vehicle", "Quests", "Ranks" }) do
            if v ~= "Quests" then
                u10.buildSignalData(u564, u10.buttonHoverSignalData(u566[v].Close.Background));
                u566[v].Visible = false;
                u10.buildSignalData(u564, u1.mouseButton(u566[v].Close, function() -- Line: 3348
                    -- upvalues: u566 (copy), v (copy), u10 (ref)
                    u566.Main.Visible = true;
                    u566[v].Visible = false;
                    u10.transparencyFade(u566.Main, true, 0.12, 0);
                end, {
                    addMobileButton = true
                }));
            end;

            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Main[v].Background, {
                intensity = -0.5
            }));
            u10.buildSignalData(u564, u1.mouseButton(u566.Main[v], function() -- Line: 3355
                -- upvalues: v (copy), u1 (ref), displaySubGui (copy)
                if v == "Quests" then
                    u1.questBoard(true);

                    return;
                end;

                displaySubGui(v);
            end, {
                mobileButtonType = "MouseButton1Click"
            }));
        end;

        u566.Main.Visible = true;
        u10.buildSignalData(u564, u1.mouseButton(u566.Ranks.Left, function() -- Line: 3362
            -- upvalues: u587 (ref), u566 (copy), u588 (copy)
            for _, child in pairs(u566.Ranks.Panels:GetChildren()) do
                child.Visible = false;
            end;

            u587 = (u587 - 1 - 1) % #u588 + 1;
            u566.Ranks.Panels[u588[u587]].Visible = true;
        end));
        u10.buildSignalData(u564, u1.mouseButton(u566.Ranks.Right, function() -- Line: 3365
            -- upvalues: u587 (ref), u566 (copy), u588 (copy)
            for _, child in pairs(u566.Ranks.Panels:GetChildren()) do
                child.Visible = false;
            end;

            u587 = (u587 + 1 - 1) % #u588 + 1;
            u566.Ranks.Panels[u588[u587]].Visible = true;
        end));

        if u567 then
            displaySubGui(u567[1]);
        end;

        return;
    end;

    if u566.Name == "TeamSelection" then
        local u591 = 0;
        local u592 = nil;
        local u593 = 0;
        local u594 = nil;

        local function activateTeamLocationSelection(p595, p596, p597, u598, u599) -- Line: 3386
            -- upvalues: u563 (ref), u10 (ref), CharScope (ref), u566 (copy), u564 (ref), u1 (ref)
            if u563 then
                local u600 = u563[1];
                u563 = nil;
                u10.guiTransition(u600, "Position", UDim2.fromScale(0, -0.02), false);
                CharScope.taskDelay(0.3, function() -- Line: 3391
                    -- upvalues: u600 (copy)
                    u600:Destroy();
                end);
            end;

            if p595 then
                local v601 = u10.clone(u566.Selection);
                v601.Position = UDim2.fromScale(p597 and 0.5 or 0.775, 0.903);

                for _, v in pairs(p596) do
                    local v602 = u10.clone(v601.List.Preview);
                    v602.Name = v[1];
                    v602.TextLabel.Text = v[2];
                    v602.Icons[v[3] or "Default"].Visible = true;
                    v602.Visible = true;
                    u10.buildSignalData(u564, u1.mouseButton(v602, function() -- Line: 3402
                        -- upvalues: u599 (copy), u598 (copy), v (copy)
                        u599(u598, v[1]);
                    end));
                    v602.Parent = v601.List;
                end;

                v601.Parent = p595;
                v601.Background.Size = UDim2.fromScale(3.6, v601.List.UIListLayout.AbsoluteContentSize.Y / v601.AbsoluteSize.Y + 0.3);
                u563 = { v601, u598 };
                u10.guiTransition(v601, "Position", UDim2.fromScale(0, -0.02), true);
            end;
        end;

        table.insert(u565, activateTeamLocationSelection);

        local function selectTeam(p603, p604, p605) -- Line: 3420
            -- upvalues: Civilian (ref), Size2 (ref), Size (ref), u591 (ref), u562 (ref), u566 (copy), u594 (ref), u10 (ref), u592 (ref), u593 (ref)
            Civilian = p604 and p603;
            p603:TweenSize(p604 and Size2 or Size, "Out", "Quint", p605 and 0 or 0.5, true);

            if not p603.Joined.Visible then
                p603.Highlight.Visible = p604;
            end;

            p603.Button.Visible = p604;

            if p604 then
                u591 = p603.LayoutOrder / 4 * -u562;
                u566.List:TweenPosition(UDim2.fromScale(p603.LayoutOrder / 4 * -u562, u566.List.Position.Y.Scale), "Out", "Quint", p605 and 0 or 0.5, true);

                if u594 then
                    u10.taskCancel(u594);
                    u594 = nil;
                end;

                if not p605 then
                    u594 = task.delay(0.47, function() -- Line: 3430
                        -- upvalues: u592 (ref), u10 (ref), u593 (ref)
                        u592 = u10.getMousePos().X;
                        u593 = 0;
                    end);
                end;
            end;
        end;

        local u606 = {
            Civilian = { { "Main Civilian Spawn", "San Aurie City", "Main" }, { "Civilian Spawn", "Yorktown" } },
            Chef = { { "Burger Nord", "Burger Nord" }, { "Mad Mile", "Mad Mile" }, { "Maldini\'s Pizza", "Maldini\'s Pizza" } }
        };

        local function buttonStatus(p607, p608, p609) -- Line: 3414
            p608.ImageColor3 = p609 == "CanLeave" and Color3.fromRGB(220, 148, 85) or p609 == "Joined" and Color3.fromRGB(209, 175, 95) or (p609 == "Join" and Color3.fromRGB(62, 150, 69) or Color3.fromRGB(255, 255, 255));

            if p608:FindFirstChild("Frame") then
                p608.Frame.BackgroundColor3 = p608.ImageColor3;
            end;

            p608.TextLabel.TextColor3 = (p609 == "CanLeave" or (p609 == "Joined" or p609 == "Join")) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(54, 54, 59);
            p608.TextLabel.Text = p609 == "CanLeave" and "LEAVE TEAM" or (p609 == "Joined" and "RESPAWN" or (p609 == "Join" and "SELECT TEAM" or "SHOW ON MAP"));
        end;

        local u610 = false;

        for _, child in pairs(u566.List:GetChildren()) do
            if child:IsA("Frame") then
                local u611 = LocalPlayer.Team and LocalPlayer.Team.Name == child.Name;
                local u612;

                if u611 then
                    u612 = u10.isPlayerNearbyToLeaveJobTeam(LocalPlayer);
                end;

                local u613;

                if u567 then
                    if u10.typeOf(u567[1]) == "Instance" then
                        u613 = u567[1].TeamSpawn.Value.Parent.Parent.Name == child.Name;
                    else
                        u613 = false;
                    end;
                else
                    u613 = u567;
                end;

                local u614 = not u612 and not u611;
                child.Button.Button.Visible = not u614;
                child.Button.Locate.Visible = not u614;
                child.Button.FullButton.Visible = u614;
                child.Joined.Visible = u611;
                child.JoinedGlow.Visible = u611;
                child.Highlight.Visible = u611;
                child.Highlight.ImageColor3 = u611 and Color3.fromRGB(102, 207, 109) or Color3.fromRGB(255, 255, 255);
                child.Full.Visible = false;
                u10.buildSignalData(u564, u1.mouseButton(child.Background, function() -- Line: 3458
                    -- upvalues: Civilian (ref), Size (ref), selectTeam (copy), child (copy)
                    if Civilian then
                        local v615 = Civilian;
                        Civilian = nil;
                        v615:TweenSize(Size, "Out", "Quint", 0.5, true);

                        if not v615.Joined.Visible then
                            v615.Highlight.Visible = nil;
                        end;

                        v615.Button.Visible = nil;
                    end;

                    selectTeam(child, true);
                end, {
                    buttonType = "MouseButton1Click",
                    keepClickClose = true
                }));

                local function buttonPressed(p616, p617) -- Line: 3463
                    -- upvalues: u610 (ref), u606 (copy), child (copy), u567 (copy), u10 (ref), u612 (copy), u1 (ref), activateTeamLocationSelection (copy), u614 (copy), buttonPressed (ref), u613 (copy), u2 (ref), MapLocations (ref)
                    if u610 and u610[2] == p616 or (p617 or not (u606[child.Name] and (not u567 or u10.typeOf(u567[1]) ~= "Instance")) or p616 and u612) then
                        if p616 then
                            if not u10.invokeTraffic.selectTeam then
                                local v618 = u10.invokeServerTraffic("selectTeam", u613 and u567[1] or (u612 and "LeaveTeam" or child.Name), p617);

                                if v618 == true then
                                    u1.activateMenu(false);

                                    return;
                                end;

                                if u10.typeOf(v618) == "string" then
                                    u1.notify({
                                        color = "red",
                                        message = v618
                                    });

                                    return;
                                end;
                            end;
                        elseif u2.loaded then
                            u2.activateMap(true, p617 and (workspace.World.Housing:FindFirstChild(p617) and workspace.World.Housing[p617].PrimaryPart.Position or game.Teams[child.Name].Spawn[p617].Value.Name) or (MapLocations:FindFirstChild(game.Teams[child.Name].Spawn:GetChildren()[1].Value.Name) and (require(game.Teams[child.Name].Config).DEFAULT_SPAWN or game.Teams[child.Name].Spawn:GetChildren()[1].Value.Name) or game.Teams[child.Name].Spawn:GetChildren()[1].Value:GetPivot().Position));
                            u1.activateMenu(false);
                        end;

                        return;
                    end;

                    local v619 = u10.deepCopyTable(u606[child.Name]);

                    if child.Name == "Civilian" and u10.isGamepassOwned("Property Upgrade") then
                        local v620 = {};

                        for i, _ in pairs(u1.readPlayerData("Housing")) do
                            local Config = require(workspace.World.Housing[i].Config);

                            if Config.CATEGORY == "House" or Config.CATEGORY == "Apartment" then
                                table.insert(v620, i);
                            end;
                        end;

                        table.sort(v620, function(p621, p622) -- Line: 3472
                            return p621 < p622;
                        end);
                        local FavoriteProperty = u10.getFavoriteProperty();

                        for _, v in pairs(v620) do
                            table.insert(v619, { v, v, v == FavoriteProperty and "Main" or "House" });
                        end;
                    end;

                    activateTeamLocationSelection(child, v619, p616 or u614, p616, buttonPressed);
                end;

                if u614 then
                    buttonStatus(child.Name, child.Button.FullButton, u612 and "CanLeave" or (u611 and "Joined" or u613 and "Join"));
                    u10.resetButtonColor(child.Button.FullButton);
                    u10.buildSignalData(u564, u10.buttonHoverSignalData(child.Button.FullButton));
                    table.insert(u564, child.Button.FullButton.MouseButton1Click:Connect(function() -- Line: 3498
                        -- upvalues: buttonPressed (ref), u613 (copy)
                        buttonPressed(u613 and true or false);
                    end));
                else
                    buttonStatus(child.Name, child.Button.Button, u612 and "CanLeave" or (u611 and "Joined" or u613 and "Join"));
                    u10.resetButtonColor(child.Button.Button);
                    u10.resetButtonColor(child.Button.Locate);
                    u10.buildSignalData(u564, u10.buttonHoverSignalData(child.Button.Button, {
                        childrenVisual = { child.Button.Button, child.Button.Button.Frame }
                    }));
                    u10.buildSignalData(u564, u10.buttonHoverSignalData(child.Button.Locate, {
                        childrenVisual = { child.Button.Locate, child.Button.Locate.Frame }
                    }));
                    table.insert(u564, child.Button.Button.MouseButton1Click:Connect(function() -- Line: 3507
                        -- upvalues: buttonPressed (ref)
                        buttonPressed(true);
                    end));
                    table.insert(u564, child.Button.Locate.MouseButton1Click:Connect(function() -- Line: 3510
                        -- upvalues: buttonPressed (ref)
                        buttonPressed(false);
                    end));
                end;

                local function updateTeamCount() -- Line: 3514
                    -- upvalues: u10 (ref), child (copy), u611 (copy)
                    local v623 = #u10.getLoadedPlayers(game.Teams[child.Name]);
                    child.Players.Text = v623;
                    child.Players.Shadow.Text = v623;

                    if not u611 then
                        child.Full.Visible = not u10.canJoinTeam(v623, child.Name);
                    end;
                end;

                u10.loadedPlayerAdded(u10.buildSignalData, u564, game.Teams[child.Name], updateTeamCount);
                table.insert(u564, game.Teams[child.Name].PlayerRemoved:Connect(updateTeamCount));
                local v624 = #u10.getLoadedPlayers(game.Teams[child.Name]);
                child.Players.Text = v624;
                child.Players.Shadow.Text = v624;

                if not u611 then
                    child.Full.Visible = not u10.canJoinTeam(v624, child.Name);
                end;

                if game.Teams[child.Name]:FindFirstChild("Jobs") then
                    local u625 = child;

                    for _, child2 in pairs(game.Teams[child.Name].Jobs:GetChildren()) do
                        local function update(p626) -- Line: 3526
                            -- upvalues: u625 (copy), child2 (copy)
                            u625.Jobs[child2.Name].Text = p626 == 1 and "Low" or (p626 == 2 and "Average" or (p626 == 3 and "High" or false));
                            local v627 = u625.Jobs[child2.Name];
                            local v628 = p626 == 1 and Color3.fromRGB(255, 120, 120) or p626 == 2 and Color3.fromRGB(255, 192, 119);

                            if not v628 then
                                if p626 == 3 then
                                    v628 = Color3.fromRGB(112, 231, 103);
                                else
                                    v628 = false;
                                end;
                            end;

                            v627.TextColor3 = v628;
                        end;

                        table.insert(u564, child2.Changed:Connect(update));
                        update(child2.Value);
                    end;
                end;
            end;
        end;

        if Civilian then
            u10.transparencyFadeRemove(Civilian.Button);
            u10.transparencyFadeRemove(Civilian.Highlight);
            local v629 = Civilian;
            Civilian = nil;
            v629:TweenSize(Size, "Out", "Quint", 0, true);

            if not v629.Joined.Visible then
                v629.Highlight.Visible = nil;
            end;

            v629.Button.Visible = nil;
        end;

        local v630 = u567 and u10.typeOf(u567[1]) == "Instance" and u566.List[u567[1].TeamSpawn.Value.Parent.Parent.Name] or LocalPlayer.Team and u566.List:FindFirstChild(LocalPlayer.Team.Name);

        if v630 then
            selectTeam(v630, true, true);
        end;

        local u631 = 0;
        local u632 = tick();
        table.insert(u564, UserInputService.InputBegan:Connect(function(p633) -- Line: 3547
            -- upvalues: u632 (copy), u610 (ref), u563 (ref), activateTeamLocationSelection (copy), u591 (ref), u566 (copy), u592 (ref), u10 (ref), u593 (ref)
            if (p633.UserInputType == Enum.UserInputType.MouseButton1 or p633.UserInputType == Enum.UserInputType.Touch) and tick() - u632 > 0.2 then
                u610 = u563;

                if u563 then
                    activateTeamLocationSelection();
                end;

                u591 = u566.List.Position.X.Scale;
                u592 = u10.getMousePos().X;
                u593 = 0;
            end;
        end));
        table.insert(u564, Heartbeat:Connect(function(p634) -- Line: 3562
            -- upvalues: u1 (ref), u592 (ref), u10 (ref), u631 (ref), u593 (ref), u566 (copy), u591 (ref), u562 (ref)
            if u1.isMouseButton1Pressed() and u592 then
                local v635 = u1.getMouseProperty.mobileTouch and u1.getMouseProperty.mobileTouch.Position.X or u10.getMousePos().X;
                u631 = v635 - u592 - u593;
                u593 = v635 - u592;
            else
                u631 = u10.lerp(u631, 0, 1 - 1e-6 ^ p634);
                u593 = u593 + u631;
            end;

            u566.List.Position = UDim2.fromScale(math.clamp(u591 + u593 / u566.AbsoluteSize.X, -u562, u562), u566.List.Position.Y.Scale);
        end));

        return;
    end;

    if u566.Name == "Leaderboard" then
        for _, child in pairs(Leaderboard._ScrollingList.Scroll:GetChildren()) do
            if child.Name == "Player" then
                child:Destroy();
            end;
        end;

        u10.buildSignalData(u564, u1.mouseButton(Leaderboard.InviteFriend, function() -- Line: 3576
            -- upvalues: LocalPlayer (ref)
            game:GetService("SocialService"):PromptGameInvite(LocalPlayer);
        end));
        u10.buildSignalData(u564, u10.buttonHoverSignalData(Leaderboard.InviteFriend));
        local v636 = {};

        for _, v in pairs(u10.getLoadedPlayers()) do
            table.insert(v636, v);
        end;

        table.sort(v636, function(p637, p638) -- Line: 3584
            return p637.Reputation.Value > p638.Reputation.Value;
        end);
        Leaderboard.TopBar.PlayersText.Text = "PLAYERS (" .. #v636 .. ")";

        for i, v in pairs(v636) do
            local Attribute = v:GetAttribute("Incognito");
            local v639 = u10.clone(Leaderboard._ScrollingList.Scroll.PlayerPreview);
            v639.Visible = true;
            v639.Name = "Player";
            v639.LayoutOrder = i;
            v639.Team.Text = v.Team and (v.Team.Name or "") or "";
            v639.PlayerName.Text = "@" .. (Attribute or v.Name);
            v639.DisplayName.Text = Attribute or v.DisplayName;
            v639.Reputation.Text = v.Reputation.Value;
            local Attribute2 = v:GetAttribute("Platform");

            if Attribute2 then
                v639.Platform.Text = Attribute2;
            end;

            local u640;

            if Attribute then
                u640 = v;
            else
                u640 = v;

                for _, child in pairs(v639.Icons:GetChildren()) do
                    if child:IsA("ImageLabel") and u640:GetAttribute(child.Name) then
                        child.Visible = true;
                        u10.buildSignalData(u564, u1.displayGuiDetails(child, u10.splitCapitalLetters(child.Name)));
                    end;
                end;
            end;

            if u640 == LocalPlayer then
                v639.ImageColor3 = Color3.fromRGB(88, 105, 135);
            end;

            v639.PlayerIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. u640.UserId .. "&w=60&h=60";
            v639.Parent = Leaderboard._ScrollingList.Scroll;
            u10.buildSignalData(u564, u1.mouseButton(v639, function() -- Line: 3612
                -- upvalues: leaderboardActivateOptions (ref), u640 (copy)
                leaderboardActivateOptions(u640);
            end, {
                mobileButtonType = "MouseButton1Click"
            }));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(v639));
        end;

        local v641 = u10.scrollingListSystem(Leaderboard._ScrollingList.Scroll, 0.3, {
            hideScrollBarWhenNotUsed = true,
            scrollBar = Leaderboard.ScrollBar
        });
        u10.buildSignalData(u564, unpack(v641.multipleSignalData));
        table.insert(u564, v641.cleanUp);
        Leaderboard._ScrollingList.Size = UDim2.fromScale(Leaderboard.ScrollBar.Visible and 0.982 or 0.991, Leaderboard._ScrollingList.Size.Y.Scale);

        return;
    end;

    if u566.Name ~= "Settings" then
        if u566.Name == "PrivateServers" then
            if GameRules.temporaryPrivateServerComingSoon then
                u566.List.Visible = false;
                u566.Buttons.Visible = false;
                u566.PrivateServer.Visible = false;
                u566.Windows.Visible = false;
                u566["COMING SOON"].Visible = true;

                return;
            end;

            local u653 = (function(p642, u643, u644, u645) -- Line: 3844, Name: createSearchBox
                -- upvalues: u10 (ref)
                u643.TextBoxFrame.TextBox.Text = "";

                local function u647() -- Line: 3846
                    -- upvalues: u643 (copy), u644 (copy), u645 (copy)
                    local string_lower_ret = string.lower(u643.TextBoxFrame.TextBox.Text);

                    for _, child in pairs(u644:GetChildren()) do
                        local v646;

                        if string_lower_ret == "" or not string_lower_ret then
                            v646 = nil;
                        else
                            v646 = string_lower_ret;
                        end;

                        u645(child, v646);
                    end;
                end;

                table.insert(p642, u643.TextBoxFrame.TextBox.FocusLost:Connect(function(p648) -- Line: 3850
                    -- upvalues: u647 (copy)
                    u647();
                end));
                local v649 = u10.textBoxSystem(u643.TextBoxFrame, {
                    enableScrolling = true
                });
                u10.buildSignalData(p642, unpack(v649.multipleSignalData));
                table.insert(p642, v649.cleanUp);

                return u647;
            end)(u564, u566.List.SearchBox, u566.List._ScrollingList.Scroll, function(p650, p651) -- Line: 3858
                if p650.Name == "Server" then
                    local v652;

                    if p651 then
                        v652 = string.find(string.lower(p650.ServerName.Text), p651, nil, true) or p650:GetAttribute("searchTags") and string.find(p650:GetAttribute("searchTags"), p651, nil, true);
                    else
                        v652 = true;
                    end;

                    if p650.Visible ~= (v652 and true or false) then
                        p650.Visible = v652;
                    end;
                end;
            end);
            u566.List.Visible = true;
            u566.PrivateServer.Visible = false;
            local u654 = "Community";

            for _, child in pairs(u566.Windows:GetChildren()) do
                child.Visible = false;
            end;

            local function buttonColorCore(p655, p656) -- Line: 3868
                p655.Background.ImageTransparency = p656 and 0 or 1;
                p655.TextLabel.TextColor3 = not p656 and (p655.Name == "PrivateServer" and Color3.fromRGB(255, 214, 117) or Color3.fromRGB(255, 255, 255)) or Color3.fromRGB(63, 63, 63);
            end;

            local function buttonColor(p657) -- Line: 3872
                -- upvalues: buttonColorCore (copy), u566 (copy), u654 (ref)
                for _, v in pairs({ "Community", "Ranked", "PrivateServer", "JoinIP", "FavOwned", "CreateServer" }) do
                    buttonColorCore(u566.Buttons[v]);
                end;

                local v658 = p657 or (u654 and u566.Buttons[u654] or (u566.Buttons.PrivateServer.Visible and u566.Buttons.PrivateServer or u566.Buttons.Community));

                if v658 then
                    v658.Background.ImageTransparency = 0;
                    v658.TextLabel.TextColor3 = Color3.fromRGB(63, 63, 63);
                end;
            end;

            local function setWindow(p659) -- Line: 3877
                -- upvalues: u566 (copy), u10 (ref)
                for _, child in pairs(u566.Windows:GetChildren()) do
                    if child.Visible then
                        u10.guiTransition(child, "Position", UDim2.fromScale(0, 0.02), false);
                        child:SetAttribute("On", nil);
                    end;
                end;

                if p659 then
                    u10.guiTransition(u566.Windows[p659], "Position", UDim2.fromScale(0, 0.02), true);
                    u566.Windows[p659]:SetAttribute("On", true);
                end;
            end;

            table.insert(u564, task.spawn(function() -- Line: 3883
                -- upvalues: PlayerFunc (ref), u558 (ref), u559 (ref), u560 (ref), u561 (ref), u557 (ref)
                while true do
                    local v660, v661, v662, v663 = PlayerFunc:InvokeServer("clientPrivateServerAsync", "getLists");

                    if v660 then
                        u558 = v660;
                        u559 = v661;
                        u560 = v662;
                        u561 = v663;
                        u557 = (u557 + 1) % 100;
                    end;

                    task.wait(5);
                end;
            end));
            local u664 = nil;

            local function setCreateAndJoinButtonColors(p665) -- Line: 3896
                -- upvalues: u566 (copy)
                u566.Windows.JoinIP.Join.Background.ImageColor3 = p665 and Color3.fromRGB(35, 173, 46) or Color3.fromRGB(157, 157, 157);
                u566.Windows.CreateServer.Create.Background.ImageColor3 = p665 and Color3.fromRGB(35, 173, 46) or Color3.fromRGB(157, 157, 157);
                u566.Windows.ServerDetails.Join.Default.Join.Background.ImageColor3 = p665 and Color3.fromRGB(35, 173, 46) or Color3.fromRGB(157, 157, 157);
                u566.Windows.ServerDetails.Join.Password.Join.Background.ImageColor3 = p665 and Color3.fromRGB(35, 173, 46) or Color3.fromRGB(157, 157, 157);
            end;

            local u666 = nil;
            local u667 = false;

            local function setServerDetailsFavorite(p668) -- Line: 3905
                -- upvalues: u566 (copy), u667 (ref)
                u566.Windows.ServerDetails.Favorite.Background.ImageColor3 = p668 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(145, 145, 145);
                u566.Windows.ServerDetails.Favorite.Icon.ImageColor3 = p668 and Color3.fromRGB(106, 106, 106) or Color3.fromRGB(255, 255, 255);
                u667 = p668;
            end;

            local u669 = u10.scrollingListSystem(u566.Windows.ServerDetails._ScrollingList.Scroll, 0.1, {
                hideScrollBarWhenNotUsed = true,
                scrollBar = u566.Windows.ServerDetails.ScrollBar
            });
            u10.buildSignalData(u564, unpack(u669.multipleSignalData));
            table.insert(u564, u669.cleanUp);

            local function setServerDetails(p670, p671) -- Line: 3913
                -- upvalues: u666 (ref), buttonColor (copy), u566 (copy), u10 (ref), GameRules (ref), LocalPlayer (ref), setServerDetailsFavorite (copy), u1 (ref), LocalizationService (ref), setCreateAndJoinButtonColors (copy), GlobalGui (ref), u234 (ref), u669 (copy), setWindow (copy)
                u666 = p670;
                buttonColor();
                u566.Windows.ServerDetails._ScrollingList.Scroll.Position = UDim2.new();
                u566.Windows.ServerDetails.Join.Visible = not p671;
                local PrivateServerConfigurationValue = u10.getPrivateServerConfigurationValue(p670);
                u566.Windows.ServerDetails.ServerName.Text = p670.serverName;

                if p670.ranked then
                    u10.fitText(u566.Windows.ServerDetails.Description.Default.Description, "This is the official vanilla server, open for players with a certain level of experience. It ensures higher quality gameplay and roleplay. Your progress is saved on the server", 8);
                else
                    u10.fitText(u566.Windows.ServerDetails.Description.Default.Description, PrivateServerConfigurationValue.description or "A community server", 8);
                end;

                u566.Windows.ServerDetails.Players.Text = p670.players .. "/" .. (p670.serverSize or GameRules.maxPlayers);
                local v672 = {};

                for i, v in pairs({
                    accessServerGroup = "Group",
                    password = "Password",
                    accountVerification = "Verified",
                    voiceChatRequired = "Voice Chat",
                    minimumReputation = "* Rep"
                }) do
                    local v673 = p670[i] or PrivateServerConfigurationValue[i];

                    if v673 then
                        local v674;

                        if string.find(v, "*") then
                            v674 = string.gsub(v, "*", u10.privateServerAvailableConfiguration[i].display[v673]) or v;
                        else
                            v674 = v;
                        end;

                        table.insert(v672, v674);
                    end;
                end;

                u10.fitText(u566.Windows.ServerDetails.Requirements, #v672 > 0 and table.concat(v672, ", ") or "None", 2);
                u566.Windows.ServerDetails.Flag.Visible = false;
                u566.Windows.ServerDetails.Dot.Visible = false;

                if p670.ranked then
                    u566.Windows.ServerDetails.LanguageOrRank.Text = GameRules.privateRankedServerTypes[p670.ranked].name;
                    u566.Windows.ServerDetails.Dot.ImageColor3 = GameRules.privateRankedServerTypes[p670.ranked].color;
                    u566.Windows.ServerDetails.Dot.Visible = true;
                else
                    local v675 = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[u10.privateServerAvailableConfiguration.language.display[p670.language or "default"]];
                    u566.Windows.ServerDetails.LanguageOrRank.Text = string.split(v675.Name, " ")[1];
                    u566.Windows.ServerDetails.Flag.Image = v675.Texture;
                    u566.Windows.ServerDetails.Flag.Visible = true;
                end;

                u566.Windows.ServerDetails.Favorite.Visible = false;
                u566.Windows.ServerDetails.IsOwner.Visible = false;

                if not p670.ranked then
                    if p670.ownerId == tostring(LocalPlayer.UserId) then
                        u566.Windows.ServerDetails.IsOwner.Visible = true;
                    else
                        u566.Windows.ServerDetails.Favorite.Visible = true;
                        setServerDetailsFavorite(u1.readPlayerData("FavoritePrivateServers")[p670.serverId]);
                    end;
                end;

                u566.Windows.ServerDetails.LanguageOrRankHeadline.Text = p670.ranked and "EXPERIENCE" or "LANGUAGE";
                u566.Windows.ServerDetails._ScrollingList.Scroll.List.JoinIP.Visible = PrivateServerConfigurationValue.defaultJoinIP;

                if PrivateServerConfigurationValue.defaultJoinIP then
                    u566.Windows.ServerDetails._ScrollingList.Scroll.List.JoinIP.Text = "Join IP: " .. (PrivateServerConfigurationValue.customJoinIP or PrivateServerConfigurationValue.defaultJoinIP) .. "-" .. (p670.language or "us");
                end;

                u566.Windows.ServerDetails._ScrollingList.Scroll.List.CreationDate.Visible = p670.creationDate;

                if p670.creationDate then
                    u566.Windows.ServerDetails._ScrollingList.Scroll.List.CreationDate.Text = "Creation Date: " .. DateTime.fromUnixTimestamp(p670.creationDate):FormatUniversalTime("L", LocalizationService.RobloxLocaleId);
                end;

                u566.Windows.ServerDetails._ScrollingList.Scroll.List.Owner.Visible = p670.owner;

                if p670.owner then
                    u566.Windows.ServerDetails._ScrollingList.Scroll.List.Owner.Text = "Owner: " .. p670.owner;
                end;

                u566.Windows.ServerDetails._ScrollingList.Scroll.List.OwnerInfo.Visible = p670.ownerId == tostring(LocalPlayer.UserId);
                u566.Windows.ServerDetails._ScrollingList.Scroll.List.ServerUpgrades.Visible = p670.upgrades and #p670.upgrades > 0;

                if p670.upgrades and #p670.upgrades > 0 then
                    local v676 = {};

                    for i, _ in pairs(p670.upgrades) do
                        table.insert(v676, i);
                    end;

                    u10.fitText(u566.Windows.ServerDetails._ScrollingList.Scroll.List.ServerUpgrades, "Server Upgrades: " .. table.concat(v676, ", "));
                end;

                setCreateAndJoinButtonColors(true);

                if p670.password then
                    u566.Windows.ServerDetails.Join.Default.Visible = false;
                    u566.Windows.ServerDetails.Join.Password.Visible = true;
                    u566.Windows.ServerDetails.Join.Password.Content.TextBoxFrame.TextBox.Text = "";
                else
                    u566.Windows.ServerDetails.Join.Default.Visible = true;
                    u566.Windows.ServerDetails.Join.Password.Visible = false;
                end;

                local v677 = {};

                for i, _ in pairs(p670.tags) do
                    table.insert(v677, u566.List._ScrollingList.Scroll.Tags[i].TextLabel.Text);
                end;

                u10.fitText(u566.Windows.ServerDetails._ScrollingList.Scroll.List.Tags, "Tags: " .. table.concat(v677, ", "));
                local v678 = u10.indexedTableSize(PrivateServerConfigurationValue);
                u566.Windows.ServerDetails._ScrollingList.Scroll.List.Configuration.Visible = v678 > 0;
                local v679 = {};

                if v678 > 0 then
                    local Scroll = GlobalGui.Center.Middle.PrivateServerPanel.Configuration._ScrollingList.Scroll;

                    for i, v in pairs(u10.privateServerAvailableConfiguration) do
                        if u10.typeOf(v) == "table" and not (u10.privateServerServerDetailsIgnoreConfig[i] or (v.storage == "core" or v.storage == "session")) then
                            local v680 = (v.storage == "main" and p670 and p670 or PrivateServerConfigurationValue)[i];

                            if v680 then
                                local v681 = Scroll[u10.firstToUpper(i)].Headline.Text .. " \'" .. u10.cutTextBeyondBounds(u566.Windows.ServerDetails._ScrollingList.Scroll.List.MaxConfigurationValueSize, u234(i, v680, p670, PrivateServerConfigurationValue), u566.Windows.ServerDetails._ScrollingList.Scroll.List.MaxConfigurationValueSize.Size.X.Scale) .. "\'";
                                table.insert(v679, v681);
                            end;
                        end;
                    end;

                    if #v679 > 0 then
                        u10.fitText(u566.Windows.ServerDetails._ScrollingList.Scroll.List.Configuration, "Configuration: " .. table.concat(v679, ", "));
                    end;
                end;

                u566.Windows.ServerDetails._ScrollingList.Scroll.List.Configuration.Visible = #v679 > 0;
                local v682 = u566.Windows.ServerDetails._ScrollingList.Scroll.List.UIListLayout.AbsoluteContentSize.Y / u566.Windows.ServerDetails._ScrollingList.AbsoluteSize.Y > 1;

                if v682 then
                    u669.limitYScrollListener();
                end;

                u566.Windows.ServerDetails.ScrollBar.Visible = v682;

                local function showSocialMedia() -- Line: 4001
                end;

                for _, child in pairs(u566.Windows.ServerDetails._ScrollingList.Scroll.List:GetChildren()) do
                    if child.Name == "SocialMedia" then
                        child:Destroy();
                    end;
                end;

                if GameRules.policyInfo and GameRules.policyInfo.AllowedExternalLinkReferences then
                    local v683 = {
                        YouTube = "rbxassetid://81237555729176",
                        X = "rbxassetid://122723221155271",
                        Discord = "rbxassetid://109365199217277",
                        Guilded = "rbxassetid://130443975499710"
                    };

                    for i = 1, 2 do
                        local v684 = PrivateServerConfigurationValue[i == 1 and "platformHandle" or "platform2Handle"];
                        local v685;

                        if v684 then
                            local v686 = u10.privateServerAvailableConfiguration[i == 1 and "platform" or "platform2"].display[PrivateServerConfigurationValue[i == 1 and "platform" or "platform2"] or "default"];
                            v685 = i;

                            for i2, v in pairs(GameRules.policyInfo.AllowedExternalLinkReferences) do
                                if v == v686 then
                                    local v687 = u10.clone(u566.Windows.ServerDetails._ScrollingList.Scroll.List.SocialMediaPreview);
                                    v687.Name = "SocialMedia";
                                    v687.Visible = true;
                                    v687.Icon.Image = v683[v686];
                                    v687.TextLabel.Text = v684;
                                    v687.LayoutOrder = -10 - i2;
                                    v687.Parent = u566.Windows.ServerDetails._ScrollingList.Scroll.List;
                                    break;
                                end;
                            end;
                        else
                            v685 = i;
                        end;
                    end;
                end;

                setWindow("ServerDetails");

                while u566.Windows.ServerDetails:GetAttribute("On") do
                    task.wait();
                end;
            end;

            u10.buildSignalData(u564, u1.displayGuiDetails(u566.Windows.ServerDetails.IsOwner, "Owned"));
            u10.buildSignalData(u564, u1.displayGuiDetails(u566.Windows.ServerDetails.Favorite, "Favorite"));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.ServerDetails.Close));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.ServerDetails.Favorite.Background));
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.ServerDetails.Close, function() -- Line: 4036
                -- upvalues: buttonColor (copy), setWindow (copy)
                buttonColor();
                setWindow();
            end, {
                addMobileButton = true
            }));
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.ServerDetails.Favorite, function() -- Line: 4040
                -- upvalues: u10 (ref), u666 (ref), u667 (ref), u1 (ref), setServerDetailsFavorite (copy)
                if not u10.invokeTraffic.clientPrivateServerAsync then
                    local serverId = u666.serverId;
                    local v688 = u10.invokeServerTraffic("clientPrivateServerAsync", "setFavorite", {
                        serverId = serverId,
                        set = not u667
                    });

                    if u10.typeOf(v688) == "string" then
                        u1.notify({
                            color = "red",
                            message = v688
                        });

                        return;
                    end;

                    if (v688 == true or v688 == false) and u666.serverId == serverId then
                        setServerDetailsFavorite(v688);
                    end;
                end;
            end));

            local function joinServer(p689) -- Line: 4051
                -- upvalues: u10 (ref), setCreateAndJoinButtonColors (copy), u666 (ref), u1 (ref)
                if not u10.invokeTraffic.clientPrivateServerAsync then
                    setCreateAndJoinButtonColors(false);
                    local v690 = u10.invokeServerTraffic("clientPrivateServerAsync", "join", {
                        serverId = u666.serverId,
                        password = p689
                    });

                    if u10.typeOf(v690) == "string" then
                        u1.notify({
                            color = "red",
                            message = v690
                        });
                    end;

                    setCreateAndJoinButtonColors(true);
                end;
            end;

            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.ServerDetails.Join.Default.Join, function() -- Line: 4059
                -- upvalues: joinServer (copy)
                joinServer();
            end));
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.ServerDetails.Join.Password.Join, function() -- Line: 4060
                -- upvalues: joinServer (copy), u566 (copy)
                joinServer(u566.Windows.ServerDetails.Join.Password.Content.TextBoxFrame.TextBox.Text);
            end));
            local v691 = u10.textBoxSystem(u566.Windows.ServerDetails.Join.Password.Content.TextBoxFrame);
            u10.buildSignalData(u564, unpack(v691.multipleSignalData));
            table.insert(u564, v691.cleanUp);
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.ServerDetails.Join.Default.Join.Background));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.ServerDetails.Join.Password.Join.Background));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.JoinIP.Close));
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.JoinIP.Close, function() -- Line: 4068
                -- upvalues: setWindow (copy), buttonColor (copy)
                setWindow();
                buttonColor();
            end, {
                addMobileButton = true
            }));
            local v692 = u10.textBoxSystem(u566.Windows.JoinIP.Content.TextBoxFrame);
            u10.buildSignalData(u564, unpack(v692.multipleSignalData));
            table.insert(u564, v692.cleanUp);
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.JoinIP.Join, function() -- Line: 4075
                -- upvalues: u10 (ref), u566 (copy), setCreateAndJoinButtonColors (copy), setServerDetails (copy), u1 (ref)
                if not (u10.invokeTraffic.clientPrivateServerAsync or (not u566.Windows.JoinIP:GetAttribute("On") or u566.Windows.JoinIP.Content.TextBoxFrame.TextBox.Text == "")) then
                    setCreateAndJoinButtonColors(false);
                    local v693 = u10.invokeServerTraffic("clientPrivateServerAsync", "getServerDataFromIp", {
                        joinIp = u566.Windows.JoinIP.Content.TextBoxFrame.TextBox.Text
                    });

                    if u10.typeOf(v693) == "table" then
                        setServerDetails(v693);
                    elseif u10.typeOf(v693) == "string" then
                        u1.notify({
                            color = "red",
                            message = v693
                        });
                    end;

                    setCreateAndJoinButtonColors(true);
                end;
            end));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.JoinIP.Join.Background));
            local PropertyChangedSignal = u566.Windows.JoinIP.Content.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text");
            table.insert(u564, PropertyChangedSignal:Connect(function() -- Line: 4086
                -- upvalues: u566 (copy)
                local TextBox = u566.Windows.JoinIP.Content.TextBoxFrame.TextBox;
                local string_lower_ret = string.lower(string.gsub(u566.Windows.JoinIP.Content.TextBoxFrame.TextBox.Text, "%s+", ""));
                TextBox.Text = string.sub(string_lower_ret, 1, 30);
            end));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.CreateServer.Close));
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.CreateServer.Close, function() -- Line: 4091
                -- upvalues: setWindow (copy), buttonColor (copy)
                setWindow();
                buttonColor();
            end, {
                addMobileButton = true
            }));
            local v694 = u10.textBoxSystem(u566.Windows.CreateServer.Content.TextBoxFrame);
            u10.buildSignalData(u564, unpack(v694.multipleSignalData));
            table.insert(u564, v694.cleanUp);
            u10.buildSignalData(u564, u1.mouseButton(u566.Windows.CreateServer.Create, function() -- Line: 4098
                -- upvalues: u10 (ref), u566 (copy), setCreateAndJoinButtonColors (copy), setWindow (copy), buttonColor (copy), u1 (ref)
                if not u10.invokeTraffic.clientPrivateServerAsync and u566.Windows.CreateServer:GetAttribute("On") then
                    setCreateAndJoinButtonColors(false);
                    local v695 = u10.invokeServerTraffic("clientPrivateServerAsync", "create", {
                        name = u566.Windows.CreateServer.Content.TextBoxFrame.TextBox.Text
                    });

                    if v695 == true then
                        setWindow();
                        buttonColor();
                    elseif u10.typeOf(v695) == "string" then
                        u1.notify({
                            color = "red",
                            message = v695
                        });
                    end;

                    setCreateAndJoinButtonColors(true);
                end;
            end));
            u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Windows.CreateServer.Create.Background));
            local u696 = "";
            local PropertyChangedSignal2 = u566.Windows.CreateServer.Content.TextBoxFrame.TextBox:GetPropertyChangedSignal("Text");
            table.insert(u564, PropertyChangedSignal2:Connect(function() -- Line: 4111
                -- upvalues: u10 (ref), u566 (copy), u696 (ref)
                if u10.privateServerAvailableConfiguration.serverName.isInvalid(u566.Windows.CreateServer.Content.TextBoxFrame.TextBox.Text, true) then
                    u566.Windows.CreateServer.Content.TextBoxFrame.TextBox.Text = u696;

                    return;
                end;

                u696 = u566.Windows.CreateServer.Content.TextBoxFrame.TextBox.Text;
            end));
            local u697 = {};

            local function loadingCircle(p698) -- Line: 4118
                -- upvalues: u566 (copy)
                u566.List.LoadingCircle.Visible = true;
                local v699 = 0;

                while p698() do
                    u566.List.LoadingCircle.Rotation = u566.List.LoadingCircle.Rotation + v699 * 3 * 60;
                    v699 = task.wait();
                end;

                u566.List.LoadingCircle.Visible = false;
            end;

            local function showSubpanel(p700) -- Line: 4127
                -- upvalues: u10 (ref), u697 (copy), u566 (copy), u654 (ref), Variables (ref), GameRules (ref), u564 (ref), u1 (ref), setServerDetails (copy), LocalPlayer (ref), u664 (ref), u653 (copy), u557 (ref), loadingCircle (copy), u558 (ref), u560 (ref), u561 (ref), u559 (ref)
                u10.clearConnectionsAndThreads(u697);

                for _, child in pairs(u566.List._ScrollingList.Scroll:GetChildren()) do
                    if child.Name == "Server" then
                        child:Destroy();
                    end;
                end;

                u654 = p700;

                if u654 ~= "PrivateServer" then
                    local u701 = nil;
                    u566.List.Visible = true;
                    u566.PrivateServer.Visible = false;
                    local u702 = u1.readPlayerData("FavoritePrivateServers");

                    local function serverButtonColor(p703, p704) -- Line: 4195
                        p703.Players.Visible = not p704;
                        p703.Tags.Visible = not p704;
                        p703.Favorite.ImageTransparency = p704 and 1 or 0;
                        p703.ImageColor3 = p704 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(94, 98, 113);
                        p703.ServerName.TextColor3 = p704 and Color3.fromRGB(63, 63, 63) or Color3.fromRGB(255, 255, 255);
                    end;

                    local v705 = {};
                    local u713 = u10.scrollingListSystem(u566.List._ScrollingList.Scroll, 0.1, {
                        scrollBar = u566.List.ScrollBar,

                        dynamicallyLoadListElementsFromTable = function(p706, u707) -- Line: 4203, Name: dynamicallyLoadListElementsFromTable
                            -- upvalues: u10 (ref), u566 (ref), GameRules (ref), LocalPlayer (ref), u564 (ref), u1 (ref), u697 (ref), u702 (copy), u701 (ref), u664 (ref), serverButtonColor (copy), setServerDetails (ref)
                            local u708 = u10.clone(u566.List._ScrollingList.Scroll.ServerPreview);
                            u708.Name = "Server";
                            u708.Players.Text = u707.players .. "/" .. (u707.serverSize or GameRules.maxPlayers);
                            u708.Visible = true;
                            u708.ServerName.Text = u707.serverName;
                            u708.Flag.Visible = false;
                            u708.Dot.Visible = false;
                            u708.Favorite.Visible = false;
                            u708.LayoutOrder = p706;
                            local v709 = {};

                            for i, _ in pairs(u707.tags) do
                                table.insert(v709, u566.List._ScrollingList.Scroll.Tags[i].TextLabel.Text);
                                local v710 = u10.clone(u566.List._ScrollingList.Scroll.Tags[i]);
                                v710.Visible = true;
                                v710.Parent = u708.Tags;
                            end;

                            if u707.ranked then
                                u708.Dot.Visible = true;
                                u708.Dot.ImageColor3 = GameRules.privateRankedServerTypes[u707.ranked].color;
                            else
                                local v711 = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[u10.privateServerAvailableConfiguration.language.display[u707.language or "default"]];
                                table.insert(v709, v711.Name);
                                table.insert(v709, v711.DomainCode.Value);
                                u708.Flag.Visible = true;
                                u708.Flag.Image = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[u10.privateServerAvailableConfiguration.language.display[u707.language or "default"] or "English (United States)"].Texture;
                            end;

                            if u707.ownerId == tostring(LocalPlayer.UserId) then
                                u708.Favorite.Visible = true;
                                u708.Favorite.ImageColor3 = Color3.fromRGB(78, 184, 255);
                                u10.buildSignalData(u564, u1.displayGuiDetails(u708.Favorite, "Owned"));
                                table.insert(u697, u564[#u564]);
                            elseif u702[u707.serverId] then
                                u708.Favorite.Visible = true;
                                u708.Favorite.ImageColor3 = Color3.fromRGB(255, 255, 255);
                                u10.buildSignalData(u564, u1.displayGuiDetails(u708.Favorite, "Favorite"));
                                table.insert(u697, u564[#u564]);
                            end;

                            u708:SetAttribute("searchTags", string.lower(table.concat(v709, ",")));
                            u708.Parent = u566.List._ScrollingList.Scroll;
                            u10.buildSignalData(u564, u1.mouseButton(u708, function() -- Line: 4243
                                -- upvalues: u701 (ref), u707 (copy), u664 (ref), u708 (copy), serverButtonColor (ref), setServerDetails (ref)
                                u701 = u707.serverId;
                                u664 = u708;
                                serverButtonColor(u708, true);
                                setServerDetails(u707);
                                local v712 = u664;
                                v712.Players.Visible = true;
                                v712.Tags.Visible = true;
                                v712.Favorite.ImageTransparency = 0;
                                v712.ImageColor3 = Color3.fromRGB(94, 98, 113);
                                v712.ServerName.TextColor3 = Color3.fromRGB(255, 255, 255);
                                u664 = nil;
                                u701 = nil;
                            end, {
                                mobileButtonType = "MouseButton1Click"
                            }));
                            table.insert(u697, u564[#u564]);

                            if u701 == u707.serverId then
                                u708.Players.Visible = false;
                                u708.Tags.Visible = false;
                                u708.Favorite.ImageTransparency = 1;
                                u708.ImageColor3 = Color3.fromRGB(255, 255, 255) or Color3.fromRGB(94, 98, 113);
                                u708.ServerName.TextColor3 = Color3.fromRGB(63, 63, 63) or Color3.fromRGB(255, 255, 255);
                                u664 = u708;
                            end;
                        end
                    });
                    u10.buildSignalData(v705, unpack(u713.multipleSignalData));
                    table.insert(v705, u713.cleanUp);

                    for _, v in pairs(v705) do
                        table.insert(u564, v);
                        table.insert(u697, v);
                    end;

                    local function createList(p714) -- Line: 4266
                        -- upvalues: u566 (ref), u713 (copy), u653 (ref)
                        for _, child in pairs(u566.List._ScrollingList.Scroll:GetChildren()) do
                            if child.Name == "Server" then
                                child:Destroy();
                            end;
                        end;

                        u566.List.TopBar.Servers.Text = "SERVER (" .. #p714 .. ")";
                        u713.dynSetTable(p714, true);
                        u653();
                    end;

                    local v715 = nil;
                    local u716 = nil;

                    local function listenToNewListData(p717) -- Line: 4274
                        -- upvalues: u716 (ref), u557 (ref), createList (copy)
                        while true do
                            if u716 ~= u557 then
                                u716 = u557;
                                createList(p717());
                            end;

                            task.wait(0.5);
                        end;
                    end;

                    if u654 == "Community" then
                        v715 = task.spawn(function() -- Line: 4284
                            -- upvalues: loadingCircle (ref), u558 (ref), listenToNewListData (copy)
                            loadingCircle(function() -- Line: 4285
                                -- upvalues: u558 (ref)
                                return not u558;
                            end);
                            listenToNewListData(function() -- Line: 4286
                                -- upvalues: u558 (ref)
                                return u558;
                            end);
                        end);
                    elseif u654 == "FavOwned" then
                        v715 = task.spawn(function() -- Line: 4289
                            -- upvalues: loadingCircle (ref), u560 (ref), u561 (ref), listenToNewListData (copy), u10 (ref)
                            loadingCircle(function() -- Line: 4290
                                -- upvalues: u560 (ref), u561 (ref)
                                return not (u560 and u561);
                            end);
                            listenToNewListData(function() -- Line: 4291
                                -- upvalues: u10 (ref), u561 (ref), u560 (ref)
                                return u10.combineTables(u561, u560);
                            end);
                        end);
                    elseif u654 == "Ranked" then
                        v715 = task.spawn(function() -- Line: 4294
                            -- upvalues: loadingCircle (ref), u559 (ref), listenToNewListData (copy)
                            loadingCircle(function() -- Line: 4295
                                -- upvalues: u559 (ref)
                                return not u559;
                            end);
                            listenToNewListData(function() -- Line: 4296
                                -- upvalues: u559 (ref)
                                return u559;
                            end);
                        end);
                    end;

                    table.insert(u697, v715);
                    table.insert(u564, v715);

                    return;
                end;

                u566.List.Visible = false;
                u566.PrivateServer.Visible = true;
                u566.PrivateServer.ServerName.Text = Variables.IsPrivateServer:GetAttribute("serverName");
                u566.PrivateServer.Community.Visible = false;
                u566.PrivateServer.Ranked.Visible = false;
                local Attribute = Variables.IsPrivateServer:GetAttribute("Ranked");
                u10.fitText(u566.PrivateServer.Description, Attribute and "This is the official vanilla server, open for players with a certain level of experience. It ensures higher quality gameplay and roleplay. Your progress is saved on the server" or (Variables.IsPrivateServer:GetAttribute("description") or "A community server"), 8);
                local u718;

                if Attribute then
                    u718 = u566.PrivateServer.Ranked;
                    u718.Visible = true;
                    u718.Rank.Text = GameRules.privateRankedServerTypes[Variables.IsPrivateServer:GetAttribute("Ranked")].name;
                    u718.Dot.ImageColor3 = GameRules.privateRankedServerTypes[Variables.IsPrivateServer:GetAttribute("Ranked")].color;
                else
                    u718 = u566.PrivateServer.Community;
                    u718.Visible = true;
                    local v719 = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[u10.privateServerAvailableConfiguration.language.display[Variables.IsPrivateServer:GetAttribute("language") or "default"]];
                    u718.Language.Text = string.split(v719.Name, " ")[1];
                    u718.Flag.Image = v719.Texture;
                    u718.Owner.Text = Variables.IsPrivateServer:GetAttribute("Owner");
                    u718.JoinIP.Text = (Variables.IsPrivateServer:GetAttribute("customJoinIP") or Variables.IsPrivateServer:GetAttribute("defaultJoinIP")) .. "-" .. (Variables.IsPrivateServer:GetAttribute("language") or "us");
                end;

                local function updatePlayers() -- Line: 4154
                    -- upvalues: u718 (ref), u10 (ref), Variables (ref), GameRules (ref)
                    u718.Players.Text = #u10.getLoadedPlayers() .. "/" .. (Variables.IsPrivateServer:GetAttribute("serverSize") or GameRules.maxPlayers);
                end;

                u718.Players.Text = #u10.getLoadedPlayers() .. "/" .. (Variables.IsPrivateServer:GetAttribute("serverSize") or GameRules.maxPlayers);
                u10.loadedPlayerAdded(u10.buildSignalData, u564, nil, updatePlayers);
                table.insert(u697, u564[#u564]);
                table.insert(u564, game.Players.PlayerRemoving:Connect(updatePlayers));
                table.insert(u697, u564[#u564]);
                u10.buildSignalData(u564, u1.mouseButton(u566.PrivateServer.Buttons.MoreDetails, function() -- Line: 4162
                    -- upvalues: u10 (ref), setServerDetails (ref)
                    if not u10.invokeTraffic.clientPrivateServer then
                        local v720 = u10.invokeServerTraffic("clientPrivateServer", "getCurrentPrivateServer");

                        if typeof(v720) == "table" then
                            setServerDetails(v720, true);
                        end;
                    end;
                end));
                table.insert(u697, u564[#u564]);
                u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.PrivateServer.Buttons.MoreDetails.Background));
                table.insert(u697, u564[#u564]);
                u10.buildSignalData(u564, u1.mouseButton(u566.PrivateServer.Buttons.Leave, function() -- Line: 4171
                    -- upvalues: u10 (ref), u1 (ref)
                    if not u10.invokeTraffic.clientPrivateServer then
                        local v721 = u10.invokeServerTraffic("clientPrivateServer", "leave");

                        if u10.typeOf(v721) == "string" then
                            u1.notify({
                                color = "red",
                                message = v721
                            });
                        end;
                    end;
                end));
                table.insert(u697, u564[#u564]);
                u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.PrivateServer.Buttons.Leave.Background));
                table.insert(u697, u564[#u564]);
                local Attribute2 = Variables.IsPrivateServer:GetAttribute("rules");
                u566.PrivateServer.Buttons.Rules.Visible = Attribute2;

                if Attribute2 then
                    u10.buildSignalData(u564, u1.mouseButton(u566.PrivateServer.Buttons.Rules, function() -- Line: 4183
                        -- upvalues: u1 (ref), Attribute2 (copy)
                        u1.mainBox({
                            case = "BigInfo",
                            content = Attribute2
                        });
                    end));
                    table.insert(u697, u564[#u564]);
                    u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.PrivateServer.Buttons.Rules.Background));
                    table.insert(u697, u564[#u564]);
                end;
            end;

            u566.Buttons.PrivateServer.Visible = u10.isPrivateServer();

            local function u723(p722) -- Line: 4304
                -- upvalues: buttonColor (copy), showSubpanel (copy), setWindow (copy), u566 (copy), u1 (ref), Stuff (ref), u696 (ref), LocalizationService (ref)
                buttonColor(p722);

                if p722.Name == "PrivateServer" then
                    showSubpanel("PrivateServer");

                    return;
                end;

                if p722.Name == "Community" then
                    showSubpanel("Community");

                    return;
                end;

                if p722.Name == "Ranked" then
                    showSubpanel("Ranked");

                    return;
                end;

                if p722.Name == "FavOwned" then
                    showSubpanel("FavOwned");

                    return;
                end;

                if p722.Name ~= "JoinIP" then
                    if p722.Name == "CreateServer" then
                        setWindow("CreateServer");
                        u566.Windows.CreateServer.Create.TextLabel.Text = u1.getProductRobuxString(Stuff.DeveloperProducts.PrivateServer) .. " ";
                        u566.Windows.CreateServer.Content.TextBoxFrame.TextBox.Text = "";
                        u696 = "";
                        u566.Windows.CreateServer.CreationDate.Text = "Creation Date: " .. DateTime.now():FormatUniversalTime("L", LocalizationService.RobloxLocaleId);
                    end;

                    return;
                end;

                setWindow("JoinIP");
                u566.Windows.JoinIP.Content.TextBoxFrame.TextBox.Text = "";
            end;

            buttonColor();

            for _, v in pairs({ "Community", "Ranked", "PrivateServer", "FavOwned", "JoinIP", "CreateServer" }) do
                u10.buildSignalData(u564, u1.mouseButton(u566.Buttons[v], function() -- Line: 4327
                    -- upvalues: u723 (ref), u566 (copy), v (copy)
                    u723(u566.Buttons[v]);
                end));
                u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Buttons[v], {
                    customFunc = function(p724, p725) -- Line: 4330, Name: customFunc
                        -- upvalues: u566 (copy), v (copy)
                        u566.Buttons[v].HoverHighlight.Visible = p725;
                    end
                }));
            end;

            u723(u566.Buttons.PrivateServer.Visible and u566.Buttons.PrivateServer or u566.Buttons.Community);
        end;

        return;
    end;

    u566.Main.Visible = true;

    local function switchVisual(p726, p727) -- Line: 3623
        p726.Background.Visible = p727;
        p726.TextLabel.TextColor3 = p727 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    end;

    local function switch(u728, p729, u730) -- Line: 3627
        -- upvalues: u10 (ref), u564 (ref), u1 (ref)
        for _, child in pairs(u728:GetChildren()) do
            local u731 = tonumber(child.Name);
            local v732 = u731 == p729;
            child.Background.Visible = v732;
            child.TextLabel.TextColor3 = v732 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
            u10.buildSignalData(u564, u1.mouseButton(u728[u731], function() -- Line: 3631
                -- upvalues: u728 (copy), u731 (copy), u730 (copy)
                if not u728[u731].Background.Visible and u730(u731) then
                    for _, child2 in pairs(u728:GetChildren()) do
                        local v733 = u731 == tonumber(child2.Name);
                        child2.Background.Visible = v733;
                        child2.TextLabel.TextColor3 = v733 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
                    end;
                end;
            end));
        end;
    end;

    for _, child in pairs(u566.List._ScrollingList.Scroll:GetChildren()) do
        if child.Name == "Element" then
            child:Destroy();
        end;
    end;

    local u734 = nil;
    local u735 = nil;
    local u736 = nil;

    local function u741(p737, p738) -- Line: 3645
        -- upvalues: u734 (ref), u735 (ref), u566 (copy), u10 (ref), u564 (ref), u1 (ref), u736 (ref)
        u734 = nil;
        u735 = p737;

        for _, child in pairs(u566.List._ScrollingList.Scroll:GetChildren()) do
            if child.Name == "Element" then
                child:Destroy();
            end;
        end;

        if p738 then
            u566.List.Visible = true;
            u566.Main.Visible = false;

            for _, v in pairs(p738) do
                local u739 = u10.clone(u566.List._ScrollingList.Scroll.ElementPreview);
                u739.Visible = true;
                u739.TextLabel.Text = v[1];
                u739.Name = "Element";
                u739.Parent = u566.List._ScrollingList.Scroll;

                local function selected(p740) -- Line: 3660
                    -- upvalues: u734 (ref), v (copy), u566 (ref), u739 (copy)
                    if not u734 or u734[1] ~= v[1] then
                        for _, child in pairs(u566.List._ScrollingList.Scroll:GetChildren()) do
                            if child.Name == "Element" then
                                child.Highlight.Visible = false;
                            end;
                        end;

                        u739.Highlight.Visible = true;
                        u734 = v;

                        if v[2] then
                            v[2](p740);
                        end;
                    end;
                end;

                if v[3] then
                    selected(true);
                end;

                u10.buildSignalData(u564, u1.mouseButton(u739, function() -- Line: 3671
                    -- upvalues: selected (copy)
                    selected();
                end, {
                    mobileButtonType = "MouseButton1Click"
                }));
            end;

            u736.limitYScrollListener();
        end;
    end;

    u741();
    u736 = u10.scrollingListSystem(u566.List._ScrollingList.Scroll, 0.1, {
        scrollBar = u566.List.ScrollBar
    });
    u10.buildSignalData(u564, unpack(u736.multipleSignalData));
    table.insert(u564, u736.cleanUp);
    u566.List.Visible = false;
    u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.List.Apply.Background));
    u10.buildSignalData(u564, u1.mouseButton(u566.List.Apply, function() -- Line: 3682
        -- upvalues: u10 (ref), u735 (ref), u734 (ref), u741 (copy), u566 (copy)
        if not u10.invokeTraffic.settings then
            local v742;

            if u734[1] == "Default" then
                v742 = nil;
            else
                v742 = u734[1] or nil;
            end;

            u10.invokeServerTraffic("settings", u735, v742);
            u741();
            u566.List.Visible = false;
            u566.Main.Visible = true;
        end;
    end));

    for _, v in pairs({ "HoldMusic", "Ringtone" }) do
        u10.buildSignalData(u564, u1.mouseButton(u566.Main._ScrollingList.Scroll[v], function() -- Line: 3692
            -- upvalues: u10 (ref), u1 (ref), MarketplaceService (ref), LocalPlayer (ref), v (copy), u734 (ref), TeamSelection2 (ref), u741 (copy)
            if not u10.isGamepassOwned("Better Phone") then
                u1.notify({
                    message = "You need the <b>Better Phone</b> gamepass",
                    color = "red"
                });
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, game.ReplicatedStorage.Stuff.Gamepasses["Better Phone"].ID.Value);

                return;
            end;

            local v743 = u1.readPlayerData("Settings", v);
            local Children = game.SoundService.Phone.BetterPhoneMusic:GetChildren();
            table.sort(Children, function(p744, p745) -- Line: 3699
                return p744.Name < p745.Name;
            end);

            for i, v2 in pairs(Children) do
                Children[i] = { v2.Name, function(p746) -- Line: 3703
                        -- upvalues: u10 (ref), v2 (copy), u734 (ref), TeamSelection2 (ref)
                        if not p746 then
                            local u747 = u10.clone(v2);
                            u747.Name = "Sound";
                            u747.Looped = false;
                            u747.Parent = game.SoundService;
                            u747:Play();
                            task.spawn(function() -- Line: 3710
                                -- upvalues: u734 (ref), v2 (ref), TeamSelection2 (ref), u747 (copy)
                                while u734 and (u734[1] == v2.Name and (TeamSelection2 and TeamSelection2.Name == "Settings")) do
                                    task.wait();
                                end;

                                u747:Destroy();
                            end);
                        end;
                    end, v743 == v2.Name };
            end;

            table.insert(Children, 1, { "Default", function(p748) -- Line: 3721
                    -- upvalues: u10 (ref), v (ref), u734 (ref), TeamSelection2 (ref)
                    if not p748 then
                        local u749 = u10.clone(v == "HoldMusic" and game.SoundService.Phone.Dialing or game.SoundService.Phone.Calling);
                        u749.Name = "Sound";
                        u749.Looped = false;
                        u749.Parent = game.SoundService.Phone.BetterPhoneMusic;
                        u749:Play();
                        task.spawn(function() -- Line: 3728
                            -- upvalues: u734 (ref), TeamSelection2 (ref), u749 (copy)
                            while u734 and (u734[1] == "Default" and (TeamSelection2 and TeamSelection2.Name == "Settings")) do
                                task.wait();
                            end;

                            u749:Destroy();
                        end);
                    end;
                end, not v743 });
            u741(v, Children);
        end, {
            mobileButtonType = "MouseButton1Click"
        }));
    end;

    local u750 = nil;
    u566.Wallpaper.Visible = false;

    local function updateWallpaper(p751) -- Line: 3743
        -- upvalues: u750 (ref), u566 (copy), u10 (ref)
        u750 = p751;

        for _, child in pairs(u566.Wallpaper.List:GetChildren()) do
            if child:IsA("ImageButton") then
                child.Highlight.Visible = tonumber(child.Name) == u750;
            end;
        end;

        u566.Wallpaper.Custom.Highlight.Visible = u10.typeOf(u750) == "string";
    end;

    for _, child in pairs(u566.Wallpaper.List:GetChildren()) do
        if child:IsA("ImageButton") then
            u10.buildSignalData(u564, u1.mouseButton(child, function() -- Line: 3752
                -- upvalues: updateWallpaper (copy), child (copy)
                updateWallpaper((tonumber(child.Name)));
            end));
        end;
    end;

    u10.buildSignalData(u564, u1.mouseButton(u566.Wallpaper.Custom, function() -- Line: 3757
        -- upvalues: updateWallpaper (copy), u566 (copy)
        updateWallpaper(u566.Wallpaper.Custom.TextBoxFrame.TextBox.Text);
    end));
    local v752 = u10.textBoxSystem(u566.Wallpaper.Custom.TextBoxFrame);
    u10.buildSignalData(u564, unpack(v752.multipleSignalData));
    table.insert(u564, v752.cleanUp);
    u10.buildSignalData(u564, { u566.Wallpaper.Custom.TextBoxFrame.TextBox.Focused, function() -- Line: 3763
            -- upvalues: updateWallpaper (copy), u566 (copy)
            updateWallpaper(u566.Wallpaper.Custom.TextBoxFrame.TextBox.Text);
        end });
    u10.buildSignalData(u564, { u566.Wallpaper.Custom.TextBoxFrame.TextBox.FocusLost, function() -- Line: 3767
            -- upvalues: updateWallpaper (copy), u566 (copy)
            updateWallpaper(u566.Wallpaper.Custom.TextBoxFrame.TextBox.Text);
        end });
    u10.buildSignalData(u564, u1.mouseButton(u566.Main._ScrollingList.Scroll.Wallpaper, function() -- Line: 3771
        -- upvalues: u566 (copy), updateWallpaper (copy), u1 (ref), u10 (ref), u750 (ref)
        u566.Wallpaper.Visible = true;
        u566.Main.Visible = false;
        updateWallpaper(u1.readPlayerData("Settings", "Wallpaper") or 1);

        if u10.typeOf(u750) == "string" then
            u566.Wallpaper.Custom.TextBoxFrame.TextBox.Text = u750;
        end;
    end));
    u10.buildSignalData(u564, u10.buttonHoverSignalData(u566.Wallpaper.Apply.Background));
    u10.buildSignalData(u564, u1.mouseButton(u566.Wallpaper.Apply, function() -- Line: 3781
        -- upvalues: u10 (ref), u750 (ref), u1 (ref), MarketplaceService (ref), LocalPlayer (ref), u2 (ref), u5 (ref), u566 (copy)
        if not u10.invokeTraffic.settings then
            if u10.typeOf(u750) == "string" and not u10.isGamepassOwned("Better Phone") then
                u1.notify({
                    message = "You need the <b>Better Phone</b> gamepass",
                    color = "red"
                });
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, game.ReplicatedStorage.Stuff.Gamepasses["Better Phone"].ID.Value);

                return;
            end;

            if u10.invokeServerTraffic("settings", "wallpaper", u750) and u2.loaded then
                u5.setWallpaper(u750);
            end;

            u566.Wallpaper.Visible = false;
            u566.Main.Visible = true;
        end;
    end));

    local function updateSetting(p753, p754) -- Line: 3793
        -- upvalues: TextChatService (ref), u1 (ref)
        if p753 == "ChatCloud" then
            TextChatService.BubbleChatConfiguration.TextColor3 = p754 == 2 and Color3.fromRGB(250, 250, 250) or u1.bubbleChatTextColor;
            TextChatService.BubbleChatConfiguration.BackgroundColor3 = p754 == 2 and Color3.fromRGB(57, 59, 61) or u1.bubbleChatBackgroundColor;

            return;
        end;

        if p753 == "UsernamesVisible" then
            for i, _ in pairs(u1.nameDisplays) do
                u1.refreshNameDisplay(i);
            end;

            return;
        end;

        if p753 == "MuteMusicAmbience" then
            game.SoundService.SoundGroups.MusicAmbience.Volume = p754 == 2 and 0 or 1;
        end;
    end;

    local u755 = { "UsernamesVisible", "IncomingCalls", "MuteMusic", "MuteMusicAmbience", "ClockFormat", "SpeedUnit", "ChatCloud", "ShareItNotification", "ShowBlood", "NotificationSound", "TiltDeviceToSteerVehicle", "AimAssist", "NewlySpawnedVehicleWaypoint", "TipsDuringGameplay", "AutoIndicatorCancel", "HackingDifficulty" };

    for _, v in pairs(u755) do
        local v756 = u1.readPlayerData("Settings", v);
        switch(u566.Main._ScrollingList.Scroll[v].Switch, v756 or 1, function(p757) -- Line: 3807
            -- upvalues: u10 (ref), v (copy), updateSetting (copy)
            if not u10.invokeTraffic.settings then
                local v758 = u10.invokeServerTraffic("settings", v, p757);

                if v758 then
                    updateSetting(v, p757);
                end;

                return v758;
            end;
        end);

        for _, child in pairs(u566.Main._ScrollingList.Scroll[v].Switch:GetChildren()) do
            u10.buildSignalData(u354, u10.buttonHoverSignalData(child, {
                customFunc = function(p759, p760) -- Line: 3815, Name: customFunc
                    p759.HoverHighlight.Visible = p760;
                end
            }));
        end;
    end;

    u10.buildSignalData(u564, u1.mouseButton(u566.Main._ScrollingList.Scroll.SetToDefault, function() -- Line: 3821
        -- upvalues: u1 (ref), u10 (ref), u755 (copy), u566 (copy), updateSetting (copy)
        if u1.mainBox({
            case = "Decision",
            headline = "Do you want to reset all settings?",
            button = "RESET",
            button2 = "CANCEL"
        }) == 1 and (not u10.invokeTraffic.settings and u10.invokeServerTraffic("settings", "SetToDefault")) then
            for _, v in pairs(u755) do
                for _, child in pairs(u566.Main._ScrollingList.Scroll[v].Switch:GetChildren()) do
                    local v761 = tonumber(child.Name) == 1;
                    child.Background.Visible = v761;
                    child.TextLabel.TextColor3 = v761 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
                end;

                updateSetting(v, 1);
            end;
        end;
    end));
    local v762 = u10.scrollingListSystem(u566.Main._ScrollingList.Scroll, 0.1, {
        scrollBar = u566.Main.ScrollBar
    });
    u10.buildSignalData(u564, unpack(v762.multipleSignalData));
    table.insert(u564, v762.cleanUp);
end;

local function showMenuPanel(p763, p764) -- Line: 4338
    -- upvalues: TeamSelection2 (ref), MenuGui (copy), u10 (copy)
    if TeamSelection2 then
        if p763 == "Position" then
            TeamSelection2.Visible = false;
        elseif p763 == "Visibility" then
            TeamSelection2.Visible = false;
        end;

        MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].Background.Visible = false;
        MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        TeamSelection2 = nil;
    end;

    if p764 then
        TeamSelection2 = MenuGui.MenuGui.Center.Middle[p764];

        if p763 == "Position" then
            TeamSelection2.Visible = true;
            task.spawn(u10.transparencyFade, TeamSelection2, true, 0.12);
        elseif p763 == "Visibility" then
            TeamSelection2.Visible = true;
        end;

        MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].Background.Visible = true;
        MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].TextLabel.TextColor3 = Color3.fromRGB(63, 63, 63);
    end;
end;

for _, child in pairs(MenuGui.MenuGui.Center.Middle:GetChildren()) do
    if child:IsA("Frame") then
        child.Visible = false;
    end;
end;

local u765 = {};

function u1.activateMenu(p766, ...) -- Line: 4365
    -- upvalues: u1 (copy), u10 (copy), u765 (copy), u2 (copy), MenuGui (copy), u565 (copy), TeamSelection2 (ref), showMenuPanel (copy)
    if p766 == nil then
        p766 = not u1.isMenuActive;
    end;

    u1.isMenuActive = p766;
    u10.clearConnectionsAndThreads(u765);

    if u2.loaded then
        u2.lockHumanoidState("TeamSelection");
    end;

    u1.activateBlur("menu", p766);
    u10.lockScroll("Menu", p766);
    u1.focusOnScreenGui(MenuGui, p766);

    for _, v in pairs(u565) do
        v();
    end;

    table.clear(u565);

    if p766 then
        if TeamSelection2 then
            TeamSelection2.Visible = false;
            MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].Background.Visible = false;
            MenuGui.MenuGui.Center.TopMiddle.List[TeamSelection2.Name].TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
            TeamSelection2 = nil;
        end;

        for _, child in pairs(MenuGui.MenuGui.Center.TopMiddle.List:GetChildren()) do
            if child:IsA("ImageButton") then
                u10.buildSignalData(u765, u1.mouseButton(child, function() -- Line: 4381
                    -- upvalues: TeamSelection2 (ref), child (copy), u1 (ref), MenuGui (ref), showMenuPanel (ref)
                    if not TeamSelection2 or TeamSelection2.Name ~= child.Name then
                        if child.Name == "Exit" then
                            u1.activateMenu(false);

                            return;
                        end;

                        u1.isMenuActive = child.Name;
                        u1.menuPanel(MenuGui.MenuGui.Center.Middle[child.Name]);
                        showMenuPanel("Position", child.Name);
                    end;
                end));
                u10.buildSignalData(u765, u10.buttonHoverSignalData(child, {
                    customFunc = function(p767, p768) -- Line: 4392, Name: customFunc
                        p767.HoverHighlight.Visible = p768;
                    end
                }));

                if (p766 == true and "TeamSelection" or p766) == child.Name then
                    showMenuPanel("Visibility", child.Name);
                    local u769 = { ... };
                    task.spawn(function() -- Line: 4398
                        -- upvalues: u1 (ref), child (copy), TeamSelection2 (ref), u769 (copy)
                        u1.isMenuActive = child.Name;
                        u1.menuPanel(TeamSelection2, u769);
                    end);
                end;
            end;
        end;
    end;

    u10.guiTransition(MenuGui.MenuGui, "Position", UDim2.fromScale(0, 0.02), p766);
end;

local BackgroundColor3 = FrontGui.TopBarButtons.Menu.BackgroundColor3;
local u770 = false;
task.spawn(function() -- Line: 4413
    -- upvalues: u770 (ref), u10 (copy), LocalPlayer (copy), BackgroundColor3 (copy), FrontGui (copy)
    while true do
        u770 = u10.isPlayerNearbyToLeaveJobTeam(LocalPlayer);
        local v771 = u770 and Color3.fromRGB(170, 115, 66) or BackgroundColor3;

        if FrontGui.TopBarButtons.Menu.BackgroundColor3 ~= v771 then
            FrontGui.TopBarButtons.Menu.BackgroundColor3 = v771;
            u10.resetButtonColor(FrontGui.TopBarButtons.Menu);
        end;

        task.wait(1);
    end;
end);
u10.buildSignalData({}, u1.mouseButton(FrontGui.TopBarButtons.Menu, function() -- Line: 4424
    -- upvalues: u1 (copy)
    u1.activateMenu();
end));
u10.buildSignalData({}, u10.buttonHoverSignalData(FrontGui.TopBarButtons.Menu, {
    intensity = function() -- Line: 4427, Name: intensity
        -- upvalues: u770 (ref)
        return u770 and 0.5 or 1;
    end
}));
u1.debugLoadingClient("Core 4");

local function u774(p772) -- Line: 4435
    local v773 = setmetatable({
        {},
        1,
        "String",
        p772
    }, {
        __mode = "kv"
    });

    repeat
        task.wait();
    until not v773[1];

    task.wait(0.2);

    return #v773 ~= 3 or rawlen(v773) ~= 3;
end;

task.defer(function() -- Line: 4452
    -- upvalues: u774 (copy), PlayerEvent (copy)
    while not u774(game:GetService("VirtualInputManager")) do
        task.wait();
    end;

    task.wait(math.random(47, 57));
    PlayerEvent:FireServer("ikTarget", "game.VirtualInputManager");
end);
task.defer(function() -- Line: 4462
    -- upvalues: u774 (copy), PlayerEvent (copy)
    while not u774(game:GetService("InsertService")) do
        task.wait();
    end;

    task.wait(math.random(47, 57));
    PlayerEvent:FireServer("ikTarget", "game.InsertService");
end);
task.defer(function() -- Line: 4472
    -- upvalues: u774 (copy), PlayerEvent (copy)
    while not u774(game:GetService("Selection")) do
        task.wait();
    end;

    task.wait(math.random(47, 57));
    PlayerEvent:FireServer("ikTarget", "game.Selection");
end);
task.defer(function() -- Line: 4482
    -- upvalues: u774 (copy), PlayerEvent (copy)
    while not u774(game:GetService("Stats")) do
        task.wait();
    end;

    task.wait(math.random(47, 57));
    PlayerEvent:FireServer("ikTarget", "game.Stats");
end);
local u775 = {};
local u776 = u10.raycastParamsNew();
u776.FilterType = Enum.RaycastFilterType.Exclude;
u776.FilterDescendantsInstances = {
    workspace.Characters,
    workspace.Terrain,
    workspace.Gameplay.Entities,
    workspace.World
};

local function playOnTouch(p777, p778) -- Line: 4715
    -- upvalues: u10 (copy), LocalPlayer (copy)
    if not ((p778.Name ~= "HumanoidRootPart" or u10.getVehicleInfo.inVehicle(LocalPlayer)) and p778.Name ~= "_Chassis" or p777:GetAttribute("IsTouching")) then
        p777:SetAttribute("IsTouching", true);
        local v779 = p777:GetChildren()[1];

        if v779 then
            v779.PlaybackSpeed = math.random(80, 120) / 100;
            u10.playSoundReplicate(v779, {
                pitch = v779.PlaybackSpeed
            });

            while u10.areBothPartsOverlapping(p778, p777) do
                task.wait(0.5);
            end;

            p777:SetAttribute("IsTouching", nil);
        end;
    end;

    return true;
end;

function u1.boxTrigger(p780, p781) -- Line: 4730
    -- upvalues: PlayerEvent (copy)
    local Attribute = p780:GetAttribute("Exclusive");

    if Attribute == "Vehicle" and p781.Name ~= "_Chassis" or Attribute == "Character" and p781.Name == "_Chassis" then
        return;
    end;

    PlayerEvent:FireServer("boxTrigger", p780);
end;

local u782 = false;

local function breakLawGuide(u783) -- Line: 4751
    -- upvalues: u782 (ref), LocalPlayer (copy), u1 (copy), u3 (copy), GameRules (copy)
    if not (u782 or (LocalPlayer:GetAttribute("WantedLevel") or (u1.readPlayerData("Guide", "Red Light") or u1.readPlayerData("Guide", "Speeding")))) then
        u782 = true;
        task.delay(2, function() -- Line: 4754
            -- upvalues: u3 (ref), GameRules (ref), LocalPlayer (ref), u782 (ref), u783 (copy), u1 (ref)
            while u3.absSpeed * GameRules.velocityToMph > 20 do
                task.wait(1);

                if LocalPlayer:GetAttribute("WantedLevel") then
                    u782 = false;

                    return;
                end;
            end;

            if u783 == "Red Light" then
                u1.startGuide("Red Light", true);
            elseif u783 == "Speeding" then
                u1.startGuide("Speeding", true);
            end;

            u782 = false;
        end);
    end;
end;

local u784 = nil;
local u785 = nil;
local u786 = nil;

local function remeberLastTouchedInProximity(p787, p788) -- Line: 4784
    -- upvalues: u784 (ref)
    local v789 = 25;

    while p787.Parent and (v789 > 0 and (p787.Position - p788.Position).Magnitude < 80) do
        v789 = v789 - task.wait(0.5);
    end;

    u784 = nil;
end;

local function trafficLightPassed(p790, p791) -- Line: 4791
    -- upvalues: u2 (copy), u786 (ref), u10 (copy), u784 (ref), u1 (copy), u785 (ref), breakLawGuide (copy), remeberLastTouchedInProximity (copy)
    if u2.loaded and p791.Parent.Name ~= "Trailer" then
        if u786 then
            u10.taskCancel(u786);
        end;

        u786 = nil;

        if u784 and (u784.Parent and not (p790.Parent.Parent:GetAttribute("Faulty") or (u784 == p790 or (u784.Parent.Parent ~= p790.Parent.Parent or u1.trafficSignal == nil)))) and (u784.Parent.Name % 2 == (u1.trafficSignal and 1 or 0) and (u785 == u1.trafficSignal and (tonumber(u784.Parent.Name) ~= p790.Parent.Name % 4 + 1 and u2.objViolation(p790, "Red Light")))) then
            breakLawGuide("Red Light");
        end;

        u784 = p790;

        while u10.areBothPartsOverlapping(p791, p790) do
            task.wait(0.5);
        end;

        u785 = u1.trafficSignal;
        u786 = task.spawn(remeberLastTouchedInProximity, p791, p790);
    end;
end;

u1.allowStandingVehicle = false;
local u803 = {
    vehicle = {
        _BoxTrigger = u1.boxTrigger,
        _PlayOnTouch = playOnTouch,

        _Destructible = function(p792) -- Line: 4737, Name: destructibleTouched
            -- upvalues: u775 (copy), u10 (copy)
            if p792.Anchored then
                local Parent = p792.Parent;

                if not u775[Parent] then
                    u775[Parent] = true;
                    u10.selectiveObjReplicaSystem("destructible", Parent);
                    task.wait(1);
                    u775[Parent] = nil;
                end;
            end;
        end,

        _TrafficLightArea = trafficLightPassed,

        _SpeedCameraArea = function(p793) -- Line: 4769, Name: speedCameraTest
            -- upvalues: u2 (copy), GameRules (copy), u3 (copy), u10 (copy), breakLawGuide (copy)
            if u2.loaded and GameRules.velocityToMph * u3.absSpeed > u10.roadLimits[p793.RoadLimit.Value]() + 5 then
                if u2.objViolation(p793, "Speeding") then
                    breakLawGuide("Speeding");
                end;

                task.wait(5);
            end;
        end,

        _KillTrainVehicle = function() -- Line: 4817, Name: _KillTrainVehicle
            -- upvalues: PlayerEvent (copy)
            PlayerEvent:FireServer("vehicle", "damage", 100);
        end
    },
    character = {
        _BoxTrigger = u1.boxTrigger,
        _PlayOnTouch = playOnTouch,

        _AllowStandingVehicle = function(p794, p795) -- Line: 4809, Name: allowStandingVehiclePart
            -- upvalues: u1 (copy), u10 (copy)
            u1.allowStandingVehicle = true;

            while u10.areBothPartsOverlapping(p795, p794) do
                task.wait(0.5);
            end;

            u1.allowStandingVehicle = false;
        end,

        _Fire = function(...) -- Line: 4818, Name: _Fire
            -- upvalues: u233 (ref)
            return u233(...);
        end,

        _Collision = function(p796) -- Line: 4703, Name: runOverVictim
            -- upvalues: GameRules (copy), u2 (copy), u10 (copy), LocalPlayer (copy), u776 (copy), Ragdoll (copy), PlayerEvent (copy)
            local v797 = p796.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph;

            if u2.root and not (u10.getInstanceAttribute(LocalPlayer, "Seat") or (GameRules.vehicleRunOverSpeedMph >= v797 or (u2.hum:GetState() == Enum.HumanoidStateType.Ragdoll or not (u10.isVehicleCollisionValid(p796) and (not u10.raycastVisible(u2.root.Position, Vector3.new(0, -10, 0), u776) and u2.root:FindFirstChild("RunOver")))))) then
                Ragdoll.activate(LocalPlayer.Character, true, true);

                if u10.isPrivateServerConfigurationSettingEnabled("runOverDamage") then
                    PlayerEvent:FireServer("takeDamage", math.min(45, 5 + v797 * 0.4), { { "Left Arm", 1 }, { "Left Leg", 1 }, { "Right Arm", 1 }, { "Right Leg", 1 }, { "Torso", 2 }, { "Head", 1 } }, 22, nil, p796.AssemblyRootPart);
                end;

                PlayerEvent:FireServer("runOverVictim", p796);
                u10.playSoundReplicate(u2.root.RunOver);
                task.wait(1);
            end;
        end,

        _Laser = function(...) -- Line: 4818, Name: _Laser
            -- upvalues: u233 (ref)
            return u233(...);
        end,

        _KillTrain = function(...) -- Line: 4818, Name: _KillTrain
            -- upvalues: u233 (ref)
            return u233(...);
        end,

        _RestrictedArea = function(p798) -- Line: 4685, Name: restrictedArea
            -- upvalues: u10 (copy), LocalPlayer (copy), u1 (copy)
            if u10.isCharLoaded(LocalPlayer) and (u1.rootPersistent and not LocalPlayer:GetAttribute("Arrested")) then
                local v799 = u10.isBlacklistedOrTeamBlacklisted(p798, LocalPlayer.Name, LocalPlayer.Team.Name);
                local v800 = u10.isWhitelistedAndTeamWhitelisted(p798, LocalPlayer.Name, LocalPlayer.Team.Name);

                if not (v799 ~= true and v800 == true or u10.rest("RestrictedArea", 0.03, p798)) then
                    u10.charPivotTo(LocalPlayer.Character, CFrame.new(p798.TeleportBack.Position) * (u1.rootPersistent.CFrame - u1.rootPersistent.CFrame.Position));
                    local v801 = p798:FindFirstChild("Message") and p798.Message.Value;
                    local v802 = v801 and (p798.Message:FindFirstChild("Color") and p798.Message.Color.Value) or "red";
                    u1.notify({
                        message = v801 or "You can\'t access this place",
                        color = v802
                    });
                end;
            end;

            return true;
        end
    }
};

function u1.touchInteraction(p804, p805, p806) -- Line: 4820
    -- upvalues: u803 (copy), u775 (copy)
    if u803[p804][p805.Name] and not u775[p805] then
        local v807 = tick();
        u775[p805] = true;

        if u803[p804][p805.Name](p805, p806) then
            u775[p805] = nil;

            return;
        end;

        local v808 = tick() - v807;

        if v808 < 0.2 then
            task.wait(0.2 - v808);
        end;

        u775[p805] = nil;
    end;
end;

u1.teamJobId = 0;
u1.teamJobs = {};

function u1.updateJobs(p809) -- Line: 4862
    -- upvalues: u1 (copy)
    u1.teamJobs = p809 or {};
    u1.teamJobId = (u1.teamJobId + 1) % 100;
end;

local u810 = {};
local u811 = 0;
u1.activeMission = nil;

function u1.currentJobWaypoint(p812, p813) -- Line: 4871
    -- upvalues: u1 (copy), LocalPlayer (copy)
    u1.createWaypoint({
        navigation = true,
        create = true,
        name = p813 and "Current Job (Ended)" or "Current Job",
        image = LocalPlayer.Team.Icon.Texture,
        location = p812,
        color = p813 and Color3.fromRGB(153, 153, 153) or Color3.fromRGB(238, 199, 0)
    });
end;

function u1.missionJoined(p814, u815) -- Line: 4875
    -- upvalues: u10 (copy), u810 (copy), u1 (copy), u811 (ref), LocalPlayer (copy), u2 (copy)
    u10.clearConnectionsAndThreads(u810);
    u1.createWaypoint({
        name = "Incident"
    });
    u1.createWaypoint({
        name = "Incident (Ended)"
    });
    u1.createWaypoint({
        name = "Current Job"
    });
    u1.createWaypoint({
        name = "Current Job (Ended)"
    });
    u1.activeMission = p814;
    u811 = (u811 + 1) % 1000;
    local u816 = u811;
    u1.startControlsGuide("EmergencyLights");

    if p814 and (u815 and u815.location) then
        if u10.typeOf(u815.location) == "string" then
            u815.location = u10.getInstanceReference(u815.location, 30);

            if not u815.location or u816 ~= u811 then
                return;
            end;
        end;

        if u10.typeOf(u815.actualLocation) == "string" then
            u815.actualLocation = u10.getInstanceReference(u815.actualLocation, 30);

            if not u815.actualLocation or u816 ~= u811 then
                return;
            end;
        end;

        local u817 = p814:GetAttribute("Incident") and 100 or 50;

        if p814:GetAttribute("Incident") then
            u1.startControlsGuide("EmergencyLights", 0);
            local _ = LocalPlayer.Team.Name;
            u1.createWaypoint({
                navigation = true,
                image = "rbxassetid://11645366727",
                create = true,
                name = u815.lateOnScene and "Incident (Ended)" or "Incident",
                location = u815.location,
                hasRadius = u815.locationRadius,
                color = u815.lateOnScene and Color3.fromRGB(153, 153, 153) or Color3.fromRGB(255, 133, 133),
                showMessageWhenCloseForSomeTime = u815.showMessageWhenCloseForSomeTime or nil
            });

            if u815.locationRadius and u815.lateOnScene then
                u817 = u815.locationRadius + 50;
            end;
        else
            u1.currentJobWaypoint(u815.location, u815.lateOnScene);
        end;

        if not (p814:GetAttribute("Job") and not u815.lateOnScene or p814:GetAttribute("OnScene_" .. LocalPlayer.Name)) then
            task.defer(function() -- Line: 4906
                -- upvalues: u816 (copy), u811 (ref), u2 (ref), u10 (ref), u815 (copy), u817 (ref)
                while u816 == u811 do
                    if u2.root and (u10.isWithinOnSceneLocation(u815.actualLocation or u815.location, u2.root.Position, u817) and (not u10.invokeTraffic.talkToMission and u10.invokeServerTraffic("talkToMission", u815.missionId .. "onScene"))) then
                        return;
                    end;

                    task.wait(1);
                end;
            end);

            if u815.lateOnScene then
                task.delay(120, function() -- Line: 4915
                    -- upvalues: u816 (copy), u811 (ref), u1 (ref)
                    if u816 == u811 then
                        u1.missionJoined();
                    end;
                end);
            end;
        end;
    end;
end;

function u1.joinIncidentsIfNear(p818) -- Line: 4923
    -- upvalues: u1 (copy), Missions (copy), LocalPlayer (copy), u10 (copy), u2 (copy), PlayerFunc (copy)
    if not require(game.Teams[p818].Config).MDT then
        return;
    end;

    local v819 = nil;
    local v820 = 0;

    while true do
        if u1.activeMission and u1.activeMission.Parent then
            v819 = nil;
            v820 = 0;
        else
            local v821 = 0;
            local v822 = nil;

            for _, child in pairs(Missions.Active:GetChildren()) do
                if child:GetAttribute("Incident") and (child:FindFirstChild("Team") and (child.Team:FindFirstChild(p818) and (child.Team[p818]:FindFirstChild("ActualLocation") and (child.Team[p818]:FindFirstChild("Location") and (child:FindFirstChild("Players") and not (child.Players:FindFirstChild(LocalPlayer.Name) or child:GetAttribute("OnScene_" .. LocalPlayer.Name))))))) and ((child.Team[p818].ActualLocation.Value or child.Team[p818].Location.Value) and (u10.isWithinOnSceneLocation(child.Team[p818].ActualLocation.Value or child.Team[p818].Location.Value, u2.root.Position, 100) and v821 < child.StartTime.Value)) then
                    v821 = child.StartTime.Value;
                    v822 = child;
                end;
            end;

            if v822 and v819 == v822 then
                v820 = v820 + 1;

                if v820 >= 2 then
                    PlayerFunc:InvokeServer("talkToMission", v822.ID.Value .. "join", {
                        nearbyJoined = true
                    });
                end;
            else
                v819 = v822;
                v820 = 0;
            end;
        end;

        task.wait(4);
    end;
end;

local u823 = {};
local u824 = 0;
local u825 = 0;
local u826 = nil;

function u1.jobStep(p827, u828) -- Line: 4961
    -- upvalues: u826 (ref), u825 (ref), u824 (ref), u823 (ref), u10 (copy), Stuff (copy), Missions (copy), u7 (copy), u1 (copy), PlayerFunc (copy), GameRules (copy), LocalPlayer (copy), u3 (copy)
    if u828 then
        u826 = u828;
    end;

    u825 = (u825 + 1) % 100;

    if p827 == "nextStep" then
        u824 = u824 + 1;

        if u823[u824] then
            task.spawn(u823[u824], u826);
        end;
    elseif p827 == "start" then
        local u829 = {};
        local Value = u828.missionObject.ID.Value;
        u824 = 0;
        table.clear(u823);

        if u828.team == "Chef" then
            if u828.mission == "Prepare Food" then
                local u830 = nil;
                local InstanceReference = u10.getInstanceReference(u828.cookSpotReference, 20);

                if not InstanceReference then
                    return;
                end;

                local u831 = nil;
                local u832 = nil;
                local u833 = {};
                local u834 = {};
                u823 = { function(p835) -- Line: 4982
                        -- upvalues: u830 (ref), u10 (ref), u832 (ref), Stuff (ref), u834 (copy), Missions (ref), u7 (ref), u1 (ref), u833 (copy), u825 (ref), InstanceReference (copy), PlayerFunc (ref), Value (copy)
                        u830 = u10.clone(p835.restaurant.Ingredients);
                        u830.Parent = workspace.Gameplay.Entities;
                        u832 = u10.clone(p835.restaurant.Value.OrderScreen.Screen.SurfaceGui);
                        u832.Enabled = true;
                        u832.Parent = p835.restaurant.Value.OrderScreen.Screen;
                        u832.OrderText.Text = string.upper(p835.orderName) .. " ORDER";
                        u832.Order.Image = require(Stuff.Food[p835.order].Config).ICON;

                        for _, v in pairs(p835.ingredients) do
                            u834[v] = (u834[v] or 0) + 1;
                            local v836 = u10.clone(u832.Ingredients.Preview);
                            v836.Image = require(u10.availableItems[v].Config).ICON;
                            v836.Name = v;
                            v836.Visible = true;
                            v836.Parent = u832.Ingredients;
                        end;

                        for _, child in pairs(u830:GetChildren()) do
                            local v837 = u10.clone(Missions.Stuff.Interaction);
                            v837.HoldDuration = 0.5;
                            v837.ActionText = "Take";
                            v837.ObjectText = child.Name;
                            v837.Name = "Ingredients";
                            v837.Parent = child;
                            u7.triggerListener(v837, function() -- Line: 5005
                                -- upvalues: u1 (ref), u10 (ref), child (copy), u833 (ref)
                                local v838 = u1.makeDraggable(u10.availableItems[child.Name], true);
                                v838:PivotTo(child.CFrame + child.CFrame.LookVector * 2);
                                v838.Parent = workspace.Gameplay.Entities;
                                table.insert(u833, v838);
                            end);
                        end;

                        local u839 = u825;
                        task.defer(function() -- Line: 5013
                            -- upvalues: u825 (ref), u839 (copy), u833 (ref), u834 (ref), InstanceReference (ref), u832 (ref), u10 (ref), PlayerFunc (ref), Value (ref)
                            local v840 = 0;

                            while u825 == u839 do
                                for _, v in pairs(u833) do
                                    if v.Parent and (u834[v.Name] and ((v.PrimaryPart.Position - InstanceReference.PrimaryPart.Position).Magnitude < 3 and v:GetAttribute("DraggedOnce"))) then
                                        u834[v.Name] = u834[v.Name] - 1;

                                        if u834[v.Name] <= 0 then
                                            u834[v.Name] = nil;
                                        end;

                                        u832.Ingredients[v.Name]:Destroy();
                                        v:Destroy();
                                        local v841 = u10.clone(u10.availableItems[v.Name]);

                                        for _, child in pairs(v841:GetChildren()) do
                                            if child:IsA("BasePart") then
                                                child.Anchored = true;
                                                child.CanCollide = true;
                                            end;
                                        end;

                                        local BoundingBox, v842 = v841:GetBoundingBox();
                                        local v843 = v841.PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position);
                                        v840 = v840 + 1;
                                        local v844 = CFrame.new(InstanceReference.PrimaryPart[v840].WorldCFrame:PointToWorldSpace(-v843)) * (v841.PrimaryPart.CFrame - v841.PrimaryPart.Position);
                                        local v845 = u10.getWorldSize(v841.PrimaryPart.CFrame, v842).Y / 2;
                                        v841:PivotTo(v844 + Vector3.new(0, v845, 0));
                                        v841.Parent = InstanceReference;

                                        if u10.indexedTableSize(u834) == 0 then
                                            while not PlayerFunc:InvokeServer("talkToMission", Value .. "ingredients") and u825 == u839 do
                                                task.wait(1);
                                            end;

                                            return;
                                        end;
                                    end;
                                end;

                                task.wait(0.1);
                            end;
                        end);
                    end, function(p846) -- Line: 5039
                        -- upvalues: u830 (ref)
                        u830:Destroy();
                    end, function(p847) -- Line: 5042
                        -- upvalues: u831 (ref), u10 (ref)
                        u831 = u10.clone(p847.restaurant.CookOrderPickUp);
                        u831.Parent = workspace.Gameplay.Entities;
                    end };
                table.insert(u829, function() -- Line: 5047
                    -- upvalues: u832 (ref), u833 (copy), u830 (ref), u831 (ref)
                    if u832.Parent then
                        u832:Destroy();
                    end;

                    for _, v in pairs(u833) do
                        v:Destroy();
                    end;

                    if u830 and u830.Parent then
                        u830:Destroy();
                    end;

                    if u831 and u831.Parent then
                        u831:Destroy();
                    end;
                end);
            end;
        elseif u828.team == "Farmer" then
            if u828.mission == "Crops" then
                u823 = {
                    [3] = function(u848) -- Line: 5057
                        -- upvalues: u825 (ref), u10 (ref), GameRules (ref), PlayerFunc (ref), Value (copy), u829 (copy)
                        local u849 = u825;
                        local InstanceReference = u10.getInstanceReference(u848.cropsReference, function() -- Line: 5059
                            -- upvalues: u825 (ref), u849 (copy)
                            return u825 ~= u849;
                        end);
                        local u850 = u10.overlapParamsNew();
                        u850.FilterDescendantsInstances = { workspace.Characters, workspace.Gameplay };
                        local u851 = 0;
                        local u852 = #InstanceReference:GetChildren() * (GameRules.percentageOfCropsRequiredToFinishJob / 100);

                        if not InstanceReference:GetAttribute("CropTransparency") then
                            InstanceReference:SetAttribute("CropTransparency", InstanceReference:GetChildren()[1].Transparency);
                        end;

                        local Attribute = InstanceReference:GetAttribute("CropTransparency");
                        task.defer(function() -- Line: 5066
                            -- upvalues: u10 (ref), u848 (copy), u825 (ref), u849 (copy), u850 (copy), InstanceReference (copy), u851 (ref), u852 (copy), PlayerFunc (ref), Value (ref)
                            local InstanceReference2 = u10.getInstanceReference(u848.harrowReference, function() -- Line: 5067
                                -- upvalues: u825 (ref), u849 (ref)
                                return u825 ~= u849;
                            end);

                            while u825 == u849 do
                                if InstanceReference2.Parent then
                                    for _, v in pairs(workspace:GetPartsInPart(InstanceReference2.Harvest, u850)) do
                                        if v:IsDescendantOf(InstanceReference) and v.Transparency ~= 1 then
                                            task.delay(math.random(0, 6) * 0.03, function() -- Line: 5072
                                                -- upvalues: u10 (ref), InstanceReference2 (copy)
                                                u10.emit(InstanceReference2.Harvest.CropResidue, 40);
                                                InstanceReference2.Harvest.Sound.PlaybackSpeed = math.random(80, 120) / 100;
                                                u10.playSoundReplicate(InstanceReference2.Harvest.Sound);
                                            end);
                                            v.Transparency = 1;
                                            u851 = u851 + 1;

                                            if u852 <= u851 then
                                                while not PlayerFunc:InvokeServer("talkToMission", Value .. "harvested", u851) and u825 == u849 do
                                                    task.wait(1);
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                task.wait(0.15);
                            end;
                        end);
                        table.insert(u829, function() -- Line: 5088
                            -- upvalues: InstanceReference (copy), Attribute (copy)
                            task.wait(20);

                            for i = 1, 16 do
                                task.wait(5);
                                local v853 = i;

                                for _, child in pairs(InstanceReference:GetChildren()) do
                                    if child.Transparency ~= Attribute then
                                        child.Transparency = Attribute + (1 - Attribute) * (1 - v853 / 8);
                                    end;
                                end;
                            end;
                        end);
                    end
                };
            elseif u828.mission == "Animals" then
                local u854 = nil;
                local u855 = nil;
                u823 = { function(p856) -- Line: 5102
                        -- upvalues: u854 (ref), u10 (ref), Missions (ref), u855 (ref), u1 (ref)
                        local Value2 = p856.folder.Farmhouse.Value;
                        local _, _ = game.ReplicatedStorage.Gameplay.Farm.Animals[Value2.Name]:GetBoundingBox();
                        u854 = u10.clone(Missions.Stuff.Interaction);
                        u854.HoldDuration = 2;
                        u854.ActionText = "Pick Up";
                        u854.Name = "Relocate";
                        u855 = u10.clone(Value2.DropOff);
                        u855.Parent = workspace.Gameplay.Entities;
                        local v857 = p856.folder.Tool:GetChildren()[1];
                        u1.missionLibrary("relocate", p856.missionObject, {
                            putInHand = true,
                            updateJobWaypoint = true,
                            spawnGoodsOffset = "closeToPlayer",
                            invokeStatus = p856.id .. "relocate",
                            interaction = u854,
                            pickUp = u1.farmhouses[Value2][1].PrimaryPart,
                            totalAmount = p856.totalAmount,
                            dropOff = u855,
                            items = { v857 },
                            spawnGoodsOffset2 = require(v857.Config).CUSTOM_OFFSET,

                            droppedOffFunc = function(p858) -- Line: 5112, Name: droppedOffFunc
                                -- upvalues: u854 (ref), u1 (ref), Value2 (copy)
                                u854.Parent = u1.farmhouses[Value2][p858 % #u1.farmhouses[Value2] + 1].PrimaryPart;
                            end
                        });
                    end };
                table.insert(u829, function() -- Line: 5117
                    -- upvalues: u854 (ref), u855 (ref)
                    if u854 then
                        u854:Destroy();
                    end;

                    if u855 then
                        u855:Destroy();
                    end;
                end);
            end;
        elseif u828.team == "Transit" then
            local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);
            local u859 = { "Casual", "Formal", "Very Formal" };

            local function spawnNPCthatInteractsWithVehicle(u860) -- Line: 5125
                -- upvalues: u10 (ref), u859 (copy), BelongingVehicle (copy)
                local v861 = {};
                local u862 = {};

                local function generateNPC(p863, p864, p865) -- Line: 5128
                    -- upvalues: u10 (ref), u859 (ref)
                    local v866, v867 = u10.createNPC(p863 or u859[math.random(#u859)], p864, p865);
                    v866.Parent = workspace.Gameplay.Entities;

                    return v866, v867;
                end;

                if u860["in"] then
                    v861.previewNPCs = {};

                    for _, v in pairs(u10.generateSpawnPointsForNPC({
                        box = u860.box,
                        circle = u860.circle,
                        circleSpread = u860.circleSpread,
                        circleRadius = u860.circleRadius,
                        population = u860["in"]
                    })) do
                        local v868 = u10.smartUnit(v - u860.vehicleLocation.Position);
                        local v869 = math.atan2(-v868.X, -v868.Z) + 3.141592653589793;
                        local look = u860.look;
                        local v870 = CFrame.new(v) * CFrame.Angles(0, v869 + math.random(-10, 10) / 10, 0);
                        local u871, v872 = u10.createNPC(look or u859[math.random(#u859)], v870, true);
                        u871.Parent = workspace.Gameplay.Entities;
                        table.insert(v861.previewNPCs, v872);
                        table.insert(u862, function(u873) -- Line: 5140
                            -- upvalues: BelongingVehicle (ref), u860 (copy), u871 (copy), u10 (ref), v (copy)
                            task.spawn(function() -- Line: 5141
                                -- upvalues: BelongingVehicle (ref), u860 (ref), u873 (copy), u871 (ref), u10 (ref), v (ref)
                                if BelongingVehicle.Parent then
                                    if u860.randomness and not u873 then
                                        task.wait(u860.randomness());
                                    end;

                                    local v874 = {};

                                    for _, child in pairs(BelongingVehicle:GetChildren()) do
                                        if child:IsA("Seat") and child.Name ~= "DriveSeat" then
                                            table.insert(v874, child);
                                        end;
                                    end;

                                    for _, descendant in pairs(u871:GetDescendants()) do
                                        if descendant:IsA("BasePart") then
                                            descendant.CollisionGroup = "NonCollide";
                                        end;
                                    end;

                                    if u873 then
                                        u10.walkNPC({
                                            fadeOut = true,
                                            studsPerSecond = 11,
                                            findSurface = true,
                                            npc = u871,
                                            walkTo = (CFrame.new(u871.PrimaryPart.Position) * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(u871, 30), 0) * CFrame.new(0, 0, 30)).Position
                                        });
                                    else
                                        local v875 = u10.findClosestFromTable(v, v874);
                                        local v876 = v875.Attachment.WorldPosition + u10.leaveVehicleSeatPathRaycast(v875) / 2;
                                        local v877 = u10.intersectLineWithPlane(v876, Vector3.new(0, 1, 0), u10.getEntireVehicleBoxCFrame(BelongingVehicle).Position, -BelongingVehicle.PrimaryPart.CFrame.UpVector);
                                        local v878 = BelongingVehicle:GetAttribute("EntireBoxSize").Y / 2;
                                        local v879 = v877 - Vector3.new(0, v878, 0);
                                        u10.walkNPC({
                                            fadeOut = true,
                                            studsPerSecond = 11,
                                            isWalkToAtFoot = true,
                                            npc = u871,
                                            walkTo = Vector3.new(v876.X, v879.Y, v876.Z)
                                        });
                                    end;

                                    if u871.Parent then
                                        u871:Destroy();
                                    end;
                                end;
                            end);
                        end);
                    end;
                end;

                if u860.out then
                    for i, v in pairs(u10.generateSpawnPointsForNPC({
                        noDistancing = true,
                        box = u860.box,
                        circle = u860.circle,
                        circleSpread = u860.circleSpread,
                        circleRadius = u860.circleRadius,
                        population = u10.typeOf(u860.out) == "table" and #u860.out or u860.out
                    })) do
                        table.insert(u862, function(u880, u881) -- Line: 5163
                            -- upvalues: BelongingVehicle (ref), u860 (copy), v (ref), u10 (ref), i (copy), u859 (ref)
                            task.spawn(function() -- Line: 5164
                                -- upvalues: BelongingVehicle (ref), u860 (ref), u880 (copy), v (ref), u10 (ref), i (ref), u859 (ref), u881 (copy)
                                if BelongingVehicle.Parent then
                                    if u860.randomness and not u880 then
                                        task.wait(u860.randomness());
                                    end;

                                    local v882 = {};

                                    for _, child in pairs(BelongingVehicle:GetChildren()) do
                                        if child:IsA("Seat") and child.Name ~= "DriveSeat" then
                                            table.insert(v882, child);
                                        end;
                                    end;

                                    if u880 then
                                        local v883 = { BelongingVehicle };
                                        v = (CFrame.new(BelongingVehicle.PrimaryPart.Position) * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(BelongingVehicle.PrimaryPart.Position, 40, v883), 0) * CFrame.new(0, 0, 40)).Position;
                                    elseif u860.circleFindSpace then
                                        v = (u860.circle * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(u860.circle.Position, u860.circleRadius, { BelongingVehicle }), 0) * CFrame.new(0, 0, u860.circleRadius)).Position;
                                    end;

                                    local v884 = u10.findClosestFromTable(v, v882);
                                    local v885 = v884.Attachment.WorldPosition + u10.leaveVehicleSeatPathRaycast(v884) / 2;
                                    local X = v885.X;
                                    local v886 = u10.getEntireVehicleBoxCFrame(BelongingVehicle).Y - BelongingVehicle:GetAttribute("EntireBoxSize").Y / 2;
                                    local Vector3_new_ret = Vector3.new(X, v886, v885.Z);
                                    local v887 = u10.smartUnit(Vector3_new_ret - v);
                                    local v888 = math.atan2(-v887.X, -v887.Z) + 3.141592653589793;
                                    local v889 = u10.typeOf(u860.out) == "table" and u860.out[i] or u860.look;
                                    local v890 = CFrame.new(Vector3_new_ret) * CFrame.Angles(0, v888 + math.random(-10, 10) / 10, 0);
                                    local v891, _ = u10.createNPC(v889 or u859[math.random(#u859)], v890, true);
                                    v891.Parent = workspace.Gameplay.Entities;

                                    if u881 then
                                        u10.chatNPC(v891, u881);
                                    end;

                                    for _, descendant in pairs(v891:GetDescendants()) do
                                        if descendant:IsA("BasePart") then
                                            descendant.CollisionGroup = "NonCollide";
                                        end;
                                    end;

                                    u10.walkNPC({
                                        fadeOut = true,
                                        studsPerSecond = 11,
                                        findSurface = true,
                                        npc = v891,
                                        walkTo = v
                                    });

                                    if v891.Parent then
                                        v891:Destroy();
                                    end;
                                end;
                            end);
                        end);
                    end;
                end;

                function v861.walk(p892, p893) -- Line: 5190
                    -- upvalues: u862 (copy)
                    for _, v in pairs(u862) do
                        v(p892, p893);
                    end;
                end;

                return v861;
            end;

            if u828.mission == "Bus Driver" then
                local u894 = #u828.route:GetChildren();
                local u895 = nil;

                for i = 1, u894 do
                    table.insert(u823, function(p896) -- Line: 5199
                        -- upvalues: u895 (ref), spawnNPCthatInteractsWithVehicle (copy), i (copy), u894 (copy)
                        if u895 then
                            u895.walk();
                        end;

                        local v897 = {
                            randomness = function() -- Line: 5201, Name: randomness
                                return math.random(50) / 100;
                            end
                        };
                        local v898;

                        if i == u894 then
                            v898 = false;
                        else
                            v898 = math.random(2, 6);
                        end;

                        v897["in"] = v898;
                        local v899;

                        if i == 1 then
                            v899 = false;
                        else
                            v899 = u895.previewNPCs;
                        end;

                        v897.out = v899;
                        v897.vehicleLocation = p896.route[i];
                        v897.box = p896.route[i].Area;
                        u895 = spawnNPCthatInteractsWithVehicle(v897);
                    end);
                    local _ = i;
                end;

                table.insert(u823, function(p900) -- Line: 5204
                    -- upvalues: u895 (ref)
                    u895.walk();
                    u895 = nil;
                end);
                table.insert(u829, function() -- Line: 5208
                    -- upvalues: u895 (ref)
                    if u895 then
                        u895.walk(true);
                    end;
                end);
            elseif u828.mission == "Taxi" then
                local u901 = nil;
                local u902 = nil;
                u823 = { function(p903) -- Line: 5215
                        -- upvalues: u901 (ref), spawnNPCthatInteractsWithVehicle (copy)
                        u901 = spawnNPCthatInteractsWithVehicle({
                            ["in"] = 1,
                            vehicleLocation = p903.start,
                            circleSpread = 0.25,
                            box = p903.start.Area
                        });
                    end, function(p904) -- Line: 5218
                        -- upvalues: u901 (ref), u902 (ref), spawnNPCthatInteractsWithVehicle (copy)
                        u901.walk();
                        u902 = spawnNPCthatInteractsWithVehicle({
                            circleFindSpace = true,
                            circleRadius = 40,
                            out = u901.previewNPCs,
                            circle = p904.finish.CFrame - Vector3.new(0, p904.finish.Visual.Size.Y, 0)
                        });
                        u901 = nil;
                    end, function(p905) -- Line: 5223
                        -- upvalues: u902 (ref)
                        u902.walk(nil, "taxiDestination");
                        u902 = nil;
                    end };
                table.insert(u829, function() -- Line: 5228
                    -- upvalues: u901 (ref), u902 (ref)
                    if u901 then
                        u901.walk(true);
                    end;

                    if u902 then
                        u902.walk(true);
                    end;
                end);
            elseif u828.mission == "Public Taxi" then
                u823 = {
                    [2] = function(u906) -- Line: 5234
                        -- upvalues: u10 (ref), LocalPlayer (ref), u825 (ref), PlayerFunc (ref), Value (copy)
                        local BelongingVehicle2 = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);
                        local u907 = u825;
                        task.defer(function() -- Line: 5237
                            -- upvalues: u825 (ref), u907 (copy), BelongingVehicle2 (copy), u10 (ref), u906 (copy), PlayerFunc (ref), Value (ref)
                            while u825 == u907 and BelongingVehicle2.Parent do
                                local v908 = u10.isCharLoaded(u906.target) and u906.target.Character.PrimaryPart;

                                if v908 and ((v908.Position - BelongingVehicle2._Chassis.Position).Magnitude < 20 and PlayerFunc:InvokeServer("talkToMission", Value .. "playerNearby")) then
                                    return;
                                end;

                                task.wait(2);
                            end;
                        end);
                    end
                };
            end;
        elseif u828.team == "Delivery" then
            if u828.mission == "Courier" then
                local u909 = false;

                local function destroyNPC(u910) -- Line: 5250
                    -- upvalues: u909 (ref), u10 (ref)
                    task.spawn(function() -- Line: 5251
                        -- upvalues: u909 (ref), u10 (ref), u910 (copy)
                        if u909 then
                            u10.walkNPC({
                                fadeOut = true,
                                studsPerSecond = 7,
                                findSurface = true,
                                npc = u910,
                                walkTo = u910.PrimaryPart.Position + u910.PrimaryPart.CFrame.LookVector * -4
                            });
                        end;

                        u910:Destroy();
                    end);
                end;

                local u911 = nil;

                if u828.isPickUp then
                    u823 = {
                        [2] = function(p912) -- Line: 5259
                            -- upvalues: u911 (ref), u10 (ref), u909 (ref)
                            if p912.start:FindFirstChild("NPC") then
                                u911 = u10.createLocationNPC(p912.start.NPC, "Casual");
                                u909 = p912.start.NPC:FindFirstChild("WalksOut") and true or false;

                                if u909 then
                                    u911:PivotTo(u911.PrimaryPart.CFrame + u911.PrimaryPart.CFrame.LookVector * -4);
                                    u10.walkNPC({
                                        studsPerSecond = 7,
                                        npc = u911,
                                        walkTo = u911.PrimaryPart.Position + u911.PrimaryPart.CFrame.LookVector * 4
                                    });
                                end;
                            end;
                        end,

                        [3] = function(p913) -- Line: 5269
                            -- upvalues: u911 (ref), u909 (ref), u10 (ref)
                            if u911 then
                                local u914 = u911;
                                task.spawn(function() -- Line: 5251
                                    -- upvalues: u909 (ref), u10 (ref), u914 (copy)
                                    if u909 then
                                        u10.walkNPC({
                                            fadeOut = true,
                                            studsPerSecond = 7,
                                            findSurface = true,
                                            npc = u914,
                                            walkTo = u914.PrimaryPart.Position + u914.PrimaryPart.CFrame.LookVector * -4
                                        });
                                    end;

                                    u914:Destroy();
                                end);
                                u911 = nil;
                            end;
                        end
                    };
                else
                    u823 = {
                        [2] = function(p915) -- Line: 5275
                            -- upvalues: u911 (ref), u10 (ref), u909 (ref)
                            if p915.finish:FindFirstChild("NPC") then
                                u911 = u10.createLocationNPC(p915.finish.NPC, "Casual");
                                u909 = p915.finish.NPC:FindFirstChild("WalksOut") and true or false;

                                if u909 then
                                    u911:PivotTo(u911.PrimaryPart.CFrame + u911.PrimaryPart.CFrame.LookVector * -4);
                                    u10.walkNPC({
                                        studsPerSecond = 7,
                                        npc = u911,
                                        walkTo = u911.PrimaryPart.Position + u911.PrimaryPart.CFrame.LookVector * 4
                                    });
                                end;
                            end;
                        end
                    };
                end;

                table.insert(u829, function() -- Line: 5287
                    -- upvalues: u911 (ref), u909 (ref), u10 (ref)
                    if u911 then
                        local u916 = u911;
                        task.spawn(function() -- Line: 5251
                            -- upvalues: u909 (ref), u10 (ref), u916 (copy)
                            if u909 then
                                u10.walkNPC({
                                    fadeOut = true,
                                    studsPerSecond = 7,
                                    findSurface = true,
                                    npc = u916,
                                    walkTo = u916.PrimaryPart.Position + u916.PrimaryPart.CFrame.LookVector * -4
                                });
                            end;

                            u916:Destroy();
                        end);
                    end;
                end);
            elseif u828.mission == "Pizza" then
                local u917 = nil;
                local u918 = false;

                local function _(u919) -- Line: 5293
                    -- upvalues: u10 (ref), u918 (ref)
                    task.spawn(function() -- Line: 5294
                        -- upvalues: u10 (ref), u919 (copy), u918 (ref)
                        u10.walkNPC({
                            fadeOut = true,
                            studsPerSecond = 7,
                            npc = u919,
                            walkTo = u918 and u919.PrimaryPart.Position + u919.PrimaryPart.CFrame.LookVector * -4 or (CFrame.new(u919.PrimaryPart.Position) * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(u919, 30), 0) * CFrame.new(0, 0, 30)).Position,
                            findSurface = not u918
                        });
                        u919:Destroy();
                    end);
                end;

                u823 = { function() -- Line: 5300
                        -- upvalues: u825 (ref), LocalPlayer (ref), u828 (copy), u1 (ref)
                        local u920 = u825;
                        task.defer(function() -- Line: 5302
                            -- upvalues: u825 (ref), u920 (copy), LocalPlayer (ref), u828 (ref), u1 (ref)
                            while u825 == u920 do
                                if LocalPlayer.InsideLocation.Value and LocalPlayer.InsideLocation.Value.Name == u828.start.Restaurant.Value then
                                    u1.notify({
                                        message = "Your pick up point is behind the restaurant, not inside"
                                    });

                                    return;
                                end;

                                task.wait(2);
                            end;
                        end);
                    end };

                for i, v in pairs(u828.deliveryLocations) do
                    u823[i * 2] = function() -- Line: 5314
                        -- upvalues: u917 (ref), u10 (ref), u918 (ref), v (copy)
                        if u917 then
                            local u921 = u917;
                            task.spawn(function() -- Line: 5294
                                -- upvalues: u10 (ref), u921 (copy), u918 (ref)
                                u10.walkNPC({
                                    fadeOut = true,
                                    studsPerSecond = 7,
                                    npc = u921,
                                    walkTo = u918 and u921.PrimaryPart.Position + u921.PrimaryPart.CFrame.LookVector * -4 or (CFrame.new(u921.PrimaryPart.Position) * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(u921, 30), 0) * CFrame.new(0, 0, 30)).Position,
                                    findSurface = not u918
                                });
                                u921:Destroy();
                            end);
                            u917 = nil;
                        end;

                        if v:FindFirstChild("NPC") then
                            u917 = u10.createLocationNPC(v.NPC, "Casual");
                            u918 = v.NPC:FindFirstChild("WalksOut") and true or false;

                            if u918 then
                                u917:PivotTo(u917.PrimaryPart.CFrame + u917.PrimaryPart.CFrame.LookVector * -4);
                            end;
                        end;
                    end;

                    u823[i * 2 + 1] = function() -- Line: 5324
                        -- upvalues: u917 (ref), u918 (ref), u10 (ref)
                        if u917 and u918 then
                            u10.chatNPC(u917, "pizzaDelivered");
                            u10.walkNPC({
                                studsPerSecond = 7,
                                npc = u917,
                                walkTo = u917.PrimaryPart.Position + u917.PrimaryPart.CFrame.LookVector * 4
                            });
                        end;
                    end;
                end;

                table.insert(u829, function() -- Line: 5331
                    -- upvalues: u917 (ref), u10 (ref), u918 (ref)
                    if u917 then
                        local u922 = u917;
                        task.spawn(function() -- Line: 5294
                            -- upvalues: u10 (ref), u922 (copy), u918 (ref)
                            u10.walkNPC({
                                fadeOut = true,
                                studsPerSecond = 7,
                                npc = u922,
                                walkTo = u918 and u922.PrimaryPart.Position + u922.PrimaryPart.CFrame.LookVector * -4 or (CFrame.new(u922.PrimaryPart.Position) * CFrame.Angles(0, u10.NPCfindSpaceToWalkAway(u922, 30), 0) * CFrame.new(0, 0, 30)).Position,
                                findSurface = not u918
                            });
                            u922:Destroy();
                        end);
                    end;
                end);
            elseif u828.mission == "Cargo" then
                local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);
                u823 = {
                    [2] = function() -- Line: 5337
                        -- upvalues: u3 (ref), BelongingVehicle (copy), u10 (ref), u828 (copy), Missions (ref), PlayerFunc (ref), Value (copy)
                        u3.freezeVehicle(BelongingVehicle, "loadingCargo", true);
                        local math_random_ret = math.random(6, 8);
                        local Trunk = BelongingVehicle.Config.Trailer.Value.PrimaryPart.Trunk;

                        for _, v in pairs(u10.generateSpawnPointsForNPC({
                            noDistancing = true,
                            box = u828.spawnNPCArea,
                            population = math_random_ret
                        })) do
                            if BelongingVehicle.Parent then
                                local v923 = u10.smartUnit(v - u828.start.Position);
                                local v924 = math.atan2(-v923.X, -v923.Z) + 3.141592653589793;
                                local u925 = u10.createNPC("Cargo", CFrame.new(v) * CFrame.Angles(0, v924, 0), true);
                                local u926 = v;

                                for _, descendant in pairs(u925:GetDescendants()) do
                                    if descendant:IsA("BasePart") then
                                        descendant.CollisionGroup = "VehiclesNonCollide";
                                    end;
                                end;

                                u925.Parent = workspace.Gameplay.Entities;
                                u10.playAnimation(u10.loadAnimation(u925.Humanoid.Animator, game.ReplicatedStorage.PlayerStuff.Items.Animations.PackageIdle), "play");
                                local u927 = u10.clone(Missions.Delivery.Tools.Packages:GetChildren()[math.random(#Missions.Delivery.Tools.Packages:GetChildren())]);
                                u10.toolSystem.createGrip(u925, true);
                                u10.gripTheItem(u925.RightGrip, u925, u927);
                                u927.Parent = u925;
                                task.spawn(function() -- Line: 5353
                                    -- upvalues: u10 (ref), u925 (copy), Trunk (copy), BelongingVehicle (ref), math_random_ret (ref), u3 (ref), PlayerFunc (ref), Value (ref), u927 (copy), u926 (copy)
                                    local walkNPC = u10.walkNPC;
                                    local v928 = {
                                        isWalkToAtFoot = true,
                                        studsPerSecond = 11,
                                        pathfinding = true,
                                        npc = u925
                                    };
                                    local v929 = Trunk.WorldPosition.X + Trunk.WorldCFrame.RightVector.X * 2;
                                    local v930 = BelongingVehicle.PrimaryPart.VisualCenter.WorldPosition.Y - BelongingVehicle:GetAttribute("EntireBoxSize").Y / 2;
                                    v928.walkTo = Vector3.new(v929, v930, Trunk.WorldPosition.Z + Trunk.WorldCFrame.RightVector.Z * 2);
                                    walkNPC(v928);
                                    math_random_ret = math_random_ret - 1;

                                    if math_random_ret <= 0 then
                                        u3.freezeVehicle(BelongingVehicle, "loadingCargo", false);
                                        task.spawn(function() -- Line: 5358
                                            -- upvalues: PlayerFunc (ref), Value (ref)
                                            PlayerFunc:InvokeServer("talkToMission", Value .. "cargoLoaded");
                                        end);
                                    end;

                                    if u925.Parent then
                                        u927:Destroy();
                                        u10.walkNPC({
                                            studsPerSecond = 17,
                                            pathfinding = true,
                                            npc = u925,
                                            walkTo = u926
                                        });

                                        if u925.Parent then
                                            u925:Destroy();
                                        end;
                                    end;
                                end);
                            end;

                            task.wait(1.3 + math.random() * 0.7);
                        end;
                    end
                };
                table.insert(u829, function() -- Line: 5371
                    -- upvalues: u3 (ref), BelongingVehicle (copy)
                    u3.freezeVehicle(BelongingVehicle, "loadingCargo", false);
                end);
            elseif u828.mission == "Public Food Delivery" then
                u823 = { function() -- Line: 5376
                        -- upvalues: u825 (ref), LocalPlayer (ref), u828 (copy), u1 (ref)
                        local u931 = u825;
                        task.defer(function() -- Line: 5378
                            -- upvalues: u825 (ref), u931 (copy), LocalPlayer (ref), u828 (ref), u1 (ref)
                            while u825 == u931 do
                                if LocalPlayer.InsideLocation.Value and LocalPlayer.InsideLocation.Value.Name == u828.start.Restaurant.Value then
                                    u1.notify({
                                        message = "Your pick up point is behind the restaurant, not inside"
                                    });

                                    return;
                                end;

                                task.wait(2);
                            end;
                        end);
                    end };
            end;
        end;

        if u828.step then
            for i = 1, u828.step do
                u1.jobStep("nextStep");
                local _ = i;
            end;
        end;

        local u932 = nil;
        u932 = u828.missionObject.Players[LocalPlayer.Name].Destroying:Connect(function() -- Line: 5395
            -- upvalues: u932 (ref), u829 (copy), u10 (ref)
            u932:Disconnect();

            for _, v in pairs(u829) do
                if u10.typeOf(v) == "Instance" then
                    if v.Parent then
                        v:Destroy();
                    end;
                else
                    v();
                end;
            end;
        end);
    end;
end;

function u1.missionLibrary(p933, p934, u935) -- Line: 5406
    -- upvalues: LocalPlayer (copy), u10 (copy), u2 (copy), PlayerFunc (copy), GameRules (copy), u1 (copy), u7 (copy)
    if p934.Players:FindFirstChild(LocalPlayer.Name) then
        local u936 = {};
        local u937 = {};
        local u938 = false;

        local function cleanUp() -- Line: 5411
            -- upvalues: cleanUp (ref), u938 (ref), u10 (ref), u937 (copy), u936 (copy)
            cleanUp = nil;
            u938 = true;
            u10.clearConnectionsAndThreads(u937);

            for _, v in pairs(u936) do
                if v.Parent then
                    v:Destroy();
                end;
            end;
        end;

        table.insert(u937, p934.Players[LocalPlayer.Name].Destroying:Connect(cleanUp));

        if p933 == "location" then
            local InstanceReference = u10.getInstanceReference(u935.locationReference, 20);

            if not InstanceReference then
                local v939 = cleanUp and cleanUp();

                return v939;
            end;

            table.insert(u937, InstanceReference.Destroying:Connect(cleanUp));
            local LocationInsideAtPos = u10.getLocationInsideAtPos(InstanceReference.Position);
            local beingNearbyOutsideIsSufficient = u935.beingNearbyOutsideIsSufficient;

            if beingNearbyOutsideIsSufficient then
                if LocationInsideAtPos then
                    LocationInsideAtPos = u10.getLocationOutsideCenter(LocationInsideAtPos);
                end;
            else
                LocationInsideAtPos = beingNearbyOutsideIsSufficient;
            end;

            task.spawn(function() -- Line: 5424
                -- upvalues: u938 (ref), u2 (ref), InstanceReference (copy), LocationInsideAtPos (copy), u10 (ref), LocalPlayer (ref), PlayerFunc (ref)
                while not (u938 or u2.root and not ((InstanceReference.Position - u2.root.Position).Magnitude >= (LocationInsideAtPos and 400 or 50) and (not LocationInsideAtPos or (LocationInsideAtPos - u2.root.Position).Magnitude >= 120) or (u10.getVehicleInfo.inVehicle(LocalPlayer) or not PlayerFunc:InvokeServer("talkToMission", InstanceReference)))) do
                    task.wait(1);
                end;
            end);
        elseif p933 == "vehicleLocation" then
            local InstanceReference = u10.getInstanceReference(u935.locationReference, 20);

            if not InstanceReference then
                local v940 = cleanUp and cleanUp();

                return v940;
            end;

            table.insert(u937, InstanceReference.Destroying:Connect(cleanUp));
            local v941 = 0;
            local v942 = false;

            while not u938 do
                local v943 = u935.vehicle or u10.getVehicleInfo.lastDrivenVehicle(LocalPlayer);

                if v943 and (v943.Parent and (v941 > 0 or v943.PrimaryPart.AssemblyLinearVelocity.Magnitude * GameRules.velocityToMph < 5)) then
                    if u935.followTrailer then
                        v943 = v943.Config.Trailer.Value;
                    end;

                    local Magnitude = (InstanceReference.Position - v943._Chassis.Position).Magnitude;

                    if Magnitude < (u935.minDistance or 8) + 8 then
                        if v941 < 8 then
                            v941 = v941 + 0.5;
                        end;
                    else
                        v941 = v941 > 0 and 0 or v941;
                    end;

                    if Magnitude < (u935.minDistance or 8) + v941 then
                        task.wait(0.5);

                        if PlayerFunc:InvokeServer("talkToMission", InstanceReference) then
                            break;
                        end;
                    end;
                end;

                if not (v942 or (u10.getVehicleInfo.inVehicle(LocalPlayer) or (not u2.root or (u2.root.Position - InstanceReference.Position).Magnitude >= (u935.minDistance or 8)))) then
                    u1.notify({
                        message = "Drive your vehicle here"
                    });
                    v942 = true;
                end;

                task.wait(1);
            end;
        elseif p933 == "relocate" then
            local u944 = u935.interaction or u10.getInstanceReference(u935.interactionReference, 20);
            local v945 = u935.pickUp or u10.getInstanceReference(u935.pickUpReference, 20);
            local u946 = u935.dropOff or u10.getInstanceReference(u935.dropOffReference, 20);
            local u947 = u935.dropOffZone or u935.dropOffZoneReference and u10.getInstanceReference(u935.dropOffZoneReference, 20);
            local u948 = {};

            if u935.items then
                u948 = u935.items;
            else
                for _, v in pairs(u935.itemsReference) do
                    local InstanceReference = u10.getInstanceReference(v, 20);

                    if not InstanceReference then
                        local v949 = cleanUp and cleanUp();

                        return v949;
                    end;

                    table.insert(u948, InstanceReference);
                end;
            end;

            if not (u944 and (v945 and u946)) then
                local v950 = cleanUp and cleanUp();

                return v950;
            end;

            local u951 = 1;
            local u952 = nil;
            local u954 = u935.totalAmount and function(p953) -- Line: 5474, Name: goodsCounter
                -- upvalues: u935 (copy), u944 (copy)
                if u935.totalAmount > 1 then
                    u944.ObjectText = p953 .. " / " .. u935.totalAmount;
                end;
            end or nil;

            if u935.totalAmount then
                u954(u951);
            end;

            u944.Name = "Relocate";
            u944.Parent = v945;

            if u935.updateJobWaypoint then
                u1.currentJobWaypoint(v945);
            end;

            if not u935.byServer then
                table.insert(u936, u944);
            end;

            local function pickedUp(p955) -- Line: 5485
                -- upvalues: u952 (ref), u1 (ref), u948 (ref), u935 (copy), u944 (copy), u10 (ref), u2 (ref), u936 (copy), u954 (ref), u951 (ref), u946 (copy), PlayerFunc (ref)
                if not u952 then
                    u952 = u1.makeDraggable(u948[math.random(#u948)], u935.putInHand);
                    local v956 = u944.Parent:IsA("Attachment") and u944.Parent.WorldCFrame or u944.Parent.CFrame;
                    local v957;

                    if u935.spawnGoodsOffset == "closeToPlayer" then
                        v957 = CFrame.new(v956.Position + u10.smartUnit(u2.root.Position - v956.Position) * (u935.spawnGoodsOffset2 or 3));
                    else
                        v957 = v956 * CFrame.new(u935.spawnGoodsOffset or (u944.Parent:IsA("Attachment") and Vector3.new(2, 0, 0) or Vector3.new(0, 0, -2)));
                    end;

                    u952:PivotTo(v957);
                    u952.Parent = workspace.Gameplay.Entities;
                    table.insert(u936, u952);
                    u944.Enabled = false;

                    if u935.totalAmount then
                        u954(u951 + 1);
                    end;

                    if u935.updateJobWaypoint then
                        u1.currentJobWaypoint(u946);
                    end;

                    if u935.pickedUpServerFunc then
                        task.spawn(function() -- Line: 5500
                            -- upvalues: PlayerFunc (ref), u935 (ref), u944 (ref)
                            PlayerFunc:InvokeServer("talkToMission", u935.invokeStatus or u944, {
                                pickedUpServerFunc = true
                            });
                        end);
                    end;
                end;
            end;

            if u935.isPickedUp then
                pickedUp();
            end;

            u7.triggerListener(u944, pickedUp);
            task.defer(function() -- Line: 5506
                -- upvalues: u938 (ref), u952 (ref), u946 (copy), u947 (copy), u10 (ref), u935 (copy), PlayerFunc (ref), u944 (copy), u951 (ref), u954 (ref), u1 (ref)
                while true do
                    if u938 then
                        return;
                    end;

                    if u952 then
                        for _, v in pairs(u946:IsA("Folder") and u946:GetChildren() or { u946 }) do
                            if (u947 and u10.isPointInArea(u947.CFrame, u947.Size, u952.PrimaryPart.Position) or not u947 and (u952.PrimaryPart.Position - (v:IsA("Model") and v.PrimaryPart.Position or (v:IsA("Attachment") and v.WorldPosition or v.Position))).Magnitude < 3) and u952:GetAttribute("DraggedOnce") then
                                u952:Destroy();
                                u952 = nil;

                                if u935.droppedOffServerFunc then
                                    task.spawn(function() -- Line: 5513
                                        -- upvalues: PlayerFunc (ref), u935 (ref), u944 (ref)
                                        PlayerFunc:InvokeServer("talkToMission", u935.invokeStatus or u944, {
                                            droppedOffServerFunc = true
                                        });
                                    end);
                                end;

                                if u935.totalAmount then
                                    if u951 >= u935.totalAmount and PlayerFunc:InvokeServer("talkToMission", u935.invokeStatus or u944, {
                                        dropOff = v,
                                        goodsAmount = u951
                                    }) then
                                        return;
                                    end;

                                    u944.Enabled = true;

                                    if u935.droppedOffFunc then
                                        u935.droppedOffFunc(u951);
                                    end;

                                    u951 = u951 + 1;
                                    u954(u951);

                                    if u935.updateJobWaypoint then
                                        u1.currentJobWaypoint(u944.Parent);
                                    end;
                                elseif PlayerFunc:InvokeServer("talkToMission", u935.invokeStatus or u944, {
                                    dropOff = v
                                }) then
                                    return;
                                end;

                                u944.Enabled = true;
                                break;
                            end;
                        end;
                    end;

                    task.wait(0.1);
                end;
            end);
            table.insert(u937, u944.Destroying:Connect(cleanUp));
        elseif p933 == "interact" then
            local InstanceReference = u10.getInstanceReference(u935.interactionReference, 20);
            local InstanceReference2 = u10.getInstanceReference(u935.parentReference, 20);

            if not (InstanceReference and InstanceReference2) then
                local v958 = cleanUp and cleanUp();

                return v958;
            end;

            InstanceReference.Parent = InstanceReference2;
            u10.buildSignalData(u937, u7.triggerListener(InstanceReference, function() -- Line: 5536
                -- upvalues: InstanceReference (copy), PlayerFunc (ref)
                InstanceReference.Enabled = false;
                PlayerFunc:InvokeServer("talkToMission", InstanceReference);
                InstanceReference.Enabled = true;
            end));
            table.insert(u937, InstanceReference.Destroying:Connect(cleanUp));
        end;
    end;
end;

u1.towHook = nil;

function u1.towing(p959, p960) -- Line: 5548
    -- upvalues: u1 (copy), u10 (copy), LocalPlayer (copy), Missions (copy), u2 (copy), PlayerFunc (copy)
    local u961 = p960 or {};

    if p959 == "hookPrompt" then
        if u1.towHook then
            u1.towHook:Destroy();
            u1.towHook = nil;
        end;

        local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);

        if BelongingVehicle then
            local v962 = BelongingVehicle._Chassis:FindFirstChild("HookPart") and BelongingVehicle._Chassis.HookPart.Towing;

            if v962 then
                if u961.trigger == "Tow" then
                    if not u10.invokeTraffic.towing then
                        u10.invokeServerTraffic("towing", "towVehicle");
                    end;
                elseif u961.trigger == "Detach" then
                    if not u10.invokeTraffic.towing then
                        local v963 = u10.invokeServerTraffic("towing", "untowVehicle");

                        if u10.typeOf(v963) == "string" then
                            u1.notify({
                                color = "red",
                                message = v963
                            });
                        end;
                    end;
                elseif u961.trigger == "Use Hook" then
                    u1.towHook = u1.makeDraggable(Missions["Road Service"].Tools.Hook, true);
                    u1.towHook:PivotTo(v962.Parent.CFrame + v962.Parent.CFrame.LookVector * 2);
                    u1.towHook.Parent = BelongingVehicle;
                    local u964 = u10.clone(Missions["Road Service"].RopeConstraint);
                    u964.Attachment0 = u1.towHook.PrimaryPart.Attachment;
                    u964.Attachment1 = v962.Parent.Attachment;
                    u964.Parent = u1.towHook;
                    local towHook = u1.towHook;
                    task.spawn(function() -- Line: 5572
                        -- upvalues: towHook (copy), u964 (copy)
                        while towHook.Parent do
                            u964.Length = u964.CurrentDistance * 1.01;
                            task.wait();
                        end;
                    end);
                    task.defer(function() -- Line: 5578
                        -- upvalues: towHook (copy), u10 (ref), u2 (ref), u961 (ref)
                        while towHook.Parent do
                            local Position2 = towHook.PrimaryPart.Position;

                            for _, v in pairs(u10.collectionGetTagged("AttachHook")) do
                                if (Position2 - v.WorldPosition).Magnitude < 3 and (towHook:GetAttribute("DraggedOnce") and (not u10.invokeTraffic.towing and u10.invokeServerTraffic("towing", "attachHook", v.Parent.Parent))) then
                                    if u2.loaded then
                                        u10.animationBuffer(u2.animator, "play", "HookAction");
                                    end;

                                    towHook:Destroy();

                                    if u961.completeFunc then
                                        u961.completeFunc();
                                    end;
                                end;
                            end;

                            task.wait(0.1);
                        end;
                    end);
                end;

                if require(BelongingVehicle.Config).TOW == "HookAndChain" then
                    local v965 = u10.getVehicleInfo.isTowing(BelongingVehicle);

                    for _, child in pairs(BelongingVehicle.Model.VisualHook:GetChildren()) do
                        child.Transparency = (u1.towHook or v965) and 1 or 0;
                    end;
                end;
            end;
        end;
    elseif p959 == "askToTow" then
        local v966, v967 = PlayerFunc:InvokeServer("towing", "askToTow", u961.targetVehicle);

        if u10.typeOf(v966) == "string" then
            u1.notify({
                message = v966,
                color = v967 or "red"
            });
        end;
    end;
end;

u1.replacementTire = nil;

function u1.replacementTireFunc(p968) -- Line: 5611
    -- upvalues: u1 (copy), u10 (copy), LocalPlayer (copy), Missions (copy)
    if u1.replacementTire then
        u1.replacementTire:Destroy();
        u1.replacementTire = nil;
    end;

    if p968 then
        local BelongingVehicle = u10.getVehicleInfo.getBelongingVehicle(LocalPlayer);
        local v969 = BelongingVehicle and BelongingVehicle._Chassis.Trunk:FindFirstChild("ReplacementTire");

        if v969 then
            u1.replacementTire = u1.makeDraggable(Missions["Road Service"].Tools["Replacement Tire"], true);
            u1.replacementTire:PivotTo(v969.Parent.WorldCFrame + v969.Parent.WorldCFrame.RightVector * 2);
            u1.replacementTire.Parent = BelongingVehicle;
            local replacementTire = u1.replacementTire;
            task.defer(function() -- Line: 5622
                -- upvalues: replacementTire (copy), u10 (ref)
                while replacementTire.Parent do
                    local Position2 = replacementTire.PrimaryPart.Position;

                    for _, v in pairs(u10.collectionGetTagged("AttachReplacementTire")) do
                        if (Position2 - v.PrimaryPart.Position).Magnitude < 3 and (replacementTire:GetAttribute("DraggedOnce") and (not u10.invokeTraffic.removeTire and (u10.invokeServerTraffic("removeTire", v) and replacementTire.Parent))) then
                            replacementTire:Destroy();
                        end;
                    end;

                    task.wait(0.1);
                end;
            end);
        end;
    end;
end;

local u970 = u1.initiateIdleAnimationCFrame();

local function loadCharacter(u971) -- Line: 5644
    -- upvalues: LocalPlayer (copy), u970 (copy), u1 (copy), u10 (copy), workspace_CurrentCamera (copy), RunService (copy)
    local v972 = game.Players:FindFirstChild(u971.Name);

    if v972 then
        v972.Character = u971;
    end;

    if u971 ~= LocalPlayer.Character then
        local PrimaryPart = u971.PrimaryPart;
        local Humanoid = u971.Humanoid;
        local Animator = Humanoid.Animator;
        local Vector2_new_ret = Vector2.new();
        local u973, u974 = u970.loadMotors(u971);
        local u975 = 0;
        local u976 = nil;
        u1.scriptedObjects[u971] = {
            cleanUp = function(p977) -- Line: 5656, Name: cleanUp
                -- upvalues: u10 (ref), u1 (ref), u971 (copy)
                u10.clearConnectionsAndThreads(u1.scriptedObjects[u971].connectionsThreads);
            end,

            connectionsThreads = {}
        };
        table.insert(u1.scriptedObjects[u971].connectionsThreads, task.defer(function() -- Line: 5661
            -- upvalues: Humanoid (copy), u1 (ref), u971 (copy), PrimaryPart (copy), workspace_CurrentCamera (ref), u974 (copy), u975 (ref), Vector2_new_ret (ref), Animator (copy), u973 (copy), u976 (ref), RunService (ref)
            if #Humanoid.Animator:GetPlayingAnimationTracks() == 0 then
                task.wait();
            end;

            while Humanoid.Health > 0 do
                if (PrimaryPart.Position - workspace_CurrentCamera.CFrame.Position).magnitude < 300 then
                    if u974(u975) then
                        Vector2_new_ret = Vector2_new_ret:Lerp(u971:GetAttribute("charRot") or Vector2.new(), 1 - 0.012 ^ u975);
                    elseif Vector2_new_ret ~= Vector2.new() then
                        Vector2_new_ret = Vector2.new();
                    end;

                    u1.adjustBodyAngle(Animator, u973, Vector2_new_ret, u971:GetAttribute("charRotType"));
                    local v978, v979 = RunService.Stepped:wait();
                    u976 = v978;
                    u975 = v979;
                else
                    task.wait(1);
                end;
            end;

            if u1.scriptedObjects[u971] then
                u1.scriptedObjects[u971].cleanUp();
            end;
        end));
    end;
end;

for _, child in pairs(workspace.Characters:GetChildren()) do
    task.spawn(loadCharacter, child);
end;

workspace.Characters.ChildAdded:Connect(loadCharacter);
local u980 = nil;

function u1.includeInCrewCrimeListener(p981) -- Line: 5686
    -- upvalues: u980 (ref), u2 (copy), u10 (copy), PlayerFunc (copy)
    if p981.Parent then
        p981:WaitForChild("Crew");
        p981:WaitForChild("IncludePlayerLocation");
        p981:WaitForChild("ID");
        p981:WaitForChild("Players");
    end;

    while p981.Parent and (p981.Crew.Value and p981.Crew.Value == u980) do
        if u2.root and (p981.IncludePlayerLocation.Value and ((u10.getVectorFromLocation(p981.IncludePlayerLocation.Value, true) - Vector2.new(u2.root.Position.X, u2.root.Position.Z)).Magnitude < 150 and PlayerFunc:InvokeServer("talkToMission", p981.ID.Value .. "join"))) then
            return;
        end;

        task.wait(3);
    end;
end;

local InstanceAttributeChangedSignal = u10.getInstanceAttributeChangedSignal(LocalPlayer, "Crew", function(p982) -- Line: 5702
    -- upvalues: u980 (ref), Missions (copy), u1 (copy)
    u980 = p982;

    if u980 then
        for _, child in pairs(Missions.Active:GetChildren()) do
            if child:GetAttribute("Crime") and child.Crew.Value == u980 then
                task.defer(u1.includeInCrewCrimeListener, child);
            end;
        end;
    end;
end);
u10.buildSignalData({}, unpack(InstanceAttributeChangedSignal));
local u983 = {};

function u1.familyJoined(u984) -- Line: 5713
    -- upvalues: u10 (copy), u983 (copy), u12 (ref), u11 (copy)
    u10.clearConnectionsAndThreads(u983);
    u12 = nil;

    for i, _ in pairs(u11) do
        i.Visible = false;
    end;

    if u984 then
        table.insert(u983, task.defer(function() -- Line: 5718
            -- upvalues: u10 (ref), u984 (copy), u12 (ref), u11 (ref), u983 (ref)
            local InstanceReference = u10.getInstanceReference(u984, 20);

            if InstanceReference then
                u12 = function(p985) -- Line: 5721, Name: checkVisibilityNameDisplayFamilyIcon
                    -- upvalues: InstanceReference (copy)
                    p985.Visible = InstanceReference.Players:FindFirstChild(p985.Parent.Parent.Parent.Parent.Name);
                end;

                local function updateNameDisplayFamilyIcons() -- Line: 5724
                    -- upvalues: u11 (ref), u12 (ref)
                    for i, _ in pairs(u11) do
                        u12(i);
                    end;
                end;

                u10.buildSignalData(u983, { InstanceReference.ChildAdded, function() -- Line: 5727
                        -- upvalues: u11 (ref), u12 (ref)
                        for i, _ in pairs(u11) do
                            u12(i);
                        end;
                    end });
                u10.buildSignalData(u983, { InstanceReference.ChildRemoved, function() -- Line: 5728
                        -- upvalues: u11 (ref), u12 (ref)
                        for i, _ in pairs(u11) do
                            u12(i);
                        end;
                    end });

                for i, _ in pairs(u11) do
                    u12(i);
                end;
            end;
        end));
    end;
end;

local u986 = require(game.ReplicatedStorage.Modules:WaitForChild("Spring")).new(Vector3.new(), true);
u986.s = 25;
u986.d = 0.2;

function u1.shakeCamera(p987) -- Line: 5739
    -- upvalues: u986 (copy)
    local v988 = p987 or 0.7;

    for i = 1, 6 do
        local v989 = math.random(2) == 1 and v988 and v988 or -v988;
        local v990 = math.random(2) == 1 and v988 and v988 or -v988;
        local Vector3_new_ret = Vector3.new(v989, v990, 0);
        u986.accelerate(Vector3_new_ret);
        task.wait(0.03);
        u986.accelerate(-Vector3_new_ret);
        task.wait(0.03);
        local _ = i;
    end;
end;

local Ambience = game.SoundService.Ambience;
local u991 = {};

for _, descendant in pairs(Ambience:GetDescendants()) do
    if descendant:IsA("Sound") and not descendant:GetAttribute("NoAmbience") then
        descendant.Volume = 0;
        u991[descendant.Name] = descendant.Parent ~= Ambience;
    end;
end;

local u992 = {};

local function fadeSound(p993, p994, p995) -- Line: 5766
    -- upvalues: TweenService (copy)
    TweenService:Create(p993, TweenInfo.new(p995, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Volume = p994 * p993:GetAttribute("BaseVolume")
    }):Play();
end;

local function muteLowerPriority(p996, p997) -- Line: 5769
    -- upvalues: u992 (copy), u231 (ref), fadeSound (copy)
    if p997 then
        for _, v in pairs(u992) do
            if not (v.fadingOut or (not v.muteLowerPriority or p997 >= v.priority)) then
                p997 = v.priority;
            end;
        end;

        u231 = p997;
    end;

    for i, v in pairs(u992) do
        if v.sound then
            if v.priority < u231 then
                if not v.isMuted then
                    fadeSound(v.sound, 0, p996);
                    u992[i].isMuted = true;
                end;
            elseif v.isMuted and not v.fadingOut then
                fadeSound(v.sound, v.volume, p996);
                u992[i].isMuted = nil;
            end;
        end;
    end;
end;

function u1.playAmbience(u998, p999, p1000) -- Line: 5790
    -- upvalues: u1 (copy), u991 (copy), Ambience (copy), GameRules (copy), u992 (copy), u231 (ref), muteLowerPriority (copy), fadeSound (copy)
    if p1000.isDay == nil then
        p1000.isDay = u1.isDay;
    end;

    local u1001 = u991[u998] == true and (Ambience[GameRules.season]:FindFirstChild(u998) and Ambience[GameRules.season][u998] or Ambience[p1000.isDay and "Day" or "Night"][u998]);

    if not u1001 then
        if u991[u998] == false then
            u1001 = Ambience[u998] or nil;
        else
            u1001 = nil;
        end;
    end;

    if p999 then
        if u992[u998] and not u992[u998].fadingOut then
            u992[u998].volume = p1000.volume or 1;
        else
            if p1000.muteLowerPriority and u231 <= p999 then
                muteLowerPriority(p1000.fadeTime or 0.03, p999);
                u992[u998] = {
                    muteLowerPriority = true,
                    sound = u1001,
                    volume = p1000.volume or 1,
                    priority = p999
                };
            else
                u992[u998] = {
                    sound = u1001,
                    volume = p1000.volume or 1,
                    priority = p999
                };
                muteLowerPriority(0.03);
            end;

            if u1001 then
                u1001:Play();

                if u1001.TimeLength ~= 0 then
                    u1001.TimePosition = math.random() * u1001.TimeLength;
                end;
            end;
        end;

        if u1001 and not u992[u998].isMuted then
            fadeSound(u1001, u992[u998].volume, p1000.fadeTime or 0.03);
        end;
    elseif u992[u998] and not u992[u998].fadingOut then
        u992[u998].fadingOut = true;

        if u1001 then
            fadeSound(u1001, 0, p1000.fadeTime or 0.03);
        end;

        if u992[u998].muteLowerPriority and u231 <= u992[u998].priority then
            muteLowerPriority(p1000.fadeTime or 0.03, 0);
        end;

        if u1001 then
            local function disable() -- Line: 5814
                -- upvalues: u992 (ref), u998 (copy), u1001 (copy)
                if u992[u998] and (u992[u998].fadingOut or u992[u998].sound ~= u1001) then
                    u1001:Stop();

                    if u992[u998].sound == u1001 then
                        u992[u998] = nil;
                    end;
                end;
            end;

            if p1000.fadeTime then
                task.delay(p1000.fadeTime, disable);

                return;
            end;

            if u992[u998] and (u992[u998].fadingOut or u992[u998].sound ~= u1001) then
                u1001:Stop();

                if u992[u998].sound == u1001 then
                    u992[u998] = nil;
                end;
            end;
        end;
    end;
end;

task.defer(function() -- Line: 5826
    -- upvalues: PlayerFunc (copy), PlayerEvent (copy)
    local u1002, u1003 = PlayerFunc:InvokeServer("getTrackedPrompts");
    local u1004 = false;
    game:GetService("ProximityPromptService").PromptShown:Connect(function(u1005) -- Line: 5829
        -- upvalues: u1004 (ref), PlayerEvent (ref), u1002 (copy), u1003 (copy)
        if not u1005:GetAttribute("PTW") then
            local function check(p1006, p1007, p1008) -- Line: 5831
                -- upvalues: u1004 (ref), u1005 (copy), PlayerEvent (ref)
                if not u1004 then
                    if p1007 and u1005.MaxActivationDistance > p1007 + 0.01 then
                        PlayerEvent:FireServer("fadeSound", "Distance", u1005:GetFullName(), u1005.MaxActivationDistance);
                        u1004 = true;

                        return;
                    end;

                    if p1008 and u1005.HoldDuration < p1008 - 0.01 then
                        PlayerEvent:FireServer("fadeSound", "Duration", u1005:GetFullName(), u1005.HoldDuration);
                        u1004 = true;
                    end;
                end;
            end;

            check(u1005.Name, u1002[u1005.Name] and u1002[u1005.Name][1] or u1003, u1002[u1005.Name] and u1002[u1005.Name][2]);
            check(u1005.Name .. "_" .. u1005.ActionText, u1002[u1005.Name .. "_" .. u1005.ActionText] and u1002[u1005.Name .. "_" .. u1005.ActionText][1], u1002[u1005.Name .. "_" .. u1005.ActionText] and u1002[u1005.Name .. "_" .. u1005.ActionText][2]);
        end;
    end);
end);
local u1009 = u10.overlapParamsNew();
u1009.FilterType = Enum.RaycastFilterType.Include;
u1009.FilterDescendantsInstances = { game.ReplicatedStorage.Gameplay.WorldModel.RegionAmbience };
local u1010 = {};
local Vector3_new_ret = Vector3.new();
local u1011 = {
    _Tunnel = Enum.ReverbType.SewerPipe,
    Default = game.SoundService.AmbientReverb
};
task.spawn(function() -- Line: 5856
    -- upvalues: LocalPlayer (copy), u2 (copy), u1010 (ref), u1 (copy), Vector3_new_ret (ref), u1009 (copy), u1011 (copy), u10 (copy)
    while true do
        local v1012 = LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot().Position or u2.root and u2.root.Position;

        local function v1014(p1013) -- Line: 5859
            -- upvalues: u1010 (ref), u1 (ref)
            for i, _ in pairs(u1010) do
                u1.playAmbience(i, false, {
                    fadeTime = 5
                });
            end;

            table.clear(u1010);
            u1010 = p1013;
        end;

        if v1012 and (Vector3_new_ret - v1012).Magnitude > 10 then
            Vector3_new_ret = v1012;
            local v1015 = {};

            for _, v in pairs(game.ReplicatedStorage.Gameplay.WorldModel:GetPartBoundsInRadius(v1012, 120, u1009)) do
                if not u1011[v.Name] then
                    local Magnitude = (v1012 - u10.closestPointOnPart(v, v1012)).Magnitude;

                    if not v1015[v.Name] or Magnitude < v1015[v.Name] then
                        v1015[v.Name] = Magnitude;
                    end;
                end;
            end;

            for i, v in pairs(v1015) do
                u1010[i] = nil;
                u1.playAmbience(i, 1, {
                    fadeTime = 2,
                    volume = (120 - v) / 120
                });
            end;

            v1014(v1015);
        elseif not (v1012 or u10.isTableEmpty(u1010)) then
            v1014({});
        end;

        task.wait(1);
    end;
end);
local Vector3_new_ret2 = Vector3.new();
task.spawn(function() -- Line: 5887
    -- upvalues: LocalPlayer (copy), u2 (copy), Vector3_new_ret2 (ref), u1009 (copy), u1011 (copy)
    while true do
        local v1016 = LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot().Position or u2.root and u2.root.Position;

        if v1016 and (Vector3_new_ret2 - v1016).Magnitude > 10 then
            local v1017 = nil;
            Vector3_new_ret2 = v1016;

            for _, v in pairs(game.ReplicatedStorage.Gameplay.WorldModel:GetPartBoundsInRadius(v1016, 1, u1009)) do
                if u1011[v.Name] then
                    v1017 = v.Name;
                end;
            end;

            if game.SoundService.AmbientReverb ~= u1011[v1017 or "Default"] then
                game.SoundService.AmbientReverb = u1011[v1017 or "Default"];
            end;
        end;

        task.wait(0.5);
    end;
end);

local function ambienceChangeDayNight(p1018, p1019) -- Line: 5902
    -- upvalues: Ambience (copy), u992 (copy), u1 (copy)
    for _, child in pairs(Ambience.Day:GetChildren()) do
        if u992[child.Name] then
            local priority = u992[child.Name].priority;
            u1.playAmbience(child.Name, false, {
                fadeTime = not p1019 and 20,
                isDay = not p1018
            });
            u1.playAmbience(child.Name, priority, {
                fadeTime = not p1019 and 20,
                isDay = p1018
            });
        end;
    end;
end;

local u1020 = nil;
local u1021 = false;
local u1022 = nil;
local u1023 = {};

function u1.playMusicAmbience(p1024) -- Line: 5917
    -- upvalues: u1022 (ref), u1020 (ref), u1021 (ref), u10 (copy), u1023 (copy), fadeSound (copy), u1 (copy), LocalPlayer (copy)
    u1022 = p1024;

    if u1020 then
        if not u1021 then
            u10.clearConnectionsAndThreads(u1023);
            u1021 = true;
            local u1025 = game.SoundService.MusicAmbience[u1020];
            fadeSound(u1025, 0, 3);
            task.delay(5, function() -- Line: 5925
                -- upvalues: u1025 (copy), u1020 (ref), u1021 (ref), u1022 (ref), u1 (ref)
                u1025:Stop();
                u1020 = nil;
                u1021 = false;

                if u1022 then
                    u1.playMusicAmbience(u1022);
                end;
            end);
        end;
    else
        u1020 = u1022;

        if u1020 then
            local u1026 = game.SoundService.MusicAmbience[u1020];
            u1026:Play();
            u1026.Volume = 0;
            fadeSound(u1026, 1, 3);
            table.insert(u1023, u1026.Ended:Connect(function() -- Line: 5939
                -- upvalues: u1 (ref)
                u1.playMusicAmbience();
            end));

            if u1020 == "OnRunHighWanted" then
                local u1027 = false;
                table.insert(u1023, task.delay(10, function() -- Line: 5942
                    -- upvalues: LocalPlayer (ref), u1 (ref), u1027 (ref), fadeSound (ref), u1026 (copy)
                    while not LocalPlayer:GetAttribute("Pursuit") and LocalPlayer:GetAttribute("WantedLevel") do
                        if LocalPlayer.InsideLocation.Value then
                            if not u1027 then
                                u1027 = true;
                                fadeSound(u1026, 1, 0);
                            end;
                        elseif u1027 then
                            u1027 = false;
                            fadeSound(u1026, 1, 3);
                        end;

                        task.wait(1);
                    end;

                    u1.playMusicAmbience();
                end));
            end;
        end;
    end;
end;

local u1028 = u10.overlapParamsNew();
u1028.FilterDescendantsInstances = { workspace.Characters };
local u1029 = {
    pet = {},
    player = {}
};
local u1030 = {
    Medical = true,
    Fire = true
};
local u1031 = {
    _Fire = 3,
    _Laser = 20,
    _KillTrain = 100
};

local function doesPartGiveDamageInLimb(p1032, p1033) -- Line: 5972
    -- upvalues: u1028 (copy)
    for _, v in pairs(workspace:GetPartBoundsInBox(p1033.CFrame, p1033.Size, u1028)) do
        if v.Name == p1032 then
            return true;
        end;
    end;
end;

u233 = function(u1034, p1035, u1036) -- Line: 5975, Name: partGivesDamage
    -- upvalues: u1030 (copy), LocalPlayer (copy), u10 (copy), u1029 (copy), u1031 (copy), u1028 (copy), PlayerEvent (copy)
    if u1036 or (not u1030[LocalPlayer.Team.Name] or u1034.Name ~= "_Laser") then
        local u1037 = u1036 and "pet" or "player";

        if u10.isTableEmpty(u1029[u1037]) then
            task.defer(function() -- Line: 5979
                -- upvalues: u1034 (copy), u1031 (ref), u1029 (ref), u1037 (copy), u1028 (ref), PlayerEvent (ref), u1036 (copy)
                while true do
                    if not (u1034.Parent and u1031[u1034.Name]) then
                        table.clear(u1029[u1037]);

                        return;
                    end;

                    local v1038 = false;

                    for i, _ in pairs(u1029[u1037]) do
                        local v1039;

                        if i:IsDescendantOf(game) then
                            local Name = u1034.Name;
                            v1039 = i;
                            local v1040 = nil;

                            for _, v in pairs(workspace:GetPartBoundsInBox(i.CFrame, i.Size, u1028)) do
                                if v.Name == Name then
                                    v1040 = true;
                                    break;
                                end;
                            end;

                            if v1040 then
                                v1038 = true;
                            end;
                        else
                            v1039 = i;
                        end;

                        u1029[u1037][v1039] = nil;
                    end;

                    if not v1038 then
                        return;
                    end;

                    PlayerEvent:FireServer("takeDamage", u1031[u1034.Name], nil, u1034.Name == "_Fire" and 4 or (u1034.Name == "_Laser" and 5 or (u1034.Name == "_KillTrain" and 7 or false)), u1036, u1034);
                    task.wait(0.5);
                end;
            end);
        end;

        u1029[u1037][p1035] = true;
    end;

    return true;
end;

local u1041 = {};
pcall(function() -- Line: 6004
    -- upvalues: u1041 (ref), StarterGui (copy)
    u1041 = StarterGui:GetCore("GetBlockedUserIds");
    StarterGui:GetCore("PlayerBlockedEvent").Event:Connect(function(p1042) -- Line: 6006
        p1042:SetAttribute("Blocked", true);
    end);
    StarterGui:GetCore("PlayerUnblockedEvent").Event:Connect(function(p1043) -- Line: 6007
        p1043:SetAttribute("Blocked", nil);
    end);
    StarterGui:GetCore("PlayerFriendedEvent").Event:Connect(function(p1044) -- Line: 6008
        p1044:SetAttribute("Friends", true);
    end);
    StarterGui:GetCore("PlayerUnfriendedEvent").Event:Connect(function(p1045) -- Line: 6009
        p1045:SetAttribute("Friends", nil);
    end);
end);

local function loadOtherPlayer(u1046) -- Line: 6012
    -- upvalues: LocalPlayer (copy), u1041 (ref)
    pcall(function() -- Line: 6013
        -- upvalues: u1046 (copy), LocalPlayer (ref), u1041 (ref)
        if u1046:IsFriendsWithAsync(LocalPlayer.UserId) then
            u1046:SetAttribute("Friends", true);
        end;

        for _, v in pairs(u1041) do
            if v == u1046.UserId then
                u1046:SetAttribute("Blocked", true);

                return;
            end;
        end;
    end);
end;

u10.loadedPlayerAdded(u10.buildSignalData, {}, nil, loadOtherPlayer);

for _, v in pairs(u10.getLoadedPlayers()) do
    task.defer(loadOtherPlayer, v);
end;

u1.debugLoadingClient("Core 5");

local function selectNumber(p1047) -- Line: 6024
    -- upvalues: u2 (copy), u4 (copy)
    if u2.loaded then
        if u2.selectionWheelUserNumberInput then
            u2.selectionWheelUserNumberInput(p1047);

            return;
        end;

        if u2.emoteBindUserInput and u2.emoteBindUserInput(p1047) then
            return;
        end;

        if u2.smartRadioUserNumberInput then
            u2.smartRadioUserNumberInput(p1047);

            return;
        end;

        if u4.equipUserInput then
            u4.equipUserInput(p1047);
        end;
    end;
end;

local function movementFunc() -- Line: 6033
    -- upvalues: UserInputService (copy), u2 (copy)
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
        u2.runningUserInput(true);
    end;
end;

local u1050 = {
    [Enum.KeyCode.W] = function() -- Line: 6035
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.A] = function() -- Line: 6036
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.S] = function() -- Line: 6037
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.D] = function() -- Line: 6038
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.One] = function() -- Line: 6040
        -- upvalues: selectNumber (copy)
        selectNumber(1);
    end,

    [Enum.KeyCode.Two] = function() -- Line: 6041
        -- upvalues: selectNumber (copy)
        selectNumber(2);
    end,

    [Enum.KeyCode.Three] = function() -- Line: 6042
        -- upvalues: selectNumber (copy)
        selectNumber(3);
    end,

    [Enum.KeyCode.Four] = function() -- Line: 6043
        -- upvalues: selectNumber (copy)
        selectNumber(4);
    end,

    [Enum.KeyCode.Five] = function() -- Line: 6044
        -- upvalues: selectNumber (copy)
        selectNumber(5);
    end,

    [Enum.KeyCode.Six] = function() -- Line: 6045
        -- upvalues: selectNumber (copy)
        selectNumber(6);
    end,

    [Enum.KeyCode.Seven] = function() -- Line: 6046
        -- upvalues: selectNumber (copy)
        selectNumber(7);
    end,

    [Enum.KeyCode.Eight] = function() -- Line: 6047
        -- upvalues: selectNumber (copy)
        selectNumber(8);
    end,

    [Enum.KeyCode.Nine] = function() -- Line: 6048
        -- upvalues: selectNumber (copy)
        selectNumber(9);
    end,

    [Enum.KeyCode.Zero] = function() -- Line: 6049
        -- upvalues: selectNumber (copy)
        selectNumber(10);
    end,

    [Enum.KeyCode.Tab] = function() -- Line: 6050
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.selectionWheelUserInput();
        end;
    end,

    [Enum.KeyCode.X] = function() -- Line: 6051
        -- upvalues: u2 (copy), u5 (copy)
        if u2.loaded then
            u5.pullOutPhoneUserInput();
        end;
    end,

    [Enum.KeyCode.Comma] = function() -- Line: 6052
        -- upvalues: u2 (copy)
        if u2.loaded and u2.smartRadioUserInput then
            u2.smartRadioUserInput();
        end;
    end,

    [Enum.KeyCode.Period] = function() -- Line: 6053
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.emoteMenu(true);
        end;
    end,

    [Enum.KeyCode.LeftShift] = function() -- Line: 6054
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.runningUserInput();
        end;
    end,

    [Enum.KeyCode.LeftControl] = function() -- Line: 6055
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.slowWalkingUserInput();
        end;
    end,

    [Enum.KeyCode.M] = function() -- Line: 6056
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.activateMap();
        end;
    end,

    [Enum.KeyCode.F] = function() -- Line: 6057
        -- upvalues: u3 (copy)
        u3.enterVehicle(false, {
            playerInput = true
        });
    end,

    [Enum.KeyCode.Backquote] = function() -- Line: 6058
        -- upvalues: u1 (copy)
        u1.activateMenu("Leaderboard");
    end,

    [Enum.KeyCode.P] = function() -- Line: 6059
        -- upvalues: UserInputService (copy), u1 (copy)
        if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            u1.activateMenu();
        end;
    end,

    [Enum.KeyCode.Z] = function() -- Line: 6060
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.crouchUserInput();
        end;
    end,

    [Enum.KeyCode.B] = function() -- Line: 6061
        -- upvalues: u2 (copy), u4 (copy)
        if u2.loaded then
            u4.inventoryUserInput();
        end;
    end,

    [Enum.KeyCode.Slash] = function() -- Line: 6062
        -- upvalues: u2 (copy), u5 (copy)
        if u2.loaded and u5.openChatUserInput then
            u5.openChatUserInput();

            return;
        end;

        if u2.chatModule then
            u2.chatModule.openChatUserInput();
        end;
    end,

    [Enum.KeyCode.T] = function() -- Line: 6063
        -- upvalues: u2 (copy), u6 (copy)
        if u2.loaded and u6.setAssetNoCollisionUserInput then
            u6.setAssetNoCollisionUserInput();

            return;
        end;

        if u2.chatModule and u2.chatModule.transmitUserInput then
            u2.chatModule.transmitUserInput();
        end;
    end,

    [Enum.KeyCode.C] = function() -- Line: 6064
        -- upvalues: u2 (copy)
        if u2.chatModule and u2.chatModule.transmitVoiceUserInput then
            u2.chatModule.transmitVoiceUserInput();
        end;
    end,

    [Enum.KeyCode.N] = function() -- Line: 6065
        -- upvalues: u2 (copy)
        if u2.loaded and u2.activateMDT then
            u2.activateMDT();
        end;
    end,

    [Enum.KeyCode.V] = function() -- Line: 6068
        -- upvalues: u3 (copy)
        if u3.activateFirstPersonCameraVehicle then
            u3.activateFirstPersonCameraVehicle();
        end;
    end,

    [Enum.KeyCode.Equals] = function() -- Line: 6069
        -- upvalues: u2 (copy)
        if u2.loaded and u2.activateRoleplayScene then
            u2.activateRoleplayScene(true);
        end;
    end,

    [Enum.KeyCode.O] = function() -- Line: 6070
        -- upvalues: u3 (copy)
        if u3.wearSeatbelt then
            u3.wearSeatbelt();
        end;
    end,

    [Enum.KeyCode.Semicolon] = function() -- Line: 6071
        -- upvalues: u3 (copy)
        if u3.switchNeon then
            u3.switchNeon();
        end;
    end,

    [Enum.UserInputType.Touch] = function(p1048, p1049) -- Line: 6072
        -- upvalues: u2 (copy), u1 (copy)
        if u2.chatModule and u2.chatModule.chatMessageMouseUserInput then
            task.spawn(function() -- Line: 6073
                -- upvalues: u1 (ref), u2 (ref)
                if u1.mobileInputServiceClick() and (u2.chatModule and u2.chatModule.chatMessageMouseUserInput) then
                    u2.chatModule.chatMessageMouseUserInput();
                end;
            end);
        end;

        if u1.mobileInputServiceClick() then
            if u2.loaded then
                u2.roleplaySceneInteractMouseUserInput(p1048, p1049);
            end;

            if not u1.dragging then
                u1.startDragging(true);
            end;
        end;
    end,

    [Enum.KeyCode.Quote] = function() -- Line: 6079
        -- upvalues: u2 (copy)
        if u2.loaded and u2.activateELSLightsUserInput then
            u2.activateELSLightsUserInput(Enum.KeyCode.Quote);
        end;
    end,

    [Enum.KeyCode.LeftBracket] = function() -- Line: 6080
        -- upvalues: u2 (copy)
        if u2.loaded and u2.activateELSManualUserInput then
            u2.activateELSManualUserInput(Enum.KeyCode.LeftBracket);
        end;
    end,

    [Enum.KeyCode.RightBracket] = function() -- Line: 6081
        -- upvalues: u2 (copy)
        if u2.loaded and u2.activateELSAutoUserInput then
            u2.activateELSAutoUserInput(Enum.KeyCode.RightBracket);
        end;
    end
};
local u1053 = {
    [Enum.KeyCode.Up] = function() -- Line: 6084
        -- upvalues: u2 (copy)
        if u2.chatModule then
            u2.chatModule.chatHistoryMoveUserInput(true);
        end;
    end,

    [Enum.KeyCode.Down] = function() -- Line: 6085
        -- upvalues: u2 (copy)
        if u2.chatModule then
            u2.chatModule.chatHistoryMoveUserInput(false);
        end;
    end,

    [Enum.UserInputType.MouseButton1] = function(p1051, p1052) -- Line: 6086
        -- upvalues: u2 (copy), u1 (copy)
        if u2.chatModule and u2.chatModule.chatMessageMouseUserInput then
            u2.chatModule.chatMessageMouseUserInput();
        end;

        u1.startDragging(true);

        if u2.makeSmowballUserInput then
            u2.makeSmowballUserInput(p1052);
        end;

        if u2.loaded then
            u2.roleplaySceneInteractMouseUserInput(p1051, p1052);
        end;
    end,

    [Enum.UserInputType.MouseButton2] = function() -- Line: 6092
        -- upvalues: u2 (copy)
        if u2.chatModule and u2.chatModule.chatMessageMouseUserInput then
            u2.chatModule.chatMessageMouseUserInput();
        end;
    end
};
local u1054 = {
    [Enum.KeyCode.W] = function() -- Line: 6095
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.A] = function() -- Line: 6096
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.S] = function() -- Line: 6097
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.D] = function() -- Line: 6098
        -- upvalues: UserInputService (copy), u2 (copy)
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and u2.loaded then
            u2.runningUserInput(true);
        end;
    end,

    [Enum.KeyCode.LeftShift] = function() -- Line: 6100
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.stopRunningUserInput();
        end;
    end,

    [Enum.KeyCode.LeftControl] = function() -- Line: 6101
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.stopSlowWalkingUserInput();
        end;
    end,

    [Enum.KeyCode.Tab] = function() -- Line: 6102
        -- upvalues: u2 (copy), u1 (copy)
        if u2.loaded then
            u2.stopSelectionWheelUserInput();
        end;

        if u1.isMenuActive == "Leaderboard" then
            u1.activateMenu(false);
        end;

        if u2.stopEmoteMenuUserInput then
            u2.stopEmoteMenuUserInput();
        end;
    end,

    [Enum.KeyCode.Period] = function() -- Line: 6103
        -- upvalues: u2 (copy)
        if u2.loaded then
            u2.stopEmoteMenuUserInput();
        end;
    end,

    [Enum.KeyCode.Backquote] = function() -- Line: 6104
        -- upvalues: u1 (copy)
        u1.activateMenu(false);
    end,

    [Enum.KeyCode.C] = function() -- Line: 6105
        -- upvalues: u2 (copy)
        if u2.chatModule and u2.chatModule.stopTransmitVoiceUserInput then
            u2.chatModule.stopTransmitVoiceUserInput();
        end;
    end
};
local u1058 = {
    [Enum.UserInputType.MouseWheel] = function(p1055) -- Line: 6109
    end,

    [Enum.UserInputType.MouseMovement] = function(p1056) -- Line: 6110
        -- upvalues: u2 (copy)
        if u2.loaded and u2.updateToolSwayFirstPerson then
            u2.updateToolSwayFirstPerson(p1056);
        end;
    end,

    [Enum.UserInputType.Touch] = function(p1057) -- Line: 6111
        -- upvalues: u2 (copy)
        if u2.loaded and u2.updateToolSwayFirstPerson then
            u2.updateToolSwayFirstPerson(p1057);
        end;
    end
};
u10.buildSignalData({}, { UserInputService.InputBegan, function(p1059, p1060) -- Line: 6113
        -- upvalues: u1053 (copy), u1 (copy), u1050 (copy)
        local v1061 = p1059.KeyCode == Enum.KeyCode.Unknown and p1059.UserInputType or p1059.KeyCode;

        if u1053[v1061] then
            u1053[v1061](p1059, p1060);
        end;

        if u1.canPressKey(v1061) and u1050[v1061] then
            u1050[v1061](p1059, p1060);
        end;
    end });
u10.buildSignalData({}, { UserInputService.InputEnded, function(p1062) -- Line: 6118
        -- upvalues: u1054 (copy)
        local v1063 = p1062.KeyCode == Enum.KeyCode.Unknown and p1062.UserInputType or p1062.KeyCode;

        if u1054[v1063] then
            u1054[v1063](p1062);
        end;
    end });
u10.buildSignalData({}, { UserInputService.InputChanged, function(p1064) -- Line: 6122
        -- upvalues: u1058 (copy)
        local v1065 = p1064.KeyCode == Enum.KeyCode.Unknown and p1064.UserInputType or p1064.KeyCode;

        if u1058[v1065] then
            u1058[v1065](p1064);
        end;
    end });
local u1066 = nil;
local u1067 = nil;
local u1068 = nil;
local VelocityWind = game.SoundService.VelocityWind;
local Volume = VelocityWind.Volume;
local u1069 = 1;
local u1070 = false;

local function activateSmoothFov(u1071) -- Line: 6135
    -- upvalues: u1070 (ref), u1069 (ref), u1067 (ref), u1068 (ref), u10 (copy)
    if u1071 then
        u1070 = true;
    end;

    u1069 = (u1069 + 1) % 100;
    local u1072 = u1069;
    task.spawn(function() -- Line: 6139
        -- upvalues: u1071 (copy), u1067 (ref), u1068 (ref), u1069 (ref), u1072 (copy), u10 (ref), u1070 (ref)
        local task_wait_ret = task.wait();

        while (u1071 or math.abs(u1067 - u1068) > 0.01) and u1069 == u1072 do
            u1068 = u10.lerp(u1068, u1067, 1 - 0.001 ^ task_wait_ret);
            workspace.Camera.FieldOfView = u1068;
            task_wait_ret = task.wait();
        end;

        if u1069 == u1072 then
            workspace.Camera.FieldOfView = u1067;
        end;

        if u1071 then
            u1070 = false;
        end;
    end);
end;

function u1.resetFov() -- Line: 6150
    -- upvalues: u1066 (ref), u1 (copy), u1067 (ref), u1068 (ref)
    u1066 = u1.initialFOV;
    u1067 = u1.initialFOV;
    u1068 = u1.initialFOV;
end;

u1.resetFov();

function u1.changeFOV(p1073) -- Line: 6156
    -- upvalues: u1066 (ref), u1070 (ref), u1067 (ref), u1069 (ref), u1068 (ref), u10 (copy)
    u1066 = u1066 + p1073;

    if not u1070 then
        u1067 = u1066;
        u1069 = (u1069 + 1) % 100;
        local u1074 = u1069;
        local u1075 = nil;
        task.spawn(function() -- Line: 6139
            -- upvalues: u1075 (copy), u1067 (ref), u1068 (ref), u1069 (ref), u1074 (copy), u10 (ref), u1070 (ref)
            local task_wait_ret = task.wait();

            while (u1075 or math.abs(u1067 - u1068) > 0.01) and u1069 == u1074 do
                u1068 = u10.lerp(u1068, u1067, 1 - 0.001 ^ task_wait_ret);
                workspace.Camera.FieldOfView = u1068;
                task_wait_ret = task.wait();
            end;

            if u1069 == u1074 then
                workspace.Camera.FieldOfView = u1067;
            end;

            if u1075 then
                u1070 = false;
            end;
        end);
    end;
end;

task.defer(function() -- Line: 6163
    -- upvalues: u2 (copy), u1070 (ref), u1069 (ref), u1067 (ref), u1068 (ref), u10 (copy), u1066 (ref), VelocityWind (copy), Volume (copy)
    while true do
        if (u2.root and u2.root.AssemblyLinearVelocity.Magnitude or 0) > 50 then
            u1070 = true;
            u1069 = (u1069 + 1) % 100;
            local u1076 = u1069;
            local u1077 = true;
            task.spawn(function() -- Line: 6139
                -- upvalues: u1077 (copy), u1067 (ref), u1068 (ref), u1069 (ref), u1076 (copy), u10 (ref), u1070 (ref)
                local task_wait_ret = task.wait();

                while (u1077 or math.abs(u1067 - u1068) > 0.01) and u1069 == u1076 do
                    u1068 = u10.lerp(u1068, u1067, 1 - 0.001 ^ task_wait_ret);
                    workspace.Camera.FieldOfView = u1068;
                    task_wait_ret = task.wait();
                end;

                if u1069 == u1076 then
                    workspace.Camera.FieldOfView = u1067;
                end;

                if u1077 then
                    u1070 = false;
                end;
            end);
            local v1078;

            repeat
                v1078 = u2.root and u2.root.AssemblyLinearVelocity.Magnitude or 0;
                u1067 = u1066 + math.clamp((v1078 - 50) * 1.1, 0, 150) * 0.1;

                if v1078 > 100 then
                    if not VelocityWind.IsPlaying then
                        VelocityWind:Play();
                    end;

                    VelocityWind.Volume = math.min(50, v1078 - 100) / 50 * Volume;
                elseif VelocityWind.IsPlaying then
                    VelocityWind:Stop();
                end;

                task.wait();
            until v1078 < 50;

            u1067 = u1066;
            u1069 = (u1069 + 1) % 100;
            local u1079 = u1069;
            local u1080 = nil;
            task.spawn(function() -- Line: 6139
                -- upvalues: u1080 (copy), u1067 (ref), u1068 (ref), u1069 (ref), u1079 (copy), u10 (ref), u1070 (ref)
                local task_wait_ret = task.wait();

                while (u1080 or math.abs(u1067 - u1068) > 0.01) and u1069 == u1079 do
                    u1068 = u10.lerp(u1068, u1067, 1 - 0.001 ^ task_wait_ret);
                    workspace.Camera.FieldOfView = u1068;
                    task_wait_ret = task.wait();
                end;

                if u1069 == u1079 then
                    workspace.Camera.FieldOfView = u1067;
                end;

                if u1080 then
                    u1070 = false;
                end;
            end);

            if VelocityWind.IsPlaying then
                VelocityWind:Stop();
            end;
        end;

        task.wait(0.25);
    end;
end);
u1.isDay = nil;
u1.weekDay = nil;
u1.weatherParticleObjActive = false;
u10.clone(game_Lighting.Atmosphere).Parent = Weather;
local Atmosphere = game_Lighting.Atmosphere;
local u1081 = {
    clearDay = Atmosphere.Color,
    fogDay = Weather.FogAtmosphere.Color,
    thunderstormDay = Weather.ThunderstormAtmosphere.Color,
    snowDay = Weather.SnowAtmosphere.Color,
    blizzardDay = Weather.BlizzardAtmosphere.Color,
    clearNight = Color3.fromRGB(80, 80, 80),
    fogNight = Color3.fromRGB(80, 80, 80),
    thunderstormNight = Color3.fromRGB(80, 80, 80),
    snowNight = Color3.fromRGB(80, 80, 80),
    blizzardNight = Color3.fromRGB(80, 80, 80)
};
local ParticleObj = Weather.ParticleObj;
local Clouds = workspace.Terrain.Clouds;
local u1082 = {
    off = {
        Cover = 0,
        Density = 0
    },
    thunderstorm = {
        Cover = 0.862,
        Density = 0.241,
        Color = Color3.fromRGB(99, 112, 130)
    },
    windy = {
        Cover = 0.632,
        Density = 0.261,
        Color = Color3.fromRGB(255, 255, 255)
    }
};
local u1083 = {};
local u1084 = true;
local u1085 = false;

for _, v in pairs({ "Snow", "Thunderstorm", "Blizzard" }) do
    u1083[v .. "Rate"] = Weather[v]:GetChildren()[1].Rate;
    u1083[v .. "Transparency"] = Weather[v]:GetChildren()[1].Transparency;
end;

local function seralizeColorCorrection(p1086) -- Line: 6207
    return {
        Brightness = p1086.Brightness,
        Contrast = p1086.Contrast,
        Saturation = p1086.Saturation,
        TintColor = p1086.TintColor
    };
end;

local function serializeClouds(p1087) -- Line: 6210
    -- upvalues: u10 (copy), u1 (copy)
    local v1088 = u10.deepCopyTable(p1087);

    if not u1.isDay then
        v1088.Color = Color3.fromRGB(19, 20, 22);
    end;

    return v1088;
end;

local u1089 = {
    Brightness = game_Lighting.Brightness
};

local function serializeLighting(p1090) -- Line: 6216
    -- upvalues: u1089 (copy)
    local v1091 = {};

    for _, v in pairs({ "Brightness" }) do
        v1091[v] = p1090 and p1090:FindFirstChild(v) and p1090[v].Value or u1089[v];
    end;

    return v1091;
end;

u1.currentColorCorrection = nil;

local function updatePostEffect(p1092, p1093) -- Line: 6224
    -- upvalues: Variables (copy), u1 (copy), game_Lighting (copy), GameRules (copy), u229 (ref), serializeLighting (copy), u10 (copy)
    local v1094 = game_Lighting.ColorCorrection[GameRules.season == "Winter" and "Winter" or "Summer"];
    u1.currentColorCorrection = not u229 and v1094.Inside or (v1094:FindFirstChild((p1093 or Variables.Weather.Value) .. (u1.isDay and "Day" or "Night")) or v1094[u1.isDay and "Day" or "Night"]);
    local v1095 = serializeLighting(u1.currentColorCorrection:FindFirstChild("Lighting"));
    local v1096 = false;

    for i, v in pairs(v1095) do
        if v ~= game_Lighting[i] then
            v1096 = true;
        end;
    end;

    if not p1092 then
        if v1096 then
            u10.tweenServiceSet(game_Lighting, v1095);
        end;

        local currentColorCorrection = u1.currentColorCorrection;
        u10.tweenServiceSet(game_Lighting.ColorCorrection, {
            Brightness = currentColorCorrection.Brightness,
            Contrast = currentColorCorrection.Contrast,
            Saturation = currentColorCorrection.Saturation,
            TintColor = currentColorCorrection.TintColor
        });

        return;
    end;

    if v1096 then
        u10.tweenServiceStart(game_Lighting, TweenInfo.new(p1092, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), v1095);
    end;

    local tweenServiceStart = u10.tweenServiceStart;
    local ColorCorrection = game_Lighting.ColorCorrection;
    local TweenInfo_new_ret = TweenInfo.new(p1092, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local currentColorCorrection = u1.currentColorCorrection;
    tweenServiceStart(ColorCorrection, TweenInfo_new_ret, {
        Brightness = currentColorCorrection.Brightness,
        Contrast = currentColorCorrection.Contrast,
        Saturation = currentColorCorrection.Saturation,
        TintColor = currentColorCorrection.TintColor
    });
end;

local u1097 = nil;

function updateClouds(p1098, p1099)
    -- upvalues: u1097 (ref), u10 (copy), u1 (copy), u1082 (copy), Variables (copy), Clouds (copy)
    if u1097 then
        u10.taskCancel(u1097);
        u1097 = nil;
    end;

    local v1100 = not u1.visualizedLocation and u1082[string.lower(p1099 or Variables.Weather.Value)];

    if v1100 or not p1098 then
        Clouds.Enabled = v1100;
    else
        u1097 = task.delay(p1098, function() -- Line: 6253
            -- upvalues: Clouds (ref)
            Clouds.Enabled = false;
        end);
    end;

    if p1098 then
        local v1101 = u10.deepCopyTable(v1100 or u1082.off);

        if not u1.isDay then
            v1101.Color = Color3.fromRGB(19, 20, 22);
        end;

        if Clouds.Cover <= 0 then
            u10.tweenServiceSet(Clouds, {
                Color = v1101.Color
            });
        end;

        u10.tweenServiceStart(Clouds, TweenInfo.new(p1098, Enum.EasingStyle.Quart, v1100 and Enum.EasingDirection.Out or Enum.EasingDirection.In), v1101);

        return;
    end;

    local tweenServiceSet = u10.tweenServiceSet;
    local v1102 = u10.deepCopyTable(v1100 or u1082.off);

    if not u1.isDay then
        v1102.Color = Color3.fromRGB(19, 20, 22);
    end;

    tweenServiceSet(Clouds, v1102);
    Clouds.Enabled = v1100;
end;

function u1.visualizeTimeOfDay(p1103) -- Line: 6267
    -- upvalues: Atmosphere (copy), game_Lighting (copy), u229 (ref), GameRules (copy), u1 (copy), updatePostEffect (copy)
    Atmosphere.Parent = p1103 and game_Lighting or nil;
    u229 = p1103;

    if p1103 and not GameRules.disableTimeOfDay then
        game_Lighting.ClockTime = u1.clockTime;
    end;

    updatePostEffect(nil);
    updateClouds(nil);
end;

u1.clockTime = 0;

function setGlass(p1104, p1105)
    p1104.Material = p1105 and Enum.Material.SmoothPlastic or Enum.Material.Neon;
    p1104.Color = p1105 and p1104:GetAttribute("Glass") or (p1104:GetAttribute("GlassLight") or Color3.fromRGB(116, 111, 108));
end;

local u1106 = {
    neon1 = {},
    neon2 = {},
    lights = {},
    glassLight = {},
    lightsInside = {}
};

local function timeOfDayLights(p1107, p1108) -- Line: 6282
    -- upvalues: u1106 (ref)
    local v1109 = 1;

    for i, _ in pairs(u1106.lightsInside) do
        i.Transparency = p1107 and 1 or 0;
        i.Light.Enabled = not p1107;
    end;

    for i, _ in pairs(u1106.lights) do
        v1109 = v1109 + 1;
        i.Material = p1107 and Enum.Material.SmoothPlastic or Enum.Material.Neon;
        i.Light.Enabled = not p1107;

        if not p1108 and v1109 % 40 == 0 then
            task.wait(0.03);
        end;
    end;

    for i, _ in pairs(u1106.neon1) do
        v1109 = v1109 + 1;
        i.Material = p1107 and Enum.Material.SmoothPlastic or Enum.Material.Neon;

        if not p1108 and v1109 % 40 == 0 then
            task.wait(0.03);
        end;
    end;

    for i, _ in pairs(u1106.neon2) do
        v1109 = v1109 + 1;
        i.Transparency = p1107 and 1 or 0;

        if not p1108 and v1109 % 40 == 0 then
            task.wait(0.03);
        end;
    end;

    for i, _ in pairs(u1106.glassLight) do
        v1109 = v1109 + 1;
        setGlass(i, p1107);

        if v1109 % 40 == 0 then
            task.wait(0.03);
        end;
    end;
end;

local function updateTimeOfDay(p1110) -- Line: 6291
    -- upvalues: u10 (copy), u1 (copy), ambienceChangeDayNight (ref), u231 (ref), u3 (copy), Variables (copy), TweenService (copy), Atmosphere (copy), u1081 (copy), timeOfDayLights (copy), updatePostEffect (copy)
    local v1111 = u10.isDayNow(p1110);

    if v1111 ~= u1.isDay then
        ambienceChangeDayNight(v1111, u1.isDay == nil);

        if u1.isDay ~= nil then
            if u231 < 4 then
                game.SoundService.Ambience[v1111 and "Day" or "Night"].Begin:Play();
            end;

            u3.vehicleTimeOfDay(v1111);
        end;

        local v1112 = string.lower(Variables.Weather.Value) .. (v1111 and "Day" or "Night");
        TweenService:Create(Atmosphere, TweenInfo.new(u1.isDay == nil and 0 or 10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Color = u1081[v1112]
        }):Play();
        task.spawn(timeOfDayLights, v1111, u1.isDay == nil);
        local v1113 = u1.isDay == nil;
        u1.isDay = v1111;
        updatePostEffect(v1113 and 0 or 15);
        updateClouds(v1113 and 0 or 10);
    end;
end;

firstTimeAlwaysDayFirstDay = false;

local function firstTimeAlwaysDay(p1114) -- Line: 6310
    if game.Lighting:GetAttribute("Freezetime") or firstTimeAlwaysDayFirstDay == "Done" then
        return p1114;
    end;

    if firstTimeAlwaysDayFirstDay then
        if p1114 > 12 then
            firstTimeAlwaysDayFirstDay = "Done";
        end;
    elseif p1114 < 12 then
        firstTimeAlwaysDayFirstDay = true;
    end;

    return 12;
end;

if GameRules.disableTimeOfDay then
    updateTimeOfDay(game_Lighting.ClockTime);
else
    task.spawn(function() -- Line: 6328
        -- upvalues: u10 (copy), GameRules (copy), u1 (copy), LocalPlayer (copy), u229 (ref), game_Lighting (copy), updateTimeOfDay (copy)
        while true do
            local v1115 = u10.isPrivateServerConfigurationSettingEnabled("dayNightLength");
            local v1116 = u10.getDistributedGameTime() / ((v1115 or GameRules.dayInMinutes) * 60);
            local math_ceil_ret = math.ceil(v1116 % 7);
            u1.weekDay = math.max(1, math_ceil_ret);
            local ActualClockTime = u10.getActualClockTime(v1116 * 24);

            if LocalPlayer:GetAttribute("FirstPlay") and (not game.Lighting:GetAttribute("Freezetime") and firstTimeAlwaysDayFirstDay ~= "Done") then
                if firstTimeAlwaysDayFirstDay then
                    if ActualClockTime > 12 then
                        firstTimeAlwaysDayFirstDay = "Done";
                        ActualClockTime = 12;
                    else
                        ActualClockTime = 12;
                    end;
                elseif ActualClockTime < 12 then
                    firstTimeAlwaysDayFirstDay = true;
                    ActualClockTime = 12;
                else
                    ActualClockTime = 12;
                end;
            end;

            if u229 then
                game_Lighting.ClockTime = ActualClockTime;
            end;

            u1.clockTime = ActualClockTime;
            updateTimeOfDay(ActualClockTime);
            task.wait(0.3);
        end;
    end);
end;

u1.playAmbience("Global", 2, {});

u232 = function() -- Line: 6347, Name: particleObjVisualizeFunc
    -- upvalues: u1085 (ref), u1 (copy), u1084 (ref), ParticleObj (copy), u1083 (copy)
    local v1117 = not u1085 and not u1.visualizedLocation;

    if u1.weatherParticleObjActive and u1084 ~= v1117 then
        u1084 = v1117;

        for _, child in pairs(ParticleObj.PrimaryPart:GetChildren()) do
            child.Transparency = v1117 and u1083[u1.weatherParticleObjActive .. "Transparency"] or NumberSequence.new(1);
        end;
    end;
end;

local u1118 = {};

local function activateParticleObj(p1119, u1120, p1121) -- Line: 6355
    -- upvalues: u1118 (copy), u10 (copy), u1085 (ref), ParticleObj (copy), Weather (copy), TweenService (copy), u1 (copy), u1084 (ref), u1083 (copy), LocalPlayer (copy), u2 (copy), workspace_CurrentCamera (copy), u232 (ref)
    for _, v in pairs(u1118) do
        u10.taskCancel(v);
    end;

    table.clear(u1118);
    u1085 = false;

    if ParticleObj.Parent ~= Weather then
        for _, child in pairs(ParticleObj.PrimaryPart:GetChildren()) do
            TweenService:Create(child, TweenInfo.new(p1119 or 0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Rate = 0
            }):Play();
        end;

        table.insert(u1118, task.delay(p1119 and (p1119 + 10 or 0) or 0, function() -- Line: 6361
            -- upvalues: ParticleObj (ref), Weather (ref), u1 (ref), u1084 (ref)
            ParticleObj.Parent = Weather;
            u1.weatherParticleObjActive = false;
            u1084 = false;

            for _, child in pairs(ParticleObj.PrimaryPart:GetChildren()) do
                child.Enabled = false;
            end;
        end));
    end;

    if u1120 then
        u1084 = true;
        ParticleObj.Parent = workspace.Gameplay.Entities;
        ParticleObj.PrimaryPart:ClearAllChildren();

        for _, child in pairs(Weather[u1120]:GetChildren()) do
            local v1122 = u10.clone(child);
            v1122.Rate = 0;
            v1122.Parent = ParticleObj.PrimaryPart;
            TweenService:Create(v1122, TweenInfo.new(p1119 or 0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Rate = u1083[u1120 .. "Rate"]
            }):Play();
        end;

        u1.weatherParticleObjActive = u1120;
        local u1123 = {};

        for _, child in pairs(game.ReplicatedStorage.Gameplay.WorldModel.RegionAmbience:GetChildren()) do
            if child.Name == "_Tunnel" then
                table.insert(u1123, child);
            end;
        end;

        table.insert(u1118, task.defer(function() -- Line: 6383
            -- upvalues: LocalPlayer (ref), u2 (ref), workspace_CurrentCamera (ref), u1085 (ref), u1123 (copy), u10 (ref), u232 (ref)
            while true do
                local v1124 = LocalPlayer.ReplicationFocus and LocalPlayer.ReplicationFocus:GetPivot().Position or (u2.root and u2.root.Position or workspace_CurrentCamera.CFrame.Position);
                u1085 = false;

                for _, v in pairs(u1123) do
                    if u10.isPointInArea(v.CFrame, v.Size, v1124) then
                        u1085 = true;
                    end;
                end;

                u232();
                task.wait(0.7);
            end;
        end));
        local u1125 = p1121 or CFrame.new(0, 45, 0);
        table.insert(u1118, task.defer(function() -- Line: 6395
            -- upvalues: Weather (ref), u1120 (copy), u1083 (ref), u2 (ref), ParticleObj (ref), workspace_CurrentCamera (ref), u1125 (copy)
            if Weather[u1120]:GetChildren()[1].LockedToPart then
                while true do
                    ParticleObj:PivotTo(CFrame.new(workspace_CurrentCamera.CFrame.Position) * u1125);
                    task.wait();
                end;
            end;

            local v1126 = u1083[u1120 .. "Rate"];

            while true do
                local v1127 = u2.root and Vector3.new(u2.root.AssemblyLinearVelocity.X, 0, u2.root.AssemblyLinearVelocity.Z);

                if v1127 and v1126 <= ParticleObj.PrimaryPart:GetChildren()[1].Rate then
                    local math_abs_ret = math.abs(v1127.Magnitude);
                    local v1128 = v1126 * (math.min(100, math_abs_ret) / 100 * 3 + 1);

                    for _, child in pairs(ParticleObj.PrimaryPart:GetChildren()) do
                        child.Rate = v1128;
                    end;
                end;

                ParticleObj:PivotTo(CFrame.new(workspace_CurrentCamera.CFrame.Position + (v1127 and v1127 * 0.5 or Vector3.new())) * (v1127 and CFrame.Angles(math.clamp(u2.root.AssemblyLinearVelocity.Z * 0.01, -0.5, 0.5), 0, (math.clamp(u2.root.AssemblyLinearVelocity.X * -0.01, -0.5, 0.5))) or CFrame.new()) * u1125);
                task.wait();
            end;
        end));
    end;
end;

local u1129 = nil;
local u1130 = u10.raycastParamsNew();

local function activateWeatherParticleDrop(p1131) -- Line: 6419
    -- upvalues: u1129 (ref), u1084 (ref), workspace_CurrentCamera (copy), u10 (copy), u2 (copy), u1130 (copy), Weather (copy), TweenService (copy)
    if not u1129 and p1131 then
        u1129 = p1131;
        task.defer(function() -- Line: 6422
            -- upvalues: u1129 (ref), u1084 (ref), workspace_CurrentCamera (ref), u10 (ref), u2 (ref), u1130 (ref), Weather (ref), TweenService (ref)
            while u1129 do
                if u1084 then
                    local _, v1132, _ = workspace_CurrentCamera.CFrame:ToOrientation();
                    local Position2 = u10.randomPointInArea(CFrame.new(workspace_CurrentCamera.CFrame.Position) * CFrame.Angles(0, v1132, 0) * CFrame.new(0, 0, -20), Vector3.new(40, 1, 40)).Position;
                    local v1133 = u10.raycastVisible(Position2 + (u2.root and u2.root.AssemblyLinearVelocity * 0.5 or Vector3.new()), Vector3.new(0, -35, 0), u1130);

                    if v1133 and v1133.Instance:IsDescendantOf(workspace.World) then
                        local v1134 = u10.clone(Weather.RainDrop);
                        v1134.CFrame = CFrame.new(v1133.Position, v1133.Position + v1133.Normal);
                        v1134.Parent = workspace.Gameplay.Entities;
                        v1134.Size = Vector3.new();
                        TweenService:Create(v1134, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            Size = Vector3.new(1.4, 1.4, 0.2)
                        }):Play();
                        TweenService:Create(v1134.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            Transparency = 1
                        }):Play();
                        u10.debrisServiceAddItem(v1134, 0.4);
                    end;
                end;

                task.wait((0.01 + math.random() * 0.1) * (6 - u1129 * 5));
            end;
        end);
    end;

    u1129 = p1131;
end;

local u1156 = {
    Thunderstorm = function(u1135, u1136) -- Line: 6447, Name: Thunderstorm
        -- upvalues: u215 (copy), activateParticleObj (copy), TweenService (copy), Atmosphere (copy), u1081 (copy), Variables (copy), u1 (copy), Weather (copy), updatePostEffect (copy), u1129 (ref), u1084 (ref), workspace_CurrentCamera (copy), u10 (copy), u2 (copy), u1130 (copy)
        updateClouds(u1136 or (u1135 and 45 or 30), u1135 and "Thunderstorm");

        if u1135 then
            task.wait(u1136 or 15);
            local v1137 = math.random() * 3.141592653589793;
            u215.Thunderstorm.GlobalWind = (CFrame.Angles(0, v1137, 0) * CFrame.new(0, 0, 3.5)).Position;
            activateParticleObj(u1136 or 20, "Thunderstorm");
        end;

        task.spawn(function() -- Line: 6455
            -- upvalues: u1135 (copy), u1136 (copy), TweenService (ref), Atmosphere (ref), u1081 (ref), Variables (ref), u1 (ref)
            if not u1135 then
                task.wait(u1136 or 29);
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Color = u1081[string.lower(Variables.Weather.Value) .. (u1.isDay and "Day" or "Night")]
            }):Play();
        end);
        task.spawn(function() -- Line: 6459
            -- upvalues: u1135 (copy), TweenService (ref), Atmosphere (ref), u1136 (copy), Weather (ref)
            if u1135 then
                TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Haze = 2
                }):Play();
                task.wait(u1136 or 10);
                TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 20, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    Haze = Weather.ThunderstormAtmosphere.Haze
                }):Play();

                return;
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 10, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Haze = 2
            }):Play();
            task.wait(u1136 or 10);
            TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Haze = 0
            }):Play();
        end);
        updatePostEffect(20, u1135 and "Thunderstorm");
        TweenService:Create(Atmosphere, TweenInfo.new(u1136 or 30, Enum.EasingStyle.Quart, u1135 and Enum.EasingDirection.Out or Enum.EasingDirection.In), u1135 and {
            Density = Weather.ThunderstormAtmosphere.Density,
            Offset = Weather.ThunderstormAtmosphere.Offset
        } or {
            Density = Weather.Atmosphere.Density,
            Offset = Weather.Atmosphere.Offset
        }):Play();
        u1.playAmbience("Rain", u1135 and 3, {
            muteLowerPriority = true,
            fadeTime = u1136 or 20
        });

        if u1135 then
            for i = 1, 20 do
                local v1138 = i / 20;

                if not u1129 and v1138 then
                    u1129 = v1138;
                    task.defer(function() -- Line: 6422
                        -- upvalues: u1129 (ref), u1084 (ref), workspace_CurrentCamera (ref), u10 (ref), u2 (ref), u1130 (ref), Weather (ref), TweenService (ref)
                        while u1129 do
                            if u1084 then
                                local _, v1139, _ = workspace_CurrentCamera.CFrame:ToOrientation();
                                local Position2 = u10.randomPointInArea(CFrame.new(workspace_CurrentCamera.CFrame.Position) * CFrame.Angles(0, v1139, 0) * CFrame.new(0, 0, -20), Vector3.new(40, 1, 40)).Position;
                                local v1140 = u10.raycastVisible(Position2 + (u2.root and u2.root.AssemblyLinearVelocity * 0.5 or Vector3.new()), Vector3.new(0, -35, 0), u1130);

                                if v1140 and v1140.Instance:IsDescendantOf(workspace.World) then
                                    local v1141 = u10.clone(Weather.RainDrop);
                                    v1141.CFrame = CFrame.new(v1140.Position, v1140.Position + v1140.Normal);
                                    v1141.Parent = workspace.Gameplay.Entities;
                                    v1141.Size = Vector3.new();
                                    TweenService:Create(v1141, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        Size = Vector3.new(1.4, 1.4, 0.2)
                                    }):Play();
                                    TweenService:Create(v1141.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        Transparency = 1
                                    }):Play();
                                    u10.debrisServiceAddItem(v1141, 0.4);
                                end;
                            end;

                            task.wait((0.01 + math.random() * 0.1) * (6 - u1129 * 5));
                        end;
                    end);
                end;

                u1129 = v1138;
                task.wait(u1136 or 1);
                local _ = i;
            end;

            u1.setGlobalWind("Thunderstorm");
            task.wait(u1136 or 10);

            return;
        end;

        activateParticleObj(u1136 or 20, false);

        for i = 20, 1, -1 do
            local v1142 = i / 20;

            if not u1129 and v1142 then
                u1129 = v1142;
                task.defer(function() -- Line: 6422
                    -- upvalues: u1129 (ref), u1084 (ref), workspace_CurrentCamera (ref), u10 (ref), u2 (ref), u1130 (ref), Weather (ref), TweenService (ref)
                    while u1129 do
                        if u1084 then
                            local _, v1143, _ = workspace_CurrentCamera.CFrame:ToOrientation();
                            local Position2 = u10.randomPointInArea(CFrame.new(workspace_CurrentCamera.CFrame.Position) * CFrame.Angles(0, v1143, 0) * CFrame.new(0, 0, -20), Vector3.new(40, 1, 40)).Position;
                            local v1144 = u10.raycastVisible(Position2 + (u2.root and u2.root.AssemblyLinearVelocity * 0.5 or Vector3.new()), Vector3.new(0, -35, 0), u1130);

                            if v1144 and v1144.Instance:IsDescendantOf(workspace.World) then
                                local v1145 = u10.clone(Weather.RainDrop);
                                v1145.CFrame = CFrame.new(v1144.Position, v1144.Position + v1144.Normal);
                                v1145.Parent = workspace.Gameplay.Entities;
                                v1145.Size = Vector3.new();
                                TweenService:Create(v1145, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                    Size = Vector3.new(1.4, 1.4, 0.2)
                                }):Play();
                                TweenService:Create(v1145.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                    Transparency = 1
                                }):Play();
                                u10.debrisServiceAddItem(v1145, 0.4);
                            end;
                        end;

                        task.wait((0.01 + math.random() * 0.1) * (6 - u1129 * 5));
                    end;
                end);
            end;

            u1129 = v1142;
            task.wait(u1136 or 1);
            local _ = i;
        end;

        u1129 = nil;
        u1.setGlobalWind("Default");
        task.wait(u1136 or 10);
    end,

    Windy = function(u1146, p1147) -- Line: 6491, Name: Windy
        -- upvalues: u1 (copy), u215 (copy)
        updateClouds(p1147 or (u1146 and 25 or 15), u1146 and "Windy");
        u1.playAmbience("WindyWeather", u1146 and 3, {
            fadeTime = p1147 or (u1146 and 25 or 15)
        });

        if u1146 then
            local v1148 = math.random() * 3.141592653589793;
            u215.Windy.GlobalWind = (CFrame.Angles(0, v1148, 0) * CFrame.new(0, 0, 2.5)).Position;
        end;

        task.delay(u1146 and 20 or 10, function() -- Line: 6498
            -- upvalues: u1 (ref), u1146 (copy)
            u1.setGlobalWind(u1146 and "Windy" or "Default");
        end);
        task.wait(u1146 and 25 or 15);
    end,

    Fog = function(u1149, u1150) -- Line: 6503, Name: Fog
        -- upvalues: TweenService (copy), Atmosphere (copy), u1081 (copy), Variables (copy), u1 (copy), Weather (copy), updatePostEffect (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Color = u1081[string.lower(Variables.Weather.Value) .. (u1.isDay and "Day" or "Night")]
        }):Play();
        task.spawn(function() -- Line: 6505
            -- upvalues: u1149 (copy), TweenService (ref), Atmosphere (ref), u1150 (copy), Weather (ref)
            if u1149 then
                TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Haze = 2
                }):Play();
                task.wait(u1150 or 10);
                TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 20, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    Haze = Weather.FogAtmosphere.Haze
                }):Play();

                return;
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 20, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Haze = 2
            }):Play();
            task.wait(u1150 or 20);
            TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Haze = 0
            }):Play();
        end);
        TweenService:Create(Atmosphere, TweenInfo.new(u1150 or 30, Enum.EasingStyle.Quint, u1149 and Enum.EasingDirection.Out or Enum.EasingDirection.In), u1149 and {
            Density = Weather.FogAtmosphere.Density,
            Offset = Weather.FogAtmosphere.Offset
        } or {
            Density = Weather.Atmosphere.Density,
            Offset = Weather.Atmosphere.Offset
        }):Play();
        updatePostEffect(20, u1149 and "Fog");
        task.wait(u1150 or 30);
    end,

    Snow = function(u1151, u1152) -- Line: 6525, Name: Snow
        -- upvalues: activateParticleObj (copy), TweenService (copy), Atmosphere (copy), u1081 (copy), Variables (copy), u1 (copy), Weather (copy), updatePostEffect (copy)
        if u1151 then
            activateParticleObj(u1152 or 20, "Snow", CFrame.new(0, 25, 0));
        end;

        task.spawn(function() -- Line: 6529
            -- upvalues: u1151 (copy), u1152 (copy), TweenService (ref), Atmosphere (ref), u1081 (ref), Variables (ref), u1 (ref)
            if not u1151 then
                task.wait(u1152 or 29);
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1152 or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Color = u1081[string.lower(Variables.Weather.Value) .. (u1.isDay and "Day" or "Night")]
            }):Play();
        end);
        task.spawn(function() -- Line: 6533
            -- upvalues: u1151 (copy), TweenService (ref), Atmosphere (ref), u1152 (copy), Weather (ref)
            if u1151 then
                TweenService:Create(Atmosphere, TweenInfo.new(u1152 or 30, Enum.EasingStyle.Quart, u1151 and Enum.EasingDirection.Out or Enum.EasingDirection.In), {
                    Haze = Weather.ThunderstormAtmosphere.Haze
                }):Play();

                return;
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1152 or 15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Haze = 0
            }):Play();
        end);
        updatePostEffect(20, u1151 and "Snow");

        if u1151 then
            task.wait(u1152 or 20);

            return;
        end;

        activateParticleObj(u1152 or 20, false);
        task.wait(u1152 or 30);
    end,

    Blizzard = function(u1153, u1154) -- Line: 6548, Name: Blizzard
        -- upvalues: u215 (copy), activateParticleObj (copy), TweenService (copy), Atmosphere (copy), u1081 (copy), Variables (copy), u1 (copy), Weather (copy), updatePostEffect (copy)
        if u1153 then
            local v1155 = math.random() * 3.141592653589793;
            u215.Blizzard.GlobalWind = (CFrame.Angles(0, v1155, 0) * CFrame.new(0, 0, 7)).Position;
            activateParticleObj(u1154 or 20, "Blizzard", CFrame.Angles(0, v1155 + 3.141592653589793, 0) * CFrame.Angles(1.2566370614359172, 0, 0) * CFrame.new(0, 65, 0));
        end;

        task.spawn(function() -- Line: 6555
            -- upvalues: u1153 (copy), u1154 (copy), TweenService (ref), Atmosphere (ref), u1081 (ref), Variables (ref), u1 (ref)
            if not u1153 then
                task.wait(u1154 or 29);
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1154 or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Color = u1081[string.lower(Variables.Weather.Value) .. (u1.isDay and "Day" or "Night")]
            }):Play();
        end);
        task.spawn(function() -- Line: 6559
            -- upvalues: u1153 (copy), TweenService (ref), Atmosphere (ref), u1154 (copy), Weather (ref)
            if u1153 then
                TweenService:Create(Atmosphere, TweenInfo.new(u1154 or 30, Enum.EasingStyle.Quart, u1153 and Enum.EasingDirection.Out or Enum.EasingDirection.In), {
                    Haze = Weather.BlizzardAtmosphere.Haze
                }):Play();

                return;
            end;

            TweenService:Create(Atmosphere, TweenInfo.new(u1154 or 15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Haze = 0
            }):Play();
        end);
        updatePostEffect(20, u1153 and "Thunderstorm");
        TweenService:Create(Atmosphere, TweenInfo.new(u1154 or 30, Enum.EasingStyle.Quart, u1153 and Enum.EasingDirection.Out or Enum.EasingDirection.In), u1153 and {
            Density = Weather.BlizzardAtmosphere.Density,
            Offset = Weather.BlizzardAtmosphere.Offset
        } or {
            Density = Weather.Atmosphere.Density,
            Offset = Weather.Atmosphere.Offset
        }):Play();
        u1.playAmbience("Blizzard", u1153 and 3, {
            muteLowerPriority = true,
            fadeTime = u1154 or 20
        });

        if u1153 then
            task.wait(u1154 or 20);
            u1.setGlobalWind("Blizzard");

            return;
        end;

        activateParticleObj(u1154 or 20, false);
        u1.setGlobalWind("Default");
        task.wait(u1154 or 30);
    end
};
local u1157 = nil;
local u1158 = false;

local function loadNewWeather(p1159) -- Line: 6581
    -- upvalues: u1158 (ref), u1157 (ref), u1156 (copy), Variables (copy), u1 (copy), loadNewWeather (copy)
    u1158 = true;

    if u1157 and u1156[u1157] then
        u1156[u1157](false);
    end;

    u1157 = Variables.Weather.Value;

    if u1156[u1157] then
        u1156[u1157](true, p1159 and 0);

        if not p1159 then
            task.defer(function() -- Line: 6588
                -- upvalues: u1 (ref)
                while u1.visualizedLocation do
                    task.wait(5);
                end;

                u1.displayTip("weatherEffects", 25);
            end);
        end;
    end;

    u1158 = false;

    if Variables.Weather.Value ~= u1157 then
        return loadNewWeather();
    end;
end;

Variables.Weather.Changed:Connect(function() -- Line: 6597
    -- upvalues: u1158 (ref), loadNewWeather (copy)
    if not u1158 then
        loadNewWeather();
    end;
end);

if u1156[Variables.Weather.Value] then
    task.spawn(loadNewWeather, true);
end;

local u1160 = {};

function u1.mutePlayer(p1161, p1162, p1163) -- Line: 6606
    -- upvalues: u10 (copy), LocalPlayer (copy), u1 (copy)
    if not p1161 then
        u1.notify({
            message = "You have to include a name",
            color = "red"
        });

        return;
    end;

    for _, v in pairs(u10.getLoadedPlayers()) do
        if v ~= LocalPlayer and string.lower(v.DisplayName) == string.lower(p1161) then
            u1.mutedPlayerId[v.UserId] = p1162 and true or nil;
            u1.notify({
                color = "green",
                message = (p1162 and "Muted " or "Unmuted ") .. (p1163 or v.DisplayName)
            });

            return true;
        end;
    end;

    u1.notify({
        message = "Player not found",
        color = "red"
    });
end;

function u1.createChat(u1164, u1165) -- Line: 6619
    -- upvalues: u1 (copy), u10 (copy), Variables (copy), u2 (copy), GameRules (copy), LocalPlayer (copy), CharScope (copy), UserInputService (copy), workspace_CurrentCamera (copy), TweenService (copy), PlayerEvent (copy), u1160 (copy), TextChatService (copy), PlayerGui (copy), FrontGui (copy), PlayerFunc (copy)
    local u1166 = {
        currentChannel = nil,
        transmit = false
    };
    local u1167 = {};
    local Scale = u1164.MouseCheck.Position.Y.Scale;
    local Scale2 = u1164.InputBox.Position.Y.Scale;

    if not u1165.radioEnabled then
        u1164.MouseCheck.Position = UDim2.fromScale(1, 0);
    end;

    if u1164:FindFirstChild("Main") then
        u1164.Channels.Visible = u1165.radioEnabled;
        u1164.ChatFrame.Visible = u1165.radioEnabled;
        u1164.Main.Visible = u1165.radioEnabled;
    end;

    local u1168 = false;
    local u1169 = false;
    local u1170 = nil;
    local u1171 = true;
    local u1172 = 0;
    local u1173 = false;
    local u1174 = u1.readPlayerData("Miscellaneous", "chatOpenTut");
    local u1175 = false;

    local function commandsList() -- Line: 6645
        -- upvalues: u10 (ref), Variables (ref), u1165 (copy), u1 (ref)
        local v1176 = {};

        if u10.isCommunityServer() then
            table.insert(v1176, "/staff [reason] - Notify server staff if you need assistance. The reason is optional");
        end;

        table.insert(v1176, "/commands /help - Show commands");
        table.insert(v1176, "/e /emote [emote] - Play emote");
        table.insert(v1176, "/mute [player] - Mute player");
        table.insert(v1176, "/unmute [player] - Unmute player");

        if Variables.IsPrivateServer:GetAttribute("rules") then
            table.insert(v1176, "/rules - Check private server rules");
        end;

        if Variables.IsPrivateServer:GetAttribute("crimeCommand") then
            table.insert(v1176, "/crime [crime] - Adds a crime from the crime list. Type \'/crime\' to see the list");
        end;

        if Variables.IsPrivateServer:GetAttribute("plrcrimeCommand") and u1165.teamName == "Police" then
            table.insert(v1176, "/plrcrime [player][crime] - Adds a crime from the crime list to any player. Can be used to add charges to caught criminal. Type \'/plrcrime\' to see the list");
        end;

        u1.notify({
            message = table.concat(v1176, "\n")
        });

        return true;
    end;

    local function emoteCommand(...) -- Line: 6660
        -- upvalues: u10 (ref), u2 (ref)
        local v1177 = { ... };

        for i, v in pairs(v1177) do
            v1177[i] = u10.firstToUpper(v);
        end;

        local table_concat_ret = table.concat(v1177, " ");
        local v1178 = game.ReplicatedStorage.PlayerStuff.Emotes:FindFirstChild(table_concat_ret, true);

        if v1178 and (v1178:IsA("Animation") and u2.loaded) then
            u2.playEmote(table_concat_ret);
        end;
    end;

    local function crimeCommand(p1179, p1180) -- Line: 6670
        -- upvalues: Variables (ref), u10 (ref), GameRules (ref), u1 (ref)
        if not p1180 and Variables.IsPrivateServer:GetAttribute(p1179) then
            local v1181 = {};

            for i, v in pairs(u10.privateServerCrimeList) do
                v1181[v[4]] = u10.splitCapitalLetters(u10.firstToUpper(i)) .. " <font color=\'rgb(140, 140, 140)\'>" .. GameRules.wantedLevelStars[v[1]] .. "★ - " .. v[3] .. "</font>";
            end;

            u1.mainBox({
                case = "BigInfo",
                lineHeight = 1.2,
                richText = true,
                content = table.concat(v1181, "\n"),
                textXAlignment = Enum.TextXAlignment.Left
            });

            return true;
        end;
    end;

    local u1193 = {
        consoleDebug = u1.consolePrintDebug,
        commands = commandsList,
        cmds = commandsList,
        help = commandsList,

        e = function(...) -- Line: 6686, Name: e
            -- upvalues: emoteCommand (copy)
            emoteCommand(...);

            return true;
        end,

        emote = function(...) -- Line: 6690, Name: emote
            -- upvalues: emoteCommand (copy)
            emoteCommand(...);

            return true;
        end,

        console = function() -- Line: 6694, Name: console
            game:GetService("StarterGui"):SetCore("DevConsoleVisible", true);
        end,

        mute = function(p1182) -- Line: 6697, Name: mute
            -- upvalues: u1 (ref)
            u1.mutePlayer(p1182, true);
        end,

        unmute = function(p1183) -- Line: 6700, Name: unmute
            -- upvalues: u1 (ref)
            u1.mutePlayer(p1183, false);
        end,

        rules = function() -- Line: 6704, Name: rules
            -- upvalues: Variables (ref), u1 (ref)
            if Variables.IsPrivateServer:GetAttribute("rules") then
                u1.mainBox({
                    case = "BigInfo",
                    maxLines = 15,
                    headline = Variables.IsPrivateServer:GetAttribute("rules")
                });
            end;

            return true;
        end,

        crime = function(p1184) -- Line: 6710, Name: crime
            -- upvalues: crimeCommand (copy)
            return crimeCommand("crimeCommand", p1184);
        end,

        plrcrime = function(p1185) -- Line: 6713, Name: plrcrime
            -- upvalues: crimeCommand (copy)
            return crimeCommand("plrcrimeCommand", p1185);
        end,

        fly = function(p1186) -- Line: 6717, Name: fly
            -- upvalues: u10 (ref), LocalPlayer (ref), u2 (ref), u1173 (ref), CharScope (ref), u1 (ref), UserInputService (ref), workspace_CurrentCamera (ref)
            local v1187 = u10.gameStaff(LocalPlayer);

            if u2.loaded and (v1187 == "Owner" or v1187 == "Admin") then
                if p1186 == "true" and not u1173 then
                    u2.fallRagdollEnabled = false;
                    u1173 = true;
                    local BodyPosition = Instance.new("BodyPosition");
                    local BodyGyro = Instance.new("BodyGyro");
                    BodyPosition:SetAttribute("UIATC", true);
                    BodyGyro:SetAttribute("UIATC", true);
                    BodyPosition.Parent = u2.root;
                    BodyGyro.Parent = u2.root;
                    BodyPosition.MaxForce = Vector3.new(inf, inf, inf);
                    BodyPosition.Position = u2.root.Position;
                    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
                    BodyGyro.CFrame = u2.root.CFrame;
                    CharScope.taskSpawn(function() -- Line: 6733
                        -- upvalues: u1173 (ref), u2 (ref), BodyGyro (copy), BodyPosition (copy), u1 (ref), UserInputService (ref), workspace_CurrentCamera (ref)
                        while u1173 do
                            u2.hum.PlatformStand = true;
                            local v1188 = BodyGyro.CFrame - BodyGyro.CFrame.p + BodyPosition.Position;

                            if u1.canPressKey() then
                                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                    v1188 = v1188 + workspace_CurrentCamera.CoordinateFrame.LookVector * 5;
                                end;

                                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                    v1188 = v1188 - workspace_CurrentCamera.CoordinateFrame.LookVector * 5;
                                end;

                                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                                    v1188 = v1188 * CFrame.new(5, 0, 0);
                                end;

                                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                                    v1188 = v1188 * CFrame.new(-5, 0, 0);
                                end;

                                BodyPosition.Position = v1188.p;

                                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                    BodyGyro.CFrame = workspace_CurrentCamera.CoordinateFrame * CFrame.Angles(-0.08726646259971647, 0, 0);
                                elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                    BodyGyro.CFrame = workspace_CurrentCamera.CoordinateFrame * CFrame.Angles(0.08726646259971647, 0, 0);
                                else
                                    BodyGyro.CFrame = workspace_CurrentCamera.CoordinateFrame;
                                end;
                            end;

                            task.wait();
                        end;

                        BodyGyro:Destroy();
                        BodyPosition:Destroy();
                        u2.hum.PlatformStand = false;
                    end);

                    return;
                end;

                u2.fallRagdollEnabled = true;
                u1173 = false;
            end;
        end,

        hud = function(p1189) -- Line: 6760, Name: hud
            -- upvalues: u1175 (ref), u1 (ref)
            u1175 = not u1175;
            local v1190;

            if p1189 == "all" then
                v1190 = false;
            else
                v1190 = u1175 and { u1.mouseIconGui };
            end;

            u1.hideGui(u1175 and "HudDisabled" or false, v1190);
        end,

        getserver = function(p1191, p1192) -- Line: 6764, Name: getserver
            -- upvalues: u10 (ref)
            if u10.gameStaff(p1192) then
                print("Server ID: " .. game.JobId);
            end;
        end
    };
    local u1194 = nil;
    local u1195 = 0;
    local u1196 = nil;
    local u1197 = workspace_CurrentCamera.ViewportSize.Y < 500;

    local function openChat(p1198, p1199) -- Line: 6775
        -- upvalues: u1195 (ref), u1 (ref), u1169 (ref), u1165 (copy), u1164 (copy), TweenService (ref), LocalPlayer (ref), u1196 (ref), Scale2 (copy), u1171 (ref), u1197 (copy), Scale (copy), u1194 (ref)
        u1195 = (u1195 + 1) % 1000;
        local v1200 = u1195;

        if u1.platform == "Mobile" and not (p1198 or p1199) then
            task.wait(2);

            if v1200 ~= u1195 or not u1.canPressKey() then
                return;
            end;
        end;

        u1169 = p1198;

        if not u1165.radioEnabled then
            u1164.MouseCheck.Size = UDim2.fromScale((p1198 or u1.platform ~= "Mobile") and 1 or 0.5, u1164.MouseCheck.Size.Y.Scale);
        end;

        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        TweenService:Create(u1164.InputBox, TweenInfo_new_ret, {
            ImageTransparency = p1198 and 0 or 1
        }):Play();
        TweenService:Create(u1164.InputBox.TextBoxFrame.TextBox, TweenInfo_new_ret, {
            TextTransparency = p1198 and 0 or 1
        }):Play();

        if not LocalPlayer:GetAttribute("ChattingRestricted") then
            u1196.freeze(not p1198);
        end;

        u1164.InputBox.TextBoxFrame.Interactable = p1198;
        u1164.InputBox.TextBoxFrame.MobileButton.Interactable = p1198;

        if u1165.radioEnabled then
            u1164.InputBox:TweenPosition(UDim2.fromScale(0, Scale2 - (u1171 and 0 or u1164.ChatFrame.Size.Y.Scale)), "Out", "Quint", 0.5, true);
            TweenService:Create(u1164.InputBox.Color, TweenInfo_new_ret, {
                BackgroundTransparency = p1198 and 0.5 or 1
            }):Play();
            u1164.ChatFrame._ScrollingList:TweenPosition(UDim2.fromScale(0, u1171 and (p1198 and 0 or (u1197 and -0.6 or -0.4)) or -1), "Out", "Quint", 0.5, true);
            local v1201;

            if u1171 then
                if p1198 then
                    v1201 = 0;
                else
                    v1201 = Scale or -u1164.ChatFrame.Size.Y.Scale;
                end;
            else
                v1201 = -u1164.ChatFrame.Size.Y.Scale;
            end;

            u1164.MouseCheck.Position = UDim2.fromScale(1, v1201);

            if not p1198 then
                u1194.setScroll(0, 0);
            end;
        end;
    end;

    CharScope.buildSignalData("Global", { u1164.MouseCheck.MouseEnter, function() -- Line: 6802
            -- upvalues: u1 (ref), openChat (copy), u1168 (ref), u10 (ref), u1164 (copy)
            if u1.platform == "Mobile" then
                return;
            end;

            if u1.canPressKey() then
                openChat(true);
            end;

            u1168 = true;

            while u10.isInFrame(u1164.MouseCheck) or u10.isTouchingScrollingListMobile do
                task.wait(0.03);
            end;

            if u1.canPressKey() then
                openChat(false);
            end;

            u1168 = false;
        end });
    CharScope.buildSignalData("Global", u1.mouseButton(u1164.MouseCheck, function() -- Line: 6811
        -- upvalues: u1 (ref), openChat (copy), u1165 (copy), u1196 (ref)
        if u1.platform ~= "Mobile" then
            return;
        end;

        openChat(true);

        if not u1165.radioEnabled then
            u1196.captureFocus();

            return;
        end;

        u1.mobileInputServiceClick();
        openChat(false);
    end));
    u1196 = u10.textBoxSystem(u1164.InputBox.TextBoxFrame, {
        enableScrolling = true
    });
    u1196.freeze(true);
    CharScope.buildSignalData("Global", unpack(u1196.multipleSignalData));
    CharScope.addThreadOrCleanUpFunction("Global", u1196.cleanUp);
    CharScope.buildSignalData("Global", { u1164.InputBox.TextBoxFrame.TextBox.FocusLost, function(p1202) -- Line: 6826
            -- upvalues: u1174 (ref), u1165 (copy), PlayerEvent (ref), u1172 (ref), u1168 (ref), openChat (copy), u1164 (copy), u1160 (ref), u10 (ref), u1193 (copy), u1 (ref), u1166 (copy), TextChatService (ref), LocalPlayer (ref), u1170 (ref)
            if not (u1174 or u1165.radioEnabled) then
                u1174 = true;
                PlayerEvent:FireServer("chatOpenTut");
            end;

            u1172 = 0;

            if not u1168 then
                openChat(false, true);
            end;

            if p1202 then
                if string.len(u1164.InputBox.TextBoxFrame.TextBox.Text) > 0 then
                    table.insert(u1160, 1, u1164.InputBox.TextBoxFrame.TextBox.Text);

                    if #u1160 > 20 then
                        table.remove(u1160, 21);
                    end;

                    if u10.retriveChatCommand(u1164.InputBox.TextBoxFrame.TextBox.Text, function(p1203, p1204) -- Line: 6837
                        -- upvalues: u1193 (ref), u10 (ref), u1 (ref), PlayerEvent (ref), u1164 (ref)
                        if u1193[p1203] then
                            local v1205 = u1193[p1203](unpack(p1204));

                            if v1205 and u10.typeOf(v1205) == "string" then
                                u1.notify({
                                    color = "red",
                                    message = v1205
                                });
                            end;
                        end;

                        PlayerEvent:FireServer("chatCommand", p1203, p1204);
                        u1164.InputBox.TextBoxFrame.TextBox.Text = "";

                        return true;
                    end) then
                        return;
                    end;

                    if u1166.transmit and u1166.transmit ~= "Voice" then
                        u10.sendMessage(TextChatService.TextChannels[u1166.currentChannel], u1164.InputBox.TextBoxFrame.TextBox.Text, {
                            location = "characterPosition",
                            username = LocalPlayer.Name,
                            callsign = LocalPlayer:GetAttribute("Callsign"),
                            team = u1165.teamName
                        });
                    else
                        u10.sendMessage(TextChatService.TextChannels.Local, u1164.InputBox.TextBoxFrame.TextBox.Text);
                    end;
                end;

                u1164.InputBox.TextBoxFrame.TextBox.Text = "";
            end;

            if u1166.transmit and u1166.transmit ~= "Voice" then
                u1170(true);
            end;
        end });

    function u1166.chatHistoryMoveUserInput(p1206) -- Line: 6859
        -- upvalues: u1164 (copy), u1172 (ref), u1160 (ref)
        if u1164.InputBox.TextBoxFrame.TextBox:IsFocused() then
            if p1206 then
                if u1172 < #u1160 then
                    u1172 = u1172 + 1;
                    u1164.InputBox.TextBoxFrame.TextBox.Text = u1160[u1172];
                    u1164.InputBox.TextBoxFrame.TextBox.CursorPosition = #u1160[u1172] + 1;
                end;
            elseif u1172 > 0 then
                u1172 = u1172 - 1;

                if u1172 == 0 then
                    u1164.InputBox.TextBoxFrame.TextBox.Text = "";

                    return;
                end;

                u1164.InputBox.TextBoxFrame.TextBox.Text = u1160[u1172];
                u1164.InputBox.TextBoxFrame.TextBox.CursorPosition = #u1160[u1172] + 1;
            end;
        end;
    end;

    function u1166.openChatUserInput() -- Line: 6881
        -- upvalues: LocalPlayer (ref), u1196 (ref), u1168 (ref), openChat (copy)
        task.wait();

        if not LocalPlayer:GetAttribute("ChattingRestricted") then
            u1196.freeze(false);
        end;

        u1196.captureFocus();

        if not u1168 then
            openChat(true);
        end;
    end;

    if u1165.radioEnabled then
        u10.animationBuffer(u2.animator, "load", game.ReplicatedStorage.PlayerStuff.Animations:WaitForChild("OnRadio"));

        function u1166.chatMessageMouseUserInput() -- Line: 6898
            -- upvalues: u10 (ref), u1164 (copy), u1169 (ref), PlayerGui (ref), u1167 (copy)
            if u10.isInFrame(u1164.MouseCheck) and u1169 then
                local MousePos = u10.getMousePos();

                for _, v in pairs(PlayerGui:GetGuiObjectsAtPosition(MousePos.X, MousePos.Y)) do
                    if v.Name == "_ChatBackground" then
                        u1167[v.Parent]();

                        return;
                    end;
                end;
            end;
        end;

        local u1207 = 0;

        u1170 = function(p1208) -- Line: 6910, Name: activateTransmitting
            -- upvalues: u1171 (ref), u10 (ref), u2 (ref), u1166 (copy), u1207 (ref), LocalPlayer (ref), u1164 (copy), CharScope (ref), u1170 (ref), PlayerEvent (ref)
            if p1208 == "Voice" or (not p1208 or u1171) then
                u10.animationBuffer(u2.animator, p1208 and "play" or "stop", "OnRadio");

                if u1166.transmit ~= p1208 then
                    game.SoundService.RadioTransmit:Play();
                end;

                u1166.transmit = p1208;
                u1207 = (u1207 + 1) % 100;
                local u1209 = u1207;

                if LocalPlayer:GetAttribute("VoiceChatEnabled") then
                    if p1208 == "Voice" then
                        u1164.Main.TransmitText.Text = "TRANSMITTING VOICE (C)";
                        CharScope.taskSpawn(function() -- Line: 6920
                            -- upvalues: u1207 (ref), u1209 (copy), u1166 (ref), LocalPlayer (ref), u1170 (ref)
                            while u1207 == u1209 and u1166.transmit do
                                if not LocalPlayer:GetAttribute("EmergencyVoiceRadio") then
                                    return u1170(false);
                                end;

                                task.wait(0.1);
                            end;
                        end);
                    else
                        u1164.Main.TransmitText.Text = p1208 and "TRANSMITTING TEXT (T)" or "TRANSMIT TEXT (T)";
                    end;

                    u2.smartRadioGui.Screen._ScrollingList.Scroll.VoiceRadio.Transmit.ImageColor3 = LocalPlayer:GetAttribute("EmergencyVoiceRadio") and (u1166.transmit == "Voice" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(142, 191, 231)) or Color3.fromRGB(216, 216, 216);
                    PlayerEvent:FireServer("emergencyVoiceRadioTransmit", p1208 == "Voice");
                else
                    u1164.Main.TransmitText.Text = p1208 and "TRANSMITTING (T)" or "TRANSMIT (T)";
                end;

                u1164.Main.Transmit.ImageColor3 = p1208 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(199, 199, 199);
                u10.resetButtonColor(u1164.Main.Transmit, p1208);

                if p1208 and p1208 ~= "Voice" then
                    task.wait(6);

                    if not u1164.InputBox.TextBoxFrame.TextBox:IsFocused() and u1209 == u1207 then
                        u1170(false);
                    end;
                end;
            end;
        end;

        u1170(false);

        function u1166.transmitUserInput() -- Line: 6940
            -- upvalues: u1170 (ref), u1166 (copy)
            u1170(not u1166.transmit);
        end;

        if require(game.Teams[u1165.teamName].Config).SMART_RADIO then
            function u1166.transmitVoiceUserInput() -- Line: 6944
                -- upvalues: LocalPlayer (ref), u10 (ref), FrontGui (ref), u1170 (ref)
                if LocalPlayer:GetAttribute("EmergencyVoiceRadio") then
                    u10.mobileButtonPressed(FrontGui.TopBarButtons.Mobile.TransmitVoice, true);
                    u1170("Voice");
                end;
            end;

            function u1166.stopTransmitVoiceUserInput() -- Line: 6950
                -- upvalues: LocalPlayer (ref), u1166 (copy), u10 (ref), FrontGui (ref), u1170 (ref)
                if LocalPlayer:GetAttribute("EmergencyVoiceRadio") and u1166.transmit == "Voice" then
                    u10.mobileButtonPressed(FrontGui.TopBarButtons.Mobile.TransmitVoice, false);
                    u1170(false);
                end;
            end;
        end;

        CharScope.buildSignalData("Global", u10.buttonHoverSignalData(u1164.Main.Transmit));
        CharScope.buildSignalData("Global", u1.mouseButton(u1164.Main.Transmit, function() -- Line: 6958
            -- upvalues: u1170 (ref), u1166 (copy)
            u1170(not u1166.transmit);
        end, {
            addMobileButton = true
        }));
        CharScope.buildSignalData("Global", u1.mouseButton(FrontGui.TopBarButtons.Mobile.TransmitVoice, function() -- Line: 6959
            -- upvalues: u1166 (copy)
            if u1166.transmit == "Voice" then
                u1166.stopTransmitVoiceUserInput();

                return;
            end;

            u1166.transmitVoiceUserInput();
        end));

        local function transmitRadioMobileButton() -- Line: 6960
            -- upvalues: LocalPlayer (ref), FrontGui (ref), CharScope (ref)
            local Attribute = LocalPlayer:GetAttribute("EmergencyVoiceRadio");
            FrontGui.TopBarButtons.Mobile.TransmitVoice.Visible = Attribute;
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "transmitVoiceCleanUp", Attribute and function() -- Line: 6963
                -- upvalues: FrontGui (ref)
                FrontGui.TopBarButtons.Mobile.TransmitVoice.Visible = false;
            end or nil);
        end;

        local Attribute = LocalPlayer:GetAttribute("EmergencyVoiceRadio");
        FrontGui.TopBarButtons.Mobile.TransmitVoice.Visible = Attribute;
        CharScope.setThreadOrCleanUpFunctionIndex("Global", "transmitVoiceCleanUp", Attribute and function() -- Line: 6963
            -- upvalues: FrontGui (ref)
            FrontGui.TopBarButtons.Mobile.TransmitVoice.Visible = false;
        end or nil);
        CharScope.buildSignalData("Global", { LocalPlayer:GetAttributeChangedSignal("EmergencyVoiceRadio"), transmitRadioMobileButton });

        local function showRadio() -- Line: 6970
            -- upvalues: u1171 (ref), u1164 (copy), u1166 (copy), u1170 (ref), openChat (copy), u1169 (ref)
            u1171 = not u1171;
            u1164.Main.RadioText.Text = u1171 and "RADIO ENABLED" or "RADIO DISABLED";

            if u1166.transmit and u1166.transmit ~= "Voice" then
                u1170(false);
            end;

            openChat(u1169);
        end;

        CharScope.buildSignalData("Global", u10.buttonHoverSignalData(u1164.Main.Radio));
        CharScope.buildSignalData("Global", u1.mouseButton(u1164.Main.Radio, showRadio, {
            addMobileButton = true
        }));
        u1194 = u10.scrollingListSystem(u1164.ChatFrame._ScrollingList.Scroll, 0.3, {
            limitY = 2,
            invert = true,

            mobileTouchCondition = function() -- Line: 6978, Name: mobileTouchCondition
                -- upvalues: u10 (ref), u1164 (copy), u1169 (ref)
                local v1210 = u10.isInFrame(u1164.ChatFrame) and u1169;

                return v1210;
            end
        });
        CharScope.buildSignalData("Global", unpack(u1194.multipleSignalData));
        CharScope.addThreadOrCleanUpFunction("Global", u1194.cleanUp);
        local u1211 = false;

        local function activateOption(u1212, p1213) -- Line: 6984
            -- upvalues: CharScope (ref), u1164 (copy), u10 (ref), u1 (ref), u1211 (ref), u2 (ref), PlayerFunc (ref), u1166 (copy), activateOption (copy), UserInputService (ref)
            CharScope.setConnectionsAndThreads("RadioOptions");
            u1164.Options.Visible = p1213;

            if p1213 then
                u1164.Options.Position = u10.guiPositionAtMouse(u1164) - UDim2.fromOffset(3, 3);

                for _, child in pairs(u1164.Options.Buttons:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.Visible = false;
                    end;
                end;

                local v1214 = {};

                for i, v in pairs(p1213) do
                    v1214[i] = v;
                end;

                for i, v in pairs(v1214) do
                    u1164.Options.Buttons[i].Visible = true;
                    CharScope.buildSignalData("RadioOptions", u10.buttonHoverSignalData(u1164.Options.Buttons[i]));
                    CharScope.buildSignalData("RadioOptions", u1.mouseButton(u1164.Options.Buttons[i], function() -- Line: 6998
                        -- upvalues: u1211 (ref), i (copy), v (copy), u1212 (copy), u10 (ref), u2 (ref), CharScope (ref), PlayerFunc (ref), u1 (ref), u1164 (ref), u1166 (ref), activateOption (ref)
                        u1211 = true;

                        if i == "Location" then
                            local v1215;

                            if v == "characterPosition" then
                                v1215 = u1212 and u1212:GetAttribute("CharacterPosition");
                            else
                                v1215 = u10.typeOf(v) == "Instance" and v.Position or v;
                            end;

                            if v1215 then
                                local LocationInsideAtPos = u10.getLocationInsideAtPos(v1215);
                                local activateMap = u2.activateMap;

                                if LocationInsideAtPos then
                                    v1215 = u10.getLocationOutsideCenter(LocationInsideAtPos) or v1215;
                                end;

                                activateMap(true, v1215);
                            end;
                        elseif i == "Tablet" then
                            u2.activateMDT(true, "Incident", v);
                        elseif i == "Tablet2" then
                            u2.activateMDT(true);
                        elseif i == "JoinCall" then
                            CharScope.taskSpawn(function() -- Line: 7016
                                -- upvalues: PlayerFunc (ref), v (ref), u1 (ref)
                                if PlayerFunc:InvokeServer("talkToMission", v .. "join") == true then
                                    u1.notify({
                                        message = "Call joined",
                                        color = "green"
                                    });
                                end;
                            end);
                        elseif i == "Reply" then
                            u1164.InputBox.TextBoxFrame.TextBox.Text = v .. " ";
                            u1166.openChatUserInput();
                        end;

                        activateOption(false);

                        while u1.isMouseButton1Pressed() do
                            task.wait();
                        end;

                        u1211 = false;
                    end));
                end;

                u1164.Options.MouseHover.Size = UDim2.fromScale(1, u10.indexedTableSize(v1214));
                CharScope.buildSignalData("RadioOptions", { UserInputService.InputChanged, function(p1216) -- Line: 7031
                        -- upvalues: u10 (ref), u1164 (ref), activateOption (ref)
                        if not (p1216.UserInputType ~= Enum.UserInputType.MouseMovement and p1216.UserInputType ~= Enum.UserInputType.Touch or u10.isInFrame(u1164.Options.MouseHover)) then
                            activateOption(false);
                        end;
                    end });
                CharScope.buildSignalData("RadioOptions", { UserInputService.InputBegan, function(p1217) -- Line: 7036
                        -- upvalues: u1 (ref), u10 (ref), u1164 (ref), activateOption (ref)
                        if p1217.UserInputType == Enum.UserInputType.Touch then
                            if u1.isMouseObstructedByBlackBackground() then
                                return;
                            end;

                            if not u10.isInFrame(u1164.Options.MouseHover) then
                                activateOption(false);
                            end;
                        end;
                    end });
            end;
        end;

        local u1218 = {};

        function u1166.createMessage(u1219) -- Line: 7046
            -- upvalues: u10 (ref), u1164 (copy), CharScope (ref), u1218 (copy), u1165 (copy), u2 (ref), u1171 (ref), u1167 (copy), LocalPlayer (ref), u1211 (ref), activateOption (copy), u1166 (copy)
            if u1219.incident and not u1219.incident.Parent then
                return;
            end;

            local u1220 = u10.clone(u1164.ChatFrame._ScrollingList[u1219.incident and "IncidentPreview" or "MessagePreview"]);
            local u1221 = CharScope.setConnectionsAndThreads();

            local function v1222() -- Line: 7050
                -- upvalues: CharScope (ref), u1221 (copy)
                CharScope.clearConnectionsAndThreads(u1221);
            end;

            u1220.Visible = true;
            local RADIO_CHANNEL = require(game.Teams[u1219.sendTo].Config).RADIO_CHANNEL;
            RADIO_CHANNEL.even = not RADIO_CHANNEL.even;
            u1220.Parent = u1164.ChatFrame._ScrollingList.Scroll[u1219.sendTo];

            if u1219.soundReference then
                CharScope.taskDefer(function() -- Line: 7058
                    -- upvalues: u10 (ref), u1219 (copy), u1220 (copy), u1218 (ref), CharScope (ref)
                    local InstanceReference = u10.getInstanceReference(u1219.soundReference, 20);

                    if InstanceReference and u1220.Parent then
                        InstanceReference:Play();

                        if u1219.soundLifetime then
                            u1218[InstanceReference] = u1220;
                            CharScope.taskDelay(u1219.soundLifetime, function() -- Line: 7064
                                -- upvalues: u1218 (ref), InstanceReference (copy), u1220 (ref)
                                if u1218[InstanceReference] == u1220 then
                                    InstanceReference:Stop();
                                    u1218[InstanceReference] = nil;
                                end;
                            end);
                        end;
                    end;
                end);
            end;

            local function setMessageColor(p1223, p1224, p1225, p1226) -- Line: 7074
                -- upvalues: u1220 (copy)
                u1220.Color.BackgroundColor3 = Color3.fromHSV(p1223, p1224, p1225 + 0.5 - (p1226 and 0.05 or 0));
                u1220._ChatBackground.BackgroundColor3 = Color3.fromHSV(p1223, p1224, p1225 - (p1226 and 0.05 or 0));
            end;

            local u1227 = true;

            if u1219.incident then
                local u1228 = u1219.incident:WaitForChild("Team"):WaitForChild(u1219.sendTo);
                local Priority = u1219.incident:WaitForChild("Priority");
                u1220.Name = "Incident";
                u1220.Code.TextLabel.Text = u1219.code;
                u10.UIListLayout(u1220, UDim2.fromScale(0, -u1220.Size.Y.Scale), true, true);
                local v1229, v1230, v1231, v1232 = RADIO_CHANNEL.incidentColor:ToHSV();
                u1220.Color.BackgroundColor3 = Color3.fromHSV(v1229, v1230, v1231 + 0.5 - (v1232 and 0.05 or 0));
                u1220._ChatBackground.BackgroundColor3 = Color3.fromHSV(v1229, v1230, v1231 - (v1232 and 0.05 or 0));
                CharScope.taskSpawn(function() -- Line: 7086
                    -- upvalues: u1220 (copy), u1227 (ref), u10 (ref), u1219 (copy), u1228 (copy)
                    for i = 0, 999 do
                        if not u1220.Parent then
                            return;
                        end;

                        u1220.Time.Text = i <= 0 and "Seconds Ago" or (i == 1 and "1 Minute Ago" or i .. " Minutes Ago");

                        if u1227 then
                            u1220.Location.Text = u10.getLocationStringAtPos(u10.getVectorFromLocation(u1219.location), nil, {
                                streetName = u1228.Location:GetAttribute("StreetName") or false
                            });
                        end;

                        task.wait(60);
                        local _ = i;
                    end;
                end);
                CharScope.taskSpawn(function() -- Line: 7097
                    -- upvalues: u1220 (copy), u1219 (copy), Priority (copy)
                    local v1233 = nil;
                    local v1234 = nil;

                    while u1220.Parent do
                        if u1219.incident.Name ~= v1233 then
                            v1233 = u1219.incident.Name;
                            u1220.Title.Text = v1233;
                        end;

                        if Priority.Value ~= v1234 then
                            v1234 = Priority.Value;
                            u1220.Code.ImageColor3 = v1234 == 1 and Color3.fromRGB(255, 232, 101) or (v1234 == 2 and Color3.fromRGB(255, 173, 90) or Color3.fromRGB(255, 111, 85));
                        end;

                        task.wait(10);
                    end;
                end);

                if u1219.sendTo == u1165.teamName then
                    u2.lastReceivedIncident = u1219.incident;

                    if u2.lastReceivedIncidentSmartRadioFunc then
                        u2.lastReceivedIncidentSmartRadioFunc();
                    end;
                end;

                CharScope.taskSpawn(function() -- Line: 7116
                    -- upvalues: u1219 (copy), u1165 (ref), u1171 (ref), u10 (ref)
                    if u1219.sendTo == u1165.teamName and (u1219.dispatchVoice and u1171) then
                        u10.playDispatch(u1219.dispatchVoice);
                    end;
                end);

                local function u1235() -- Line: 7120
                    -- upvalues: u1235 (ref), u2 (ref), u1219 (copy), u1220 (copy), u1227 (ref), CharScope (ref), u1221 (copy)
                    u1235 = nil;

                    if u2.lastReceivedIncident == u1219.incident then
                        u2.lastReceivedIncident = nil;

                        if u2.lastReceivedIncidentSmartRadioFunc then
                            u2.lastReceivedIncidentSmartRadioFunc();
                        end;
                    end;

                    u1220.Color.BackgroundColor3 = Color3.fromHSV(0, 0, 1.119607843137255);
                    u1220._ChatBackground.BackgroundColor3 = Color3.fromHSV(0, 0, 0.6196078431372549);
                    u1227 = false;
                    CharScope.clearConnectionsAndThreads(u1221);
                end;

                CharScope.buildSignalData(u1221, { u1220.Destroying, function() -- Line: 7130
                        -- upvalues: u1167 (ref), u1220 (copy), u1235 (ref)
                        u1167[u1220] = nil;

                        if u1235 then
                            u1235();
                        end;
                    end });

                local function isSoloFunc(p1236) -- Line: 7134
                    -- upvalues: u1219 (copy), LocalPlayer (ref)
                    if p1236 then
                        p1236 = not u1219.incident.Players:FindFirstChild(LocalPlayer.Name);
                    end;

                    return p1236;
                end;

                CharScope.buildSignalData(u1221, { u1219.incident.Destroying, function() -- Line: 7137
                        -- upvalues: u1235 (ref)
                        u1235();
                    end });
                CharScope.buildSignalData(u1221, { u1228.Destroying, function() -- Line: 7138
                        -- upvalues: u1235 (ref)
                        u1235();
                    end });
                CharScope.buildSignalData(u1221, { u1228.Solo.Changed, function(p1237) -- Line: 7139
                        -- upvalues: u1219 (copy), LocalPlayer (ref), u1235 (ref)
                        if p1237 then
                            p1237 = not u1219.incident.Players:FindFirstChild(LocalPlayer.Name);
                        end;

                        if p1237 then
                            u1235();
                        end;
                    end });
                local v1238 = u1228.Solo.Value and not u1219.incident.Players:FindFirstChild(LocalPlayer.Name);

                if v1238 then
                    CharScope.taskSpawn(u1235);
                end;
            else
                u1220.Name = "Message";
                local v1239, v1240, v1241 = require(game.Teams[u1219.team].Config).RADIO_CHANNEL.color:ToHSV();
                local v1242 = v1241 - 0.5;
                local even = RADIO_CHANNEL.even;
                u1220.Color.BackgroundColor3 = Color3.fromHSV(v1239, v1240, v1242 + 0.5 - (even and 0.05 or 0));
                u1220._ChatBackground.BackgroundColor3 = Color3.fromHSV(v1239, v1240, v1242 - (even and 0.05 or 0));
                local v1243 = (u1219.callsign and (u1219.callsign .. " | " or "") or "") .. (u1219.displayName or u1219.username);
                local v1244 = 1 + u1220.Content.Size.Y.Scale * (u10.fitText(u1220.Content, v1243 .. ": " .. u1219.text, 3) - 1);
                u1220._ChatBackground.Size = UDim2.fromScale(1, v1244);
                u1220.Color.Size = UDim2.fromScale(u1220.Color.Size.X.Scale, v1244);
                u10.UIListLayout(u1220, UDim2.fromScale(0, -v1244 * u1220.Size.Y.Scale), true, true);
                u1220.Player.Text = u1220.Content.Text;
                u1220.Player.MaxVisibleGraphemes = string.len(v1243);
                u1220.Player.Size = u1220.Content.Size;
                CharScope.buildSignalData(u1221, { u1220.Destroying, v1222 });
            end;

            u1167[u1220] = function() -- Line: 7158
                -- upvalues: u1211 (ref), u1227 (ref), u1219 (copy), u10 (ref), LocalPlayer (ref), u1165 (ref), activateOption (ref)
                if u1211 or not u1227 then
                    return;
                end;

                local v1245 = nil;

                if u1219.MDT and u1219.missionId then
                    local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "Mission");

                    if not (InstanceAttribute and (InstanceAttribute.Parent and InstanceAttribute.ID.Value == u1219.missionId)) and u1219.sendTo == u1165.teamName then
                        v1245 = u1219.missionId;
                    end;
                end;

                local v1246 = u1219.username and u10.findLoadedPlayer(u1219.username);
                local v1247 = {};
                local v1248;

                if u1219.MDT or u1219.username == LocalPlayer.Name then
                    v1248 = nil;
                else
                    v1248 = u1219.location or nil;
                end;

                v1247.Location = v1248;
                v1247.JoinCall = v1245;
                local v1249;

                if u1219.username == LocalPlayer.Name then
                    v1249 = nil;
                else
                    v1249 = u1219.displayName or nil;
                end;

                v1247.Reply = v1249;
                v1247.Tablet = u1219.MDT and u1219.code;
                v1247.Tablet2 = u1219.openTablet;
                activateOption(v1246, v1247);
            end;

            if u1219.sendTo == u1165.teamName and u1166.currentChannel ~= u1165.teamName then
                u1164.Channels[u1165.teamName].NotificationDot.Visible = true;
            end;

            for _, child in pairs(u1164.ChatFrame._ScrollingList.Scroll[u1219.sendTo]:GetChildren()) do
                if child:IsA("Frame") and child.Position.Y.Scale < -2 then
                    child:Destroy();
                end;
            end;
        end;

        for _, child in pairs(game.Teams:GetChildren()) do
            if require(child.Config).MDT then
                TextChatService.TextChannels[child.Name].OnIncomingMessage = function(u1250) -- Line: 7182
                    -- upvalues: u1 (ref), u10 (ref), child (copy), u1166 (copy)
                    if u1.isOnIncomingMessageMuted(u1250) then
                        return;
                    end;

                    if u1250.Status == Enum.TextChatMessageStatus.Success then
                        u10.receiveMessage(u1250, function(p1251, p1252, p1253) -- Line: 7185
                            -- upvalues: u10 (ref), child (ref), u1250 (copy), u1166 (ref)
                            if p1253.incidentReference then
                                p1253.incident = u10.getInstanceReference(p1253.incidentReference, 20);

                                if not p1253.incident then
                                    return;
                                end;
                            end;

                            if p1253.location and tonumber(p1253.location) then
                                p1253.location = u10.getInstanceReference(p1253.location, 10);

                                if not p1253.location then
                                    return;
                                end;
                            end;

                            p1253.text = p1252 or p1251;
                            p1253.sendTo = child.Name;

                            if not p1253.displayName and u1250.PrefixText ~= "" then
                                p1253.displayName = string.sub(u1250.PrefixText, 1, #u1250.PrefixText - 1);
                            end;

                            u1166.createMessage(p1253);
                        end);
                    end;
                end;

                CharScope.addThreadOrCleanUpFunction("Global", function() -- Line: 7201
                    -- upvalues: TextChatService (ref), child (copy)
                    TextChatService.TextChannels[child.Name].OnIncomingMessage = nil;
                end);
            end;
        end;

        function u1166.selectChannel(p1254) -- Line: 7208
            -- upvalues: u1166 (copy), u1164 (copy), u1194 (ref)
            if u1166.currentChannel then
                u1164.ChatFrame._ScrollingList.Scroll[u1166.currentChannel].Visible = false;
            end;

            u1166.currentChannel = p1254;
            u1164.Channels.Selected:TweenPosition(UDim2.fromScale(u1164.Channels[u1166.currentChannel].Position.X.Scale, 1), "Out", "Quint", 0.2, true);
            u1164.ChatFrame._ScrollingList.Scroll[u1166.currentChannel].Visible = true;
            u1194.setScroll(0, 0);
            u1164.Channels[u1166.currentChannel].NotificationDot.Visible = false;
        end;

        for _, child in pairs(u1164.Channels:GetChildren()) do
            if child:IsA("ImageButton") then
                local v1255 = u10.clone(u1164.ChatFrame._ScrollingList.ChannelPreview);
                v1255.Name = child.Name;
                v1255.Parent = u1164.ChatFrame._ScrollingList.Scroll;
                CharScope.buildSignalData("Global", u1.mouseButton(u1164.Channels[child.Name], function() -- Line: 7222
                    -- upvalues: u1166 (copy), child (copy)
                    u1166.selectChannel(child.Name);
                end));
                CharScope.buildSignalData("Global", u10.buttonHoverSignalData(u1164.Channels[child.Name], {
                    intensity = -0.7
                }));
            end;
        end;

        u1166.selectChannel(u1165.teamName);
    else
        u1164.Position = UDim2.fromScale(-7.2, -3.6);
        u1164.InputBox.PlaceholderRight.Visible = true;
        u1164.InputBox.Color.BackgroundTransparency = 1;
        openChat(false);
    end;

    if u1174 or u1165.radioEnabled then
        openChat(false, true);
    else
        openChat(true, true);
    end;

    if LocalPlayer:GetAttribute("ChattingRestricted") then
        u1164.InputBox.TextBoxFrame.TextBox.PlaceholderText = "Age verification needed to chat";
    end;

    return u1166;
end;

local Experience = GlobalGui.Center.Top.Experience;
local Reputation = GlobalGui.Center.Top.Reputation;
local u1256 = 0;

function u1.experienceAdded(p1257, u1258, u1259) -- Line: 7243
    -- upvalues: u1256 (ref), Reputation (copy), u1 (copy), u2 (copy), u10 (copy), LocalPlayer (copy), Experience (copy), TweenService (copy), Easing (copy)
    u1256 = u1256 + 1;
    local u1260 = u1256;

    while Reputation.Visible or (u1.loadingActivated ~= nil or (u1.setupLoading or not (u2.loaded or u10.isCharLoaded(LocalPlayer)))) do
        task.wait(1);

        if u1256 ~= u1260 or p1257 ~= LocalPlayer.Team.Name then
            return;
        end;
    end;

    local RANKS = require(LocalPlayer.Team.Config).RANKS;

    if RANKS then
        local u1261 = u1.readPlayerData("Ranks", LocalPlayer.Team.Name) or 1;
        local u1262 = u1.readPlayerData("XP", LocalPlayer.Team.Name) or 0;
        u10.guiTransition(Experience, "Position", UDim2.fromScale(0, -0.5), true);
        Experience.Rank.Text = u1261;
        Experience.NextRank.Text = u1261 + 1;
        Experience.Bar.ImageColor3 = u1258 > 0 and Color3.fromRGB(123, 194, 255) or Color3.fromRGB(255, 121, 121);

        if u1.questFunctions.xpAdded then
            u1.questFunctions.xpAdded(u1258);
        end;

        local function u1274(p1263) -- Line: 7258
            -- upvalues: RANKS (copy), u1261 (ref), Experience (ref), u10 (ref), u1258 (ref), u1259 (copy), u1262 (ref), TweenService (ref), Easing (ref), u1256 (ref), u1260 (copy), u1274 (copy)
            local v1264 = RANKS[u1261 + 1];
            local u1265 = RANKS[u1261 + 1] and RANKS[u1261 + 1][1];
            Experience.RankDetails.Text = RANKS[u1261][2] or "";
            Experience.RankDetails2.Text = "";
            Experience.Headline.XP.Text = p1263 and "RANK " .. u1261 or u10.commaValue(u1258) .. " XP";
            Experience.Headline.Reason.Text = string.upper(u1259);
            Experience.NextRankDetails.Text = v1264 and (v1264[2] or (u10.commaValue(u1265) or "Max Rank")) or "Max Rank";
            Experience.NextRankDetails2.Text = v1264 and v1264[2] and (u10.commaValue(u1265) or "") or "";
            Experience.Bar.UIGradient.Offset = Vector2.new(u1265 and (u1262 / u1265 - 0.5 or 0.5) or 0.5, 0);

            if u1265 then
                TweenService:Create(Experience.Bar.UIGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Offset = Vector2.new(math.clamp((u1262 + u1258) / u1265, 0, 1) - 0.5, 0)
                }):Play();
            end;

            Experience.Headline.Reason.Position = UDim2.fromScale(0.5, 0.5);
            Experience.Headline.XP.Position = UDim2.fromScale(0.5, -0.5);
            task.spawn(function() -- Line: 7271
                -- upvalues: Experience (ref), u1265 (copy), u1258 (ref), u1262 (ref), u10 (ref), Easing (ref), u1256 (ref), u1260 (ref)
                local v1266 = "RankDetails" .. (Experience.RankDetails.Text == "" and "" or "2");
                local v1267 = 0;
                local v1268 = u1265 and math.clamp(u1258, -u1262, u1265 - u1262) or u1258;

                while v1267 < 3 do
                    local v1269 = Experience[v1266];
                    local commaValue = u10.commaValue;
                    local v1270 = Easing.inOutQuad(v1267, u1262, v1268, 3);
                    v1269.Text = commaValue((math.ceil(v1270)));
                    v1267 = v1267 + task.wait(0.03);

                    if u1256 ~= u1260 then
                        return;
                    end;
                end;

                Experience[v1266].Text = u10.commaValue(u1262 + u1258);
            end);
            task.wait(3);

            if u1256 ~= u1260 then
                return;
            end;

            local v1271;

            if u1265 then
                v1271 = (u1262 + u1258) / u1265 > 1;
            else
                v1271 = u1265;
            end;

            if v1271 then
                game.SoundService.RankUp:Play();
                u1261 = u1261 + 1;
                u1258 = u1262 + u1258 - u1265;
                u1262 = 0;
                task.spawn(function() -- Line: 7288
                    -- upvalues: TweenService (ref), Experience (ref), u1256 (ref), u1260 (ref), u1261 (ref)
                    local function tweenRanks() -- Line: 7289
                        -- upvalues: TweenService (ref), Experience (ref)
                        TweenService:Create(Experience.Rank.UIGradient, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            Offset = Vector2.new(0.7, 0)
                        }):Play();
                        TweenService:Create(Experience.NextRank.UIGradient, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            Offset = Vector2.new(0.7, 0)
                        }):Play();
                        task.wait(0.4);
                        Experience.Rank.UIGradient.Offset = Vector2.new(-0.7, 0);
                        Experience.NextRank.UIGradient.Offset = Vector2.new(-0.7, 0);
                    end;

                    local function flare(p1272, p1273) -- Line: 7296
                        -- upvalues: TweenService (ref), Experience (ref)
                        TweenService:Create(Experience.Rank.Flare1, TweenInfo.new(p1272, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ImageTransparency = p1273 and 0.7 or 1
                        }):Play();
                        TweenService:Create(Experience.Rank.Flare2, TweenInfo.new(p1272, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ImageTransparency = p1273 and 0.8 or 1
                        }):Play();
                        TweenService:Create(Experience.NextRank.Flare1, TweenInfo.new(p1272, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ImageTransparency = p1273 and 0.7 or 1
                        }):Play();
                        TweenService:Create(Experience.NextRank.Flare2, TweenInfo.new(p1272, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ImageTransparency = p1273 and 0.8 or 1
                        }):Play();
                    end;

                    tweenRanks();

                    if u1256 == u1260 then
                        Experience.Rank.Text = u1261;
                        Experience.NextRank.Text = u1261 + 1;
                        Experience.Rank.UIGradient.Rotation = 225;
                        Experience.NextRank.UIGradient.Rotation = 225;
                        task.delay(0.1, function() -- Line: 7309
                            -- upvalues: flare (copy)
                            flare(0.06, true);
                            task.wait(0.06);
                            flare(0.4, false);
                        end);
                        tweenRanks();
                        Experience.Rank.UIGradient.Rotation = 45;
                        Experience.NextRank.UIGradient.Rotation = 45;
                    end;
                end);

                return u1274(v1271);
            end;

            Experience.Headline.Reason:TweenPosition(UDim2.fromScale(0.5, 1.5), "Out", "Quint", 1, true);
            Experience.Headline.XP:TweenPosition(UDim2.fromScale(0.5, 0.5), "Out", "Quint", 1, true);
            task.wait(p1263 and 12 or 7);

            if u1256 ~= u1260 then
                return;
            end;

            u10.guiTransition(Experience, "Position", UDim2.fromScale(0, -0.5), false);
        end;

        u1274();
    end;
end;

local u1275 = 0;

function u1.reputationIncreased(p1276) -- Line: 7331
    -- upvalues: u1275 (ref), Experience (copy), Reputation (copy), u10 (copy)
    u1275 = u1275 + 1;
    local v1277 = u1275;

    while Experience.Visible do
        task.wait(1);

        if u1275 ~= v1277 then
            return;
        end;
    end;

    Reputation.Reputation.Text = p1276;
    game.SoundService.RankUp:Play();
    u10.guiTransition(Reputation, "Position", UDim2.fromScale(0, 0.5), true);
    task.wait(7);

    if u1275 ~= v1277 then
        return;
    end;

    u10.guiTransition(Reputation, "Position", UDim2.fromScale(0, -0.5), false);
end;

local function weldTransition(u1278) -- Line: 7344
    -- upvalues: RunService (copy), u10 (copy), u1 (copy)
    if not u1278:GetAttribute("Active") then
        u1278:SetAttribute("Active", true);
        local Weld = u1278:WaitForChild("Weld");
        local Attribute = u1278:GetAttribute("WeldBehavior");
        local u1279 = (u1278:GetAttribute("Value") or 0) / 100;
        local u1285 = RunService.Heartbeat:Connect(function(p1280) -- Line: 7350
            -- upvalues: u10 (ref), u1279 (ref), u1278 (copy), u1 (ref), Weld (copy), Attribute (copy)
            local v1281 = u10.lerp(u1279, (u1278:GetAttribute("Value") or 0) / 100, 1 - 0.046 ^ p1280);

            if not u10.collectionHasTag(u1278, "WeldTransition") and math.abs(u1279 - v1281) < 0.00001 then
                return u1.scriptedObjects[u1278](u1278);
            end;

            u1279 = v1281;
            local v1282;

            if Attribute == "X" then
                v1282 = u1279;
            else
                v1282 = false;
            end;

            local v1283;

            if Attribute == "Y" then
                v1283 = u1279;
            else
                v1283 = false;
            end;

            local v1284;

            if Attribute == "Z" then
                v1284 = u1279;
            else
                v1284 = false;
            end;

            Weld.C0 = CFrame.new(v1282, v1283, v1284) * CFrame.Angles(Attribute == "AngleX" and (u1279 or 0) or 0, Attribute == "AngleY" and (u1279 or 0) or 0, Attribute == "AngleZ" and (u1279 or 0) or 0);
        end);

        u1.scriptedObjects[u1278] = function() -- Line: 7356
            -- upvalues: u1285 (copy), u1278 (copy)
            u1285:Disconnect();
            u1278:SetAttribute("Active", nil);
        end;
    end;
end;

for _, v in pairs(u10.collectionGetTagged("WeldTransition")) do
    task.spawn(weldTransition, v);
end;

u10.buildSignalData({}, u10.collectionGetInstanceAddedSignal("WeldTransition", weldTransition));
local u1286 = u10.raycastParamsNew();
u1286.FilterDescendantsInstances = { workspace.Characters };
u1286.IgnoreWater = true;
local u1287 = u10.raycastParamsNew();
u1287.IgnoreWater = true;
local DragHighlight = game.ReplicatedStorage.Gameplay.Drag.DragHighlight;
local u1288 = nil;
u1.dragging = nil;
local u1289 = {};

local function draggedTeleport(p1290, p1291) -- Line: 7374
    -- upvalues: u1 (copy), u2 (copy)
    if u1.dragging and (u2.root and p1291) then
        u1.dragging:PivotTo(p1291);
    end;
end;

function draggableInside(p1292, p1293)
    -- upvalues: u1 (copy), u10 (copy)
    if u1.dragging and u1.rootPersistent then
        u1.dragging:PivotTo(u1.rootPersistent.CFrame);
    end;

    for _, v in pairs(u10.collectionGetTagged("Draggable")) do
        local LocationInsideAtPos = u10.getLocationInsideAtPos(v.PrimaryPart.Position);

        if LocationInsideAtPos == p1293 then
            v.PrimaryPart.Anchored = true;
        end;

        if LocationInsideAtPos == p1292 then
            v.PrimaryPart.Anchored = false;
        end;
    end;
end;

function u1.makeDraggable(p1294, p1295) -- Line: 7390
    -- upvalues: u10 (copy), u1 (copy)
    local Config = require(p1294.Config);

    if Config.SPECIAL then
        local v1296 = u10.clone(p1294);

        if Config.SPECIAL_KEEP_INSTANCE then
            u10.setInstanceAttribute(v1296, "Original", p1294);
        end;

        u10.collectionAddTag(v1296, "IgnoreCamera");
        u10.collectionAddTag(v1296, "Draggable");
        v1296:SetAttribute("Draggable", true);

        for _, descendant in pairs(v1296:GetDescendants()) do
            descendant:SetAttribute("Draggable", true);

            if descendant:IsA("BasePart") then
                descendant.CanCollide = true;
                descendant.CollisionGroup = "DraggableObjects";
            end;
        end;

        if p1295 then
            u1.startDragging(v1296);
        end;

        return v1296;
    end;
end;

local function getTouchedItem() -- Line: 7413
    -- upvalues: u1 (copy), u1286 (copy), u2 (copy)
    local v1297 = u1.getMouseProperty.raycast(u1286, 30, "FreeSpace");

    if v1297 and (u2.root and ((u2.root.Position - v1297.Position).Magnitude < 12 and (v1297.Instance:GetAttribute("Draggable") and not u1.dragging))) then
        local Instance2 = v1297.Instance;

        while not Instance2:IsA("Model") or Instance2.Parent:GetAttribute("Draggable") do
            Instance2 = Instance2.Parent;

            if Instance2 == workspace then
                break;
            end;
        end;

        return Instance2;
    end;
end;

local function _() -- Line: 7421
    -- upvalues: u1 (copy), u10 (copy), u1289 (copy), PlayerFunc (copy)
    if u1.dragging then
        local dragging = u1.dragging;
        u10.clearConnectionsAndThreads(u1289);
        task.spawn(function() -- Line: 7425
            -- upvalues: PlayerFunc (ref), dragging (copy)
            PlayerFunc:InvokeServer("equipSpecialItem", dragging.Name);
        end);
    end;

    u1.dragging = nil;
end;

function u1.startDragging(p1298) -- Line: 7431
    -- upvalues: u1 (copy), u10 (copy), u1289 (copy), PlayerFunc (copy), getTouchedItem (copy), u2 (copy), LocalPlayer (copy), u1287 (copy), UserInputService (copy)
    if p1298 then
        local u1299 = u10.typeOf(p1298) == "Instance" and p1298 and p1298 or getTouchedItem();

        if u1299 then
            if u1.dragging then
                local dragging = u1.dragging;
                u10.clearConnectionsAndThreads(u1289);
                task.spawn(function() -- Line: 7425
                    -- upvalues: PlayerFunc (ref), dragging (copy)
                    PlayerFunc:InvokeServer("equipSpecialItem", dragging.Name);
                end);
            end;

            u1.dragging = nil;
            u1.dragging = u1299;
            table.insert(u1289, task.spawn(function() -- Line: 7439
                -- upvalues: PlayerFunc (ref), u10 (ref), u1299 (copy), u1 (ref)
                local v1300 = PlayerFunc:InvokeServer("equipSpecialItem", u10.getInstanceAttribute(u1299, "Original") or u1299.Name, true);

                if v1300 then
                    local InstanceReference = u10.getInstanceReference(v1300, 20);

                    if InstanceReference and u1.platform == "Mobile" then
                        u10.toolVisibility(InstanceReference, false);
                    end;
                end;
            end));

            if not u1299:GetAttribute("DraggedOnce") then
                u1299:SetAttribute("DraggedOnce", true);
            end;

            if u1.platform == "Mobile" then
                if u2.loaded then
                    u2.keepMobileGuiTypePersistent("Dragging", true);
                end;

                local v1301 = u10.getInstanceAttribute(u1299, "Original") or u10.availableItems[u1299.Name];
                local Config = require(v1301.Config);
                u1299.PrimaryPart.Anchored = true;

                local function collisionGroupFunc(p1302) -- Line: 7452
                    -- upvalues: u1299 (copy)
                    for _, descendant in pairs(u1299:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            descendant.CollisionGroup = p1302;
                        end;
                    end;
                end;

                collisionGroupFunc("NonCollide");

                if Config.SPECIAL_SIZE then
                    u1299:ScaleTo(Config.SPECIAL_SIZE);
                end;

                table.insert(u1289, function() -- Line: 7457
                    -- upvalues: collisionGroupFunc (copy), u1299 (copy), u2 (ref), Config (copy)
                    collisionGroupFunc("DraggableObjects");

                    if u1299.Parent then
                        u1299.PrimaryPart.Anchored = false;
                    end;

                    if u2.loaded then
                        u2.keepMobileGuiTypePersistent("Dragging", false);
                    end;

                    if Config.SPECIAL_SIZE then
                        u1299:ScaleTo(1);
                    end;
                end);
                table.insert(u1289, task.spawn(function() -- Line: 7463
                    -- upvalues: u2 (ref), u1 (ref), u1299 (copy), u10 (ref), LocalPlayer (ref), Config (copy)
                    while u2.loaded do
                        u1299:PivotTo(u10.getCharAttachment(LocalPlayer.Character.RightHand, "RightGripAttachment").WorldCFrame * Config.GRIP:Inverse());
                        task.wait();
                    end;

                    u1.startDragging();
                end));
                table.insert(u1289, u1299.Destroying:Connect(function() -- Line: 7473
                    -- upvalues: u1 (ref)
                    u1.startDragging();
                end));

                return;
            end;

            u1287.FilterDescendantsInstances = { workspace.Characters, u1299 };
            local u1303 = u10.clone(game.ReplicatedStorage.Gameplay.Drag.BodyGyro);
            local u1304 = u10.clone(game.ReplicatedStorage.Gameplay.Drag.BodyPosition);
            u1303.Parent = u1299.PrimaryPart;
            u1304.Parent = u1299.PrimaryPart;
            table.insert(u1289, function() -- Line: 7482
                -- upvalues: u1303 (copy), u1304 (copy)
                u1303:Destroy();
                u1304:Destroy();
            end);
            table.insert(u1289, task.spawn(function() -- Line: 7486
                -- upvalues: u1 (ref), u10 (ref), u1287 (ref), u1299 (copy), u1303 (copy), u1304 (copy), u2 (ref)
                local v1305 = 0;

                repeat
                    local v1306 = u1.getMouseProperty.unitRay("FreeSpacePersistent");
                    local v1307 = u10.raycastVisible(v1306.Origin, v1306.Direction * 10, u1287);
                    local v1308 = v1307 and v1307.Position or v1306.Origin + v1306.Direction * 10;
                    local v1309 = v1308 - u1299.PrimaryPart.Position;
                    u1303.CFrame = CFrame.new(Vector3.new(), v1309.Magnitude < 2 and Vector3.new(0, 0, 1) or u10.smartUnit(v1309):Lerp(Vector3.new(0, 1, 0), (math.min(1, v1309.Magnitude * 0.1))));
                    u1304.Position = v1308;
                    u1299.PrimaryPart.AssemblyAngularVelocity = u1299.PrimaryPart.AssemblyAngularVelocity:Lerp(Vector3.new(), 1 - 0.001 ^ v1305);
                    v1305 = task.wait();
                until not u2.loaded;

                u1.startDragging();
            end));
            table.insert(u1289, u1299.Destroying:Connect(function() -- Line: 7503
                -- upvalues: u1 (ref)
                u1.startDragging();
            end));
            table.insert(u1289, UserInputService.InputEnded:Connect(function(p1310, p1311) -- Line: 7506
                -- upvalues: u1 (ref)
                if p1310.UserInputType == Enum.UserInputType.MouseButton1 then
                    u1.startDragging();
                end;
            end));
        end;

        return;
    end;

    if u1.dragging then
        local dragging = u1.dragging;
        u10.clearConnectionsAndThreads(u1289);
        task.spawn(function() -- Line: 7425
            -- upvalues: PlayerFunc (ref), dragging (copy)
            PlayerFunc:InvokeServer("equipSpecialItem", dragging.Name);
        end);
    end;

    u1.dragging = nil;
end;

task.defer(function() -- Line: 7525
    -- upvalues: u1 (copy), u2 (copy), u10 (copy), getTouchedItem (copy), u1288 (ref), DragHighlight (copy)
    while true do
        local v1312 = 0;

        while true do
            if v1312 == 0 then
                v1312 = -1;
                local v1313 = nil;
                local v1314;

                if u1.platform == "Mobile" then
                    if u1.dragging then
                        v1314 = v1313;
                    else
                        v1314 = u2.root and u10.findClosestFromTable(u2.root.Position, u10.collectionGetTagged("Draggable"));

                        if v1314 then
                            if (v1314.PrimaryPart.Position - u2.root.Position).Magnitude >= 12 then
                                v1314 = v1313;
                            end;
                        else
                            v1314 = v1313;
                        end;
                    end;
                else
                    v1314 = getTouchedItem();
                end;

                if not v1314 then
                    if u1288 then
                        DragHighlight.Enabled = false;
                        DragHighlight.Adornee = nil;
                        u1288 = false;
                    end;

                    v1312 = 1;
                    continue;
                end;

                if true then
                    if v1314:IsA("Model") and not v1314.Parent:GetAttribute("Draggable") then
                        if u1288 ~= v1314 then
                            DragHighlight.Enabled = true;
                            DragHighlight.Adornee = v1314;
                            u1288 = v1314;
                        end;
                    else
                        v1314 = v1314.Parent;

                        if v1314 ~= workspace then
                            v1312 = -3;
                            break;
                        end;

                        if u1288 ~= v1314 then
                            DragHighlight.Enabled = true;
                            DragHighlight.Adornee = v1314;
                            u1288 = v1314;
                        end;
                    end;
                end;

                v1312 = 1;
                continue;
            elseif v1312 == 1 then
                v1312 = -1;
                task.wait(0.12);
                break;
            else
                break;
            end;
        end;

        if v1312 == -3 then
            continue;
        end;
    end;
end);
local u1315 = false;
local u1316 = {};
local Radio = game.ReplicatedStorage.Gameplay.Radio;
local u1317 = {};

local function playSong(p1318) -- Line: 7558
    -- upvalues: Radio (copy), u10 (copy), u2 (copy)
    game.SoundService.Radio.SoundId = Radio.Stations[p1318].Playing.SoundId;

    if not game.SoundService.Radio.IsLoaded then
        game.SoundService.Radio.Loaded:Wait();
    end;

    game.SoundService.Radio.Volume = Radio.Stations[p1318].Playing.Volume;
    local Radio2 = game.SoundService.Radio;
    local v1319;

    if Radio.Stations[p1318].SongName.Value == "Intermission" then
        v1319 = 0;
    else
        local v1320 = u10.getDistributedGameTime() - Radio.Stations[p1318].StartTime.Value;
        v1319 = math.max(0, v1320);
    end;

    Radio2.TimePosition = v1319;
    game.SoundService.Radio:Play();

    if u2.loaded and u2.setVolume then
        u2.radioBaseVolume = game.SoundService.Radio.Volume;
        u2.setVolume(0);
    end;
end;

function u1.radioActivate(u1321, p1322, u1323, p1324) -- Line: 7570
    -- upvalues: CharScope (copy), u10 (copy), u1316 (copy), u1 (copy), u1315 (ref), Radio (copy), u1317 (copy), playSong (copy)
    CharScope.setThreadOrCleanUpFunctionIndex("Global", "radioActivate", nil);
    u10.clearConnectionsAndThreads(u1316);

    if game.SoundService.Radio.IsPlaying then
        game.SoundService.Radio:Stop();
    end;

    game.SoundService.Radio.SoundGroup = p1322 and game.SoundService.SoundGroups[p1322];

    if not u1.readPlayerData("Settings", "MuteMusicAmbience") then
        game.SoundService.SoundGroups.MusicAmbience.Volume = u1321 and 0 or 1;
    end;

    u1315 = u1321;

    if not (u1323 and u1321) then
        u1.removePin("FM Radio");
    end;

    if u1321 and not u1.readPlayerData("Settings", "MuteMusic") then
        if p1324 then
            CharScope.setThreadOrCleanUpFunctionIndex("Global", "radioActivate", function() -- Line: 7583
                -- upvalues: u1 (ref)
                u1.radioActivate();
            end);
        end;

        local function displayInfoFunc() -- Line: 7587
            -- upvalues: Radio (ref), u1321 (copy), u1 (ref), u10 (ref), u1317 (ref)
            if Radio.Stations[u1321].SongName.Value == "Intermission" then
                return;
            end;

            local u1325 = u1.isNotification("FM Radio") or u1.notify({
                custom = "FMRadio",
                pin = "FM Radio"
            });
            u1325.Song.TextLabel.Text = "";

            for i = 1, 10 do
                u1325.Song.TextLabel.Text = u1325.Song.TextLabel.Text .. Radio.Stations[u1321].SongName.Value .. "        ";
                local _ = i;
            end;

            local u1326 = u10.getTextBounds(u1325.Song.TextLabel).X / u1325.Song.AbsoluteSize.X;

            for _, v in pairs(u1317) do
                u10.taskCancel(v);
            end;

            table.clear(u1317);
            table.insert(u1317, task.spawn(function() -- Line: 7595
                -- upvalues: u1326 (copy), u1325 (copy)
                while true do
                    for i = 0, -u1326, -0.007 do
                        u1325.Song.TextLabel.Position = UDim2.fromScale(i, 0.5);
                        task.wait(0.016);

                        if not u1325.Parent then
                            return;
                        end;

                        local _ = i;
                    end;
                end;
            end));
            table.insert(u1317, task.delay(6, function() -- Line: 7603
                -- upvalues: u1 (ref)
                u1.removePin("FM Radio");
            end));
        end;

        local u1327 = false;
        table.insert(u1316, game.SoundService.Radio.Ended:Connect(function() -- Line: 7606
            -- upvalues: Radio (ref), u1321 (copy), u1327 (ref), playSong (ref), u1323 (copy), displayInfoFunc (copy)
            if game.SoundService.Radio.SoundId == Radio.Stations[u1321].Playing.SoundId then
                u1327 = true;

                return;
            end;

            playSong(u1321);

            if u1323 then
                displayInfoFunc();
            end;
        end));
        local PropertyChangedSignal = Radio.Stations[u1321].Playing:GetPropertyChangedSignal("SoundId");
        table.insert(u1316, PropertyChangedSignal:Connect(function() -- Line: 7614
            -- upvalues: u1327 (ref), playSong (ref), u1321 (copy), u1323 (copy), displayInfoFunc (copy)
            if u1327 then
                u1327 = false;
                playSong(u1321);

                if u1323 then
                    displayInfoFunc();
                end;
            end;
        end));
        task.spawn(function() -- Line: 7621
            -- upvalues: playSong (ref), u1321 (copy), u1323 (copy), displayInfoFunc (copy)
            playSong(u1321);

            if u1323 then
                displayInfoFunc();
            end;
        end);
    end;
end;

local u1328 = 0;
local u1329 = {
    red = Color3.fromRGB(255, 65, 65),
    green = Color3.fromRGB(67, 255, 67),
    blue = Color3.fromRGB(0, 166, 255)
};
local u1330 = {
    Paycheck = true,
    FMRadio = true,
    Tip = true,
    Button = true,
    Quests = true,
    QuestBoard = true
};
local u1331 = {
    Decision = true,
    Tip = true,
    IconNotification = true
};

function u1.setNotifyColor(p1332, p1333) -- Line: 7635
    -- upvalues: u1329 (copy)
    p1332.Background.ImageColor3 = u1329[p1333] or Color3.fromRGB();
    p1332.Color.BackgroundColor3 = u1329[p1333] or Color3.fromRGB(255, 255, 255);
end;

function u1.addNotifyMoneyDesign(p1334) -- Line: 7640
    -- upvalues: u10 (copy)
    if string.find(p1334.TextLabel.Text, "＄") then
        local string_gsub_ret = string.gsub(p1334.TextLabel.Text, "＄", "@");

        for i = #string_gsub_ret, 1, -1 do
            local v1335;

            if string.sub(string_gsub_ret, i, i) == "@" then
                v1335 = i;

                for i2 = i + 1, #string_gsub_ret do
                    local string_sub_ret = string.sub(string_gsub_ret, i2, i2);

                    if i2 == #string_gsub_ret or (string_sub_ret == " " or string_sub_ret == "\n") then
                        string_gsub_ret = string.sub(string_gsub_ret, 1, v1335 - 1) .. "<font color=\"rgb(137, 255, 135)\"><b>@" .. u10.commaValue((string.sub(string_gsub_ret, v1335 + 1, i2))) .. "</b></font>" .. string.sub(string_gsub_ret, i2 + 1);
                        break;
                    end;

                    local _ = i2;
                end;
            else
                v1335 = i;
            end;
        end;

        p1334.TextLabel.Text = string.gsub(string_gsub_ret, "@", "＄");
    end;
end;

function u1.destroyNotificationsOnCharRemoving() -- Line: 7659
    -- upvalues: u1 (copy)
    for _, v in pairs({ u1.notificationsGui, u1.notificationsGuiLowDisplayOrder }) do
        for _, child in pairs(v:GetChildren()) do
            if child:GetAttribute("DestroyOnCharRemoving") then
                child:Destroy();
            end;
        end;
    end;
end;

u1.lastNotifyTick = 0;

function u1.notify(u1336) -- Line: 7668
    -- upvalues: u1 (copy), u10 (copy), u1328 (ref), u2 (copy), LocalPlayer (copy), u1330 (copy), Stuff (copy), PlayerFunc (copy), u1331 (copy)
    if u1336.pin and u1.isNotification(u1336.pin) then
        u1.removePin(u1336.pin);
    end;

    u1.lastNotifyTick = tick();
    local u1337 = u1336.custom and (u1336.custom .. "Preview" or "NotificationPreview") or "NotificationPreview";
    local u1338 = u1.notificationsGui:FindFirstChild(u1337) or u1.notificationsGuiLowDisplayOrder[u1337];
    local u1339 = u10.clone(u1338);
    local u1340 = {};
    u1.notifyCounter = (u1.notifyCounter or 0) + 1;
    local notifyCounter = u1.notifyCounter;

    local function destroy() -- Line: 7679
        -- upvalues: u1336 (copy), u10 (ref), u1340 (copy), destroy (ref), u1339 (copy), u1 (ref)
        if u1336.destroyedFunc then
            u1336.destroyedFunc();
        end;

        u10.clearConnectionsAndThreads(u1340);
        destroy = nil;

        if u1336.pin then
            u1.removePin(u1336.pin);

            return;
        end;

        u10.transparencyFade(u1339, false, 0.12);
        u1339:Destroy();
    end;

    task.spawn(function() -- Line: 7690
        -- upvalues: u1339 (copy), u1336 (copy), u1328 (ref), notifyCounter (copy), u1338 (copy), u1 (ref), u2 (ref), u10 (ref), LocalPlayer (ref), u1330 (ref), u1337 (copy), u1340 (copy), destroy (ref), Stuff (ref), PlayerFunc (ref), u1331 (ref)
        u1339.Name = u1336.pin or "Notification";
        u1339:SetAttribute("Position", -u1328 + 1);
        u1339:SetAttribute("NotifyID", notifyCounter);

        if u1336.id then
            u1339:SetAttribute("Id", u1336.id);
        end;

        u1339.Parent = u1338.Parent;

        while u1.loadingActivated ~= nil or (u1.setupLoading or not (u2.loaded or u10.isCharLoaded(LocalPlayer))) do
            task.wait(0.5);
        end;

        if not u1339.Parent or u1339.Name == "Destroyed" then
            return;
        end;

        task.spawn(u10.transparencyFade, u1339, true, 0.12);

        if not (u1336.custom and u1330[u1336.custom]) then
            game.SoundService.Notification:Play();
        end;

        if u1336.textXAlginment then
            u1339.TextLabel.TextXAlignment = u1336.textXAlginment;
        end;

        u1339.Position = UDim2.fromScale(0, -u1328 + 1);
        u1339.Visible = true;
        local v1341 = u1336.lifetime or 5;

        if u1336.message and (u1336.timerGameTime or u1336.timerGameTimeAttribute) then
            local message = u1336.message;

            local function updateMessage(p1342) -- Line: 7706
                -- upvalues: message (copy), u10 (ref)
                return string.gsub(message, "*TIMER", u10.timerFormat(p1342));
            end;

            local function getCurrentTimeLeft() -- Line: 7707
                -- upvalues: u1336 (ref), u10 (ref)
                local v1343 = (u1336.timerGameTimeAttribute and u1336.timerGameTimeAttribute[1]:GetAttribute(u1336.timerGameTimeAttribute[2]) or (u1336.timerGameTime or 0)) - u10.getDistributedGameTime();

                return math.round(v1343);
            end;

            local v1344 = (u1336.timerGameTimeAttribute and u1336.timerGameTimeAttribute[1]:GetAttribute(u1336.timerGameTimeAttribute[2]) or (u1336.timerGameTime or 0)) - u10.getDistributedGameTime();
            local math_round_ret = math.round(v1344);
            u1336.message = string.gsub(message, "*TIMER", u10.timerFormat(math_round_ret));
            task.defer(function() -- Line: 7709
                -- upvalues: u1339 (ref), u1336 (ref), u10 (ref), message (copy)
                while u1339.Parent do
                    local v1345 = (u1336.timerGameTimeAttribute and u1336.timerGameTimeAttribute[1]:GetAttribute(u1336.timerGameTimeAttribute[2]) or (u1336.timerGameTime or 0)) - u10.getDistributedGameTime();
                    local math_round_ret2 = math.round(v1345);

                    if math_round_ret2 <= 0 then
                        return;
                    end;

                    u1339.TextLabel.Text = string.gsub(message, "*TIMER", u10.timerFormat(math_round_ret2));
                    task.wait(1);
                end;
            end);
        end;

        if u1336.pin and (u1337 == "NotificationPreview" or u1337 == "DecisionPreview") then
            u1339.Background.PinIcon.Visible = true;
        end;

        if u1336.destroyOnCharRemoving then
            u1339:SetAttribute("DestroyOnCharRemoving", true);
        end;

        if u1336.custom == "Decision" then
            for i, v in pairs({ u1339.Buttons.Button1, u1339.Buttons.Button2 }) do
                local v1346 = u1336["button" .. i];
                v.Visible = v1346;

                if v1346 then
                    v.TextLabel.Text = v1346;
                    u10.buildSignalData(u1340, u10.buttonHoverSignalData(v));
                    u10.buildSignalData(u1340, u1.mouseButton(v, function() -- Line: 7730
                        -- upvalues: u1336 (ref), i (copy), destroy (ref)
                        if u1336["buttonResult" .. i] then
                            u1336["buttonResult" .. i]();
                        end;

                        destroy();
                    end));
                end;
            end;
        elseif u1336.custom == "Reputation" then
            u1339.TextLabel.Text = "Reputation " .. u1336.reputation;
            game.SoundService.RankUp:Play();
        elseif u1336.custom == "Button" then
            u1339.TextLabel.Text = u1336.message;

            if u1336.buttonGrayedOut then
                u1339.Background.ImageColor3 = Color3.fromRGB(140, 140, 140);
            elseif u1336.color then
                u1339.Background.ImageColor3 = u1336.color;
            end;

            if u1336.pin == "BailOut" then
                function u1336.buttonResult() -- Line: 7747
                    -- upvalues: u1336 (ref), u1 (ref), LocalPlayer (ref), u10 (ref), Stuff (ref), PlayerFunc (ref)
                    if u1336.buttonGrayedOut then
                        u1.notify({
                            message = "You hit your bail out limit. Try again later",
                            color = "red"
                        });

                        return;
                    end;

                    local Attribute = LocalPlayer:GetAttribute("PrisonTime");

                    if Attribute then
                        local v1347 = Attribute - u10.getDistributedGameTime();

                        if v1347 > 0 then
                            local v1348 = nil;

                            for _, child in pairs(Stuff.DeveloperProducts.BailOutJail:GetChildren()) do
                                local v1349 = child:FindFirstChild("MinimumTime") and (child.MinimumTime.Value or 0) or 0;

                                if v1349 * 60 < v1347 and (not v1348 or v1348[2] < v1349) then
                                    v1348 = { child, v1349 };
                                end;
                            end;

                            local v1350 = PlayerFunc:InvokeServer("promptProductPurchase", v1348[1].ID.Value);

                            if u10.typeOf(v1350) == "string" then
                                u1.notify({
                                    color = "red",
                                    message = v1350
                                });
                            end;
                        else
                            u1.notify({
                                message = "Your time in prison just ended",
                                color = "red"
                            });
                        end;
                    end;
                end;
            end;

            u10.buildSignalData(u1340, u10.buttonHoverSignalData(u1339.Background));
            u10.buildSignalData(u1340, u1.mouseButton(u1339.Background, function() -- Line: 7770
                -- upvalues: u1336 (ref), destroy (ref)
                if u1336.buttonResult and u1336.buttonResult() then
                    destroy();
                end;
            end, {
                mobileButtonType = "MouseButton1Click"
            }));
        elseif u1336.custom == "QuestBoard" then
            u10.buildSignalData(u1340, u10.buttonHoverSignalData(u1339.Background));
            u10.buildSignalData(u1340, u1.mouseButton(u1339.Background, function() -- Line: 7775
                -- upvalues: u1336 (ref)
                if u1336.buttonResult then
                    u1336.buttonResult();
                end;
            end, {
                mobileButtonType = "MouseButton1Click"
            }));
        end;

        if not u1336.custom or u1331[u1336.custom] then
            if u1336.icon then
                u1339.Background.Icon.Image = u1336.icon;
                u1339.Background.Icon.Shadow.Image = u1339.Background.Icon.Image;
            end;

            local Scale = u1339.TextLabel.Size.Y.Scale;
            local v1351, _ = u10.fitText(u1339.TextLabel, u1336.message, u1336.maxLines or 15);
            v1341 = u1336.lifetime or 2 + v1351 * 3;
            u1.addNotifyMoneyDesign(u1339);

            if u1339:FindFirstChild("Color") then
                local v1352 = math.max(0, Scale * (v1351 - 2)) + 1;

                if v1351 > 1 then
                    u1339.TextLabel.Position = u1339.TextLabel.Position + UDim2.fromScale(0, 0.15);
                end;

                u1339.Background.Size = UDim2.fromScale(1, v1352);
                u1.setNotifyColor(u1339, u1336.color);
                u1339.Color.Size = UDim2.fromScale(u1339.Color.Size.X.Scale, v1352);
            end;
        end;

        local v1353 = u1339.Size.Y.Scale * u1339.Background.Size.Y.Scale;

        if u1336.pin then
            u1339:TweenPosition(UDim2.fromScale(0, -u1328), "Out", "Quart", 0.7, true);
            u1339:SetAttribute("Position", -u1328);
            u1328 = u1328 + v1353 + 0.08;
        else
            u1339:SetAttribute("Position", -u1328 + v1353 + 0.08);
        end;

        for _, v in pairs({ u1.notificationsGui, u1.notificationsGuiLowDisplayOrder }) do
            for _, child in pairs(v:GetChildren()) do
                if child.Name == "Notification" and (child:GetAttribute("NotifyID") or 0) <= notifyCounter then
                    local v1354 = child:GetAttribute("Position") - v1353 - 0.08;
                    child:SetAttribute("Position", v1354);
                    child:TweenPosition(UDim2.fromScale(0, v1354), "Out", "Quart", 0.7, true);
                end;
            end;
        end;

        if not u1336.pin then
            task.delay(v1341, function() -- Line: 7812
                -- upvalues: destroy (ref)
                if destroy then
                    destroy();
                end;
            end);
        end;
    end);

    return u1339, destroy;
end;

function u1.isNotification(p1355) -- Line: 7834
    -- upvalues: u1 (copy)
    return u1.notificationsGui:FindFirstChild(p1355) or u1.notificationsGuiLowDisplayOrder:FindFirstChild(p1355);
end;

function u1.getNotificationById(p1356) -- Line: 7838
    -- upvalues: u1 (copy)
    for _, v in pairs({ u1.notificationsGui, u1.notificationsGuiLowDisplayOrder }) do
        for _, child in pairs(v:GetChildren()) do
            if child:GetAttribute("Id") == p1356 then
                return child;
            end;
        end;
    end;
end;

function u1.removePin(p1357) -- Line: 7846
    -- upvalues: u1 (copy), u1328 (ref), u10 (copy)
    local u1358 = u1.isNotification(p1357);

    if u1358 then
        u1358.Name = "Destroyed";
        local v1359 = u1358.Size.Y.Scale * u1358.Background.Size.Y.Scale + 0.08;

        if u1358.Visible then
            u1328 = u1328 - v1359;
        end;

        for _, v in pairs({ u1.notificationsGui, u1.notificationsGuiLowDisplayOrder }) do
            for _, child in pairs(v:GetChildren()) do
                if child.Visible and (child.Name ~= "Destroyed" and child:GetAttribute("Position") < u1358:GetAttribute("Position")) then
                    child:SetAttribute("Position", child:GetAttribute("Position") + v1359);
                    child:TweenPosition(UDim2.fromScale(0, child:GetAttribute("Position")), "Out", "Quart", 0.7, true);
                end;
            end;
        end;

        task.spawn(function() -- Line: 7860
            -- upvalues: u10 (ref), u1358 (copy)
            u10.transparencyFade(u1358, false, 0.12);
            u1358:Destroy();
        end);
    end;
end;

local HintMessage = GlobalGui.Center.Top.HintMessage;
local u1360 = 0;
local u1361 = {};

function u1.hintMessage(p1362) -- Line: 7870
    -- upvalues: u1360 (ref), u10 (copy), u1361 (copy), HintMessage (copy), u1 (copy)
    u1360 = (u1360 + 1) % 100;
    local v1363 = u1360;
    u10.clearConnectionsAndThreads(u1361);

    if p1362 then
        u10.guiTransition(HintMessage, "Position", UDim2.fromScale(0, 0.1), true);
        HintMessage.TextLabel.Text = p1362;
        HintMessage.Size = UDim2.fromScale(50, HintMessage.Size.Y.Scale);
        HintMessage.Size = UDim2.fromScale(u10.getTextBounds(HintMessage.TextLabel).X / HintMessage.Parent.AbsoluteSize.X + 0.4, HintMessage.Size.Y.Scale);
        u10.buildSignalData(u1361, u1.mouseButton(HintMessage, function() -- Line: 7879
            -- upvalues: u1 (ref)
            u1.hintMessage();
        end));
        task.wait(20);

        if v1363 == u1360 then
            u1.hintMessage();
        end;
    else
        u10.guiTransition(HintMessage, "Position", UDim2.fromScale(0, 0.1), false);
    end;
end;

u1.debugLoadingClient("Core 6");
local Waypoints = GlobalGui.Waypoints;
local u1364 = {};
local u1365 = true;

local function worldToViewportPointProjected(p1366) -- Line: 7893
    -- upvalues: workspace_CurrentCamera (copy)
    local lookVector = workspace_CurrentCamera.CFrame.lookVector;
    local v1367 = p1366 - workspace_CurrentCamera.CFrame.Position;
    local v1368 = lookVector:Dot(v1367);

    if v1368 <= 0 then
        p1366 = workspace_CurrentCamera.CFrame.Position + (v1367 - lookVector * v1368 * 1.01);
    end;

    return workspace_CurrentCamera:WorldToViewportPoint(p1366);
end;

local function viewportPointEdgeClamp(p1369) -- Line: 7905
    -- upvalues: workspace_CurrentCamera (copy), u10 (copy)
    local v1370 = Vector2.new(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) / 2;
    local v1371 = u10.smartUnit(p1369 - v1370);
    local math_atan2_ret = math.atan2(v1371.X, v1371.Y);
    local v1372 = (v1370.Y - 25) / math.cos(math_atan2_ret);
    local math_abs_ret = math.abs(v1372);
    local v1373 = (v1370.X - 25) / math.cos(math_atan2_ret + 1.5707963267948966);
    local math_abs_ret2 = math.abs(v1373);
    local math_min_ret = math.min(math_abs_ret, math_abs_ret2);
    local v1374 = -math.deg(math_atan2_ret) + 180;

    return v1370 + v1371 * math_min_ret, v1374;
end;

function u1.destroyWaypointsOnDeath() -- Line: 7918
    -- upvalues: u1364 (copy)
    for _, v in pairs(u1364) do
        v:Destroy();
    end;

    table.clear(u1364);
end;

u230 = function(p1375) -- Line: 7923, Name: waypointVisibility
    -- upvalues: u1365 (ref), Waypoints (copy)
    u1365 = p1375;

    for _, child in pairs(Waypoints:GetChildren()) do
        if child.Name ~= "WaypointPreview" then
            child.Visible = p1375;
        end;
    end;
end;

u1.waypoints = {};

function u1.createWaypoint(u1376) -- Line: 7931
    -- upvalues: Waypoints (copy), MapLocations (copy), u1 (copy), u10 (copy), u2 (copy), LocalPlayer (copy), u1365 (ref), u1364 (copy), workspace_CurrentCamera (copy), GameRules (copy), viewportPointEdgeClamp (copy), RunService (copy), HttpService (copy)
    for _, child in pairs(Waypoints:GetChildren()) do
        if child.Name == u1376.name then
            child:Destroy();
        end;
    end;

    if MapLocations:FindFirstChild(u1376.name) then
        MapLocations[u1376.name]:Destroy();
    end;

    if u1.waypoints[u1376.name] then
        u1.waypoints[u1376.name] = nil;
    end;

    u1.startNavigation(u1376.name);

    if not u1376.create then
        return;
    end;

    if not (u1376.location and (u10.typeOf(u1376.location) ~= "table" or not u10.isTableEmpty(u1376.location))) then
        warn(u1376.location and "CreateWaypoint location parameter is empty table for:" or "CreateWaypoint location parameter is empty for:", u1376.name);

        return;
    end;

    if not u1376.loadNextWhenCharStudsAway then
        local u1377 = {};
        local Decal = Instance.new("Decal");
        Decal:SetAttribute("IgnoreGetLocation", true);
        Decal.Name = u1376.name;

        if u1376.displayName then
            Decal:SetAttribute("DisplayName", u1376.displayName);
        end;

        Decal.Texture = u1376.image;
        Decal:SetAttribute("RenderPriority", u1376.renderPriority or 1);
        local u1378 = u10.typeOf(u1376.location) == "table";

        local function getClosestLocation() -- Line: 7961
            -- upvalues: u1378 (copy), u10 (ref), LocalPlayer (ref), u1376 (copy)
            if u1378 then
                return u10.findClosestFromTable(LocalPlayer.Character.PrimaryPart.Position, u1376.location);
            end;
        end;

        if u1376.navigation then
            local startNavigation = u1.startNavigation;
            local name = u1376.name;
            local v1379;

            if u1378 then
                v1379 = u10.findClosestFromTable(LocalPlayer.Character.PrimaryPart.Position, u1376.location);
            else
                v1379 = nil;
            end;

            startNavigation(name, v1379 or u1376.location, u1376.color);
        end;

        for _, v in pairs(u1378 and u1376.location or { u1376.location }) do
            local u1380 = nil;

            local function setLocation(u1381) -- Line: 7970
                -- upvalues: u10 (ref), u1380 (ref), u1376 (copy), u1 (ref)
                if u10.typeOf(u1381) == "Vector3" then
                    u1380 = function() -- Line: 7972, Name: getLocation
                        -- upvalues: u1381 (copy)
                        return u1381;
                    end;
                else
                    local u1382 = u1381:IsA("Attachment") and "WorldPosition" or "Position";

                    u1380 = function() -- Line: 7975, Name: getLocation
                        -- upvalues: u1381 (copy), u1382 (copy)
                        return u1381[u1382];
                    end;
                end;

                if not u1376.hideOnScreen then
                    u1.waypoints[u1376.name] = u1380;
                end;
            end;

            if u1376.hideOnScreen then
                setLocation(v);
            else
                local u1383 = false;
                local u1384 = u10.clone(Waypoints.WaypointPreview);
                u1384.Visible = u1365;
                u1384.Name = u1376.name;
                u1384.Icon.Image = u1376.image;

                if u1376.imageSize then
                    u1384.Icon.Size = UDim2.fromScale(u1384.Icon.Size.X.Scale * u1376.imageSize, u1384.Icon.Size.Y.Scale * u1376.imageSize);
                end;

                u1384.RotateLabel.Background.ImageColor3 = u1376.color;
                u1384.Parent = Waypoints;

                if u1376.destroyOnDeath then
                    table.insert(u1364, u1384);
                end;

                setLocation(v);
                local u1385 = u1380;
                local u1386 = false;
                local u1387 = true;

                local function updateStatus() -- Line: 7995
                    -- upvalues: u10 (ref), u1385 (copy), u1 (ref), u1386 (ref), u1376 (copy), u1384 (copy), setLocation (copy), v (copy), u1387 (ref), u1378 (copy), LocalPlayer (ref)
                    local LocationInsideAtPos = u10.getLocationInsideAtPos(u1385());
                    local v1388;

                    if LocationInsideAtPos then
                        v1388 = u1.visualizedLocation == LocationInsideAtPos and "inside" or (u1.visualizedLocation and "otherInside" or "waypointInside");
                    else
                        v1388 = u1.visualizedLocation and "plrInside" or "outside";
                    end;

                    if u1386 ~= v1388 then
                        u1386 = v1388;

                        if not u1376.showForSomeTime then
                            local v1389;

                            if v1388 == "plrInside" then
                                v1389 = false;
                            else
                                v1389 = v1388 ~= "otherInside";
                            end;

                            u1384.Visible = v1389;
                        end;

                        setLocation(v1388 == "waypointInside" and u10.getLocationOutsideCenter(LocationInsideAtPos) or v);

                        if u1376.navigation and v1388 ~= "inside" ~= u1387 then
                            u1387 = not u1387;
                            local startNavigation = u1.startNavigation;
                            local name = u1376.name;
                            local v1390 = u1387;

                            if v1390 then
                                local v1391;

                                if u1378 then
                                    v1391 = u10.findClosestFromTable(LocalPlayer.Character.PrimaryPart.Position, u1376.location);
                                else
                                    v1391 = nil;
                                end;

                                v1390 = v1391 or u1376.location;
                            end;

                            startNavigation(name, v1390, u1376.color);
                        end;
                    end;
                end;

                task.spawn(function() -- Line: 8008
                    -- upvalues: u1384 (copy), updateStatus (copy)
                    while u1384.Parent do
                        updateStatus();
                        task.wait(1);
                    end;
                end);

                if u1376.navigation and u1378 then
                    local u1392;

                    if u1378 then
                        u1392 = u10.findClosestFromTable(LocalPlayer.Character.PrimaryPart.Position, u1376.location);
                    else
                        u1392 = nil;
                    end;

                    task.spawn(function() -- Line: 8016
                        -- upvalues: u1384 (copy), u1387 (ref), u2 (ref), u10 (ref), u1376 (copy), u1392 (ref), u1 (ref)
                        while u1384.Parent do
                            if u1387 and u2.root then
                                local v1393 = u10.findClosestFromTable(u2.root.Position, u1376.location);

                                if u1392 ~= v1393 then
                                    u1392 = v1393;
                                    u1.startNavigation(u1376.name, v1393, u1376.color);
                                end;
                            end;

                            task.wait(1);
                        end;
                    end);
                end;

                if u1376.showForSomeTime then
                    task.spawn(function() -- Line: 8047
                        -- upvalues: u1376 (copy), u1 (ref), u1386 (ref), updateStatus (copy), u1384 (copy)
                        local showForSomeTime = u1376.showForSomeTime;

                        while true do
                            if u1.loadingActivated == nil and (u1386 ~= "plrInside" and u1386 ~= "otherInside") then
                                updateStatus();

                                if u1386 ~= "plrInside" and u1386 ~= "otherInside" then
                                    u1386 = false;
                                    u1376.showForSomeTime = nil;
                                    task.wait(showForSomeTime);

                                    if not u1384.Parent then
                                        return;
                                    end;

                                    u1376.hideOnScreen = true;
                                    u1.createWaypoint(u1376);

                                    return;
                                end;
                            end;

                            task.wait(0.5);

                            if not u1384.Parent then
                                return;
                            end;
                        end;
                    end);
                elseif u1376.pulsating then
                    u1384.Pulsating.ImageColor3 = u1376.color;
                    task.spawn(function() -- Line: 8064
                        -- upvalues: u1384 (copy), u10 (ref)
                        u1384.Pulsating.Visible = true;

                        while u1384.Parent do
                            u10.tweenServiceSet(u1384.Pulsating, {
                                ImageTransparency = 0
                            });
                            u10.tweenServiceSet(u1384.Pulsating, {
                                Size = UDim2.fromScale(0, 0)
                            });
                            u10.tweenServiceStart(u1384.Pulsating, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(2.5, 2.5)
                            });
                            task.wait(0.25);

                            if not u1384.Parent then
                                return;
                            end;

                            u10.tweenServiceStart(u1384.Pulsating, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            });
                            task.wait(1);
                        end;
                    end);
                end;

                task.spawn(function() -- Line: 8076
                    -- upvalues: u1384 (copy), u1380 (ref), u1376 (copy), workspace_CurrentCamera (ref), u1383 (ref), u2 (ref), u1 (ref), u1365 (ref), u10 (ref), GameRules (ref), viewportPointEdgeClamp (ref), RunService (ref)
                    while u1384.Parent do
                        local u1394 = u1380();

                        if u1376.offset then
                            u1394 = u1394 + u1376.offset;
                        end;

                        local Magnitude = (u1394 - workspace_CurrentCamera.CFrame.Position).Magnitude;

                        if u1376.showMessageWhenCloseForSomeTime and not u1383 then
                            local function isDistanceValid() -- Line: 8083
                                -- upvalues: u2 (ref), u1394 (ref), u1376 (ref)
                                local v1395 = u2.root and (Vector2.new(u1394.X, u1394.Z) - Vector2.new(u2.root.Position.X, u2.root.Position.Z)).Magnitude < u1376.showMessageWhenCloseForSomeTime[1];

                                return v1395;
                            end;

                            local v1396 = u2.root and (Vector2.new(u1394.X, u1394.Z) - Vector2.new(u2.root.Position.X, u2.root.Position.Z)).Magnitude < u1376.showMessageWhenCloseForSomeTime[1];

                            if v1396 then
                                u1383 = true;
                                task.defer(function() -- Line: 8088
                                    -- upvalues: u1376 (ref), u2 (ref), u1394 (ref), u1383 (ref), u1 (ref)
                                    for i = 1, u1376.showMessageWhenCloseForSomeTime[3] do
                                        task.wait(1);
                                        local v1397 = u2.root and (Vector2.new(u1394.X, u1394.Z) - Vector2.new(u2.root.Position.X, u2.root.Position.Z)).Magnitude < u1376.showMessageWhenCloseForSomeTime[1];

                                        if not v1397 then
                                            u1383 = false;

                                            return;
                                        end;

                                        local _ = i;
                                    end;

                                    u1.notify({
                                        message = u1376.showMessageWhenCloseForSomeTime[2]
                                    });
                                end);
                            end;
                        end;

                        if u1376.destroyWhenClose and (not u1376.hasRadius and u2.root) and (not u1.visualizedLocation and (u1394 - u2.root.Position).Magnitude < u1376.destroyWhenClose or u1.visualizedLocation and u1.visualizedLocation:FindFirstChild("CenterPosition") and ((u1.visualizedLocation.CenterPosition:IsA("ObjectValue") and u1.visualizedLocation.CenterPosition.Value.Position or u1.visualizedLocation.CenterPosition.Position) - u1394).Magnitude < u1376.destroyWhenClose) then
                            task.wait();

                            if u1384.Parent then
                                return u1.createWaypoint({
                                    name = u1376.name
                                });
                            end;
                        end;

                        if u1365 then
                            if u1376.minDistance then
                                if Magnitude < u1376.minDistance then
                                    if u1384.Visible then
                                        u1384.Visible = false;
                                    end;
                                elseif not u1384.Visible then
                                    u1384.Visible = true;
                                end;
                            elseif u1376.distance then
                                if u1376.distance < Magnitude then
                                    if u1384.Visible then
                                        u1384.Visible = false;
                                    end;
                                elseif not u1384.Visible then
                                    u1384.Visible = true;
                                end;
                            end;
                        end;

                        if u1384.Visible then
                            local v1398 = u1394;
                            local lookVector = workspace_CurrentCamera.CFrame.lookVector;
                            local v1399 = v1398 - workspace_CurrentCamera.CFrame.Position;
                            local v1400 = lookVector:Dot(v1399);

                            if v1400 <= 0 then
                                v1398 = workspace_CurrentCamera.CFrame.Position + (v1399 - lookVector * v1400 * 1.01);
                            end;

                            local v1401, v1402 = workspace_CurrentCamera:WorldToViewportPoint(v1398);

                            if v1402 then
                                u1384.Distance.Text = u1376.hasRadius and u1376.hasRadius >= Magnitude and "" or (u10.roundNumber(Magnitude / 1000 * GameRules.velocityToMph, 1) .. "mi" or "");

                                if u1384.RotateLabel.Rotation ~= 0 then
                                    u1384.RotateLabel.Rotation = 0;
                                end;

                                u1384.Position = UDim2.fromOffset(v1401.X, v1401.Y);
                            else
                                if u1384.Distance.Text ~= "" then
                                    u1384.Distance.Text = "";
                                end;

                                local v1403, v1404 = viewportPointEdgeClamp(Vector2.new(v1401.X, v1401.Y));
                                u1384.Position = UDim2.fromOffset(v1403.X, v1403.Y);
                                u1384.RotateLabel.Rotation = v1404 + 180;
                            end;
                        end;

                        RunService.RenderStepped:Wait();
                    end;
                end);
            end;

            local v1405;

            if u10.typeOf(v) == "Instance" then
                v1405 = Instance.new("ObjectValue");
                v1405.Value = v;
                table.insert(u1377, v.Destroying:Connect(function() -- Line: 8136
                    -- upvalues: u10 (ref), u1377 (copy), u1 (ref), u1376 (copy)
                    u10.clearConnectionsAndThreads(u1377);
                    u1.createWaypoint({
                        name = u1376.name
                    });
                end));
                table.insert(u1377, Decal.Destroying:Connect(function() -- Line: 8140
                    -- upvalues: u10 (ref), u1377 (copy)
                    u10.clearConnectionsAndThreads(u1377);
                end));
            else
                v1405 = Instance.new("Part");
                v1405.Anchored = true;
                v1405.Size = Vector3.new(1, 1, 1);
                v1405.CFrame = CFrame.new(u1380());
            end;

            v1405.Name = u1376.name;

            if u1376.displayName then
                v1405:SetAttribute("DisplayName", u1376.displayName);
            end;

            v1405.Parent = Decal;

            if u1376.hasRadius then
                v1405:SetAttribute("hasRadius", u1376.hasRadius);
            end;

            if u1376.whenNavigated and u1376.whenNavigated.showRadius then
                v1405:SetAttribute("whenNavigatedShowRadius", u1376.whenNavigated.showRadius);
            end;

            if u1376.whenNavigated and u1376.whenNavigated.showMessageWhenCloseForSomeTime then
                v1405:SetAttribute("whenNavigatedShowMessageWhenCloseForSomeTime", HttpService:JSONEncode(u1376.whenNavigated.showMessageWhenCloseForSomeTime));
            end;
        end;

        if u1376.color then
            Decal.Color3 = u1376.color;
        end;

        if u1376.destroyOnDeath then
            table.insert(u1364, Decal);
        end;

        Decal.Parent = MapLocations;

        return Decal;
    end;

    local loadNextWhenCharStudsAway = u1376.loadNextWhenCharStudsAway;
    u1376.loadNextWhenCharStudsAway = nil;
    local location = u1376.location;

    for i, v in pairs(location) do
        u1376.location = v;
        local v1406 = u1.createWaypoint(u1376);

        if i < #location then
            while not u2.root or loadNextWhenCharStudsAway < (u2.root.Position - v).Magnitude do
                task.wait(0.3);

                if not v1406.Parent then
                    return;
                end;
            end;
        end;
    end;
end;

local u1407 = u10.raycastParamsNew();
u1407.IgnoreWater = true;
local u1408 = u10.raycastParamsNew();
u1408.IgnoreWater = true;
u1408.FilterDescendantsInstances = { workspace.Characters };
local u1409 = u10.raycastParamsNew();
u1.currentPetStatus = nil;
local u1410 = {};
local u1411 = u10.createPathfindingSystem();
local u1412 = {};

function u1.spawnedPet(p1413) -- Line: 8176
    -- upvalues: u10 (copy), u1412 (copy), GameRules (copy), u1 (copy), u2 (copy), u1411 (copy), PlayerEvent (copy)
    u10.clearConnectionsAndThreads(u1412);
    local u1414 = p1413 and u10.getInstanceReference(p1413, 20);

    if u1414 then
        local PrimaryPart = u1414.PrimaryPart;

        for _, child in pairs(u1414:GetChildren()) do
            if child:IsA("BasePart") then
                child.CollisionGroup = "Default";
            end;
        end;

        local AnimationController = u1414.AnimationController;
        AnimationController.Animator:Destroy();
        local Animator = Instance.new("Animator");
        Animator:SetAttribute("DEBUG", true);
        Animator:SetAttribute("AnimationFadeTime", GameRules.defaultCharacterAnimationFadeTime);
        Animator.Parent = AnimationController;
        u10.loadPetAnimations(AnimationController, Animator);
        u1.setPetStatus(u1414, "Follow", u2.root);
        table.insert(u1412, task.spawn(function() -- Line: 8195
            -- upvalues: u2 (ref), u1414 (copy), u10 (ref)
            while true do
                if u2.root then
                    local v1415 = (u2.root.Position - u1414.PrimaryPart.Position).Magnitude < 1000;

                    if v1415 == (u1414.Parent == game.ReplicatedStorage.Gameplay.Entities) then
                        DEBUG2 = tick();
                        u10.invokeServerTraffic("pet", "hide", not v1415);
                    end;
                end;

                task.wait(1);
            end;
        end));
        table.insert(u1412, u1414.Destroying:Connect(function() -- Line: 8207
            -- upvalues: u1411 (ref), u1 (ref)
            u1411.disable();
            u1.spawnedPet();
        end));
        table.insert(u1412, task.defer(function() -- Line: 8211
            -- upvalues: PrimaryPart (copy), u10 (ref), u1414 (copy), PlayerEvent (ref)
            while true do
                if PrimaryPart.AssemblyLinearVelocity.Y < -15 then
                    while PrimaryPart.AssemblyLinearVelocity.Y < -2 do
                        task.wait();
                    end;

                    u10.animationBuffer(u1414.AnimationController.Animator, "play", "JumpLand", 0.1, 0.5);
                    PlayerEvent:FireServer("pet", "anim", { "JumpLand", 1, 0.1, 0.5 });
                end;

                task.wait();
            end;
        end));
        local u1416 = 0;
        local u1417, u1418 = u10.animationBuffer(Animator, "get", "Walk", "Run");

        local function changeAnim(p1419) -- Line: 8226
            -- upvalues: u1416 (ref), u10 (ref), Animator (ref), PlayerEvent (ref)
            if u1416 ~= p1419 then
                u1416 = p1419;
                u10.animationBuffer(Animator, u1416 == 1 and "play" or "stop", "Walk");
                u10.animationBuffer(Animator, u1416 == 2 and "play" or "stop", "Run");
                PlayerEvent:FireServer("pet", "anim", { "Walk", u1416 == 1 and 1 or 2 });
                PlayerEvent:FireServer("pet", "anim", { "Run", u1416 == 2 and 1 or 2 });
            end;
        end;

        task.spawn(function() -- Line: 8235
            -- upvalues: u1414 (copy), PrimaryPart (copy), changeAnim (copy), u1 (ref), u1417 (copy), PlayerEvent (ref), u1418 (copy)
            local v1420 = -1;

            while u1414.Parent do
                local v1421 = -PrimaryPart.CFrame:vectorToObjectSpace(PrimaryPart.AssemblyLinearVelocity).Z;

                if v1421 <= 0.2 then
                    changeAnim(0);
                elseif v1421 < 12 then
                    v1420 = (v1420 + 1) % 3;
                    changeAnim(u1.currentPetStatus == "Sit" and 0 or 1);
                    local v1422 = 0.3 + v1421 / 12;
                    u1417:AdjustSpeed(v1422);

                    if v1420 == 0 then
                        PlayerEvent:FireServer("pet", "anim", { "Walk", 3, v1422 });
                    end;
                else
                    v1420 = (v1420 + 1) % 3;
                    changeAnim(u1.currentPetStatus == "Sit" and 0 or 2);
                    local v1423 = 1.05 + (v1421 - 12) / 35;
                    u1418:AdjustSpeed(v1423);

                    if v1420 == 0 then
                        PlayerEvent:FireServer("pet", "anim", { "Run", 3, v1423 });
                    end;
                end;

                task.wait(0.1);
            end;
        end);
    end;
end;

local function pitchRange(p1424) -- Line: 8261
    if p1424:FindFirstChild("PitchRange") then
        p1424.PlaybackSpeed = 1 + math.random(-p1424.PitchRange.Value, p1424.PitchRange.Value) / 10;

        return p1424.PlaybackSpeed;
    end;
end;

function u1.petMakeSound(u1425) -- Line: 8264
    -- upvalues: u10 (copy), PlayerEvent (copy), u1 (copy)
    if not (u10.rest("TakeDamageSound", nil, u1425) or u1425.PrimaryPart.Agro.IsPlaying) then
        if not pcall(function() -- Line: 8266
            -- upvalues: u10 (ref), u1425 (copy)
            u10.animationBuffer(u1425.AnimationController.Animator, "play", "OpenMouth");
        end) then
            PlayerEvent:FireServer("developmentLogs", "DEBUG9291", u1425.AnimationController.Animator:GetAttribute("DEBUG"), tick() - (DEBUG2 or 0), u1425:GetFullName());
        end;

        PlayerEvent:FireServer("pet", "anim", { "OpenMouth", 1 });

        if u1.currentPetStatus == "Attack" and math.random(2) == 1 then
            local Agro = u1425.PrimaryPart.Agro;
            local v1426;

            if Agro:FindFirstChild("PitchRange") then
                Agro.PlaybackSpeed = 1 + math.random(-Agro.PitchRange.Value, Agro.PitchRange.Value) / 10;
                v1426 = Agro.PlaybackSpeed;
            else
                v1426 = nil;
            end;

            u10.playSoundReplicate(u1425.PrimaryPart.Agro, {
                pitch = v1426
            });

            return;
        end;

        local Children = u1425.PrimaryPart.Ambient:GetChildren();
        local v1427 = 0;

        for _, v in pairs(Children) do
            v1427 = v1427 + v.Chance.Value;
        end;

        local math_random_ret = math.random(v1427);
        local v1428 = 0;

        for _, v in pairs(Children) do
            v1428 = v1428 + v.Chance.Value;

            if math_random_ret <= v1428 then
                local v1429;

                if v:FindFirstChild("PitchRange") then
                    v.PlaybackSpeed = 1 + math.random(-v.PitchRange.Value, v.PitchRange.Value) / 10;
                    v1429 = v.PlaybackSpeed;
                else
                    v1429 = nil;
                end;

                u10.playSoundReplicate(v, {
                    pitch = v1429
                });

                return;
            end;
        end;
    end;
end;

function u1.petServerStatus(p1430, p1431) -- Line: 8294
    -- upvalues: u10 (copy), LocalPlayer (copy), u1 (copy), u1410 (ref), u2 (copy)
    local InstanceAttribute = u10.getInstanceAttribute(LocalPlayer, "Pet");

    if InstanceAttribute then
        if p1430 == "attack" then
            if p1431.target and (u1.currentPetStatus ~= "Sit" and (u1.currentPetStatus ~= "attack" or u1410[1] ~= p1431.target)) and (InstanceAttribute.Health.Value > 0 and u2.root) then
                local v1432 = not p1431.target:IsA("Player") and p1431.target or p1431.target.Character;

                if v1432 and (v1432.Parent and (v1432.PrimaryPart.Position - u2.root.Position).Magnitude < 300) then
                    u1.setPetStatus(InstanceAttribute, "Attack", p1431.target);
                end;
            end;
        elseif p1430 == "play" then
            u10.animationBuffer(InstanceAttribute.AnimationController.Animator, "play", p1431.animation);
        end;
    end;
end;

u1.petId = 1;
local u1433 = {};

function u1.setPetStatus(u1434, p1435, ...) -- Line: 8312
    -- upvalues: u1 (copy), u10 (copy), u1433 (copy), u1410 (ref), u1409 (copy), u1411 (copy), PlayerEvent (copy), u1408 (copy), PlayerFunc (copy), LocalPlayer (copy), u2 (copy), u1407 (copy)
    u1.enterPropertyWithPetFunc = nil;
    u1.currentPetStatus = p1435;
    u1.petId = (u1.petId + 1) % 100;
    u10.clearConnectionsAndThreads(u1433);
    u1410 = { ... };
    local Animator = u1434.AnimationController.Animator;
    local petId = u1.petId;
    local PrimaryPart = u1434.PrimaryPart;
    local AttackSpot = u1434.AttackSpot;
    local Position2 = PrimaryPart.Position;
    local u1436 = false;

    local function isInWater(p1437) -- Line: 8326
        -- upvalues: u1436 (ref), PrimaryPart (copy), u1409 (ref)
        local function set(p1438) -- Line: 8327
            -- upvalues: u1436 (ref), PrimaryPart (ref)
            u1436 = p1438;
            PrimaryPart.CustomPhysicalProperties = p1438 and PhysicalProperties.new(6, 0.7, 0.5) or nil;
        end;

        if p1437 == nil or u1436 == p1437 then
            local v1439 = workspace:Raycast(PrimaryPart.Position + Vector3.new(0, 3, 0), Vector3.new(0, -6, 0), u1409);

            if u1436 ~= (v1439 and (v1439.Instance == workspace.Terrain and v1439.Material == Enum.Material.Water) and true or false) then
                local v1440 = not u1436;
                u1436 = v1440;
                PrimaryPart.CustomPhysicalProperties = v1440 and PhysicalProperties.new(6, 0.7, 0.5) or nil;
            end;

            return;
        end;

        u1436 = p1437;
        PrimaryPart.CustomPhysicalProperties = p1437 and PhysicalProperties.new(6, 0.7, 0.5) or nil;
    end;

    local u1441 = nil;
    u1411.antiStuck = true;
    local u1442 = 1;

    local function jumpFunc(p1443) -- Line: 8342
        -- upvalues: u1434 (copy), u1442 (ref), isInWater (copy), u10 (ref), PlayerEvent (ref), PrimaryPart (copy)
        if not u1434.Parent then
            return true;
        end;

        u1442 = (u1442 + 1) % 100;
        isInWater(false);
        u10.animationBuffer(u1434.AnimationController.Animator, "play", "JumpStart", 0.1, 0.5);
        PlayerEvent:FireServer("pet", "anim", { "JumpStart", 1, 0.1, 0.5 });
        task.wait(0.15);
        PrimaryPart:ApplyImpulse(p1443 or Vector3.new(0, 30, 0));
    end;

    local function moveToFunc(p1444, p1445, p1446) -- Line: 8354
        -- upvalues: u1434 (copy), u1441 (ref), PrimaryPart (copy), Position2 (ref), u10 (ref), petId (copy), u1 (ref)
        if not u1434.Parent then
            return true;
        end;

        u1441 = nil;

        while (p1446 or 5) < (PrimaryPart.Position - p1444).Magnitude do
            PrimaryPart.BodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * (7.5 + math.clamp((PrimaryPart.Position - Position2).Magnitude, 15, 55) / 4 * (p1445 or 1));
            local v1447 = u10.smartUnit(p1444 - PrimaryPart.Position);
            local math_atan2_ret = math.atan2(-v1447.X, -v1447.Z);
            PrimaryPart.BodyGyro.CFrame = CFrame.Angles(0, math_atan2_ret, 0);
            task.wait();

            if not u1434.Parent then
                return true;
            end;

            if petId ~= u1.petId then
                PrimaryPart.BodyVelocity.Velocity = Vector3.new();

                return true;
            end;
        end;
    end;

    u1409.FilterDescendantsInstances = { u1434 };
    task.spawn(function() -- Line: 8374
        -- upvalues: u1 (ref), u1410 (ref), u1434 (copy), petId (copy), Position2 (ref), u10 (ref), u1408 (ref), u1411 (ref), PrimaryPart (copy), jumpFunc (copy), moveToFunc (copy), u1433 (ref), AttackSpot (copy), PlayerFunc (ref), LocalPlayer (ref), u2 (ref)
        if u1.currentPetStatus == "Follow" then
            local v1448 = u1410[1];

            if not v1448 then
                return u1.setPetStatus(u1434);
            end;

            while u1434.Parent and petId == u1.petId do
                if not v1448.Parent then
                    return u1.setPetStatus(u1434);
                end;

                local v1449 = v1448.Position + v1448.AssemblyLinearVelocity * 3;

                if (v1449 - Position2).Magnitude > 30 then
                    local v1450 = u10.raycastVisible(v1448.Position, v1448.AssemblyLinearVelocity * 3, u1408);

                    if v1450 then
                        v1449 = v1450.Position or v1449;
                    end;

                    Position2 = v1449 or Vector3.new();
                    u1411.followPath({
                        isPathfinding = true,
                        startPos = PrimaryPart.Position,
                        destination = Position2,
                        jumpFunc = jumpFunc,

                        moveToFunc = function(p1451) -- Line: 8390, Name: moveToFunc
                            -- upvalues: moveToFunc (ref)
                            return moveToFunc(p1451);
                        end,

                        finishedSuccessFunc = function() -- Line: 8391, Name: finishedSuccessFunc
                            -- upvalues: u1434 (ref), PrimaryPart (ref)
                            if u1434.Parent then
                                PrimaryPart.BodyVelocity.Velocity = Vector3.new();
                            end;
                        end
                    });
                end;

                task.wait(1);
            end;
        elseif u1.currentPetStatus == "Attack" then
            local u1452 = not u1410[1]:IsA("Player") and u1410[1] or u1410[1].Character;
            local v1453;

            if u1452 then
                v1453 = u1452.PrimaryPart;
            else
                v1453 = u1452;
            end;

            if not (v1453 and v1453.Parent) then
                return u1.setPetStatus(u1434);
            end;

            table.insert(u1433, AttackSpot.Touched:Connect(function(p1454) -- Line: 8402
                -- upvalues: u1452 (copy), u10 (ref), u1434 (ref), PlayerFunc (ref), u1410 (ref)
                if p1454:IsDescendantOf(u1452) and not u10.rest("PetGiveDamage", nil, u1434) then
                    PlayerFunc:InvokeServer("pet", "attack", {
                        target = u1410[1]
                    });
                end;
            end));

            while u1434.Parent and petId == u1.petId do
                if not v1453.Parent then
                    return u1.setPetStatus(u1434);
                end;

                local v1455 = u10.raycastVisible(v1453.Position, v1453.AssemblyLinearVelocity * 2, u1408);
                Position2 = v1455 and v1455.Position or v1453.Position + v1453.AssemblyLinearVelocity * 2 or Vector3.new();
                u1411.followPath({
                    isPathfinding = true,
                    startPos = PrimaryPart.Position,
                    destination = Position2,
                    jumpFunc = jumpFunc,

                    moveToFunc = function(p1456) -- Line: 8418, Name: moveToFunc
                        -- upvalues: moveToFunc (ref)
                        return moveToFunc(p1456, 2);
                    end,

                    finishedSuccessFunc = function() -- Line: 8419, Name: finishedSuccessFunc
                        -- upvalues: moveToFunc (ref), Position2 (ref), PrimaryPart (ref)
                        if moveToFunc(Position2, nil, 3) then
                            return;
                        end;

                        PrimaryPart.BodyVelocity.Velocity = Vector3.new();
                    end
                });

                if u1434.Health.Value <= 0 or (u1452.Humanoid.Health <= 0 or (u10.canCombat(LocalPlayer, u1410[1]) ~= true or u2.root and (v1453.Position - u2.root.Position).Magnitude > 300)) then
                    return u1.setPetStatus(u1434, "Follow", u2.root);
                end;

                task.wait((v1453.Position - PrimaryPart.Position).Magnitude > 20 and 1 or 0.5);
            end;
        elseif u1.currentPetStatus == "Move" then
            Position2 = u1410[1] or Vector3.new();
            u1411.followPath({
                isPathfinding = true,
                startPos = PrimaryPart.Position,
                destination = Position2,
                jumpFunc = jumpFunc,

                moveToFunc = function(p1457) -- Line: 8434, Name: moveToFunc
                    -- upvalues: moveToFunc (ref)
                    return moveToFunc(p1457);
                end,

                finishedSuccessFunc = function() -- Line: 8435, Name: finishedSuccessFunc
                    -- upvalues: u1434 (ref), PrimaryPart (ref)
                    if u1434.Parent then
                        PrimaryPart.BodyVelocity.Velocity = Vector3.new();
                    end;
                end,

                finishedFunc = function() -- Line: 8438, Name: finishedFunc
                    -- upvalues: u1434 (ref), petId (ref), u1 (ref)
                    if u1434.Parent and petId == u1.petId then
                        u1.setPetStatus(u1434);
                    end;
                end
            });
        end;
    end);
    task.delay(15 + math.random(25), function() -- Line: 8445
        -- upvalues: u1434 (copy), petId (copy), u1 (ref)
        while u1434.Parent and petId == u1.petId do
            u1.petMakeSound(u1434);
            task.wait(15 + math.random(25));
        end;
    end);
    u10.animationBuffer(Animator, u1.currentPetStatus == "Sit" and "play" or "stop", "Sit");
    PlayerEvent:FireServer("pet", "anim", { "Sit", u1.currentPetStatus == "Sit" and 1 or 2 });

    if u1.currentPetStatus and (u1.currentPetStatus ~= "Sit" and u1.currentPetStatus ~= "Move") then
        function u1.enterPropertyWithPetFunc() -- Line: 8454
            -- upvalues: u2 (ref), u1434 (copy)
            if u2.root then
                u1434:PivotTo(u2.root.CFrame + u2.root.CFrame.RightVector * 2);
            end;
        end;
    end;

    if u1.currentPetStatus == "Sit" then
        u10.animationBuffer(Animator, "get", "Sit"):AdjustSpeed(0.3);
        PlayerEvent:FireServer("pet", "anim", { "Sit", 3, 0.3 });
    else
        u1407.FilterDescendantsInstances = { u1434 };
        task.spawn(function() -- Line: 8463
            -- upvalues: u1434 (copy), petId (copy), u1 (ref), PrimaryPart (copy), u1411 (ref), u1441 (ref), jumpFunc (copy), isInWater (copy)
            task.wait(1);

            while u1434.Parent and petId == u1.petId do
                if PrimaryPart.BodyVelocity.Velocity == Vector3.new() or not u1411.antiStuck then
                    isInWater();
                else
                    if PrimaryPart.AssemblyLinearVelocity.Magnitude < 4 and (u1441 and (u1441 - PrimaryPart.Position).Magnitude < 2) then
                        jumpFunc(Vector3.new(0, 60, 0));
                    else
                        isInWater();
                    end;

                    u1441 = PrimaryPart.Position;
                end;

                task.wait(1);
            end;
        end);
        task.spawn(function() -- Line: 8475
            -- upvalues: u1434 (copy), petId (copy), u1 (ref), u2 (ref), PrimaryPart (copy), Position2 (ref), u1411 (ref), jumpFunc (copy), moveToFunc (copy), u10 (ref), u1407 (ref)
            task.wait(5);

            while true do
                if not u1434.Parent or petId ~= u1.petId then
                    return;
                end;

                if u2.root and ((u2.root.Position - PrimaryPart.Position).Magnitude > 200 and (u2.hum:GetState() ~= Enum.HumanoidStateType.Freefall and not (u1.isSeated() and (u1.isSeated().Parent and u1.isSeated().Parent.Name == "Parachute")))) then
                    u1434:PivotTo(u2.root.CFrame);
                    u1434.PrimaryPart.AssemblyLinearVelocity = Vector3.new();
                    u1434.PrimaryPart.AssemblyAngularVelocity = Vector3.new();

                    if u2.root then
                        return u1.setPetStatus(u1434, "Follow", u2.root);
                    end;
                elseif PrimaryPart.BodyVelocity.Velocity == Vector3.new() then
                    if (PrimaryPart.Position - Position2).Magnitude > 30 then
                        u1411.followPath({
                            isPathfinding = true,
                            startPos = PrimaryPart.Position,
                            destination = Position2,
                            jumpFunc = jumpFunc,

                            moveToFunc = function(p1458) -- Line: 8490, Name: moveToFunc
                                -- upvalues: moveToFunc (ref)
                                moveToFunc(p1458);
                            end,

                            finishedSuccessFunc = function() -- Line: 8491, Name: finishedSuccessFunc
                                -- upvalues: u1434 (ref), PrimaryPart (ref)
                                if u1434.Parent then
                                    PrimaryPart.BodyVelocity.Velocity = Vector3.new();
                                end;
                            end
                        });
                    elseif math.random(2) == 1 then
                        local v1459 = nil;

                        for i = 1, 4 do
                            local raycastVisible = u10.raycastVisible;
                            local Position3 = PrimaryPart.Position;
                            local v1460 = math.random(-4, 4) * 3;
                            local v1461 = math.random(-4, 4) * 3;
                            v1459 = raycastVisible(Position3 + Vector3.new(v1460, 4, v1461), Vector3.new(0, -8, 0), u1407);

                            if v1459 then
                                break;
                            end;

                            local _ = i;
                        end;

                        if v1459 then
                            Position2 = v1459.Position or Vector3.new();
                            u1411.followPath({
                                isPathfinding = true,
                                startPos = PrimaryPart.Position,
                                destination = Position2,
                                jumpFunc = jumpFunc,

                                moveToFunc = function(p1462) -- Line: 8508, Name: moveToFunc
                                    -- upvalues: moveToFunc (ref)
                                    moveToFunc(p1462);
                                end,

                                finishedSuccessFunc = function() -- Line: 8509, Name: finishedSuccessFunc
                                    -- upvalues: u1434 (ref), PrimaryPart (ref)
                                    if u1434.Parent then
                                        PrimaryPart.BodyVelocity.Velocity = Vector3.new();
                                    end;
                                end
                            });
                        end;
                    end;
                end;

                task.wait(5);
            end;
        end);
    end;
end;

local u1463 = {};
local u1464 = nil;

function u1.startGuide(u1465, u1466) -- Line: 8525
    -- upvalues: GameRules (copy), u7 (copy), u2 (copy), u10 (copy), u1 (copy), u1463 (copy), u1464 (ref), PlayerEvent (copy), ContentProvider (copy)
    if u1466 and GameRules.disableGuideAndQuests then
        return;
    end;

    local function u1471() -- Line: 8528
        -- upvalues: u7 (ref), u1465 (copy), u2 (ref), u10 (ref), u1 (ref), u1463 (ref), u1464 (ref), GameRules (ref), PlayerEvent (ref), u1466 (copy), ContentProvider (ref)
        u7.disabled(u1465, "guide");

        if u2.loaded then
            u2.lockHumanoidState("guide", u1465 and -1);
        end;

        u10.guiTransition(u1.guideGui, "Position", UDim2.fromScale(0, 0.1), u1465);
        u10.clearConnectionsAndThreads(u1463);
        u1464 = u1465;

        if u1465 then
            for _, child in pairs(u1.guideGui.VisualCounter:GetChildren()) do
                if child:IsA("ImageLabel") and child.Visible then
                    child:Destroy();
                end;
            end;

            for i = 1, #GameRules.guideChapters[u1465] do
                local v1467 = u10.clone(u1.guideGui.VisualCounter.Preview);
                v1467.Name = i;
                v1467.Visible = true;
                v1467.Parent = u1.guideGui.VisualCounter;
                local _ = i;
            end;

            local u1468 = 1;

            local function displayStep(p1469) -- Line: 8546
                -- upvalues: u1468 (ref), u10 (ref), u1 (ref), GameRules (ref), u1465 (ref)
                if p1469 then
                    u1468 = u1468 + p1469;
                end;

                u10.fitText(u1.guideGui.TextLabel, GameRules.guideChapters[u1465][u1468][1], 8);
                u1.guideGui.ImageLabel.Image = GameRules.guideChapters[u1465][u1468][2];
                u1.guideGui.Buttons.Previous.Visible = u1468 > 1;
                local v1470 = u1468 == #GameRules.guideChapters[u1465];
                u1.guideGui.Buttons.Next.Finish.Visible = v1470;
                u1.guideGui.Buttons.Next.Arrow.Visible = not v1470;

                for _, child in pairs(u1.guideGui.VisualCounter:GetChildren()) do
                    if child:IsA("ImageLabel") and child.Visible then
                        child.ImageTransparency = u1468 == tonumber(child.Name) and 0 or 0.6;
                    end;
                end;
            end;

            displayStep();
            u10.buildSignalData(u1463, u10.buttonHoverSignalData(u1.guideGui.Buttons.Previous));
            u10.buildSignalData(u1463, u1.mouseButton(u1.guideGui.Buttons.Previous, function() -- Line: 8560
                -- upvalues: displayStep (copy)
                displayStep(-1);
            end));
            u10.buildSignalData(u1463, u10.buttonHoverSignalData(u1.guideGui.Buttons.Next));
            u10.buildSignalData(u1463, u1.mouseButton(u1.guideGui.Buttons.Next, function() -- Line: 8564
                -- upvalues: u1468 (ref), GameRules (ref), u1465 (ref), PlayerEvent (ref), u1466 (ref), u1 (ref), displayStep (copy)
                if u1468 ~= #GameRules.guideChapters[u1465] then
                    displayStep(1);

                    return;
                end;

                PlayerEvent:FireServer("guideCompleted", u1465, u1466);
                u1.startGuide();
            end));
            task.spawn(function() -- Line: 8570
                -- upvalues: ContentProvider (ref), u1 (ref)
                ContentProvider:PreloadAsync(u1.guideGui:GetChildren());
            end);
        end;
    end;

    if not (u1465 and u1.guideGui.Visible) then
        task.spawn(u1471);

        return;
    end;

    if u1464 == u1465 then
        return;
    end;

    task.defer(function() -- Line: 8576
        -- upvalues: u1 (ref), u1464 (ref), u1465 (copy), u1471 (copy)
        while u1.guideGui.Visible do
            task.wait(2);

            if u1464 == u1465 then
                return;
            end;
        end;

        u1471();
    end);
end;

local u1472 = {};
local u1480 = {
    StartQuest = { function(p1473) -- Line: 8589
            -- upvalues: guiInteractionIndicator (copy), u1472 (copy), u1 (copy)
            guiInteractionIndicator(u1472.StartQuest, function() -- Line: 8590
                -- upvalues: u1 (ref)
                local v1474 = not (u1.openedGui or u1.guideGui.Visible) and u1.notificationsGuiLowDisplayOrder:FindFirstChild("QuestBoard");

                return v1474;
            end);

            while not u1.currentQuest do
                task.wait();
            end;
        end },
    Inventory = { function(p1475) -- Line: 8597
            -- upvalues: guiInteractionIndicator (copy), u1472 (copy), u1 (copy), u2 (copy), FrontGui (copy)
            guiInteractionIndicator(u1472.Inventory, function() -- Line: 8598
                -- upvalues: u1 (ref), u2 (ref), FrontGui (ref)
                if not (u1.openedGui and u1.openedGui ~= "SelectionWheel" or u1.guideGui.Visible) then
                    if u2.screenGui and u1.openedGui == "SelectionWheel" then
                        for _, child in pairs(u2.screenGui.Center.Middle.SelectionWheel.Slots:GetChildren()) do
                            if child.Visible and (child:IsA("ImageLabel") and child.Image == "rbxassetid://6719884688") then
                                return child;
                            end;
                        end;
                    end;

                    return FrontGui.TopBarButtons.SelectionWheel;
                end;
            end);

            while u1.openedGui ~= "Inventory" do
                task.wait();
            end;
        end },
    EmergencyLights = { function(p1476) -- Line: 8612
            -- upvalues: guiInteractionIndicator (copy), u1472 (copy), u2 (copy), u1 (copy), u10 (copy), LocalPlayer (copy)
            guiInteractionIndicator(u1472.EmergencyLights, function() -- Line: 8613
                -- upvalues: u2 (ref), u1 (ref)
                if u2.screenGui then
                    local function isActive() -- Line: 8615
                        -- upvalues: u2 (ref)
                        for _, child in pairs(u2.screenGui.Right.Bottom.ELS:GetChildren()) do
                            if child.Visible and child:FindFirstChild("Lights") then
                                return child;
                            end;
                        end;
                    end;

                    if u1.platform == "Mobile" then
                        if u2.screenGui.Right.Bottom.ELS.Visible then
                            local v1477 = isActive();

                            if v1477 then
                                v1477 = v1477.Lights;
                            end;

                            return v1477;
                        end;

                        if u2.screenGui.Right.Bottom.Vehicle.Visible and u2.ELSMobileVehicleButton then
                            return u2.ELSMobileVehicleButton;
                        end;
                    elseif u2.screenGui.Right.Bottom.ELS.Visible then
                        local v1478 = isActive();

                        if v1478 then
                            v1478 = v1478.Lights;
                        end;

                        return v1478;
                    end;
                end;
            end);

            while true do
                local v1479 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);

                if v1479 and v1479.Config.ELS.Value ~= 0 then
                    break;
                end;

                task.wait();
            end;
        end }
};
u1.controlsGuide = false;

function u1.startControlsGuide(u1481, p1482) -- Line: 8643
    -- upvalues: GameRules (copy), u1472 (copy), u10 (copy), u1 (copy), LocalPlayer (copy), u1480 (copy), PlayerEvent (copy)
    if GameRules.disableGuideAndQuests then
        return;
    end;

    if u1472[u1481] then
        u10.clearConnectionsAndThreads(u1472[u1481]);
        u1472[u1481] = nil;

        if u1.controlsGuide == u1481 then
            u1.controlsGuide = false;
        end;
    end;

    if p1482 and not u1.readPlayerData("Guide", "Controls_" .. u1481) then
        u1472[u1481] = {};
        table.insert(u1472[u1481], task.delay(p1482, function() -- Line: 8656
            -- upvalues: u1 (ref), u1481 (copy), u10 (ref), LocalPlayer (ref), u1480 (ref), PlayerEvent (ref)
            u1.controlsGuide = u1481;
            local v1483 = 0;

            while true do
                while u1.openedGui or not (u10.isCharLoaded(LocalPlayer, {
                    isAlive = true
                }) and (LocalPlayer.Character:IsDescendantOf(workspace) and not u1.loadingActivated)) do
                    task.wait(5);
                end;

                v1483 = v1483 + 1;
                u1480[u1481][v1483]();

                if not u1480[u1481][v1483 + 1] then
                    PlayerEvent:FireServer("controlsGuide", u1481);
                    u1.startControlsGuide(u1481);

                    return;
                end;

                task.wait(3);
            end;
        end));
    end;
end;

local QuestBoard = FrontGui.Center.Middle.QuestBoard;
local u1484 = {};

function u1.questBoard(p1485) -- Line: 8868
    -- upvalues: u1 (copy), u10 (copy), u1484 (copy), QuestBoard (copy)
    if u1.openedGui and u1.openedGui ~= "quest" then
        return;
    end;

    u1.openGui(p1485 and "quest", true);
    u10.clearConnectionsAndThreads(u1484);

    if p1485 then
        u1.listenToInmobileActivityInterrupted(u10.buildSignalData, u1484, function() -- Line: 8874
            -- upvalues: u1 (ref)
            u1.questBoard();
        end);

        local function getCurrentQuest() -- Line: 8877
            -- upvalues: u1 (ref)
            if u1.currentQuest and (not game.ReplicatedStorage.Gameplay.Quests.Content[u1.currentQuest]:FindFirstChild("IsTutorial") and u1.questStep ~= true) then
                return u1.currentQuest, u1.currentQuestSubName;
            end;
        end;

        local u1486, u1487;

        if u1.currentQuest and (not game.ReplicatedStorage.Gameplay.Quests.Content[u1.currentQuest]:FindFirstChild("IsTutorial") and u1.questStep ~= true) then
            u1486 = u1.currentQuest;
            u1487 = u1.currentQuestSubName;
        else
            u1486 = nil;
            u1487 = nil;
        end;

        local v1488 = u1.readPlayerData("Quests");
        local u1489 = #QuestBoard.Quests:GetChildren();
        local u1490 = u1489;
        local u1491 = nil;
        local u1492 = nil;

        for _, child in pairs(game.ReplicatedStorage.Gameplay.Quests.Content:GetChildren()) do
            if not (v1488[child.Name] or (child.Tier.Value >= u1489 or child.Tier.Value <= 0)) then
                u1489 = child.Tier.Value;
            end;
        end;

        local function updateGui() -- Line: 8891
            -- upvalues: QuestBoard (ref), u1486 (ref), u1490 (ref), u1487 (ref), u1491 (ref), u1492 (ref)
            for _, child in pairs(QuestBoard.Quests:GetChildren()) do
                for _, child2 in pairs(child:GetChildren()) do
                    if child2:IsA("ImageButton") then
                        child2.Selection.Visible = false;

                        if child2:FindFirstChild("Buttons") then
                            child2.Buttons.Visible = false;

                            for _, child3 in pairs(child2.Buttons:GetChildren()) do
                                if child3:IsA("ImageButton") then
                                    child3.Selection.Visible = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            if u1486 then
                local v1493 = QuestBoard.Quests["Tier" .. u1490]:FindFirstChild(u1486);

                if v1493 then
                    v1493.Selection.Visible = true;
                    v1493.Selection.ImageColor3 = Color3.fromRGB(137, 255, 135);
                end;

                QuestBoard.Buttons.Cancel.Visible = true;
                QuestBoard.Buttons.Start.Visible = false;

                for _, child in pairs(QuestBoard.QuestDescription:GetChildren()) do
                    child.Visible = child.Name == u1486 .. (u1487 and " - " .. u1487 or "");
                end;

                return;
            end;

            local v1494 = u1491 and QuestBoard.Quests["Tier" .. u1490]:FindFirstChild(u1491);

            if v1494 then
                v1494.Selection.Visible = true;
                v1494.Selection.ImageColor3 = Color3.fromRGB(255, 255, 255);
                local Buttons = v1494:FindFirstChild("Buttons");

                if Buttons then
                    Buttons.Visible = true;
                end;

                if u1492 or not Buttons then
                    if u1492 and Buttons then
                        Buttons[u1492].Selection.Visible = true;
                    end;

                    QuestBoard.Buttons.Cancel.Visible = false;
                    QuestBoard.Buttons.Start.Visible = true;

                    for _, child in pairs(QuestBoard.QuestDescription:GetChildren()) do
                        child.Visible = child.Name == u1491 .. (u1492 and " - " .. u1492 or "");
                    end;

                    return;
                end;
            end;

            for _, child in pairs(QuestBoard.QuestDescription:GetChildren()) do
                child.Visible = false;
            end;

            QuestBoard.Buttons.Cancel.Visible = false;
            QuestBoard.Buttons.Start.Visible = false;
        end;

        local function updateTierGui(p1495) -- Line: 8941
            -- upvalues: u1490 (ref), u1489 (ref), QuestBoard (ref), updateGui (copy)
            u1490 = math.clamp(u1490 + (p1495 or 0), 1, u1489);
            local v1496 = QuestBoard.Quests["Tier" .. u1490];

            for _, child in pairs(QuestBoard.Quests:GetChildren()) do
                child.Visible = v1496 == child;
            end;

            local v1497 = v1496.UIListLayout.AbsoluteContentSize.X / QuestBoard.AbsoluteSize.X;
            QuestBoard.Back.Position = UDim2.fromScale(-v1497 / 2 - 0.8, QuestBoard.Back.Position.Y.Scale);
            QuestBoard.Next.Position = UDim2.fromScale(v1497 / 2 + 0.8, QuestBoard.Back.Position.Y.Scale);
            QuestBoard.Back.Visible = u1490 ~= 1;
            QuestBoard.Next.Visible = u1490 < u1489;
            updateGui();
        end;

        updateTierGui();
        table.insert(u1484, task.defer(function() -- Line: 8953
            -- upvalues: u1 (ref), u1486 (ref), u1487 (ref), updateGui (copy)
            while true do
                local v1498, v1499;

                if u1.currentQuest and (not game.ReplicatedStorage.Gameplay.Quests.Content[u1.currentQuest]:FindFirstChild("IsTutorial") and u1.questStep ~= true) then
                    v1498 = u1.currentQuest;
                    v1499 = u1.currentQuestSubName;
                else
                    v1498 = nil;
                    v1499 = nil;
                end;

                if u1486 ~= v1498 or u1487 ~= v1499 then
                    u1486 = v1498;
                    u1487 = v1499;
                    updateGui();
                end;

                task.wait(0.03);
            end;
        end));

        for _, child in pairs(QuestBoard.Quests:GetChildren()) do
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("ImageButton") then
                    child2.Reward.Text = "＄" .. game.ReplicatedStorage.Gameplay.Quests.Content[child2.Name].Reward.Value;
                    child2.Finished.Visible = false;
                    child2.Reward.TextColor3 = Color3.fromRGB(137, 255, 135);

                    if v1488[child2.Name] then
                        child2.Finished.Visible = true;
                        child2.Reward.TextColor3 = Color3.fromRGB(145, 145, 145);
                    end;

                    u10.buildSignalData(u1484, u1.mouseButton(child2, function() -- Line: 8973
                        -- upvalues: u1486 (ref), u1491 (ref), child2 (copy), u1492 (ref), updateGui (copy)
                        if not u1486 then
                            u1491 = child2.Name;
                            u1492 = nil;
                            updateGui();
                        end;
                    end));

                    if child2:FindFirstChild("Buttons") then
                        for _, child3 in pairs(child2.Buttons:GetChildren()) do
                            if child3:IsA("ImageButton") then
                                u10.buildSignalData(u1484, u1.mouseButton(child3, function() -- Line: 8983
                                    -- upvalues: u1486 (ref), u1492 (ref), child3 (copy), updateGui (copy)
                                    if not u1486 then
                                        u1492 = child3.Name;
                                        updateGui();
                                    end;
                                end));
                            end;
                        end;
                    end;
                end;
            end;
        end;

        u10.buildSignalData(u1484, u1.mouseButton(QuestBoard.Back, function() -- Line: 8995
            -- upvalues: updateTierGui (copy)
            updateTierGui(-1);
        end));
        u10.buildSignalData(u1484, u1.mouseButton(QuestBoard.Next, function() -- Line: 8998
            -- upvalues: updateTierGui (copy)
            updateTierGui(1);
        end));
        u10.buildSignalData(u1484, u1.mouseButton(QuestBoard.Buttons.Close, function() -- Line: 9001
            -- upvalues: u1 (ref)
            u1.questBoard();
        end));
        u10.buildSignalData(u1484, u1.mouseButton(QuestBoard.Buttons.Cancel, function() -- Line: 9004
            -- upvalues: u1 (ref)
            u1.startQuest();
        end));
        u10.buildSignalData(u1484, u1.mouseButton(QuestBoard.Buttons.Start, function() -- Line: 9009
            -- upvalues: u1491 (ref), u1 (ref), u1492 (ref)
            if u1491 then
                u1.startQuest(u1491, u1492);
                u1.questBoard();
            end;
        end));
        u10.buildSignalData(u1484, u10.buttonHoverSignalData(QuestBoard.Buttons.Close));
        u10.buildSignalData(u1484, u10.buttonHoverSignalData(QuestBoard.Buttons.Cancel));
        u10.buildSignalData(u1484, u10.buttonHoverSignalData(QuestBoard.Buttons.Start));
        u10.guiTransition(QuestBoard, "Position", UDim2.fromScale(0, 0.1), true);
        table.insert(u1484, function() -- Line: 9019
            -- upvalues: u10 (ref), QuestBoard (ref)
            u10.guiTransition(QuestBoard, "Position", UDim2.fromScale(0, 0.1), false);
        end);
    end;
end;

local u1500 = {};
local u1501 = {};
u1.currentQuest = nil;
u1.currentQuestSubName = nil;
u1.questSteps = nil;
u1.questStep = nil;

local function questWaypoint(p1502, u1503, u1504, u1505) -- Line: 9032
    -- upvalues: u1500 (copy), u1 (copy), u10 (copy)
    for _, v in pairs(u1500) do
        v:Disconnect();
    end;

    table.clear(u1500);
    u1.createWaypoint({
        name = "Quest"
    });

    if p1502 then
        if u10.typeOf(p1502) == "string" then
            local u1506 = game.ReplicatedStorage.Gameplay.Quests.Waypoints:WaitForChild(p1502);

            local function create() -- Line: 9039
                -- upvalues: u1500 (ref), u1506 (copy), create (copy), u1 (ref), u1504 (copy), u1505 (copy), u1503 (copy)
                for _, v in pairs(u1500) do
                    v:Disconnect();
                end;

                table.clear(u1500);
                local v1507 = {};

                for _, child in pairs(u1506:GetChildren()) do
                    if child:IsA("Part") then
                        table.insert(v1507, child.Position);
                    elseif child.Value then
                        table.insert(v1507, child.Value.Position);
                    else
                        table.insert(u1500, child.Changed:Connect(create));
                    end;
                end;

                u1.createWaypoint({
                    name = "Quest",
                    image = "rbxassetid://7861318352",
                    create = true,
                    location = v1507,
                    color = Color3.fromRGB(45, 131, 223),
                    distance = u1504,
                    pulsating = u1505,
                    navigation = u1503
                });
            end;

            create();

            return;
        end;

        if u10.typeOf(p1502) == "table" and u10.isTableEmpty(p1502) then
            return;
        end;

        u1.createWaypoint({
            name = "Quest",
            image = "rbxassetid://7861318352",
            create = true,
            location = p1502,
            color = Color3.fromRGB(45, 131, 223),
            distance = u1504,
            pulsating = u1505,
            navigation = u1503
        });
    end;
end;

local function getAvailableCrimes(p1508) -- Line: 9061
    local v1509 = {};

    for _, child in pairs(game.ReplicatedStorage.Gameplay.Missions.Active:GetChildren()) do
        if child.Name == p1508 and not child.Value then
            table.insert(v1509, child);
        end;
    end;

    return v1509;
end;

local function switchToCivilianStep(p1510) -- Line: 9068
    -- upvalues: LocalPlayer (copy), questWaypoint (copy), guiInteractionIndicator (copy), u1501 (copy), u10 (copy), u1 (copy), MenuGui (copy), FrontGui (copy)
    if LocalPlayer.Team.Name ~= "Civilian" then
        p1510(1, "Switch to a Civilian team");
        questWaypoint("CivilianSpawns", true);
        local v1511 = guiInteractionIndicator(u1501, function() -- Line: 9072
            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), MenuGui (ref), FrontGui (ref)
            if u10.isPlayerNearbyToLeaveJobTeam(LocalPlayer) then
                if not u1.isMenuActive then
                    return FrontGui.TopBarButtons.Menu;
                end;

                if u1.isMenuActive ~= "TeamSelection" then
                    return MenuGui.MenuGui.Center.TopMiddle.List.TeamSelection;
                end;

                if MenuGui.MenuGui.Center.Middle.TeamSelection.List:FindFirstChild(LocalPlayer.Team.Name) then
                    if MenuGui.MenuGui.Center.Middle.TeamSelection.List[LocalPlayer.Team.Name].Button.Visible then
                        return MenuGui.MenuGui.Center.Middle.TeamSelection.List[LocalPlayer.Team.Name].Button.Button;
                    end;

                    return MenuGui.MenuGui.Center.Middle.TeamSelection.List[LocalPlayer.Team.Name];
                end;
            end;
        end);

        while LocalPlayer.Team.Name ~= "Civilian" do
            task.wait(0.5);
        end;

        v1511();
    end;
end;

local u1512 = nil;

local function mobileGuiInteractionIndicatorPreset(p1513) -- Line: 9094
    -- upvalues: u1 (copy), u5 (copy), FrontGui (copy), u1512 (ref)
    if u1.platform == "Mobile" then
        if p1513 == "phone" and not u5.pulledOut then
            return FrontGui.TopBarButtons.Mobile.Phone;
        end;

        if p1513 == "phoneOneTime" and not u1512 then
            if not u5.pulledOut then
                return FrontGui.TopBarButtons.Mobile.Phone;
            end;

            u1512 = true;
        end;
    end;
end;

function u1.startQuest(u1514, u1515) -- Line: 9107
    -- upvalues: u1 (copy), u10 (copy), u1501 (copy), questWaypoint (copy), LocalPlayer (copy), getAvailableCrimes (copy), u1512 (ref), PlayerEvent (copy), guiInteractionIndicator (copy), u2 (copy), u5 (copy), FrontGui (copy), switchToCivilianStep (copy), MapLocations (copy), u8 (copy), HttpService (copy)
    if u1.isNotification("Quest") then
        u1.removePin("Quest");
    end;

    u10.clearConnectionsAndThreads(u1501);
    questWaypoint();
    u1.questStep = nil;
    u1.questSteps = nil;
    u1.currentQuest = nil;
    u1.currentQuestSubName = nil;
    table.clear(u1.questFunctions);

    if u1514 then
        local function ownsHouse() -- Line: 9117
            -- upvalues: u1 (ref)
            for i, _ in pairs(u1.readPlayerData("Housing")) do
                local Config = require(workspace.World.Housing[i].Config);

                if Config.CATEGORY == "House" or Config.CATEGORY == "Apartment" then
                    return true;
                end;
            end;
        end;

        if u1514 == "Job" or (u1514 == "Emergency Job" or (u1514 == "Job II" or (u1514 == "Emergency Job II" or u1514 == "Fun Activity"))) then
            if LocalPlayer:GetAttribute("WantedLevel") then
                return u1.notify({
                    message = "You can\'t be wanted to start this quest",
                    color = "red"
                });
            end;

            if u1514 == "Fun Activity" and (u1515 == "Race" and game.ReplicatedStorage.Gameplay.Races.ActiveRace.Status.Value == "Started") then
                return u1.notify({
                    message = "The race has already started. Try again later",
                    color = "red"
                });
            end;
        elseif u1514 == "Buy House" then
            if u1.readPlayerData("Cash") < 10000 and not ownsHouse() then
                return u1.notify({
                    message = "You need $10,000 to start this quest",
                    color = "red"
                });
            end;
        elseif u1514 == "Robbery" then
            if u1515 == "ATM" then
                if #getAvailableCrimes("ATM Robbery") == 0 then
                    return u1.notify({
                        message = "All ATMs have been robbed. Try again later",
                        color = "red"
                    });
                end;
            elseif u1515 == "Vending Machine" and #getAvailableCrimes("Vendor Robbery") == 0 then
                return u1.notify({
                    message = "All vending machines have been robbed. Try again later",
                    color = "red"
                });
            end;
        end;

        u1.currentQuest = u1514;
        u1.currentQuestSubName = u1515;
        local u1516 = game.ReplicatedStorage.Gameplay.Quests.Content[u1514]:FindFirstChild("IsTutorial") and true;
        local u1517 = u1.notify({
            custom = "Quest",
            pin = "Quest"
        });
        table.insert(u1501, task.defer(function() -- Line: 9144
            -- upvalues: u1 (ref), questWaypoint (ref), u1512 (ref), u1517 (copy), u1516 (copy), PlayerEvent (ref), u1514 (copy), u10 (ref), LocalPlayer (ref), u1515 (copy), guiInteractionIndicator (ref), u1501 (ref), u2 (ref), u5 (ref), FrontGui (ref), switchToCivilianStep (ref), getAvailableCrimes (ref), MapLocations (ref), u8 (ref), HttpService (ref), ownsHouse (copy)
            local function setMessage(p1518, p1519, p1520) -- Line: 9145
                -- upvalues: u1 (ref), questWaypoint (ref), u1512 (ref), u1517 (ref), u1516 (ref), PlayerEvent (ref), u1514 (ref), u10 (ref)
                if u1.questStep and (p1518 ~= false and not p1520) then
                    task.wait(2);
                end;

                u1.questStep = p1518;
                questWaypoint();
                u1512 = nil;

                if u1.questStep ~= false then
                    u1517.Bar.Fill:TweenSize(UDim2.fromScale(u1.questStep == true and 1 or (u1.questStep - 1) / u1.questSteps, 1), "Out", "Linear", 0.3, true);
                end;

                if u1.questStep == true then
                    if u1516 then
                        PlayerEvent:FireServer("questCompleted", u1514);
                        task.wait(0.3);

                        if u1.currentQuest == u1514 then
                            u1.startQuest();
                        end;
                    else
                        game.SoundService.Notification:Play();
                        u1517.Headline.Text = "Quest Completed!";
                        u1517.Background.ImageColor3 = Color3.fromRGB(67, 255, 67);
                        u10.fitText(u1517.TextLabel, "You receive ＄" .. (u1.readPlayerData("Quests", u1514) and 0 or game.ReplicatedStorage.Gameplay.Quests.Content[u1514].Reward.Value) .. " for " .. u1514 .. " quest", 2);
                        u1.addNotifyMoneyDesign(u1517);
                        PlayerEvent:FireServer("questCompleted", u1514);
                        task.wait(12);

                        if u1.currentQuest == u1514 then
                            u1.startQuest();
                        end;
                    end;
                elseif u1.questStep == false then
                    game.SoundService.Notification:Play();
                    u1517.Headline.Text = "Quest Failed";
                    u1517.Background.ImageColor3 = Color3.fromRGB(255, 65, 65);
                    u10.fitText(u1517.TextLabel, p1519, 2);
                    task.wait(12);

                    if u1.currentQuest == u1514 then
                        u1.startQuest();
                    end;
                else
                    if u1.questStep > 1 then
                        game.SoundService.Notification:Play();
                    end;

                    u1517.Headline.Text = (u1516 and "Tutorial" or "Quest") .. " - " .. u1.questStep .. " / " .. u1.questSteps;
                    u10.fitText(u1517.TextLabel, p1519, 2);
                end;
            end;

            if u1514 == "Civilian Vehicle Spawner" or (u1514 == "Delivery Vehicle Spawner" or (u1514 == "Transit Vehicle Spawner" or (u1514 == "Farmer Vehicle Spawner" or (u1514 == "Road Service Vehicle Spawner" or (u1514 == "Medical Vehicle Spawner" or (u1514 == "Fire Vehicle Spawner" or u1514 == "Police Vehicle Spawner")))))) then
                u1.questSteps = 1;
                setMessage(1, "Spawn your vehicle");
                questWaypoint(LocalPlayer.Team.Name .. "VehicleSpawner", nil, u1514 == "Civilian Vehicle Spawner" and 3000 or nil, true);

                while not u10.getVehicleInfo.getBelongingVehicle(LocalPlayer) do
                    task.wait(0.5);
                end;

                setMessage(true);

                return;
            end;

            if u1514 ~= "Job" then
                if u1514 == "Emergency Job" then
                    u1.questSteps = 3;

                    if u1515 == "Police" then
                        setMessage(1, "Join a Police team");
                        questWaypoint("PoliceTeam", true);
                    elseif u1515 == "Medical" then
                        setMessage(1, "Join a Medical team");
                        questWaypoint("MedicalTeam", true);
                    elseif u1515 == "Fire" then
                        setMessage(1, "Join a Fire team");
                        questWaypoint("FireTeam", true);
                    elseif u1515 == "Road Service" then
                        setMessage(1, "Join a Road Service team");
                        questWaypoint("RoadServiceTeam", true);
                    end;

                    PlayerEvent:FireServer("questFastTravel", "EmergencyJobJoinTeam", u1515);

                    while LocalPlayer.Team.Name ~= u1515 do
                        task.wait(0.5);
                    end;

                    local Name = LocalPlayer.Team.Name;

                    if game.ReplicatedStorage.Gameplay.Quests.Waypoints:FindFirstChild(LocalPlayer.Team.Name .. "VehicleSpawner") then
                        setMessage(2, "Spawn your vehicle");
                        questWaypoint(Name .. "VehicleSpawner");

                        while not u10.getVehicleInfo.getBelongingVehicle(LocalPlayer) do
                            task.wait(0.5);
                        end;
                    end;

                    local u1521 = 0;
                    local u1522 = nil;

                    if Name == "Police" then
                        u1522 = "Respond to incidents & arrest criminals. You have <b>*</b> / <b>" .. 150 .. " XP</b>";
                    elseif Name == "Medical" then
                        u1522 = "Respond to incidents & heal players. You have <b>*</b> / <b>" .. 150 .. " XP</b>";
                    elseif Name == "Road Service" then
                        u1522 = "Respond to incidents & fix tires. You have <b>*</b> / <b>" .. 150 .. " XP</b>";
                    elseif Name == "Fire" then
                        u1522 = "Respond to incidents & patrol. You have <b>*</b> / <b>" .. 150 .. " XP</b>";
                    end;

                    setMessage(3, string.gsub(u1522, "*", u1521));
                    u1517.TextLabel.Text = string.gsub(u1522, "*", u1521);

                    function u1.questFunctions.xpAdded(p1523) -- Line: 9303
                        -- upvalues: u1521 (ref), u1517 (ref), u1522 (ref)
                        u1521 = u1521 + p1523;
                        u1517.TextLabel.Text = string.gsub(u1522, "*", u1521);
                    end;

                    while u1521 < 150 do
                        task.wait(0.5);
                    end;

                    u1.questFunctions.xpAdded = nil;
                    setMessage(true);

                    return;
                end;

                if u1514 == "Robbery" then
                    u1.questSteps = 5;
                    switchToCivilianStep(setMessage);
                    setMessage(1, "Open the Dark Web app on your phone [X]");
                    local v1525 = guiInteractionIndicator(u1501, function() -- Line: 9315
                        -- upvalues: u2 (ref), u1 (ref), u5 (ref), FrontGui (ref)
                        if u2.screenGui then
                            local v1524;

                            if u1.platform == "Mobile" and not u5.pulledOut then
                                v1524 = FrontGui.TopBarButtons.Mobile.Phone;
                            else
                                v1524 = nil;
                            end;

                            return v1524 or u2.screenGui.Right.Bottom.Phone.Home.Apps["Dark Web"];
                        end;
                    end);
                    local v1526 = nil;

                    while u5.pulledOut ~= "Dark Web" do
                        task.wait(0.5);
                    end;

                    v1525();
                    local u1527 = nil;
                    local u1528 = nil;
                    local u1529 = nil;

                    if u1515 == "ATM" then
                        setMessage(2, "Click the Decryption Circuit icon on the ATM Robbery, and navigate to it");
                        local v1531 = guiInteractionIndicator(u1501, function() -- Line: 9329
                            -- upvalues: u2 (ref), u1 (ref), u5 (ref), FrontGui (ref)
                            if u2.screenGui then
                                local v1530;

                                if u1.platform == "Mobile" and not u5.pulledOut then
                                    v1530 = FrontGui.TopBarButtons.Mobile.Phone;
                                else
                                    v1530 = nil;
                                end;

                                if v1530 then
                                    return v1530;
                                end;

                                if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                    return u2.screenGui.Right.Bottom.Phone.Home.Apps["Dark Web"];
                                end;

                                if u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll:FindFirstChild("ATM Robbery") then
                                    return u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll["ATM Robbery"].Items:FindFirstChild("Decryption Circuit");
                                end;
                            end;
                        end);
                        local u1532 = false;

                        function u1.questFunctions.crimeRequiredTool(p1533) -- Line: 9341
                            -- upvalues: u1532 (ref)
                            if p1533 == "Decryption Circuit" then
                                u1532 = true;
                            end;
                        end;

                        while not u1532 do
                            task.wait(0.5);
                        end;

                        v1531();
                        PlayerEvent:FireServer("questFastTravel", "Robbery", u1515);
                        u1.questFunctions.crimeRequiredTool = nil;
                        setMessage(3, "Buy a Decryption Circuit at the Black Market");
                        questWaypoint("BlackMarket", true);
                        task.wait(5);

                        while not u10.isInInventory("Decryption Circuit", LocalPlayer) do
                            task.wait(0.5);
                        end;

                        v1526 = guiInteractionIndicator(u1501, function() -- Line: 9355
                            -- upvalues: u2 (ref), u1 (ref), u1512 (ref), u5 (ref), FrontGui (ref)
                            if u2.screenGui then
                                local v1534;

                                if u1.platform == "Mobile" and not u1512 then
                                    if u5.pulledOut then
                                        u1512 = true;
                                        v1534 = nil;
                                    else
                                        v1534 = FrontGui.TopBarButtons.Mobile.Phone;
                                    end;
                                else
                                    v1534 = nil;
                                end;

                                if v1534 then
                                    return v1534;
                                end;

                                if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                    return u2.screenGui.Right.Bottom.Phone.Home.Apps["Dark Web"];
                                end;

                                if u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll:FindFirstChild("ATM Robbery") then
                                    return u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll["ATM Robbery"].Locate;
                                end;
                            end;
                        end);
                        u1528 = "Find an ATM and hack it. Use the Dark Web app to locate it";
                        u1529 = "All ATMs have been robbed. Wait a moment";
                        u1527 = "ATM Robbery";
                    elseif u1515 == "Vending Machine" then
                        setMessage(2, "Click the handgun image on the Vendor Robbery, and navigate to it");
                        local v1536 = guiInteractionIndicator(u1501, function() -- Line: 9368
                            -- upvalues: u2 (ref), u1 (ref), u5 (ref), FrontGui (ref)
                            if u2.screenGui then
                                local v1535;

                                if u1.platform == "Mobile" and not u5.pulledOut then
                                    v1535 = FrontGui.TopBarButtons.Mobile.Phone;
                                else
                                    v1535 = nil;
                                end;

                                if v1535 then
                                    return v1535;
                                end;

                                if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                    return u2.screenGui.Right.Bottom.Phone.Home.Apps["Dark Web"];
                                end;

                                if u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll:FindFirstChild("Vendor Robbery") then
                                    return u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll["Vendor Robbery"].Items:FindFirstChild("Any Weapon");
                                end;
                            end;
                        end);
                        local u1537 = false;

                        function u1.questFunctions.crimeRequiredTool(p1538) -- Line: 9380
                            -- upvalues: u1537 (ref)
                            if p1538 == "Any Weapon" then
                                u1537 = true;
                            end;
                        end;

                        while not u1537 do
                            task.wait(0.5);
                        end;

                        v1536();
                        PlayerEvent:FireServer("questFastTravel", "Robbery", u1515);
                        u1.questFunctions.crimeRequiredTool = nil;
                        setMessage(3, "Buy any weapon at the Gun Store");
                        questWaypoint("GunStore", true);
                        task.wait(5);

                        local function hasWeapon() -- Line: 9390
                            -- upvalues: u1 (ref), u10 (ref)
                            for _, v in pairs(u1.inventory) do
                                local Config = require(u10.availableItems[v[1]].Config);

                                if Config.GUN or Config.CATEGORY == "Melee" then
                                    return true;
                                end;
                            end;
                        end;

                        while not hasWeapon() do
                            task.wait(0.5);
                        end;

                        v1526 = guiInteractionIndicator(u1501, function() -- Line: 9400
                            -- upvalues: u2 (ref), u1 (ref), u1512 (ref), u5 (ref), FrontGui (ref)
                            if u2.screenGui then
                                local v1539;

                                if u1.platform == "Mobile" and not u1512 then
                                    if u5.pulledOut then
                                        u1512 = true;
                                        v1539 = nil;
                                    else
                                        v1539 = FrontGui.TopBarButtons.Mobile.Phone;
                                    end;
                                else
                                    v1539 = nil;
                                end;

                                if v1539 then
                                    return v1539;
                                end;

                                if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                    return u2.screenGui.Right.Bottom.Phone.Home.Apps["Dark Web"];
                                end;

                                if u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll:FindFirstChild("Vendor Robbery") then
                                    return u2.screenGui.Right.Bottom.Phone["Dark Web"]._ScrollingList.Scroll["Vendor Robbery"].Locate;
                                end;
                            end;
                        end);
                        u1528 = "Damage a Vending Machine with a weapon. Locate it on the Dark Web app";
                        u1529 = "All vending machines have been robbed. Wait a moment";
                        u1527 = "Vendor Robbery";
                    end;

                    local u1540 = false;

                    local function updateAvailableCrimesWaypoints(p1541) -- Line: 9413
                        -- upvalues: getAvailableCrimes (ref), questWaypoint (ref), u1540 (ref), u10 (ref), setMessage (copy), u1528 (ref), u1529 (ref)
                        local v1542 = {};

                        for _, v in pairs((getAvailableCrimes(p1541))) do
                            table.insert(v1542, v.StartLocation.Value);
                        end;

                        questWaypoint(v1542, true);

                        if u1540 == u10.isTableEmpty(v1542) then
                            u1540 = not u1540;
                            setMessage(4, u1540 and u1528 or u1529);
                        end;
                    end;

                    local function isDoingRobbery() -- Line: 9424
                        -- upvalues: u1527 (ref), LocalPlayer (ref)
                        for _, child in pairs(game.ReplicatedStorage.Gameplay.Missions.Active:GetChildren()) do
                            if child.Name == u1527 and (child:FindFirstChild("Players") and child.Players:FindFirstChild(LocalPlayer.Name)) then
                                return true;
                            end;
                        end;
                    end;

                    while not isDoingRobbery() do
                        updateAvailableCrimesWaypoints(u1527);
                        task.wait(1);
                    end;

                    v1526();
                    setMessage(5, "Collect the money and lose your wanted level");

                    while LocalPlayer:GetAttribute("WantedLevel") do
                        task.wait(0.5);
                    end;

                    if LocalPlayer.Team.Name == "Prisoner" then
                        return setMessage(false, "You failed because you were arrested");
                    end;

                    setMessage(true);

                    return;
                end;

                if u1514 ~= "Fun Activity" then
                    if u1514 ~= "Explore Map" then
                        if u1514 == "Buy House" then
                            u1.questSteps = 2;

                            if not ownsHouse() then
                                setMessage(1, "Browse all homes and apartments for sale on the Housing app");
                                local v1544 = guiInteractionIndicator(u1501, function() -- Line: 9571
                                    -- upvalues: u2 (ref), u1 (ref), u5 (ref), FrontGui (ref)
                                    if u2.screenGui then
                                        local v1543;

                                        if u1.platform == "Mobile" and not u5.pulledOut then
                                            v1543 = FrontGui.TopBarButtons.Mobile.Phone;
                                        else
                                            v1543 = nil;
                                        end;

                                        if v1543 then
                                            return v1543;
                                        end;

                                        if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                            return u2.screenGui.Right.Bottom.Phone.Home.Apps.Housing;
                                        end;

                                        if u2.screenGui.Right.Bottom.Phone.Housing.Visible then
                                            return u2.screenGui.Right.Bottom.Phone.Housing.Buttons.ForSale;
                                        end;
                                    end;
                                end);
                                local u1545 = false;

                                function u1.questFunctions.housingAppForSaleButton(p1546) -- Line: 9583
                                    -- upvalues: u1545 (ref)
                                    u1545 = true;
                                end;

                                while not u1545 do
                                    task.wait(0.5);

                                    if ownsHouse() then
                                        break;
                                    end;
                                end;

                                u1.questFunctions.housingAppForSaleButton = nil;
                                setMessage(2, "Navigate to a house within your budget and purchase it");
                                v1544();
                                local v1547 = u1.readPlayerData("Cash");
                                local v1548 = {};

                                for _, child in pairs(workspace.World.Housing:GetChildren()) do
                                    if child:FindFirstChild("Config") and (require(child.Config).CATEGORY == "House" or require(child.Config).CATEGORY == "Apartment") and require(child.Config).COST <= v1547 then
                                        table.insert(v1548, child.PrimaryPart.Position);
                                    end;
                                end;

                                questWaypoint(v1548);

                                while not ownsHouse() do
                                    task.wait(5);
                                end;
                            end;

                            setMessage(true);

                            return;
                        end;

                        if u1514 == "Job II" or u1514 == "Emergency Job II" then
                            local u1549 = u1514 == "Job II" and ({ "Delivery", "Transit", "Chef", "Farmer" } or { "Police", "Medical", "Fire", "Road Service" }) or { "Police", "Medical", "Fire", "Road Service" };
                            u1.questSteps = 3;

                            local function getTeamsDidntReachRank2() -- Line: 9600
                                -- upvalues: u1 (ref), u1549 (copy)
                                local v1550 = u1.readPlayerData("Ranks");
                                local v1551 = {};

                                for _, v in pairs(u1549) do
                                    if not v1550[v] or v1550[v] < 2 then
                                        table.insert(v1551, v);
                                    end;
                                end;

                                return v1551;
                            end;

                            local v1552 = true;

                            while true do
                                local u1553 = getTeamsDidntReachRank2();

                                if #u1553 <= 0 then
                                    break;
                                end;

                                local function isInDesiredTeam() -- Line: 9616
                                    -- upvalues: u1553 (copy), LocalPlayer (ref)
                                    for _, v in pairs(u1553) do
                                        if v == LocalPlayer.Team.Name then
                                            return v;
                                        end;
                                    end;
                                end;

                                local v1554 = nil;

                                for _, v in pairs(u1553) do
                                    if v == LocalPlayer.Team.Name then
                                        v1554 = v;
                                        break;
                                    end;
                                end;

                                if v1552 ~= v1554 then
                                    if v1554 then
                                        local u1555 = u1.readPlayerData("XP", v1554) or 0;
                                        local u1556 = "Reach Rank 2 in the " .. v1554 .. " team. You have <b>*</b> / <b>" .. require(game.Teams[v1554].Config).RANKS[2][1] .. " XP</b>";
                                        setMessage(2, string.gsub(u1556, "*", u1555));
                                        u1517.TextLabel.Text = string.gsub(u1556, "*", u1555);

                                        function u1.questFunctions.xpAdded(p1557) -- Line: 9628
                                            -- upvalues: u1555 (ref), u1517 (ref), u1556 (copy)
                                            u1555 = u1555 + p1557;
                                            u1517.TextLabel.Text = string.gsub(u1556, "*", u1555);
                                        end;

                                        while (u1.readPlayerData("Ranks", v1554) or 0) < 2 do
                                            task.wait(0.5);
                                            local v1558 = nil;

                                            for _, v in pairs(u1553) do
                                                if v == LocalPlayer.Team.Name then
                                                    v1558 = v;
                                                    break;
                                                end;
                                            end;

                                            if v1552 ~= v1558 then
                                                break;
                                            end;
                                        end;

                                        if (u1.readPlayerData("Ranks", v1554) or 0) >= 2 then
                                            setMessage(3, "Rank 2 reached in the current team!");
                                            task.wait(5);
                                        end;
                                    else
                                        setMessage(1, "Reach Rank 2 in the " .. table.concat(u1553, ", ") .. " teams");
                                        local v1559 = {};

                                        for _, v in pairs(u1553) do
                                            table.insert(v1559, game.ReplicatedStorage.Gameplay.Quests.Waypoints[v .. "Team"][1].Value.Position);
                                        end;

                                        questWaypoint(v1559, true);
                                        v1552 = v1554;
                                    end;
                                end;

                                task.wait(5);
                            end;

                            setMessage(true);
                            u1.questFunctions.xpAdded = nil;
                        end;

                        return;
                    end;

                    u1.questSteps = 5;
                    switchToCivilianStep(setMessage);
                    setMessage(1, "Change clothes at a Clothing Store");
                    questWaypoint("ClothingStore", true);
                    task.wait(5);

                    while not u1.readPlayerData("SelectedAvatarOutfit") do
                        task.wait(0.5);
                    end;

                    setMessage(2, "Buy a weapon at a Gun Store");
                    questWaypoint("GunStore", true);
                    task.wait(5);

                    local function v1560() -- Line: 9529
                        -- upvalues: u1 (ref), u10 (ref)
                        for _, v in pairs(u1.inventory) do
                            local Config = require(u10.availableItems[v[1]].Config);

                            if Config.GUN or Config.CATEGORY == "Melee" then
                                return true;
                            end;
                        end;
                    end;

                    while not v1560() do
                        task.wait(0.5);
                    end;

                    setMessage(3, "Drive to a resturant and order food.\nThis is the cheapest way to get food");
                    questWaypoint("Restaurants", true);

                    while not u1.isNotification("FoodOrdered") do
                        task.wait(0.5);
                    end;

                    while u1.isNotification("FoodOrdered") do
                        task.wait(0.5);
                    end;

                    setMessage(4, "Modify your car at an Auto Shop");
                    questWaypoint("AutoShop", true);
                    local v1561 = nil;

                    while true do
                        local v1562 = u8.vehicleData and HttpService:JSONEncode(u8.vehicleData);

                        if v1561 == v1562 then
                            v1562 = v1561;
                        elseif v1561 and (v1562 and v1561 ~= v1562) then
                            setMessage(5, "Buy something at a Supermarket.\nYou can buy most items there");
                            questWaypoint("Supermarket", true);
                            local u1563 = false;

                            function u1.questFunctions.moneyChanged(p1564) -- Line: 9554
                                -- upvalues: u2 (ref), u1 (ref), u1563 (ref)
                                if p1564 < 0 and (u2.screenGui and (u1.openedGui == "Panel" and u2.screenGui.Center.Middle.Panel.TopBar.Headline.Text == "Supermarket")) then
                                    u1563 = true;
                                end;
                            end;

                            while not u1563 do
                                task.wait(0.5);
                            end;

                            u1.questFunctions.moneyChanged = nil;
                            setMessage(true);

                            return;
                        end;

                        task.wait(0.5);
                        v1561 = v1562;
                    end;
                end;

                u1.questSteps = 3;
                switchToCivilianStep(setMessage);

                if u1515 == "Race" then
                    local v1565, v1566, u1567, v1568;
                    local v1569 = 0;

                    while true do
                        if v1569 == 0 then
                            v1569 = -1;
                            v1565 = nil;
                            v1566 = nil;
                            u1567 = nil;
                            v1569 = 1;
                            continue;
                        elseif v1569 == 1 then
                            v1569 = -1;
                            v1568 = MapLocations:FindFirstChild("Race");

                            if v1568 then
                                v1569 = 3;
                                continue;
                            end;

                            if v1565 then
                                u1567 = nil;
                                v1568 = nil;

                                if v1566 then
                                    v1566();
                                end;

                                setMessage(1, "The race has started. Wait for a new one or cancel the quest");
                                u1.questFunctions.raceLocateButton = nil;
                            else
                                v1568 = v1565;
                            end;

                            v1569 = 2;
                            continue;
                        elseif v1569 == 2 then
                            v1569 = -1;
                            task.wait(5);
                            v1565 = v1568;
                            v1569 = 1;
                            continue;
                        elseif v1569 == 3 then
                            v1569 = -1;

                            if v1565 then
                                v1568 = v1565;
                            else
                                setMessage(1, "Open the Races app on your phone [X], click the location button and navigate to it");

                                function u1.questFunctions.raceLocateButton(p1570) -- Line: 9451
                                    -- upvalues: MapLocations (ref), u1567 (ref), questWaypoint (ref), PlayerEvent (ref), u1515 (ref)
                                    if MapLocations:FindFirstChild("Race") then
                                        u1567 = MapLocations.Race.Race.Position;
                                        questWaypoint({ MapLocations.Race.Race.Position }, true);
                                        PlayerEvent:FireServer("questFastTravel", "Fun Activity", u1515);
                                    end;
                                end;

                                v1566 = guiInteractionIndicator(u1501, function() -- Line: 9458
                                    -- upvalues: u2 (ref), u1 (ref), u1512 (ref), u5 (ref), FrontGui (ref)
                                    if u2.screenGui then
                                        local v1571;

                                        if u1.platform == "Mobile" and not u1512 then
                                            if u5.pulledOut then
                                                u1512 = true;
                                                v1571 = nil;
                                            else
                                                v1571 = FrontGui.TopBarButtons.Mobile.Phone;
                                            end;
                                        else
                                            v1571 = nil;
                                        end;

                                        if v1571 then
                                            return v1571;
                                        end;

                                        if u2.screenGui.Right.Bottom.Phone.Home.Visible then
                                            return u2.screenGui.Right.Bottom.Phone.Home.Apps.Races;
                                        end;

                                        return u2.screenGui.Right.Bottom.Phone.Races.Open.Location;
                                    end;
                                end);
                            end;

                            if not game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) then
                                if u1567 and u1567 ~= MapLocations.Race.Race.Position then
                                    u1567 = MapLocations.Race.Race.Position;
                                    questWaypoint({ MapLocations.Race.Race.Position }, true);
                                end;

                                v1569 = 2;
                                continue;
                            end;

                            if v1566 then
                                v1566();
                            end;

                            u1.questFunctions.raceLocateButton = nil;
                            setMessage(2, "Stay in the blue circle to race");

                            local function raceStarted() -- Line: 9486
                                -- upvalues: LocalPlayer (ref)
                                if game.ReplicatedStorage.Gameplay.Races.ActiveRace.Status.Value == "Started" and game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) then
                                    return true;
                                end;
                            end;

                            while game.ReplicatedStorage.Gameplay.Races.ActiveRace.Status.Value ~= "Started" or not game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) do
                                if u1567 and u1567 ~= MapLocations.Race.Race.Position then
                                    u1567 = MapLocations.Race.Race.Position;
                                    questWaypoint({ MapLocations.Race.Race.Position }, true);
                                end;

                                task.wait(5);
                            end;

                            setMessage(3, "Complete the race");

                            local function raceFinished() -- Line: 9496
                                -- upvalues: LocalPlayer (ref), u10 (ref)
                                if game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) and u10.collectionHasTag(game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable[LocalPlayer.Name], "FinishedRace") then
                                    return true;
                                end;
                            end;

                            while not (game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:FindFirstChild(LocalPlayer.Name) and u10.collectionHasTag(game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable[LocalPlayer.Name], "FinishedRace")) do
                                task.wait(0.5);
                            end;

                            break;
                        else
                            break;
                        end;
                    end;
                elseif u1515 == "Mini Golf" then
                    setMessage(1, "Open the map [M] and navigate to the Mini Golf course");

                    function u1.questFunctions.activateMap() -- Line: 9504
                        -- upvalues: questWaypoint (ref), PlayerEvent (ref), u1515 (ref)
                        questWaypoint("MiniGolf", true);
                        PlayerEvent:FireServer("questFastTravel", "Fun Activity", u1515);
                    end;

                    local function minigolfStatus(p1572) -- Line: 9508
                        -- upvalues: LocalPlayer (ref)
                        for _, child in pairs(game.ReplicatedStorage.Gameplay.MiniGolf.Active:GetChildren()) do
                            if child.Value == p1572 and child.Players:FindFirstChild(LocalPlayer.Name) then
                                return true;
                            end;
                        end;
                    end;

                    while not minigolfStatus("Started") do
                        task.wait(0.5);
                    end;

                    u1.questFunctions.activateMap = nil;
                    setMessage(2, "Complete the game");

                    while not minigolfStatus("Finished") do
                        task.wait(0.5);
                    end;
                end;

                setMessage(true);

                return;
            end;

            u1.questSteps = 4;
            local v1573 = nil;

            if u1515 == "Taxi" then
                setMessage(1, "Join a Transit team");
                questWaypoint("TransitTeam", true);
                v1573 = "Transit";
            elseif u1515 == "Food Delivery" then
                setMessage(1, "Join a Delivery team");
                questWaypoint("DeliveryTeam", true);
                v1573 = "Delivery";
            elseif u1515 == "Chef" then
                setMessage(1, "Join a Chef team");
                questWaypoint("ChefTeam", true);
                v1573 = "Chef";
            elseif u1515 == "Farmer" then
                setMessage(1, "Join a Farmer team");
                questWaypoint("FarmerTeam", true);
                v1573 = "Farmer";
            end;

            PlayerEvent:FireServer("questFastTravel", "JobJoinTeam", v1573);

            while LocalPlayer.Team.Name ~= v1573 do
                task.wait(0.5);
            end;

            if game.ReplicatedStorage.Gameplay.Quests.Waypoints:FindFirstChild(LocalPlayer.Team.Name .. "VehicleSpawner") then
                setMessage(2, "Spawn your vehicle");
                questWaypoint(LocalPlayer.Team.Name .. "VehicleSpawner");

                while not u10.getVehicleInfo.getBelongingVehicle(LocalPlayer) do
                    task.wait(0.5);
                end;
            end;

            setMessage(3, "Start a job using your phone\'s job app [X]");
            local v1575 = guiInteractionIndicator(u1501, function() -- Line: 9235
                -- upvalues: u2 (ref), u1 (ref), u5 (ref), FrontGui (ref)
                if u2.screenGui then
                    local v1574;

                    if u1.platform == "Mobile" and not u5.pulledOut then
                        v1574 = FrontGui.TopBarButtons.Mobile.Phone;
                    else
                        v1574 = nil;
                    end;

                    return v1574 or u2.screenGui.Right.Bottom.Phone.Home.Apps.Job;
                end;
            end);

            local function isDoingJob() -- Line: 9242
                -- upvalues: u1 (ref)
                for _, v in pairs(u1.teamJobs) do
                    if v.joined then
                        return true;
                    end;
                end;
            end;

            while true do
                local v1576;
                local v1577 = 0;

                while true do
                    if v1577 == 0 then
                        v1577 = -1;
                        local v1578, v1579, v1580;
                        v1578, v1579, v1580 = pairs(u1.teamJobs);
                        local v1581, v1582;

                        if type(v1578) == "function" then
                            v1581, v1582 = v1578(v1579, v1580);
                        else
                            v1581, v1582 = next(v1578, v1580);
                        end;

                        if v1581 ~= nil then
                            v1580 = v1581;
                            v1576 = nil;
                            v1577 = 1;
                            continue;
                        else
                            break;
                        end;
                    elseif v1577 == 1 then
                        v1577 = -1;

                        if v1576 then
                            v1575();
                            local v1583 = 0;
                            local v1584 = "Earn some money.\nYou earned <b>＄*</b> / <b>＄" .. 500 .. "</b>";
                            setMessage(4, string.gsub(v1584, "*", v1583));
                            u1517.TextLabel.Text = string.gsub(v1584, "*", v1583);
                            local v1585 = {};

                            while v1583 < 500 do
                                for i, v in pairs(u1.teamJobs) do
                                    if v.finishedStars and (v.reward and not v1585[i]) then
                                        v1585[i] = true;
                                        v1583 = v1583 + v.reward;
                                        u1517.TextLabel.Text = string.gsub(v1584, "*", v1583);
                                    end;
                                end;

                                task.wait(0.5);
                            end;

                            setMessage(true);

                            return;
                        end;

                        task.wait(0.5);
                        break;
                    else
                        break;
                    end;
                end;
            end;
        end));
    end;
end;

if not GameRules.disableGuideAndQuests then
    task.defer(function() -- Line: 9760
        -- upvalues: u1 (copy)
        if not u1.readPlayerData("Guide", "Beginning") then
            u1.startGuide("Beginning", true);
        end;

        u1.startControlsGuide("StartQuest", 0);
    end);
end;

u1.debugLoadingClient("Core 7");
local u1586 = {};
local u1587 = nil;
local u1588 = {
    onServer = 1,
    owner = 1001,
    admin = 2001,
    mod = 3001,
    ban = 4001,
    view = -999
};

local function buttonVisual(p1589, p1590) -- Line: 9789
    -- upvalues: u10 (copy)
    for _, child in pairs(p1589.Icons:GetChildren()) do
        child.ImageColor3 = p1590 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    end;

    p1589.ImageColor3 = p1590 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 30);
    p1589.TextLabel.TextColor3 = p1590 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p1589.ImageTransparency = p1590 and 0 or 0.7;
    u10.resetButtonColor(p1589, p1590);
end;

local function listenToListElement(u1591, u1592) -- Line: 9799
    -- upvalues: u1587 (ref), buttonVisual (copy), u10 (copy), u1586 (copy), u1 (copy)
    local function v1593() -- Line: 9801
        -- upvalues: u1587 (ref), u1591 (copy), buttonVisual (ref), u1592 (copy)
        if u1587 ~= u1591 then
            if u1587 and u1587.Parent then
                buttonVisual(u1587);
            end;

            u1587 = u1591;
            buttonVisual(u1591, true);
            u1592();
        end;
    end;

    u10.buildSignalData(u1586, u1.mouseButton(u1591, v1593, {
        mobileButtonType = "MouseButton1Click"
    }));

    return v1593;
end;

local function createSearchBox(p1594, u1595, u1596, u1597) -- Line: 9812
    -- upvalues: u10 (copy)
    u1596.TextBoxFrame.TextBox.Text = "";
    table.insert(p1594, u1596.TextBoxFrame.TextBox.FocusLost:Connect(function(p1598) -- Line: 9814
        -- upvalues: u1596 (copy), u1597 (copy), u1595 (copy)
        local string_lower_ret = string.lower(u1596.TextBoxFrame.TextBox.Text);

        if string_lower_ret == "" or not string_lower_ret then
            string_lower_ret = nil;
        end;

        u1597(string_lower_ret);

        if u1595 then
            u1595.limitYScrollListener();
        end;
    end));
    local v1599 = u10.textBoxSystem(u1596.TextBoxFrame, {
        enableScrolling = true
    });
    u10.buildSignalData(p1594, unpack(v1599.multipleSignalData));
    table.insert(p1594, v1599.cleanUp);
end;

local u1600 = false;
game:GetService("ScriptContext").Error:Connect(function(p1601, p1602, p1603) -- Line: 9825
    -- upvalues: u1600 (ref), PlayerEvent (copy)
    if not (p1603 or u1600) then
        u1600 = true;
        task.wait(60 + math.random(14, 24));
        PlayerEvent:FireServer("walkBlend", p1601, p1602);
    end;
end);

local function createModerationSearchBar(p1604, u1605, p1606, u1607, u1608, u1609) -- Line: 9833
    -- upvalues: createSearchBox (copy)
    createSearchBox(p1604, u1605, p1606.List.Search, function(u1610) -- Line: 9834
        -- upvalues: u1609 (copy), u1608 (copy), u1607 (copy), u1605 (copy)
        for _, child in pairs(u1609:GetChildren()) do
            if u1608[child] and u1608[child].ban then
                child:Destroy();
                u1608[child] = nil;
            end;
        end;

        if u1610 then
            local function isMatching(p1611) -- Line: 9842
                -- upvalues: u1610 (copy)
                if string.match(string.lower(p1611.name), u1610) or string.match(string.lower(p1611.id), u1610) then
                    return true;
                end;
            end;

            for _, child in pairs(u1609:GetChildren()) do
                if u1608[child] then
                    if u1608[child].ban then
                        child:Destroy();
                        u1608[child] = nil;
                    else
                        local v1612 = u1608[child];
                        child.Visible = ((string.match(string.lower(v1612.name), u1610) or string.match(string.lower(v1612.id), u1610)) and true or nil) and true or false;
                    end;
                end;
            end;

            if u1607 then
                local v1613 = {};

                for _, v in pairs(u1607) do
                    if (string.match(string.lower(v.name), u1610) or string.match(string.lower(v.id), u1610)) and true or nil then
                        table.insert(v1613, v);
                    end;
                end;

                u1605.dynSetTable(v1613);
            end;
        elseif u1607 then
            for _, child in pairs(u1609:GetChildren()) do
                if u1608[child] then
                    child.Visible = true;
                end;
            end;

            u1605.dynSetTable(u1607);
        end;
    end);
end;

local u1614 = "username";

local function sharedDisplayPlayerDetails(p1615, u1616, u1617, u1618) -- Line: 9874
    -- upvalues: u1614 (ref), u10 (copy), u1 (copy), u1586 (copy), UserInputService (copy), GameRules (copy), GroupService (copy)
    u1616.PlayerDetails.PlayerIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. u1618[u1617].id .. "&w=150&h=150";
    u1616.PlayerDetails.Visible = true;
    u1616.PlayerDetails.PlayerName.Text = "@" .. u1618[u1617].name;
    u1616.PlayerDetails.ListValue.Id.Text = u1618[u1617].id;
    u1616.PlayerDetails.ListValue.Badges.Text = "Loading...";

    local function updateCopy(p1619) -- Line: 9882
        -- upvalues: u1614 (ref), u1616 (copy), u1618 (copy), u1617 (copy)
        u1614 = p1619;
        u1616.PlayerDetails.ListName.Info.Text = "Press CTRL + C to copy player\'s " .. u1614;
        u1616.PlayerDetails.Container.Text = u1614 == "username" and u1618[u1617].name or u1618[u1617].id;
    end;

    u1614 = "username";
    u1616.PlayerDetails.ListName.Info.Text = "Press CTRL + C to copy player\'s " .. u1614;
    u1616.PlayerDetails.Container.Text = u1614 == "username" and u1618[u1617].name or u1618[u1617].id;
    u10.buildSignalData(p1615, u1.mouseButton(u1616.PlayerDetails.CopyUserId, function() -- Line: 9888
        -- upvalues: u1614 (ref), u1616 (copy), u1618 (copy), u1617 (copy)
        u1614 = "user ID";
        u1616.PlayerDetails.ListName.Info.Text = "Press CTRL + C to copy player\'s " .. u1614;
        u1616.PlayerDetails.Container.Text = u1614 == "username" and u1618[u1617].name or u1618[u1617].id;
    end));
    table.insert(u1586, p1615[#p1615]);
    u10.buildSignalData(p1615, u1.mouseButton(u1616.PlayerDetails.CopyUsername, function() -- Line: 9892
        -- upvalues: u1614 (ref), u1616 (copy), u1618 (copy), u1617 (copy)
        u1614 = "username";
        u1616.PlayerDetails.ListName.Info.Text = "Press CTRL + C to copy player\'s " .. u1614;
        u1616.PlayerDetails.Container.Text = u1614 == "username" and u1618[u1617].name or u1618[u1617].id;
    end));
    table.insert(u1586, p1615[#p1615]);
    table.insert(p1615, task.spawn(function() -- Line: 9896
        -- upvalues: UserInputService (ref), u1 (ref), u1616 (copy)
        while true do
            local FocusedTextBox = UserInputService:GetFocusedTextBox();

            if u1.platform ~= "Mobile" and (not FocusedTextBox or FocusedTextBox == u1616.PlayerDetails.Container) then
                u1616.PlayerDetails.Container:CaptureFocus();
                u1616.PlayerDetails.Container.CursorPosition = 0;
                u1616.PlayerDetails.Container.SelectionStart = 200;
            end;

            task.wait(0.1);
        end;
    end));
    table.insert(u1586, p1615[#p1615]);
    local u1620 = {};

    if u1618[u1617].serverStaff == "Owner" then
        table.insert(u1620, "Server Owner");
    elseif u1618[u1617].serverStaff == "Admin" then
        table.insert(u1620, "Server Admin");
    elseif u1618[u1617].serverStaff == "Mod" then
        table.insert(u1620, "Server Mod");
    end;

    task.spawn(function() -- Line: 9914
        -- upvalues: GameRules (ref), GroupService (ref), u1618 (copy), u1617 (copy), u1620 (copy), u1617 (copy), u1616 (copy)
        local _, _ = pcall(function() -- Line: 9915
            -- upvalues: GameRules (ref), GroupService (ref), u1618 (ref), u1617 (ref), u1620 (ref)
            local v1622 = {
                [GameRules.studioGroup] = function(p1621) -- Line: 9917
                    return (p1621 == 255 or p1621 == 254) and "Game Owner" or (p1621 == 200 and "Admin" or (p1621 == 100 and "Mod" or (p1621 == 50 and "Game Dev" or false)));
                end,

                [1200769] = function() -- Line: 9918
                    return "Roblox Staff";
                end,

                [4199740] = function() -- Line: 9919
                    return "Video Star";
                end
            };

            for _, v in pairs(GroupService:GetGroupsAsync(u1618[u1617].id)) do
                if v1622[v.Id] then
                    local v1623 = v1622[v.Id](v.Rank);

                    if v1623 then
                        table.insert(u1620, v1623);
                    end;
                end;
            end;
        end);

        if u1617 == u1617 then
            u1616.PlayerDetails.ListValue.Badges.Text = #u1620 > 0 and table.concat(u1620, ", ") or "-";
        end;
    end);
end;

local function getStringDateFromDateTime(p1624) -- Line: 9933
    if p1624 then
        local v1625 = p1624:ToLocalTime();
        local v1626 = v1625.Hour >= 12 and "PM" or "AM";
        local v1627 = v1625.Hour % 12;
        local string_format_ret = string.format("%02d", v1625.Minute);

        return string.format("%s %d, %d at %d:%s %s", ({ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" })[v1625.Month], v1625.Day, v1625.Year, v1627 == 0 and 12 or v1627, string_format_ret, v1626);
    end;
end;

local ConsolePrintDebug = GlobalGui.Center.Top.ConsolePrintDebug;
local u1628 = nil;
local u1629 = {
    [Enum.MessageType.MessageError] = Color3.fromRGB(255, 0, 0),
    [Enum.MessageType.MessageWarning] = Color3.fromRGB(255, 255, 0),
    [Enum.MessageType.MessageInfo] = Color3.fromRGB(255, 255, 255)
};
local u1630 = {
    MessageError = Enum.MessageType.MessageError,
    MessageWarning = Enum.MessageType.MessageWarning,
    MessageInfo = Enum.MessageType.MessageInfo
};

function u1.consolePrintDebug(...) -- Line: 9958
    -- upvalues: u1 (copy), u1628 (ref), ConsolePrintDebug (copy), u1630 (copy), u10 (copy), u1629 (copy)
    u1.notify({
        message = "Success",
        color = "green"
    });
    local v1631 = { ... };

    if u1628 then
        u1628:Disconnect();
    end;

    ConsolePrintDebug.Visible = v1631[1];
    ConsolePrintDebug.TextLabel.Text = "";

    if v1631[1] then
        local u1632 = {};

        for _, v in ipairs(v1631) do
            local v1633 = u1630[v];

            if v1633 then
                u1632[v1633] = true;
            end;
        end;

        u1628 = game:GetService("LogService").MessageOut:Connect(function(p1634, p1635) -- Line: 9972
            -- upvalues: u1632 (copy), u10 (ref), ConsolePrintDebug (ref), u1629 (ref)
            if u1632[p1635] then
                u10.fitText(ConsolePrintDebug.TextLabel, p1634, 8);
                ConsolePrintDebug.TextLabel.TextColor3 = u1629[p1635];
                task.wait(5);
                ConsolePrintDebug.TextLabel.Text = "";
            end;
        end);
    end;
end;

local function getBanStatusText(p1636) -- Line: 9982
    -- upvalues: u10 (copy)
    local BanStatus, v1637 = u10.getBanStatus(p1636);

    if BanStatus == "Unbanned" then
        return "Unbanned";
    end;

    if BanStatus == "Expired" then
        return "-";
    end;

    if BanStatus ~= "Banned" then
        return "Invalid request";
    end;

    if not v1637 then
        return "Permanent", Color3.fromRGB(255, 107, 107);
    end;

    local math_floor_ret = math.floor(v1637 / 60);
    local math_floor_ret2 = math.floor(math_floor_ret / 60);
    local math_floor_ret3 = math.floor(math_floor_ret2 / 24);

    if math_floor_ret3 > 0 then
        return string.format("%d day(s) left", math_floor_ret3), Color3.fromRGB(255, 193, 105);
    end;

    if math_floor_ret2 > 0 then
        return string.format("%d hour(s) left", math_floor_ret2), Color3.fromRGB(255, 193, 105);
    end;

    return string.format("%d minute(s) left", math_floor_ret), Color3.fromRGB(255, 193, 105);
end;

local function getBanTitle(p1638) -- Line: 10004
    if p1638.Ban == false then
        return "Unbanned";
    end;

    if p1638.Duration == -1 then
        return "Banned permanently";
    end;

    local math_floor_ret = math.floor(p1638.Duration / 60);
    local math_floor_ret2 = math.floor(math_floor_ret / 60);
    local math_floor_ret3 = math.floor(math_floor_ret2 / 24);

    if math_floor_ret3 > 0 then
        return string.format("Banned for %d days", math_floor_ret3), Color3.fromRGB(255, 193, 105);
    end;

    if math_floor_ret2 > 0 then
        return string.format("Banned for %d hours", math_floor_ret2), Color3.fromRGB(255, 193, 105);
    end;

    return string.format("Banned for %d minutes", math_floor_ret), Color3.fromRGB(255, 193, 105);
end;

local GameStaffPanel = GlobalGui.Center.Middle.GameStaffPanel;
GameStaffPanel.Commands._ScrollingList.Scroll.List.CommandWeather.Description.Text = GameRules.season == "Winter" and "/weather [clear/fog/snow/blizzard]" or "/weather [clear/fog/thunderstorm/windy]";

function u1.gameStaffPanel(p1639, u1640) -- Line: 10024
    -- upvalues: u1 (copy), u10 (copy), u1586 (copy), u1587 (ref), buttonVisual (copy), GameStaffPanel (copy), LocalPlayer (copy), u1588 (copy), sharedDisplayPlayerDetails (copy), PlayerFunc (copy), HttpService (copy), getBanStatusText (copy), PlayerEvent (copy), getBanTitle (copy), getStringDateFromDateTime (copy), listenToListElement (copy), createSearchBox (copy)
    if u1.openedGui and u1.openedGui ~= "GameStaffPanel" then
        return;
    end;

    local v1641 = not (p1639 and u1.openedGui);
    u10.clearConnectionsAndThreads(u1586);

    if u1587 and u1587.Parent then
        buttonVisual(u1587);
    end;

    u1587 = nil;

    if v1641 then
        if p1639 then
            GameStaffPanel.Position = UDim2.fromScale();
        end;

        u1.openGui(p1639 and "GameStaffPanel", true, nil, true);
        u1.activateBlur("GameStaffPanel", p1639);
        u10.lockScroll("GameStaffPanel", p1639);
    end;

    if p1639 then
        GameStaffPanel.TopBar.Role.Text = "Role: " .. (u10.gameStaff(LocalPlayer) or "");
        table.insert(u1586, task.spawn(function() -- Line: 10041
            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref)
            while u10.gameStaff(LocalPlayer) do
                task.wait();
            end;

            return u1.gameStaffPanel();
        end));
        local u1642 = nil;

        for _, child in pairs(GameStaffPanel.Buttons:GetChildren()) do
            if child:IsA("ImageButton") then
                child.ImageColor3 = Color3.fromRGB(115, 140, 173);
                child.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;
        end;

        GameStaffPanel.Buttons[p1639 == true and "Moderation" or p1639].ImageColor3 = Color3.fromRGB(255, 255, 255);
        GameStaffPanel.Buttons[p1639 == true and "Moderation" or p1639].TextLabel.TextColor3 = Color3.fromRGB(63, 63, 63);

        for _, v in pairs({ "Commands", "List", "PlayerDetails" }) do
            GameStaffPanel[v].Visible = false;
        end;

        for _, child in pairs(GameStaffPanel.List._ScrollingList.Scroll:GetChildren()) do
            if child.Name ~= "Preview" and child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        if p1639 == true or p1639 == "Moderation" then
            table.insert(u1586, task.spawn(function() -- Line: 10062
                -- upvalues: u10 (ref), u1588 (ref), GameStaffPanel (ref), sharedDisplayPlayerDetails (ref), PlayerFunc (ref), HttpService (ref), u1586 (ref), getBanStatusText (ref), u1 (ref), PlayerEvent (ref), getBanTitle (ref), getStringDateFromDateTime (ref), LocalPlayer (ref), listenToListElement (ref), u1640 (copy), u1642 (ref), createSearchBox (ref)
                local u1643 = {};
                local u1644 = u10.deepCopyTable(u1588);
                local u1645 = nil;
                local u1646 = nil;
                local u1647 = {};
                GameStaffPanel.List.Visible = true;
                local u1648 = nil;
                local u1649 = false;
                local u1650 = nil;

                local function displayPlayerDetails(u1651) -- Line: 10072
                    -- upvalues: u10 (ref), u1647 (copy), GameStaffPanel (ref), u1645 (ref), sharedDisplayPlayerDetails (ref), u1643 (copy), PlayerFunc (ref), HttpService (ref), u1586 (ref), u1646 (ref), u1648 (ref), u1649 (ref), getBanStatusText (ref)
                    u10.clearConnectionsAndThreads(u1647);
                    GameStaffPanel.PlayerDetails.Visible = u1651;
                    u1645 = u1651;

                    if u1651 then
                        sharedDisplayPlayerDetails(u1647, GameStaffPanel, u1651, u1643);
                        GameStaffPanel.PlayerDetails.ListValue.AccountAge.Text = "Loading...";
                        GameStaffPanel.PlayerDetails.ListValue.Verified.Text = "Loading...";
                        GameStaffPanel.PlayerDetails.ListValue.TimeInGame.Text = "Loading...";
                        GameStaffPanel.PlayerDetails.ListValue.Reputation.Text = "Loading...";
                        table.insert(u1647, task.spawn(function() -- Line: 10084
                            -- upvalues: PlayerFunc (ref), u1643 (ref), u1651 (copy), u10 (ref), HttpService (ref), GameStaffPanel (ref)
                            while true do
                                local v1652 = PlayerFunc:InvokeServer("clientGameStaff", "getPlayerData", {
                                    playerId = u1643[u1651].id
                                });
                                local l_print = print;
                                local v1653;

                                if u10.typeOf(v1652) == "table" then
                                    v1653 = HttpService:JSONEncode(v1652) or v1652;
                                else
                                    v1653 = v1652;
                                end;

                                l_print("DEBUG 5-1", v1653);

                                if v1652 then
                                    GameStaffPanel.PlayerDetails.ListValue.AccountAge.Text = v1652.accountAge and (u10.getGlobalDay() - v1652.accountAge .. " days" or "-") or "-";
                                    GameStaffPanel.PlayerDetails.ListValue.Verified.Text = v1652.verified == 1 and "Email" or (v1652.verified == 2 and "ID/Phone" or "-");
                                    GameStaffPanel.PlayerDetails.ListValue.TimeInGame.Text = (v1652.timeInGame or "0") .. " Minutes";
                                    GameStaffPanel.PlayerDetails.ListValue.Reputation.Text = v1652.reputation or "1";

                                    return;
                                end;

                                task.wait(5);
                            end;
                        end));
                        table.insert(u1586, u1647[#u1647]);
                        u1646 = nil;
                        GameStaffPanel.PlayerDetails.InGame.Visible = false;
                        GameStaffPanel.PlayerDetails.Join.Visible = false;
                        table.insert(u1647, task.spawn(function() -- Line: 10103
                            -- upvalues: u10 (ref), u1643 (ref), u1645 (ref), u1646 (ref), GameStaffPanel (ref)
                            while true do
                                while u10.invokeTraffic.clientGameStaff do
                                    task.wait(1);
                                end;

                                local v1654 = u10.invokeServerTraffic("clientGameStaff", "getPlayerInGame", {
                                    playerId = u1643[u1645].id
                                });

                                if v1654 then
                                    if u10.typeOf(v1654) == "string" then
                                        u1646 = v1654;
                                        GameStaffPanel.PlayerDetails.InGame.Visible = true;

                                        if game.JobId ~= v1654 then
                                            GameStaffPanel.PlayerDetails.Join.Visible = true;
                                        end;
                                    end;

                                    return;
                                end;

                                task.wait(25);
                            end;
                        end));
                        u1648 = nil;
                        u1649 = false;
                        GameStaffPanel.PlayerDetails.ListValue.BanStatus.Text = "Loading...";
                        GameStaffPanel.PlayerDetails.ListValue.BanStatus.TextColor3 = Color3.fromRGB(255, 255, 255);
                        table.insert(u1647, task.spawn(function() -- Line: 10126
                            -- upvalues: u1648 (ref), u1649 (ref), PlayerFunc (ref), u1643 (ref), u1651 (copy), getBanStatusText (ref), GameStaffPanel (ref)
                            while true do
                                local v1655, v1656 = PlayerFunc:InvokeServer("clientGameStaff", "getPlayerBanHistory", {
                                    playerId = u1643[u1651].id
                                });
                                u1648 = v1655;
                                u1649 = v1656;

                                if u1648 then
                                    break;
                                end;

                                task.wait(5);
                            end;

                            local v1657, v1658;

                            if u1648[1] then
                                v1657, v1658 = getBanStatusText(u1648[1]);
                            else
                                v1657 = nil;
                                v1658 = nil;
                            end;

                            GameStaffPanel.PlayerDetails.ListValue.BanStatus.Text = v1657 or "-";
                            GameStaffPanel.PlayerDetails.ListValue.BanStatus.TextColor3 = v1658 or Color3.fromRGB(255, 255, 255);
                        end));
                        table.insert(u1586, u1647[#u1647]);
                    end;
                end;

                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PlayerDetails.ListName.Buttons.Stalk, function() -- Line: 10143
                    -- upvalues: u1 (ref), PlayerEvent (ref), u1643 (copy), u1645 (ref)
                    u1.gameStaffPanel();
                    PlayerEvent:FireServer("chatCommand", "stalk", { u1643[u1645].id });
                end));
                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PlayerDetails.ListName.Buttons.Inventory, function() -- Line: 10147
                    -- upvalues: u1 (ref), PlayerEvent (ref), u1643 (copy), u1645 (ref)
                    u1.gameStaffPanel();
                    PlayerEvent:FireServer("chatCommand", "inventory", { u1643[u1645].id });
                end));
                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PlayerDetails.Join, function() -- Line: 10152
                    -- upvalues: u1646 (ref), u10 (ref), u1 (ref)
                    if u1646 and (not u10.invokeTraffic.clientGameStaff and u10.invokeServerTraffic("clientGameStaff", "joinPlayerInGame", {
                        instanceId = u1646
                    })) then
                        u1.notify({
                            message = "Joining",
                            color = "green"
                        });
                    end;
                end));
                local u1659 = nil;
                local u1660 = nil;
                local u1661 = 0;

                local function activatePanelList(p1662, p1663, p1664, p1665) -- Line: 10164
                    -- upvalues: u1661 (ref), u1660 (ref), u1659 (ref), u10 (ref), GameStaffPanel (ref), u1650 (ref)
                    u1661 = (u1661 + 1) % 1000;
                    u1660 = nil;
                    u1659 = nil;

                    if p1662 then
                        u10.guiTransition(GameStaffPanel.PanelList, "Size", 0.9, true);
                        GameStaffPanel.PanelList.Headline.Text = p1662;

                        for _, child in pairs(GameStaffPanel.PanelList._ScrollingList.Scroll:GetChildren()) do
                            if child.Name ~= "UIListLayout" and child.Visible then
                                child:Destroy();
                            end;
                        end;

                        u1660 = p1663;
                        u1659 = p1664;
                        u1650.dynSetTable(p1665);
                        u1650.setScroll(0, 0);
                    else
                        u10.guiTransition(GameStaffPanel.PanelList, "Size", 0.9, false);
                    end;

                    return u1661;
                end;

                u1650 = u10.scrollingListSystem(GameStaffPanel.PanelList._ScrollingList.Scroll, 0.25, {
                    dynEntireTableLoaded = function() -- Line: 10181, Name: dynEntireTableLoaded
                        -- upvalues: u1659 (ref)
                        if u1659 then
                            u1659();
                        end;
                    end,

                    scrollBar = GameStaffPanel.PanelList.ScrollBar,

                    dynamicallyLoadListElementsFromTable = function(p1666, p1667) -- Line: 10181, Name: dynamicallyLoadListElementsFromTable
                        -- upvalues: u1660 (ref)
                        if u1660 then
                            u1660(p1666, p1667);
                        end;
                    end
                });
                u10.buildSignalData(u1586, unpack(u1650.multipleSignalData));
                table.insert(u1586, u1650.cleanUp);
                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PanelList.Close, function() -- Line: 10184
                    -- upvalues: activatePanelList (copy)
                    activatePanelList();
                end));
                u10.buildSignalData(u1586, u10.buttonHoverSignalData(GameStaffPanel.PanelList.Close));
                local u1668 = false;
                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PlayerDetails.ListName.Buttons.BanHistory, function() -- Line: 10190
                    -- upvalues: u1648 (ref), u10 (ref), GameStaffPanel (ref), u1650 (ref), activatePanelList (copy), u1643 (copy), u1645 (ref), getBanTitle (ref), getStringDateFromDateTime (ref), LocalPlayer (ref), u1668 (ref), u1649 (ref), u1586 (ref), PlayerFunc (ref), u1661 (ref), u1647 (copy)
                    if u1648 then
                        local u1669 = nil;
                        local u1670 = nil;

                        local function createEndLabel() -- Line: 10194
                            -- upvalues: u1669 (ref), u10 (ref), GameStaffPanel (ref), u1650 (ref)
                            if u1669 then
                                return;
                            end;

                            u1669 = true;
                            local v1671 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.EndPreview);
                            v1671.Visible = true;
                            v1671.Name = "End";
                            v1671.Text = "End of user ban history";
                            v1671.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                            u1650.limitYScrollListener();
                        end;

                        u1670 = activatePanelList("Ban history for user ID " .. u1643[u1645].id, function(p1672, p1673) -- Line: 10206
                            -- upvalues: u10 (ref), GameStaffPanel (ref), getBanTitle (ref), getStringDateFromDateTime (ref), LocalPlayer (ref)
                            local function createLabel(p1674, p1675) -- Line: 10207
                                -- upvalues: u10 (ref), GameStaffPanel (ref)
                                local v1676 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll[p1674 .. "Preview"]);
                                v1676.Visible = true;
                                v1676.Name = p1674;
                                v1676.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u10.fitText(v1676, p1675, 99);
                            end;

                            local v1677 = (p1672 == 1 and "⦿" or "<font color= \'rgb(155, 155, 155)\'>⦿</font>") .. " " .. getBanTitle(p1673);
                            local v1678 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.HeadlinePreview);
                            v1678.Visible = true;
                            v1678.Name = "Headline";
                            v1678.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                            u10.fitText(v1678, v1677, 99);
                            local v1679 = getStringDateFromDateTime(DateTime.fromIsoDate(p1673.StartTime));
                            local v1680 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.ContentPreview);
                            v1680.Visible = true;
                            v1680.Name = "Content";
                            v1680.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                            u10.fitText(v1680, v1679 and "Last updated " .. v1679 or "Last updated at an unknown time", 99);

                            if p1673.DisplayReason ~= "" then
                                local v1681 = "Public reason: " .. p1673.DisplayReason;
                                local v1682 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.ContentPreview);
                                v1682.Visible = true;
                                v1682.Name = "Content";
                                v1682.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u10.fitText(v1682, v1681, 99);
                            end;

                            if p1673.PrivateReason ~= "" then
                                if u10.gameStaff(LocalPlayer) == "Mod" and DateTime.fromIsoDate(p1673.StartTime).UnixTimestampMillis < 1786508760121 then
                                    local string_split_ret = string.split(p1673.PrivateReason, " ");

                                    if string_split_ret[1] == "By" then
                                        string_split_ret[2] = "[HIDDEN]";
                                    end;

                                    p1673.PrivateReason = table.concat(string_split_ret, " ");
                                end;

                                local v1683 = "Private reason: " .. p1673.PrivateReason;
                                local v1684 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.ContentPreview);
                                v1684.Visible = true;
                                v1684.Name = "Content";
                                v1684.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u10.fitText(v1684, v1683, 99);
                            end;
                        end, function() -- Line: 10228
                            -- upvalues: u1668 (ref), u1649 (ref), createEndLabel (copy), u1586 (ref), PlayerFunc (ref), u1670 (ref), u1661 (ref), u1648 (ref), u1650 (ref), u1669 (ref), u10 (ref), GameStaffPanel (ref), u1647 (ref)
                            if u1668 then
                                return;
                            end;

                            if u1649 then
                                return createEndLabel();
                            end;

                            u1668 = true;
                            u1586.dynEntireTableLoaded = task.defer(function() -- Line: 10232
                                -- upvalues: PlayerFunc (ref), u1668 (ref), u1670 (ref), u1661 (ref), u1648 (ref), u1649 (ref), u1650 (ref), u1669 (ref), u10 (ref), GameStaffPanel (ref)
                                local v1685, v1686;

                                while true do
                                    local v1687;
                                    v1687, v1685, v1686 = pcall(function() -- Line: 10235
                                        -- upvalues: PlayerFunc (ref)
                                        return PlayerFunc:InvokeServer("clientGameStaff", "getPlayerBanHistory", {
                                            nextPage = true
                                        });
                                    end);

                                    if v1687 then
                                        break;
                                    end;

                                    task.wait(6);
                                end;

                                u1668 = false;

                                if u1670 ~= u1661 then
                                    return;
                                end;

                                if v1685 then
                                    for _, v in pairs(v1685) do
                                        table.insert(u1648, v);
                                    end;

                                    u1649 = v1686;
                                    u1650.dynSetTable(v1685, true);

                                    return;
                                end;

                                u1649 = true;

                                if u1669 then
                                    return;
                                end;

                                u1669 = true;
                                local v1688 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.EndPreview);
                                v1688.Visible = true;
                                v1688.Name = "End";
                                v1688.Text = "End of user ban history";
                                v1688.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u1650.limitYScrollListener();
                            end);
                            u1647.dynEntireTableLoaded = u1586.dynEntireTableLoaded;
                        end, u1648);
                    end;
                end));
                u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.PlayerDetails.ListName.Buttons.EncounteredPlayer, function() -- Line: 10260
                    -- upvalues: u1 (ref), u10 (ref), u1645 (ref), u1643 (copy), getStringDateFromDateTime (ref), activatePanelList (copy), GameStaffPanel (ref), u1650 (ref)
                    local v1690 = u1.mainBox({
                        case = "Text",
                        headline = "Provide the other player",
                        textPlaceholder = "Player",
                        acceptContent = "CHECK",

                        formatTextFunc = function(p1689) -- Line: 10261, Name: formatTextFunc
                            -- upvalues: u10 (ref)
                            return u10.toSimpleString(p1689);
                        end
                    });

                    if v1690 and (u1645 and u1643[u1645]) then
                        local id = u1643[u1645].id;

                        if u10.invokeTraffic.clientGameStaff then
                            return u1.notify({
                                message = "Please wait",
                                color = "gray"
                            });
                        end;

                        local v1691, v1692, v1693 = pcall(u10.invokeServerTraffic, "clientGameStaff", "getPlayerServerEncounters", {
                            playerId = id,
                            player2 = v1690
                        });

                        if not v1691 then
                            return u1.notify({
                                message = "Something went wrong. Try again",
                                color = "red"
                            });
                        end;

                        if u10.typeOf(v1692) == "table" then
                            local v1694 = {};

                            for _, v in pairs(v1692.encounters or {}) do
                                local v1695 = getStringDateFromDateTime(DateTime.fromUnixTimestamp(v[1]));
                                local v1696 = v[2] >= 60 and math.floor(v[2] / 60) .. "h " .. v[2] % 60 .. "m" or v[2] .. "m";
                                table.insert(v1694, (v[3] and "Currently in the same server for " or "In the same server for ") .. v1696 .. " • " .. (v1695 or "an unknown time"));
                            end;

                            local u1697 = nil;
                            activatePanelList("Same server encounters for user ID " .. id .. " and user ID " .. v1692.playerId2, function(p1698, p1699) -- Line: 10279
                                -- upvalues: u10 (ref), GameStaffPanel (ref)
                                local v1700 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.ContentPreview);
                                v1700.Visible = true;
                                v1700.Name = "Content";
                                v1700.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u10.fitText(v1700, p1699, 99);
                            end, function() -- Line: 10286
                                -- upvalues: u1697 (ref), u10 (ref), GameStaffPanel (ref), u1650 (ref)
                                if u1697 then
                                    return;
                                end;

                                u1697 = true;
                                local v1701 = u10.clone(GameStaffPanel.PanelList._ScrollingList.Scroll.EndPreview);
                                v1701.Visible = true;
                                v1701.Name = "End";
                                v1701.Text = "End of same server encounters";
                                v1701.Parent = GameStaffPanel.PanelList._ScrollingList.Scroll;
                                u1650.limitYScrollListener();
                            end, v1694);

                            return;
                        end;

                        if u10.typeOf(v1692) == "string" then
                            u1.notify({
                                message = v1692,
                                color = v1693 or "red"
                            });

                            return;
                        end;

                        u1.notify({
                            message = "Something went wrong. Try again",
                            color = "red"
                        });
                    end;
                end));

                local function updateModerationListGroups() -- Line: 10303
                    -- upvalues: GameStaffPanel (ref), u10 (ref)
                    GameStaffPanel.List._ScrollingList.Scroll.GroupOnServer.TextLabel.Text = "PLAYERS (" .. #u10.getLoadedPlayers() .. ")";
                    GameStaffPanel.List._ScrollingList.Scroll.GroupOnServerView.TextLabel.Text = GameStaffPanel.List._ScrollingList.Scroll.GroupOnServer.TextLabel.Text;
                end;

                local function createPlayerListGui(p1702, p1703, p1704) -- Line: 10307
                    -- upvalues: u1644 (copy), u10 (ref), GameStaffPanel (ref), u1643 (copy)
                    if not p1704 then
                        u1644[p1703] = u1644[p1703] + 1;
                    end;

                    local v1705 = u10.clone(GameStaffPanel.List._ScrollingList.Scroll.Preview);
                    u1643[v1705] = p1702;
                    v1705.TextLabel.Text = "@" .. p1702.name;
                    v1705.TextLabel.AutoLocalize = false;
                    v1705.Name = p1702.id;
                    v1705.LayoutOrder = p1704 or u1644[p1703];
                    v1705.Visible = true;
                    v1705.Parent = GameStaffPanel.List._ScrollingList.Scroll;

                    return v1705;
                end;

                local LoadedPlayers = u10.getLoadedPlayers();
                table.sort(LoadedPlayers, function(p1706, p1707) -- Line: 10322
                    return string.lower(p1706.Name) < string.lower(p1707.Name);
                end);

                for _, v in pairs(LoadedPlayers) do
                    local v1708 = {
                        name = v.Name,
                        id = v.UserId
                    };
                    u1644.onServer = u1644.onServer + 1;
                    local u1709 = u10.clone(GameStaffPanel.List._ScrollingList.Scroll.Preview);
                    u1643[u1709] = v1708;
                    u1709.TextLabel.Text = "@" .. v1708.name;
                    u1709.TextLabel.AutoLocalize = false;
                    u1709.Name = v1708.id;
                    u1709.LayoutOrder = u1644.onServer;
                    u1709.Visible = true;
                    u1709.Parent = GameStaffPanel.List._ScrollingList.Scroll;
                    u1709.Name = "OnServer-" .. u1709.Name;
                    listenToListElement(u1709, function() -- Line: 10326
                        -- upvalues: displayPlayerDetails (copy), u1709 (copy)
                        displayPlayerDetails(u1709);
                    end);
                end;

                if u1640 then
                    local v1710 = u1640;
                    u1644.view = u1644.view + 1;
                    local u1711 = u10.clone(GameStaffPanel.List._ScrollingList.Scroll.Preview);
                    u1643[u1711] = v1710;
                    u1711.TextLabel.Text = "@" .. v1710.name;
                    u1711.TextLabel.AutoLocalize = false;
                    u1711.Name = v1710.id;
                    u1711.LayoutOrder = u1644.view;
                    u1711.Visible = true;
                    u1711.Parent = GameStaffPanel.List._ScrollingList.Scroll;
                    u1711.Name = "View-" .. u1711.Name;
                    listenToListElement(u1711, function() -- Line: 10334
                        -- upvalues: displayPlayerDetails (copy), u1711 (copy)
                        displayPlayerDetails(u1711);
                    end)();
                end;

                GameStaffPanel.List._ScrollingList.Scroll.GroupView.Visible = u1640;
                GameStaffPanel.List._ScrollingList.Scroll.GroupOnServer.Visible = not u1640;
                GameStaffPanel.List._ScrollingList.Scroll.GroupOnServerView.Visible = u1640;
                u1642 = u10.scrollingListSystem(GameStaffPanel.List._ScrollingList.Scroll, 0.2, {
                    scrollBar = GameStaffPanel.List.ScrollBar
                });
                u10.buildSignalData(u1586, unpack(u1642.multipleSignalData));
                table.insert(u1586, u1642.cleanUp);
                local u1712 = u1642;
                local Scroll = GameStaffPanel.List._ScrollingList.Scroll;
                local u1713 = nil;
                createSearchBox(u1586, u1712, GameStaffPanel.List.Search, function(u1714) -- Line: 9834
                    -- upvalues: Scroll (copy), u1643 (copy), u1713 (copy), u1712 (copy)
                    for _, child in pairs(Scroll:GetChildren()) do
                        if u1643[child] and u1643[child].ban then
                            child:Destroy();
                            u1643[child] = nil;
                        end;
                    end;

                    if u1714 then
                        local function _(p1715) -- Line: 9842
                            -- upvalues: u1714 (copy)
                            if string.match(string.lower(p1715.name), u1714) or string.match(string.lower(p1715.id), u1714) then
                                return true;
                            end;
                        end;

                        for _, child in pairs(Scroll:GetChildren()) do
                            if u1643[child] then
                                if u1643[child].ban then
                                    child:Destroy();
                                    u1643[child] = nil;
                                else
                                    local v1716 = u1643[child];
                                    child.Visible = ((string.match(string.lower(v1716.name), u1714) or string.match(string.lower(v1716.id), u1714)) and true or nil) and true or false;
                                end;
                            end;
                        end;

                        if u1713 then
                            local v1717 = {};

                            for _, v in pairs(u1713) do
                                if (string.match(string.lower(v.name), u1714) or string.match(string.lower(v.id), u1714)) and true or nil then
                                    table.insert(v1717, v);
                                end;
                            end;

                            u1712.dynSetTable(v1717);
                        end;
                    elseif u1713 then
                        for _, child in pairs(Scroll:GetChildren()) do
                            if u1643[child] then
                                child.Visible = true;
                            end;
                        end;

                        u1712.dynSetTable(u1713);
                    end;
                end);
                GameStaffPanel.List._ScrollingList.Scroll.GroupOnServer.TextLabel.Text = "PLAYERS (" .. #u10.getLoadedPlayers() .. ")";
                GameStaffPanel.List._ScrollingList.Scroll.GroupOnServerView.TextLabel.Text = GameStaffPanel.List._ScrollingList.Scroll.GroupOnServer.TextLabel.Text;
            end));
        elseif p1639 == "Commands" then
            GameStaffPanel.Commands.Visible = true;
            u10.buildSignalData(u1586, u1.displayGuiDetails(GameStaffPanel.Commands.Info, "[player] - You can put incomplete name to find a player on the server, full name or user ID to find a player on the roblox platform, \"all\" to happen to everybody on the server\n\nRemove bans, mods and admins in the \"Moderation\" tab"));
            local v1718 = u10.scrollingListSystem(GameStaffPanel.Commands._ScrollingList.Scroll, 0.1, {
                scrollBar = GameStaffPanel.Commands.ScrollBar
            });
            u10.buildSignalData(u1586, unpack(v1718.multipleSignalData));
            table.insert(u1586, v1718.cleanUp);
        end;

        for _, child in pairs(GameStaffPanel.Buttons:GetChildren()) do
            if child:IsA("ImageButton") then
                u10.buildSignalData(u1586, u1.mouseButton(child, function() -- Line: 10356
                    -- upvalues: u1 (ref), child (copy)
                    u1.gameStaffPanel(child.Name);
                end));
            end;
        end;

        u10.buildSignalData(u1586, u10.buttonHoverSignalData(GameStaffPanel.Close));
        u10.buildSignalData(u1586, u1.mouseButton(GameStaffPanel.Close, function() -- Line: 10362
            -- upvalues: u1 (ref)
            u1.gameStaffPanel();
        end, {
            addMobileButton = true
        }));
    end;

    if v1641 then
        u10.guiTransition(GameStaffPanel, "Size", 0.9, p1639);
    end;
end;

local PrivateServerPanel = GlobalGui.Center.Middle.PrivateServerPanel;
PrivateServerPanel.Commands._ScrollingList.Scroll.List.AdminCommandWeather.Description.Text = GameRules.season == "Winter" and "/weather [clear/fog/snow/blizzard]" or "/weather [clear/fog/thunderstorm/windy]";
local u1719 = {
    modLogs = {},
    gameLogs = {},
    admin = {},
    mod = {},
    owner = {},
    ban = {}
};
local u1720 = { Color3.fromRGB(255, 255, 255), Color3.fromRGB(121, 208, 255), Color3.fromRGB(255, 130, 108) };
local u1721 = nil;
local u1722 = nil;
local u1723 = nil;

u234 = function(p1724, p1725, p1726, p1727) -- Line: 10378, Name: getPrivateServerConfigurationAsText
    -- upvalues: u10 (copy)
    local v1728 = u10.typeOf(u10.privateServerAvailableConfiguration[p1724].display) == "function" and not p1725 and u10.privateServerAvailableConfiguration[p1724].display() or (u10.typeOf(u10.privateServerAvailableConfiguration[p1724].display) == "table" and p1725 and u10.privateServerAvailableConfiguration[p1724].display[p1725] or (p1725 or u10.privateServerAvailableConfiguration[p1724].display));

    if not p1725 then
        return v1728;
    end;

    if u10.typeOf(u10.privateServerAvailableConfiguration[p1724].format) == "function" then
        return u10.privateServerAvailableConfiguration[p1724].format(v1728, p1726, p1727);
    end;

    return v1728 .. (u10.privateServerAvailableConfiguration[p1724].format and u10.privateServerAvailableConfiguration[p1724].format or "");
end;

function u1.updatePrivateServerCoreData(p1729, u1730) -- Line: 10388
    -- upvalues: LocalizationService (copy), u1719 (copy), u1721 (ref), GameRules (copy), u1723 (ref), u1722 (ref)
    local function registerLog(p1731, p1732) -- Line: 10389
        -- upvalues: LocalizationService (ref), u1719 (ref), u1721 (ref)
        local DateTime_fromUnixTimestamp_ret = DateTime.fromUnixTimestamp(p1731[2]);
        local v1733 = DateTime_fromUnixTimestamp_ret:FormatLocalTime("L", LocalizationService.RobloxLocaleId) .. " " .. DateTime_fromUnixTimestamp_ret:FormatLocalTime("LTS", LocalizationService.RobloxLocaleId);
        local v1734 = { p1731[1], v1733, p1731[3] };
        table.insert(u1719[p1732], 1, v1734);

        if u1721 then
            u1721(v1734, p1732);
        end;
    end;

    if p1729 ~= "set" then
        if p1729 == "addLog" then
            registerLog(u1730.log, u1730.logType);

            if #u1719[u1730.logType] > GameRules.maxPermissionAmounts[u1730.logType] then
                table.remove(u1719[u1730.logType]);

                return;
            end;
        elseif p1729 == "addPermissions" then
            if u1730.removeById then
                (function() -- Line: 10420, Name: run
                    -- upvalues: u1719 (ref), u1730 (copy)
                    for _, v in pairs({ "mod", "admin", "owner", "ban" }) do
                        local v1735 = v;

                        for i, v2 in pairs(u1719[v]) do
                            if v2.id == u1730.removeById then
                                table.remove(u1719[v1735], i);

                                return;
                            end;
                        end;
                    end;
                end)();

                if u1723 then
                    u1723(u1730.removeById);
                end;
            end;

            if u1730.addData then
                if u1730.addData.ban then
                    table.insert(u1719.ban, u1730.addData);
                    table.sort(u1719.ban, function(p1736, p1737) -- Line: 10433
                        return string.lower(p1736.name) < string.lower(p1737.name);
                    end);

                    if u1722 then
                        u1722(u1730.addData, "ban");

                        return;
                    end;
                elseif u1730.addData.serverStaff then
                    local v1738 = u1719[string.lower(u1730.addData.serverStaff)];
                    table.insert(v1738, u1730.addData);
                    table.sort(u1719[string.lower(u1730.addData.serverStaff)], function(p1739, p1740) -- Line: 10437
                        return string.lower(p1739.name) < string.lower(p1740.name);
                    end);

                    if u1722 then
                        u1722(u1730.addData, string.lower(u1730.addData.serverStaff));
                    end;
                end;
            end;
        end;

        return;
    end;

    u1719.modLogs = {};

    for i = #u1730.modLogs, 1, -1 do
        registerLog(u1730.modLogs[i], "modLogs");
        local _ = i;
    end;

    u1719.gameLogs = {};

    for i = #u1730.gameLogs, 1, -1 do
        registerLog(u1730.gameLogs[i], "gameLogs");
        local _ = i;
    end;

    for _, v in pairs({ "mod", "admin", "owner", "ban" }) do
        u1719[v] = {};
    end;

    for i, v in pairs(u1730.permissions) do
        v.id = i;

        if v.ban then
            table.insert(u1719.ban, v);
        elseif v.serverStaff then
            local v1741 = u1719[string.lower(v.serverStaff)];
            table.insert(v1741, v);
        end;
    end;

    for _, v in pairs({ "mod", "admin", "owner", "ban" }) do
        table.sort(u1719[v], function(p1742, p1743) -- Line: 10411
            return string.lower(p1742.name) < string.lower(p1743.name);
        end);
    end;
end;

function u1.privateServerPanel(p1744) -- Line: 10443
    -- upvalues: u1 (copy), u10 (copy), u1586 (copy), u1587 (ref), buttonVisual (copy), PrivateServerPanel (copy), u1721 (ref), LocalPlayer (copy), u1719 (copy), u1588 (copy), sharedDisplayPlayerDetails (copy), PlayerFunc (copy), listenToListElement (copy), u1723 (ref), u1722 (ref), createSearchBox (copy), Variables (copy), Stuff (copy), u234 (ref), u1720 (copy)
    if u1.openedGui and u1.openedGui ~= "PrivateServerPanel" then
        return;
    end;

    local v1745 = not (p1744 and u1.openedGui);
    u10.clearConnectionsAndThreads(u1586);

    if u1587 and u1587.Parent then
        buttonVisual(u1587);
    end;

    u1587 = nil;

    for _, child in pairs(PrivateServerPanel.Logs._ScrollingList.Scroll.List:GetChildren()) do
        if child:IsA("Frame") and child.Visible then
            child:Destroy();
        end;
    end;

    for _, child in pairs(PrivateServerPanel.List._ScrollingList.ModerationScroll:GetChildren()) do
        if child:IsA("ImageButton") and child.Visible then
            child:Destroy();
        end;
    end;

    u1721 = nil;

    if v1745 then
        u1.openGui(p1744 and "PrivateServerPanel", true, nil, true);
        u1.activateBlur("privateServerPanel", p1744);
        u10.lockScroll("privateServerPanel", p1744);
    end;

    if p1744 then
        table.insert(u1586, task.spawn(function() -- Line: 10464
            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref)
            while u10.serverStaff(LocalPlayer) do
                task.wait();
            end;

            return u1.privateServerPanel();
        end));

        local function visualButtons(p1746, p1747) -- Line: 10471
            for _, child in pairs(p1746:GetChildren()) do
                if child:IsA("ImageButton") then
                    child.ImageColor3 = Color3.fromRGB(115, 140, 173);
                    child.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end;

            p1746[p1747].ImageColor3 = Color3.fromRGB(255, 255, 255);
            p1746[p1747].TextLabel.TextColor3 = Color3.fromRGB(63, 63, 63);
        end;

        visualButtons(PrivateServerPanel.Buttons, p1744 == true and "Moderation" or p1744);
        local u1748 = nil;

        for _, v in pairs({ "Commands", "List", "Logs", "PlayerDetails", "Configuration", "Upgrades" }) do
            PrivateServerPanel[v].Visible = false;
        end;

        for _, child in pairs(PrivateServerPanel.List._ScrollingList.Scroll:GetChildren()) do
            if child.Name ~= "Preview" and child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        if p1744 == true or p1744 == "Moderation" then
            local u1749 = u10.deepCopyTable(u1719.ban);
            local u1750 = {};
            local u1751 = u10.deepCopyTable(u1588);
            local u1752 = nil;
            local u1753 = {};
            PrivateServerPanel.List.Visible = true;
            PrivateServerPanel.List._ScrollingList.Scroll.Visible = false;
            PrivateServerPanel.List._ScrollingList.ModerationScroll.Visible = true;

            local function u1761(u1754) -- Line: 10496
                -- upvalues: u10 (ref), u1753 (copy), PrivateServerPanel (ref), u1752 (ref), sharedDisplayPlayerDetails (ref), u1750 (copy), LocalPlayer (ref), PlayerFunc (ref), u1586 (ref)
                u10.clearConnectionsAndThreads(u1753);
                PrivateServerPanel.PlayerDetails.Visible = u1754;
                u1752 = u1754;

                if u1754 then
                    sharedDisplayPlayerDetails(u1753, PrivateServerPanel, u1754, u1750);
                    local v1755 = u1750[u1754].ban and u1750[u1754].ban[4];

                    if v1755 then
                        local v1756 = u1750[u1754].ban[4];
                        local GlobalHour = u10.getGlobalHour();
                        v1755 = v1756 - math.round(GlobalHour);
                    end;

                    if v1755 and v1755 < 0 then
                        u1750[u1754].ban = nil;
                        v1755 = nil;
                    end;

                    PrivateServerPanel.PlayerDetails.ListName.BanDetails.Visible = u1750[u1754].ban;
                    PrivateServerPanel.PlayerDetails.ListValue.BanDetails.Visible = u1750[u1754].ban;
                    PrivateServerPanel.PlayerDetails.ListName.BanLength.Visible = v1755;
                    PrivateServerPanel.PlayerDetails.ListValue.BanLength.Visible = v1755;

                    if u1750[u1754].ban and u1750[u1754].ban[2] then
                        PrivateServerPanel.PlayerDetails.ListValue.BanDetails.Text = "By " .. u1750[u1754].ban[2] .. (u1750[u1754].ban[1] and (": " .. u1750[u1754].ban[1] or "") or "");
                    end;

                    if v1755 then
                        PrivateServerPanel.PlayerDetails.ListValue.BanLength.Text = u1750[u1754].ban[3] .. " hours (" .. v1755 .. " hours left)";
                    end;

                    PrivateServerPanel.PlayerDetails.ListName.Buttons.Unban.Visible = u1750[u1754].ban and u1750[u1754].ban[2];
                    local v1757 = u10.serverStaff(LocalPlayer);
                    local v1758;

                    if v1757 == "ServerOwner" or v1757 == "ServerAdmin" then
                        v1758 = u1750[u1754].serverStaff == "Admin" and true or u1750[u1754].serverStaff == "Mod";
                    else
                        v1758 = false;
                    end;

                    PrivateServerPanel.PlayerDetails.ListName.Buttons.RemoveStaff.Visible = v1758;

                    if u1750[u1754].serverStaff == "Admin" or u1750[u1754].serverStaff == "Mod" then
                        PrivateServerPanel.PlayerDetails.ListName.Buttons.RemoveStaff.TextLabel.Text = u1750[u1754].serverStaff == "Admin" and "UNADMIN" or "UNMOD";
                    end;

                    PrivateServerPanel.PlayerDetails.ListValue.AccountAge.Text = "Loading...";
                    PrivateServerPanel.PlayerDetails.ListValue.Verified.Text = "Loading...";
                    PrivateServerPanel.PlayerDetails.ListValue.TimeInGame.Text = "Loading...";
                    PrivateServerPanel.PlayerDetails.ListValue.Reputation.Text = "Loading...";
                    table.insert(u1753, task.spawn(function() -- Line: 10523
                        -- upvalues: PlayerFunc (ref), u1750 (ref), u1754 (copy), PrivateServerPanel (ref), u10 (ref)
                        local v1759;

                        while true do
                            v1759 = PlayerFunc:InvokeServer("clientPrivateServer", "modGetPlayerFromDataStore", {
                                playerId = u1750[u1754].id
                            });

                            if v1759 then
                                break;
                            end;

                            task.wait(5);
                        end;

                        PrivateServerPanel.PlayerDetails.ListValue.AccountAge.Text = v1759.accountAge and (u10.getGlobalDay() - v1759.accountAge .. " days" or "-") or "-";
                        PrivateServerPanel.PlayerDetails.ListValue.Verified.Text = v1759.verified == 1 and "Email" or (v1759.verified == 2 and "ID/Phone" or "-");
                        PrivateServerPanel.PlayerDetails.ListValue.TimeInGame.Text = (v1759.timeInGame or "0") .. " Minutes";
                        PrivateServerPanel.PlayerDetails.ListValue.Reputation.Text = v1759.reputation or "1";
                    end));
                    table.insert(u1586, u1753[#u1753]);
                    PrivateServerPanel.PlayerDetails.ListName.StaffNote.Visible = false;
                    PrivateServerPanel.PlayerDetails.ListValue.StaffNote.Text = "";
                    PrivateServerPanel.PlayerDetails.ListValue.StaffNote.Visible = false;
                    PrivateServerPanel.PlayerDetails.ListValue.BanAmount.Text = "Loading...";
                    table.insert(u1753, task.spawn(function() -- Line: 10542
                        -- upvalues: PlayerFunc (ref), u1750 (ref), u1754 (copy), PrivateServerPanel (ref)
                        local v1760 = PlayerFunc:InvokeServer("clientPrivateServer", "modGetPlayerData", {
                            playerId = u1750[u1754].id
                        });
                        PrivateServerPanel.PlayerDetails.ListValue.BanAmount.Text = v1760 and (v1760.banAmount or "0") or "0";

                        if v1760 and v1760.staffNote then
                            PrivateServerPanel.PlayerDetails.ListValue.StaffNote.Text = v1760.staffNote;
                            PrivateServerPanel.PlayerDetails.ListName.StaffNote.Visible = true;
                            PrivateServerPanel.PlayerDetails.ListValue.StaffNote.Visible = true;
                        end;
                    end));
                    table.insert(u1586, u1753[#u1753]);
                end;
            end;

            local function u1762() -- Line: 10554
                -- upvalues: PrivateServerPanel (ref), u10 (ref), u1719 (ref)
                PrivateServerPanel.List._ScrollingList.ModerationScroll.GroupOnServer.TextLabel.Text = "PLAYERS (" .. #u10.getLoadedPlayers() .. ")";
                PrivateServerPanel.List._ScrollingList.ModerationScroll.GroupOwner.TextLabel.Text = "OWNERS (1)";
                PrivateServerPanel.List._ScrollingList.ModerationScroll.GroupAdmin.TextLabel.Text = "ADMINS (" .. #u1719.admin .. ")";
                PrivateServerPanel.List._ScrollingList.ModerationScroll.GroupBan.TextLabel.Text = "BANS (" .. #u1719.ban .. ")";
                PrivateServerPanel.List._ScrollingList.ModerationScroll.GroupMod.TextLabel.Text = "MODERATORS (" .. #u1719.mod .. ")";
            end;

            local function u1767(p1763, p1764, p1765) -- Line: 10561
                -- upvalues: u1751 (copy), u10 (ref), PrivateServerPanel (ref), u1750 (copy)
                if not p1765 then
                    u1751[p1764] = u1751[p1764] + 1;
                end;

                local v1766 = u10.clone(PrivateServerPanel.List._ScrollingList.Scroll.Preview);
                u1750[v1766] = p1763;
                v1766.TextLabel.Text = "@" .. p1763.name;
                v1766.AutoLocalize = false;
                v1766.Name = p1763.id;
                v1766.LayoutOrder = p1765 or u1751[p1764];
                v1766.Visible = true;
                v1766.Parent = PrivateServerPanel.List._ScrollingList.ModerationScroll;

                return v1766;
            end;

            local function onServerPlayerAdded(p1768) -- Line: 10575
                -- upvalues: u1751 (copy), u10 (ref), PrivateServerPanel (ref), u1750 (copy), listenToListElement (ref), u1761 (copy)
                local v1769 = {
                    name = p1768.Name,
                    id = p1768.UserId
                };
                u1751.onServer = u1751.onServer + 1;
                local u1770 = u10.clone(PrivateServerPanel.List._ScrollingList.Scroll.Preview);
                u1750[u1770] = v1769;
                u1770.TextLabel.Text = "@" .. v1769.name;
                u1770.AutoLocalize = false;
                u1770.Name = v1769.id;
                u1770.LayoutOrder = u1751.onServer;
                u1770.Visible = true;
                u1770.Parent = PrivateServerPanel.List._ScrollingList.ModerationScroll;
                u1770.Name = "OnServer-" .. u1770.Name;
                listenToListElement(u1770, function() -- Line: 10578
                    -- upvalues: u1761 (ref), u1770 (copy)
                    u1761(u1770);
                end);
            end;

            u10.loadedPlayerAdded(u10.buildSignalData, u1586, nil, function(p1771) -- Line: 10582
                -- upvalues: onServerPlayerAdded (copy), u1762 (copy), u1748 (ref)
                onServerPlayerAdded(p1771);
                u1762();
                u1748.limitYScrollListener();
            end);
            table.insert(u1586, game.Players.PlayerRemoving:Connect(function(p1772) -- Line: 10587
                -- upvalues: PrivateServerPanel (ref), u1750 (copy), u1762 (copy), u1748 (ref)
                local v1773 = PrivateServerPanel.List._ScrollingList.ModerationScroll:FindFirstChild("OnServer-" .. p1772.UserId);

                if v1773 then
                    v1773:Destroy();
                    u1750[v1773] = nil;
                    u1762();
                    u1748.limitYScrollListener();
                end;
            end));
            local LoadedPlayers = u10.getLoadedPlayers();
            table.sort(LoadedPlayers, function(p1774, p1775) -- Line: 10597
                return string.lower(p1774.Name) < string.lower(p1775.Name);
            end);

            for _, v in pairs(LoadedPlayers) do
                onServerPlayerAdded(v);
            end;

            u1723 = function(p1776) -- Line: 10602, Name: listenToRemoveModerationId
                -- upvalues: PrivateServerPanel (ref), u1750 (copy), u1762 (copy), u1748 (ref)
                local v1777 = PrivateServerPanel.List._ScrollingList.ModerationScroll:FindFirstChild(p1776);

                if v1777 then
                    v1777:Destroy();
                    u1750[v1777] = nil;
                end;

                u1762();
                u1748.limitYScrollListener();
            end;

            u1722 = function(p1778, p1779) -- Line: 10611, Name: listenToAddModerationData
                -- upvalues: u1767 (copy), u1588 (ref), listenToListElement (ref), u1761 (copy), u1762 (copy), u1748 (ref)
                local u1780 = u1767(p1778, p1779, u1588[p1779] - 1);
                listenToListElement(u1780, function() -- Line: 10613
                    -- upvalues: u1761 (ref), u1780 (copy)
                    u1761(u1780);
                end);
                u1762();
                u1748.limitYScrollListener();
            end;

            for _, v in pairs({ "mod", "admin", "owner" }) do
                local v1781 = v;

                for _, v2 in pairs(u1719[v]) do
                    u1751[v1781] = u1751[v1781] + 1;
                    local u1782 = u10.clone(PrivateServerPanel.List._ScrollingList.Scroll.Preview);
                    u1750[u1782] = v2;
                    u1782.TextLabel.Text = "@" .. v2.name;
                    u1782.AutoLocalize = false;
                    u1782.Name = v2.id;
                    u1782.LayoutOrder = u1751[v1781];
                    u1782.Visible = true;
                    u1782.Parent = PrivateServerPanel.List._ScrollingList.ModerationScroll;
                    listenToListElement(u1782, function() -- Line: 10622
                        -- upvalues: u1761 (copy), u1782 (copy)
                        u1761(u1782);
                    end);
                end;
            end;

            u1748 = u10.scrollingListSystem(PrivateServerPanel.List._ScrollingList.ModerationScroll, 0.2, {
                scrollBar = PrivateServerPanel.List.ScrollBar,

                dynamicallyLoadListElementsFromTable = function(p1783, p1784) -- Line: 10627, Name: dynamicallyLoadListElementsFromTable
                    -- upvalues: u1751 (copy), u10 (ref), PrivateServerPanel (ref), u1750 (copy), listenToListElement (ref), u1761 (copy)
                    u1751.ban = u1751.ban + 1;
                    local u1785 = u10.clone(PrivateServerPanel.List._ScrollingList.Scroll.Preview);
                    u1750[u1785] = p1784;
                    u1785.TextLabel.Text = "@" .. p1784.name;
                    u1785.AutoLocalize = false;
                    u1785.Name = p1784.id;
                    u1785.LayoutOrder = u1751.ban;
                    u1785.Visible = true;
                    u1785.Parent = PrivateServerPanel.List._ScrollingList.ModerationScroll;
                    listenToListElement(u1785, function() -- Line: 10629
                        -- upvalues: u1761 (ref), u1785 (copy)
                        u1761(u1785);
                    end);
                end
            });
            u10.buildSignalData(u1586, unpack(u1748.multipleSignalData));
            table.insert(u1586, u1748.cleanUp);
            u1748.dynSetTable(u1749);
            local u1786 = u1748;
            local ModerationScroll = PrivateServerPanel.List._ScrollingList.ModerationScroll;
            createSearchBox(u1586, u1786, PrivateServerPanel.List.Search, function(u1787) -- Line: 9834
                -- upvalues: ModerationScroll (copy), u1750 (copy), u1749 (copy), u1786 (copy)
                for _, child in pairs(ModerationScroll:GetChildren()) do
                    if u1750[child] and u1750[child].ban then
                        child:Destroy();
                        u1750[child] = nil;
                    end;
                end;

                if u1787 then
                    local function _(p1788) -- Line: 9842
                        -- upvalues: u1787 (copy)
                        if string.match(string.lower(p1788.name), u1787) or string.match(string.lower(p1788.id), u1787) then
                            return true;
                        end;
                    end;

                    for _, child in pairs(ModerationScroll:GetChildren()) do
                        if u1750[child] then
                            if u1750[child].ban then
                                child:Destroy();
                                u1750[child] = nil;
                            else
                                local v1789 = u1750[child];
                                child.Visible = ((string.match(string.lower(v1789.name), u1787) or string.match(string.lower(v1789.id), u1787)) and true or nil) and true or false;
                            end;
                        end;
                    end;

                    if u1749 then
                        local v1790 = {};

                        for _, v in pairs(u1749) do
                            if (string.match(string.lower(v.name), u1787) or string.match(string.lower(v.id), u1787)) and true or nil then
                                table.insert(v1790, v);
                            end;
                        end;

                        u1786.dynSetTable(v1790);
                    end;
                elseif u1749 then
                    for _, child in pairs(ModerationScroll:GetChildren()) do
                        if u1750[child] then
                            child.Visible = true;
                        end;
                    end;

                    u1786.dynSetTable(u1749);
                end;
            end);
            u1762();
            u10.buildSignalData(u1586, u1.mouseButton(PrivateServerPanel.PlayerDetails.ListName.Buttons.EditStaffNote, function() -- Line: 10642
                -- upvalues: Variables (ref), u10 (ref), PrivateServerPanel (ref), u1 (ref), u1761 (copy), u1752 (ref)
                if Variables.IsPrivateServer:GetAttribute("Upgrade_MoreConfiguration") then
                    if not u10.invokeTraffic.clientPrivateServer then
                        local Text = PrivateServerPanel.PlayerDetails.ListValue.Id.Text;
                        local v1792 = u1.mainBox({
                            case = "Text",
                            headline = "Make a note about this player for a future reference",
                            textCanBeEmpty = true,
                            textPlaceholder = "Note",
                            acceptContent = "CONFIRM",
                            startText = PrivateServerPanel.PlayerDetails.ListValue.StaffNote.Text,

                            formatTextFunc = function(p1791) -- Line: 10646, Name: formatTextFunc
                                return string.sub(p1791, 1, 50);
                            end
                        });

                        if v1792 then
                            local v1793 = u10.invokeServerTraffic("clientPrivateServer", "modPlayerNote", {
                                note = v1792,
                                targetId = Text
                            });

                            if v1793 == true then
                                u1.notify({
                                    message = "Success",
                                    color = "green"
                                });
                                u1761(u1752);

                                return;
                            end;

                            if u10.typeOf(v1793) == "string" then
                                u1.notify({
                                    color = "red",
                                    message = v1793
                                });
                            end;
                        end;
                    end;
                else
                    u1.notify({
                        message = "You need the <b>More Configuration</b> server upgrade",
                        color = "red"
                    });
                end;
            end));
            u10.buildSignalData(u1586, u1.mouseButton(PrivateServerPanel.PlayerDetails.ListName.Buttons.Unban, function() -- Line: 10657
                -- upvalues: u1752 (ref), u10 (ref), u1750 (copy), u1761 (copy), u1 (ref)
                if u1752 and (not u10.invokeTraffic.clientPrivateServer and u10.invokeServerTraffic("clientPrivateServer", "modUnban", {
                    playerId = u1750[u1752].id
                })) then
                    u1761();
                    u1.notify({
                        message = "Success",
                        color = "green"
                    });
                end;
            end));
            u10.buildSignalData(u1586, u1.mouseButton(PrivateServerPanel.PlayerDetails.ListName.Buttons.RemoveStaff, function() -- Line: 10666
                -- upvalues: u1752 (ref), u10 (ref), u1750 (copy), u1761 (copy), u1 (ref)
                if u1752 and (not u10.invokeTraffic.clientPrivateServer and u10.invokeServerTraffic("clientPrivateServer", "modRemoveStaff", {
                    playerId = u1750[u1752].id
                })) then
                    u1761();
                    u1.notify({
                        message = "Success",
                        color = "green"
                    });
                end;
            end));
        elseif p1744 == "Upgrades" then
            PrivateServerPanel.List.Visible = true;
            PrivateServerPanel.List._ScrollingList.Scroll.Visible = true;
            PrivateServerPanel.List._ScrollingList.ModerationScroll.Visible = false;
            local u1794 = nil;
            u10.buildSignalData(u1586, u1.mouseButton(PrivateServerPanel.Upgrades.Purchase, function() -- Line: 10680
                -- upvalues: u1794 (ref), PlayerFunc (ref), u1586 (ref), u1 (ref), u10 (ref)
                if u1794 then
                    local v1795 = PlayerFunc:InvokeServer("clientPrivateServer", "purchaseUpgrade", {
                        upgrade = u1794.Name
                    });

                    if v1795 == true then
                        u1586.developerProductListener = u1.createDeveloperProductListener(function() -- Line: 10684
                            -- upvalues: u1 (ref)
                            u1.privateServerPanel("Upgrades");
                        end);

                        return;
                    end;

                    if u10.typeOf(v1795) == "string" then
                        u1.notify({
                            color = "red",
                            message = v1795
                        });
                    end;
                end;
            end));
            createSearchBox(u1586, u1748, PrivateServerPanel.List.Search, function(p1796) -- Line: 10690
                -- upvalues: PrivateServerPanel (ref)
                for _, child in pairs(PrivateServerPanel.List._ScrollingList.Scroll:GetChildren()) do
                    if child.Name ~= "Preview" and child:IsA("ImageButton") then
                        child.Visible = not p1796 and true or string.find(string.lower(child.TextLabel.Text), p1796, nil, true);
                    end;
                end;
            end);
            local Children = Stuff.DeveloperProducts.PrivateServerUpgrades:GetChildren();
            table.sort(Children, function(p1797, p1798) -- Line: 10698
                return p1797.Name < p1798.Name;
            end);

            for _, v in pairs(Children) do
                local v1799 = u10.clone(PrivateServerPanel.List._ScrollingList.Scroll.Preview);
                v1799.Name = "Element";
                v1799.Visible = true;
                v1799.TextLabel.Text = v.Name;

                if Variables.IsPrivateServer:GetAttribute("Upgrade_" .. string.gsub(v.Name, "%s+", "")) then
                    v1799.Icons.Checkmark.Visible = true;
                end;

                v1799.Parent = PrivateServerPanel.List._ScrollingList.Scroll;
                listenToListElement(v1799, function() -- Line: 10706
                    -- upvalues: PrivateServerPanel (ref), v (copy), Variables (ref), u10 (ref), u1 (ref), u1794 (ref)
                    PrivateServerPanel.Upgrades.Visible = true;
                    PrivateServerPanel.Upgrades.Icon.Image = v.Image.Texture;
                    PrivateServerPanel.Upgrades.Headline.Text = v.Name;
                    PrivateServerPanel.Upgrades.Purchase.Visible = not Variables.IsPrivateServer:GetAttribute("Upgrade_" .. string.gsub(v.Name, "%s+", ""));
                    u10.fitText(PrivateServerPanel.Upgrades.Description, v.Description.Value, 8);
                    PrivateServerPanel.Upgrades.Purchase.TextLabel.Text = "PURCHASE " .. u1.getProductRobuxString(v) .. "";
                    u1794 = v;
                end);
            end;

            local v1800 = u10.scrollingListSystem(PrivateServerPanel.List._ScrollingList.Scroll, 0.3, {
                scrollBar = PrivateServerPanel.List.ScrollBar
            });
            u10.buildSignalData(u1586, unpack(v1800.multipleSignalData));
            table.insert(u1586, v1800.cleanUp);
        elseif p1744 == "Configuration" then
            PrivateServerPanel.Configuration.Visible = true;

            local function configurationSetting(p1801, p1802) -- Line: 10721
                -- upvalues: Variables (ref), PlayerFunc (ref)
                return p1802 and Variables.IsPrivateServer:GetAttribute(p1801) == "Secret" and PlayerFunc:InvokeServer("clientPrivateServer", "getSecret", {
                    property = p1801
                }) or Variables.IsPrivateServer:GetAttribute(p1801);
            end;

            local function refreshConfigurationValues() -- Line: 10728
                -- upvalues: PrivateServerPanel (ref), u10 (ref), u234 (ref), Variables (ref)
                for _, child in pairs(PrivateServerPanel.Configuration._ScrollingList.Scroll:GetChildren()) do
                    if child:IsA("ImageButton") then
                        if child:FindFirstChild("TextButton") or child:FindFirstChild("LongTextButton") then
                            local v1803 = child:FindFirstChild("TextButton") or child:FindFirstChild("LongTextButton");
                            local v1804 = u10.firstToLower(child.Name);
                            v1803.Content.Text = u10.cutTextBeyondBounds(v1803.Content, u234(v1804, Variables.IsPrivateServer:GetAttribute(v1804)));
                        elseif child:FindFirstChild("ChoiceButtons") then
                            local v1805 = u10.firstToLower(child.Name);
                            local Attribute = Variables.IsPrivateServer:GetAttribute(v1805);
                            local v1806 = u10.privateServerAvailableConfiguration[v1805].display[Attribute or "default"];

                            for _, child2 in pairs(child.ChoiceButtons:GetChildren()) do
                                if child2:IsA("ImageButton") then
                                    child2.Background.Visible = v1806 == child2.Name;
                                    child2.TextLabel.TextColor3 = v1806 == child2.Name and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
                                end;
                            end;
                        elseif child:FindFirstChild("ListButton") then
                            local v1807 = u10.firstToLower(child.Name);
                            local Attribute = Variables.IsPrivateServer:GetAttribute(v1807);
                            child.ListButton.Content.Text = u10.privateServerAvailableConfiguration[v1807].display[Attribute or "default"];
                        end;
                    end;
                end;
            end;

            for _, child in pairs(PrivateServerPanel.Configuration._ScrollingList.Scroll:GetChildren()) do
                if child:IsA("ImageButton") then
                    local u1808 = u10.firstToLower(child.Name);

                    if child:FindFirstChild("TextButton") or child:FindFirstChild("LongTextButton") then
                        local u1809 = child:FindFirstChild("TextButton") or child:FindFirstChild("LongTextButton");
                        u10.buildSignalData(u1586, u1.mouseButton(u1809, function() -- Line: 10759
                            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), u1748 (ref), u1809 (copy), u1808 (copy), Variables (ref), PlayerFunc (ref), refreshConfigurationValues (copy)
                            if not u10.invokeTraffic.clientPrivateServer then
                                if u10.serverStaff(LocalPlayer) ~= "ServerOwner" then
                                    return u1.notify({
                                        message = "You must be the server owner to configure this server",
                                        color = "red"
                                    });
                                end;

                                local u1810 = "";
                                u1748.freeze = true;
                                local mainBox = u1.mainBox;
                                local v1811 = {
                                    textCanBeEmpty = true,
                                    case = u1809.Name == "TextButton" and "Text" or "LongText",
                                    headline = u10.privateServerAvailableConfiguration[u1808].inputBoxHeadline
                                };
                                local v1812 = u1808;
                                v1811.startText = Variables.IsPrivateServer:GetAttribute(v1812) == "Secret" and PlayerFunc:InvokeServer("clientPrivateServer", "getSecret", {
                                    property = v1812
                                }) or Variables.IsPrivateServer:GetAttribute(v1812);

                                function v1811.formatTextFunc(p1813) -- Line: 10764
                                    -- upvalues: u10 (ref), u1808 (ref), u1810 (ref)
                                    if p1813 ~= "" and (p1813 ~= "0" and (p1813 ~= "0." and (p1813 ~= "0.0" and (p1813 ~= "0.00" and u10.privateServerAvailableConfiguration[u1808].isInvalid(p1813, true))))) then
                                        return u1810;
                                    end;

                                    u1810 = p1813;

                                    return p1813;
                                end;

                                local v1814 = mainBox(v1811);

                                if v1814 then
                                    local invokeServerTraffic = u10.invokeServerTraffic;
                                    local v1815 = {
                                        property = u1808
                                    };

                                    if v1814 == "" or (string.lower(v1814) == "none" or not v1814) then
                                        v1814 = nil;
                                    end;

                                    v1815.value = v1814;
                                    local v1816 = invokeServerTraffic("clientPrivateServer", "modifyConfig", v1815);

                                    if v1816 == true then
                                        u1.notify({
                                            message = "Success",
                                            color = "green"
                                        });
                                        refreshConfigurationValues();
                                    elseif u10.typeOf(v1816) == "string" then
                                        u1.notify({
                                            color = "red",
                                            message = v1816
                                        });
                                    end;
                                end;

                                u1748.freeze = false;
                            end;
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    elseif child:FindFirstChild("ChoiceButtons") then
                        for _, child2 in pairs(child.ChoiceButtons:GetChildren()) do
                            if child2:IsA("ImageButton") then
                                u10.buildSignalData(u1586, u1.mouseButton(child2, function() -- Line: 10781
                                    -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), u1808 (copy), child2 (copy), refreshConfigurationValues (copy)
                                    if not u10.invokeTraffic.clientPrivateServer then
                                        if u10.serverStaff(LocalPlayer) ~= "ServerOwner" then
                                            return u1.notify({
                                                message = "You must be the server owner to configure this server",
                                                color = "red"
                                            });
                                        end;

                                        local v1817 = nil;

                                        for i, v in pairs(u10.privateServerAvailableConfiguration[u1808].display) do
                                            if u10.typeOf(v) == "table" and child2.Name == v then
                                                v1817 = i;
                                                break;
                                            end;
                                        end;

                                        local invokeServerTraffic = u10.invokeServerTraffic;
                                        local v1818 = {
                                            property = u1808
                                        };

                                        if v1817 == "default" or not v1817 then
                                            v1817 = nil;
                                        end;

                                        v1818.value = v1817;
                                        local v1819 = invokeServerTraffic("clientPrivateServer", "modifyConfig", v1818);

                                        if v1819 == true then
                                            u1.notify({
                                                message = "Success",
                                                color = "green"
                                            });
                                            refreshConfigurationValues();

                                            return;
                                        end;

                                        if u10.typeOf(v1819) == "string" then
                                            u1.notify({
                                                color = "red",
                                                message = v1819
                                            });
                                        end;
                                    end;
                                end, {
                                    mobileButtonType = "MouseButton1Click"
                                }));
                            end;
                        end;
                    elseif child:FindFirstChild("ListButton") then
                        u10.buildSignalData(u1586, u1.mouseButton(child.ListButton, function() -- Line: 10798
                            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), u1808 (copy), Variables (ref), PlayerFunc (ref), u1748 (ref), refreshConfigurationValues (copy)
                            if not u10.invokeTraffic.clientPrivateServer then
                                if u10.serverStaff(LocalPlayer) ~= "ServerOwner" then
                                    return u1.notify({
                                        message = "You must be the server owner to configure this server",
                                        color = "red"
                                    });
                                end;

                                local v1820 = {};

                                for _, child2 in pairs(game.ReplicatedStorage.Gameplay.PrivateServers.Languages:GetChildren()) do
                                    if u10.privateServerAvailableConfiguration.language.display.default ~= child2.Name then
                                        table.insert(v1820, child2.Name);
                                    end;
                                end;

                                table.sort(v1820, function(p1821, p1822) -- Line: 10807
                                    return p1821 < p1822;
                                end);
                                table.insert(v1820, 1, u10.privateServerAvailableConfiguration.language.display.default);
                                local v1823 = nil;

                                for i, v in pairs(v1820) do
                                    local v1824 = u1808;

                                    if game.ReplicatedStorage.Gameplay.PrivateServers.Languages[v].DomainCode.Value == (Variables.IsPrivateServer:GetAttribute(v1824) == "Secret" and PlayerFunc:InvokeServer("clientPrivateServer", "getSecret", {
                                        property = v1824
                                    }) or Variables.IsPrivateServer:GetAttribute(v1824) or "us") then
                                        v1823 = i;
                                        break;
                                    end;
                                end;

                                u1748.freeze = true;
                                local v1825 = u1.mainBox({
                                    case = "List",
                                    headline = u10.privateServerAvailableConfiguration[u1808].inputBoxHeadline,
                                    list = v1820,
                                    startValue = v1823
                                });

                                if v1825 then
                                    local invokeServerTraffic = u10.invokeServerTraffic;
                                    local v1826 = {
                                        property = u1808
                                    };
                                    local v1827;

                                    if v1825 == 1 then
                                        v1827 = nil;
                                    else
                                        v1827 = game.ReplicatedStorage.Gameplay.PrivateServers.Languages[v1820[v1825]].DomainCode.Value or nil;
                                    end;

                                    v1826.value = v1827;
                                    local v1828 = invokeServerTraffic("clientPrivateServer", "modifyConfig", v1826);

                                    if v1828 == true then
                                        u1.notify({
                                            message = "Success",
                                            color = "green"
                                        });
                                        refreshConfigurationValues();
                                    elseif u10.typeOf(v1828) == "string" then
                                        u1.notify({
                                            color = "red",
                                            message = v1828
                                        });
                                    end;
                                end;

                                u1748.freeze = false;
                            end;
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    elseif child:FindFirstChild("ViewButton") then
                        u10.buildSignalData(u1586, u1.mouseButton(child.ViewButton, function() -- Line: 10829
                            -- upvalues: u10 (ref), LocalPlayer (ref), u1 (ref), u1748 (ref), u1808 (copy), u234 (ref), configurationSetting (copy)
                            if not u10.invokeTraffic.clientPrivateServer then
                                if u10.serverStaff(LocalPlayer) ~= "ServerOwner" then
                                    return u1.notify({
                                        message = "You must be the server owner to configure this server",
                                        color = "red"
                                    });
                                end;

                                u1748.freeze = true;
                                u1.mainBox({
                                    case = "LongText",
                                    lockEdit = true,
                                    acceptContent = "CLOSE",
                                    headline = u10.privateServerAvailableConfiguration[u1808].inputBoxHeadline,
                                    startText = u234(u1808, configurationSetting(u1808, true))
                                });
                                u1748.freeze = false;
                            end;
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    elseif child:FindFirstChild("ExpandList") then
                        u10.buildSignalData(u1586, u1.mouseButton(child, function() -- Line: 10838
                            -- upvalues: child (copy), u1748 (ref)
                            local v1829 = not child.ExpandList:GetChildren()[1].Value.Visible;

                            for _, child2 in pairs(child.ExpandList:GetChildren()) do
                                child2.Value.Visible = v1829;
                            end;

                            u1748.limitYScrollListener();
                        end, {
                            mobileButtonType = "MouseButton1Click"
                        }));
                    end;
                end;
            end;

            createSearchBox(u1586, u1748, PrivateServerPanel.Configuration.Search, function(p1830) -- Line: 10846
                -- upvalues: PrivateServerPanel (ref)
                for _, child in pairs(PrivateServerPanel.Configuration._ScrollingList.Scroll:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.Visible = not p1830 and true or string.find(string.lower(child.Headline.Text), p1830, nil, true);
                    end;
                end;
            end);
            local v1831 = u10.scrollingListSystem(PrivateServerPanel.Configuration._ScrollingList.Scroll, 0.2, {
                scrollBar = PrivateServerPanel.Configuration.ScrollBar
            });
            u10.buildSignalData(u1586, unpack(v1831.multipleSignalData));
            table.insert(u1586, v1831.cleanUp);
            refreshConfigurationValues();
        elseif p1744 == "Commands" then
            PrivateServerPanel.Commands.Visible = true;
            u10.buildSignalData(u1586, u1.displayGuiDetails(PrivateServerPanel.Commands.Info, "[player] - You can put incomplete name to find a player on the server, full name or user ID to find a player on the Roblox platform, \"all\" to happen to everybody on the server\n\nRemove bans, mods and admins in the \"Moderation\" tab"));
            local v1832 = u10.scrollingListSystem(PrivateServerPanel.Commands._ScrollingList.Scroll, 0.1, {
                scrollBar = PrivateServerPanel.Commands.ScrollBar
            });
            u10.buildSignalData(u1586, unpack(v1832.multipleSignalData));
            table.insert(u1586, v1832.cleanUp);
        elseif p1744 == "Logs" then
            PrivateServerPanel.Logs.Visible = true;
            local u1833 = nil;

            local function createLog(p1834, p1835) -- Line: 10867
                -- upvalues: u10 (ref), PrivateServerPanel (ref), u1720 (ref)
                local v1836 = u10.clone(PrivateServerPanel.Logs._ScrollingList.Scroll.List.LogPreview);
                v1836.Name = "Log";
                v1836.Text.Text = p1835[1];
                v1836.Time.Text = p1835[2];
                v1836.LayoutOrder = p1834;

                if p1835[3] then
                    v1836.Text.TextColor3 = u1720[p1835[3]];
                end;

                v1836.Visible = true;
                v1836.Parent = PrivateServerPanel.Logs._ScrollingList.Scroll.List;
            end;

            local u1839 = u10.scrollingListSystem(PrivateServerPanel.Logs._ScrollingList.Scroll, 0.2, {
                scrollBar = PrivateServerPanel.Logs.ScrollBar,

                dynamicallyLoadListElementsFromTable = function(p1837, p1838) -- Line: 10877, Name: dynamicallyLoadListElementsFromTable
                    -- upvalues: createLog (copy)
                    createLog(p1837, p1838);
                end
            });
            u10.buildSignalData(u1586, unpack(u1839.multipleSignalData));
            table.insert(u1586, u1839.cleanUp);
            createSearchBox(u1586, u1839, PrivateServerPanel.Logs.Search, function(p1840) -- Line: 10883
                -- upvalues: PrivateServerPanel (ref), u1833 (ref), u1839 (ref)
                for _, child in pairs(PrivateServerPanel.Logs._ScrollingList.Scroll.List:GetChildren()) do
                    if child:IsA("Frame") and child.Visible then
                        child:Destroy();
                    end;
                end;

                if not p1840 then
                    u1839.dynSetTable(u1833);

                    return;
                end;

                local v1841 = {};

                for _, v in pairs(u1833) do
                    if string.match(string.lower(v[1]), p1840) or string.match(string.lower(v[2]), p1840) then
                        table.insert(v1841, v);
                    end;
                end;

                u1839.dynSetTable(v1841);
            end);

            local function loadList(u1842) -- Line: 10899
                -- upvalues: PrivateServerPanel (ref), visualButtons (copy), createLog (copy), u1839 (ref), u1721 (ref), u1833 (ref), u10 (ref), u1719 (ref)
                for _, child in pairs(PrivateServerPanel.Logs._ScrollingList.Scroll.List:GetChildren()) do
                    if child:IsA("Frame") and child.Visible then
                        child:Destroy();
                    end;
                end;

                PrivateServerPanel.Logs.Search.TextBoxFrame.TextBox.Text = "";
                visualButtons(PrivateServerPanel.Logs.Buttons, u1842);
                local u1843 = 0;

                u1721 = function(p1844, p1845) -- Line: 10906, Name: listenToCreateLog
                    -- upvalues: u1842 (copy), u1843 (ref), createLog (ref), u1839 (ref)
                    if u1842 == p1845 then
                        u1843 = u1843 - 1;
                        createLog(u1843, p1844);
                        u1839.limitYScrollListener();
                    end;
                end;

                u1833 = u10.deepCopyTable(u1719[u10.firstToLower(u1842)]);
                u1839.dynSetTable(u1833);
            end;

            loadList("ModLogs");

            for _, child in pairs(PrivateServerPanel.Logs.Buttons:GetChildren()) do
                if child:IsA("ImageButton") then
                    u10.buildSignalData(u1586, u1.mouseButton(child, function() -- Line: 10919
                        -- upvalues: loadList (copy), child (copy)
                        loadList(child.Name);
                    end));
                end;
            end;
        end;

        for _, child in pairs(PrivateServerPanel.Buttons:GetChildren()) do
            if child:IsA("ImageButton") then
                u10.buildSignalData(u1586, u1.mouseButton(child, function() -- Line: 10927
                    -- upvalues: u1 (ref), child (copy)
                    u1.privateServerPanel(child.Name);
                end));
            end;
        end;

        u10.buildSignalData(u1586, u10.buttonHoverSignalData(PrivateServerPanel.Close));
        u10.buildSignalData(u1586, u1.mouseButton(PrivateServerPanel.Close, function() -- Line: 10933
            -- upvalues: u1 (ref)
            u1.privateServerPanel();
        end, {
            addMobileButton = true
        }));
    end;

    if v1745 then
        u10.guiTransition(PrivateServerPanel, "Size", 0.9, p1744);
    end;
end;

local u1846 = u1.initiateIdleAnimationCFrame();
local u1847 = { game.ReplicatedStorage.Gameplay.NPC.Animations.Idle };

local function railwaySingularLight(p1848, p1849) -- Line: 10944
    p1848.Color = p1849 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(126, 49, 49);
    p1848.Material = p1849 and Enum.Material.Neon or Enum.Material.SmoothPlastic;
end;

local function railwayLight(u1850) -- Line: 10948
    -- upvalues: railwaySingularLight (copy), u1 (copy), u10 (copy)
    u1850.PrimaryPart.Sound:Play();
    local task_defer_ret = task.defer(function() -- Line: 10950
        -- upvalues: railwaySingularLight (ref), u1850 (copy)
        while true do
            for i = 1, 2 do
                railwaySingularLight(u1850["Light" .. i], true);
                local v1851 = u1850["Light" .. 3 - i];
                v1851.Color = Color3.fromRGB(126, 49, 49);
                v1851.Material = Enum.Material.SmoothPlastic;
                task.wait(0.7);
                local _ = i;
            end;
        end;
    end);

    u1.scriptedObjects[u1850] = function(p1852) -- Line: 10959
        -- upvalues: u10 (ref), task_defer_ret (copy)
        u10.taskCancel(task_defer_ret);
    end;
end;

local function railwayCrossing(p1853) -- Line: 10962
    -- upvalues: u10 (copy), railwayLight (copy), u1 (copy)
    local Value = p1853.RailwayCrossing.Value;

    if u10.requestsFlow(nil, Value, p1853.Active.Value and 1 or -1) == (p1853.Active.Value and 1 or nil) then
        Value.Active.Value = p1853.Active.Value;

        if Value.Active.Value then
            for _, child in pairs(Value:GetChildren()) do
                if child:IsA("Model") then
                    railwayLight(child);
                end;
            end;

            return;
        end;

        for _, child in pairs(Value:GetChildren()) do
            if child:IsA("Model") then
                if u1.scriptedObjects[child] then
                    u1.scriptedObjects[child]();
                end;

                local v1854 = child["Light" .. 1];
                v1854.Color = Color3.fromRGB(126, 49, 49);
                v1854.Material = Enum.Material.SmoothPlastic;
                local v1855 = child["Light" .. 2];
                v1855.Color = Color3.fromRGB(126, 49, 49);
                v1855.Material = Enum.Material.SmoothPlastic;
                child.PrimaryPart.Sound:Stop();
            end;
        end;
    end;
end;

function u1.spawnTrain(p1856) -- Line: 10982
    -- upvalues: u10 (copy), GameRules (copy), railwayCrossing (copy)
    local route = p1856.route;
    local u1857 = u10.clone(game.ReplicatedStorage.Gameplay.Train.Locomotive);
    u1857.PrimaryPart.Sound:Play();
    local u1858 = { 0 };
    local u1859 = {};

    for i = 2, #route:GetChildren() do
        u1858[i] = u1858[i - 1] + (route[i].Position - route[i - 1].Position).Magnitude / GameRules.trainStudsPerSecond;
        local _ = i;
    end;

    task.spawn(function() -- Line: 10992
        -- upvalues: u10 (ref), u1857 (copy), u1859 (copy)
        u10.refreshObjCreate(u1857, true, 800);
        local task_wait_ret = task.wait();

        while #u1859 > 0 do
            local v1860 = u10.refreshObj(u1857);

            for i, v in pairs(u1859) do
                if v(task_wait_ret, v1860) then
                    table.remove(u1859, i);
                end;
            end;

            task_wait_ret = task.wait();
        end;

        u10.refreshObjCreate(u1857, false);
    end);

    local function spawnTrailer(u1861, u1862, u1863) -- Line: 11006
        -- upvalues: route (copy), u1858 (copy), railwayCrossing (ref)
        local Vector3_new_ret3 = Vector3.new(0, u1861.PrimaryPart.Size.Y / 2, 0);
        u1861:PivotTo(route[1].CFrame + Vector3_new_ret3);
        u1861.Parent = workspace.World.Interactive;
        local u1864 = 1;
        local u1865 = nil;
        local u1866 = nil;
        local u1867 = route[1].CFrame - route[1].Position;
        local u1868 = nil;

        return function(p1869, p1870) -- Line: 11015
            -- upvalues: u1862 (ref), u1865 (ref), u1858 (ref), u1864 (ref), u1861 (copy), route (ref), u1866 (ref), u1868 (ref), u1863 (copy), railwayCrossing (ref), u1867 (ref), Vector3_new_ret3 (copy)
            u1862 = u1862 + p1869;

            while not u1865 or u1862 >= u1858[u1864] do
                u1864 = u1864 + 1;

                if u1864 > #u1858 then
                    u1861:Destroy();

                    return true;
                end;

                u1865 = route[u1864 - 1].Position;
                u1866 = route[u1864].Position - u1865;
                u1868 = route[u1864].CFrame - route[u1864].Position;

                if u1863 and route[u1864 - 1]:FindFirstChild("RailwayCrossing") then
                    railwayCrossing(route[u1864 - 1]);
                end;
            end;

            u1867 = u1867:Lerp(u1868, 1 - 0.1 ^ p1869);

            if u1862 > 0 and p1870 then
                u1861:PivotTo(CFrame.new(u1865 + u1866 * ((u1862 - u1858[u1864 - 1]) / (u1858[u1864] - u1858[u1864 - 1])) + Vector3_new_ret3) * u1867);
            end;
        end;
    end;

    table.insert(p1856.trailers, 1, u1857);
    local v1871 = 0;

    for i, v in pairs(p1856.trailers) do
        if i > 1 then
            v1871 = v1871 + (p1856.trailers[i - 1].PrimaryPart.Rear.Position.Z - v.PrimaryPart.Front.Position.Z) / GameRules.trainStudsPerSecond;
        end;

        local v1872;

        if i > 1 then
            v1872 = u10.clone(v) or v;
        else
            v1872 = v;
        end;

        local v1873 = spawnTrailer(v1872, -v1871, i == 1);
        table.insert(u1859, v1873);
    end;
end;

local u1874 = {};
local u1875 = {};

local function lightColor(p1876, p1877) -- Line: 11045
    for _, v in pairs({ "Green", "Orange", "Red" }) do
        p1876[v].Transparency = p1877 == v and 0 or 1;
    end;
end;

local function updateTrafficLight(p1878, p1879, p1880) -- Line: 11051
    -- upvalues: u1874 (copy), lightColor (copy)
    if not u1874[p1879] then
        local v1881;

        if p1880 == nil then
            v1881 = "Orange";
        elseif p1878.Parent.Parent.Name % 2 == 0 then
            v1881 = p1880 and "Green" or "Red";
        else
            v1881 = p1880 and "Red" or "Green";
        end;

        lightColor(p1878, v1881);
    end;
end;

function u1.faultyTrafficLights(p1882) -- Line: 11055
    -- upvalues: u1874 (copy), u1875 (copy), lightColor (copy), u1 (copy)
    u1874[p1882] = true;

    while p1882:GetAttribute("Faulty") do
        for i, v in pairs(u1875) do
            if v == p1882 then
                lightColor(i, "Orange");
            end;
        end;

        task.wait(1.5);

        for i, v in pairs(u1875) do
            if v == p1882 then
                lightColor(i);
            end;
        end;

        task.wait(1.5);
    end;

    u1874[p1882] = nil;

    for i, v in pairs(u1875) do
        if v == p1882 then
            local trafficSignal = u1.trafficSignal;

            if not u1874[v] then
                local v1883;

                if trafficSignal == nil then
                    v1883 = "Orange";
                elseif i.Parent.Parent.Name % 2 == 0 then
                    v1883 = trafficSignal and "Green" or "Red";
                else
                    v1883 = trafficSignal and "Red" or "Green";
                end;

                lightColor(i, v1883);
            end;
        end;
    end;
end;

for _, child in pairs(workspace.World.Interactive.Intersections:GetChildren()) do
    if child:GetAttribute("Faulty") then
        task.spawn(u1.faultyTrafficLights, child);
    end;
end;

function u1.switchTrafficLights(p1884) -- Line: 11068
    -- upvalues: u1 (copy), u1875 (copy), u1874 (copy), lightColor (copy)
    u1.trafficSignal = nil;

    for i, v in pairs(u1875) do
        if i.Green.Transparency == 0 and not u1874[v] then
            lightColor(i, "Orange");
        end;
    end;

    task.wait(2);
    u1.trafficSignal = p1884;

    for i, v in pairs(u1875) do
        if i.Orange.Transparency == 0 then
            local trafficSignal = u1.trafficSignal;

            if not u1874[v] then
                local v1885;

                if trafficSignal == nil then
                    v1885 = "Orange";
                elseif i.Parent.Parent.Name % 2 == 0 then
                    v1885 = trafficSignal and "Green" or "Red";
                else
                    v1885 = trafficSignal and "Red" or "Green";
                end;

                lightColor(i, v1885);
            end;
        else
            local trafficSignal = u1.trafficSignal;

            if not u1874[v] then
                local v1886;

                if trafficSignal == nil then
                    v1886 = "Orange";
                elseif i.Parent.Parent.Name % 2 == 0 then
                    v1886 = trafficSignal and "Green" or "Red";
                else
                    v1886 = trafficSignal and "Red" or "Green";
                end;

                lightColor(i, v1886);
            end;
        end;
    end;
end;

u1.farmhouses = {};
local v1887 = {
    Chicken = { "rbxassetid://126398418234261", "rbxassetid://102537352398974", "rbxassetid://128126719531289" },
    Sheep = { "rbxassetid://122691521830438", "rbxassetid://87096607361903" },
    Cow = { "rbxassetid://86411640942093", "rbxassetid://128111924970227" }
};

local function resetAnimalCFrame(p1888, p1889, p1890) -- Line: 11093
    -- upvalues: u10 (copy)
    local v1891 = math.random() * 3.141592653589793 * 2;
    p1888.PrimaryPart.BodyGyro.CFrame = CFrame.Angles(0, v1891, 0);
    p1888:PivotTo(u10.randomPointInArea(p1889.CFrame, p1889.Size) * CFrame.Angles(0, v1891, 0) + Vector3.new(0, p1890.Y / 2, 0));
end;

for _, child in pairs(game.ReplicatedStorage.Gameplay.Farm.Farmhouses:GetChildren()) do
    local u1892 = game.ReplicatedStorage.Gameplay.Farm.Animals[child.Name];
    local _, u1893 = u1892:GetBoundingBox();
    local u1894 = child.Size + Vector3.new(5, 0, 5);
    u1.farmhouses[child] = {};
    local u1895 = child;

    for i = 1, child.Population.Value do
        local v1896 = u10.clone(u1892);

        if v1887[v1896.Name] then
            v1896.MeshPart.TextureID = v1887[v1896.Name][math.random(#v1887[v1896.Name])];
        end;

        resetAnimalCFrame(v1896, u1895, u1893);
        table.insert(u1.farmhouses[u1895], v1896);
        v1896.Parent = workspace.Gameplay.Entities;
        u10.animationBuffer(v1896.AnimationController.Animator, "load", v1896.AnimationController.Idle, v1896.AnimationController.Walk);
        local _ = i;
    end;

    local u1897 = 0;
    local u1898 = false;

    local function movement(p1899) -- Line: 11113
        -- upvalues: u1898 (ref), u1897 (ref), u1 (copy), u1895 (copy), u10 (copy), u1892 (copy), u1894 (copy), resetAnimalCFrame (copy), u1893 (copy)
        u1898 = p1899;
        u1897 = (u1897 + 1) % 100;
        local u1900 = u1897;

        if p1899 then
            for _, v in pairs(u1.farmhouses[u1895]) do
                u10.animationBuffer(v.AnimationController.Animator, "play", "Idle", nil, nil, v.AnimationController.Idle.PlaybackSpeed.Value);
                v.PrimaryPart.Anchored = false;
                task.delay(math.random() * 10, function() -- Line: 11121
                    -- upvalues: u1900 (copy), u1897 (ref), u10 (ref), v (copy), u1895 (ref), u1892 (ref)
                    while u1900 == u1897 do
                        u10.animationBuffer(v.AnimationController.Animator, "play", "Walk", 0.25, nil, v.AnimationController.Walk.PlaybackSpeed.Value);
                        v.PrimaryPart.BodyVelocity.MaxForce = Vector3.new(4000, 50, 4000);
                        u10.walkNPC({
                            nonHumanoid = true,
                            npc = v,
                            walkTo = u10.randomPointInArea(u1895.CFrame, u1895.Size).Position,
                            studsPerSecond = u1892.Speed.Value
                        });
                        v.PrimaryPart.BodyVelocity.MaxForce = Vector3.new(1000, 50, 1000);
                        u10.animationBuffer(v.AnimationController.Animator, "stop", "Walk", 0.25);
                        task.wait(math.random(5, 12));
                    end;

                    if u1900 + 1 == u1897 then
                        v.PrimaryPart.Anchored = true;
                    end;
                end);
                task.delay(math.random() * 15, function() -- Line: 11132
                    -- upvalues: u1900 (copy), u1897 (ref), u10 (ref), u1895 (ref), u1894 (ref), v (copy), resetAnimalCFrame (ref), u1893 (ref)
                    while u1900 == u1897 do
                        if not u10.isPointInArea(u1895.CFrame, u1894, (Vector3.new(v.PrimaryPart.Position.X, u1895.Position.Y, v.PrimaryPart.Position.Z))) or v.PrimaryPart.Position.Y < u1895.Position.Y then
                            resetAnimalCFrame(v, u1895, u1893);
                        end;

                        v.PrimaryPart.Sound.PlaybackSpeed = math.random(80, 120) / 100;
                        v.PrimaryPart.Sound:Play();
                        task.wait(math.random(11, 20));
                    end;
                end);
            end;

            return;
        end;

        for _, v in pairs(u1.farmhouses[u1895]) do
            u10.animationBuffer(v.AnimationController.Animator, "stop", "Idle");
            u10.animationBuffer(v.AnimationController.Animator, "stop", "Walk");
        end;
    end;

    task.defer(function() -- Line: 11148
        -- upvalues: workspace_CurrentCamera (copy), u1895 (copy), u1898 (ref), movement (copy)
        while true do
            local v1901 = (workspace_CurrentCamera.CFrame.Position - u1895.Position).Magnitude < 750;

            if v1901 ~= u1898 then
                movement(v1901);
            end;

            task.wait(u1898 and 1 or 5);
        end;
    end);
end;

local CFrame2 = game.ReplicatedStorage.Gameplay:WaitForChild("CrimeArcadeSetupVanCFrame").CFrame;
local u1902 = nil;

function u1.arcadeSetupVanFunc() -- Line: 11160
    -- upvalues: u1902 (ref), u1 (copy), u10 (copy), CFrame2 (copy)
    if u1902 and u1902.Parent then
        u1902:Destroy();
        u1902 = nil;
    end;

    if u1.readPlayerData("Miscellaneous", "crimeArcadeSetup") then
        u1902 = u10.clone(u10.availableItems.Special["Chevrolet G3500 2016 Satellites"]);
        u1902:PivotTo(CFrame2);
        u10.setVehicleAnchored(u1902, true);
        u10.loadVehicleCustomization(u1902, {
            Color = Color3.fromRGB(163, 162, 165),
            LicensePlate = u10.getRandomNumberOrLetter(4)
        });
        u10.setVehicleSeats(u1902, false);
        u1902.Parent = workspace.Gameplay.Entities;
    end;
end;

u1.arcadeSetupVanFunc();
local BirdSpawner = game.ReplicatedStorage.Gameplay.BirdSpawner;
local u1903 = BirdSpawner.PrimaryPart.CFrame - BirdSpawner.PrimaryPart.Position;
BirdSpawner.Parent = workspace.Gameplay.Entities;
task.defer(function() -- Line: 11180
    -- upvalues: workspace_CurrentCamera (copy), BirdSpawner (copy), u1903 (copy), u2 (copy)
    while true do
        if workspace_CurrentCamera.CFrame.Position.Y > -35 then
            if not BirdSpawner.PrimaryPart.ParticleEmitter.Enabled then
                BirdSpawner.PrimaryPart.ParticleEmitter.Enabled = true;
            end;

            BirdSpawner:PivotTo(CFrame.new(workspace_CurrentCamera.CFrame.Position) * u1903 + Vector3.new(0, 150, 0) + (u2.root and Vector3.new(u2.root.AssemblyLinearVelocity.X, 0, u2.root.AssemblyLinearVelocity.Z) * 5 or Vector3.new()));
        elseif BirdSpawner.PrimaryPart.ParticleEmitter.Enabled then
            BirdSpawner.PrimaryPart.ParticleEmitter.Enabled = false;
        end;

        task.wait(5);
    end;
end);

local function changeAd(p1904, p1905) -- Line: 11196
    -- upvalues: workspace_CurrentCamera (copy)
    if (workspace_CurrentCamera.CFrame.Position - p1904.Parent.Position).magnitude < 1000 then
        for i = 0, 1, 0.03 do
            p1904.ImageLabel.ImageTransparency = i;
            task.wait(0.03);
            local _ = i;
        end;

        p1904.ImageLabel.Image = p1905;

        for i = 1, 0, -0.03 do
            p1904.ImageLabel.ImageTransparency = i;
            task.wait(0.03);
            local _ = i;
        end;
    end;
end;

local function mover(u1906, p1907, u1908, p1909) -- Line: 11210
    -- upvalues: u10 (copy), workspace_CurrentCamera (copy), u1 (copy)
    local u1910;

    if u1906:IsA("Weld") then
        u1910 = u1906.Parent or u1906;
    else
        u1910 = u1906;
    end;

    u10.refreshObjCreate(u1910, true, u1906:GetAttribute("Distance") or 400);
    local Attribute = u1906:GetAttribute("Distance");
    local u1911 = (u1906:GetAttribute("Refresh") or 0) / 100;
    local u1912 = u1906:GetAttribute("Speed") and (u1906:GetAttribute("Speed") / 100 or 0.01) or 0.01;
    local u1913 = 0;
    local u1914, u1915;

    if u1906:IsA("Weld") then
        u1914 = function() -- Line: 11220, Name: getCFrame
            -- upvalues: u1906 (copy)
            return u1906.C0;
        end;

        u1915 = function(p1916) -- Line: 11221, Name: setCFrame
            -- upvalues: u1906 (copy)
            u1906.C0 = p1916;
        end;
    else
        u1914 = function() -- Line: 11223, Name: getCFrame
            -- upvalues: u1906 (copy)
            return u1906:GetPivot();
        end;

        u1915 = function(p1917) -- Line: 11224, Name: setCFrame
            -- upvalues: u1906 (copy)
            u1906:PivotTo(p1917);
        end;
    end;

    local u1918 = u1906:GetAttribute("StartCF") or u1914();
    local u1919 = nil;
    local u1920 = 0;

    if p1907 == "Mover" then
        if not u1906:GetAttribute("StartCF") then
            u1906:SetAttribute("StartCF", u1918);
        end;

        local u1921 = { u1918 };
        local l_pairs = pairs;
        local v1922;

        if u1906:IsA("Model") then
            v1922 = u1906.PrimaryPart or u1906;
        else
            v1922 = u1906;
        end;

        for _, child in l_pairs(v1922:GetChildren()) do
            if child:IsA("Attachment") then
                local v1923 = tonumber(child.Name) + 1;
                local v1924;

                if u1906:IsA("Model") then
                    v1924 = u1906.PrimaryPart or u1906;
                else
                    v1924 = u1906;
                end;

                u1921[v1923] = u1918 * v1924[tonumber(child.Name)].CFrame;
            end;
        end;

        table.insert(u1921, u1918);
        local u1925 = #u1921 - 1;

        u1919 = function(p1926) -- Line: 11237, Name: run
            -- upvalues: u1913 (ref), u1912 (copy), u1925 (copy), u10 (ref), u1910 (copy), u1915 (ref), u1921 (copy)
            u1913 = (u1913 + u1912 * p1926 * 0.1) % u1925;

            if u10.refreshObj(u1910) then
                u1915(u1921[math.floor(u1913 + 1)]:Lerp(u1921[math.floor(u1913 + 1) + 1], u1913 % 1));
            end;
        end;
    elseif p1907 == "Rotator" then
        local u1927;

        if u1906:GetAttribute("RotatorAxis") == "X" then
            u1927 = function() -- Line: 11244, Name: rotatorAxis
                -- upvalues: u1913 (ref)
                return CFrame.Angles(u1913, 0, 0);
            end;
        elseif u1906:GetAttribute("RotatorAxis") == "Z" then
            u1927 = function() -- Line: 11246, Name: rotatorAxis
                -- upvalues: u1913 (ref)
                return CFrame.Angles(0, 0, u1913);
            end;
        else
            u1927 = function() -- Line: 11248, Name: rotatorAxis
                -- upvalues: u1913 (ref)
                return CFrame.Angles(0, u1913, 0);
            end;
        end;

        u1919 = function(p1928) -- Line: 11250, Name: run
            -- upvalues: u1908 (copy), u1918 (ref), u1914 (ref), u1913 (ref), u1912 (copy), u10 (ref), u1910 (copy), u1915 (ref), u1927 (ref)
            if u1908 then
                u1918 = CFrame.new(u1914().Position) * (u1918 - u1918.Position);
            end;

            u1913 = (u1913 + u1912 * p1928) % 6.283185307179586;

            if u10.refreshObj(u1910) then
                u1915(u1918 * u1927());
            end;
        end;
    end;

    local function run2(p1929) -- Line: 11256
        -- upvalues: Attribute (copy), workspace_CurrentCamera (ref), u1910 (copy), u1919 (ref)
        if not Attribute or (workspace_CurrentCamera.CFrame.Position - u1910:GetPivot().Position).magnitude < Attribute * 7 then
            u1919(p1929);

            return true;
        end;
    end;

    local u1930;

    if p1909 then
        u1930 = nil;
    else
        u1930 = task.spawn(function() -- Line: 11264
            -- upvalues: u1920 (ref), Attribute (copy), workspace_CurrentCamera (ref), u1910 (copy), u1919 (ref), u1911 (copy)
            while true do
                local v1931 = u1920;
                local v1932;

                if Attribute and (workspace_CurrentCamera.CFrame.Position - u1910:GetPivot().Position).magnitude >= Attribute * 7 then
                    v1932 = nil;
                else
                    u1919(v1931);
                    v1932 = true;
                end;

                if not v1932 then
                    u1920 = 0;
                    task.wait(5);
                end;

                u1920 = task.wait(u1911);
            end;
        end);
    end;

    u1.scriptedObjects[u1906] = function(p1933) -- Line: 11271
        -- upvalues: u1930 (ref), u10 (ref), u1910 (copy)
        if u1930 then
            u10.taskCancel(u1930);
        end;

        u10.refreshObjCreate(u1910, false);
    end;

    return run2;
end;

local u1934 = {
    Day = {},
    Rest = {}
};
local u1935 = true;

local function checkEmitters(p1936, p1937) -- Line: 11280
    for i, v in pairs(p1936) do
        if (i.Parent.Position - p1937).Magnitude < v then
            if not i.Enabled then
                i.Enabled = true;
            end;
        elseif i.Enabled then
            i.Enabled = false;
        end;
    end;
end;

task.spawn(function() -- Line: 11289
    -- upvalues: u1 (copy), u1935 (ref), u1934 (copy), u2 (copy), checkEmitters (copy)
    local Vector3_new_ret3 = Vector3.new();

    while true do
        local v1938;

        if u1.isDay == u1935 then
            v1938 = Vector3_new_ret3;
        else
            u1935 = u1.isDay;
            v1938 = Vector3.new();

            if not u1935 then
                for i, _ in pairs(u1934.Day) do
                    i.Enabled = false;
                end;
            end;
        end;

        Vector3_new_ret3 = u2.root and u2.root.Position;

        if Vector3_new_ret3 and (v1938 - Vector3_new_ret3).Magnitude > 70 then
            if u1935 then
                checkEmitters(u1934.Day, Vector3_new_ret3);
            end;

            checkEmitters(u1934.Rest, Vector3_new_ret3);
        else
            Vector3_new_ret3 = v1938;
        end;

        task.wait(1);
    end;
end);
u1.roleplayScenes = {};

local function updateCombatModeIconPosition(p1939, p1940) -- Line: 11312
    -- upvalues: u10 (copy)
    while p1939.Parent.AbsoluteSize.X == 0 do
        task.wait();

        if not p1940.Parent then
            return;
        end;
    end;

    p1939.Position = UDim2.fromScale(0.54 + u10.getTextBounds(p1939.Parent).X / p1939.Parent.AbsoluteSize.X / 2, 0.5);
end;

u1.nameDisplays = {};

function u1.refreshNameDisplay(u1941) -- Line: 11318
    -- upvalues: u1 (copy), u10 (copy), LocalPlayer (copy), updateCombatModeIconPosition (copy), u11 (copy), u12 (ref), workspace_CurrentCamera (copy)
    if u1.scriptedObjects[u1941] then
        u1.scriptedObjects[u1941].cleanUp(u1941);
    end;

    u1.scriptedObjects[u1941] = {
        cleanUp = function(p1942) -- Line: 11321, Name: cleanUp
            -- upvalues: u1 (ref), u10 (ref)
            for i, v in pairs(u1.scriptedObjects[p1942].connectionsThreads) do
                if u10.typeOf(v) == "table" then
                    u10.clearConnectionsAndThreads(v);
                    u1.scriptedObjects[p1942].connectionsThreads[i] = nil;
                end;
            end;

            u10.clearConnectionsAndThreads(u1.scriptedObjects[p1942].connectionsThreads);
            u1.nameDisplays[p1942] = nil;
        end,

        connectionsThreads = {}
    };
    local Parent = u1941.Parent.Parent;
    table.insert(u1.scriptedObjects[u1941].connectionsThreads, task.defer(function() -- Line: 11334
        -- upvalues: u10 (ref), Parent (copy), u1941 (copy), u1 (ref), LocalPlayer (ref), updateCombatModeIconPosition (ref), u11 (ref), u12 (ref), workspace_CurrentCamera (ref)
        local PlayerFromCharacter = u10.getPlayerFromCharacter(Parent, 60);

        if PlayerFromCharacter and u1941.Parent then
            local v1943 = PlayerFromCharacter:GetAttribute("Incognito") or PlayerFromCharacter.DisplayName .. (u1.readPlayerData("Settings", "UsernamesVisible") and PlayerFromCharacter.DisplayName ~= PlayerFromCharacter.Name and (" (@" .. PlayerFromCharacter.Name .. ")" or "") or "");
            u1941.Nickname.TextLabel.Text = v1943;
            u1941.Nickname.Text = v1943;
            u1941.Arrested.Visible = PlayerFromCharacter:GetAttribute("Arrested") == LocalPlayer.UserId;
            local Family = u1941.Nickname.Family;
            local Family2 = u1941.Point.Family;
            table.insert(u1.scriptedObjects[u1941].connectionsThreads, task.defer(function() -- Line: 11344
                -- upvalues: u1941 (ref), updateCombatModeIconPosition (ref), Family (copy), u10 (ref)
                u1941.MaxDistance = (1 / 0);
                updateCombatModeIconPosition(u1941.Nickname.CombatMode, u1941);
                Family.Position = UDim2.fromScale(0.47 - u10.getTextBounds(Family.Parent).X / Family.Parent.AbsoluteSize.X / 2, 0.5);
                u1941.MaxDistance = game.ReplicatedStorage.PlayerStuff._NameDisplay.MaxDistance;
            end));
            u11[Family] = true;
            u11[Family2] = true;

            if u12 then
                u12(Family);
            end;

            if u12 then
                u12(Family2);
            end;

            u1.scriptedObjects[Family] = function(p1944) -- Line: 11354
                -- upvalues: u11 (ref)
                u11[p1944] = nil;
            end;

            u1.scriptedObjects[Family2] = function(p1945) -- Line: 11355
                -- upvalues: u11 (ref)
                u11[p1945] = nil;
            end;

            local u1946 = false;

            local function hoverShowName(p1947) -- Line: 11358
                -- upvalues: u1946 (ref), u10 (ref), Parent (ref)
                if p1947 ~= u1946 then
                    u1946 = p1947;
                    u10.setNameDisplayLook(Parent, p1947);
                end;
            end;

            local MaxDistance = game.ReplicatedStorage.PlayerStuff._NameDisplay.MaxDistance;
            table.insert(u1.scriptedObjects[u1941].connectionsThreads, task.defer(function() -- Line: 11365
                -- upvalues: workspace_CurrentCamera (ref), Parent (ref), MaxDistance (copy), u10 (ref), PlayerFromCharacter (copy), u1941 (ref), u1 (ref), u1946 (ref)
                while true do
                    while (workspace_CurrentCamera.CFrame.Position - Parent.PrimaryPart.Position).Magnitude >= MaxDistance or not u10.getVehicleInfo.inVehicle(PlayerFromCharacter) do
                        if u1946 then
                            if u10.getVehicleInfo.inVehicle(PlayerFromCharacter) and u1946 ~= false then
                                u1946 = false;
                                u10.setNameDisplayLook(Parent, false);
                            end;

                            u1946 = false;
                        end;

                        task.wait(2);
                    end;

                    local v1948 = workspace_CurrentCamera:WorldToViewportPoint((u1941.Adornee and u1941.Adornee.Position or u1941.Parent.Position) + (u1941:GetAttribute("VehicleStudsOffset") or u1941:GetAttribute("OriginalStudsOffset")));
                    local v1949 = u10.isInFrame(u1941.HoverMouse, nil, nil, Vector2.new(v1948.X, v1948.Y - u1.guiInset) - u1941.HoverMouse.AbsoluteSize / 2) and true or false;

                    if v1949 ~= u1946 then
                        u1946 = v1949;
                        u10.setNameDisplayLook(Parent, v1949);
                    end;

                    task.wait(v1949 and 1 or 0.2);
                end;
            end));
        end;
    end));
    u1.nameDisplays[u1941] = true;
end;

u1.healNpcs = {};
u1.updateUIViewportMaxScale = {};
local u2043 = {
    _AdAuto = function(u1950) -- Line: 11395, Name: _AdAuto
        -- upvalues: changeAd (copy), u1 (copy), u10 (copy)
        local task_defer_ret = task.defer(function() -- Line: 11396
            -- upvalues: u1950 (copy), changeAd (ref)
            local ImageLabel = u1950:WaitForChild("ImageLabel");
            local Children = game.ReplicatedStorage.Gameplay.Ads[u1950.Parent.Name]:GetChildren();
            ImageLabel.Image = Children[math.random(#Children)].Texture;
            task.wait(15 + math.random() * 15);

            while true do
                changeAd(u1950, Children[math.random(#Children)].Texture);
                task.wait(15 + math.random() * 15);
            end;
        end);

        u1.scriptedObjects[u1950] = function(p1951) -- Line: 11407
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _Chassis = function(p1952) -- Line: 11409, Name: _Chassis
        -- upvalues: u1 (copy), u10 (copy), u3 (copy)
        if p1952.Parent.Parent == workspace.Gameplay.Vehicles then
            u1.scriptedObjects[p1952.Parent] = {
                cleanUp = function(p1953) -- Line: 11412, Name: cleanUp
                    -- upvalues: u1 (ref), u10 (ref)
                    for i, v in pairs(u1.scriptedObjects[p1953].connectionsThreads) do
                        if u10.typeOf(v) == "table" then
                            u10.clearConnectionsAndThreads(v);
                            u1.scriptedObjects[p1953].connectionsThreads[i] = nil;
                        end;
                    end;

                    u10.clearConnectionsAndThreads(u1.scriptedObjects[p1953].connectionsThreads);
                end,

                connectionsThreads = {}
            };
            u3.loadVehicle(p1952.Parent, u1.scriptedObjects[p1952.Parent].connectionsThreads);
        end;
    end,

    _GlassLight = function(p1954) -- Line: 11426, Name: _GlassLight
        -- upvalues: u1106 (ref), u1 (copy)
        u1106.glassLight[p1954] = true;
        setGlass(p1954, u1.isDay);

        u1.scriptedObjects[p1954] = function(p1955) -- Line: 11429
            -- upvalues: u1106 (ref)
            u1106.glassLight[p1955] = nil;
        end;
    end,

    _Neon1 = function(p1956) -- Line: 11431, Name: _Neon1
        -- upvalues: u1106 (ref), u1 (copy)
        if not p1956:IsDescendantOf(workspace.Gameplay) then
            u1106.neon1[p1956] = true;
            p1956.Material = u1.isDay and Enum.Material.SmoothPlastic or Enum.Material.Neon;

            u1.scriptedObjects[p1956] = function(p1957) -- Line: 11435
                -- upvalues: u1106 (ref)
                u1106.neon1[p1957] = nil;
            end;
        end;
    end,

    _Neon2 = function(p1958) -- Line: 11438, Name: _Neon2
        -- upvalues: u1106 (ref), u1 (copy)
        if not p1958:IsDescendantOf(workspace.Gameplay) then
            u1106.neon2[p1958] = true;
            p1958.Transparency = u1.isDay and 1 or 0;

            u1.scriptedObjects[p1958] = function(p1959) -- Line: 11442
                -- upvalues: u1106 (ref)
                u1106.neon2[p1959] = nil;
            end;
        end;
    end,

    _Light = function(p1960) -- Line: 11445, Name: _Light
        -- upvalues: u1 (copy), u1106 (ref)
        if not p1960:IsDescendantOf(workspace.Gameplay) then
            local Light = p1960:WaitForChild("Light", 5);

            if Light and p1960.Parent then
                Light.Enabled = not u1.isDay;
                p1960.Material = u1.isDay and Enum.Material.SmoothPlastic or Enum.Material.Neon;
                u1106.lights[p1960] = true;

                u1.scriptedObjects[p1960] = function(p1961) -- Line: 11452
                    -- upvalues: u1106 (ref)
                    u1106.lights[p1961] = nil;
                end;
            end;
        end;
    end,

    _LightInside = function(p1962) -- Line: 11456, Name: _LightInside
        -- upvalues: u1 (copy), u1106 (ref)
        local Light = p1962:WaitForChild("Light", 5);

        if Light and p1962.Parent then
            Light.Enabled = not u1.isDay;
            p1962.Transparency = u1.isDay and 1 or 0;
            u1106.lightsInside[p1962] = true;

            u1.scriptedObjects[p1962] = function(p1963) -- Line: 11462
                -- upvalues: u1106 (ref)
                u1106.lightsInside[p1963] = nil;
            end;
        end;
    end,

    _Blinker = function(u1964) -- Line: 11465, Name: _Blinker
        -- upvalues: u10 (copy), workspace_CurrentCamera (copy), u1 (copy)
        if not u10.waitForAllObjectReferences(u1964) then
            return;
        end;

        local Attribute = u1964:GetAttribute("Distance");
        local u1965 = u1964:GetAttribute("Speed") and (u1964:GetAttribute("Speed") / 100 or 2) or 2;
        local Attribute2 = u1964:GetAttribute("Flash");
        local u1966 = false;
        local u1967;

        if u1964:GetAttribute("Type") == "Light" then
            u1967 = function() -- Line: 11473, Name: set
                -- upvalues: u1964 (copy), u1966 (ref)
                u1964:GetChildren()[1].Enabled = u1966;
            end;
        elseif u1964:GetAttribute("Type") == "Visibility" then
            local Transparency = u1964.Transparency;

            u1967 = function() -- Line: 11476, Name: set
                -- upvalues: u1964 (copy), u1966 (ref), Transparency (copy)
                u1964.Transparency = u1966 and Transparency or 1;
            end;
        else
            u1967 = function() -- Line: 11478, Name: set
                -- upvalues: u1964 (copy), u1966 (ref)
                u1964.Material = u1966 and Enum.Material.Neon or Enum.Material.SmoothPlastic;
            end;
        end;

        local task_defer_ret = task.defer(function() -- Line: 11480
            -- upvalues: Attribute (copy), workspace_CurrentCamera (ref), u1964 (copy), u1966 (ref), u1967 (ref), Attribute2 (copy), u1965 (copy)
            while true do
                if Attribute and (workspace_CurrentCamera.CFrame.Position - u1964.Position).magnitude >= Attribute then
                    task.wait(5);
                else
                    u1966 = not u1966;
                    u1967();
                end;

                task.wait(Attribute2 and u1966 and 0.09 or u1965);
            end;
        end);

        u1.scriptedObjects[u1964] = function(p1968) -- Line: 11489
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _Counter = function(u1969) -- Line: 11491, Name: _Counter
        -- upvalues: workspace_CurrentCamera (copy), u10 (copy), u1 (copy)
        local Attribute = u1969:GetAttribute("Distance");
        local u1972 = u1969:GetAttribute("Type") == "Timer" and function(p1970) -- Line: 11495, Name: format
            return string.format("%02d:%02d", math.floor(p1970 / 60), (math.floor(p1970 % 60)));
        end or function(p1971) -- Line: 11497, Name: format
            return p1971;
        end;
        local task_defer_ret = task.defer(function() -- Line: 11499
            -- upvalues: Attribute (copy), workspace_CurrentCamera (ref), u1969 (copy), u1972 (ref), u10 (ref)
            while true do
                if Attribute and (workspace_CurrentCamera.CFrame.Position - u1969.Position).magnitude >= Attribute then
                    task.wait(5);
                else
                    local Attribute2 = u1969:GetAttribute("StartTime");
                    local Attribute3 = u1969:GetAttribute("EndTime");

                    if Attribute2 then
                        local v1973 = u10.getDistributedGameTime() - Attribute2;
                        u1969.Text = u1972((math.floor(v1973)));
                    elseif Attribute3 then
                        local v1974 = Attribute3 - u10.getDistributedGameTime();
                        u1969.Text = u1972((math.floor(v1974)));
                    end;
                end;

                task.wait(1);
            end;
        end);

        u1.scriptedObjects[u1969] = function(p1975) -- Line: 11510
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _Rotator = function(p1976) -- Line: 11512, Name: _Rotator
        -- upvalues: u10 (copy), mover (copy)
        if not u10.waitForAllObjectReferences(p1976) then
            return;
        end;

        mover(p1976, "Rotator");
    end,

    _Mover = function(p1977) -- Line: 11516, Name: _Mover
        -- upvalues: u10 (copy), mover (copy)
        if not u10.waitForAllObjectReferences(p1977) then
            return;
        end;

        mover(p1977, "Mover");
    end,

    _Balloon = function(u1978, p1979) -- Line: 11520, Name: _Balloon
        -- upvalues: u10 (copy), u1 (copy)
        if p1979 then
            u1978.Model:ScaleTo(0.01);
            task.spawn(u10.customTweenService, u1978.Model, 40, 0.2, "linear", 0.01, 1, {
                updateChanges = function(p1980) -- Line: 11523, Name: updateChanges
                    -- upvalues: u1978 (copy)
                    u1978.Model:ScaleTo(p1980);
                end
            });
        end;

        local u1981 = math.random() * 359;
        local CFrame3 = u1978.Center.CFrame;
        u1978.Model:PivotTo(CFrame3 + Vector3.new(1300, 0, 0));

        if math.random(2) == 1 then
            u1978.Center.CFrame = u1978.Center.CFrame * CFrame.Angles(3.141592653589793, 0, 3.141592653589793);
        end;

        local u1982 = false;
        local task_defer_ret = task.defer(function() -- Line: 11529
            -- upvalues: u1982 (ref), u1978 (copy), u10 (ref), u1981 (ref), CFrame3 (copy)
            while true do
                if not u1982 and u1978.Name == "Destroying" then
                    u1982 = true;
                    task.defer(function() -- Line: 11533
                        -- upvalues: u10 (ref), u1978 (ref)
                        u10.customTweenService(u1978.Model, 40, 0.2, "linear", 1, 0.01, {
                            updateChanges = function(p1983) -- Line: 11534, Name: updateChanges
                                -- upvalues: u1978 (ref)
                                u1978.Model:ScaleTo(p1983);
                            end
                        });

                        if u1978.Parent then
                            u1978:Destroy();
                        end;
                    end);
                end;

                u1981 = u1981 + 0.0006;
                u1978:PivotTo(CFrame3 * CFrame.Angles(0, u1981, 0));
                task.wait(0.2);
            end;
        end);

        u1.scriptedObjects[u1978] = function(p1984) -- Line: 11543
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _AirVehicle = function(u1985) -- Line: 11545, Name: _AirVehicle
        -- upvalues: mover (copy), u10 (copy)
        local CFrame3 = u1985.Center.CFrame;
        local Value = u1985.StartTime.Value;
        local Value2 = u1985.Speed.Value;
        local u1986 = {};
        local u1987 = 0;

        for _, child in pairs(u1985:GetChildren()) do
            if child.Name == "Propeller" then
                local v1988 = mover(child.Rotator, "Rotator", true, true);
                table.insert(u1986, v1988);
            end;
        end;

        task.spawn(function() -- Line: 11552
            -- upvalues: u1985 (copy), u10 (ref), Value (copy), CFrame3 (copy), Value2 (copy), u1986 (copy), u1987 (ref)
            while u1985.Parent do
                local v1989 = u10.getDistributedGameTime() - Value;
                u1985:PivotTo(CFrame3 + CFrame3.LookVector * v1989 * Value2);

                for _, v in pairs(u1986) do
                    v(u1987);
                end;

                u1987 = task.wait(0.03);
            end;
        end);
    end,

    _Flag = function(p1990) -- Line: 11561, Name: _Flag
        -- upvalues: workspace_CurrentCamera (copy), u1 (copy), u10 (copy)
        local u1991 = p1990:FindFirstChild("Distance") and p1990.Distance.Value;
        local Flag = p1990.Flag;
        local task_defer_ret = task.defer(function() -- Line: 11564
            -- upvalues: workspace_CurrentCamera (ref), Flag (copy), u1991 (copy)
            while true do
                while (workspace_CurrentCamera.CFrame.Position - Flag[1].Position).magnitude < u1991 do
                    for i = 1, 16 do
                        Flag[i - 1 == 0 and 16 or i - 1].Transparency = 1;
                        Flag[i].Transparency = 0;
                        task.wait(0.06);
                        local _ = i;
                    end;
                end;

                task.wait(5);
            end;
        end);

        u1.scriptedObjects[p1990] = function(p1992) -- Line: 11575
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _TrafficLight = function(p1993) -- Line: 11577, Name: _TrafficLight
        -- upvalues: u1 (copy), u1874 (copy), lightColor (copy), u1875 (copy)
        local trafficSignal = u1.trafficSignal;

        if not u1874[p1993.Parent.Parent.Parent] then
            local v1994;

            if trafficSignal == nil then
                v1994 = "Orange";
            elseif p1993.Parent.Parent.Name % 2 == 0 then
                v1994 = trafficSignal and "Green" or "Red";
            else
                v1994 = trafficSignal and "Red" or "Green";
            end;

            lightColor(p1993, v1994);
        end;

        u1875[p1993] = p1993.Parent.Parent.Parent;

        u1.scriptedObjects[p1993] = function(p1995) -- Line: 11580
            -- upvalues: u1875 (ref)
            u1875[p1995] = nil;
        end;
    end,

    _Hawk = function(p1996) -- Line: 11582, Name: _Hawk
        -- upvalues: u1 (copy), u10 (copy)
        local RedtailHawk = p1996.RedtailHawk;
        local task_defer_ret = task.defer(function() -- Line: 11584
            -- upvalues: RedtailHawk (ref)
            while true do
                RedtailHawk.Sound:Play();
                task.wait(math.random(30, 120));
            end;
        end);

        u1.scriptedObjects[RedtailHawk] = function(p1997) -- Line: 11590
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _RaceJoinZone = function(u1998) -- Line: 11592, Name: _RaceJoinZone
        -- upvalues: u2 (copy), u10 (copy), LocalPlayer (copy), u1 (copy)
        local ActiveRace = game.ReplicatedStorage.Gameplay.Races.ActiveRace;
        local u1999 = u1998.Visual.Size.X / 2;
        local u2000 = false;
        local u2001 = false;
        local task_defer_ret = task.defer(function() -- Line: 11596
            -- upvalues: u2 (ref), u1998 (copy), u1999 (copy), u10 (ref), LocalPlayer (ref), u2001 (ref), ActiveRace (copy), u2000 (ref), u1 (ref)
            while true do
                if u2.root then
                    local v2002;

                    if (u2.root.Position - u1998.Center.Position).Magnitude < u1999 then
                        v2002 = u10.getVehicleInfo.controlledVehicle(LocalPlayer);
                    else
                        v2002 = false;
                    end;

                    if u2001 and (u2001 == "full" and #ActiveRace.RacersTable:GetChildren() < ActiveRace.Participants.Max.Value) or u2001 == "team" and LocalPlayer.Team.Name == "Civilian" then
                        u2000 = false;
                        u2001 = false;
                    end;

                    if u2000 ~= v2002 and not u10.invokeTraffic.raceCase then
                        local v2003, v2004 = u10.invokeServerTraffic("raceCase", v2002 and "join" or "leave", {
                            expectedStatus = "Open"
                        });
                        u2001 = v2004;

                        if v2003 == true then
                            u1998.Center.BillboardGui.Joined.Visible = v2002;
                            u1998.Center.BillboardGui.Background.ImageColor3 = v2002 and Color3.fromRGB(40, 56, 39) or Color3.fromRGB(36, 36, 36);

                            if v2002 then
                                local function didAnybodyJoinTheRace() -- Line: 11610
                                    -- upvalues: LocalPlayer (ref)
                                    for _, child in pairs(game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:GetChildren()) do
                                        if child.Value ~= LocalPlayer then
                                            return true;
                                        end;
                                    end;
                                end;

                                u1.autoDecisionInviteToJoinActivity("Race", "🏁 Come and join me in the " .. ActiveRace.Value.Name .. " race!", function() -- Line: 11615
                                    -- upvalues: LocalPlayer (ref)
                                    local v2005 = nil;

                                    for _, child in pairs(game.ReplicatedStorage.Gameplay.Races.ActiveRace.RacersTable:GetChildren()) do
                                        if child.Value ~= LocalPlayer then
                                            v2005 = true;
                                            break;
                                        end;
                                    end;

                                    return not v2005 and "Solo races pay less. Do you want to invite people in the server?";
                                end);
                            end;
                        elseif u10.typeOf(v2003) == "string" then
                            u1.notify({
                                color = "red",
                                message = v2003
                            });
                        end;

                        u2000 = v2002;
                    end;
                end;

                task.wait(3);
            end;
        end);

        u1.scriptedObjects[u1998] = function(p2006) -- Line: 11624
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _Black = function(p2007) -- Line: 11626, Name: _Black
        -- upvalues: includeBlackBackgrounds (ref), u1 (copy)
        includeBlackBackgrounds(p2007, true);

        u1.scriptedObjects[p2007] = function(p2008) -- Line: 11628
            -- upvalues: includeBlackBackgrounds (ref)
            includeBlackBackgrounds(p2008, false);
        end;
    end,

    _UIViewportMaxScale = function(u2009) -- Line: 11630, Name: _UIViewportMaxScale
        -- upvalues: workspace_CurrentCamera (copy), u1 (copy)
        while workspace_CurrentCamera.ViewportSize.Y <= 1 do
            task.wait();
        end;

        local UIScale = Instance.new("UIScale");
        UIScale.Parent = u2009.Parent;
        local Frame = Instance.new("Frame");
        Frame.BackgroundTransparency = 1;
        Frame.Size = u2009.Parent.Size;
        Frame.Position = u2009.Parent.Position;
        Frame.Name = "__FakeFrame";
        Frame.SizeConstraint = u2009.Parent.SizeConstraint;
        Frame.Parent = u2009.Parent.Parent;

        u1.updateUIViewportMaxScale[u2009] = function(p2010) -- Line: 11641
            -- upvalues: u2009 (copy), Frame (copy), workspace_CurrentCamera (ref), UIScale (copy)
            if p2010 then
                u2009.Value = p2010;
            end;

            local math_min_ret = math.min(1, u2009.Value / (Frame.AbsoluteSize.Y / workspace_CurrentCamera.ViewportSize.Y));

            if math_min_ret ~= UIScale.Scale then
                UIScale.Scale = math_min_ret;
            end;
        end;

        local u2011 = Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 11646
            -- upvalues: u1 (ref), u2009 (copy)
            u1.updateUIViewportMaxScale[u2009]();
        end);
        u1.updateUIViewportMaxScale[u2009]();

        u1.scriptedObjects[u2009] = function(p2012) -- Line: 11650
            -- upvalues: u2011 (copy), u1 (ref), UIScale (copy), Frame (copy)
            u2011:Disconnect();
            u1.updateUIViewportMaxScale[p2012] = nil;

            if UIScale.Parent then
                UIScale:Destroy();
            end;

            if Frame.Parent then
                Frame:Destroy();
            end;
        end;
    end,

    _NameDisplay = function(p2013) -- Line: 11657, Name: _NameDisplay
        -- upvalues: LocalPlayer (copy), u1 (copy)
        if not (LocalPlayer.Character and p2013:IsDescendantOf(LocalPlayer.Character)) and (p2013:IsDescendantOf(workspace) and p2013.Enabled) then
            u1.refreshNameDisplay(p2013);
        end;
    end,

    _PetNameDisplay = function(u2014) -- Line: 11662, Name: _PetNameDisplay
        -- upvalues: updateCombatModeIconPosition (copy), u1 (copy), u10 (copy)
        if not u2014:IsDescendantOf(workspace.Gameplay.Entities) then
            local task_defer_ret = task.defer(function() -- Line: 11664
                -- upvalues: u2014 (copy), updateCombatModeIconPosition (ref)
                u2014.MaxDistance = (1 / 0);
                updateCombatModeIconPosition(u2014.Nickname.CombatMode, u2014);
                u2014.MaxDistance = game.ReplicatedStorage.PlayerStuff._NameDisplay.MaxDistance;
            end);

            u1.scriptedObjects[u2014] = function(p2015) -- Line: 11669
                -- upvalues: u10 (ref), task_defer_ret (copy), u1 (ref)
                u10.taskCancel(task_defer_ret);
                u1.nameDisplays[p2015] = nil;
            end;
        end;
    end,

    _RoleplayScene = function(u2016) -- Line: 11672, Name: _RoleplayScene
        -- upvalues: game_Players (copy), u1 (copy), u10 (copy)
        if u2016:IsDescendantOf(workspace) then
            local v2017 = game_Players:FindFirstChild(u2016.Parent.Name);
            u2016.Part.BillboardGui.Enabled = not (v2017 and u1.isPlayerMutedOrBlockedByThisPlayer(v2017));
            u1.roleplayScenes[u2016] = true;
            local u2018 = {};
            table.insert(u2018, task.defer(function() -- Line: 11680
                -- upvalues: u2016 (copy), u10 (ref), u2018 (copy)
                u2016.Part.BillboardGui.MaxDistance = (1 / 0);

                while u2016.Part.BillboardGui.AbsoluteSize.X == 0 do
                    task.wait();

                    if not u2016.Parent then
                        return;
                    end;
                end;

                u10.adjustSceneText(u2016, u2016.Content.Value);
                u10.waitForTextFilterResultText(u10.buildSignalData, u2018, u2016.Content, function(p2019) -- Line: 11684
                    -- upvalues: u10 (ref), u2016 (ref)
                    u10.adjustSceneText(u2016, p2019);
                end);
                u2016.Part.BillboardGui.MaxDistance = game.ReplicatedStorage.Gameplay._RoleplayScene.Part.BillboardGui.MaxDistance;
            end));

            u1.scriptedObjects[u2016] = function(p2020) -- Line: 11689
                -- upvalues: u1 (ref), u10 (ref), u2018 (copy)
                u1.roleplayScenes[p2020] = nil;
                u10.clearConnectionsAndThreads(u2018);
            end;
        end;
    end,

    _DistanceEmitter = function(p2021) -- Line: 11699, Name: _DistanceEmitter
        -- upvalues: u1934 (copy), u1 (copy)
        local Distance = p2021:WaitForChild("Distance", 5);

        if Distance and p2021.Parent then
            local u2022 = p2021:GetAttribute("EmitterTimeOfDay") or "Rest";
            u1934[u2022][p2021] = Distance.Value;

            u1.scriptedObjects[p2021] = function(p2023) -- Line: 11704
                -- upvalues: u1934 (ref), u2022 (copy)
                u1934[u2022][p2023] = nil;
            end;
        end;
    end,

    _RailwayLight = function(p2024) -- Line: 11707, Name: _RailwayLight
        -- upvalues: railwayLight (copy)
        if p2024.Parent.Active.Value then
            railwayLight(p2024);
        end;
    end,

    _HealNPC = function(p2025) -- Line: 11710, Name: _HealNPC
        -- upvalues: u1 (copy)
        u1.healNpcs[p2025] = true;

        u1.scriptedObjects[p2025] = function(p2026) -- Line: 11712
            -- upvalues: u1 (ref)
            u1.healNpcs[p2026] = nil;
        end;
    end,

    _Parent = function(u2027) -- Line: 11714, Name: _Parent
        -- upvalues: u1 (copy), u10 (copy)
        if not u2027:GetAttribute("Executed") then
            u2027:SetAttribute("Executed", true);
            local task_defer_ret = task.defer(function() -- Line: 11717
                -- upvalues: u2027 (copy), u1 (ref)
                while not u2027.Value do
                    task.wait();
                end;

                u1.scriptedObjects[u2027] = nil;
                u2027.Parent.Parent = u2027.Value;
            end);

            u1.scriptedObjects[u2027] = function(p2028) -- Line: 11722
                -- upvalues: u10 (ref), task_defer_ret (copy)
                u10.taskCancel(task_defer_ret);
            end;
        end;
    end,

    _Align = function(u2029) -- Line: 11725, Name: _Align
        -- upvalues: u1 (copy), u10 (copy)
        local task_defer_ret = task.defer(function() -- Line: 11726
            -- upvalues: u2029 (copy)
            u2029:WaitForChild("Target");

            while not u2029.Target.Value do
                task.wait();
            end;

            local Value = u2029.Target.Value;

            while true do
                u2029.CFrame = CFrame.new(Value.Position);
                task.wait();
            end;
        end);

        u1.scriptedObjects[u2029] = function(p2030) -- Line: 11735
            -- upvalues: u10 (ref), task_defer_ret (copy)
            u10.taskCancel(task_defer_ret);
        end;
    end,

    _HousingGarage = function(p2031) -- Line: 11737, Name: _HousingGarage
        -- upvalues: u1 (copy)
        local Name = p2031.Parent.Parent.Parent.Name;

        if not u1.propertyGarageInteractions[Name] then
            u1.propertyGarageInteractions[Name] = {};
        end;

        table.insert(u1.propertyGarageInteractions[Name], p2031.Parent);
        u1.parentPropertyGarageInteraction(Name, { p2031.Parent });
    end,

    _Rope = function(u2032) -- Line: 11743, Name: _Rope
        -- upvalues: u10 (copy), u1 (copy)
        local u2033 = u10.typeOf(u2032.Value) == "Vector3";
        local u2034 = nil;
        local task_defer_ret = task.defer(function() -- Line: 11747
            -- upvalues: u2033 (copy), u2032 (copy), u2034 (ref), u10 (ref)
            while true do
                while u2033 or u2032.Value and u2032.Value:IsDescendantOf(workspace) do
                    if not u2034 then
                        u2034 = u10.clone(game.ReplicatedStorage.Gameplay.Rope);
                        u2034.RopeConstraint.Thickness = u2032:GetAttribute("Thickness");
                        u2034.Parent = workspace.Gameplay.Entities;

                        if u2033 then
                            u2034.End.CFrame = CFrame.new(u2032.Value);
                        end;
                    end;

                    u2034.Start.CFrame = CFrame.new(u2032.Parent.WorldPosition);

                    if not u2033 then
                        u2034.End.CFrame = CFrame.new(u2032.Value.WorldPosition);
                    end;

                    u2034.RopeConstraint.Length = u2034.RopeConstraint.CurrentDistance + 0.2;
                    task.wait();
                end;

                if u2034 then
                    u2034:Destroy();
                    u2034 = nil;
                end;

                task.wait(1);
            end;
        end);

        u1.scriptedObjects[u2032] = function(p2035) -- Line: 11766
            -- upvalues: u2034 (ref), u10 (ref), task_defer_ret (ref)
            if u2034 then
                u2034:Destroy();
                u2034 = nil;
            end;

            u10.taskCancel(task_defer_ret);
        end;
    end,

    Humanoid = function(u2036) -- Line: 11771, Name: Humanoid
        -- upvalues: u10 (copy), u1847 (copy), u1846 (copy), workspace_CurrentCamera (copy), RunService (copy), u1 (copy)
        if u2036:IsDescendantOf(workspace.Gameplay) or u2036:IsDescendantOf(workspace.World) then
            if u2036.Parent.Name == "ViewModel" then
                return;
            end;

            local Parent = u2036.Parent;
            local PrimaryPart = Parent.PrimaryPart;
            u10.playAnimation(u10.loadAnimation(u2036.Animator, u1847[math.random(#u1847)]), "play");
            local _, u2037 = u1846.loadMotors(Parent);
            local u2038 = 0;
            local u2039 = nil;
            local task_defer_ret = task.defer(function() -- Line: 11779
                -- upvalues: PrimaryPart (copy), workspace_CurrentCamera (ref), u2036 (copy), u2037 (copy), u2038 (ref), u2039 (ref), RunService (ref)
                while true do
                    while (PrimaryPart.Position - workspace_CurrentCamera.CFrame.Position).magnitude >= 300 or u2036.Health <= 0 do
                        task.wait(1);
                    end;

                    u2037(u2038);
                    local v2040, v2041 = RunService.Stepped:wait();
                    u2039 = v2040;
                    u2038 = v2041;
                end;
            end);

            u1.scriptedObjects[u2036] = function(p2042) -- Line: 11788
                -- upvalues: u10 (ref), task_defer_ret (copy)
                u10.taskCancel(task_defer_ret);
            end;
        end;
    end
};

function u1.addScriptObject(p2044) -- Line: 11793
    -- upvalues: u2043 (copy)
    if p2044 and u2043[p2044.Name] then
        u2043[p2044.Name](p2044, true);
    end;
end;

function u1.removeScriptObject(p2045) -- Line: 11796
    -- upvalues: u1 (copy), u10 (copy)
    if p2045 and u1.scriptedObjects[p2045] then
        if u10.typeOf(u1.scriptedObjects[p2045]) == "table" then
            u1.scriptedObjects[p2045].cleanUp(p2045);
        else
            u1.scriptedObjects[p2045](p2045);
        end;

        u1.scriptedObjects[p2045] = nil;
    end;
end;

task.defer(function() -- Line: 11802
    -- upvalues: u10 (copy), LocalPlayer (copy), PlayerGui (copy), u1 (copy), u2043 (copy)
    u10.waitForClientToLoad(LocalPlayer);

    for _, v in pairs({ workspace, PlayerGui }) do
        v.DescendantAdded:Connect(u1.addScriptObject);
        v.DescendantRemoving:Connect(u1.removeScriptObject);

        for _, descendant in pairs(v:GetDescendants()) do
            if u2043[descendant.Name] then
                task.spawn(u2043[descendant.Name], descendant);
            end;
        end;
    end;
end);
u1.debugLoadingClient("Core 8");

return u1;
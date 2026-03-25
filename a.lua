local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotFinderGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 460)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 36)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Brainrot Finder"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

local minButton = Instance.new("TextButton")
minButton.Name = "MinButton"
minButton.Size = UDim2.new(0, 28, 0, 28)
minButton.AnchorPoint = Vector2.new(1, 0)
minButton.Position = UDim2.new(1, -6, 0, 4)
minButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minButton.Text = "-"
minButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minButton.Font = Enum.Font.SourceSansBold
minButton.TextScaled = true
minButton.ZIndex = 10
minButton.Parent = mainFrame

local minimized = false
local fullSize = mainFrame.Size
local function setBodyVisible(v)
    for _, c in ipairs(mainFrame:GetChildren()) do
        if c ~= titleLabel and c ~= minButton then
            if c:IsA("GuiObject") then
                c.Visible = v
            end
        end
    end
end
minButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        fullSize = mainFrame.Size
        setBodyVisible(false)
        minButton.Text = "+"
        mainFrame.Size = UDim2.new(mainFrame.Size.X.Scale, mainFrame.Size.X.Offset, 0, 36)
    else
        setBodyVisible(true)
        minButton.Text = "-"
        mainFrame.Size = fullSize
    end
end)

local refreshButton = Instance.new("TextButton")
refreshButton.Name = "RefreshButton"
refreshButton.Size = UDim2.new(1, -40, 0, 34)
refreshButton.Position = UDim2.new(0, 20, 0, 50)
refreshButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
refreshButton.Text = "Refresh"
refreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshButton.Font = Enum.Font.SourceSansBold
refreshButton.TextScaled = true
refreshButton.Parent = mainFrame

local autoButton = Instance.new("TextButton")
autoButton.Name = "AutoButton"
autoButton.Size = UDim2.new(1, -40, 0, 34)
autoButton.Position = UDim2.new(0, 20, 0, 176)
autoButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
autoButton.Text = "Auto Grab: OFF"
autoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoButton.Font = Enum.Font.SourceSansBold
autoButton.TextScaled = true
autoButton.Parent = mainFrame

local rankButton = Instance.new("TextButton")
rankButton.Name = "RankButton"
rankButton.Size = UDim2.new(1, -40, 0, 34)
rankButton.Position = UDim2.new(0, 20, 0, 92)
rankButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rankButton.Text = "Ranks: All"
rankButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rankButton.Font = Enum.Font.SourceSansBold
rankButton.TextScaled = true
rankButton.Parent = mainFrame

local rarityButton = Instance.new("TextButton")
rarityButton.Name = "RarityButton"
rarityButton.Size = UDim2.new(1, -40, 0, 34)
rarityButton.Position = UDim2.new(0, 20, 0, 134)
rarityButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rarityButton.Text = "Rarities: All"
rarityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rarityButton.Font = Enum.Font.SourceSansBold
rarityButton.TextScaled = true
rarityButton.Parent = mainFrame

local rankDrop = Instance.new("ScrollingFrame")
rankDrop.Name = "RankDrop"
rankDrop.Size = UDim2.new(1, -40, 0, 180)
rankDrop.Position = UDim2.new(0, 20, 0, 126)
rankDrop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
rankDrop.BorderSizePixel = 0
rankDrop.ScrollBarThickness = 6
rankDrop.Visible = false
rankDrop.Parent = mainFrame
rankDrop.ZIndex = 100

local rankLayout = Instance.new("UIListLayout")
rankLayout.Parent = rankDrop
rankLayout.Padding = UDim.new(0, 4)
rankLayout.FillDirection = Enum.FillDirection.Vertical
rankLayout.SortOrder = Enum.SortOrder.LayoutOrder

local rarityDrop = Instance.new("ScrollingFrame")
rarityDrop.Name = "RarityDrop"
rarityDrop.Size = UDim2.new(1, -40, 0, 180)
rarityDrop.Position = UDim2.new(0, 20, 0, 168)
rarityDrop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
rarityDrop.BorderSizePixel = 0
rarityDrop.ScrollBarThickness = 6
rarityDrop.Visible = false
rarityDrop.Parent = mainFrame
rarityDrop.ZIndex = 100

local rarityLayout = Instance.new("UIListLayout")
rarityLayout.Parent = rarityDrop
rarityLayout.Padding = UDim.new(0, 4)
rarityLayout.FillDirection = Enum.FillDirection.Vertical
rarityLayout.SortOrder = Enum.SortOrder.LayoutOrder

local selectedRanks = {}
local function selectedRanksCount()
    local c = 0
    for _, v in pairs(selectedRanks) do
        if v then c += 1 end
    end
    return c
end
local function updateRankButtonText()
    local names = {}
    for k, v in pairs(selectedRanks) do
        if v then
            table.insert(names, k)
        end
    end
    table.sort(names, function(a, b) return a:lower() < b:lower() end)
    if #names == 0 then
        rankButton.Text = "Ranks: All"
        return
    end
    if #names == 1 then
        rankButton.Text = "Ranks: " .. names[1]
        return
    end
    if #names == 2 then
        rankButton.Text = "Ranks: " .. names[1] .. ", " .. names[2]
        return
    end
    rankButton.Text = "Ranks: " .. names[1] .. ", " .. names[2] .. " +" .. tostring(#names - 2)
end
local function clearRankDrop()
    for _, c in ipairs(rankDrop:GetChildren()) do
        if c:IsA("TextButton") then
            c:Destroy()
        end
    end
end
local function collectRanks()
    local set = {["All"] = true}
    local root = workspace:FindFirstChild("ActiveBrainrots")
    if root then
        for _, m in ipairs(root:GetChildren()) do
            local r = tostring((function()
                for _, d in ipairs(m:GetDescendants()) do
                    local n = d.Name:lower()
                    if d:IsA("StringValue") and (n:find("rank") or n:find("tier") or n:find("rarity")) and d.Value and #d.Value > 0 then
                        return d.Value
                    end
                    if (d:IsA("TextLabel") or d:IsA("TextBox")) and (n:find("rank") or n:find("tier") or n:find("rarity") or n == "text") then
                        if d.Text and #d.Text > 0 then
                            return d.Text
                        end
                    end
                end
                for _, d in ipairs(m:GetDescendants()) do
                    if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
                        for _, c in ipairs(d:GetDescendants()) do
                            if c:IsA("TextLabel") and c.Text and #c.Text > 0 then
                                return c.Text
                            end
                        end
                    end
                end
                return ""
            end)() or "")
            r = r:gsub("^%s+", ""):gsub("%s+$", "")
            if #r > 0 then
                set[r] = true
            end
        end
    end
    local arr = {}
    for k in pairs(set) do
        table.insert(arr, k)
    end
    table.sort(arr, function(a, b)
        if a == "All" then return true end
        if b == "All" then return false end
        return a:lower() < b:lower()
    end)
    return arr
end
local function rebuildRankDrop()
    clearRankDrop()
    local arr = collectRanks()
    for _, r in ipairs(arr) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -8, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSans
        b.TextScaled = true
        b.Text = r == "All" and "All (clear)" or r
        b.Parent = rankDrop
        b.ZIndex = 101
        if r ~= "All" and selectedRanks[r] then
            b.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
        end
        b.MouseButton1Click:Connect(function()
            if r == "All" then
                for k in pairs(selectedRanks) do
                    selectedRanks[k] = nil
                end
                updateRankButtonText()
                rebuild()
                rankDrop.Visible = false
            else
                selectedRanks[r] = not selectedRanks[r]
                if selectedRanks[r] then
                    b.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
                else
                    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end
                updateRankButtonText()
                rebuild()
            end
        end)
    end
    rankDrop.CanvasSize = UDim2.new(0, 0, 0, rankLayout.AbsoluteContentSize.Y + 8)
end
rankLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    rankDrop.CanvasSize = UDim2.new(0, 0, 0, rankLayout.AbsoluteContentSize.Y + 8)
end)

rankButton.MouseButton1Click:Connect(function()
    rebuildRankDrop()
    rankDrop.Visible = not rankDrop.Visible
    if rankDrop.Visible then
        rarityDrop.Visible = false
    end
end)

local selectedRarities = {}
local function updateRarityButtonText()
    local names = {}
    for k, v in pairs(selectedRarities) do
        if v then table.insert(names, k) end
    end
    table.sort(names, function(a, b) return a:lower() < b:lower() end)
    if #names == 0 then
        rarityButton.Text = "Rarities: All"
        return
    end
    if #names == 1 then
        rarityButton.Text = "Rarities: " .. names[1]
        return
    end
    if #names == 2 then
        rarityButton.Text = "Rarities: " .. names[1] .. ", " .. names[2]
        return
    end
    rarityButton.Text = "Rarities: " .. names[1] .. ", " .. names[2] .. " +" .. tostring(#names - 2)
end

local function getRarityText(model)
    for _, d in ipairs(model:GetDescendants()) do
        local n = d.Name:lower()
        if d:IsA("StringValue") and n:find("rarity") and d.Value and #d.Value > 0 then
            return d.Value
        end
        if (d:IsA("TextLabel") or d:IsA("TextBox")) and (n:find("rarity") or n == "text") then
            if d.Text and #d.Text > 0 then
                return d.Text
            end
        end
    end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
            for _, c in ipairs(d:GetDescendants()) do
                if c:IsA("TextLabel") and c.Text and #c.Text > 0 then
                    return c.Text
                end
            end
        end
    end
    return "?"
end

local function collectRarities()
    local set = {["All"] = true}
    local root = workspace:FindFirstChild("ActiveBrainrots")
    if root then
        for _, m in ipairs(root:GetChildren()) do
            local rr = getRarityText(m)
            rr = tostring(rr or ""):gsub("^%s+", ""):gsub("%s+$", "")
            if #rr > 0 then
                set[rr] = true
            end
        end
    end
    local arr = {}
    for k in pairs(set) do table.insert(arr, k) end
    table.sort(arr, function(a, b)
        if a == "All" then return true end
        if b == "All" then return false end
        return a:lower() < b:lower()
    end)
    return arr
end

local function rebuildRarityDrop()
    for _, c in ipairs(rarityDrop:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local arr = collectRarities()
    for _, r in ipairs(arr) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -8, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSans
        b.TextScaled = true
        b.Text = r == "All" and "All (clear)" or r
        b.Parent = rarityDrop
        b.ZIndex = 101
        if r ~= "All" and selectedRarities[r] then
            b.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
        end
        b.MouseButton1Click:Connect(function()
            if r == "All" then
                for k in pairs(selectedRarities) do selectedRarities[k] = nil end
                updateRarityButtonText()
                rebuild()
                rarityDrop.Visible = false
            else
                selectedRarities[r] = not selectedRarities[r]
                if selectedRarities[r] then
                    b.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
                else
                    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end
                updateRarityButtonText()
                rebuild()
            end
        end)
    end
    rarityDrop.CanvasSize = UDim2.new(0, 0, 0, rarityLayout.AbsoluteContentSize.Y + 8)
end
rarityLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    rarityDrop.CanvasSize = UDim2.new(0, 0, 0, rarityLayout.AbsoluteContentSize.Y + 8)
end)
rarityButton.MouseButton1Click:Connect(function()
    rebuildRarityDrop()
    rarityDrop.Visible = not rarityDrop.Visible
    if rarityDrop.Visible then
        rankDrop.Visible = false
    end
end)


local list = Instance.new("ScrollingFrame")
list.Name = "BrainrotList"
list.Size = UDim2.new(1, -40, 0, 260)
list.Position = UDim2.new(0, 20, 0, 218)
list.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
list.BorderSizePixel = 0
list.ScrollBarThickness = 6
list.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = list
layout.Padding = UDim.new(0, 6)
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function getRankText(model)
    for _, d in ipairs(model:GetDescendants()) do
        local n = d.Name:lower()
        if d:IsA("StringValue") and (n:find("rank") or n:find("tier")) and d.Value and #d.Value > 0 then
            return d.Value
        end
        if (d:IsA("TextLabel") or d:IsA("TextBox")) and (n:find("rank") or n:find("tier") or n == "text") then
            if d.Text and #d.Text > 0 then
                return d.Text
            end
        end
    end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
            for _, c in ipairs(d:GetDescendants()) do
                if c:IsA("TextLabel") and c.Text and #c.Text > 0 then
                    return c.Text
                end
            end
        end
    end
    return "?"
end

local function getHitboxPart(model)
    local cand = {}
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BasePart") then
            table.insert(cand, d)
        end
    end
    local best = nil
    for _, p in ipairs(cand) do
        local n = p.Name:lower()
        if n:find("hitbox") or n:find("serverhit") then
            best = p
            break
        end
    end
    if not best and model:IsA("Model") and model.PrimaryPart then
        best = model.PrimaryPart
    end
    if not best then
        local maxV = -1
        for _, p in ipairs(cand) do
            local v = p.Size.X * p.Size.Y * p.Size.Z
            if v > maxV then
                maxV = v
                best = p
            end
        end
    end
    return best
end

local function tpTo(part)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and part and part:IsDescendantOf(workspace) then
        hrp.CFrame = part.CFrame + Vector3.new(0, 4, 0)
    end
end

local function tryGrab(model)
    local prompt = nil
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            prompt = d
            break
        end
    end
    local function snapshot()
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local t = {}
        if bp then
            for _, c in ipairs(bp:GetChildren()) do
                local n = c.Name
                t[n] = (t[n] or 0) + 1
            end
        end
        local inv = LocalPlayer:FindFirstChild("Inventory")
        if inv then
            for _, c in ipairs(inv:GetDescendants()) do
                local key = c:GetFullName()
                t[key] = (t[key] or 0) + 1
            end
        end
        return t
    end
    local function changed(a, b)
        for k, v in pairs(a) do
            if (b[k] or 0) ~= v then
                return true
            end
        end
        for k, v in pairs(b) do
            if (a[k] or 0) ~= v then
                return true
            end
        end
        return false
    end
    if prompt then
        local before = snapshot()
        local t0 = time()
        if typeof(fireproximityprompt) == "function" then
            fireproximityprompt(prompt)
        end
        while time() - t0 < 12 do
            local after = snapshot()
            if changed(before, after) then
                return true
            end
            if typeof(fireproximityprompt) == "function" then
                fireproximityprompt(prompt)
            end
            task.wait(0.2)
        end
    end
    return false
end

local function clearList()
    for _, c in ipairs(list:GetChildren()) do
        if c:IsA("Frame") then
            c:Destroy()
        end
    end
end

local function matchRank(txt)
    local t = tostring(txt or "")
    t = string.lower(t)
    local anySelected = false
    for _, v in pairs(selectedRanks) do
        if v then
            anySelected = true
            break
        end
    end
    if not anySelected then
        return true
    end
    for k, v in pairs(selectedRanks) do
        if v then
            local s = string.lower(k)
            if string.find(t, s, 1, true) ~= nil then
                return true
            end
        end
    end
    return false
end

local function matchRarity(txt)
    local t = tostring(txt or "")
    t = string.lower(t)
    local anySelected = false
    for _, v in pairs(selectedRarities) do
        if v then
            anySelected = true
            break
        end
    end
    if not anySelected then
        return true
    end
    for k, v in pairs(selectedRarities) do
        if v then
            local s = string.lower(k)
            if string.find(t, s, 1, true) ~= nil then
                return true
            end
        end
    end
    return false
end

function rebuild()
    clearList()
    local root = workspace:FindFirstChild("ActiveBrainrots")
    if not root then
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        return
    end
    local children = root:GetChildren()
    table.sort(children, function(a, b)
        return a.Name < b.Name
    end)
    for _, m in ipairs(children) do
        local rank = getRankText(m)
        local rarity = getRarityText(m)
        if not matchRank(rank) or not matchRarity(rarity) then
            continue
        end
        local hit = getHitboxPart(m)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -8, 0, 40)
        row.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        row.Parent = list

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, -8, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = m.Name .. "  |  " .. rank .. "  |  " .. rarity
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.SourceSans
        label.TextScaled = true
        label.Parent = row

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0.17, -6, 1, 0)
        tpBtn.Position = UDim2.new(0.6, 4, 0, 0)
        tpBtn.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
        tpBtn.Text = "TP"
        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpBtn.Font = Enum.Font.SourceSansBold
        tpBtn.TextScaled = true
        tpBtn.Parent = row

        local grabBtn = Instance.new("TextButton")
        grabBtn.Size = UDim2.new(0.23, -6, 1, 0)
        grabBtn.Position = UDim2.new(0.77, 4, 0, 0)
        grabBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        grabBtn.Text = "Grab"
        grabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        grabBtn.Font = Enum.Font.SourceSansBold
        grabBtn.TextScaled = true
        grabBtn.Parent = row

        tpBtn.MouseButton1Click:Connect(function()
            local target = getHitboxPart(m)
            tpTo(target)
        end)
        grabBtn.MouseButton1Click:Connect(function()
            local target = getHitboxPart(m)
            tpTo(target)
            tryGrab(m)
        end)
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Wait()
    list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
end

refreshButton.MouseButton1Click:Connect(function()
    rebuild()
end)

local isAuto = false
autoButton.MouseButton1Click:Connect(function()
    isAuto = not isAuto
    if isAuto then
        autoButton.Text = "Auto Grab: ON"
        autoButton.BackgroundColor3 = Color3.fromRGB(60, 170, 60)
        task.spawn(function()
            while isAuto do
                local root = workspace:FindFirstChild("ActiveBrainrots")
                if root then
                    local children = root:GetChildren()
                    table.sort(children, function(a, b)
                        return a.Name < b.Name
                    end)
                    for _, m in ipairs(children) do
                        if not isAuto then break end
                        local rank = getRankText(m)
                        local rarity = getRarityText(m)
                        if matchRank(rank) and matchRarity(rarity) then
                            local target = getHitboxPart(m)
                            tpTo(target)
                            tryGrab(m)
                            task.wait(0.3)
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        autoButton.Text = "Auto Grab: OFF"
        autoButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    end
end)

rebuild()

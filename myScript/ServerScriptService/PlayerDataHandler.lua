-- ServerScriptService.PlayerDataHandler
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StatModule = require(ReplicatedStorage.Modules.StatModule)

-- 데이터 스토어 생성 (게임에 맞게 이름 변경 가능)
local playerDataStore = DataStoreService:GetDataStore("PlayerStats_V1")

local playerStats = {}

local function onPlayerAdded(player)
    local userId = "Player_" .. player.UserId

    local success, data = pcall(function()
        return playerDataStore:GetAsync(userId)
    end)

    if success then
        if data then
            -- 데이터가 있으면 로드
            playerStats[player] = data
            print(player.Name .. "님의 데이터를 불러왔습니다.")
        else
            -- 데이터가 없으면 새로 생성
            playerStats[player] = StatModule.new()
            print(player.Name .. "님의 신규 데이터를 생성했습니다.")
        end
    else
        -- 데이터 로드 실패 시 경고 출력
        warn("데이터를 불러오는데 실패했습니다: " .. tostring(data))
        -- 실패 시 임시 데이터 생성
        playerStats[player] = StatModule.new()
    end
end

local function onPlayerRemoving(player)
    local userId = "Player_" .. player.UserId

    local statsToSave = playerStats[player]
    if not statsToSave then return end

    local success, err = pcall(function()
        playerDataStore:SetAsync(userId, statsToSave)
    end)

    if success then
        print(player.Name .. "님의 데이터를 저장했습니다.")
    else
        warn("데이터를 저장하는데 실패했습니다: " .. tostring(err))
    end

    -- 메모리에서 플레이어 데이터 제거
    playerStats[player] = nil
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- 다른 서버 스크립트에서 플레이어 스탯에 접근할 수 있도록 테이블 반환
return playerStats

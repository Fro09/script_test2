-- StarterPlayerScripts.TrainingClient
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrainEvent = ReplicatedStorage:WaitForChild("TrainEvent")

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Space then
		-- 서버에 훈련 요청 (서버가 검증/증가 처리)
		TrainEvent:FireServer()
	end
end)

-- 서버에서 수신: strength 값만 받음
TrainEvent.OnClientEvent:Connect(function(strength)
	print("현재 힘:", strength)
	-- 여기서 UI 갱신, 외형 변경 등은 strength 값만으로 구현하면 됨
end)

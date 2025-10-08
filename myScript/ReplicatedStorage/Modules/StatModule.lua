-- ReplicatedStorage.Modules.StatModule
local StatModule = {}

function StatModule.new()
	return {
		Strength = 0,
	}
end

function StatModule.Train(stats)
	-- 힘만 1씩 증가하도록 함
	stats.Strength = stats.Strength + 1
	return stats
end

return StatModule

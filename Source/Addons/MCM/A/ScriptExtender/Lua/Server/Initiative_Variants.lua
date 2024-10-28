local function SetInitiativeDie(value)
    value = value or MCM.Get("InitiativeDie")
    if value and value >= 4 and value <= 100 then
        local StatsManager = Ext.Stats.GetStatsManager()
        -- _D(StatsManager.ExtraData["InitiativeDie"])
        StatsManager.ExtraData["InitiativeDie"] = value
        -- _D(StatsManager.ExtraData["InitiativeDie"])
    end
end

Ext.ModEvents.BG3MCM["MCM_Setting_Saved"]:Subscribe(function(payload)
    if not payload or payload.modUUID ~= ModuleUUID or not payload.settingId then
        return
    end

    local settingId = payload.settingId
    local value = payload.value

    if settingId == "InitiativeDie" then
        SetInitiativeDie(value)
    end
end)

local function GameStateChangedFunction(event)
    if event.FromState ~= "Sync" or event.ToState ~= "Running" then
        return
    end

    SetInitiativeDie()
end


Ext.Events.GameStateChanged:Subscribe(GameStateChangedFunction)

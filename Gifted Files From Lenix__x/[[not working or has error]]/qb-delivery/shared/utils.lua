Utils = {}
Utils.Functions = {}

--- Prints the contents of a table with optional indentation.
---
--- @param table (table) The table to be printed.
--- @param indent? (number, optional) The level of indentation for formatting.
function Utils.Functions.printTable(table, indent)
    indent = indent or 0
    if type(table) == "table" then
        for k, v in pairs(table) do
            local tblType = type(v)
            local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)
            if tblType == "table" then
                print(formatting)
                Utils.Functions.printTable(v, indent + 1)
            elseif tblType == "boolean" then
                print(("%s^1 %s ^0"):format(formatting, v))
            elseif tblType == "function" then
                print(("%s^9 %s ^0"):format(formatting, v))
            elseif tblType == "number" then
                print(("%s^5 %s ^0"):format(formatting, v))
            elseif tblType == "string" then
                print(("%s ^2%s ^0"):format(formatting, v))
            else
                print(("%s^2 %s ^0"):format(formatting, v))
            end
        end
    else
        print(("%s ^0%s"):format(string.rep("  ", indent), table))
    end
end

--- A simple debug print function that is dependent on a convar
--- will output a nice prettfied message if debugMode is on
function Utils.Functions.debugPrint(text)
    if not Config.DebugPrint then return end
    print(("[ %s : DEBUG]"):format("qb-delivery"))
    Utils.Functions.printTable(tbl)
    print("[ END DEBUG ]")
end

---@param name string resource name
---@return boolean
function Utils.Functions.hasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

--- Get framework used by the server
--- @return object
function Utils.Functions.GetFramework()
    if Config.FrameWork == "qb" then
        if not Utils.Functions.hasResource("qb-core") then
            Utils.Functions.debugPrint("QBCore is not installed! The plugin cannot be used with this framework.")
            return false
        end
        return exports["qb-core"]:GetCoreObject()
    elseif Config.FrameWork == "esx" then
        if not Utils.Functions.hasResource("es_extended") then
            Utils.Functions.debugPrint("QBCore is not installed! The plugin cannot be used with this framework.")
            return false
        end
        return exports["es_extended"]:getSharedObject()
    end
end

---@param source number | nil Player server id or nil, if value is nil, Trigger client event.
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
function Utils.Functions.CustomNotify(source, title, type, text, duration, icon)
    if source and source > 0 then -- Server Notify
        -- TriggerClientEvent("EventName", source, ?, ?, ?, ?)
    else                          -- Client Notify
        -- exports["ExportName"]:Alert(?, ?, ?, ?)
    end
end

function Utils.Functions.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Utils.Functions.deepCopy(orig_key)] = Utils.Functions.deepCopy(orig_value)
        end
        setmetatable(copy, Utils.Functions.deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Utils.Functions.GetRandomTaskProp()
    local taskProps = Config.JobOptions.delivery.taskProps
    return taskProps[math.random(1, #taskProps)]
end

function Utils.Functions.GetTaskProp(model)
    for key, value in pairs(Config.JobOptions.delivery.taskProps) do
        if value.model == model then
            return value
        end
    end
end

function Utils.Functions.GetRandomTaskPed()
    local taskPeds = Config.JobOptions.delivery.taskPeds
    return taskPeds[math.random(1, #taskPeds)]
end

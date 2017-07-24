BindActorTriggers = function(a)

	-- Don't try to attack stuff while being inside a transport
	Trigger.OnAddedToWorld(a, function()

		-- If you have nothing to do at the moment...
		Trigger.OnIdle(a, function(a)
			-- ...go attack an actor with the 'Huntable' trait
			a.Hunt()
		end)
	end)
end

VGForce = { "smech, smech", "smech" }
VGForcePath = { Actor1018.Location, Actor1268.Location }
VGForceInterval = 20

WolverineSpawn = function()
    local units = Reinforcements.Reinforce(gdi, AirdropedForce, VGForcePath, VGForceInterval)
    Utils.Do(units, function(unit)
        BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(35), WolverineSpawn)
end

AirdropedForce = { "gdie1", "gdie1", "gdie1", "gdie1", "gdie1" }
AirdropedForcePath = { Actor788.Location, Actor1360.Location }
AirdropedForceInterval = 50

GdiTransportReinforcement = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1314.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
        BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement)
end

GdiTransportReinforcement2 = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1324.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
       BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement2)
end

GdiTransportReinforcement3 = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1353.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
       BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement3)
end

GdiTransportReinforcement4 = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1270.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
       BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement4)
end

GdiTransportReinforcement5 = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1352.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
       BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement5)
end

GdiTransportReinforcement6 = function()
    local units = Reinforcements.ReinforceWithTransport(gdi, "orcatran", AirdropedForce,
	{ Actor788.Location, Actor1269.Location },  { Actor788.Location }) [2]
    Utils.Do(units, function(unit)
       BindActorTriggers(unit)
    end)
    Trigger.AfterDelay(DateTime.Seconds(40), GdiTransportReinforcement6)
end

ScrinInf1 = { "shark","shark","shark","shark","shark","shark" }
ScrinInf1Path = { Actor1219.Location, Actor1268.Location }
ScrinInf2Path = { Actor1223.Location, Actor1360.Location }
ScrinInf3Path = { Actor1266.Location, Actor1320.Location }
ScrinInf4Path = { Actor1318.Location, Actor1319.Location }
--SrinForceIntrval = 25

-- Reduce duplication a tiny bit:
-- All four scrin reinforcements come at the same time,
-- so no need to have four times "Trigger.AfterDelay(DateTime.Seconds(2), <function>)" running
ScrinInfLoop = function()
	-- Save the global table as local one for quicker lookup
	local Reinforcements = Reinforcements

	-- 25 is already the default for the interval, so we don't need to redefine it here
	Reinforcements.Reinforce(scrin, ScrinInf1, ScrinInf1Path)
	Reinforcements.Reinforce(scrin, ScrinInf1, ScrinInf2Path)
	Reinforcements.Reinforce(scrin, ScrinInf1, ScrinInf3Path)
	Reinforcements.Reinforce(scrin, ScrinInf1, ScrinInf4Path)

    Trigger.AfterDelay(DateTime.Seconds(15), ScrinInfLoop)
end

StormRiderForce = { "stormrider", "stormrider", "stormrider" }
StormRiderSpawn1Path = { Actor1219.Location } --, Actor869.Location }
StormRiderSpawn2Path = { Actor1323.Location } --, Actor1269.Location }
StormRiderSpawn3Path = { Actor1323.Location } --, Actor1319.Location }

StormRiderTarget1 = Actor1224
StormRiderTarget2 = Actor1221
StormRiderTarget3 = Actor1321

StormRiderSpawn1 = function()
    local units = Reinforcements.Reinforce(scrin, StormRiderForce, StormRiderSpawn1Path)
    Utils.Do(units, function(unit)
        TargetAndAttack(unit, StormRiderTarget1)
    end)
    Trigger.AfterDelay(DateTime.Seconds(21), StormRiderSpawn1)
end

StormRiderSpawn2 = function()
    local units = Reinforcements.Reinforce(scrin, StormRiderForce, StormRiderSpawn2Path)
    Utils.Do(units, function(unit)
        TargetAndAttack(unit, StormRiderTarget2)
    end)
    Trigger.AfterDelay(DateTime.Seconds(20), StormRiderSpawn2)
end

StormRiderSpawn3 = function()
    local units = Reinforcements.Reinforce(scrin, StormRiderForce, StormRiderSpawn3Path)
    Utils.Do(units, function(unit)
        TargetAndAttack(unit, StormRiderTarget3)
    end)
    Trigger.AfterDelay(DateTime.Seconds(20), StormRiderSpawn3)
end

TargetAndAttack = function(rider, target)
	rider.Attack(target)
	rider.Wait(DateTime.Seconds(1))
	rider.CallFunc(function()
		TargetAndAttack(rider, target)
	end)
end


WorldLoaded = function()
	gdi = Player.GetPlayer("GDI")
	scrin = Player.GetPlayer("SCRIN")
	Camera.Position = Actor1220.CenterPosition
	ScrinInfLoop()
	StormRiderSpawn1()
	Trigger.AfterDelay(DateTime.Seconds(5), StormRiderSpawn2)
	Trigger.AfterDelay(DateTime.Seconds(10), StormRiderSpawn3)
	GdiTransportReinforcement()
	GdiTransportReinforcement2()
	GdiTransportReinforcement3()
	GdiTransportReinforcement4()
	GdiTransportReinforcement5()
	GdiTransportReinforcement6()
	WolverineSpawn()
end

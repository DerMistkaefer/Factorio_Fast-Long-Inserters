
--DATA
require("prototypes.technology")
require("prototypes.style")

--CODE
FLI = {}
FLI.modName = "FastLongInserters"


function FastLongInserter_addInseter(baseInserter,order)
	local inserter = data.raw["inserter"][baseInserter]
	local baseItem = inserter.minable.result
	
	FastLongInserter_addItem(baseItem,baseInserter,order)
	FastLongInserter_addRecipe(baseItem,baseInserter)
	FastLongInserter_addEntity(baseItem,baseInserter)
end

function FastLongInserter_addItem(base,baseName,order)
	local obj = util.table.deepcopy(data.raw["item"][base])
	local icon = "__".. FLI.modName .."__/graphics/icons/FLI_" .. baseName .. ".png"
	
	obj.name = FLI.modName .. "_" .. baseName
	obj.icon = icon
	obj.icon_size = 32
	obj.place_result = obj.name
	obj.order = order
	
	data.raw[obj.type][obj.name] = obj
end

function FastLongInserter_addRecipe(base,baseName)
	local obj = util.table.deepcopy(data.raw["recipe"][base])
	obj.type = "recipe"
	obj.name = FLI.modName .. "_" .. baseName
	
	obj.enabled = false
	
	obj.ingredients = nil
	obj.ingredients = {}
	obj.ingredients[1] = {type = "item", name = "iron-gear-wheel", amount = 1}
	obj.ingredients[2] = {type = "item", name = "iron-plate", amount = 1}
	obj.ingredients[3] = {type = "item", name = baseName, amount = 1}
	
	obj.result = nil
	obj.results = {}
	obj.results[1] = {type = "item", name = obj.name, amount = 1}
	
	obj.requester_paste_multiplier = 4
	
	data.raw[obj.type][obj.name] = obj
end

function FastLongInserter_addEntity(base,baseName)
	local obj = util.table.deepcopy(data.raw["inserter"][base])
	obj.name = FLI.modName .. "_" .. baseName
	obj.minable.result = obj.name
	
	local baseGraphics = "__".. FLI.modName .."__/graphics/entity/"
	local baseGraphicsInserter = baseGraphics .. baseName .. "/" .. baseName
	obj.hand_base_picture.filename = baseGraphics .. "inserter-hand-base.png"
	obj.hand_closed_picture.filename =  baseGraphicsInserter .. "-hand-closed.png"
	obj.hand_open_picture.filename = baseGraphicsInserter .. "-hand-open.png"
	obj.platform_picture.sheet.filename = baseGraphics .. "inserter-platform.png"
	
	obj.pickup_position = {0, -2}
	obj.insert_position = {0, 2.2}
	obj.extension_speed = 0.56
	
	data.raw[obj.type][obj.name] = obj
end

function FastLongInserter_addItemG(base,baseName,GhostName)
	local obj = util.table.deepcopy(data.raw["item"][base])
	local icon = "__".. FLI.modName .."__/graphics/icons/FLI_" .. "Ghost" .. ".png"
	
	obj.name = FLI.modName .. "_" .. GhostName
	obj.icon = icon
	obj.icon_size = 32
	obj.place_result = obj.name
	
	data.raw[obj.type][obj.name] = obj
end

function FastLongInserter_addEntityG(base,baseName,GhostName)
	local obj = util.table.deepcopy(data.raw["inserter"][base])
	obj.name = FLI.modName .. "_" .. GhostName
	obj.minable.result = obj.name
	
	local baseGraphics = "__".. FLI.modName .."__/graphics/entity/Ghost/"
	local baseGraphicsInserter = baseGraphics .. baseName .. "/" .. baseName
	obj.hand_base_picture.filename = baseGraphics .. "inserter-hand-base.png"
	obj.hand_closed_picture.filename =  baseGraphics .. "Ghost-hand-closed.png"
	obj.hand_open_picture.filename = baseGraphics .. "Ghost-hand-open.png"
	obj.platform_picture.sheet.filename = baseGraphics .. GhostName .. ".png"
	
	
	data.raw[obj.type][obj.name] = obj
end


FastLongInserter_addEntityG(data.raw["inserter"]["inserter"].minable.result,"inserter","Ghost_I")
FastLongInserter_addEntityG(data.raw["inserter"]["inserter"].minable.result,"inserter","Ghost_O")
FastLongInserter_addItemG(data.raw["inserter"]["inserter"].minable.result,"inserter","Ghost_I")
FastLongInserter_addItemG(data.raw["inserter"]["inserter"].minable.result,"inserter","Ghost_O")
--stLongInserter_addInseter(GrundName,order)
FastLongInserter_addInseter("fast-inserter","dd[long-fast-inserter]")
FastLongInserter_addInseter("filter-inserter","ee[long-filter-inserter]")
FastLongInserter_addInseter("stack-inserter","ff[long-stack-inserter]")
FastLongInserter_addInseter("stack-filter-inserter","gg[long-stack-filter-inserter]")


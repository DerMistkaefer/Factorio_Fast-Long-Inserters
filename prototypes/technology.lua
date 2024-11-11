FLI = {}
FLI.modName = "FastLongInserters"
FLI.techIcon = "__"..FLI.modName.. "__/graphics/technology/"..FLI.modName..".png"

data:extend({
	{
    type = "technology",
    name = FLI.modName .. "-fast-inserter",
    icon = FLI.techIcon,
	  icon_size = 32,
    effects = {{type = "unlock-recipe",recipe = FLI.modName.."_fast-inserter"}},
    prerequisites = {"logistics"},
    unit = {count = 75,ingredients = {{"automation-science-pack", 1}},time = 5}
  },
  {
    type = "technology",
    name = FLI.modName .. "-bulk-inserter",
    icon = FLI.techIcon,
  	icon_size = 32,
    effects = {{type = "unlock-recipe", recipe = FLI.modName.."_bulk-inserter"}},
    prerequisites = {"bulk-inserter",FLI.modName.."-fast-inserter"},
    unit = {count = 75, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack", 1}},time = 15}
  }
})



FLI = {}
FLI.modName = "FastLongInserters"
FLI.techIcon = "__"..FLI.modName.. "__/graphics/technology/"..FLI.modName..".png"

data:extend({
	{
    type = "technology",
    name = FLI.modName .. "-1",
    icon = FLI.techIcon,
	icon_size = 32,
    effects = {{type = "unlock-recipe",recipe = FLI.modName.."_fast-inserter"}},
    prerequisites = {"logistics"},
    unit = {count = 75,ingredients = {{"automation-science-pack", 1}},time = 5}
  },
  	{
    type = "technology",
    name = FLI.modName .. "-2",
    icon = FLI.techIcon,
	icon_size = 32,
    effects = {{type = "unlock-recipe",recipe = FLI.modName.."_filter-inserter"}},
    prerequisites = {"logistics","electronics",FLI.modName.."-1"},
    unit = {count = 75, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1}},time = 10}
  },
  {
    type = "technology",
    name = FLI.modName .. "-3",
    icon = FLI.techIcon,
	icon_size = 32,
    effects = {{type = "unlock-recipe", recipe = FLI.modName.."_stack-inserter"},{type = "unlock-recipe", recipe = FLI.modName.."_stack-filter-inserter"}},
    prerequisites = {"stack-inserter",FLI.modName.."-2"},
    unit = {count = 75, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack", 1}},time = 15}
  }
})



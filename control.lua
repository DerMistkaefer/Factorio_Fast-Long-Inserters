FLI = {}
FLI.modName = "FastLongInserters"
FLI.Debug = false
FLI.TestMode = false

function debug_mode()
	if FLI.TestMode == true then
		for _, p in pairs(game.players) do
			p.print(FLI.modName..": TestMode-True")
			p.cheat_mode = true
			p.surface.always_day = true
			p.force.research_all_technologies()
		end
	end
end

function debug_print(message)
	if game ~= nil and FLI.Debug then
		for _, p in pairs(game.players) do
			p.print(message)
		end
	end	
end

function initialize()
	global.FLI = global.FLI or {}
	global.FLI_GUI = global.FLI_GUI or {}
	global.FLI_I = global.FLI_I or {}
	global.FLI_O = global.FLI_O or {}
	global.FLI_I_x = global.FLI_I_x or {}
	global.FLI_I_y = global.FLI_I_y or {}
	global.FLI_O_x = global.FLI_O_x or {}
	global.FLI_O_y = global.FLI_O_y or {}
end

-- when new game started
script.on_init(function()
	initialize()
end)

-- when saved game loaded
script.on_load(function()

end)

--when loaded mods changed
script.on_configuration_changed(function(data)
	initialize()
	
	if data.mod_changes == nil or data.mod_changes[FLI.modName] == nil then
		return
	end
	
	local previousVersion = data.mod_changes[FLI.modName].old_version
	if previousVersion == nil then
		return
	end
	debug_print(previousVersion)
	
	--Migration
end)

--player join
script.on_event(defines.events.on_player_joined_game, function(event)
	debug_mode()
end)

-- Entity build
script.on_event(defines.events.on_built_entity, function(event)
	if string.sub(event.created_entity.name,1,18) == "FastLongInserters_" then
		local player = game.players[event.player_index]
		entity = event.created_entity
		global.FLI[player.index] = entity
		
		global.FLI_GUI[player.index] = true
				
		if global.FLI_I[player.index] and  global.FLI_O[player.index] and global.FLI_I_x[player.index] and  global.FLI_I_y[player.index] and global.FLI_O_x[player.index] and global.FLI_O_y[player.index] then
			entity.pickup_position = {entity.position.x + global.FLI_I_x[player.index], entity.position.y + global.FLI_I_y[player.index]}
			entity.drop_position = {entity.position.x + global.FLI_O_x[player.index], entity.position.y + global.FLI_O_y[player.index]}
		else
			global.FLI_I[player.index] = 2
			global.FLI_O[player.index] = 2
		end
		
		debug_print("Player:" .. player.name)
		debug_print(event.created_entity.name)
		GUI_update(player)
	end
end)

--Entity rotated
script.on_event(defines.events.on_player_rotated_entity, function(event)
	if string.sub(event.entity.name,1,18) == "FastLongInserters_" then
		local player = game.players[event.player_index]
		if player.gui.left.FLI_GUI_base then 
			reEntity(player)
			GUI_arrow(player)
		end
	end
end)

-- GUI Open
script.on_event(defines.events.on_gui_opened, function(event)
	player = game.players[event.player_index]
	if event.gui_type == defines.gui_type.entity and player.gui.left.FLI_GUI_base == nil then
		debug_print("Player:" .. event.entity.name)
		if string.sub(event.entity.name,1,18) == "FastLongInserters_" then
			GUI_open(player, event.entity)
		end
	end
end)

-- GUI Close
script.on_event(defines.events.on_gui_closed, function(event)
	player = game.players[event.player_index]
	if event.gui_type == defines.gui_type.entity and player.gui.left.FLI_GUI_base ~= nil then
		debug_print("Player:" .. event.entity.name)
		if not global.FLI_GUI[player.index] == true then
			if player.opened == nil then
				GUI_close(player)
			elseif not string.sub(player.opened.name,1,18) == "FastLongInserters_" then
				GUI_close(player)
			end
		end
	end
end)

-- GUI action
script.on_event(defines.events.on_gui_click, function(event)
	local player = game.players[event.player_index]
	if (event.element.name == "FLI_GUI_flow_Input_Button_top") then
		if global.FLI_I[player.index] < 10 then global.FLI_I[player.index] = global.FLI_I[player.index] + 1 end
		reEntity(player)
		GUI_update(player)
	elseif (event.element.name == "FLI_GUI_flow_Input_Button_down") then
		if global.FLI_I[player.index] > 1 then global.FLI_I[player.index] = global.FLI_I[player.index] - 1 end
		reEntity(player)
		GUI_update(player)
	elseif (event.element.name == "FLI_GUI_flow_Output_Button_top") then
		if global.FLI_O[player.index] < 10 then global.FLI_O[player.index] = global.FLI_O[player.index] + 1 end
		reEntity(player)
		GUI_update(player)
	elseif (event.element.name == "FLI_GUI_flow_Output_Button_down") then
		if global.FLI_O[player.index] > 1 then global.FLI_O[player.index] =  global.FLI_O[player.index] - 1 end
		reEntity(player)
		GUI_update(player)
	elseif (event.element.name == "FLI_GUI_close") then
		GUI_close(player)
	end
end)

function GUI_close(player)
	if player.gui.left.FLI_GUI_base then
		player.gui.left.FLI_GUI_base.destroy()
		player.clear_gui_arrow()
		player.clear_gui_arrow()
		global.FLI[player.index] = nil
		global.FLI_GUI[player.index] = nil 
		global.FLI_I[player.index] = nil
		global.FLI_O[player.index] = nil
		global.FLI_I_x[player.index] = nil
		global.FLI_I_y[player.index] = nil
		global.FLI_O_x[player.index] = nil
		global.FLI_O_y[player.index] = nil
		if GUI_arrow_I_Name then GUI_arrow_I_Name.destroy() end
		if GUI_arrow_O_Name then GUI_arrow_O_Name.destroy() end
		if GUI_arrow_I then GUI_arrow_I.destroy() end
		if GUI_arrow_O then GUI_arrow_O.destroy() end
		debug_print("F - GUI_close")
	end
end

function reEntity(player)
	local inserter = global.FLI[player.index]

	pickup_position_x = inserter.pickup_position.x - inserter.position.x
	pickup_position_y = inserter.pickup_position.y - inserter.position.y
	drop_position_x = inserter.drop_position.x - inserter.position.x
	drop_position_y = inserter.drop_position.y - inserter.position.y

	global.FLI_I_x[player.index],global.FLI_I_y[player.index] = side(pickup_position_x,pickup_position_y,global.FLI_I[player.index])
	global.FLI_O_x[player.index],global.FLI_O_y[player.index] = side(drop_position_x,drop_position_y,global.FLI_O[player.index]+0.2)

	inserter.pickup_position = {inserter.position.x + global.FLI_I_x[player.index], inserter.position.y + global.FLI_I_y[player.index]}
	inserter.drop_position = {inserter.position.x + global.FLI_O_x[player.index], inserter.position.y + global.FLI_O_y[player.index]}
end

--top    = 0 -
--bottom = 0 +
--left   = - 0
--right  = + 0
function side(x,y,var)
	if x > 0 and y == 0 then return var,0
 	elseif x < 0 and y == 0 then return var*(-1),0
	elseif x == 0 and y > 0 then return 0,var
	elseif x == 0 and y < 0 then return 0,var*(-1)
	end
end

function GUI_open(player, entity)
	global.FLI[player.index] = entity

	pickup_position_x = entity.pickup_position.x-entity.position.x
	pickup_position_y = entity.pickup_position.y-entity.position.y
	drop_position_x = entity.drop_position.x-entity.position.x
	drop_position_y = entity.drop_position.y-entity.position.y

	if pickup_position_x == 0 then global.FLI_I[player.index] = math.floor(pickup_position_y + 0.5)
	elseif pickup_position_y == 0 then global.FLI_I[player.index] = math.floor(pickup_position_x + 0.5) end

	if drop_position_x == 0 then global.FLI_O[player.index] = math.floor(drop_position_y + 0.5)
	elseif drop_position_y == 0 then global.FLI_O[player.index] = math.floor(drop_position_x + 0.5) end

	if global.FLI_I[player.index] <= 0 then global.FLI_I[player.index] = global.FLI_I[player.index] *(-1) end
	if global.FLI_O[player.index] <= 0 then global.FLI_O[player.index] = global.FLI_O[player.index] *(-1) end

	global.FLI_I_x[player.index] = entity.pickup_position.x-entity.position.x
	global.FLI_I_y[player.index] = entity.pickup_position.y-entity.position.y
	global.FLI_O_x[player.index] = entity.drop_position.x-entity.position.x
	global.FLI_O_y[player.index] = entity.drop_position.y-entity.position.y

	GUI_update(player)
end

function GUI_arrow(player)
	local inserter = global.FLI[player.index]
	
	player.clear_gui_arrow()

	if GUI_arrow_I_Name then GUI_arrow_I_Name.destroy() end
	if GUI_arrow_O_Name then GUI_arrow_O_Name.destroy() end
	if GUI_arrow_I then GUI_arrow_I.destroy() end
	if GUI_arrow_O then GUI_arrow_O.destroy() end
	
	player.set_gui_arrow{type="entity", entity=inserter}

	GUI_arrow_I_Name = game.surfaces[1].create_entity{name = "flying-text", text="Input",color={r = 1, g = 1, b = 1, a = 0.5}, position=inserter.pickup_position, force = game.forces.player}
	GUI_arrow_O_Name = game.surfaces[1].create_entity{name = "flying-text", text="Output",color={r = 1, g = 1, b = 1, a = 0.5}, position=inserter.drop_position, force = game.forces.player}

	GUI_arrow_I_Name.active = false
	GUI_arrow_O_Name.active = false
	
	GUI_arrow_I = game.surfaces[1].create_entity{name = "entity-ghost", inner_name="FastLongInserters_Ghost_I", position=inserter.pickup_position, force = game.forces.player}
	GUI_arrow_O = game.surfaces[1].create_entity{name = "entity-ghost", inner_name="FastLongInserters_Ghost_O", position=inserter.drop_position, force = game.forces.player}
end

function GUI_update(player)
	debug_print("F - GUI_print")
	debug_print("Input: " .. global.FLI_I[player.index])
	debug_print("Output: " .. global.FLI_O[player.index])

	GUI_arrow(player)

	debug_print("GUI_normal")
	local gui0 = player.gui.left.FLI_GUI_base
    local destroyed = false
	
    if gui0 then
        player.gui.left.FLI_GUI_base.destroy()
        destroyed = true
    end
	
	if not gui0 or destroyed then
		gui0 = player.gui.left.add{type="frame", name="FLI_GUI_base", direction = "vertical", style = "FLI_base_style"}
		guiF = gui0.add{type="frame", name="FLI_GUI_frame", direction = "vertical", caption = {"gui.FLI-gui-title"}, style = "FLI_frame_style"}
		
		guiI = guiF.add{type="flow",name="FLI_GUI_flow_Input", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiI.add{type = "label", caption = "Input", style = "FLI_label_IO_Button_Titel_style"}
		guiI_Text = guiI.add{type="flow",name="FLI_GUI_flow_Input_Text", direction = "horizontal", style = "FLI__horizontal_flow_style"}
		guiI_Btn = guiI_Text.add{type="flow",name="FLI_GUI_flow_Input_Button", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiI_Btn.add{type="sprite-button",name="FLI_GUI_flow_Input_Button_top", sprite = "FLI_sprite_button_top", style = "FLI_button_IO_Button_style"}
		guiI_Btn.add{type="sprite-button",name="FLI_GUI_flow_Input_Button_down", sprite = "FLI_sprite_button_down", style = "FLI_button_IO_Button_style"}
		guiI_Number = guiI_Text.add{type = "flow", name="FLI_GUI_flow_Input_Number", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiI_Number.add{type = "label", caption = global.FLI_I[player.index], style="FLI_label_IO_Number_style"}
		
		guiO = guiF.add{type="flow",name="FLI_GUI_flow_Output", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiO.add{type = "label", caption = "Output", style = "FLI_label_IO_Button_Titel_style"}
		guiO_Text = guiO.add{type="flow",name="FLI_GUI_flow_Output_Text", direction = "horizontal", style = "FLI__horizontal_flow_style"}
		guiO_Btn = guiO_Text.add{type="flow",name="FLI_GUI_flow_Output_Button", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiO_Btn.add{type="sprite-button",name="FLI_GUI_flow_Output_Button_top", sprite = "FLI_sprite_button_top", style = "FLI_button_IO_Button_style"}
		guiO_Btn.add{type="sprite-button",name="FLI_GUI_flow_Output_Button_down", sprite = "FLI_sprite_button_down", style = "FLI_button_IO_Button_style"}
		guiO_Number = guiO_Text.add{type="flow",name="FLI_GUI_flow_Output_Number", direction = "vertical", style = "FLI_vertical_flow_style"}
		guiO_Number.add{type = "label", caption = global.FLI_O[player.index], style="FLI_label_IO_Number_style"}

		guiF.add{type="button",name="FLI_GUI_close", caption ={"gui.FLI-gui-close"}, style = "FLI_button_style"}
	end
end

function Debug_build(player)
	debug_print("Input: " .. global.FLI_I[player.index])
	debug_print("Output: " .. global.FLI_O[player.index])
	debug_print("Input_x: " .. global.FLI_I_x[player.index])
	debug_print("Input_y: " .. global.FLI_I_y[player.index])
	debug_print("Output_x: " .. global.FLI_O_x[player.index])
	debug_print("Output_y: " .. global.FLI_O_y[player.index])
end

function Debug_reEntity(inserter)
	debug_print("DEBUG-START")
	debug_print("position.x" .. inserter.position.x)
	debug_print("position.y" .. inserter.position.y)
	debug_print("pickup_position.x" .. inserter.pickup_position.x)
	debug_print("pickup_position.y" .. inserter.pickup_position.y)
	debug_print("drop_position.x" .. inserter.drop_position.x)
	debug_print("drop_position.y" .. inserter.drop_position.y)
	debug_print("DEBUG-END")
end

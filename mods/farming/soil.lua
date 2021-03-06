
--= Soil Functions

-- Normal Soil

minetest.register_node("farming:soil", {
	description = "Soil",
	tiles = {"farming_soil.png", "default_dirt.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_alias("farming:desert_sand_soil", "farming:soil")

-- Wet Soil

minetest.register_node("farming:soil_wet", {
	description = "Wet Soil",
	tiles = {"farming_soil_wet.png", "farming_soil_wet_side.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_alias("farming:desert_sand_soil_wet", "farming:soil_wet")

-- Rich Soil

minetest.register_node("farming:rich_soil", {
	description = "Rich Soil",
	tiles = {"farming_rich_soil.png", "skylands_rich_dirt.png"},
	drop = "skylands:rich_dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2},
	sounds = default.node_sound_dirt_defaults(),
})

-- Wet Soil

minetest.register_node("farming:rich_soil_wet", {
	description = "Wet, Rich Soil",
	tiles = {"farming_soil_wet.png", "skylands_rich_soil.png"},
	drop = "skylands:rich_dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3},
	sounds = default.node_sound_dirt_defaults(),
})

-- If Water near Soil then turn into Wet Soil

minetest.register_abm({
	nodenames = {"farming:soil", "farming:soil_wet", "farming:rich_soil", "farming:rich_soil_wet"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		pos.y = pos.y+1
		local nn = minetest.get_node(pos).name
		pos.y = pos.y-1
		if minetest.registered_nodes[nn] and
				minetest.registered_nodes[nn].walkable and
				minetest.get_item_group(nn, "plant") == 0
		then
			minetest.set_node(pos, {name="default:dirt"})
		end
		-- check if there is water nearby
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil turn it into wet soil
			if node.name == "farming:soil" then
				minetest.set_node(pos, {name="farming:soil_wet"})
			elseif node.name == "farming:rich_soil" then
				minetest.set_node(pos, {name="farming:rich_soil_wet"})
			end
		else
			-- turn it back into dirt if it is already dry
			if node.name == "farming:soil" then
				-- only turn it back if there is no plant on top of it
				if minetest.get_item_group(nn, "plant") == 0 then
					minetest.set_node(pos, {name="default:dirt"})
				end
				
			-- if its wet turn it back into dry soil
			elseif node.name == "farming:soil_wet" then
				minetest.set_node(pos, {name="farming:soil"})
				
			elseif node.name == "farming:rich_soil" then
				-- only turn it back if there is no plant on top of it
				if minetest.get_item_group(nn, "plant") == 0 then
					minetest.set_node(pos, {name="skylands:rich_dirt"})
				end
				
			-- if its wet turn it back into dry soil
			elseif node.name == "farming:rich_soil_wet" then
				minetest.set_node(pos, {name="farming:rich_soil"})
			end
		end
	end,
})
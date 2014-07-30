
--= Hoes

-- Turns nodes with group soil=1 into soil

function farming.hoe_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local upos = pointed_thing.under

	if minetest.is_protected(upos, user:get_player_name()) then
		minetest.record_protection_violation(upos, user:get_player_name())
		return
	end

	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, wear out item and play sound
	if under.name == "skylands:rich_dirt" then
		minetest.set_node(pt.under, {name="farming:rich_soil"})
	else
		minetest.set_node(pt.under, {name="farming:soil"})
	end
	minetest.sound_play("default_dig_crumbly", {pos = pt.under, gain = 0.5,})
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

-- Wooden Hoe

minetest.register_tool("farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 30)
	end,
})

minetest.register_craft({
	output = "farming:hoe_wood",
	recipe = {
		{"group:wood", "group:wood"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

-- Stone Hoe

minetest.register_tool("farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 90)
	end,
})

minetest.register_craft({
	output = "farming:hoe_stone",
	recipe = {
		{"group:stone", "group:stone"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

-- Steel Hoe

minetest.register_tool("farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 200)
	end,
})

minetest.register_craft({
	output = "farming:hoe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

-- Bronze Hoe

minetest.register_tool("farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 220)
	end,
})

minetest.register_craft({
	output = "farming:hoe_bronze",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

-- Mese

minetest.register_tool("farming:hoe_mese", {
	description = "Mese Hoe",
	inventory_image = "farming_tool_mesehoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 350)
	end,
})

minetest.register_craft({
	output = "farming:hoe_mese",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

-- Diamond

minetest.register_tool("farming:hoe_diamond", {
	description = "Diamond Hoe",
	inventory_image = "farming_tool_diamondhoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 500)
	end,
})

minetest.register_craft({
	output = "farming:hoe_diamond",
	recipe = {
		{"default:diamond", "default:diamond"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})
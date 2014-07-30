--[[
	Minetest Farming Redo Mod 0.5 (26 July 2014)
	by TenPlus1
	Some additions by HeroOfTheWinds for use with SkyTest
]]

farming = {}
farming.hoe_on_use = default.hoe_on_use

dofile(minetest.get_modpath("farming").."/soil.lua")
dofile(minetest.get_modpath("farming").."/hoes.lua")
dofile(minetest.get_modpath("farming").."/grass.lua")
dofile(minetest.get_modpath("farming").."/wheat.lua")
dofile(minetest.get_modpath("farming").."/cotton.lua")
dofile(minetest.get_modpath("farming").."/carrot.lua")
dofile(minetest.get_modpath("farming").."/potato.lua")
dofile(minetest.get_modpath("farming").."/tomato.lua")
dofile(minetest.get_modpath("farming").."/cucumber.lua")
dofile(minetest.get_modpath("farming").."/mapgen.lua")

-- Place Seeds on Soil

function place_seed(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return
	end
	
	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return
	end
	
	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") <= 1 then
		return
	end
	
	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name=plantname})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

-- Single ABM Handles Growing of All Plants

minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:soil_wet"},
	interval = 70,
	chance = 2,
	
	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)

		local len = string.len(node.name)
		local plant = string.sub(node.name, 1, len - 1)
		local numb = string.sub(node.name,len, len)

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then
			return
		end
		
		-- check if on wet soil
		pos.y = pos.y-1
		local n = minetest.get_node(pos)
		if n.name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		
		-- check light
		if minetest.get_node_light(pos) < 13 then
			return
		end
		
		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})
	end
})

--double speed for rich soil
minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:rich_soil_wet"},
	interval = 35,
	chance = 2,
	
	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)

		local len = string.len(node.name)
		local plant = string.sub(node.name, 1, len - 1)
		local numb = string.sub(node.name,len, len)

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then
			return
		end
		
		-- check if on wet soil
		pos.y = pos.y-1
		local n = minetest.get_node(pos)
		if n.name ~= "farming:rich_soil_wet" then
			return
		end
		pos.y = pos.y+1
		
		-- check light
		if minetest.get_node_light(pos) < 13 then
			return
		end
		
		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})
	end
})

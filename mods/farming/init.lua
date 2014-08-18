--[[
	Minetest Farming Redo Mod 1.0 (13th August 2014)
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
dofile(minetest.get_modpath("farming").."/corn.lua")
dofile(minetest.get_modpath("farming").."/coffee.lua")
dofile(minetest.get_modpath("farming").."/melon.lua")
dofile(minetest.get_modpath("farming").."/sugar.lua")
dofile(minetest.get_modpath("farming").."/pumpkin.lua")
dofile(minetest.get_modpath("farming").."/cocoa.lua")
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
	neighbors = {"farming:soil_wet", "default:jungletree"},
	interval = 70, -- 70
	chance = 2,
	
	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)

		local data = nil
		data = string.split(node.name, '_', 2)
		local plant = data[1].."_"
		local numb = data[2]

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then
			return
		end
		
		-- Check for Cocoa Pod
		if plant == "farming:cocoa_" and minetest.find_node_near(pos, 1, {"default:jungletree"})then
		
		else
		
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
		
		end
		
		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})
		
		-- check for corn
		if plant == "farming:corn_" and tonumber(numb) > 4 then
			pos.y = pos.y + 1
			minetest.set_node(pos, {name=plant..(numb + 1)})
		end
	end
})

--double speed for rich soil
minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:rich_soil_wet"},
	interval = 35, -- originally 70
	chance = 2,
	
	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)

		local data = nil
		data = string.split(node.name, '_', 2)
		local plant = data[1].."_"
		local numb = data[2]

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then
			return
		end
		
		-- Check for Cocoa Pod
		if plant == "farming:cocoa_" and minetest.find_node_near(pos, 1, {"default:jungletree"})then
		
		else
		
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
		
		end
		
		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})
		
		-- check for corn
		if plant == "farming:corn_" and tonumber(numb) > 4 then
			pos.y = pos.y + 1
			minetest.set_node(pos, {name=plant..(numb + 1)})
		end
	end
})

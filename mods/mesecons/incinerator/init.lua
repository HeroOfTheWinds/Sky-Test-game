--incinerator mod
--used by mesecons, creates a block to generate fire in the space above the block.

--craft recipe: S=steel_ingot, O=stone, M=mesecon, L=lava_source or bucket_lava
--S S S
--O L O
--O M O

local incinerator_on = function (pos, node)
	np = {x = pos.x, y = pos.y+1, z = pos.z}
	up_node = minetest.get_node(np)
	if up_node.name == "air" or minetest.get_item_group(up_node.name, "flammable") >= 1 then
		minetest.set_node(np, {name="fire:basic_flame"})
		print("placed fire at "..np.x.." "..np.y.." "..np.z..".")
	end
	minetest.set_node(pos, {name="incinerator:incinerator_active"})
end

local incinerator_off = function (pos, node)
	np = {pos.x, pos.y+1, pos.z}
	up_node = minetest.get_node(np)
	if up_node.name == "fire:basic_flame" then
		minetest.remove_node(np)
	end
	minetest.set_node(pos, {name="incinerator:incinerator_neutral"})
end

local incinerator_destroy = function (pos, node)
	np = {pos.x, pos.y+1, pos.z}
	up_node = minetest.get_node(np)
	if up_node.name == "fire:basic_flame" then
		minetest.remove_node(np)
	end
end

-- offstate
minetest.register_node("incinerator:incinerator_neutral", {
	description = "Incinerator",
	tiles = {
		"incinerator_top.png", 
		"incinerator_bottom.png", 
		"incinerator_side.png", 
		"incinerator_side.png", 
		"incinerator_side.png", 
		"incinerator_side.png"
		},
	groups = {cracky = 3},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "size[8,9]"..
		"list[current_name;trash;2,1;2,2;]"..
		"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Incinerator")
		local inv = meta:get_inventory()
		inv:set_size("trash", 4)		
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("trash") then
			return false
		end
		return true
	end,
	mesecons = {effector={
		action_on = incinerator_on
	}}
})

-- onstate
minetest.register_node("incinerator:incinerator_active", {
	description = "Incinerator",
	tiles = {
		"incinerator_active_top.png", 
		"incinerator_bottom.png", 
		"incinerator_active_side.png", 
		"incinerator_active_side.png", 
		"incinerator_active_side.png", 
		"incinerator_active_side.png"
		},
	groups = {cracky = 3, not_in_creative_inventory=1},
	drop = "incinerator:incinerator_neutral",
	after_dig_node = incinerator_destroy,
	light_source = 5,
	mesecons = {effector={
		action_off = incinerator_off
	}}
})

minetest.register_craft({
	output = "incinerator:incinerator_neutral",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:stone","default:lava_source","default:stone"},
		{"default:stone","mesecons:mesecon","default:stone"}
	}
})

minetest.register_craft({
	output = "incinerator:incinerator_neutral",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:stone","bucket:bucket_lava","default:stone"},
		{"default:stone","mesecons:mesecon","default:stone"}
	},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
})

minetest.register_alias("mesecons:incinerator", "incinerator:incinerator_neutral")
minetest.register_alias("incinerator:incinerator", "incinerator:incinerator_neutral")
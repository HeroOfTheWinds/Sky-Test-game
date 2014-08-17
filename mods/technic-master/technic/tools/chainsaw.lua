-- Configuration

local chainsaw_max_charge      = 30000 -- Maximum charge of the saw
-- Gives 2500 nodes on a single charge (about 50 complete normal trees)
local chainsaw_charge_per_node = 12
-- Cut down tree leaves.  Leaf decay may cause slowness on large trees
-- if this is disabled.
local chainsaw_leaves = true

-- The default trees
local timber_nodenames = {
	["default:jungletree"] = true,
	["default:papyrus"]    = true,
	["default:cactus"]     = true,
	["default:tree"]       = true,
	["default:apple"]      = true,
}

if chainsaw_leaves then
	timber_nodenames["default:leaves"] = true
	timber_nodenames["default:jungleleaves"] = true
end

-- technic_worldgen defines rubber trees if moretrees isn't installed
if minetest.get_modpath("technic_worldgen") or
		minetest.get_modpath("moretrees") then
	timber_nodenames["moretrees:rubber_tree_trunk_empty"] = true
	timber_nodenames["moretrees:rubber_tree_trunk"]       = true
	if chainsaw_leaves then
		timber_nodenames["moretrees:rubber_tree_leaves"] = true
	end
end

-- Support moretrees if it is there
if minetest.get_modpath("moretrees") then
	timber_nodenames["moretrees:apple_tree_trunk"]                 = true
	timber_nodenames["moretrees:apple_tree_trunk_sideways"]        = true
	timber_nodenames["moretrees:beech_trunk"]                      = true
	timber_nodenames["moretrees:beech_trunk_sideways"]             = true
	timber_nodenames["moretrees:birch_trunk"]                      = true
	timber_nodenames["moretrees:birch_trunk_sideways"]             = true
	timber_nodenames["moretrees:fir_trunk"]                        = true
	timber_nodenames["moretrees:fir_trunk_sideways"]               = true
	timber_nodenames["moretrees:oak_trunk"]                        = true
	timber_nodenames["moretrees:oak_trunk_sideways"]               = true
	timber_nodenames["moretrees:palm_trunk"]                       = true
	timber_nodenames["moretrees:palm_trunk_sideways"]              = true
	timber_nodenames["moretrees:pine_trunk"]                       = true
	timber_nodenames["moretrees:pine_trunk_sideways"]              = true
	timber_nodenames["moretrees:rubber_tree_trunk_sideways"]       = true
	timber_nodenames["moretrees:rubber_tree_trunk_sideways_empty"] = true
	timber_nodenames["moretrees:sequoia_trunk"]                    = true
	timber_nodenames["moretrees:sequoia_trunk_sideways"]           = true
	timber_nodenames["moretrees:spruce_trunk"]                     = true
	timber_nodenames["moretrees:spruce_trunk_sideways"]            = true
	timber_nodenames["moretrees:willow_trunk"]                     = true
	timber_nodenames["moretrees:willow_trunk_sideways"]            = true
	timber_nodenames["moretrees:jungletree_trunk"]                 = true
	timber_nodenames["moretrees:jungletree_trunk_sideways"]        = true

	if chainsaw_leaves then
		timber_nodenames["moretrees:apple_tree_leaves"]        = true
		timber_nodenames["moretrees:oak_leaves"]               = true
		timber_nodenames["moretrees:fir_leaves"]               = true
		timber_nodenames["moretrees:fir_leaves_bright"]        = true
		timber_nodenames["moretrees:sequoia_leaves"]           = true
		timber_nodenames["moretrees:birch_leaves"]             = true
		timber_nodenames["moretrees:birch_leaves"]             = true
		timber_nodenames["moretrees:palm_leaves"]              = true
		timber_nodenames["moretrees:spruce_leaves"]            = true
		timber_nodenames["moretrees:spruce_leaves"]            = true
		timber_nodenames["moretrees:pine_leaves"]              = true
		timber_nodenames["moretrees:willow_leaves"]            = true
		timber_nodenames["moretrees:jungletree_leaves_green"]  = true
		timber_nodenames["moretrees:jungletree_leaves_yellow"] = true
		timber_nodenames["moretrees:jungletree_leaves_red"]    = true
	end
end

-- Support growing_trees
if minetest.get_modpath("growing_trees") then
	timber_nodenames["growing_trees:trunk"]         = true
	timber_nodenames["growing_trees:medium_trunk"]  = true
	timber_nodenames["growing_trees:big_trunk"]     = true
	timber_nodenames["growing_trees:trunk_top"]     = true
	timber_nodenames["growing_trees:trunk_sprout"]  = true
	timber_nodenames["growing_trees:branch_sprout"] = true
	timber_nodenames["growing_trees:branch"]        = true
	timber_nodenames["growing_trees:branch_xmzm"]   = true
	timber_nodenames["growing_trees:branch_xpzm"]   = true
	timber_nodenames["growing_trees:branch_xmzp"]   = true
	timber_nodenames["growing_trees:branch_xpzp"]   = true
	timber_nodenames["growing_trees:branch_zz"]     = true
	timber_nodenames["growing_trees:branch_xx"]     = true

	if chainsaw_leaves then
		timber_nodenames["growing_trees:leaves"] = true
	end
end

-- Support growing_cactus
if minetest.get_modpath("growing_cactus") then
	timber_nodenames["growing_cactus:sprout"]                       = true
	timber_nodenames["growing_cactus:branch_sprout_vertical"]       = true
	timber_nodenames["growing_cactus:branch_sprout_vertical_fixed"] = true
	timber_nodenames["growing_cactus:branch_sprout_xp"]             = true
	timber_nodenames["growing_cactus:branch_sprout_xm"]             = true
	timber_nodenames["growing_cactus:branch_sprout_zp"]             = true
	timber_nodenames["growing_cactus:branch_sprout_zm"]             = true
	timber_nodenames["growing_cactus:trunk"]                        = true
	timber_nodenames["growing_cactus:branch_trunk"]                 = true
	timber_nodenames["growing_cactus:branch"]                       = true
	timber_nodenames["growing_cactus:branch_xp"]                    = true
	timber_nodenames["growing_cactus:branch_xm"]                    = true
	timber_nodenames["growing_cactus:branch_zp"]                    = true
	timber_nodenames["growing_cactus:branch_zm"]                    = true
	timber_nodenames["growing_cactus:branch_zz"]                    = true
	timber_nodenames["growing_cactus:branch_xx"]                    = true
end

-- Support farming_plus
if minetest.get_modpath("farming_plus") then
	if chainsaw_leaves then
		timber_nodenames["farming_plus:cocoa_leaves"] = true
	end
end


local S = technic.getter

technic.register_power_tool("technic:chainsaw", chainsaw_max_charge)

-- Table for saving what was sawed down
local produced = {}

-- Save the items sawed down so that we can drop them in a nice single stack
local function handle_drops(drops)
	for _, item in ipairs(drops) do
		local stack = ItemStack(item)
		local name = stack:get_name()
		local p = produced[name]
		if not p then
			produced[name] = stack
		else
			p:set_count(p:get_count() + stack:get_count())
		end
	end
end

--- Iterator over positions to try to saw around a sawed node.
-- This returns nodes in a 3x2x3 area. It does not return lower (y) positions
-- to prevent the chainsaw from cutting down nodes below the cutting position.
-- @param pos Reference to sawing position.  Note that this is overridden.
local function iterSawTries(pos)
	-- Shift the position down on the x and z axes
	pos.x, pos.z = pos.x - 1, pos.z - 1
	-- Save our starting position for reseting it later
	local startx, startz = pos.x, pos.z
	-- We will move out by one in every direction except -y
	local endx, endy, endz = pos.x + 2, pos.y + 1, pos.z + 2
	-- Adjust for initial increment
	pos.x = pos.x - 1

	return function()
		if pos.x < endx then
			pos.x = pos.x + 1
		else
			pos.x = startx
			if pos.z < endz then
				pos.z = pos.z + 1
			else
				pos.z = startz
				if pos.y < endy then
					pos.y = pos.y + 1
				else
					return nil
				end
			end
		end
		return pos
	end
end

-- This function does all the hard work. Recursively we dig the node at hand
-- if it is in the table and then search the surroundings for more stuff to dig.
local function recursive_dig(pos, remaining_charge)
	if remaining_charge < chainsaw_charge_per_node then
		return remaining_charge
	end
	local node = minetest.get_node(pos)

	if not timber_nodenames[node.name] then
		return remaining_charge
	end

	-- wood found - cut it
	handle_drops(minetest.get_node_drops(node.name, ""))
	minetest.remove_node(pos)
	remaining_charge = remaining_charge - chainsaw_charge_per_node

	-- Check surroundings and run recursively if any charge left
	for pos in iterSawTries(pos) do
		if remaining_charge < chainsaw_charge_per_node then
			break
		end
		if timber_nodenames[minetest.get_node(pos).name] then
			remaining_charge = recursive_dig(pos, remaining_charge)
		end
	end
	return remaining_charge
end

-- Function to randomize positions for new node drops
local function get_drop_pos(pos)
	local drop_pos = {}

	for i = 0, 8 do
		-- Randomize position for a new drop
		drop_pos.x = pos.x + math.random(-3, 3)
		drop_pos.y = pos.y - 1
		drop_pos.z = pos.z + math.random(-3, 3)

		-- Move the randomized position upwards until
		-- the node is air or unloaded.
		for y = drop_pos.y, drop_pos.y + 5 do
			drop_pos.y = y
			local node = minetest.get_node_or_nil(drop_pos)

			if not node then
				-- If the node is not loaded yet simply drop
				-- the item at the original digging position.
				return pos
			elseif node.name == "air" then
				-- Add variation to the entity drop position,
				-- but don't let drops get too close to the edge
				drop_pos.x = drop_pos.x + (math.random() * 0.8) - 0.5
				drop_pos.z = drop_pos.z + (math.random() * 0.8) - 0.5
				return drop_pos
			end
		end
	end

	-- Return the original position if this takes too long
	return pos
end

-- Chainsaw entry point
local function chainsaw_dig(pos, current_charge)
	-- Start sawing things down
	local remaining_charge = recursive_dig(pos, current_charge)
	minetest.sound_play("chainsaw", {pos = pos, gain = 1.0,
			max_hear_distance = 10})

	-- Now drop items for the player
	for name, stack in pairs(produced) do
		-- Drop stacks of stack max or less
		local count, max = stack:get_count(), stack:get_stack_max()
		stack:set_count(max)
		while count > max do
			minetest.add_item(get_drop_pos(pos), stack)
			count = count - max
		end
		stack:set_count(count)
		minetest.add_item(get_drop_pos(pos), stack)
	end

	-- Clean up
	produced = {}

	return remaining_charge
end


minetest.register_tool("technic:chainsaw", {
	description = S("Chainsaw"),
	inventory_image = "technic_chainsaw.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local meta = minetest.deserialize(itemstack:get_metadata())
		if not meta or not meta.charge or
				meta.charge < chainsaw_charge_per_node then
			return
		end

		local name = user:get_player_name()
		if minetest.is_protected(pointed_thing.under, name) then
			minetest.record_protection_violation(pointed_thing.under, name)
			return
		end

		-- Send current charge to digging function so that the
		-- chainsaw will stop after digging a number of nodes
		meta.charge = chainsaw_dig(pointed_thing.under, meta.charge)

		technic.set_RE_wear(itemstack, meta.charge, chainsaw_max_charge)
		itemstack:set_metadata(minetest.serialize(meta))
		return itemstack
	end,
})

minetest.register_craft({
	output = "technic:chainsaw",
	recipe = {
		{"technic:stainless_steel_ingot", "mesecons_button:button_off", "technic:battery"},
		{"technic:fine_copper_wire",      "technic:motor",              "technic:battery"},
		{"",                              "",                           "technic:stainless_steel_ingot"},
	}
})


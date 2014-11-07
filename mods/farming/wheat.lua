
--= Wheat

-- Wheat Seed

--minetest.register_craftitem("farming:seed_wheat", {
--	description = "Wheat Seed",
--	inventory_image = "farming_wheat_seed.png",
--	on_place = function(itemstack, placer, pointed_thing)
--		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
--	end,
--})

minetest.register_node("farming:seed_wheat", {
	description = "Wheat Seed",
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end,
})

-- Harvested Wheat

minetest.register_craftitem("farming:wheat", {
	description = "Wheat",
	inventory_image = "farming_wheat.png",
})

-- flour

minetest.register_craftitem("farming:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"}
})

-- Bread

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

-- Define Wheat growth stages

minetest.register_node("farming:wheat_1", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_2", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_2.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_3", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_4", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_5", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_5.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:wheat'},rarity=2},
			{items = {'farming:seed_wheat'},rarity=2},
		}
	},
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_6", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_6.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:wheat'},rarity=2},
			{items = {'farming:seed_wheat'},rarity=1},
		}
	},
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_7", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_7.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:wheat'},rarity=1},
			{items = {'farming:wheat'},rarity=3},
			{items = {'farming:seed_wheat'},rarity=1},
			{items = {'farming:seed_wheat'},rarity=3},
		}
	},
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1,growing=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of Wheat growth doesnnot have growing=1 so abm never has to check these

minetest.register_node("farming:wheat_8", {
	drawtype = "plantlike",
	tiles = {"farming_wheat_8.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:wheat'},rarity=1},
			{items = {'farming:wheat'},rarity=2},
			{items = {'farming:seed_wheat'},rarity=1},
			{items = {'farming:seed_wheat'},rarity=2},
		}
	},
	selection_box = {type = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
	groups = {snappy=3,flammable=2,plant=1,not_in_creative_inventory=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

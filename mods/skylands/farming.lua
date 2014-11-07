function skylands:farmplant(data, vi)
	local c_potato = minetest.get_content_id("farming:potato_3")
	local c_carrot = minetest.get_content_id("farming:carrot_7")
	local c_tomato = minetest.get_content_id("farming:tomato_7")
	local c_cucumber = minetest.get_content_id("farming:cucumber_4")
	local c_corn = minetest.get_content_id("farming:corn_7")
	local c_coffee = minetest.get_content_id("farming:coffee_5")
	local c_melon = minetest.get_content_id("farming:melon_8")
	local c_pumpkin = minetest.get_content_id("farming:pumpkin_8")
	local c_raspberry = minetest.get_content_id("farming:raspberry_4")
	local c_rhubarb = minetest.get_content_id("farming:rhubarb_3")
	local c_blueberry = minetest.get_content_id("farming:blueberry_4")
	local rand = math.random(1,11)
	if rand == 1 then
		data[vi] = c_potato
	elseif rand == 2 then
		data[vi] = c_carrot
	elseif rand == 3 then
		data[vi] = c_tomato
	elseif rand == 4 then
		data[vi] = c_cucumber
	elseif rand == 5 then
		data[vi] = c_corn
	elseif rand == 6 then
		data[vi] = c_coffee
	elseif rand == 7 then
		data[vi] = c_melon
	elseif rand == 8 then
		data[vi] = c_pumpkin
	elseif rand == 9 then
		data[vi] = c_raspberry
	elseif rand == 10 and ground_y > 10 then
		data[vi] = c_rhubarb
	else
		data[vi] = c_blueberry
	end
end
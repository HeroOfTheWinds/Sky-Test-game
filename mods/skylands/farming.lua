function skylands:farmplant(data, vi)
	local c_potato = minetest.get_content_id("farming:potato_3")
	local c_carrot = minetest.get_content_id("farming:carrot_7")
	local c_tomato = minetest.get_content_id("farming:tomato_7")
	local c_cucumber = minetest.get_content_id("farming:cucumber_4")
	local rand = math.random(1,4)
	if rand == 1 then
		data[vi] = c_potato
	elseif rand == 2 then
		data[vi] = c_carrot
	elseif rand == 3 then
		data[vi] = c_tomato
	else
		data[vi] = c_cucumber
	end
end
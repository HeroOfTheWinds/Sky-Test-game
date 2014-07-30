
-- Generate new foods on map

minetest.register_on_generated(function(minp, maxp, seed)

	local perlin1 = minetest.get_perlin(329, 3, 0.6, 100)

	-- Assume X and Z lengths are equal
	local divlen = 16
	local divs = (maxp.x-minp.x)/divlen+1;

	for divx=0,divs-1 do
		for divz=0,divs-1 do

			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)

			-- Determine grass amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 9)

			-- Find random positions for grass based on this random
			local pr = PseudoRandom(seed+1)

			for i=0,grass_amount do

				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)

				-- Find ground level (0...15)
				local ground_y = nil

				for y=30,0,-1 do
					if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				
				if ground_y then

					local p = {x=x,y=ground_y+1,z=z}
					local nn = minetest.get_node(p).name

					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and

						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x,y=ground_y,z=z}).name

						-- If dirt with grass, add plant in various stages of maturity
						if nn == "default:dirt_with_grass" then
						
							local type = math.random(1,4)
							if type == 1 then
								minetest.set_node(p,{name="farming:potato_"..pr:next(3, 4)})
							else if type == 2 then
								minetest.set_node(p,{name="farming:tomato_"..pr:next(7, 8)})
							else if type == 3 then
								minetest.set_node(p,{name="farming:carrot_"..pr:next(7, 8)})
							else
								minetest.set_node(p,{name="farming:cucumber_4"})
							end
						end
					end
				end
			end
		end
	end
end
end
end)

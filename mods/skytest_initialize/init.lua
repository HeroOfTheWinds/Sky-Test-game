mgparams = {mgname="singlenode"}
minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params(mgparams)
end)

-- 2D noise for wave

local np_wave = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = -400000000089,
	octaves = 3,
	persist = 0.5
}

minetest.register_on_generated(function(minp, maxp, seed)

	if minp.x < -90 or maxp.x > 90
	or minp.y < -90 or maxp.y > 90
	or minp.z < -90 or maxp.z > 90 then
		return
	end
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local c_stone = minetest.get_content_id("skylands:stone")
	local c_grass = minetest.get_content_id("default:dirt_with_grass")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_air = minetest.get_content_id("air")
	local c_sand = minetest.get_content_id("default:sand")
	local c_water = minetest.get_content_id("default:water_source")
	
	local HSIZE = 30 --radius of the island
	local PEAK = 4 --height of the island
	local TROUGH = 12 --how "deep" is the island?
	
	--local WAVAMP = 6 -- Structure wave amplitude
	--local HISCAL = 9 -- Upper structure vertical scale
	--local LOSCAL = 9 -- Lower structure vertical scale
	--local HIEXP = 0.5 -- Upper structure density gradient exponent
	--local LOEXP = 0.5 -- Lower structure density gradient exponent
	
	--local nvals_wave = minetest.get_perlin_map(np_wave, {x=80, y=80, z=80}):get2dMap_flat({x=0, y=0, z=0})
	
	
	--loop over all positions within island's bounding box
	for y = -TROUGH, PEAK do
		--determine radius for this 'level'
		local rad = HSIZE - (math.abs(y)+1)	
		for z = -HSIZE, HSIZE do
			for x = -HSIZE, HSIZE do
				--idek
			--	local flomid = -40 + nvals_wave[1] * WAVAMP
			--	local grad
			--	if y > flomid then
			--		grad = ((y - flomid) / HISCAL) ^ HIEXP
			--	else
			--		grad = ((flomid - y) / LOSCAL) ^ LOEXP
			--	end
				--lol
			--	y = math.floor(flomid)
			--	local vi = area:index(x, y, z)
			--	data[vi] = c_stone
				
				
				--generate central lake
				local l_rad = (HSIZE - (HSIZE * 1/2)) - (math.abs(y)+1)
				local rad_max = (HSIZE - (HSIZE * 1/2))
				if z*z + x*x <= rad * rad then
					if z*z + x*x <= l_rad * l_rad and y <= 0 then
						local vi = area:index(x, y-10, z)
						if y >= -TROUGH /2 then
							data[vi] = c_water
						else
							data[vi] = c_stone
						end
					elseif y > 0 and z*z + x*x <= rad_max * rad_max then
						local vi = area:index(x, y-10, z)
						data[vi] = c_air
					else
						local vi = area:index(x, y-10, z)
						if y > 0 then
							data[vi] = c_grass
						elseif y == 0 then
							data[vi] = c_sand
						elseif y > -TROUGH / 2 then
							data[vi] = c_dirt
						else
							data[vi] = c_stone
						end
					end
				end
				for ny = 1, PEAK do
					t_rad = rad_max + ny
					if z*z + x*x <= t_rad * t_rad then
						local vi = area:index(x, ny-10, z)
						data[vi] = c_air
					end
				end
			end
		end
	end
	for y = -TROUGH-10, -TROUGH-9 do
		for x = -1, 1 do
			for z = -1, 1 do
				local vi = area:index(x, y, z)
				data[vi] = c_stone
			end
		end
	end
	
	
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)
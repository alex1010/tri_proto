local Vector2d = require "Vector2d"

local triangle = {
	a = 90,
	s = 5
}

local sq3 = math.sqrt(3)

local av = Vector2d.new(-sq3/2, -0.5)
local bv = Vector2d.new(0, 1)
local cv = Vector2d.new(sq3/2, -0.5)

function triangle:delta()
	return self.a / sq3 + self.s
end

function triangle:center(i, j)
	local delta = self:delta()
	local floor = math.floor
	local acomp = av:scale(-floor((i + (j % 2)) * 0.5))
	local bcomp = bv:scale(j + floor(j * 0.5))
	local ccomp = cv:scale(floor((i + ((j+1) % 2)) * 0.5))
	-- print(av, bv, cv)
	-- print(acomp, bcomp, ccomp)
	local centerVect = acomp + bcomp  + ccomp

	return centerVect:scale(delta)
end

function triangle:orientation(i, j)
	return (i + j) % 2 == 0 
end

function triangle:vertices(i, j)
	local R = self.a / sq3
	local sign = 1
	if self:orientation(i, j) then
		sign = -1
	end
	local vectors = { av:scale(sign), bv:scale(sign), cv:scale(sign) }
	local result = {}
	for _, vector in ipairs(vectors) do
		table.insert(result, vector.x * R)
		table.insert(result, vector.y * R)
	end
	return result
end

function triangle:neighbors(i, j)

end


return triangle
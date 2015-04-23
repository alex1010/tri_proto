local Vector2d = require "Vector2d"
local triangle = require "triangle"
local a = 90
local s = 5
local sq3 = math.sqrt(3)
local r = a / (2*sq3)
local R = 2 * r
local delta = R + s
print(delta)

local av = Vector2d.new(-sq3/2, -0.5)
local bv = Vector2d.new(0, 1)
local cv = Vector2d.new(sq3/2, -0.5)

function center(v)
	local floor = math.floor
	local acomp = av:scale(-floor((v.x + (v.y % 2)) * 0.5))
	local bcomp = bv:scale(v.y + floor(v.y * 0.5))
	local ccomp = cv:scale(floor((v.x + ((v.y+1) % 2)) * 0.5))
	print(av, bv, cv)
	print(acomp, bcomp, ccomp)
	local centerVect = acomp + bcomp  + ccomp

	return centerVect:scale(delta)
end 

local gr = display.newGroup()
gr.x, gr.y = display.contentCenterX, display.contentCenterY

function draw(v)
	display.newCircle(gr, v.x, v.y, 5):setFillColor(math.random(), math.random(), math.random())
end

function drawTriangle(v)
	local trCenter = center(v)
	local sh = {x = 0, y = -20}
	local vectors = { av, bv, cv }
	if (v.x + v.y) % 2 == 0 then
		vectors = { -av, -bv, -cv }
	end
	local vertices = {}
	for _, vect in ipairs(vectors) do
		table.insert(vertices, vect.x * R)
		table.insert(vertices, vect.y * R)
	end
	print("----")
	print(v)
	print(trCenter)
	for _, vert in ipairs(vertices) do
		print(vert)
	end
	triangle = display.newPolygon(gr, trCenter.x, trCenter.y, vertices)
	triangle:setFillColor(math.random(), math.random(), math.random())
	triangle.anchorX, triangle.anchorY = 0.5, (1 + (v.y + v.x + 1) % 2) / 3
end

for i = -10, 20 do
	for j = -10, 20 do
		local v = Vector2d.new(i, j)
		-- print(v, center(v))
		centerVect = center(v)
		drawTriangle(v)
		-- draw(centerVect)
	end
end


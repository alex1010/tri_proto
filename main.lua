local Vector2d = require "Vector2d"
local triangle = require "triangle"

local gr = display.newGroup()
gr.x, gr.y = display.contentCenterX, display.contentCenterY

function drawTriangle(i, j, color)
	local c = triangle:center(i, j)
	local polygon = display.newPolygon(gr, c.x, c.y, triangle:vertices(i, j))
	polygon:setFillColor(math.random(), math.random(), math.random())

	polygon.anchorX, polygon.anchorY = 0.5, ((i + j + 1) % 2) / 3
end

for i = -10, 20 do
	for j = -10, 20 do
		drawTriangle(i, j)
	end
end


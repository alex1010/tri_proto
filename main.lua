local Vector2d = require "Vector2d"
local triangle = require "triangle"

local gr = display.newGroup()
gr.x, gr.y = display.contentCenterX, display.contentCenterY

local trTable = {}

local colorNames = {
	"red", "green", "blue"
}

local colors = {
	["red"] = { 1.0, 0, 0 },
	["green"] = { 0.0, 1.0, 0.0 },
	["blue"] = { 0.0, 0.0, 1.0 }
}

function hasTriangle(i, j)
	local v = Vector2d.new(i, j)
	for _, otherV in ipairs(trTable) do
		if v == otherV then
			return true
		end
	end
	return false
	-- if table.indexOf(tr, v) then
	-- 	return true
	-- end
	-- return false
end

function onTap(event)
	local t = event.target
	local nextColorName = colorNames[(table.indexOf(colorNames, t.color) % 3) + 1]
	local neighbors = triangle:neighbors(t.i, t.j)
	for _, neighbor in ipairs(neighbors) do
		drawTriangle(neighbor[1], neighbor[2], nextColorName)
	end
	-- print(event.target.color)
end

function drawTriangle(i, j, color)
	if hasTriangle(i, j) then
		return
	end
	table.insert(trTable, Vector2d.new(i, j))
	local c = triangle:center(i, j)
	local polygon = display.newPolygon(gr, c.x, c.y, triangle:vertices(i, j))
	polygon:setFillColor(unpack(colors[color]))
	polygon.anchorX, polygon.anchorY = 0.5, ((i + j + 1) % 2) / 3
	polygon.color = color
	polygon.i, polygon.j = i, j
	polygon:addEventListener("tap", onTap)
	polygon.xScale, polygon.yScale = 0.05, 0.05
	transition.to(polygon, {
			time = 400,
			xScale = 1,
			yScale = 1,
			transition = easing.inQuad
		})
end

drawTriangle(3, 3, "red")
drawTriangle(3, 2, "green")
drawTriangle(0, 0, "blue")


local Vector2d = require "Vector2d"
local triangle = require "triangle"
local widget = require "widget"

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

local points = {
	[{3, 4}] = "red",
	[{2, 2}] = "blue",
	[{-3, 1}] = "green",
	[{-4, 1}] = "red"
}

function displayPoints()
	for point, colorName in pairs(points) do
		local c = triangle:center(unpack(point))
		display.newCircle(gr, c.x, c.y, 10):setFillColor(unpack(colors[colorName]))
	end
end

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

widget.newButton {
	label = "Left",
	x = 80,
	y = 30,
	fontSize = 48,
	onRelease = function()
		gr.rotation = gr.rotation + 30
	end
}

widget.newButton {
	x = 500,
	y = 30,
	fontSize = 48,
	label = "Right",
	onRelease = function()
		gr.rotation = gr.rotation - 30
	end
}

displayPoints()
drawTriangle(3, 3, "red")
local ttc = triangle:center(3, 3)
display.newCircle(gr, ttc.x, ttc.y, 5)
drawTriangle(3, 2, "green")
local ttc2 = triangle:center(3, 2)
display.newCircle(gr, ttc2.x, ttc2.y, 5)
drawTriangle(0, 0, "blue")



function love.load()
	--global variables
	hexaPositionsY= {}
	hexaPositionsX = {}
	hexaCount = 1
	WINDOW_WIDTH = 1280
	WINDOW_HEIGHT = 720

	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('gridcombat 0.1')
	
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
	
end

function love.update()

	function love.keypressed(key) --function to quit on escape
		if key == "escape" then
			love.event.quit()
		end
	end
	
	function love.mousepressed(x, y, button)
		if button == 1 and x > 65 and x < 680 and y < 695 and y > 70 then
			print(x,y)
		end
	end

end

function love.draw()
    local cols, rows = 10, 10  -- Number of hexagons in the grid
    local startX, startY = 100, 100  -- Starting position
    local radius = 35  -- Hexagon radius

    local hexWidth = math.sqrt(3) * radius  -- Width of hexagon
    local hexHeight = 2 * radius  -- Height of hexagon

    for col = 0, cols - 1 do 
        for row = 0, rows - 1 do
            -- Compute hexagon center position
            local x = startX + col * hexWidth
            local y = startY + row * (radius * 1.7)

            -- Offset every other column to create a honeycomb pattern
            if col % 2 == 1 then
                y = y + (radius * 0.85)
            end
			
            drawLinedHexa(x, y, radius)
			drawHexaPoint(x, y)
        end
    end

	hexaHoverFill()
	displayFPS()
end


function drawLinedHexa(centerX, centerY, radius)
    local vertices = {}

    for i = 0, 5 do
        local angle = (i * math.pi / 3) + (math.pi / 3)  -- Offset by 30 degrees for flat-top
        local x = centerX + radius * math.cos(angle)
        local y = centerY + radius * math.sin(angle)
        table.insert(vertices, x)
        table.insert(vertices, y)
    end


    love.graphics.polygon("line", vertices)
end

function drawHexaPoint(centerX, centerY)
	love.graphics.points(centerX, centerY)
	local total = 100
	
	if hexaCount <= total then
		table.insert(hexaPositionsX, centerX)
		table.insert(hexaPositionsY, centerY)
		hexaCount = hexaCount + 1
	end
	if(hexaCount == 100) then
		printDebugPositions()
	end
end


function printDebugPositions() 	
	for i, pos in ipairs(hexaPositionsX) do
		print("index", i)
		print("X: ", pos)
		print("Y: ", hexaPositionsY[i])
	end
end

function hexaHoverFill()
	local mouseX,mouseY = love.mouse.getPosition()
	local minDist = 9999999
	local minY = 0
	local minX = 0
	for i, pos in ipairs(hexaPositionsX) do
		local distance = math.sqrt(math.pow((mouseX-hexaPositionsX[i]), 2) + math.pow((mouseY-hexaPositionsY[i]),2))
		if distance < minDist then
			minDist = distance
			minX = hexaPositionsX[i]
			minY = hexaPositionsY[i]
		end
	end
	local radius = 15
	love.graphics.circle("fill", minX, minY, radius)
end

function displayFPS()
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 1200, 10)
end


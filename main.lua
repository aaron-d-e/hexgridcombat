function love.draw()
    local cols, rows = 5, 5  -- Number of hexagons in the grid
    local startX, startY = 100, 100  -- Starting position
    local radius = 30  -- Hexagon radius

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

            drawHexagon(x, y, radius)
        end
    end
end

function drawHexagon(centerX, centerY, radius)
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


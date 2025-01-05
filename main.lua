local CPU = require("cpu")

local maxH, maxV, cellSize = 3, 3, 100
local grid, turn, hasWon, winner = {}, 0, false, nil
local showMessage, messageText, messageTitle, delay = false, "", "", 0
local buttonX, buttonY, buttonW, buttonH = 10, 350, 200, 50

function love.load()
    CPU.setEnabled(false)
    resetGame()
end

function love.draw()
    drawGrid()
    drawButton()
    love.graphics.setColor(1, 1, 1)
end

function love.update(dt)
    if showMessage and delay <= 0 then
        love.window.showMessageBox(messageTitle, messageText, "info", true)
        resetGame()
    else
        delay = delay - 1
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if isButtonClicked(x, y) then
            CPU.setEnabled(not CPU.isEnabled())
        elseif not showMessage then
            handlePlayerMove(x, y)
        end
    end
end

function resetGame()
    grid, turn, hasWon, winner, showMessage = {}, 0, false, nil, false
    for x = 1, maxH do
        grid[x] = {}
        for y = 1, maxV do
            grid[x][y] = 0
        end
    end
end

function drawGrid()
    for y = 1, maxV do
        for x = 1, maxH do
            love.graphics.setColor(grid[x][y] == 1 and {1, 0, 0} or grid[x][y] == 2 and {0, 1, 0} or {1, 1, 1})
            love.graphics.rectangle("fill", (x - 1) * cellSize, (y - 1) * cellSize, cellSize - 1, cellSize - 1)
        end
    end
end

function drawButton()
    love.graphics.setColor(0.2, 0.2, 0.8)
    love.graphics.rectangle("fill", buttonX, buttonY, buttonW, buttonH)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(CPU.isEnabled() and "Disable CPU" or "Enable CPU", buttonX + 10, buttonY + 15)
end

function handlePlayerMove(x, y)
    local cellX, cellY = math.floor(x / cellSize) + 1, math.floor(y / cellSize) + 1
    if isValidMove(cellX, cellY) then
        local currentPlayer = turn % 2 == 0 and 1 or 2
        grid[cellX][cellY] = currentPlayer

        if checkForWin() then
            endGame(string.format("Player %d has won!", currentPlayer))
        elseif isDraw() then
            endGame("It's a draw!")
        else
            turn = turn + 1
            if currentPlayer == 1 and CPU.isEnabled() then handleCPUMove() end
        end
    end
end

function handleCPUMove()
    if hasWon or isDraw() then return end
    local cellX, cellY = CPU.getMove(grid, maxH, maxV)
    if cellX and cellY then
        grid[cellX][cellY] = 2
        if checkForWin() then
            endGame("Player 2 (CPU) has won!")
        elseif isDraw() then
            endGame("It's a draw!")
        else
            turn = turn + 1
        end
    end
end

function isButtonClicked(x, y)
    return x >= buttonX and x <= buttonX + buttonW and y >= buttonY and y <= buttonY + buttonH
end

function isValidMove(cellX, cellY)
    return cellX >= 1 and cellX <= maxH and cellY >= 1 and cellY <= maxV and grid[cellX][cellY] == 0
end

function endGame(message)
    showMessage, messageText, messageTitle, delay = true, message, "Game Over", 1
end

function isDraw()
    for x = 1, maxH do
        for y = 1, maxV do
            if grid[x][y] == 0 then return false end
        end
    end
    return true
end

-- Check if a specific line is a winning line
local function checkLine(player, startX, startY, stepX, stepY)
    for i = 0, maxH - 1 do
        local x = startX + i * stepX
        local y = startY + i * stepY

        if x < 1 or x > maxH or y < 1 or y > maxV or grid[x][y] ~= player then
            return false
        end
    end
    return true
end

-- Check for a win condition
function checkForWin()
    local player = turn % 2 == 0 and 1 or 2

    -- Check all rows
    for y = 1, maxV do
        if checkLine(player, 1, y, 1, 0) then
            return true
        end
    end

    -- Check all columns
    for x = 1, maxH do
        if checkLine(player, x, 1, 0, 1) then
            return true
        end
    end

    -- Check diagonals
    if checkLine(player, 1, 1, 1, 1) or checkLine(player, maxH, 1, -1, 1) then
        return true
    end

    return false
end

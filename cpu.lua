local CPU = {}
local isEnabled = false

-- Enable or disable the CPU
function CPU.setEnabled(state)
    isEnabled = state
    print(state and "CPU enabled" or "CPU disabled")
end

function CPU.isEnabled()
    return isEnabled
end

-- Find a winning move for a player
function CPU.findWinningMove(grid, player, maxH, maxV)
    if not isEnabled then return nil, nil end

    for x = 1, maxH do
        for y = 1, maxV do
            if grid[x][y] == 0 then
                grid[x][y] = player
                if checkForWin(player, grid, maxH, maxV) then
                    grid[x][y] = 0
                    return x, y
                end
                grid[x][y] = 0
            end
        end
    end
    return nil, nil
end

-- Evaluate the score of a move
local function evaluateMove(grid, x, y, player, maxH, maxV)
    if not isEnabled then return 0 end

    local opponent = player == 1 and 2 or 1
    local score = 0

    grid[x][y] = player
    if checkForWin(player, grid, maxH, maxV) then score = score + 100 end

    grid[x][y] = opponent
    if checkForWin(opponent, grid, maxH, maxV) then score = score + 90 end

    grid[x][y] = player
    if CPU.hasDoubleThreat(player, grid, maxH, maxV) then score = score + 80 end

    grid[x][y] = 0
    return score
end

-- Detect double threats
function CPU.hasDoubleThreat(player, grid, maxH, maxV)
    if not isEnabled then return false end

    local threatCount = 0
    for x = 1, maxH do
        for y = 1, maxV do
            if grid[x][y] == 0 then
                grid[x][y] = player
                if checkForWin(player, grid, maxH, maxV) then
                    threatCount = threatCount + 1
                end
                grid[x][y] = 0
            end
        end
    end
    return threatCount >= 2
end

-- Find the best move based on scoring
function CPU.findBestMove(grid, player, maxH, maxV)
    if not isEnabled then return nil, nil end

    local bestScore, bestMove = -math.huge, nil
    for x = 1, maxH do
        for y = 1, maxV do
            if grid[x][y] == 0 then
                local score = evaluateMove(grid, x, y, player, maxH, maxV)
                if score > bestScore then
                    bestScore, bestMove = score, {x, y}
                end
            end
        end
    end
    return bestMove and bestMove[1], bestMove and bestMove[2]
end

-- Get the CPU's move
function CPU.getMove(grid, maxH, maxV)
    if not isEnabled then return nil, nil end

    local actions = {
        function() return CPU.findWinningMove(grid, 2, maxH, maxV) end,
        function() return CPU.findWinningMove(grid, 1, maxH, maxV) end,
        function() return CPU.findBestMove(grid, 2, maxH, maxV) end,
        function() return CPU.findRandomMove(grid, maxH, maxV) end,
    }

    for _, action in ipairs(actions) do
        local x, y = action()
        if x and y then return x, y end
    end
end

-- Find a random valid move
function CPU.findRandomMove(grid, maxH, maxV)
    if not isEnabled then return nil, nil end

    local validMoves = {}
    for x = 1, maxH do
        for y = 1, maxV do
            if grid[x][y] == 0 then
                table.insert(validMoves, {x, y})
            end
        end
    end

    if #validMoves > 0 then
        local move = validMoves[math.random(#validMoves)]
        return move[1], move[2]
    end
    return nil, nil
end

return CPU

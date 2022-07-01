import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "ball"
import "brick"
import "paddle"
import "states"
import "wall"

local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display

local function initialize()
    bricksCounter = 0
    mode = "start"
    local start = Start()
    start:add()
end

initialize()

function changeMode(newMode)
    if mode ~= "play" and newMode == "play" then
        -- Invisible walls, right outside the screen.
        local wallTop = Wall(dsp.getWidth() / 2, -1, dsp.getWidth(), 2)
        wallTop:add()

        local wallRight = Wall(dsp.getWidth() - 40, dsp.getHeight() / 2, 10, dsp.getHeight())
        wallRight:add()

        local wallLeft = Wall(40, dsp.getHeight() / 2, 10, dsp.getHeight())
        wallLeft:add()

        local ballSprite = Ball(80, 80, 5)
        ballSprite:add()

        local paddleSprite = Paddle(dsp.getWidth() / 2, dsp.getHeight() - 10, 60, 10)
        paddleSprite:add()

        for i = 0, 5 do
            for j = 0, 2 do
                Brick(100 + i * 40, 40 + j * 12):add()
                bricksCounter = bricksCounter + 1
            end
        end
    elseif mode == "play" and newMode == "over" then
        bricksCounter = 0
        Over():add()
    elseif mode == "play" and newMode == "win" then
        Win():add()
    end
    mode = newMode
end

function decreaseBricksCounter()
    bricksCounter = bricksCounter - 1
    if bricksCounter <= 0 then
        changeMode("win")
    end
end

function pd.update()
    gfx.sprite.update()
end

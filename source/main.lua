import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "ball"
import "paddle"
import "states"
import "wall"

local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display

local function initialize()
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

        local ballSprite = Ball(80, 40, 5)
        ballSprite:add()

        local paddleSprite = Paddle(dsp.getWidth() / 2, dsp.getHeight() - 10, 60, 10)
        paddleSprite:add()
    elseif mode == "play" and newMode == "over" then
        local over = Over()
        over:add()
    end
    mode = newMode
end

function pd.update()
    gfx.sprite.update()
end

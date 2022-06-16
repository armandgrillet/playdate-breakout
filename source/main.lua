import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "ball"
import "paddle"
import "wall"

local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display

local function initialize()
    -- Invisible walls, right outside the screen.
    local wallTop = Wall(dsp.getWidth() / 2, -1, dsp.getWidth(), 2)
    wallTop:add()

    local wallRight = Wall(dsp.getWidth() + 1, dsp.getHeight() / 2, 2, dsp.getHeight())
    wallRight:add()

    local wallBottom = Wall(dsp.getWidth() / 2, dsp.getHeight() + 1, dsp.getWidth(), 2)
    wallBottom:add()

    local wallLeft = Wall(-1, dsp.getHeight() / 2, 2, dsp.getHeight())
    wallLeft:add()

    local ballSprite = Ball(33, 33, 5)
    ballSprite:add()

    local paddleSprite = Paddle(dsp.getWidth() / 2, dsp.getHeight() - 10, 60, 10)
    paddleSprite:add()
end

initialize()

function pd.update()
    gfx.sprite.update()
end

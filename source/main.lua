import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "ball"
import "paddle"

local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display

local function initialize()
    local ballSprite = Ball(33, 33, 5)
    ballSprite:add()

    local paddleSprite = Paddle(dsp.getWidth() / 2, dsp.getHeight() - 30, 60, 10)
    paddleSprite:add()
end

initialize()

function pd.update()
    gfx.sprite.update()
end

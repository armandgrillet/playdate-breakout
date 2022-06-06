import "CoreLibs/graphics"
import "CoreLibs/timer"

-- Shorthands.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx <const> = playdate.graphics
local dsp <const> = playdate.display
local sfx <const> = playdate.sound

-- Information about the ball.
-- Coordinates.
ballX = 33
ballY = 33
-- Velocity
ballVX = 2
ballVY = 2
-- Radius
ballR = 5

-- Sound effects.
bip = sfx.synth.new(sfx.kWaveSine)

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()
    gfx.clear()

    ballX = ballX + ballVX
    ballY = ballY + ballVY

    if ballX > dsp.getWidth() or ballX < 0 then
        ballVX = -ballVX
        bip:playNote(261.63, 1, 0.2)
    end
    if ballY > dsp.getHeight() or ballY < 0 then
        ballVY = -ballVY
        bip:playNote(261.63, 1, 0.2)
    end

    gfx.fillCircleAtPoint(ballX, ballY, ballR)

    gfx.sprite.update()
    playdate.timer.updateTimers()
end

import "CoreLibs/graphics"
import "CoreLibs/timer"

-- Shorthands.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx<const> = playdate.graphics
local dsp<const> = playdate.display
local sfx<const> = playdate.sound

-- Information about the ball.
-- Coordinates.
ballX = 33
ballY = 33
-- Velocity
ballVX = 3
ballVY = 3
-- Radius
ballR = 5

-- Information about the player (the paddle)
paddleX = dsp.getWidth() / 2
paddleY = dsp.getHeight() - 30

-- Velocity
paddleVX = 0
-- Dimensions
paddleWidth = 60
paddleHeight = 10

-- Sound effects.
bip = sfx.synth.new(sfx.kWaveSine)

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()
    gfx.clear()

    -- Moving the ball
    if ballX >= dsp.getWidth() or ballX <= 0 then
        ballVX = -ballVX
        bip:playNote(261.63, 1, 0.2)
    end
    if ballY >= dsp.getHeight() or ballY <= 0 then
        ballVY = -ballVY
        bip:playNote(261.63, 1, 0.2)
    end

    ballX = ballX + ballVX
    ballY = ballY + ballVY

    gfx.fillCircleAtPoint(ballX, ballY, ballR)

    -- Moving the paddle
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        paddleVX = 9
    elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
        paddleVX = -9
    else
        paddleVX = paddleVX / 2
    end

    paddleX = paddleX + paddleVX
    gfx.drawRect(paddleX, paddleY, paddleWidth, paddleHeight)

    gfx.sprite.update()
    playdate.timer.updateTimers()
end

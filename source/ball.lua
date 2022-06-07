local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display
local sfx<const> = pd.sound

class('Ball').extends(gfx.sprite)

function Ball:init(x, y, r)
    Ball.super.init(self)
    self:moveTo(x, y)
    local ballImage = gfx.image.new(r*2, r*2)

    gfx.pushContext(ballImage)
        gfx.fillCircleAtPoint(r, r, r)
    gfx.popContext()
    self:setImage(ballImage)

    self.vx = 3
    self.vy = 3
    self:setCollideRect(0, 0, self:getSize())

    self.bip = sfx.synth.new(sfx.kWaveSine)
end

function Ball:update()
    Ball.super.update(self)
    -- Moving the ball
    if self.x >= dsp.getWidth() or self.x <= 0 then
        self.vx = -self.vx
        self.bip:playNote(261.63, 1, 0.2)
    end
    if self.y >= dsp.getHeight() or self.y <= 0 then
        self.vy = -self.vy
        self.bip:playNote(261.63, 1, 0.2)
    end

    self:moveBy(self.vx, self.vy)
end

function Ball:moveBy(x, y)
    Ball.super.moveBy(self, x, y)
end

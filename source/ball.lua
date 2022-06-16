local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display
local sfx<const> = pd.sound

class('Ball').extends(gfx.sprite)

function Ball:init(x, y, r)
    Ball.super.init(self)
    self:moveTo(x - r, y - r)
    local ballImage = gfx.image.new(r * 2, r * 2)

    gfx.pushContext(ballImage)
    gfx.fillCircleAtPoint(r, r, r)
    gfx.popContext()
    self:setImage(ballImage)

    self.r = r
    self.defaultAxisSpeed = 8.1
    self.v = geo.vector2D.new(self.defaultAxisSpeed, self.defaultAxisSpeed)
    self:setCollideRect(0, 0, self:getSize())

    self.bip = sfx.synth.new(sfx.kWaveSine)
end

function Ball:update()
    Ball.super.update(self)

    x, y, collisions, numberOfCollisions = self:moveWithCollisions(self.x + self.v.dx, self.y + self.v.dy)
    if numberOfCollisions > 0 then
        if collisions[1].other.name() == "Paddle" then
            self.bip:playNote("C4", 1, 0.2)
        else
            self.bip:playNote("C3b", 1, 0.2)
        end

        -- playdate.stop()
        if (self.v.dx > 0 and collisions[1].touch.x > collisions[1].bounce.x) or
            (self.v.dx < 0 and collisions[1].touch.x < collisions[1].bounce.x) then
            -- Impact with something like |.
            self.v.dx = -1 * self.v.dx
        end
        if (self.v.dy > 0 and collisions[1].touch.y > collisions[1].bounce.y) or
            (self.v.dy < 0 and collisions[1].touch.y < collisions[1].bounce.y) then
            -- Impact with something like -.
            self.v.dy = -1 * self.v.dy
        end
    end
end

function Ball:collisionResponse(other)
    return "bounce"
end

local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display
local sfx<const> = pd.sound

class('Ball').extends(gfx.sprite)

function Ball:init(x, y, r)
    Ball.super.init(self)

    self.origins = geo.point.new(x, y)
    self:moveTo(self.origins)
    local ballImage = gfx.image.new(r * 2, r * 2)
    gfx.pushContext(ballImage)
    gfx.fillCircleAtPoint(r, r, r)
    gfx.popContext()
    self:setImage(ballImage)
    self:setCollideRect(0, 0, self:getSize())

    self.remains = 3
    self.remainsSprite = self:createRemainsSprite()
    self.remainsSprite:add()

    self.r = r
    self.defaultAxisSpeed = 7
    self.v = geo.vector2D.new(self.defaultAxisSpeed, self.defaultAxisSpeed)

    self.bip = sfx.synth.new(sfx.kWaveSine)
end

function Ball:createRemainsSprite()
    local remainsImage = gfx.image.new(25, 25)
    gfx.pushContext(remainsImage)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(0, 0, 25, 25)
        gfx.drawText(tostring(self.remains), 0, 0)
    gfx.popContext()

    local remainsSprite = gfx.sprite.new(remainsImage)
    remainsSprite:setImage(remainsImage)
    remainsSprite:moveTo(dsp.getWidth() - 10, 20)
    return remainsSprite
end

function Ball:update()
    Ball.super.update(self)

    if mode == "play" then
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

        if self.x < 0 or self.x > dsp.getWidth() or self.y < 0 or self.y > dsp.getHeight() then
            -- Bottom of the screen
            self.bip:playNote("A2", 1, 0.2)
            self.remains = self.remains - 1
            self.remainsSprite:remove()
            if self.remains > 0 then
                self.remainsSprite = self:createRemainsSprite()
                self.remainsSprite:add()
                self:moveTo(self.origins)
                self.v = geo.vector2D.new(self.defaultAxisSpeed, self.defaultAxisSpeed)
            else
                changeMode("over")
            end
        end
    end

    if mode ~= "play" then
        self:remove()
        self.remainsSprite:remove()
    end
end

function Ball:collisionResponse(other)
    return "bounce"
end

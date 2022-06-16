local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display

class('Paddle').extends(gfx.sprite)

function Paddle:init(x, y, w, h)
    Paddle.super.init(self)
    self:moveTo(x, y)
    local paddleImage = gfx.image.new(w, h)

    gfx.pushContext(paddleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, w, h)
    gfx.popContext()
    self:setImage(paddleImage)

    self.maxSpeed = 8
    self.v = geo.vector2D.new(0, 0)
    self:setCollideRect(0, 0, self:getSize())
end

function Paddle:update()
    Paddle.super.update(self)
    -- Moving the paddle
    if pd.buttonIsPressed(pd.kButtonRight) then
        self.v.x = self.maxSpeed
    elseif pd.buttonIsPressed(pd.kButtonLeft) then
        self.v.x = -self.maxSpeed
    else
        self.v.x = self.v.x / 1.8
    end

    self:moveWithCollisions(self.x + self.v.x, self.y + self.v.y)
end

function Paddle:moveBy(x, y)
    Paddle.super.moveBy(self, x, y)
end

function Paddle:name()
    return "Paddle"
end

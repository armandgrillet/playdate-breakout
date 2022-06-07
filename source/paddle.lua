local pd<const> = playdate
local gfx<const> = pd.graphics
local dsp<const> = pd.display

class('Paddle').extends(gfx.sprite)

function Paddle:init(x, y, w, h)
    Paddle.super.init(self)
    self:moveTo(x, y)
    local paddleImage = gfx.image.new(60, 10)

    gfx.pushContext(paddleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, w, h)
    gfx.popContext()
    self:setImage(paddleImage)

    self.vx = 9
    self:setCollideRect(0, 0, self:getSize())
end

function Paddle:update()
    Paddle.super.update(self)
    -- Moving the paddle
    if pd.buttonIsPressed(pd.kButtonRight) then
        self.vx = 9
    elseif pd.buttonIsPressed(pd.kButtonLeft) then
        self.vx = -9
    else
        self.vx = self.vx / 2
    end

    self:moveBy(self.vx, 0)

    local overlappingSprites = self:overlappingSprites()
    if #overlappingSprites > 0 then
        print("DAMAGED")
    end
end

function Paddle:moveBy(x, y)
    Paddle.super.moveBy(self, x, y)
end

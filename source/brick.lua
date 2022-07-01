local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display
local sfx<const> = pd.sound

class('Brick').extends(gfx.sprite)

function Brick:init(x, y)
    Brick.super.init(self)
    self:moveTo(x, y)
    local w = 35
    local h = 10
    local wallImage = gfx.image.new(w, h)

    gfx.pushContext(wallImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, w, h)
    gfx.popContext()
    self:setImage(wallImage)

    self:setCollideRect(0, 0, self:getSize())
    self.v = geo.vector2D.new(0, 0)
end

function Brick:update()
    Brick.super.update(self)

    if mode ~= "play" then
        self:remove()
    end
end

function Brick:name()
    return "Brick"
end

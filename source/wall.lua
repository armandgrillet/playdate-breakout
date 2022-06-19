local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display

class('Wall').extends(gfx.sprite)

function Wall:init(x, y, w, h)
    Wall.super.init(self)
    self:moveTo(x, y)
    local wallImage = gfx.image.new(w, h)

    gfx.pushContext(wallImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, w, h)
    gfx.popContext()
    self:setImage(wallImage)

    self:setCollideRect(0, 0, self:getSize())
    self.v = geo.vector2D.new(0, 0)
end

function Wall:update()
    Wall.super.update(self)

    if mode ~= "play" then
        self:remove()
    end
end

function Wall:name()
    return "Wall"
end

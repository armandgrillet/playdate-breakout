local pd<const> = playdate
local geo<const> = pd.geometry
local gfx<const> = pd.graphics
local dsp<const> = pd.display

class('Start').extends(gfx.sprite)

function Start:init()
    Start.super.init(self)

    local startImage = gfx.image.new(dsp.getWidth(), 40)
    gfx.pushContext(startImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, dsp.getWidth(), 40)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText("Press A to start", 10, 10)
    gfx.popContext()

    self:setImage(startImage)
    self:moveTo(dsp.getWidth() / 2,dsp.getHeight() / 2)
end

function Start:update()
    Start.super.update(self)
    if pd.buttonIsPressed(playdate.kButtonA) then
        changeMode("play")
    end

    if mode ~= "start" then
        self:remove()
    end
end

function Start:name()
    return "Start"
end

class('Over').extends(gfx.sprite)

function Over:init()
    Over.super.init(self)

    local startImage = gfx.image.new(dsp.getWidth(), 40)
    gfx.pushContext(startImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, dsp.getWidth(), 40)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText("Game over, press A to restart", 10, 10)
    gfx.popContext()

    self:setImage(startImage)
    self:moveTo(dsp.getWidth() / 2,dsp.getHeight() / 2)
end

function Over:update()
    Over.super.update(self)
    if pd.buttonIsPressed(playdate.kButtonA) then
        changeMode("play")
    end

    if mode ~= "over" then
        self:remove()
    end
end

function Over:name()
    return "Game Over"
end

class('Win').extends(gfx.sprite)

function Win:init()
    Win.super.init(self)

    local winImage = gfx.image.new(dsp.getWidth(), 40)
    gfx.pushContext(winImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, dsp.getWidth(), 40)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText("You won! Press A to restart", 10, 10)
    gfx.popContext()

    self:setImage(winImage)
    self:moveTo(dsp.getWidth() / 2,dsp.getHeight() / 2)
end

function Win:update()
    Win.super.update(self)
    if pd.buttonIsPressed(playdate.kButtonA) then
        changeMode("play")
    end

    if mode ~= "win" then
        self:remove()
    end
end

function Win:name()
    return "Win"
end

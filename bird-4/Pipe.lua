Pipe = Class{}

local PIPLE_IMAGE = love.graphics.newImage('pipe.png')

local PIPE_SCROLL = -60

function Pipe:init()
    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

    self.width = PIPLE_IMAGE:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + ( PIPE_SCROLL * dt )
end

function Pipe:render()
    love.graphics.draw(PIPLE_IMAGE, self.x, self.y)
end
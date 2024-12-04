PipePair = Class{}

local GAP_HEIGHT = 90

local PIPE_SPEED = 60

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32

    self.y = y
    
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('botton', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }
    self.remove = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.X
        self.pipes['upper'].y = self.X
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
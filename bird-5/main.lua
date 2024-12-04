push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH = 512

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png') 
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

local spawnTimer = 0

local pipePairs = {}

local lastY = -PIPE_HEIGHT + math.random(80) + 20

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)  --custom function
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end

end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT  --to reset

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
    math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y

        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end

    bird:update(dt)

    for k, pipe in pairs(pipePairs) do
        pipe:update(dt)

        if pipe.x < -PIPE_WIDTH then
            table.remove(pipePairs, k)
        end
    end
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start() --push:apply('start')
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pipe in pairs(pipePairs) do
        pipe:render()
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
    push:finish()
end
require("world")
require("car")
require("vec")
love.load = function()
  love.window.setMode(960, 540, {
    vsync = false,
    resizable = true
  })
  love.graphics.setLineWidth(4)
  love.graphics.setBackgroundColor(.12, .1, .1)
  w = World()
  Car(vec(256, 256), 1)
  Car(vec(256, 256), 2)
  Car(vec(256, 256), 3)
  return Car(vec(256, 256), 4)
end
love.update = function(dt)
  return w:update(dt)
end
love.draw = function()
  w:draw()
  return love.graphics.print("fps: " .. tostring(love.timer.getFPS()), 0, 0)
end

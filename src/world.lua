require("entity")
require("vec")
require("rect")
do
  local _class_0
  local _base_0 = {
    own = Nil,
    bg = love.graphics.newImage("pics/bg.png"),
    fg = love.graphics.newImage("pics/fg.png"),
    shine = love.graphics.newImage("pics/shine.png"),
    grill = love.graphics.newImage("pics/grill.png"),
    grillBorder = love.graphics.newImage("pics/grill-border.png"),
    update = function(self, dt)
      self.world:update(dt)
      local _list_0 = Entity.all
      for _index_0 = 1, #_list_0 do
        local e = _list_0[_index_0]
        if e ~= Nil then
          e:update(dt)
        end
      end
      self.spot.t = self.spot.t - dt
      if self.spot.t < 0 then
        self.spot.t = .6
        self.spot.pos = vec(math.random(64, 960 - 64), math.random(64, 450 - 64))
        self.spot.color = Color.fromHSL(math.random(0.0, 255) / 255.0, 1, .5)
      end
    end,
    draw = function(self)
      love.graphics.draw(self.bg, 0, 0)
      local _list_0 = Entity.all
      for _index_0 = 1, #_list_0 do
        local e = _list_0[_index_0]
        if e ~= Nil then
          e:draw()
        end
      end
      love.graphics.setColor(self.spot.color.r, self.spot.color.g, self.spot.color.b, .2)
      love.graphics.draw(self.shine, self.spot.pos.x, self.spot.pos.y)
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(self.fg, 0, 0)
      for y, line in pairs(self.net) do
        for x, v in pairs(line) do
          if v ~= 0 then
            if v == 1 then
              love.graphics.setColor(.7, .7, .7, .1)
            end
            if v == 2 then
              love.graphics.setColor(1, .3, .3, .2)
            end
            love.graphics.draw(self.grillBorder, (x - 1) * self.netSize, (y - 1) * self.netSize)
            love.graphics.setColor(1, 1, 1, .1)
            love.graphics.draw(self.grill, (x - 1) * self.netSize, (y - 1) * self.netSize)
          end
        end
      end
      return love.graphics.setColor(1, 1, 1, 1)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.__class.own = self
      self.world = love.physics.newWorld(0, 0, true)
      love.physics.setMeter(64)
      self.body = love.physics.newBody(self.world, 0, 0)
      self.shapeU = love.physics.newEdgeShape(0, 60, 960, 60)
      self.fixtureU = love.physics.newFixture(self.body, self.shapeU)
      self.shapeR = love.physics.newEdgeShape(960 - 38, 0, 960 - 38, 540)
      self.fixtureR = love.physics.newFixture(self.body, self.shapeR)
      self.shapeL = love.physics.newEdgeShape(0 + 38, 0, 0 + 38, 540)
      self.fixtureL = love.physics.newFixture(self.body, self.shapeL)
      self.shapeB = love.physics.newEdgeShape(0, 540, 960, 540)
      self.fixtureB = love.physics.newFixture(self.body, self.shapeB)
      self.net = {
        {
          1,
          1,
          2,
          2,
          1,
          1,
          2,
          1
        },
        {
          1,
          2,
          1,
          0,
          1,
          1,
          0,
          1
        },
        {
          1,
          0,
          1,
          2,
          2,
          1,
          0,
          1
        },
        {
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1
        }
      }
      self.netSize = 120
      self.joysticks = love.joystick.getJoysticks()
      self.spot = {
        pos = vec(),
        color = Color(),
        t = 0
      }
    end,
    __base = _base_0,
    __name = "World"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  World = _class_0
end

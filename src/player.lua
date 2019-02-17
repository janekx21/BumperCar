require("vec")
require("entity")
require("particle")
require("dusk")
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    img = love.graphics.newImage("pics/run.png"),
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      self.pos:set(self.body:getX(), self.body:getY())
      self.vel.x, self.vel.y = self.body:getLinearVelocity()
      self.move:set(0, 0)
      if love.keyboard.isDown("right") then
        self.move.x = self.move.x + 1
      end
      if love.keyboard.isDown("left") then
        self.move.x = self.move.x + -1
      end
      self.body:setLinearVelocity(self.move.x * self.speed, self.vel.y)
      if self.move:mag() > 0 then
        self.animTimer = self.animTimer + dt
        self.dir = self.move.x
        if self.pTimer <= 0 then
          Dusk(self.pos:copy():add(vec(0, 32)))
          self.pTimer = .1
        end
      end
      self.pTimer = self.pTimer - dt
    end,
    draw = function(self)
      local quad = love.graphics.newQuad(math.floor(self.animTimer * 12) % 5 * 32, 0, 32, 32, self.img:getWidth(), self.img:getHeight())
      return love.graphics.draw(self.img, quad, self.pos.x, self.pos.y, 0, self.dir * 2, 2, self.img:getWidth() / 5 / 2, self.img:getHeight() / 2)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos)
      _class_0.__parent.__init(self, pos)
      self.vel = vec()
      self.img:setFilter("nearest", "nearest")
      self.speed = 64 * 4
      self.z = 1
      self.animTimer = 0
      self.move = vec()
      self.dir = 1
      self.pTimer = 0
      self.body = love.physics.newBody(World.own.world, self.pos.x, self.pos.y, "dynamic")
      self.shape = love.physics.newRectangleShape(32, 32)
      self.fixture = love.physics.newFixture(self.body, self.shape)
      self.body:setBullet(true)
      return self.body:setFixedRotation(true)
    end,
    __base = _base_0,
    __name = "Player",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Player = _class_0
end

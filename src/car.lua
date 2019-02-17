require("entity")
require("vec")
require("spark")
require("blitz")
require("dusk")
require("world")
require("color")
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    ground = {
      love.graphics.newImage("pics/car-ground-black.png"),
      love.graphics.newImage("pics/car-ground-inner.png"),
      love.graphics.newImage("pics/car-ground-lower.png"),
      love.graphics.newImage("pics/car-ground-upper.png")
    },
    vertex = {
      -32,
      -64 + 18,
      -32 + 18,
      -64,
      32 - 18,
      -64,
      32,
      -64 + 18,
      32,
      64,
      -32,
      64
    },
    playerColors = {
      Color(1, 0, 0),
      Color(0, 1, 0),
      Color(0, 1, 1),
      Color(1, 0, 1)
    },
    shine = love.graphics.newImage("pics/shine.png"),
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      self.deactTimer = self.deactTimer - dt
      self.pos = vec(self.body:getPosition())
      self.vel = vec(self.body:getLinearVelocity())
      local mouse = vec(love.mouse.getPosition())
      self.angle = self.body:getAngle()
      self.apply = vec(0, -48)
      self.apply:rotate(self.angle)
      self.apply:add(self.pos)
      self.target = vec()
      if self.num == 1 then
        if love.mouse.isDown(1) then
          self.target = mouse:copy():sub(self.apply)
        end
      end
      if self.num == 2 then
        if World.own.joysticks[1] ~= Nil then
          local dir = vec(World.own.joysticks[1]:getAxes())
          self.target = dir
        end
      end
      if (self.target.x ~= 0 or self.target.y ~= 0) and self.deactTimer <= 0 and self.lives > 0 then
        if self.target:mag() > 1 then
          self.target:norm()
        end
        local speed = self.accel
        if self.state == 2 then
          speed = speed * 1.6
        end
        if self.state == 0 then
          speed = speed * .1
        end
        self.target:scale(speed)
        self.body:applyForce(self.target.x, self.target.y, self.apply.x, self.apply.y)
      end
      local ray = vec(0, -64)
      ray:rotate(self.angle)
      ray:add(self.pos)
      local dir = vec(0, -64 - self.vel:mag() * .01 - 1)
      dir:rotate(self.angle)
      dir:add(self.pos)
      local callback
      callback = function(fixture, x, y, xn, yn, fraction)
        local data = fixture:getUserData()
        if fixture ~= self.fixture and data ~= Nil then
          if data.origen ~= Nil then
            if data.origen.deactTimer <= 0 then
              for i = 1, 8 do
                local d = Dusk(vec(x, y))
                d.vel:add(data.origen.vel:copy():scale(.3))
              end
            end
            data.origen:getHit(self)
          end
        end
        return 0
      end
      if self.lives > 0 then
        World.own.world:rayCast(ray.x, ray.y, dir.x, dir.y, callback)
      end
      self.debug = {
        ray,
        dir
      }
      local start = vec(0, 64 - 16)
      start:rotate(self.angle)
      start:add(self.pos)
      local coll = vec(math.floor(start.x / World.own.netSize), math.floor((start.y - 128) / World.own.netSize))
      self.state = 0
      if coll.x >= 0 and coll.x < 8 and coll.y >= 0 and coll.y < 4 and self.lives > 0 then
        self.state = World.own.net[coll.y + 1][coll.x + 1]
        if World.own.net[coll.y + 1][coll.x + 1] == 1 then
          Spark(start:copy():add(vec(0, -128)))
        end
        if World.own.net[coll.y + 1][coll.x + 1] == 2 then
          return Blitz(start:copy():add(vec(0, -128)))
        end
      end
    end,
    getHit = function(self, origen)
      if self.deactTimer <= 0 and self.lives > 0 then
        self.lives = self.lives - 1
      end
      self.deactTimer = 1
    end,
    draw = function(self)
      love.graphics.setColor(self.playerColors[self.num]:pack())
      if self.deactTimer > 0 and math.floor(love.timer.getTime() * 6) % 2 == 0 or self.lives == 0 then
        love.graphics.setColor(0, 0, 0, 0)
      end
      love.graphics.draw(self.shine, self.pos.x, self.pos.y, self.angle, .6, 1, 128, 128)
      love.graphics.setColor(1, 1, 1)
      for i, p in pairs(self.ground) do
        if i == 2 then
          love.graphics.setColor(self.playerColors[self.num]:copy():scale(.8):pack())
        else
          love.graphics.setColor(1, 1, 1)
        end
        for j = 0, 4 do
          love.graphics.draw(p, self.pos.x, self.pos.y - (i * 4 + j), self.angle, 1, 1, 32, 64)
        end
      end
      local start = vec(0, 64 - 16)
      start:rotate(self.angle)
      start:add(self.pos)
      love.graphics.line(start.x, start.y - 16, start.x, start.y - 128)
      love.graphics.setColor(self.playerColors[self.num]:pack())
      love.graphics.line(start.x, start.y - 16, start.x, start.y - 16 - ((128 - 16) * self.lives / self.maxHP))
      love.graphics.setColor(1, 1, 1)
      local ende = start:copy():add(self.vel:copy():scale(-.02))
      love.graphics.line(start.x, start.y - 128, ende.x, ende.y - 128 - 16)
      local coll = vec(math.floor(start.x / World.own.netSize), math.floor((start.y - 128) / World.own.netSize))
      love.graphics.setColor(1, 1, 1)
      if coll.x >= 0 and coll.x < 8 and coll.y >= 0 and coll.y < 4 then
        if World.own.net[coll.y + 1][coll.x + 1] ~= 0 then
          love.graphics.setColor(1, 0, 0)
        end
      end
      love.graphics.line(start.x, start.y - 128, ende.x, ende.y - 128 - 16)
      love.graphics.setColor(1, 1, 1)
      if self.deactTimer > 0 then
        love.graphics.print(self.lives, self.apply.x, self.apply.y)
      end
      return love.graphics.line(self.debug[1].x, self.debug[1].y, self.debug[2].x, self.debug[2].y)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos, num)
      _class_0.__parent.__init(self, pos)
      self.pos = pos
      self.vel = vec()
      self.num = num or 1
      self.body = love.physics.newBody(World.own.world, self.pos.x, self.pos.y, "dynamic")
      self.shape = love.physics.newPolygonShape(self.vertex)
      self.fixture = love.physics.newFixture(self.body, self.shape)
      self.fixture:setUserData({
        origen = self
      })
      self.fixture:setRestitution(1)
      self.target = vec(1, 0)
      self.accel = 4000
      self.apply = vec()
      self.angle = 0
      self.state = 0
      self.deactTimer = 0
      self.maxHP = 3
      self.lives = self.maxHP
      self.body:setMassData(0, 32, 2, 3400)
      self.body:setLinearDamping(2.8)
      self.body:setAngularDamping(3.8 * 10)
      self.debug = {
        vec(),
        vec()
      }
    end,
    __base = _base_0,
    __name = "Car",
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
  Car = _class_0
end

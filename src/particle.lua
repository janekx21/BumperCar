require("entity")
require("vec")
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    img = Nil,
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      self.pos:add(self.vel:copy():scale(dt))
      self.vel:add(self.gravity:copy():scale(dt))
      if self.t > self.livetime then
        return self:die()
      end
    end,
    draw = function(self)
      local size = math.sin(self.t / self.livetime * math.pi)
      return love.graphics.draw(self.img, self.pos.x, self.pos.y, self.r, self.size * size, self.size * size, self.img:getWidth() / 2, self.img:getHeight() / 2)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos)
      _class_0.__parent.__init(self, pos)
      self.vel = vec()
      self.livetime = 1
      self.r = 0
      self.gravity = vec()
      self.size = 1
    end,
    __base = _base_0,
    __name = "Particle",
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
  Particle = _class_0
end

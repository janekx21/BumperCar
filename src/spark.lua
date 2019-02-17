require("particle")
do
  local _class_0
  local _parent_0 = Particle
  local _base_0 = {
    img = love.graphics.newImage("pics/spark-blue.png"),
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      self.r = self.vel:angle() + math.pi / 2
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos)
      _class_0.__parent.__init(self, pos)
      self.size = math.random(.4, .8)
      self.livetime = .6
      self.vel = vec(math.random(-90.0, 90.0), math.random(-120.0, -50))
      self.r = self.vel:angle()
      self.gravity = vec(0, 280)
      return self.img:setFilter("linear", "linear")
    end,
    __base = _base_0,
    __name = "Spark",
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
  Spark = _class_0
end

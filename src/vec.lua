do
  local _class_0
  local _base_0 = {
    clone = function(self)
      return vec(self.x, self.y)
    end,
    copy = function(self)
      return vec(self.x, self.y)
    end,
    add = function(self, o)
      self.x = self.x + o.x
      self.y = self.y + o.y
      return self
    end,
    sub = function(self, o)
      self.x = self.x - o.x
      self.y = self.y - o.y
      return self
    end,
    mul = function(self, o)
      self.x = self.x * o.x
      self.y = self.y * o.y
      return self
    end,
    div = function(self, o)
      self.x = self.x / o.x
      self.y = self.y / o.y
      return self
    end,
    ort = function(self)
      local tmp = self.x
      self.x = self.y
      self.y = -tmp
      return self
    end,
    mag = function(self)
      return math.sqrt(self.x * self.x + self.y * self.y)
    end,
    norm = function(self)
      local l = self:mag()
      assert(l ~= 0)
      self.x = self.x / l
      self.y = self.y / l
      return self
    end,
    scale = function(self, f)
      self.x = self.x * f
      self.y = self.y * f
      return self
    end,
    cross = function(self, o)
      return self.x * o.y - self.y * o.x
    end,
    set = function(self, x, y)
      self.x = x
      self.y = y
      return self
    end,
    put = function(self, v)
      self.x = v.x
      self.y = v.y
      return self
    end,
    move = function(self, t, md)
      local v = t:copy():sub(self)
      if v:mag() ~= 0 then
        if v:mag() <= md then
          self:put(t)
        else
          v:norm():scale(md)
          self:add(v)
        end
      end
      return self
    end,
    angle = function(self)
      if self.x == 0 and self.y == 0 then
        return 0
      end
      return math.atan(self.y / self.x)
    end,
    rotate = function(self, rad)
      local x = self.x * math.cos(rad) - self.y * math.sin(rad)
      local y = self.x * math.sin(rad) + self.y * math.cos(rad)
      self:set(x, y)
      return self
    end,
    dis = function(self, o)
      return o:copy():sub(self):mag()
    end,
    print = function(self)
      return "<" .. self.x .. "," .. self.y .. ">"
    end,
    pack = function(self)
      return {
        self.x,
        self.y
      }
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      self.x = x or 0
      self.y = y or 0
    end,
    __base = _base_0,
    __name = "vec"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  vec = _class_0
end
vec.lerp = function(a, b, t)
  return a:copy():scale(1 - t):add(b:copy():scale(t))
end

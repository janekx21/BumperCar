do
  local _class_0
  local _base_0 = {
    add = function(self, o)
      self.r = self.r + o.r
      self.g = self.g + o.g
      self.b = self.b + o.b
      self:clamp()
      return self
    end,
    scale = function(self, f)
      self.r = self.r * f
      self.g = self.g * f
      self.b = self.b * f
      self:clamp()
      return self
    end,
    sub = function(self, o)
      self.r = self.r - o.r
      self.g = self.g - o.g
      self.b = self.b - o.b
      self:clamp()
      return self
    end,
    put = function(self, value)
      self.r = value.r
      self.g = value.g
      self.b = value.b
      return self
    end,
    clamp = function(self)
      if self.r > 1 then
        self.r = 1
      end
      if self.r < 0 then
        self.r = 0
      end
      if self.g > 1 then
        self.g = 1
      end
      if self.g < 0 then
        self.g = 0
      end
      if self.b > 1 then
        self.b = 1
      end
      if self.b < 0 then
        self.b = 0
      end
      return self
    end,
    copy = function(self)
      return Color(self.r, self.g, self.b)
    end,
    pack = function(self)
      return {
        self.r,
        self.g,
        self.b
      }
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, r, g, b)
      self.r = r or 0
      self.g = g or 0
      self.b = b or 0
      return self:clamp()
    end,
    __base = _base_0,
    __name = "Color"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Color = _class_0
end
Color.fromHSL = function(h, s, l)
  if s <= 0 then
    return Color(l, l, l)
  end
  h, s, l = h * 6, s, l
  local c = (1 - math.abs(2 * l - 1)) * s
  local x = (1 - math.abs(h % 2 - 1)) * c
  local m, r, g, b = (l - .5 * c), 0, 0, 0
  if h < 1 then
    r, g, b = c, x, 0
  elseif h < 2 then
    r, g, b = x, c, 0
  elseif h < 3 then
    r, g, b = 0, c, x
  elseif h < 4 then
    r, g, b = 0, x, c
  elseif h < 5 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end
  local color = Color((r + m), (g + m), (b + m))
  return color
end
Color.RED = Color(1, 0, 0)
Color.GREEN = Color(0, 1, 0)
Color.BLUE = Color(0, 0, 1)
Color.WHITE = Color(1, 1, 1)
Color.BLACK = Color(0, 0, 0)

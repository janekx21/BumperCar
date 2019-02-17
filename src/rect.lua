require("vec")
do
  local _class_0
  local _base_0 = {
    get = function(self)
      return self.pos:copy():sub(self.pivot), self.size
    end,
    inflate = function(self, value)
      self.size:add(value)
      return self.pivot:add(value:copy():scale(.5))
    end,
    center = function(self)
      self.pivot = self.size:copy():scale(.5)
      return self
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, pos, size, pivot)
      self.pos = pos or vec()
      self.size = size or vec()
      self.pivot = pivot or vec()
    end,
    __base = _base_0,
    __name = "rect"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  rect = _class_0
end

require("vec")
do
  local _class_0
  local _base_0 = {
    die = function(self)
      local index = -1
      for i, item in pairs(Entity.all) do
        if item == self then
          index = i
          break
        end
      end
      if index ~= -1 then
        return table.remove(Entity.all, index)
      else
        return print("Entity not found")
      end
    end,
    update = function(self, dt)
      self.t = self.t + dt
    end,
    draw = function(self)
      return Nil
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, pos)
      self.pos = pos
      self.z = 0
      self.t = 0
      return table.insert(Entity.all, self)
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
Entity.all = { }

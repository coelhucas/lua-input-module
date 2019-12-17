local Input = {}
local mtInput = { __index = Input }

--[[
  inputs table must be like:
  { key = 'x',
    axis = 'y',
    button: 'dpdown'
    mouse = 'z'
  }
]] --

inputStates = {
  notpressed = 0,
  pressed = 1,
  notclicking = 2,
  clicking = 3
}

mouseButtons = {
  left = 1,
  right = 2,
  middle = 3
}

function Input.new()
  local input = {}
  input.binds = {}
  input.joystick = love.joystick.getJoysticks()[1]

  return setmetatable(input, mtInput)
end

function Input:bind(inputs, action)
  -- If we don't have this binding yet, we register it with the desired alias (action name)
  if (not self.binds[action]) then
    self.binds[action] = inputs
    self.binds[action].elapsedTime = 0
    self.binds[action].delay = 0.3
    self.binds[action].down = false
    self.binds[action].prevstate = inputStates.notpressed
    self.binds[action].state = inputStates.notpressed
    end
end

function Input:update()
  for action, input in pairs(self.binds) do
    -- We run actions internally for update the state as needed
    self:released(action)
    self:pressed(action)
    self:down(action)

    -- Detects for input changes
    if (input.key) then
      for _, key in pairs(input.key) do
        if (love.keyboard.isDown(key) and self.binds[action].state ~= inputStates.clicking) then
          self.binds[action].state = inputStates.pressed
          self.binds[action].down = true
          break
        elseif (self.binds[action].state ~= inputStates.clicking) then
      -- 'Reset' changes if released
            self.binds[action].state = inputStates.notpressed
          self.binds[action].down = false
        end
      end
    end

    -- TODO: receive also AXIS and MOUSE inputs

    -- Mouse Handling
    if (input.mouse) then
      if (love.mouse.isDown(mouseButtons[input.mouse]) and self.binds[action].state ~= inputStates.pressed) then
        self.binds[action].state = inputStates.pressed
        self.binds[action].down = true
        break
      elseif (self.binds[action].state ~= inputStates.pressed) then
        self.binds[action].state = inputStates.notpressed
        self.binds[action].down = false
      end
    end

    -- Joystick Handling: MUST BE TESTED!
    if (input.button and self.joystick ~= nil) then
      if (self.joystick:isDown(input.button) and self.binds[action].state ~= inputStates.clicking) then
        self.binds[action].state = inputStates.pressed
        self.binds[action].down = true
      elseif (self.binds[action].state ~= inputStates.clicking) then
        self.binds[action].state = inputStates.notpressed
        self.binds[action].down = false
      end
    end
  end
end

-- Detects single press action
function Input:pressed(action)
  if (self.binds[action] ~= nil) then
    if (self.binds[action].prevstate == inputStates.notpressed and self.binds[action].state == inputStates.pressed) then
      self.binds[action].prevstate = self.binds[action].state
      return true
    end
  end
end

-- Detects just release action
function Input:released(action)
  if (self.binds[action] ~= nil) then
    if (self.binds[action].prevstate == inputStates.pressed and self.binds[action].state == inputStates.notpressed) then
      self.binds[action].prevstate = self.binds[action].state
      return true
    end
  end
end

-- Detects input holding
function Input:down(action)
  if (self.binds[action] ~= nil) then
    return self.binds[action].down
  end
end

-- Receive Mouse position
function Input:getMousePosition()
  return love.mouse.getPosition()
end

return Input

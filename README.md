# LIM

Lua Input Module library. It has simple asbtractions on top of the love input functions and isn't totally complete yet [1]
It's a great alternative to make different inputs being handled with only one registered action.

[1] - Input Axis are not handled yet, and gamepad actions must be tested.

## Example

```lua
local Input = require 'input'

function love.load()
  input = Input.new()
  -- To register an action called 'left' which will be triggered with A, left arrow or left mousebutton
  input:bind(key = { 'a', 'left' }, mouse = left, 'left')
end

function love.update()
  if (input:down('left')) then
    print('left action is down')
  end
end
```

And simple as that your input will be handled automagically.

## API

```lua
  -- Creates a new input
  input = Input.new()

  -- Bind an unique key to an action called jump
  input:bind({ key = {'up'} }, 'jump')

  -- Bind a mouse button and a gamepad button on the same action
  input:bind({ mouse = 'left', button = 'start' }, 'start')

  -- Input callbacks (called on your update function)
  -- Check for binded action single press
  if input:pressed('start') then print('start the game') end

  -- Check for binded action down
  if input:down('start') then print('holding start action') end

  -- Check for binded action just released
  if input:down('start') then print('released start action') end
```

## TODO List

- [ ] Handle gamepad axis
- [ ] Test gamepad functionalities
- [ ] Support multiple joysticks (won't resolve until I need it)

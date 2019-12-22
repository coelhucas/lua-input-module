# LIM

Lua Input Module library. It has simple asbtractions on top of the love input functions and isn't totally complete yet [1]
It's a great alternative to make different inputs being handled with only one registered action.

[1] - [check the current TODO list](#todo-list)

## Example

```lua
local Input = require 'input'

function love.load()
  input = Input.new()
  -- To register an action called 'left' which will be triggered with A, left arrow or left mouse button
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

  -- Check mouse position (Just the love.mouse.getPosition() wrapped inside input)
  input:getMousePosition()

  --[[
  Mouse buttons mapped to love indexes:
  left = 1
  right = 2
  middle = 3

  You don't need to worry about it, just using left, right or middle and mouse's table
  field and it'll be converted internally
  ]]--
```

## TODO List

- [ ] Handle gamepad axis
- [ ] Test gamepad functionalities
- [ ] Support multiple joysticks (won't resolve until I need it)

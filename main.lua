local novum = require 'novum'

local system_start = love.timer.getTime()

novum.title = 'DhilltOS'
novum.versioning.game = '0.2.0'

print(novum.title .. ' ('..novum.versioning.game..')')

io.write('Preparing GUI mode... ')
love.mouse.setVisible(false)
novum:dynamicTitle()
novum:discoverAllScenes()
novum:discoverAllTransitions()
print('[OK]')

io.write('Adding math helpers... ')
function math.interpolationWrapper(fn)
	return function(a, b, t)
		return a + (b-a)*fn(t)
	end
end
math.lerp = math.interpolationWrapper(function(x) return x end)
math.smoothInterpolation = math.interpolationWrapper(function(x) return x*x*(3-2*x) end)
print('[OK]')

print('Loading system-relative toolkits: ')
io.write('  Creating "using" function... ')
function using(mod)
	if type(mod) == 'string' then
		return require('vstorage.lib.' .. mod)
	elseif type(mod) == 'table' then
		local modTable = {}
		for i, v in ipairs(mod) do
			table.insert(modTable, require('vstorage.lib.' .. v))
		end
		return (unpack or table.unpack)(modTable)
	end
end
print('[OK]')

io.write('  Importing object-oriented tools... ')
Object = require "classic"
print('[OK]')

io.write('  Importing DCL... ')
DCL = using "dcl"
print('[OK]')
io.write('  Importing FontManager... ')
FontManager = using "fontmanager"
FontManager:setFont(12)
print('[OK]')

io.write('Loading system resources... ')
SYSTEM = {
	images = novum.autoImport('image', 'vstorage/sys/img'),
	cursors = novum.autoImport('image', 'vstorage/sys/cursors'),
	icons = novum.autoImport('image', 'vstorage/sys/icons'),
}
SYSTEM.cursors.hidden = true
print('[OK]')

io.write('  Importing internal error toast system... ')
novum.toasts.renderSingle = using "toasts"
print('[OK]')

io.write('Loading graphical cursor system... ')
CURSORSTATE = 'normal'
novum:hookCallback('update', function()
	CURSORSTATE = 'normal'
end)
local CURSORSTATEERROR = ''
novum:hookCallback('overlay', function()
	if not SYSTEM.cursors[CURSORSTATE] then
		if CURSORSTATE ~= CURSORSTATEERROR then
			novum.toasts:post('error', 'Attempted to set invalid cursor state "'..CURSORSTATE..'". Falling back to "normal".')
		end
		CURSORSTATEERROR = CURSORSTATE
		CURSORSTATE = 'normal'
	end
	if CURSORSTATE ~= 'hidden' then
		love.graphics.setColor(1,1,1,1)
		local x, y = love.mouse.getPosition()
		local cs = 56
		love.graphics.draw(SYSTEM.cursors[CURSORSTATE], x, y, 0, cs/SYSTEM.cursors[CURSORSTATE]:getWidth(), cs/SYSTEM.cursors[CURSORSTATE]:getHeight(), SYSTEM.cursors[CURSORSTATE]:getWidth()/2, SYSTEM.cursors[CURSORSTATE]:getHeight()/2)
	end
end)
print('[OK]')

io.write('Verifying user list... ')
local users = love.filesystem.getDirectoryItems('vstorage/usr/')
print('['..#users..' user(s)]')
if #users < 1 then
	print('Out Of Box Experience will be launched.')
	novum.toasts:post('info', 'It seems like it\'s your first time here. We will launch the setup wizard for you.')
end

io.write('Creating status overlay (F12)... ')
novum:hookCallback('overlay', function(game)
	if love.keyboard.isDown('f12') then
		love.graphics.setColor(0, 0, 0, 0.5)
		love.graphics.rectangle('fill', 0, 0, 300, love.graphics.getHeight())
		FontManager:setFont(12)
		love.graphics.setColor(1, 1, 1)
		love.graphics.printf('Uptime', 0, 0, 300, 'left')
		love.graphics.printf(string.format("%.3f", love.timer.getTime()-system_start), 0, 0, 300, 'right')
		love.graphics.printf('Resolution', 0, 12*1, 300, 'left')
		love.graphics.printf(love.graphics.getWidth() .. 'x' .. love.graphics.getHeight(), 0, 12*1, 300, 'right')
		love.graphics.printf('Host platform', 0, 12*2, 300, 'left')
		love.graphics.printf(love.system.getOS(), 0, 12*2, 300, 'right')
		love.graphics.printf('Processors', 0, 12*3, 300, 'left')
		love.graphics.printf(love.system.getProcessorCount(), 0, 12*3, 300, 'right')
		local state, percent, seconds = love.system.getPowerInfo()
		love.graphics.printf('Power state', 0, 12*4, 300, 'left')
		love.graphics.printf(state, 0, 12*4, 300, 'right')
		love.graphics.printf('Battery SoC', 0, 12*5, 300, 'left')
		love.graphics.printf(tostring(percent), 0, 12*5, 300, 'right')
		love.graphics.printf('Battery time left', 0, 12*6, 300, 'left')
		love.graphics.printf(tostring(seconds), 0, 12*6, 300, 'right')
	end
end)
print('[OK]')

print('Starting GUI mode!')

print()
quotes = {
	'"we ballin"\n- kevadesu',
	'"forget linux, this is the real stuff"\n- Mizu',
	'"designing a full graphical user interface toolkit from scratch is very fun :3 (save me)"\n- Mizu',
	'"A computer is like air conditioning; it becomes useless when you open windows"\n- Lap'
}
print(quotes[love.math.random(#quotes)])
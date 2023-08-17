local novum = require 'novum'

novum.title = 'DhilltOS'
novum.versioning.game = '0.1.0'

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

io.write('Loading system resources... ')
SYSTEM = {
	images = novum.autoImport('image', 'vstorage/sys/img'),
	cursors = novum.autoImport('image', 'vstorage/sys/cursors'),
}
print('[OK]')

novum:hookCallback('overlay', function()
	love.graphics.setColor(1,1,1,1)
	local x, y = love.mouse.getPosition()
	local cs = 48
	love.graphics.draw(SYSTEM.cursors.normal, x, y, 0, cs/SYSTEM.cursors.normal:getWidth(), cs/SYSTEM.cursors.normal:getHeight())
end)

print('Starting GUI mode...')
print('we ballin')

-- the GUI toolkit (vstorage/lib/dcl)
-- i already started a small server that doesn't support interaction yet
-- nor does it update
-- nor does it render lmao
-- lmao
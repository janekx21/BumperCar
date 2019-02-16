require "world"

w = 1920
h = 1080
print w/1,h/1
print w/2,h/2
print w/3,h/3
print w/4,h/4

love.load = ()->
	love.window.setMode(960,540,{vsync:false,resizable:true})
	love.graphics.setBackgroundColor .1,.1,.1
	export w = World!

	file = love.filesystem.newFile "test.txt"
	text,size = file\read!
	print text

love.update = (dt)->
	w\update dt
love.draw = ()->
	w\draw!
	love.graphics.print "fps: #{love.timer.getFPS!}",0,0

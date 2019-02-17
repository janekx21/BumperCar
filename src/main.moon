require "world"
require "car"
require "vec"

love.load = ()->
	love.window.setMode(960,540,{vsync:false,resizable:true})
	love.graphics.setLineWidth 4
	love.graphics.setBackgroundColor .12,.1,.1
	export w = World!
	Car vec(256,256),1
	Car vec(256,256),2
	Car vec(256,256),3
	Car vec(256,256),4

love.update = (dt)->
	w\update dt

love.draw = ()->
	w\draw!
	love.graphics.print "fps: #{love.timer.getFPS!}",0,0

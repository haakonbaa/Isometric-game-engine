function love.load()
	engine = require("engine.engine");
	love.graphics.setBackgroundColor(135,206,250);
end

function love.draw()
	love.graphics.push();
	love.graphics.translate(1366/2,768/2);
	--for x = -9,9,3 do
		--for y = -9,9,3 do
			--love.graphics.setColor(124,252,0,255);
			--engine.graphics.plane("fill",x,y,0,1,1);
			--love.graphics.setColor(0,0,0,255);
			--engine.graphics.plane("line",x,y,0,1,1);
		--end
	--end
	love.graphics.setColor(124,252,0,255);
	engine.graphics.plane("fill",-2,-2,0,4,4);
	love.graphics.setColor(0,0,0,255);
	engine.graphics.plane("line",-2,-2,0,4,4);
	love.graphics.pop();
end

function love.update( dt )
	engine.update(dt)
end

function love.keypressed( key, unicode )
	if key == "escape" then love.event.quit(); end
end

function love.load()
	engine = require("engine.engine");
	love.graphics.setBackgroundColor(135*0.2,206*0.2,250*0.2);

	engine.world.newObject.planeX( "fill", 0, 0, 0, 1, 1, {45,12,220}, 1 );
	engine.world.newObject.planeX( "line", 0, 0, 0, 1, 1, {0,0,0}, 1 );
	engine.world.newObject.planeX( "fill", 1, 0, 0, 1, 1, {45,240,40}, 1 );
	engine.world.newObject.planeX( "line", 1, 0, 0, 1, 1, {0,0,0}, 1 );
	engine.world.newObject.planeZ( "fill", 0, 0, 0, 1, 1, {230,12,45},1 );
	engine.world.newObject.planeZ( "line", 0, 0, 0, 1, 1, {0,0,0}, 2 );
	engine.world.newObject.planeZ( "fill", 0, 0, 1, 1, 1, {12,233,244}, 2 );
	engine.world.newObject.planeZ( "line", 0, 0, 1, 1, 1, {0,0,0}, 2 );
	for x = 0, 10 do
		for y = 0, 10 do
			--engine.world.newObject.planeZ( "fill", x, y, 0, 1, 1, {math.random()*25,230 + 25*math.random(),math.random()*25}, 1 );
			--engine.world.newObject.planeZ( "line", x, y, 0, 1, 1, {0,0,0}, 1 );
		end
	end
end

function love.draw()
	love.graphics.push();
	love.graphics.translate( 1366/2, 768/2 );
	engine.world.draw();
	love.graphics.pop();
end

function love.update( dt )
	engine.update(dt)
end

function love.keypressed( key, unicode )
	if key == "escape" then love.event.quit(); end
end

--[[
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
--world.newObject.planeX("line", -2, -2, 0, 4, 4 );
engine.graphics.plane("line",-2,-2,0,4,4);
--]]

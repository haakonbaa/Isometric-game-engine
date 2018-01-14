function love.load()
	engine = require("engine.engine");
	love.graphics.setBackgroundColor(135*0.2,206*0.2,250*0.2);
	for x = 0, 10 do
		for y = 0, 10 do
			if y > 0 and y < 4 and x < 5 then
				-- Nothing
			else
				engine.world.newObject.planeZ( "fill", x, y, 0, 1, 1, {math.random()*25,230 + 25*math.random(),math.random()*25}, 1 );
			end
		end
	end
	engine.world.newObject.box("fill",2.25,6.25,0,0.5,0.5,1.5,{83,53,10},"trunk");
	engine.world.newObject.box("line",2.25,6.25,0,0.5,0.5,1.5,{0,0,0},"trunk");
	engine.world.newObject.box("fill",2-0.25,6-0.25,1.5,1.5,1.5,2.5,{45,200,0},"bush");
	engine.world.newObject.box("line",2-0.25,6-0.25,1.5,1.5,1.5,2.5,{0,0,0},"bush");

	engine.world.newObject.box("fill",6+2.25,3.25,0,0.5,0.5,1.5,{83,53,10},"trunk");
	engine.world.newObject.box("line",6+2.25,3.25,0,0.5,0.5,1.5,{0,0,0},"trunk");
	engine.world.newObject.box("fill",6+2-0.25,3-0.25,1.5,1.5,1.5,2.5,{45,200,0},"bush");
	engine.world.newObject.box("line",6+2-0.25,3-0.25,1.5,1.5,1.5,2.5,{0,0,0},"bush");

	engine.world.newObject.planeZ( "fill", 0, 1, 0, 5, 3, {200,200,200}, "parking" );
	for x = 0, 10 do
		for y = 0, 10 do
			if ((x == 0 or x == 10) or (y == 0 or y == 10) ) and ( not ( (y == 1 or y == 2 or y == 3) and ( x == 0 ) ) ) then
				engine.world.newObject.box("fill",x+0.25,y+0.25,0,0.5,0.5,1.5,{25,190,10},"bush");
				engine.world.newObject.box("line",x+0.25,y+0.25,0,0.5,0.5,1.5,{0,0,0},"bush");
			end
		end
	end

end

function love.draw()
	love.graphics.push();
	love.graphics.translate( 1366/2, 768/2 );
	engine.world.draw();
	love.graphics.pop();
	love.graphics.setColor(0,0,0);
	love.graphics.print(love.timer.getFPS(),5,5);
end

function love.update( dt )
	engine.update(dt)
end

function love.keypressed( key, unicode )
	if key == "escape" then love.event.quit(); end
end

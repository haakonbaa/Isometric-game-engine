camera = require("engine.isometricCamera");
local engine = {
    graphics = require("engine.graphics");
    controls = require("engine.controls");
    world = require("engine.world");
};

function engine.update(dt)
    controls.update(dt);
    world.update(dt);
end

return engine;

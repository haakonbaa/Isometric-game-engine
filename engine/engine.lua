camera = require("engine.isometricCamera");
local engine = {
    graphics = require("engine.graphics");
    controls = require("engine.controls");
};

function engine.update(dt)
    controls.update(dt);
end

return engine;

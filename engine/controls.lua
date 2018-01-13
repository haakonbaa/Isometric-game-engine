controls = {
    enabled = true,
    rotateByKeys = true,
    speeds = {
        moveX = 1,
        moveY = 1,
        moveZ = 1,
        rotZ = math.pi/4,
        rotX = math.pi/4
    },
    keyMap = {
        moveUp =        "space",
        moveDown =      "lshift",
        moveRight =     "d",
        moveLeft =      "a",
        moveForward =   "w",
        moveBackward =  "s",
        rotateZPos =    "left",
        rotateZNeg =    "right",
        rotateXPos =    "up",
        rotateXNeg =    "down"
    }
};
local map = controls.keyMap;

function controls.update( dt )
    if controls.enabled then
        if love.keyboard.isDown( map.moveUp ) then
            camera.camera.z = camera.camera.z + controls.speeds.moveZ*dt;
        end
        if love.keyboard.isDown( map.moveDown ) then
            camera.camera.z = camera.camera.z - controls.speeds.moveZ*dt;
        end
        if love.keyboard.isDown( map.moveRight ) then
            camera.camera.x = camera.camera.x + controls.speeds.moveX*dt;
        end
        if love.keyboard.isDown( map.moveLeft ) then
            camera.camera.x = camera.camera.x - controls.speeds.moveX*dt;
        end
        if love.keyboard.isDown( map.moveForward ) then
            camera.camera.y = camera.camera.y + controls.speeds.moveY*dt;
        end
        if love.keyboard.isDown( map.moveBackward ) then
            camera.camera.y = camera.camera.y - controls.speeds.moveY*dt;
        end
        if controls.rotateByKeys then
            if love.keyboard.isDown( map.rotateZPos ) then
                camera.camera.rotationZ = camera.camera.rotationZ + controls.speeds.rotZ*dt;
            end
            if love.keyboard.isDown( map.rotateZNeg ) then
                camera.camera.rotationZ = camera.camera.rotationZ - controls.speeds.rotZ*dt;
            end
            if love.keyboard.isDown( map.rotateXPos ) then
                camera.camera.rotationX = camera.camera.rotationX + controls.speeds.rotX*dt;
            end
            if love.keyboard.isDown( map.rotateXNeg ) then
                camera.camera.rotationX = camera.camera.rotationX - controls.speeds.rotX*dt;
            end
        end
    end
end

function controls.setEnabled( boolean )
    assert( type(boolean) == "boolean","controls.setEnabled() anly accepts booleans!")
    controls.enabled = boolean;
end

function controls.mapKey( keyName, action )
    assert( map[action],"Action: '"..tostring(action).."' does not exist!");
    assert( type( keyName ) == "string", "Keyname is not a string!");
    map[action] = keyName;
end

return controls;

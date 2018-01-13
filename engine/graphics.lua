local graphics = {
};

function graphics.plane( mode, x, y, z, w, l )
    local mode = mode;
    if not ( mode == "line" or mode == "fill" ) then
        mode = "fill";
    end
    x = x or 0;
    y = y or 0;
    w = w or 1;
    l = l or 1;
    local x1 , y1 = camera.translatePoint.dynamicRotation( x, y, z );
    local x2 , y2 = camera.translatePoint.dynamicRotation( x+w, y, z );
    local x3 , y3 = camera.translatePoint.dynamicRotation( x+w, y+l, z );
    local x4 , y4 = camera.translatePoint.dynamicRotation( x, y+l, z );
    local x1 , y1 = x1*camera.scale.width , y1*camera.scale.height;
    local x2 , y2 = x2*camera.scale.width , y2*camera.scale.height;
    local x3 , y3 = x3*camera.scale.width , y3*camera.scale.height;
    local x4 , y4 = x4*camera.scale.width , y4*camera.scale.height;
    love.graphics.polygon( mode, {x1,y1,x2,y2,x3,y3,x4,y4} );
end

return graphics;

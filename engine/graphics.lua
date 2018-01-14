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
    love.graphics.polygon( mode, {x1,y1,x2,y2,x3,y3,x4,y4} );
end

return graphics;

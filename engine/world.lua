world = {
    drawMode = "dynamicRotation";
    objects = {},
    newObject = {}
};

local function getAverageTable( vertices )
    local sumX = 0;
    local sumY = 0;
    local sumZ = 0;
    local tableLength = #vertices;
    for index = 1, tableLength do
        sumX = sumX + vertices[index][1];
        sumY = sumY + vertices[index][2];
        sumZ = sumZ + vertices[index][3];
    end
    return {
        x = sumX / tableLength,
        y = sumY / tableLength,
        z = sumZ / tableLength
    };
end

function world.newObject.planeZ( mode, x, y, z, w, l, color, id )
    local object = {
        color = { r = color[1], g = color[2], b = color[3] },
        type = "plane",
        subType = mode,
        distance = math.huge,
        id = id or 0
    };
    local vertices = {{x,y,z},{x+w,y,z},{x+w,y+l,z},{x,y+l,z}};
    object["vertices"] = vertices;
    object["average"] = getAverageTable( vertices );
    table.insert( world.objects, object );
end

function world.newObject.planeX( mode, x, y, z, h, l, color, id )
    local object = {
        color = { r = color[1], g = color[2], b = color[3] },
        type = "plane",
        subType = mode,
        distance = 10, -- It might be wise to set this to math.huge.
        id = id or 0
    };
    local vertices = {{x,y,z},{x,y,z+h},{x,y+l,z+h},{x,y+l,z}};
    object["vertices"] = vertices;
    object["average"] = getAverageTable( vertices );
    print( tableToString(vertices) , tableToString(getAverageTable( vertices )));
    table.insert( world.objects, object );
end

function world.update( dt )
    for index = 1, #world.objects do
        local object = world.objects[index];
        local a,b,c = camera.translatePoint[ world.drawMode ]( object.average.x, object.average.y, object.average.z );
        object.distance = c;
        -- temporary solution to draw lines with higher priority
        if world.objects[index].subType == "line" then
            object.distance = object.distance - 0.01;
        end
    end

    table.sort( world.objects, function( obj1, obj2 )
        return obj1.distance > obj2.distance;
    end );
end

function world.draw()
    for index = 1, #world.objects do
        world.drawObject( world.objects[index] );
    end
end

function world.drawObject( object )
    local vertices = {};
    for index = 1, #object.vertices do
        local v = object.vertices[index];
        local x, y = camera.translatePoint[ world.drawMode ]( v[1], v[2], v[3] );
        table.insert( vertices, x );
        table.insert( vertices, y );
    end
    love.graphics.setColor( object.color.r, object.color.g, object.color.b);
    if object.type == "plane" then
        love.graphics.polygon( object.subType, vertices );
    end
end

-- This function is only for debugging!
function tableToString( table )
	local result = "";
	for i , v in pairs( table ) do
		local addon = "";
		if type( i ) == "string" then
			addon = i.."=";
		elseif i <= 0 then
			addon = "["..i.."]=";
		end
		typeV = type( v );
		if typeV == "number" then --Nothing
		elseif typeV == "boolean" then if v then v = "true"; else v = "false"; end
		elseif typeV == "string" then v = string.format("%q",v);
		elseif typeV == "table" then v = tableToString( v );
		elseif typeV == "function" then v = "'function'";
		end
		result = result .. "," .. addon .. v
	end
	return "{" .. string.sub( result , 2 ).. "}";
end

return world;

--object.distance =
--    ( camera.camera.x - object.average.x )^2 +
--    ( camera.camera.y - object.average.y )^2 +
--    ( camera.camera.z - object.average.z )^2;

--[[
Objects are just several planes or other 3d-shapes
put together to create a world. An object closer
to the camera will be drawn inforont of objects
further away.

Objects are built using tis syntax:
object = {
    color = {r=,g=,b=},
    type = "",           plane/box/circle...
    subType = "",        line/fill...
    id = number,         0 if an id is not set.
    distance = math.huge
    vertices = {{x,y,z},{x,y,z}...},
    average = {
        x =
        y =
        z =
    }
};
]]--

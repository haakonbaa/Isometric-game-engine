isometric = {
    scale = {
        width = 100,
        height = 100
    },
    camera = {
        x = 0,
        y = 0,
        z = 2,
        rotationZ = math.pi/4,---math.pi/4,
        rotationX = -math.atan(1/math.sqrt(2)),
    },
    draw = {
        x = 0,
        y = 0,
        width = 400,
        height = 400,
    },
    constants = {
        invsqrt2 = 1/math.sqrt(2),
        invsqrt3 = 1/math.sqrt(3),
        invsqrt6 = 1/math.sqrt(6)
    },
    objects = {},
    translatePoint = {}
};

-- Returns the determinant of a 3x3 vector. See
-- https://www.chilimath.com/lessons/advanced-algebra/cramers-rule-with-three-variables/
-- for more information.
local function determinant( a, b, c, d, e, f, g, h, i )
    return a * e * i + b * f * g + c * d * h - c * e * g - b * d * i - a * f * h;
end

-- Translates a point in 3-dimentions to 2-dimentional x/y-screen coordinates.
function isometric.translatePoint.dynamicRotation( x , y , z )
    -- difference between camera and point to translate:
    local dx = x - isometric.camera.x;
    local dy = y - isometric.camera.y;
    local dz = z - isometric.camera.z;

    --[[
    We have tree vectors defined by two angles a and b:

    u = [ cos(a)        ,  sin(a)       ,     0  ]
    v = [ -cos(b) sin(a),  cos(b) cos(a), sin(b) ]
    w = [  sin(b) sin(a), -sin(b) cos(a), cos(b) ]

    We will need to solve a system of three linear equations:...

    ux a + vx b + wx c = dx
    uy a + vy b + wy c = dy
    uz a + vz b + wz c = dz

    to find what combination of vectors add up to the vector
    between the camera and the point to be translated.

    to solve the equation, Cramer's rule will be used.
    (https://en.wikipedia.org/wiki/Cramer%27s_rule)
    --].]
    ]]--
    local cosA = math.cos( isometric.camera.rotationZ );
    local sinA = math.sin( isometric.camera.rotationZ );
    local cosB = math.cos( isometric.camera.rotationX );
    local sinB = math.sin( isometric.camera.rotationX );

    local ux, uy, uz =          cosA,         sinA,     0;
    local vx, vy, vz = - cosB * sinA,   cosB * cosA, sinB;
    local wx, wy, wz =   sinB * sinA, - sinB * cosA, cosB;

    local det  = determinant( ux, vx, wx, uy, vy, wy, uz, vz, wz );
    local detA = determinant( dx, vx, wx, dy, vy, wy, dz, vz, wz );
    local detB = determinant( ux, dx, wx, uy, dy, wy, uz, dz, wz );
    local detC = determinant( ux, vx, dx, uy, vy, dy, uz, vz, dz );

    local u = detA / det;
    local v = detB / det;
    local w = detC / det;

    -- 'w' has to be negative since y-axis is mirrored from the cartesian coordinat system
    return u , -w, v,v > 0;
end

-- assumes the rotation is math.pi/4 and math.pi/4,-math.atan(1/math.sqrt(2))
function isometric.translatePoint.staticRotation( x , y , z )
    local dx = x - isometric.camera.x;
    local dy = y - isometric.camera.y;
    local dz = z - isometric.camera.z;
    local detA = isometric.constants.invsqrt2*(  dx+dy     );
    local detB = isometric.constants.invsqrt3*(  dy-dx-dz  );
    local detC = isometric.constants.invsqrt6*( 2*dz+dy-dx );
    return detA, -detC, detB,detB > 0;
end

function isometric.camera.setPosition( x, y, z )
    isometric.camera.x = x or isometric.camera.x;
    isometric.camera.y = y or isometric.camera.y;
    isometric.camera.z = z or isometric.camera.z;
end

function isometric.camera.movePosition( x, y, z )
    isometric.camera.x = isometric.camera.x + (x or 0);
    isometric.camera.y = isometric.camera.y + (y or 0);
    isometric.camera.z = isometric.camera.z + (z or 0);
end

function isometric.camera.getPosition( )
    return isometric.camera.x, isometric.camera.y, isometric.camera.z;
end

function isometric.camera.setRotation( rotZ, rotX )
    isometric.camera.rotationZ = rotZ or isometric.camera.rotationZ;
    isometric.camera.rotationX = rotX or isometric.camera.rotationX;
end

function isometric.camera.moveRotation( rotZ, rotX )
    isometric.camera.rotationZ = isometric.camera.rotationZ + (rotZ or 0);
    isometric.camera.rotationX = isometric.camera.rotationX + (rotX or 0);
end

function isometric.camera.getRotation( )
    return isometric.camera.rotationZ, isometric.camera.rotationX;
end

return isometric;

--[[
local cosA = math.sqrt(2)/2;
local sinA = math.sqrt(2)/2;
local cosB = math.sqrt(6)/3;
local sinB = -math.sqrt(3)/3;
local ux, uy, uz =  math.sqrt(2)/2, math.sqrt(2)/2,               0;
local vx, vy, vz = -math.sqrt(3)/3, math.sqrt(3)/3, -math.sqrt(3)/3;
local wx, wy, wz = -math.sqrt(6)/6, math.sqrt(6)/6,  math.sqrt(6)/3;
--]]

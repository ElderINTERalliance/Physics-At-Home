missing_texture = love.graphics.newImage('missing_texture.png')

Entity ={}
Entity.prototype={health=1,x=0,y=0,hitbox={[[0,0],[0,0]]},hurtbox={[[0,0],[0,0]]},texture=missing_texture}
function Entity.new(o)
    setmetatable(o, Entity.mt)
    return o
end
Entity.mt={}
Entity.mt.__index = function (table, key)
    return Entity.prototype[key]
end
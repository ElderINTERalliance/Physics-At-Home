Draw = {}

function Draw.Shape(shape, r, g, b, a, ...)
    love.graphics.setColor(r, g, b, a)
    love.graphics[shape](...)
    love.graphics.setColor(1, 1, 1, 1)
end

local lab = {}

lab.args = {}
local restit = 1
function lab.load()
    -- the height of a meter our worlds will be 64px
    love.physics.setMeter(64)
    -- create a world for the bodies to exist in with horizontal gravity
    -- of 0 and vertical gravity of 9.81
    world = love.physics.newWorld(0, 0, false)

    local WIDTH, HEIGHT = 720, 576

    objects = {} -- table to hold all our physical objects

    -- let's create the ground
    objects.ground = {}
    -- remember, the shape (the rectangle we create next) anchors to the
    -- body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground.body = love.physics.newBody(world, WIDTH / 2, HEIGHT - 50 / 2)
    objects.ground.shape = love.physics.newRectangleShape(650, 50)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

    objects.wall1={}
    objects.wall1.body = love.physics.newBody(world, 10, HEIGHT/2)
    -- make wall1angle with a width of 650 and a height of 50
    objects.wall1.shape = love.physics.newRectangleShape(20, 50)
    -- attacwall1e to body
    objects.wall1.fixture = love.physics.newFixture(objects.wall1.body, objects.wall1.shape)

    objects.wall2={}
    objects.wall2.body = love.physics.newBody(world, WIDTH - 10, HEIGHT/2)
    -- make wall2angle with a width of 650 and a height of 50
    objects.wall2.shape = love.physics.newRectangleShape(20, 50)
    -- attacwall2e to body
    objects.wall2.fixture = love.physics.newFixture(objects.wall2.body, objects.wall2.shape)
    -- let's create a ball
    -- place the body in the center of the world and make it dynamic, so
    objects.ball1 = {}
    objects.ball2 = {}
    objects.ball3 = {}
    objects.ball4 = {}
    objects.ball5 = {}

    objects.ball1.fv = {0,0}
    objects.ball2.fv = {0,0}
    objects.ball3.fv = {0,0}
    objects.ball4.fv = {0,0}
    objects.ball5.fv = {0,0}
    -- it can move around
    objects.ball1.body = love.physics.newBody(world, WIDTH / 2 -180, HEIGHT / 2, "dynamic")
    -- the ball'1s shape has a radius of 20
    -- Attach fi1xture to body and give it a density of 1.
    objects.ball1.shape = love.physics.newCircleShape(20)
    objects.ball1.fixture = love.physics.newFixture(objects.ball1.body, objects.ball1.shape, 1)
    objects.ball1.fixture:setRestitution(restit)

    objects.ball2.body = love.physics.newBody(world, WIDTH / 2 -60, HEIGHT / 2, "dynamic")
    -- the ball'2s shape has a radius of 20
    objects.ball2.shape = love.physics.newCircleShape(20)
    -- Attach fi2xture to body and give it a density of 1.
    objects.ball2.fixture = love.physics.newFixture(objects.ball2.body, objects.ball2.shape, 1)
    objects.ball2.fixture:setRestitution(restit)

    objects.ball3.body = love.physics.newBody(world, WIDTH / 2 , HEIGHT / 2, "dynamic")
    -- the ball'3s shape has a radius of 20
    objects.ball3.shape = love.physics.newCircleShape(20)
    -- Attach fi3xture to body and give it a density of 1.
    objects.ball3.fixture = love.physics.newFixture(objects.ball3.body, objects.ball3.shape, 1)
    objects.ball3.fixture:setRestitution(restit)

    objects.ball4.body = love.physics.newBody(world, WIDTH / 2 +60, HEIGHT / 2, "dynamic")
    -- the ball'4s shape has a radius of 20
    objects.ball4.shape = love.physics.newCircleShape(20)
    -- Attach fi4xture to body and give it a density of 1.
    objects.ball4.fixture = love.physics.newFixture(objects.ball4.body, objects.ball4.shape, 1)
    objects.ball4.fixture:setRestitution(restit)

    objects.ball5.body = love.physics.newBody(world, WIDTH / 2 +120, HEIGHT / 2, "dynamic")
    -- the ball'5s shape has a radius of 20
    objects.ball5.shape = love.physics.newCircleShape(20)
    -- Attach fi5xture to body and give it a density of 1.
    objects.ball5.fixture = love.physics.newFixture(objects.ball5.body, objects.ball5.shape, 1)
    objects.ball5.fixture:setRestitution(restit)

    ballobjs = {objects.ball1,objects.ball2,objects.ball3,objects.ball4,objects.ball5}

    -- let's create a couple blocks to play around with
    objects.block1 = {}
    objects.block1.body = love.physics.newBody(world, 200, HEIGHT - 50 - 50, "dynamic")
    objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
    -- A higher density gives it more mass.
    objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5)

    objects.block2 = {}
    objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
    objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
    objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

    love.physics.newWeldJoint( objects.block2.body, objects.block1.body, 200, 475, false )

    objects.ball1.body:applyLinearImpulse( 100, 0 )
    -- joint = love.physics.newFrictionJoint( objects.ground.body, objects.ball.body, 325, 580, false )
    --objects.ground.fixture:setFriction(0.5)
    --objects.ball.fixture:setFriction(0.5)
    --objects.ball.body:setAngularDamping(2)

    selObj = nil
end

function lab.update(dt)
    --if love.keyboard.isDown("space") then
        world:update(dt)
        objects.ball1.fv = {0,0}
    -- here we are going to create some keyboard events
    -- press the right arrow key to push the ball to the right
    if love.keyboard.isDown("right") then
        objects.ball1.body:applyForce(400, 0)
        --objects.ball1.fv[1] = objects.ball1.fv[1] + (400*dt)
        -- press the left arrow key to push the ball to the left
    elseif love.keyboard.isDown("left") then
        objects.ball1.body:applyForce(-400, 0)
        --objects.ball1.fv[1] = objects.ball1.fv[1] + (-400*dt)
        -- press the up arrow key to set the ball in the air
    elseif love.keyboard.isDown("up") then
        objects.ball1.body:applyForce(0, -400)
        -- we must set the velocity to zero to prevent a potentially large
        -- velocity generated by the change in position
        --objects.ball1.body:setLinearVelocity(0, 0)
    elseif love.keyboard.isDown("down") then
        objects.ball1.body:applyForce(0, 400)
    end

if love.keyboard.isDown('r') then
    objects.ball1.body:setPosition(650/2, 650/2)
    -- we must set the velocity to zero to prevent a potentially large
    -- velocity generated by the change in position
    --objects.ball.body:setInertia( 0 )
    objects.ball1.body:setLinearVelocity(0, 0)
    objects.ball1.body:setAngularVelocity( 0 )
  end
        
    --world:update(0)

    --if love.mouse.isDown(1) then
    --    -- print("mousedown")
    --    local x, y = maid64.mouse.getPosition()
--
    --    if selObj == nil then
    --        -- print("fart")
    --        for index, value in pairs(objects) do
    --            local bx, by = value.body:getPosition()
    --            if value.shape:testPoint(bx, by, 0, x, y) and value.body:getType() == "dynamic" then
    --                selObj = value
    --                selObj.body:setAwake(true)
    --            end
    --        end
    --    else
    --        selObj.body:setPosition(x, y)
    --        selObj.body:setLinearVelocity(0, 0)
    --        selObj.body:setAngularVelocity(0)
    --        fn={0,0}
    --    end
    --else
    --    selObj = nil
    --end
end

function lab.draw()
    -- set the drawing color to green for the ground
    love.graphics.setColor(0.28, 0.63, 0.05)
    -- draw a "filled in" polygon using the ground's coordinates
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
    love.graphics.setColor(0.76, 0.18, 0.05)
    --love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

    -- set the drawing color to red for the ball
    for index, value in ipairs(ballobjs) do
        love.graphics.setColor(0.76, 0.18, 0.05)
        love.graphics.circle("fill", value.body:getX(), value.body:getY(), value.shape:getRadius())
        local bx, by = value.body:getPosition()
        local vx, vy = value.body:getLinearVelocity()
        -- print(vx,vy)
        utils.DrawArrow(bx, by, ((vx) / 8 +value.fv[1]/2+ bx), ((vy) / 8 +value.fv[2]/2+ by), 2, 10)
    end

    -- set the drawing color to grey for the blocks
    love.graphics.setColor(0.20, 0.20, 0.20)
    love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
    love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

    love.graphics.polygon("fill", objects.wall1.body:getWorldPoints(objects.wall1.shape:getPoints()))
    love.graphics.polygon("fill", objects.wall2.body:getWorldPoints(objects.wall2.shape:getPoints()))
end

return lab

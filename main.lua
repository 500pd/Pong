function love.load()
    bold = love.graphics.newImage("bold.png")
    resetbold()
    ketcherv = love.graphics.newImage("ketcher.png")
    ketcherh = love.graphics.newImage("ketcher.png")
    ketchervy=love.graphics.getHeight()/2-ketcherv:getHeight()/2
    ketcherhy=love.graphics.getHeight()/2-ketcherh:getHeight()/2
    ketcherhx=love.graphics.getWidth()-ketcherh:getWidth()
    pointv = 0
    pointh = 0
    ketcherspeed=7
end
function love.update()
    x = speedx+x
    y = speedy+y
    if y >= love.graphics.getHeight()-bold:getHeight() or y <= 0 then
        speedy = -1*speedy
    end
    if x <= ketcherv:getWidth() and y>ketchervy and y<ketchervy+ketcherv:getHeight() then
         speedx = -1*speedx
    end
    if x >= ketcherhx-ketcherh:getWidth() and y>ketcherhy and y<ketcherhy+ketcherh:getHeight() then
         speedx = -1*speedx
    end
    if love.keyboard.isDown("up") and ketcherhy > 0 then
        ketcherhy = ketcherhy - ketcherspeed
    end
    if love.keyboard.isDown("down") and ketcherhy < love.graphics.getHeight() - ketcherh:getHeight()then
        ketcherhy = ketcherhy + ketcherspeed
    end
    if love.keyboard.isDown("w") and ketchervy > 0 then
        ketchervy = ketchervy - ketcherspeed
    end
    if love.keyboard.isDown("s") and ketchervy < love.graphics.getHeight() - ketcherv:getHeight() then
        ketchervy = ketchervy + ketcherspeed
    end
    if love.keyboard.isDown("r") then resetbold() end
    if love.keyboard.isDown("backspace") then reset() resetbold() end
    if x < 0 or x > love.graphics.getWidth() then
        if x>0 then pointv = pointv + 1 end
        if x<0 then pointh = pointh + 1 end
        resetbold()
    end
end
function resetbold()
	speedx=love.math.random(-7,7)
		speedy=love.math.random(-7,7)
	while speedx <= 4 and speedx >= -4 or speedy <= 4 and speedy >= -4 do
		speedx=love.math.random(-7,7)
		speedy=love.math.random(-7,7)
    end
    x = love.graphics.getWidth()/2-bold:getWidth()/2
    y = love.graphics.getHeight()/2
end
function reset()
	pointv=0
	pointh=0
end
function love.draw()
    love.graphics.draw(bold, x, y)
    love.graphics.setBackgroundColor(86, 138, 200)
    --love.graphics.print(speedx,0,0)
    --love.graphics.print(speedy,0,10)
    love.graphics.draw(ketcherv, 0, ketchervy)
    love.graphics.draw(ketcherh, ketcherhx, ketcherhy)
    love.graphics.print(pointv,love.graphics.getWidth()*0.25,0)
    love.graphics.print(pointh,love.graphics.getWidth()*0.75,0)
    love.graphics.line(love.graphics.getWidth()/2,0,love.graphics.getWidth()/2,love.graphics.getHeight())
end

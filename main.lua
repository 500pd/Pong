function love.load()
	paused = false
    bold = love.graphics.newImage("bold.png")
    resetbold()
    ketcherv = love.graphics.newImage("ketcher.png")
    ketcherh = love.graphics.newImage("ketcher.png")
    skalerketchery=(love.graphics.getHeight()/5)/ketcherv:getHeight()
	skalerketcherx=(love.graphics.getWidth()/75)/ketcherv:getWidth()
    ketchervy=love.graphics.getHeight()/2-ketcherv:getHeight()/2
    ketcherhy=love.graphics.getHeight()/2-ketcherh:getHeight()/2
    ketcherhx=love.graphics.getWidth()-ketcherh:getWidth()*skalerketcherx
    pointv = 0
    pointh = 0
    ketcherspeed=12
    love.window.setMode(0,0,{resizable=true,highdpi=true,--[[minwidth=800,minheight=600--]]})
    --love.window.setFullscreen(true,"desktop")
    love.mouse.setVisible(false)
    font = love.graphics.newFont("LukasSvatbaBoldOblique.ttf", 30)
    pauset = false		--pause
end

function love.update()
	if pause then
		return
	end
--	ketcherhy=y-ketcher:getHeight()*skalerketchery/2
	skalerketchery=(love.graphics.getHeight()/5)/ketcherv:getHeight()
	skalerketcherx=(love.graphics.getWidth()/75)/ketcherv:getWidth()
	skalerbold=(love.graphics.getHeight()/40)/bold:getHeight()
	skalerspeed=skalerbold
	if not pauset then
    	x = speedx*skalerspeed+x
    	y = speedy*skalerspeed+y
    end
    if y >= love.graphics.getHeight()-bold:getHeight() or y <= 0 then
        speedy = -1*speedy
    end
    if x <= ketcherv:getWidth()*skalerketcherx and y>ketchervy and y<ketchervy+ketcherv:getHeight()*skalerketchery then
         speedx = -1.1*speedx
    end
    if x >= ketcherhx-ketcherh:getWidth()*skalerketcherx and y>ketcherhy and y<ketcherhy+ketcherh:getHeight()*skalerketchery then
         speedx = -1.1*speedx
    end
    if love.keyboard.isDown("up") and ketcherhy > 0 then
        ketcherhy = ketcherhy - ketcherspeed*skalerspeed
    end
    if love.keyboard.isDown("down") and ketcherhy < love.graphics.getHeight() - ketcherh:getHeight()*skalerketchery then
        ketcherhy = ketcherhy + ketcherspeed*skalerspeed
    end
    if love.keyboard.isDown("w") and ketchervy > 0 then
        ketchervy = ketchervy - ketcherspeed*skalerspeed
    end
    if love.keyboard.isDown("s") and ketchervy < love.graphics.getHeight() - ketcherv:getHeight()*skalerketchery then
        ketchervy = ketchervy + ketcherspeed*skalerspeed
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
	while speedx <= 5 and speedx >= -5 or speedy <= 5 and speedy >= -5 do
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

function love.keypressed(pause)
	if pause == "p" then pauset = true end
	if pause ~= "p" then pauset = false end
end

function love.focus(f)
	if not f then
		pauset = true
	end
end

function love.draw()
	love.graphics.setFont(font)
	love.graphics.line(love.graphics.getWidth()/2,0,love.graphics.getWidth()/2,love.graphics.getHeight())
	love.graphics.setColor(237,255,0)
	love.graphics.draw(bold, x, y,0,skalerbold,skalerbold)
	love.graphics.draw(ketcherv, 0, ketchervy,0,skalerketcherx,skalerketchery)
	love.graphics.draw(ketcherh, ketcherhx, ketcherhy,0,skalerketcherx,skalerketchery)
	love.graphics.print(pointv,love.graphics.getWidth()*0.25,0)
	love.graphics.print(pointh,love.graphics.getWidth()*0.75,0)
	ketcherhx=love.graphics.getWidth()-ketcherh:getWidth()*skalerketcherx
	love.graphics.setBackgroundColor(12, 50, 150)
	if pauset then
			love.graphics.print("Pauset", (love.graphics.getWidth()/2)-35)
	end
	--[[
	love.graphics.print(speedx,0,0)					--Hastighed på boldens X
	love.graphics.print(speedy,0,10)				--og Y koordinat
	love.graphics.print(love.graphics.getWidth(),0,20)		--Skærmens bredde
	love.graphics.print(love.graphics.getHeight(),0,30)		--og højde i pixels
	--]]
end

function love.load()
	paused = false
	bold = love.graphics.newImage("bold.png") -- sæt boldens billede
	resetbold() -- kør "resetbold" funktionen
	ketcherv = love.graphics.newImage("ketcher.png") -- sæt venstre ketchers billede
	ketcherh = love.graphics.newImage("ketcher.png") -- sæt højre ketchers billede
	skalerketchery = (love.graphics.getHeight()/5)/ketcherv:getHeight() -- skalerer ketcherens højde til en femtedel af skærmen
	skalerketcherx = (love.graphics.getWidth()/75)/ketcherv:getWidth() -- skalerer ketcherens bredde til 1/75 af skærmen
	ketchervy = love.graphics.getHeight()/2 - ketcherv:getHeight()/2
	ketcherhy = love.graphics.getHeight()/2 - ketcherh:getHeight()/2
	ketcherhx = love.graphics.getWidth() - ketcherh:getWidth()*skalerketcherx
	--pointv = 0 -- sætter venstres point til 0
	--pointh = 0 -- sætter højres point til 0
	ketcherspeed = 12 -- sætter ketcherens hastighed
	love.window.setMode(0,0,{resizable = true, highdpi = true,--[[minwidth=800,minheight=600--]]}) -- lader vinduets størrelse blive ændret
	-- love.window.setFullscreen(true, "desktop") -- start i fuldskærm
	love.mouse.setVisible(true)
	font = love.graphics.newFont("LukasSvatbaBoldOblique.ttf", 30) -- sætter skrifttypen
	--pauset = true --start pauset
	touches = love.touch.getTouches()
end

function love.update()
	if pause then
		return
	end
	ketchervy = y-ketcherv:getHeight()*skalerketchery/2 -- Få venstre ketcher til at følge boldens y-koordinat
	if ketchervy < 0 then
		ketchervy = 0
	end
	if ketchervy + ketcherv:getHeight() * skalerketchery > love.graphics.getHeight() then
		ketchervy = love.graphics.getHeight() - ketcherv:getHeight() * skalerketchery
	end
	skalerketchery = (love.graphics.getHeight()/5)/ketcherv:getHeight()
	skalerketcherx = (love.graphics.getWidth()/75)/ketcherv:getWidth()
	skalerbold = (love.graphics.getHeight()/40)/bold:getHeight()
	skalerspeed = skalerbold
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
	--[[for i, id in ipairs(touches) do
		touchX, touchY = love.touch.getPosition(id)
	end
	if touchY and touchY <= love.graphics.getHeight()/2 then
		ketcherhy = ketcherhy - ketcherspeed*skalerspeed
	end
	if touchY and touchY >= love.graphics.getHeight()/2 then
		ketcherhy = ketcherhy + ketcherspeed*skalerspeed
	end--]]
	--[[
	if love.keyboard.isDown("left") and ketcherhx > love.graphics.getWidth()/2 then
		ketcherhx = ketcherhx - ketcherspeed*skalerspeed
	end
	if love.keyboard.isDown("right") and ketcherhx < love.graphics.getWidth() then
		ketcherhx = ketcherhx + ketcherspeed*skalerspeed
	end
	--]] -- udkommentér for at kunne bevæge højre ketcher til siderne
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
		randomizecolors()
	end
end

function resetbold()
	speedx = love.math.random(-7,7)
		speedy = love.math.random(-7,7)
	while speedx <= 5 and speedx >= -5 or speedy <= 5 and speedy >= -5 do
		speedx = love.math.random(-7,7)
		speedy = love.math.random(-7,7)
	end
	x = love.graphics.getWidth()/2-bold:getWidth()/2
	y = love.graphics.getHeight()/2
end

function reset()
	pointv = 0
	pointh = 0
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

function randomizecolors()
	--love.graphics.setColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	--love.graphics.setBackgroundColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

function love.draw()
	love.graphics.setFont(font)
	love.graphics.line(love.graphics.getWidth()/2,0,love.graphics.getWidth()/2,love.graphics.getHeight())
	--love.graphics.setColor(237, 255, 0)
	love.graphics.setColor(245, 208, 200)
	love.graphics.draw(bold, x, y, 0, skalerbold, skalerbold)
	love.graphics.draw(ketcherv, 0, ketchervy, 0, skalerketcherx, skalerketchery)
	love.graphics.draw(ketcherh, ketcherhx, ketcherhy, 0, skalerketcherx, skalerketchery)
	love.graphics.print(pointv, love.graphics.getWidth()*0.25,0)
	love.graphics.print(pointh, love.graphics.getWidth()*0.75,0)
	ketcherhx = love.graphics.getWidth() - ketcherh:getWidth() * skalerketcherx -- udkommentér for at kunne bevæge højre ketcher til siderne
	--love.graphics.setBackgroundColor(12, 50, 150)
	love.graphics.setBackgroundColor(39, 71, 69)
	if pauset then
		love.graphics.print("Pauset", (love.graphics.getWidth()/2)-35)
	end
	--
	for i, id in ipairs(touches) do
		local x, y = love.touch.getPosition(id)
		love.graphics.circle("fill", x, y, 20)
	end
	--

	--[[
	love.graphics.print(speedx,0,0) --Hastighed på boldens X
	love.graphics.print(speedy,0,10) --og Y koordinat
	love.graphics.print(love.graphics.getWidth(),0,20) --Skærmens bredde
	love.graphics.print(love.graphics.getHeight(),0,30) --og højde i pixels
	--]]
end

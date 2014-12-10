---
--The Game module 
--The controller for managing the Game module. 
--@module Game 

--[[
Start functional_code.lua
]]

--[[*****************
global_variables.lua*
*********************]]


if timer then
   timer:stop()
   timer = nil
end


require "picture"
require "savegame"
require "slobs"
require "blob"
require "collision"
require "custom_onkey"
require "menu"
--require "log"
	


-- Global variables
path = "2-6062-C247"
profil = "Nima"
saveProfil(profil,0,0,0,0,0,0) --DO: if you want to create a new savegame, do this one time after you changed the variable "profil"
dance_img = "/images/dance1o.png"
tutorial_page = 1
-- Sizes
window_width = gfx.screen:get_width()
window_height = gfx.screen:get_height()

--Margins
side_margin = 10

--Movement blob
movement=30

-- Colors
white = {r = 255, g = 255, b = 255, a = 255}
green = {r = 0, g = 255, b = 0, a = 255}
magenta = {r = 255, g = 0, b = 255, a = 255}
light_grey = {r = 220, g = 220, b = 220, a = 210}

--Table of size depending of levels
tab_level = {[0]=90,100,110,120,130,140,150,160,170,180}

---
-- Initialize level 
-- Sets the global variables for the current level.
-- @param img_background The image path representing the background image.
-- @param lvl_limit The limit of the level.
-- @param sb_limit The limit of nthe amount of spawned Slobs.
-- @param nbtype The type of the spawned Slobs.
-- @param sb_speed The speed of the spawned Slobs.
-- @param spawn_rate The rate of which the Slobs spawns.
-- @param with_boss The parameter deciding if the level should contain a boss as well.
function initializeLevel(img_background,lvl_limit,sb_limit,nbtype,sb_speed,spawn_rate,with_boss)
  	level_limit=lvl_limit
	slob_limit=sb_limit
	nb_type_slob = nbtype
    slob_speed = sb_speed
	spawning_rate = spawn_rate
	lvl_with_boss = with_boss
	if (g_background~=nil) then
      g_background:destroy()
    end
    local img_b = img_background
	g_background = gfx.loadpng(img_b) 
end

---
--Game over
--The function controlling the game over event, stopping the timer and setting the background. 
function gameOver()
	game_state="game_over"
	timer:stop()
	timer = nil
	if (g_background ~= nil) then
		g_background:destroy()
	end
  	local name = "images/Game_over.png"
  	local level_img=gfx.loadpng(name)
	screen:copyfrom(level_img, nil, {x=0 , y=0, w=1280, h=720}, true)
	gfx.update()
  	level_img:destroy()
end

---
--Level complete
--The function controlling the level complete event, stopping the timer, saving the profile and displaying the stars. 
function levelCompleted()
	game_state="level_complete"
	timer:stop()
	timer = nil
	if (no_collision < 3) then
		if (no_collision == 0) then
			stars = 3
		elseif (no_collision == 1) then
			stars = 2
		elseif (no_collision == 2) then
			stars = 1
		end
	else
		stars = 0
	end
	local lvl1_s,lvl2_s,lvl3_s,lvl4_s,highs,level_reached = loadProfil(profil)
	if c_lv == 1 then
		if level_reached+0 < c_lv then
			level_reached = 1
		end
		if lvl1_s+0 < stars then	-- +0 is used to convert lvl1_s
			lvl1_s = stars
		end
	elseif c_lv == 2 then
		if level_reached+0 < c_lv then
			level_reached = 2
		end
		if lvl2_s+0< stars then
			lvl2_s = stars
		end		
	elseif c_lv == 3 then
		if level_reached+0 < c_lv then
			level_reached = 3
		end
		if lvl3_s+0 < stars then
			lvl3_s = stars
		end
	elseif c_lv == 4 then
		if level_reached+0 < c_lv then
			level_reached = 4
		end
		if lvl4_s+0 < stars then
			lvl4_s = stars
		end
	end
	local new_highscore = lvl1_s + lvl2_s + lvl3_s + lvl4_s
	saveProfil(profil,lvl1_s,lvl2_s,lvl3_s,lvl4_s,new_highscore,level_reached)
	if c_lv <= 4 then
		c_lv = c_lv + 1
	end
	if (g_background ~= nil) then
		g_background:destroy()
	end	
	local name = "images/lvl_complete"..stars..".png"
  level_img=gfx.loadpng(name)
	screen:copyfrom(level_img, nil, {x=0 , y=0, w=1280, h=720}, true)
	gfx.update()
  level_img:destroy()
end

---
--Update Cb
--The function updating the timer. 
--@param timer The timer input parameter.
function updateCb(timer)
   now = sys.time()
   last_time = last_time or 0
   updateState(now - last_time)
   delta1 = now - last_time
   last_time = now
end

---
--Update state
--The function updating the state. 
--@param delta The input parameter to be used for controling the start.
function updateState(delta)
	moveBlob()
	if nbslob ~= 0 then
		moveSlobs()
		drawScreen()
		detectCollision()
	end
	if flag_spawn == spawning_rate and nb_sad_slobs <= slob_limit then
		spawnSlob(nb_type_slob)
		flag_spawn = 0
	else
		if nb_sad_slobs ~= slob_limit then
			flag_spawn = flag_spawn + 1
		end
	end
	
	if lvl_with_boss == 1 and nbslob > 1 and blob.level >= level_of_boss  then
		if flag_vulnerable < 20 then
			flag_vulnerable = flag_vulnerable + 1
		else
			if slob_list[1].vulnerable == true then
				slob_list[1].vulnerable = false	
			else
				slob_list[1].vulnerable = true
			end
			flag_vulnerable = 0
		end
	end	
	drawScreen()
end

---
--Draw Screen
--The function controlling what's to be displayed on the screen after each update.
function drawScreen()
	screen:clear({b=150,r=100,g=200})
	screen:copyfrom(g_background, nil, {x = 0, y = 0, w=1280, h=720}, true)
	drawSlobs()
	if blink ~= true then
		drawBlob()
	end
	gfx.update()

  screen:clear({b=150,r=100,g=200}) 
end

function drawPause()
	screen:clear()
	screen:copyfrom(g_background, nil, {x = 0, y = 0, w=1280, h=720}, true)
	drawSlobs()
	drawBlob()
    screen:copyfrom(pause_img, nil, {x = 450, y = 250}, true)
	gfx.update()
  	--screen:clear({b=150,r=100,g=200}) 
end

function pausing()
    game_state = "pause"
	local pause = "images/pause.png"
	timer:stop()
	timer = nil
   	pause_img = gfx.loadpng(pause)
   	pause_img:premultiply()
   	drawPause()
   	pause_img:destroy()
 end

 function restart()
 	  game_state = "run"
      --pause_img:destroy()
      timer = sys.new_timer(100, "updateCb")
 end
---
--Start
--The function controlling the start event, managing the current level and the avatar for the users Blob.
--@param current_lvl The input parameter for the level to be started.
--@param bloba_design The input paramter for the users avatar.
function start(current_lvl, bloba_design)
--initializeLevel(background image, level to reach, nb max of slobs on screen, nb of different type of slobs, speed of slobs, spawning rate, level with boss)
	blobaD = bloba_design
	c_lv = current_lvl
	if current_lvl == 1 then
		initializeLevel("images/background1.png",9,5,1,13,20,0)
	  elseif current_lvl == 2 then
		initializeLevel("images/background2.png",9,5,2,15,10,0)
	  elseif current_lvl == 3 then
		initializeLevel("images/background3.png",9,7,4,17,10,0)
	  elseif current_lvl == 4 then
		initializeLevel("images/level4_background.png",9,7,3,20,10,1)
	end
	no_collision = 0
	nbslob=0
	nb_sad_slobs=0
	blink = false
	blink_zlobby = false
	delta1=0
	flag_spawn = 0
	flag_vulnerable = 0
	blob_movement_state = "still"
	game_state = "run"
	--List of current Slobs
	slob_list = {}
	blob = {x,y,width,height,level,speed,img}
	overlaping_object = {}
	createBlob(100,window_height/2,bloba_design,movement,1) 
	if lvl_with_boss == 1 then
		spawnSlob(1)
	end
	drawScreen()
	timer = sys.new_timer(100, "updateCb")
end

Story()




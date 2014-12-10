---
--The Slobs class 
--The controller for managing the Slobs class. 
--@classmod Slobs 

---
--Random spawning place
--The spawning handler for the slobs making them spawn at the edges of the screen and at random places each time.  
--@param sb_type The input parameter that represents the type of Slob to be spawned.
--@param lvl_slob The input parameter that represents the level of the Slob to be spawned.
--@return window_width - tab_level[lvl_slob] The output representing the spawn width.
--@return math.random(side_margin,window_height - tab_level[lvl_slob]) The output representing the spawn height.
function randomPlace(sb_type,lvl_slob)
	if sb_type == 1  then
		return window_width - tab_level[lvl_slob], math.random(side_margin,window_height - tab_level[lvl_slob])
	elseif sb_type == 2 then
		return math.random(side_margin,window_width - tab_level[lvl_slob]), side_margin
	elseif sb_type == 3 then
		return window_width - tab_level[lvl_slob], math.random(side_margin,window_height - tab_level[lvl_slob])
	elseif sb_type == 4 then
		return math.random(300,window_width - tab_level[lvl_slob]), math.random(0,window_height - tab_level[lvl_slob])
	end
end

---
-- Create Slob
-- The function setting the Slob parameters.
-- @param slob_type The parameter representing the type of Slob to be created.
function createSlob(slob_type)
	  if lvl_with_boss == 1 and nbslob == 0 then
		  level_of_boss = math.floor(level_limit/2)
		  local size_slob = createSizeSlob(level_of_boss)
		  local x_slob, y_slob = randomPlace(4,level_of_boss)
		  slobi = {x = x_slob, y = y_slob, speed = slob_speed, im=Slobs_img[9], width = size_slob, height = size_slob, level = level_of_boss, type_slob=4, happy=0, type_boss=1,vulnerable=false}
		  position_boss = "middle"
	  else
		  local level_slob = getRandomLevelSlob(3)
		  local size_slob = createSizeSlob(level_slob)
		  local x_slob, y_slob = randomPlace(slob_type,level_slob)
		  slobi = {x = x_slob, y = y_slob, speed = slob_speed, im=Slobs_img[slob_type], width = size_slob, height = size_slob, level = level_slob, type_slob=slob_type, happy=0, type_boss=0, vulnerable=true, sin_of_set_counter = 0}
	  end
	  nb_sad_slobs = nb_sad_slobs + 1
	  nbslob = nbslob + 1
	  if nbslob > 1 then
		  for i=1,nbslob do
			if slob_list[i]==nil then
				slob_list[i] = slobi
				overlaping_object[i]=false
				goto continue
			end
		  end
	  end
	  slob_list[nbslob] = slobi
	  overlaping_object[nbslob]=false
	  ::continue::
end

---
--Spawn Slob
--The handler of the spawning of the Slobs.
--@param nb_type 
function spawnSlob(nb_type)
	local type_slob = math.random(1,nb_type)
	createSlob(type_slob)
end

---
--Slob size creation
--The function that controls the size of the Slobs and returns a table.
--@param level The level of the Slob to be created.
--@return tab_level[level] The output representing the table of
function createSizeSlob(level)
	 return tab_level[level]
end

---
--Display Slob numbers
--The function that controls the displaying of the Slobs number representing the appropriate level.
--@param i The ID of the Slob number to be created.
function displayNumberSlobs(i)
	x_nb,y_nb,w_nb,h_nb = getCharacteristicNumberSlobs(i)
	screen:copyfrom(all_numbers[slob_list[i].level], nil, {x=x_nb, y=y_nb, w=w_nb, h=h_nb}, true)
end

---
--Slob characteristics
--The function handling the parameters assigned to in a correct way display a Slob of different levels.
--@param num The input parameter representing the ID of the Slob to get the characteristics from.
--@return (slob_list[num].x + slob_list[num].width/4) The output parameter representing the x-coordinate for the Slob.
--@return (slob_list[num].y + slob_list[num].height/2) The output parameter representing the y-coordinate for the Slob.
--@return slob_list[num].width/2  The output parameter representing the width to be displayed.
--@return slob_list[num].height/3 The output parameter representing the height to be displayed.
function getCharacteristicNumberSlobs(num)
	return (slob_list[num].x + slob_list[num].width/4), (slob_list[num].y + slob_list[num].height/1.5), slob_list[num].width/3, slob_list[num].height/4
end

---
--Draw Slobs
--The function handling the drawing of the Slobs.
function drawSlobs()
	for i,slob in pairs(slob_list) do
		if slob.type_boss == 1 then
			if slob.vulnerable == false then
				slob.im = Slobs_img[8]
				screen:copyfrom(slob.im, nil, {x=slob.x, y=slob.y, w=slob.width+10, h=slob.height+30}, true)
				goto jump
			else
				if blink_zlobby ~= false then
					goto jump
				end
				slob.im = Slobs_img[9]
			end
		end
		screen:copyfrom(slob.im, nil, {x=slob.x, y=slob.y, w=slob.width, h=slob.height}, true)
		::jump::
		if slob.happy == 0 then
			displayNumberSlobs(i)
		end
	end
end

---
--Horizontal movement
--The function controlling the horizontal movement of the Slob.
--@param i The ID representing the Slob to move.
function movementSlobHorizontal(i)
	if slob_list[i].x - slob_list[i].speed > side_margin then
	   slob_list[i].x = slob_list[i].x - slob_list[i].speed
	else
		removeSlob(i)
	end
end

---
--Vertical movement
--The function controlling the vertical movement of the Slob.
--@param i The ID representing the Slob to move.
function movementSlobVertical(i)
	if slob_list[i].y + slob_list[i].height + 20 < window_height then
	   slob_list[i].y = slob_list[i].y + slob_list[i].speed
	else
	   removeSlob(i)
	end
end

---
-- Slob sinusoidal movement
-- Change local variables period and amplitude to change the sine curve
--@param i The input parameter representing the ID of the Slob.
function movementSlobSinus(i)
	local x = slob_list[i].x
	local y = slob_list[i].y
	local speed = slob_list[i].speed

	-- period: increase to have a longer period of the sine curve
	local period = 8
	-- amplitude: increase for a larger amplitude of the sine curve
	local amplitude = 80
	if x - 20 > 20 and y - 20 > 20 then

	local previus_sin_of_set = 
	  math.floor( (amplitude * math.sin( (slob_list[i].sin_of_set_counter * 0.5 * math.pi)/period )) )

	slob_list[i].sin_of_set_counter = slob_list[i].sin_of_set_counter + 1

	local sin_of_set = 
	  math.floor( (amplitude * math.sin( (slob_list[i].sin_of_set_counter * 0.5 * math.pi)/period )) )

	slob_list[i].x = x - speed
	slob_list[i].y = y + sin_of_set - previus_sin_of_set
	print(x .. " : " .. y .. " : " .. sin_of_set .. " : " .. slob_list[i].sin_of_set_counter)
	else
	 	removeSlob(i)
	end
end

---
--Slob diagonal movement
--The function controlling the digonal movement of the Slob.
--@param i The input parameter representing the ID of the Slob.
function movementSlobDiagonalUp(i)
	if slob_list[i].x - 20 > 0 and slob_list[i].y > 0 then
	   slob_list[i].x = slob_list[i].x - slob_list[i].speed
	   slob_list[i].y = slob_list[i].y - slob_list[i].speed/4
	else
	   removeSlob(i)
	end
end

---
--Slob random movement
--The function controlling the random movement of the Slob.
--@param i The input parameter representing the ID of the Slob.
function movementSlobRandom(i)
	n = math.random(1,3)
	if n==1  then 
    movementSlobHorizontal(i)
	elseif n==2  then 
    movementSlobVertical(i)
	elseif n==3  then 
    movementSlobDiagonalUp(i)
	end
end

--Global variables used only in function movementBoss
signx = 1
signy = 1

---
--Boss movement
--The function controlling the movement of the boss: Mad Zlobby.
--@param i The input parameter representing the ID of the boss.
function movementBoss(i)
	if (slob_list[i].x - slob_list[i].speed-1 < 0) and position_boss ~= "left" then
		signx = -1
		position_boss = "left"
	end
	if ((slob_list[i].x + slob_list[i].width + slob_list[i].speed-1) > window_width) and position_boss ~= "right" then
		signx = 1
		position_boss = "right"
	end	
	if slob_list[i].y - slob_list[i].speed-1 < 0 and position_boss ~= "top" then
		signy = -1
		position_boss = "top"
	end	
	if slob_list[i].y + slob_list[i].height + slob_list[i].speed-1 > window_height and position_boss ~= "bottom" then
		signy = 1
		position_boss = "bottom"
	end	
	slob_list[i].x = slob_list[i].x - (signx * slob_list[i].speed)
	slob_list[i].y = slob_list[i].y - (signy * slob_list[i].speed)
end

---
-- Move Slob
-- The function controlling the movement of a Slob depending on its type.
function moveSlobs()
	for i,sloba in pairs(slob_list) do
		if sloba.type_boss == 0 then
			if sloba.type_slob ==1 then
				movementSlobHorizontal(i)
			elseif sloba.type_slob ==2 then
				movementSlobVertical(i)
			elseif sloba.type_slob ==3 then
				movementSlobSinus(i)
			elseif sloba.type_slob ==4 then
				movementSlobRandom(i)
			end
		else
			movementBoss(i)	
		end	
	end
end

---
-- Remove Slob
-- Remove a specific slob using the input ID.
-- @param object_nb The input parameter representing the Slob to be removed.
function removeSlob(object_nb)
	blink = false
	if slob_list[object_nb].happy == 1 then
		nbslob = nbslob-1 
	else
		nb_sad_slobs = 	nb_sad_slobs - 1
	end
	overlaping_object[object_nb] = nil
	slob_list[object_nb] = nil
end

---
--Random spawning
--Generate a random level Slob based on the Blobs level(input)
--@param max_deviation Defines the largest deviation the output can have from the input
--@return slob_level Random integer based on input
function getRandomLevelSlob(max_deviation)
	lower_limit = (blob.level - max_deviation)
	random_int = math.random(0,max_deviation*2)
	slob_level = (lower_limit + random_int)

	if slob_level < 1 then
		return 1
	end
	if slob_level >9 then
		return 9
	end
	return slob_level
end

---
--Make happpy
--The function turning the sad Slobs in to happy blobs and moving them out of the screen.
--@param slob The input parameter representing the ID of the Slob.
function makeHappy(slob)
	slob_list[slob].happy = 1
	slob_list[slob].level = 1
	slob_list[slob].speed = 40
	local size_slob = createSizeSlob(slob_list[slob].level)
	slob_list[slob].width = size_slob
	slob_list[slob].height = size_slob
	if slob_list[slob].type_slob == 1 then
		slob_list[slob].im = Slobs_img[5]
	elseif slob_list[slob].type_slob == 2 then
		slob_list[slob].im = Slobs_img[6]
	elseif slob_list[slob].type_slob == 3 then
		slob_list[slob].im = Slobs_img[7]
	elseif slob_list[slob].type_slob == 4 then
		slob_list[slob].im = Slobs_img[5]	
	end
	nb_sad_slobs = nb_sad_slobs - 1
end

---
--Boss decrease
--The function controlling the decreasing of the boss.
function decreaseBoss()
	local boss_slob = slob_list[1]
	boss_slob.level = boss_slob.level - 1
	level_of_boss = boss_slob.level
	if boss_slob.level <= 0 then
		boss_slob.level = 0
		drawScreen()
		levelCompleted()
	end
	boss_slob.width = tab_level[boss_slob.level]
	boss_slob.height = tab_level[boss_slob.level]
	--slob_list[1].vulnerable = false
	--flag_vulnerable = 0
end


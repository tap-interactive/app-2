--- 
--The Blob class 
--The controller for managing the Blob class. 
--@classmod Blob 

---
--Blob creation
--The function that creates the playable character. 
--@param pos_x The input parameter representing the x-coordinate to the Blob that's to be created.
--@param pos_y The input parameter representing the y-coordinate to the Blob that's to be created. 
--@param img_url The input parameter representing the url for the Blob that's to be created. 
--@param speed_blob The input parameter representing the speed of the Blob that's to be created. 
--@param lev The input parameter representing the appropriate level to the Blob that's to be created. 
function createBlob(pos_x,pos_y,img_url,speed_blob,lev)
  blob.x=pos_x
  blob.y=pos_y
  blob.width=tab_level[lev]
  blob.height=tab_level[lev]
  blob.speed = speed_blob
  blob.level = lev
  blob.img = gfx.loadpng(img_url)
  blob.img:premultiply()
end

--- 
--Blob movement:Right 
--The function that controls the movement to the right for the Blob. 
function moveBlobRight()
	if(blob.x+blob.width<window_width-side_margin) then
        if (blob.x+blob.width+blob.speed<window_width-side_margin) then
			blob.x = blob.x+blob.speed
        else
			blob.x=window_width-side_margin-blob.width
		end
	end
end

--- 
--Blob movement:Left 
--The function that controls the movement to the left for the Blob. 
function moveBlobLeft()
    if(blob.x>side_margin) then
		if (blob.x-blob.speed>side_margin) then
			   blob.x = blob.x-blob.speed
			else
		   blob.x = side_margin
		end
	end
end

--- 
--Blob movement:Up 
--The function that controls the movement up the screen for the Blob. 
function moveBlobUp()
    if(blob.y>side_margin) then
		if (blob.y-blob.speed>side_margin) then
			   blob.y = blob.y-blob.speed
		else
		   blob.y= side_margin
		end
    end
end

--- 
--Blob movement:Down 
--The function that controls the movement down the screen for the Blob. 
function moveBlobDown()
	if(blob.y+blob.height<window_height-side_margin) then
        if (blob.y+blob.height+blob.speed<window_height-side_margin) then
			blob.y = blob.y+blob.speed
        else
			blob.y=window_height-side_margin-blob.height
		end
    end
end

--- 
--Blob movement state 
--The function that controls the movement state for the Blob. 
function moveBlob()
	if blob_movement_state == "right" then
		moveBlobRight()
	elseif blob_movement_state == "left" then
		moveBlobLeft()
	elseif blob_movement_state == "down" then
		moveBlobDown()
	elseif blob_movement_state == "up" then
		moveBlobUp()
	end
end

---
--Blob number display 
--The function that handles the numbers, corresponding to the level, to be displayed on the Blob. 
function displayNumberBlob()
	x_nb,y_nb,w_nb,h_nb = getCharacteristicNumberBlob()
	screen:copyfrom(all_numbers[blob.level], nil, {x=x_nb, y=y_nb, w=w_nb, h=h_nb}, true)
end

--- 
--Blob number characteristics 
--The function that handles the characteristics of the Blob, corresponding to the level. 
function getCharacteristicNumberBlob()
	return (blob.x + blob.width/2.5), (blob.y + blob.height/1.5), blob.width/3, blob.height/4
end

--- 
--Draw Blob  
--The function that handles the drawing of the Blob. 
function drawBlob()
	screen:copyfrom(blob.img, nil, {x=blob.x, y=blob.y, w=blob.width, h=blob.height}, true)
	displayNumberBlob()
end

---
-- Is higher level  
-- Check if the Slob has a higher or equal level than the Blob  
-- @param object The Slob to compare to the Blob 
function isHigherLevel(object)
	if(slob_list[object].level <= blob.level) then
		return true
	else
		return false
	end
end

---
--Grow Blob 
--Make the Blob grow, meaning growing in both height and width, as well as the level gets incremented by 1. 
function growBlob()
	blob.level = blob.level + 1
	if blob.level > 9 then
		blob.level = 9
	end
	blob.width = tab_level[blob.level]
	blob.height = tab_level[blob.level]
end

--- 
--Decrease Blob 
--Make the Blob decrease, meaning decreasing in both size and width, as well as the level gets decremented by the difference between the Blobs level and the level of the Slob. If the Blob level gets lower than one, the Blob will be given a zero as its level and gameOver is called. 
--@param nb The input parameter that represents the ID of the Slob. 
function decreaseBlob(nb)
	no_collision = no_collision + 1
	if slob_list[nb].type_boss == 1 then
		if  math.abs(slob_list[nb].level - blob.level) == 0 then
			blob.level = blob.level - 1
		else
			blob.level = blob.level - math.abs(slob_list[nb].level - blob.level)
		end
	else
		blob.level = blob.level - (slob_list[nb].level - blob.level)
	end
	
	if blob.level <= 0 then
		blob.level = 0
		drawScreen()
		gameOver()
	elseif blob.level < slob_list[1].level then
		slob_list[1].vulnerable = false
		flag_vulnerable = 0
	end
	blob.width = tab_level[blob.level]
	blob.height = tab_level[blob.level]
end


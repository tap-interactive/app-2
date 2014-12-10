---
--The Collision module 
--The controller for managing the Collison module. 
--@module Collison 

--- 
--Detect collision 
--The function detects if there is a collision between the Blob and on or more of the Slobs. For the detection it uses the different function to determine in what stage of the collison process the Blob and the Slob is in.
 function detectCollision()
 	for i,slob in pairs(slob_list) do
		if slob.happy == 0 then
			if checkIfOverLaping(i) then
				if overlaping_object[i] == true then
					isColliding(i)
					break
				elseif overlaping_object[i] == false then
					beginColliding(i)
					break
				end              
			else
				if(overlaping_object[i] == true) then
					endColliding(i)
				end
			end
		end
	end
end     

--- 
--Check overlaping  
--The function detects if a the Blob overlapse the Slob entity, using the logic describe in the pictures below. Briefly the top left corner and the bottom right corners of both the Slob and the blob is used to determined collision. The ID of the Slob is inputted to the function and is used to detect overlaping. If overlaping is detected a boolean parameter will be returned. 
--@param slob_num The input parameter representing the ID of the Slob. 
--@return bool 
function checkIfOverLaping(slob_num)

--			X
--		----->
--		|
--	  Y |	L1----------
--		v	|			|
--			|	blob	|
--			|			|
--			-----------R1
--
--					L2-----------
--					|			|
--					|	slob	|
--					|			|
--					------------R2

	local offset = 10
	-- L1
	local blobTopLeftCorner = {
		x = blob.x + offset,
		y = blob.y 
	}
	-- R1
	local blobBottomRightCorner = {
		x = blob.x + blob.width - offset,
		y = blob.y + blob.height 
	}
	-- L2
	local slobTopLeftCorner = {
		x = slob_list[slob_num].x + offset,
		y = slob_list[slob_num].y 
	}
	-- R2
	local slobBottomRightCorner = {
		x = slob_list[slob_num].x + slob_list[slob_num].width - offset,
		y = slob_list[slob_num].y + slob_list[slob_num].height - offset
	}
	
	-- If one rectangle is on the left side of other
  if (blobTopLeftCorner.x > slobBottomRightCorner.x) or (slobTopLeftCorner.x > blobBottomRightCorner.x) then
    return false
 	end
 	-- If one rectangle is above other
 	if (blobTopLeftCorner.y > slobBottomRightCorner.y) or (slobTopLeftCorner.y > blobBottomRightCorner.y) then    return false
 	end 
  return true;
end

---
-- Begin colliding 
-- Event handler for when a Slob is begining to collide with a Blob. The colliding objects are compared to determine how to handle the subsequent events. 
-- @param object_nb The ID of the object  
function beginColliding(object_nb)
	overlaping_object[object_nb] = true
	if isHigherLevel(object_nb) and slob_list[object_nb].vulnerable == true then
		if slob_list[object_nb].type_boss == 1 then
			growBlob()
			decreaseBoss()
		else
			growBlob()
			makeHappy(object_nb)
			if lvl_with_boss == 0 then
				if (blob.level==level_limit) then
					drawScreen()
					levelCompleted()
				end
			end
		end
	else
		decreaseBlob(object_nb)
	end
end

---
--End colliding 
--Event handler when ending colliding, also controlling the ending of the blinking and the restoring of the force shield for the boss.
--@param object The input parameter representing the object ID. 
function endColliding(object)
	overlaping_object[object] = false
	blink = false
	blink_zlobby = false
	if slob_list[object].type_boss == 8 then
		slob_list[8].vulnerable = false
		flag_vulnerable = 0
	end
end

---
--Is colliding 
--Event handler when the Blob is colliding and should be blinking. 
--@param object The input parameter representing the object ID.
function isColliding(object)
	if (isHigherLevel(object) == false or (slob_list[object].type_boss == 1 and slob_list[object].vulnerable == false)) then
		if blink == false then
			blink = true
		else
			blink = false
		end
		blink_zlobby = false
	elseif (isHigherLevel(object) == true and slob_list[object].type_boss == 1 and slob_list[object].vulnerable == true) then
		blink = false
		if blink_zlobby == false then
			blink_zlobby = true
		else
			blink_zlobby = false
		end
	end	
end

--- 
--The Custom on key module 
--The controller for managing the input from the player through the remote. 
--@module CustomOnKey  

--- 
-- Custom on key 
-- Handles all input by the user taking care of the different keys inputed depending on the current state of the game. 
-- @param key The input representing the current state of the game. 
-- @param state The input representing the key that has been given as input from the user.
function onKey(key, state)
-- MAIN MENU
  if (game_state == "startpage") then
      if ((key == "down" or key == "up" or key == "right" or key == "left") and state == "down") then
          choice = optionStartpage(key)
      end
      if (key == "ok" and state == "down") then
        if choice == 1 then --enter level choosing option
            release_memory()
            Level()
          elseif choice == 2 then --avatar option
            release_memory()
            Avatar()
          elseif choice == 3 then --option option
            release_memory()
            tutorial(tutorial_page)
          elseif choice == 4 then --score option
            release_memory()
            highscore()
        end
      end
-- LEVEL      
  elseif (game_state  == "level") then
    if (key == "ok" and state == "down" and game_lv == nil) then -- first case when game_lv has no value
        release_memory()
        bloba_path = get_design()
        start(1, bloba_path)
    elseif ((key == "down" or key == "up" or key== "right" or key == "left") and state == "down") then
        game_lv = chooseLv(key)
    elseif (key == "ok" and state == "down") then
        release_memory()
        bloba_path = get_design()
		  if(game_lv <= level_reached+1) then
			 start(game_lv, bloba_path)
		  end
    elseif (key == "menu" and state == "down") then
        release_memory()
        startPage()
    end  
    
-- GAME
    elseif (game_state == "run") then
		if(key=="right" and (state=="repeat" or state=="down")) then
		blob_movement_state = "right"
		end
		if(key=="left" and (state=="repeat" or state=="down")) then
		blob_movement_state = "left"
		end
		if(key=="up" and (state=="repeat" or state=="down")) then
		blob_movement_state = "up"
		end
		if(key=="down" and (state=="repeat" or state=="down")) then
		blob_movement_state = "down"
		end
		if(key=="ok" and state=="down") then
		blob_movement_state = "still"
		end
		if(key=="menu" and state=="down") then
		  pausing()
		end
--PAUSE in the game
	elseif (game_state == "pause") then
		if(key=="menu" and state=="down") then
      release_memory() 
			startPage()
		end
		if(key=="ok" and state=="down") then
      restart()
		end
--LEVEL COMPLETED
  elseif (game_state == "level_complete")then
    if(key=="ok" and state=="down") then
		if c_lv <= 4 then
			start(c_lv, blobaD)
    else 
      dance()
		end
    elseif (key=="menu" and state=="down") then
      release_memory()
			startPage()
    end
--Game OVER
  elseif (game_state == "game_over")then
    if(key=="ok" and state=="down") then
      start(c_lv, blobaD)
    elseif (key == "menu" and state == "down") then
      release_memory()
      startPage()
    end
--STORYLINE  
  elseif (game_state == "story") then
    if (key == "menu" and state == "down") then
        release_memory()
        startPage()
    elseif (key == "right" and state == "down") then
        Story()
    end
--TUTORIAL
  elseif (game_state == "tutorial") then
    if (key == "menu" and state == "down") then
      tutorial_page = 1
      release_memory()
      startPage()
    elseif (key == "right" and state == "down") then
      if (tutorial_page < 4) then
        tutorial_page = tutorial_page + 1
        tutorial(tutorial_page)
      end
    elseif (key == "ok" and state == "down") then
      if (tutorial_page < 4) then
        tutorial_page = tutorial_page + 1
        tutorial(tutorial_page)
      end
    elseif (key == "left" and state == "down") then
      if (tutorial_page > 1) then
        tutorial_page = tutorial_page - 1
        tutorial(tutorial_page)
      end
    end 
--ENDING with DANCE  
  elseif (game_state == "dance") then
    if (key=="ok" and state=="down") then
      dance()
    elseif (key=="menu" and state=="down") then
      release_memory()
      
      startPage()
    end
--AVATARS  
  elseif (game_state == "avatars") then
    if ((key == "left" or key == "right") and state =="down") then
      chooseItem(key)
      elseif ((key =="up" or key == "down") and state == "down") then
      parameter = chooseParam(key)
      elseif (key == "menu" and state == "down") then
      release_memory()
      startPage()
    end
--HIGHSCORES  
  elseif (game_state == "scores") then
    if (key == "menu" and state == "down") then
      release_memory()
      startPage()
    end
  end 
end


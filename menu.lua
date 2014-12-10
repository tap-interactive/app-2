---
--The Menu module 
--The controller for managing the Menu module. 
--@module Menu 

---
--the empty images for the default choice in Avatar customization
local top_items = {}
    top_items[1] = "images/menu/avatar_img/items/empty.png"
local middle_items = {}
    middle_items[1] = "images/menu/avatar_img/items/empty.png"
local bottom_items = {}
    bottom_items[1] = "images/menu/avatar_img/items/empty.png"
    
---
--item unlocking 
--unlocks the top, middle and bottom items name path based on level reached
function unlock()
  if (level_reached+0 > 1) then
    top_items[2] = "images/menu/avatar_img/items/hat.png"
    top_items[3] = "images/menu/avatar_img/items/eyepatch_l.png"
    top_items[4] = "images/menu/avatar_img/items/flower.png"
  end
  if (level_reached+0 > 2) then
    middle_items[2] = "images/menu/avatar_img/items/green_gloves.png"
    middle_items[3] = "images/menu/avatar_img/items/pink_gloves.png"
  end
  if (level_reached+0 > 3) then
    bottom_items[2] = "images/menu/avatar_img/items/jeans.png"
    bottom_items[3] = "images/menu/avatar_img/items/skirt.png"
    bottom_items[4] = "images/menu/avatar_img/items/black.png"
  end
end

---
--Avatar arrows
-- the array for right and left arrows for the top, middle and bottom items in the avatar page
local arrow = {}
arrow[1] = nil
arrow[2] = nil
arrow[3] = nil
arrow[4] = nil
arrow[5] = nil
arrow[6] = nil

---
--printing one image to screen
--The function controlling the loading of the background png-image.
--@param background The input parameter of the path to the background image.
function load_png(background)
    screen:clear()
    screen:copyfrom(background, nil, {x = 0, y = 0, w=1280, h=720}, true)
    gfx.update()  
end

---
--all possible combination of avatars
--the Bloba design image name paths
local bloba = {}
for t=1,4 do --4 top items
  for m=1,3 do -- 3 middle items
     for b=1,4 do -- 4 bottom items
      bloba[t..m..b] = "images/menu/avatar_img/Bloba/B"..t..m..b..".png"
     end
  end
end
  
    
---
--Start page options
--The event handler of the startpage, controlling the events to be carried out after input by the user. 
--@param key The input parameter representing the key that is pressed by the user.
--@return img_nr The output parameter representing the image to be displayed next.
 function optionStartpage(key)
    if (img_choice=="images/menu/StartpageStart.png" and key=="right") then
        img_choice = "images/menu/StartpageAvatar.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 2
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageStart.png" and key=="down")  then
        img_choice = "images/menu/StartpageTutorial.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 3
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageAvatar.png" and key=="left")  then
        img_choice = "images/menu/StartpageStart.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 1
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageAvatar.png" and key=="down") then
        img_choice = "images/menu/StartpageScore.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 4
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageTutorial.png" and key=="up") then
        img_choice = "images/menu/StartpageStart.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 1
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageTutorial.png" and key=="right") then
        img_choice = "images/menu/StartpageScore.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 4
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageScore.png" and key=="up") then
        img_choice = "images/menu/StartpageAvatar.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 2
        return(img_nr)
      elseif(img_choice=="images/menu/StartpageScore.png" and key=="left") then
        img_choice = "images/menu/StartpageTutorial.png"
        background:destroy()
        background=gfx.loadpng(img_choice)
        load_png(background)
        img_nr = 3
      return(img_nr)
    end
   end

---
--initialization of main menu 
function startPage()
  game_state = "startpage"
  lvl1_s,lvl2_s,lvl3_s,lvl4_s,highs,level_reached = loadProfil(profil)
  --level = 0
  choice = 1
  img_choice = "images/menu/StartpageStart.png" -- default choice 
  if (background ~= nil) then
    background:destroy()
  end
  background=gfx.loadpng(img_choice)
  load_png(background)
end

--LEVEL
---
--drawing the Level page
--draws the background, and which planet/level the player is standing on with a rocket image. Based on the saved values it also draws the amount of star earned for each level
function drawLevelScreen()
  screen:clear()
  screen:copyfrom(level_background, nil, {x = 0, y = 0, w=1280, h=720}, true)
  if (lvl1_s+0 ~= 0) then
     screen:copyfrom(stars1, nil, {x=330, y=230}, true)
  end
  if (lvl2_s+0 ~= 0) then
    screen:copyfrom(stars2, nil, {x=175, y=510}, true)
  end
  if (lvl3_s+0 ~= 0) then
    screen:copyfrom(stars3, nil, {x=800, y=230}, true)
  end
  if (lvl4_s+0 ~= 0) then
    screen:copyfrom(stars4, nil, {x=1050, y=500}, true)
  end
  if (level_choice == 1) then
    screen:copyfrom(rocket, nil, {x=250, y=220, w=80, h=60}, true)
  elseif (level_choice == 2) then
    screen:copyfrom(rocket, nil, {x=360, y=500, w=100, h=90}, true)
  elseif (level_choice == 3) then
    screen:copyfrom(rocket, nil, {x=950, y=250, w=55, h=50}, true)
  elseif (level_choice == 4) then
    screen:copyfrom(rocket, nil, {x=900, y=500, w=140, h=120}, true)
  elseif (level_choice == 0) then
    screen:copyfrom(rocket, nil, {x=190, y=670, w=60, h=50}, true)
  end
  gfx.update()
end
---
--Choosing the level from the level page using the input from the user and then outputs a parameter for the appropriate level.
--@param key The appropriate key to choose level.
--@return lv The output parameter representing the level.
function chooseLv(key)

  if (level_reached+0 == 1) then
    if (level_choice == 1 and key == "down") then
      level_choice = 2
    elseif (level_choice == 2 and key == "up") then
      level_choice = 1 
    end
  elseif (level_reached+0 == 2) then
    if (level_choice == 1 and key == "down") then
      level_choice = 2
    elseif (level_choice == 1 and key == "right") then
      level_choice = 3
    elseif (level_choice == 3 and key == "left") then
      level_choice = 1
    elseif (level_choice == 2 and key == "up") then
      level_choice = 1
    end
  elseif (level_reached+0 == 4 or level_reached+0 == 3) then
    if (level_choice == 1 and key == "down") then
      level_choice = 2
    elseif (level_choice == 1 and key == "right") then
      level_choice = 3
    elseif (level_choice == 3 and key == "down") then
      level_choice = 4 
    elseif (level_choice == 4 and key == "left") then
      level_choice = 2
    elseif (level_choice == 4 and key == "up") then
      level_choice = 3
    elseif (level_choice == 3 and key == "left") then
      level_choice = 1
    elseif (level_choice == 2 and key == "right") then
      level_choice = 4
    elseif (level_choice == 2 and key == "up") then
      level_choice = 1
    end
  end
  drawLevelScreen()  
  return level_choice
end 

---
--Level page initialization
function Level()
  game_state = "level"
  if level_reached+0 == 4 then
    level_background=gfx.loadpng("images/menu/lvl"..level_reached..".png")
  else
    local no_level = level_reached+1
    level_background=gfx.loadpng("images/menu/lvl"..no_level..".png")
  end
  if (lvl1_s+0 ~= 0) then
      stars1 = gfx.loadpng("images/menu/stars"..lvl1_s..".png")
      stars1:premultiply()
  end
  if (lvl2_s+0 ~= 0) then
      stars2 = gfx.loadpng("images/menu/stars"..lvl2_s..".png")
      stars2:premultiply()
  end
  if (lvl3_s+0 ~= 0) then
      stars3 = gfx.loadpng("images/menu/stars"..lvl3_s..".png")
      stars3:premultiply()
  end
  if (lvl4_s+0 ~= 0) then
      stars4 = gfx.loadpng("images/menu/stars"..lvl4_s..".png")
      stars4:premultiply()
  end

  level_choice = 1 --default
  rocket = gfx.loadpng("images/menu/rocket.png")
  rocket:premultiply()
  drawLevelScreen()
  end
  


--AVATARS
---
--Draws the avatar page
--Draws the background, available items, unavailable parameters and the choice the player is standing on with a rectangular image
--@param y_box The inputted box representing the current option.
function drawAvatarScreen(y_box)
  screen:clear()
  screen:copyfrom(avatar_background, nil, {x = 0, y = 0, w=1280, h=720}, true) 
  --orange rectangle to see which parameter the user is standing on
   screen:copyfrom(box, nil, {x=775, y=y_box, w=335, h=150}, true)               
  --shows a lock for items that are unavailable                                                                              
  if (level_reached+0 == 1 or level_reached+0 == 0) then                                                 
    screen:copyfrom(lock, nil, {x=970, y=185}, true)                            
    screen:copyfrom(lock, nil, {x=970, y=354}, true)                            
    screen:copyfrom(lock, nil, {x=970, y=527}, true)  
    screen:copyfrom(lock_text2, nil, {x=800, y = 220, w = 165, h=55}, true)
    screen:copyfrom(lock_text3, nil, {x=800, y = 390, w = 165, h=55}, true)  
    screen:copyfrom(lock_text4, nil, {x=800, y = 560, w = 165, h=55}, true)                                                                            
  elseif (level_reached+0 == 2) then                                            
    screen:copyfrom(lock, nil, {x=970, y=354}, true)
    screen:copyfrom(lock, nil, {x=970, y=527}, true)    
    screen:copyfrom(lock_text3, nil, {x=800, y = 390, w = 165, h=55}, true)  
    screen:copyfrom(lock_text4, nil, {x=800, y = 560, w = 165, h=55}, true)                                                                            
  elseif (level_reached+0 == 3) then                                            
    screen:copyfrom(lock, nil, {x=970, y=527}, true)                                                        
    screen:copyfrom(lock_text4, nil, {x=800, y = 560, w = 165, h=55}, true)                                                                            
  end
  --right and left arrows 
  screen:copyfrom(arrow[1], nil, {x=1115, y=220, w=70, h=50}, true)
  screen:copyfrom(arrow[2], nil, {x=1115, y=390, w=70, h=50}, true)
  screen:copyfrom(arrow[3], nil, {x=1115, y=560, w=70, h=50}, true)
  screen:copyfrom(arrow[4], nil, {x=700, y=220, w=70, h=50}, true)
  screen:copyfrom(arrow[5], nil, {x=700, y=390, w=70, h=50}, true)
  screen:copyfrom(arrow[6], nil, {x=700, y=560, w=70, h=50}, true)
  --items and Bloba
  screen:copyfrom(top, nil, {x=823, y=190}, true)
  screen:copyfrom(middle, nil, {x=900, y=360}, true)
  screen:copyfrom(bottom, nil, {x=863, y=530}, true)
  screen:copyfrom(design, nil, {x=200, y=235, w=300, h=330}, true)
  gfx.update()
end

---
--Release memory
--The function controlling the memory usage and keeping the graphics memory down. 
function release_memory()
--memory from the Avatar page
  if (avatar_background ~= nil) then
    avatar_background:destroy()
    box:destroy()
    top:destroy()
    middle:destroy()
    bottom:destroy()
    design:destroy()
    for i=1, 6 do
      arrow[i]:destroy()
    end
    if (lock ~= nil) then
      lock:destroy()
    end
    if lock_text2 ~= nil then
         lock_text2:destroy()
    elseif lock_text3 ~= nil then
         lock_text3:destroy()
    elseif lock_text4 ~= nil then
        lock_text4:destroy()     
    end
  end
--memory from story, tutorial and main menu
  if (background ~= nil) then
    background:destroy()
  end
--memory from level page
  if (level_background ~= nil) then
    level_background:destroy()
    rocket:destroy()
    if (stars1 ~= nil) then
      stars1:destroy()
    end    
    if (stars2 ~= nil) then
      stars2:destroy()
    end
    if (stars3 ~= nil) then
      stars3:destroy()
    end
    if (stars4 ~= nil) then
      stars4:destroy()
    end
  end
--memory from highscore page
  if (highscore_background ~= nil) then
    highscore_background:destroy()
    if (highscore_star ~= nil) then
      highscore_star:destroy()
    end
  end
end

---
--Choose parameter 
--The function taking care of the user input changing between the top, middle and bottom options of the avatar page.
--@param key The key representing the user input to choose the correct parameter.
--@return param The output parameter representing the parameter choosen by the user.
function chooseParam(key)
  if (key == "up" and param == "middle") then
    param = "top"
    drawAvatarScreen(174)
  elseif (key == "down" and param == "middle") then
    param = "bottom"
    drawAvatarScreen(515)
  elseif (key == "down" and param == "top") then
    param = "middle"
    drawAvatarScreen(343)
  elseif (key == "up" and param == "bottom") then
    param = "middle"    
    drawAvatarScreen(343)
  end  
  return param
end

---
--Choose item
--Choosing what items to design the avatar with depending on the user input and the parameter representing the current avatar page "level": top, middle or bottom. 
--@param key The key to choose the correct item. 
function chooseItem(key)
  --TOP go Right
  if (key == "right" and param == "top") then
    if (index_t < #top_items) then 
      top:destroy()
      design:destroy()
      index_t = index_t + 1
      --changing top item and Bloba
      top = gfx.loadpng(top_items[index_t]) 
      top:premultiply()    
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_t == #top_items) then --change right to unavailable
        arrow[1]:destroy()
        arrow[1] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
      elseif (index_t==2) then --change left to available
        arrow[4]:destroy()
        arrow[4] = gfx.loadpng("images/menu/avatar_img/arrow_left.png")
      end
      drawAvatarScreen(174)
    end
  --TOP go left
  elseif (key == "left" and param == "top") then
    if (index_t > 1) then
      top:destroy()
      design:destroy()
      index_t = index_t - 1      
      --changing top item and Bloba
      top = gfx.loadpng(top_items[index_t])
      top:premultiply()    
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_t == 1) then  --change left to unavailable
        arrow[4]:destroy()
        arrow[4] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
      elseif (index_t == #top_items -1) then  --change right to available
        arrow[1]:destroy()
        arrow[1] = gfx.loadpng("images/menu/avatar_img/arrow_right.png")
      end
      drawAvatarScreen(174)      
    end
  --MIDDLE go RIGHT
  elseif (key == "right" and param == "middle") then
    if (index_m < #middle_items) then
      middle:destroy()
      design:destroy()
      index_m = index_m + 1
      --changing middle item and Bloba
      middle = gfx.loadpng(middle_items[index_m])
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_m == #middle_items) then --change right to unavailable
        arrow[2]:destroy()
        arrow[2] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
      elseif (index_m==2) then  --change left to available
        arrow[5]:destroy()
        arrow[5] = gfx.loadpng("images/menu/avatar_img/arrow_left.png")
      end
      drawAvatarScreen(343)
    end
  --MIDDLE go LEFT
  elseif (key == "left" and param == "middle") then
    if (index_m > 1) then
      middle:destroy()
      design:destroy()
      index_m = index_m - 1     
      --changing middle item and Bloba
      middle = gfx.loadpng(middle_items[index_m])
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_m == 1) then  --change left to unavailable
        arrow[5]:destroy()
        arrow[5] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
      elseif (index_m == #middle_items -1) then --change right to available
        arrow[2]:destroy()
        arrow[2] = gfx.loadpng("images/menu/avatar_img/arrow_right.png")
      end
      drawAvatarScreen(343)
    end
  --BOTTOM go RIGHT
  elseif (key == "right" and param == "bottom") then
    if (index_b < #bottom_items) then
      bottom:destroy()
      design:destroy()
      index_b = index_b + 1    
      --changing bottom item and Bloba
      bottom = gfx.loadpng(bottom_items[index_b])
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_b == #bottom_items) then  --change right to unavailable
        arrow[3]:destroy()
        arrow[3] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
      elseif (index_b==2) then  --change left to available
        arrow[6]:destroy()
        arrow[6] = gfx.loadpng("images/menu/avatar_img/arrow_left.png")
      end
      drawAvatarScreen(515)
    end
  --BOTTOM go LEFT
  elseif (key == "left" and param == "bottom") then
    if (index_b > 1) then
      bottom:destroy()
      design:destroy()
      index_b = index_b - 1      
      --changing bottom item and Bloba
      bottom = gfx.loadpng(bottom_items[index_b])
      design = gfx.loadpng(bloba[index_t..index_m..index_b])
      design:premultiply()
      --change arrows
      if (index_b == 1) then  --change left to unavailable
        arrow[6]:destroy()
        arrow[6] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
      elseif (index_b == #bottom_items -1) then --change right to available
        arrow[3]:destroy()
        arrow[3] = gfx.loadpng("images/menu/avatar_img/arrow_right.png")
      end
      drawAvatarScreen(515)
    end
  end
end

---
--Get bloba design for gameplay
--The function finding the bloba design either default or customised in avatar page.
function get_design()
  if (index_t == nil) then
    index_t = 1
    index_m = 1
    index_b = 1
  end
  return bloba[index_t..index_m..index_b]
end

---
--Avatar page initialization
function Avatar()
  game_state = "avatars"
  unlock()
  avatar_background = gfx.loadpng("images/menu/avatar_img/Avatar.png")
  param = "top" -- default head area
  index_t = 1 --default top-index 
  index_m = 1 --default middle-index
  index_b = 1 --default bottom-index
  box = gfx.loadpng("images/menu/avatar_img/rec.png") --the orange box that emphasized where you stand
  box:premultiply()   
  top = gfx.loadpng(top_items[index_t])
  top:premultiply() 
  middle = gfx.loadpng(middle_items[index_m])
  middle:premultiply()
  bottom = gfx.loadpng(bottom_items[index_b])
  bottom:premultiply()
  design = gfx.loadpng(bloba[index_t..index_m..index_b]) --bloba image
  design:premultiply()
  --loading the images for locks based on reached level
  if level_reached+0 < 4 then
      lock = gfx.loadpng("images/menu/avatar_img/lock.png")
      lock:premultiply()
      if (level_reached+0 == 0 or level_reached+0 == 1) then
        lock_text2 = gfx.loadpng("images/menu/avatar_img/lock2.png")
        lock_text3 = gfx.loadpng("images/menu/avatar_img/lock3.png")
        lock_text4 = gfx.loadpng("images/menu/avatar_img/lock4.png")
      elseif (level_reached+0 == 2) then
        lock_text3 = gfx.loadpng("images/menu/avatar_img/lock3.png")
        lock_text4 = gfx.loadpng("images/menu/avatar_img/lock4.png")
      elseif (level_reached+0 == 3) then
        lock_text4 = gfx.loadpng("images/menu/avatar_img/lock4.png")
      end
  end
  --loading grey arrows to the direction that is not available and turqoise arrows to directions that are available
  if (level_reached+0 == 1 or level_reached+0 == 0) then
    for i=1, 3 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
    end
    for i=4, 6 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
    end
  elseif (level_reached+0 == 2) then
    arrow[1] = gfx.loadpng("images/menu/avatar_img/arrow_right.png")
    for i=2, 3 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
    end
    for i=4, 6 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
    end
  elseif (level_reached+0 == 3) then
    for i=1, 2 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_right.png")
    end
    arrow[3] = gfx.loadpng("images/menu/avatar_img/arrow_right_grey.png")
    for i=4, 6 do
      arrow[i] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png")
    end
  elseif (level_reached+0 == 4) then
    arrow[1] = gfx.loadpng("images/menu/avatar_img/arrow_right.png") --top right
    arrow[2] = gfx.loadpng("images/menu/avatar_img/arrow_right.png") --middle right
    arrow[3] = gfx.loadpng("images/menu/avatar_img/arrow_right.png") --bottom right
    arrow[4] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png") --top left
    arrow[5] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png") --middle left
    arrow[6] = gfx.loadpng("images/menu/avatar_img/arrow_left_grey.png") --bottom left
  end
  for i=1, 6 do
    arrow[i]:premultiply()
  end
  drawAvatarScreen(174)
end

---
--draws the highscore page
--entails the background and the stars that are earned
function drawHighscoreScreen()
  screen:clear()
  screen:copyfrom(highscore_background, nil, {x = 0, y = 0, w=1280, h=720}, true)
  if highs+0 > 0 then
    screen:copyfrom(highscore_star, nil, {x = 91, y = 109, w=156, h=132}, true)
  end
  if highs+0 > 1 then
    screen:copyfrom(highscore_star, nil, {x = 613, y = 537, w=157, h=132}, true)
  end
  if highs+0 > 2 then
    screen:copyfrom(highscore_star, nil, {x = 884.5, y = 207.5, w=157, h=132}, true)
  end
  if highs+0 > 3 then
    screen:copyfrom(highscore_star, nil, {x = 295, y = 520.5, w=157, h=132}, true)
  end
  if highs+0 > 4 then
    screen:copyfrom(highscore_star, nil, {x = 287.5, y = 236.5, w=157, h=132}, true)
  end
  if highs+0 > 5 then
    screen:copyfrom(highscore_star, nil, {x = 738, y = 366, w=157, h=132}, true)
  end
  if highs+0 > 6 then
    screen:copyfrom(highscore_star, nil, {x = 884, y = 540, w=157, h=132}, true)
  end
  if highs+0 > 7 then
    screen:copyfrom(highscore_star, nil, {x = 55, y = 405, w=157, h=132}, true)
  end
  if highs+0 > 8 then
    screen:copyfrom(highscore_star, nil, {x = 539, y = 175, w=157, h=132}, true)
  end
  if highs+0 > 9 then
    screen:copyfrom(highscore_star, nil, {x = 1075, y = 390, w=157, h=132}, true)
  end
  if highs+0 > 10 then
    screen:copyfrom(highscore_star, nil, {x = 1057, y = 93, w=157, h=132}, true)
  end
  if highs+0 > 11 then
    screen:copyfrom(highscore_star, nil, {x = 490, y = 365, w=157, h=132}, true)
  end
  gfx.update()
end

---
--highscore page initialization
function highscore()
  game_state = "scores"
  highscore_background = gfx.loadpng("images/menu/highscore.png")
  highscore_star = gfx.loadpng("images/menu/highscore_star.png")
  drawHighscoreScreen()
end

---
--Storyline strip initialization 
function Story()
  game_state = "story"
  if (background ~= nil) then
    background:destroy()
  end
  if (page == nil) then
    page = 1
  elseif (page == 4) then
    startPage()
    goto Next 
  else
    page = page + 1
  end
  story_img = "images/story/story"..page..".png"
  background = gfx.loadpng(story_img)
  load_png(background)
  ::Next::
end

---
--Tutorial page initialization
--The function controlling the tutorial event handling the profile, background and the page.
--@param tutorial_page The input tutorial handle in the on key
function tutorial(tutorial_page)
  game_state = "tutorial"
  --saveProfil(profil,0,0,0,0,0,4)
  if (background ~= nil) then
    background:destroy()
  end
  if (tutorial_page == nil or tutorial_page == 0) then
    tutorial_page = 1
  elseif (tutorial_page > 4) then
    tutorial_page = 4
  end
  tutorial_img = "images/tutorial"..tutorial_page..".png"
  background = gfx.loadpng(tutorial_img)
  load_png(background)
end

---
--Dance function
--The function to handle the event after the completion of the boss level
function dance()
  game_state="dance"
  if (dance_img == "/images/dance1o.png") then
    dance_img = "/images/dance2o.png"
  else 
    dance_img ="/images/dance1o.png"
  end
  dance_picture = gfx.loadpng(dance_img)
  load_png(dance_picture)
  dance_picture:destroy()
end



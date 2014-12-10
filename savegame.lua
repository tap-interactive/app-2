---
--The Save game module 
--The controller for managing the save game module. 
--@module SaveGame 



-- Alan
-- 0 level 1
-- 2 level 2
-- 1 level 3
-- 3 total of stars
-- /
---
--Save profile
--The function controlling the saving of the user saving all the information about the user. 
--@param name The name of the user.
--@param lvl1_stars The amount of stars achieved in the level one, by the user.
--@param lvl2_stars The amount of stars achieved in the level two, by the user.
--@param lvl3_stars The amount of stars achieved in the level three, by the user.
--@param lvl4_stars The amount of stars achieved in the level four, by the user.
--@param highscore The total number of stars achieved.
--@param lvl_reached The level reached by the user.
function saveProfil(name,lvl1_stars,lvl2_stars,lvl3_stars,lvl4_stars,highscore,lvl_reached) --REMINDER: Don't forget to change everywhere you call this function
	local savegame_name = "/mnt/"..path.."/app2/gamev3/savegame"..name..".txt"
	local savegame_content = lvl1_stars.."/"..lvl2_stars.."/"..lvl3_stars.."/"..lvl4_stars.."/"..highscore.."/"..lvl_reached.."\n"
	local file = io.open(savegame_name,"w+")
	io.output(file)
	io.write(savegame_content)
	io.close()
end

---
--Load profile
--The function controlling the loading of an already saved profile.
--@param name The name of the user.
--@param star_lvl1 The amount of stars achieved in the level one, by the user.
--@param star_lvl2 The amount of stars achieved in the level two, by the user.
--@param star_lvl3 The amount of stars achieved in the level three, by the user.
--@param star_lvl4 The amount of stars achieved in the level four, by the user.
--@return high The total number of stars achieved.
--@return reached_lvl The level reached by the user.
function loadProfil(name) --REMINDER: Don't forget to change everywhere you call this function
  -- Opens a file in read
  local savegame_name = "/mnt/"..path.."/app2/gamev3/savegame"..name..".txt"
  local file = io.open(savegame_name, "r")
  io.input(file)
  local count = 1
  while true do
      local f = io.read()
	  if f == nil then break end
	  if count == 1 then
		  if f == nil then break end
		  star_lvl1,star_lvl2,star_lvl3,star_lvl4,high,reached_lvl = string.match(f,"(%d+)/(%d+)/(%d+)/(%d+)/(%d+)/(%d+)")
	  end
	  count = count + 1
  end
  io.close(file)
  return star_lvl1,star_lvl2,star_lvl3,star_lvl4,high,reached_lvl
end




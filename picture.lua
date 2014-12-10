--- 
--The Picture module
--The controller for managing the Picture module. 
--@module Picture  

--- 
--Slob pictures 
--Function for creating the Slobs pictures. 
--@return Slobs_img The table containing the three different pictures representing the different Slobs and the picture for Mad Zlobby. The pictures that is used for displaying the slobs that has been turned happy, is also loaded. 
function make_slob_picture()
	local Slobs_img = {}
	Slobs_img[1] = gfx.loadpng("images/slob1.png")
	Slobs_img[2] = gfx.loadpng("images/slob2.png")
	Slobs_img[3] = gfx.loadpng("images/slob3.png")
	Slobs_img[4] = Slobs_img[1]
	Slobs_img[5] = gfx.loadpng("images/friend1.png")
	Slobs_img[6] = gfx.loadpng("images/friend2.png")
	Slobs_img[7] = gfx.loadpng("images/friend3.png")
	Slobs_img[8] = gfx.loadpng("images/slob5s.png")
	Slobs_img[9] = gfx.loadpng("images/slob4.png")
	for i=1, #Slobs_img do
		Slobs_img[i]:premultiply()
	end
	return Slobs_img
end
Slobs_img = Slobs_img or make_slob_picture()

---
--Slob numbers 
--The function that loads the pictures and places them in a table, to later be placed on the Slobs and the Blob. 
-- @return number The Table that contains the number pictures to be printed on the Slobs, ordered by their represented size. 
function make_number_pictures()
	local number = {}
	number[0] = gfx.loadpng("images/no0.png")
	number[1] = gfx.loadpng("images/no1.png")
	number[2] = gfx.loadpng("images/no2.png")
	number[3] = gfx.loadpng("images/no3.png")
	number[4] = gfx.loadpng("images/no4.png")
	number[5] = gfx.loadpng("images/no5.png")
	number[6] = gfx.loadpng("images/no6.png")
	number[7] = gfx.loadpng("images/no7.png")
	number[8] = gfx.loadpng("images/no8.png")
	number[9] = gfx.loadpng("images/no9.png")
   for i=0, #number do
		number[i]:premultiply()
	end
   return number
end
all_numbers = all_numbers or make_number_pictures()

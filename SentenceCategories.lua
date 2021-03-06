--function make_window()
-- Sentencer Root Path
--on mac make this root back in 2010 "/ig3d_mac_xcode/Data/Fluid/SentenceCategories/"
sentencerRoot = ""
cbrowsertable={}
gFoldersFound={}
gFilesFound={}
math.randomseed(os.time())
functionslist={}
pickedlist={{}}
q = "\""
empty="  "
--dirandsubdirs getfilelist getAllFoldersandFiles
function dirandsubdirs(tPath)
	for file in lfs.dir(tPath) do
		if string.sub(file, 1,1) ~= "."    then
		local f = tPath..'/'..file
            	local attr = lfs.attributes(f)
            	assert (type(attr) == "table")
             		if attr.mode == "directory" then 
           		local a={file, "directory"}
			table.insert(gFoldersFound, f)
			end 
		end
	end
	
end

function getfilelist(tPath)
	for file in lfs.dir(tPath) do
 		if string.sub(file, 1,1) ~= "."    then
        local f = tPath..'/'..file
        local attr = lfs.attributes(f)
		assert (type(attr) == "table")
        	if attr.mode == "file" and string.sub(file, -4,-1)==".lua" then 
            local a={file, "file"}  
            table.insert(gFilesFound, f) 
            end  
 		end          
	end
end


function getAllFoldersandFiles(tPath)
gFoldersFound={}
dirandsubdirs(tPath)
local n = #gFoldersFound
for i =1,n,1 do dirandsubdirs(gFoldersFound[i]) end
gFilesFound={}
if gFoldersFound[1]== nil then gFoldersFound[1] = tPath end
for i = 1,#gFoldersFound,1 do getfilelist(gFoldersFound[i]) end	
end
--listFiles
 
function listFiles(path)
local fileList={}
--print(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path.."/"..file
           -- print(f)
            local attr = lfs.attributes(f)
            assert (type(attr) == "table")
             if attr.mode == "file" then 
             if file ~= ".DS_Store"  then
             table.insert(fileList, file)
             end
           -- print(file)
           end   
        end
     end
    return fileList
end
--load all the tables in the path
-- 

tablesfolderpath = sentencerRoot.."Word_Categories" 

getAllFoldersandFiles(tablesfolderpath)
tablesfiles = gFilesFound
--tablesfiles = listFiles(tablesfolderpath)
for i=1,#tablesfiles,1 do
if tablesfiles[i] ~= nil then
tablefilepath=tablesfiles[i]
--print(tablefilepath)

dofile(tablefilepath)

end



end
-- clear_cb
function clear_cb()
pickedbrowser:clear()
resultbrowser:clear()
resultField_buf:text("")
end
--load all the functions in the path
-- 

sentencerfuncpath = sentencerRoot.."SentenceCategories_Functions" 

funcfiles = listFiles(sentencerfuncpath)
for i=1,#funcfiles,1 do
funcfilepath= sentencerfuncpath.."/"..funcfiles[i]
--print(tablefilepath)
dofile(funcfilepath)
end
--resultPrint
function resultPrint(...)


	local str=""
	local i=1
	while arg[i]~= nil do
		if str=="" then
			str=tostring(arg[i])
		else
			str=str.."	"..tostring(arg[i])
		end
		
		i=i+1
	end
	nn=0
	aa=""
	nc=0
	str=str
for ii in string.gfind(str,".") do
nn=nn+1 
aa=aa..ii
nc=nc+1
tw=resultField:w()/(resultField:textsize())+12
	if nc>=tw then 
	if ii == " " then
	aa=aa.."\n"
	nc=0
	end
	end
end
nnp=#pickedlist
cc=pickedlist[nnp][1]
if aa ~= "" then str=aa end

lfc=string.len(str)

shrtstr=string.sub(str,1,20)
if string.len(str) >= 20 then 
resultField_buf:text("")
	 
	local l_offset=# resultField_buf:text()
	 resultField:insert_position(l_offset)
	 resultField:insert(str.."\n")
	 resultField:show_insert_position()
	 resultField:textfont(4)
	 resultField:textsize(11)
	pickedbrowser:add(cc)
	 resultbrowser:add(string.gsub(shrtstr,"\n"," "))
	 else 
	 pickedbrowser:add(cc)
	 resultbrowser:add(string.gsub(str,"\n"," "))
	 end

	 
	 
end
-- functionsbrowser_cb
function functionsbrowser_cb(w)
if w:value() == nil then return end
if w:value() <=0 then return end
cbt = cbrowsertable[w:value()]
print(a)
s=functionslist[cbt]
sres = evaluateTable(cbt)
table.insert(pickedlist,{cbt,sres})
resultPrint(sres)

end
--randomstuff_cb
function randomstuff_cb()

r=math.random(1,50)
for i = 1,r,1 do
rs=math.random(1,#cbrowsertable)


s = cbrowsertable[rs]
if s =="anyName" then sres= anyName() end
if s =="maleName" then sres= maleName() end
if s =="femaleName" then sres= femaleName() end
if s =="ethnic" then sres= ethnic() end
if s =="career" then sres= career() end
if s =="ghettoName" then sres= ghettoName() end
if s =="cityName" then sres= cityName() end
if s =="verb" then sres= verb() end
if s =="rhymeWord" then sres= rhymeWord() end
if s =="colorName" then sres= colorName() end
if s =="pronoun" then sres= pronoun() end
if s =="noun" then sres= noun() end
if s =="actionVerb" then sres= actionVerb() end
if s =="preposition" then sres= preposition() end
if s =="personalityAdjective" then sres= personalityAdjective() end
if s =="adjective" then sres= adjective() end
if s =="shapeName" then sres= shapeName() end
if s =="mentalIllness" then sres= mentalIllness() end
if s =="phobia" then sres= phobia() end
if s =="tourettes" then sres= tourettes() end
if s =="exclamation" then sres= exclamation() end
if s =="vulgarity" then sres= vulgarity() end
if s =="anatomy" then sres= anatomy() end
if s =="monster" then sres= monster() end
if s =="mythicMonster" then sres= mythicMonster() end
if s =="oneLiner" then sres= oneLiner() end
if s =="lovecraftElement" then sres= lovecraftElement() end
if s =="ebonic" then sres= ebonic() end
if s =="ghettotalk" then sres= ghettotalk() end
if s =="yo_momma" then sres= yo_momma() end
if s =="excuse" then sres= excuse() end
if s =="kidsGame" then sres= kidsGame() end
if s =="food" then sres= food() end
if s =="demon" then sres= demon() end
if s =="bookName" then sres= bookName() end
if s =="tarotName" then sres= tarotName() end
if s =="celticCross" then sres= celticCross() end
if s =="animalName" then sres= animalName() end
if s =="element" then sres= element() end
if s =="meleeWeapon" then sres= meleeWeapon() end
if s =="shit" then sres= shit() end
if s =="tourettes" then sres= tourettes() end
if s =="onomatopoeia" then sres= onomatopoeia() end
if s =="dunwich" then sres= dunwich() end
if s =="lyric" then sres= lyric() end
if s =="road" then sres= road() end
if s =="speechVerb" then sres = speechVerb() end
if s =="alisaList" then sres= alisaList() end
if s =="letter" then sres= letter() end
if s =="textAdventure" then sres = textAdventure() end
if s =="undermountain" then sres = undermountain() end
if s =="houseRoom" then sres = houseRoom() end
if s =="superpower" then sres = superpower() end
if s =="stereotype" then sres = stereotype() end
if s =="business" then sres = business() end
if s =="adverbs" then sres = adverb() end
if s =="classes" then sres = classes() end
if s =="motivation" then sres = motivation() end
if s=="lovecraftwords" then sres=lovecraftwords() end
if s=="NPC" then sres=npcencounter() end
if s=="location" then sres=location() end
if s=="twentiesSlang" then sres=twentiesSlang() end
if s =="occupation" then sres=occupation() end
if s =="skill" then sres=skill() end
if s=="psychiatry" then sres=psychiatry() end
if s=="History" then sres=History() end
if s=="disaster" then sres=disaster() end


resultPrint(sres)
end

end
--tablesbrowserUpdate

function tablesbrowserUpdate(c)
print(c)
functionsbrowser:clear()
cbrowsertable={}
categoriesbrowser:clear()
if c == " " then 
for i=1,#functionslist,1 do
table.insert(cbrowsertable,functionslist[i])
functionsbrowser:add(functionslist[i])
ff=functionslist[i]
setup1="if s =="..q..ff..q.." then sres= "..ff.."() end"
end
end

if string.len(c) == 1 then 
	for i=1,#functionslist,1 do
	a=string.sub(functionslist[i],1,1)
		if a==c then 
		table.insert(cbrowsertable,functionslist[i])
		functionsbrowser:add(functionslist[i])
		ff=functionslist[i]
		setup1="if s =="..q..ff..q.." then sres= "..ff.."() end"
		end
		end
end


for i =1,#gFoldersFound,1 do
if gFoldersFound[i] ~= nil then
categoriespath= string.gsub(gFoldersFound[i],sentencerRoot.."Word_Categories/","")
categoriesbrowser:add(categoriespath)
end
end

resultField_buf = fltk:Fl_Text_Buffer();
resultField:buffer(resultField_buf);
end
-- FilterInputChanged
function FilterInputChanged(w)
t=w:value()
if t== nil then t=" " end
if tonumber(t) ~= nil then w:value("") end
o=string.sub(t,-1,-1)
w:value(o)
tablesbrowserUpdate(o)
end
-- categoriessbrowser_cb
function categoriesbrowser_cb(w)
if w:value() == nil then return end
tfo= gFoldersFound[w:value()]
nn=string.len(tfo.."/")
n=string.len(sentencerRoot.."Word_Categories/")
tfn=string.sub(tfo,n,-1)

functionsbrowser:clear()
cbrowsertable={}

	for i=1,#gFilesFound,1 do
	if gFilesFound[i] ~= nil then
	if string.find(gFilesFound[i],tfn) ~= nil then 	
	
	
	tf=string.sub(gFilesFound[i],nn,-1)
	
	if string.find(tf,"_") ~= nil then
	sn=string.find(tf,"/")+1
	un=string.find(tf,"_")-2
	
	out=string.sub(tf,sn,un)
		
	for ii=1,#functionslist,1 do
	a=functionslist[ii]
		if a~=nil then
		x=string.sub(out,1,4)
		y=string.sub(a,1,4)
		print(a)
			if string.find(x,y) ~= nil then 
			table.insert(cbrowsertable,a)
			functionsbrowser:add(a)
			ff=a
			setup1="if s =="..q..ff..q.." then sres= "..ff.."() end"
			end
		end
	end
		
		
	end
		
	end
	end
	
end

end
-- tablesbrowserInit
function tablesbrowserInit()
tablesbrowser:clear()
functionsbrowser:clear()
cbrowsertable={}
for i=1,#tablesfiles,1 do
tablesbrowser:add(tablesfiles[i])
end
for i=1,#functionslist,1 do
functionsbrowser:add(functionslist[i])

ff=functionslist[i]
table.insert(cbrowsertable,functionslist[i])
setup1="if s =="..q..ff..q.." then sres= "..ff.."() end"
end

for i =1,#gFoldersFound,1 do
if gFoldersFound[i] ~= nil then
categoriespath= string.gsub(gFoldersFound[i],sentencerRoot.."Word_Categories/","")
categoriesbrowser:add(categoriespath)
end
end

resultField_buf = fltk:Fl_Text_Buffer();
resultField:buffer(resultField_buf);

--resultField2_buf = fltk:Fl_Text_Buffer();
--resultField2:buffer(resultField2_buf);
end
do Useit= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Useit")
Useit:label(gLabelTable[#gLabelTable])
Useit:resize(180,68,607,529)
Fl_Group:current():resizable(Useit)
--Useit:show()
do BrowseGroup= fltk:Fl_Group(0,0,0,0,"")
BrowseGroup:resize(-4,25,602,306)
do functionsbrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "functionsbrowser")
functionsbrowser:label(gLabelTable[#gLabelTable])
functionsbrowser:callback(functionsbrowser_cb)
functionsbrowser:resize(86,33,129,292)
functionsbrowser:type(2)
functionsbrowser:labeltype(fltk.FL_NO_LABEL)
functionsbrowser:textsize(12)
end

do categoriesbrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "functionsbrowser")
categoriesbrowser:label(gLabelTable[#gLabelTable])
categoriesbrowser:callback(categoriesbrowser_cb)
categoriesbrowser:resize(3,33,82,292)
categoriesbrowser:type(2)
categoriesbrowser:labeltype(fltk.FL_NO_LABEL)
categoriesbrowser:textsize(12)
end

do pickedbrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "pickedbrowser")
pickedbrowser:label(gLabelTable[#gLabelTable])
pickedbrowser:resize(221,33,129,292)
pickedbrowser:type(1)
pickedbrowser:labeltype(fltk.FL_NO_LABEL)
pickedbrowser:textsize(12)
end

do resultbrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "functionsbrowser")
resultbrowser:label(gLabelTable[#gLabelTable])
resultbrowser:resize(350,33,245,292)
resultbrowser:type(1)
resultbrowser:labeltype(fltk.FL_NO_LABEL)
resultbrowser:textsize(12)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TopGroup= fltk:Fl_Group(0,0,0,0,"")
TopGroup:resize(25,0,320,30)
do randomize= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "randomize")
randomize:label(gLabelTable[#gLabelTable])
randomize:callback(randomstuff_cb)
randomize:resize(130,5,80,20)
end

do FilterInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Filter:")
FilterInput:label(gLabelTable[#gLabelTable])
FilterInput:callback(FilterInputChanged)
FilterInput:resize(40,7,65,18)
FilterInput:labelsize(11)
FilterInput:when(1)
FilterInput:textsize(11)
end

do clear= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "clear")
clear:label(gLabelTable[#gLabelTable])
clear:callback(clear_cb)
clear:resize(220,5,80,20)
end
Fl_Group:current(Fl_Group:current():parent())
end

do tablesbrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "tablesbrowser")
tablesbrowser:label(gLabelTable[#gLabelTable])
tablesbrowser:resize(-130,30,130,160)
tablesbrowser:type(1)
tablesbrowser:textsize(10)
end

do resultField= fltk:Fl_Text_Editor(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "resultField")
resultField:label(gLabelTable[#gLabelTable])
resultField:resize(5,340,590,175)
resultField:labeltype(fltk.FL_NO_LABEL)
resultField:labelsize(10)
resultField:textsize(10)
end
end
Useit:show()

tablesbrowserInit()
--end
Fl:run()

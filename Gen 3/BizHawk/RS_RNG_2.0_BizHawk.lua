mdword = memory.read_u32_le
mword = memory.read_u16_le
mbyte = memory.readbyte
rshift = bit.rshift
bxor = bit.bxor
band = bit.band
floor = math.floor

local natureorder = {"Atk", "Def", "Spd", "SpAtk", "SpDef"}
local naturename = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}
local typeorder = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}
local movename = {
 "--" , "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch", "Thunder Punch", 
 "Scratch", "Vice Grip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust", "Wing Attack", "Whirlwind", "Fly", 
 "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick", "Rolling Kick", "Sand Attack", "Headbutt", 
 "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap", "Take Down", "Thrash", "Double-Edge",
 "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite", "Growl", "Roar", "Sing", "Supersonic", "Sonic Boom", 
 "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun", "Hydro Pump", "Surf", "Ice Beam", "Blizzard", "Psybeam", 
 "Bubble Beam", "Aurora Beam", "Hyper Beam", "Peck", "Drill Peck", "Submission", "Low Kick", "Counter", "Seismic Toss", 
 "Strength", "Absorb", "Mega Drain", "Leech Seed", "Growth", "Razor Leaf", "Solar Beam", "Poison Powder", "Stun Spore", 
 "Sleep Powder", "Petal Dance", "String Shot", "Dragon Rage", "Fire Spin", "Thunder Shock", "Thunderbolt", "Thunder Wave", 
 "Thunder", "Rock Throw", "Earthquake", "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate", 
 "Agility", "Quick Attack", "Rage", "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden", 
 "Minimize", "Smokescreen", "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect",
 "Focus Energy", "Bide", "Metronome", "Mirror Move", "Self-Destruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club",
 "Fire Blast", "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Soft-Boiled", 
 "High Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack", "Transform", 
 "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer", "Explosion", "Fury Swipes", 
 "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack", "Super Fang", "Slash", 
 "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader", "Nightmare", "Flame Wheel", 
 "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal", "Spite", "Powder Snow", "Protect", 
 "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum", "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes", 
 "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song", "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage", 
 "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout", "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter", 
 "Steel Wing", "Mean Look", "Attract", "Sleep Talk", "Heal Bell", "Return", "Present", "Frustration", "Safeguard",
 "Pain Split", "Sacred Fire", "Magnitude", "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit",
 "Rapid Spin", "Sweet Scent", "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power", 
 "Cross Chop", "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power", 
 "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up", "Fake Out", "Uproar", "Stockpile", "Spit Up", 
 "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp", "Memento", "Facade", "Focus Punch", "Smelling Salts", 
 "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand", "Trick", "Role Play", "Wish", "Assist", "Ingrain", 
 "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock Off", "Endeavor", "Eruption", "Skill Swap", 
 "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge", 
 "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack Off",
 "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball", 
 "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound",
 "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut",
 "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl",
 "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf",
 "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire",
 "Psycho Boost"}

local mode = {"None", "Capture", "Breeding", "Pandora", "Pokemon Info"}
local index = 1
local gameLang = mbyte(0x080000AF)
local gameVersion = mbyte(0x080000AE)
local language
local monInfo
local pointers
local partyscreenOff
local startboxInfo
local startboxInfo2
local partyScreen
local partyCursor
local hpiv
local atkiv
local defiv
local spdiv
local spatkiv
local spdefiv
local personality
local shinyCheck
local nature
local natinc
local natdec
local hidpowtype
local hidpowbase
local tid
local sid

if gameLang == 0x4A then  -- Check game language
 language = "JPN"
 monInfo = 0
 movesInfo = 0
 pointers = 0
 partyscreenOff = 0
 startboxInfo = 0
 startboxInfo2 = 0
elseif gameLang == 0x45 then
 language = "USA"
 monInfo = 0xD0
 movesInfo = -0x3D4
 pointers = 0x2A0
 partyscreenOff = 0x80000
 startboxInfo = 0x2E4
 startboxInfo2 = 0x5D0
else
 language = "EUR"
 monInfo = 0xE0
 movesInfo = -0x3D4
 pointers = 0x2A0
 partyscreenOff = 0x80000
 startboxInfo = 0x2E4
 startboxInfo2 = 0x5D0
end

if gameVersion == 0x56 then  -- Check game version
 game = "Ruby"
elseif gameVersion == 0x50 then
 game = "Sapphire"
elseif gameVersion == 0x52 then
 game = "FireRed"
elseif gameVersion == 0x47 then
 game = "LeafGreen"
elseif gameVersion == 0x45 then
 game = "Emerald"
end

if game ~= 'Ruby' and game ~= 'Sapphire' then
 warning = ' - Wrong game version! Use Ruby/Sapphire instead'
else
 warning = ''
end

console.clear()
print("New Order of Breeding x Real.96")
print("") 
print("Game Version: "..game..warning)
print("Language: "..language)

local start = 0x030044F0 + monInfo
local moveStart = 0x02024844 + movesInfo
local ppStart = 0x0202485C + pointers
local partyStart = 0x03004290 + monInfo
local currentboxpidSelected = 0x02000C1C + startboxInfo2
local boxCheck = false
local initSeed = 0
local currSeed = 0
local tempInit = 0
local tempCurr = 0
local frame = 0
local key = {}
local prevKey = {}

joypad.set({Power = true})

function next(s)	
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function back(s)	
 local a = 0xEEB9 * (s % 65536) + rshift(s, 16) * 0xEB65
 local b = 0xEB65 * (s % 65536) + (a % 65536) * 65536 + 0x0A3561A1
 local c = b % 4294967296
 return c
end

function calcFrameJump()
 frame = frame + 1
 calibrationFrame = 0
 if frame > 4 and tempCurr ~= currSeed then
  tempCurr2 = tempCurr
  while tempCurr ~= currSeed and tempCurr2 ~= currSeed do
   tempCurr = next(tempCurr)
   tempCurr2 = back(tempCurr2)
   calibrationFrame = calibrationFrame + 1
  end
  if tempCurr2 == currSeed then
    calibrationFrame = (-1) * calibrationFrame
	tempCurr = tempCurr2
  end
 end
 userdata.set('temp', tempCurr)
 return calibrationFrame
end

function setinitseed()
 initSeed = userdata.get('seed')
 frame = userdata.get('frame')
 tempCurr = userdata.get('temp')
end

function showStats()
 gui.text(0, 21, "Stats:")
 gui.text(90, 21, "HP "..mword(start + 86))
 gui.text(176, 21, "Atk "..mword(start + 90))
 gui.text(272, 21, "Def "..mword(start + 92))
 gui.text(366, 21, "SpA "..mword(start + 96))
 gui.text(460, 21, "SpD "..mword(start + 98))
 gui.text(554, 21, "Spe "..mword(start + 94))
end

function showhiddenInfo()
 gui.text(0, 41, "IVs:")
 gui.text(90, 41, "HP ")
 if hpiv >= 30 then
  gui.text(120, 41, hpiv, "LIMEGREEN")
 elseif hpiv >= 1 and hpiv <= 5 then
  gui.text(120, 41, hpiv, "orange")
 elseif hpiv < 1 then
  gui.text(120, 41, hpiv, "red")
 else
  gui.text(120, 41, hpiv)
 end
 gui.text(176, 41, "Atk ")
 if atkiv >= 30 then
  gui.text(216, 41, atkiv, "LIMEGREEN")
 elseif atkiv >= 1 and atkiv <= 5 then
  gui.text(216, 41, atkiv, "orange")
 elseif atkiv < 1 then
  gui.text(216, 41, atkiv, "red")
 else
  gui.text(216, 41, atkiv)
 end
 gui.text(272, 41, "Def ")
 if defiv >= 30 then
  gui.text(312, 41, defiv, "LIMEGREEN")
 elseif defiv >= 1 and defiv <= 5 then
  gui.text(312, 41, defiv, "orange")
 elseif defiv < 1 then
  gui.text(312, 41, defiv, "red")
 else
  gui.text(312, 41, defiv)
 end
 gui.text(366, 41, "SpA ")
 if spatkiv >= 30 then
  gui.text(406, 41, spatkiv, "LIMEGREEN")
 elseif spatkiv >= 1 and spatkiv <= 5 then
  gui.text(406, 41, spatkiv, "orange")
 elseif spatkiv < 1 then
  gui.text(406, 41, spatkiv, "red")
 else
  gui.text(406, 41, spatkiv)
 end
 gui.text(460, 41, "SpD ")
 if spdefiv >= 30 then
  gui.text(500, 41, spdefiv, "LIMEGREEN")
 elseif spdefiv >= 1 and spdefiv <= 5 then
  gui.text(500, 41, spdefiv, "orange")
 elseif spdefiv < 1 then
  gui.text(500, 41, spdefiv, "red")
 else
  gui.text(500, 41, spdefiv)
 end
 gui.text(554, 41, "Spe ")
 if spdiv >= 30 then
  gui.text(594, 41, spdiv, "LIMEGREEN")
 elseif spdiv >= 1 and spdiv <= 5 then
  gui.text(594, 41, spdiv, "orange")
 elseif spdiv < 1 then
  gui.text(594, 41, spdiv, "red")
 else
  gui.text(594, 41, spdiv)
 end

 gui.text(0, 120, "PID: ")
 if shinyCheck < 8 then
  gui.text(50, 120, string.format("%08X", personality), "LIMEGREEN")
 else
  gui.text(50, 120, string.format("%08X", personality))
 end
 gui.text(0, 140, "Nature: "..naturename[nature + 1])
 gui.text(0, 160, natureorder[natinc + 1].."+ "..natureorder[natdec + 1].."-")
 gui.text(487, 56, "HP "..typeorder[hidpowtype + 1].." "..hidpowbase)
end

function showMoves()
 if mword(moveStart) + 1 <= 355 then
  gui.text(0, 190, "Move: "..movename[mword(moveStart) + 1])
 end
 if mword(moveStart + 2) + 1 <= 355 then
  gui.text(0, 210, "Move: "..movename[mword(moveStart + 2) + 1])
 end
 if mword(moveStart + 4) + 1 <= 355 then
  gui.text(0, 230, "Move: "..movename[mword(moveStart + 4) + 1])
 end
 if mword(moveStart + 6) + 1 <= 355 then
  gui.text(0, 250, "Move: "..movename[mword(moveStart + 6) + 1])
 end
end

function showPP()
 gui.text(225, 190, "PP: "..mbyte(ppStart))
 if mbyte(ppStart) >= 1 and mbyte(ppStart) <= 4 then
  gui.text(265, 190, mbyte(ppStart), "orange")
 elseif mbyte(ppStart) < 1 then
  gui.text(265, 190, mbyte(ppStart), "red")
 else
  gui.text(265, 190, mbyte(ppStart))
 end
 gui.text(225, 210, "PP: ")
 if mbyte(ppStart + 1) >= 1 and mbyte(ppStart + 1) <= 4 then
  gui.text(265, 210, mbyte(ppStart + 1), "orange")
 elseif mbyte(ppStart + 1) < 1 then
  gui.text(265, 210, mbyte(ppStart + 1), "red")
 else
  gui.text(265, 210, mbyte(ppStart + 1))
 end
 gui.text(225, 230, "PP: ")
 if mbyte(ppStart + 2) >= 1 and mbyte(ppStart + 2) <= 4 then
  gui.text(265, 230, mbyte(ppStart + 2), "orange")
 elseif mbyte(ppStart + 2) < 1 then
  gui.text(265, 230, mbyte(ppStart + 2), "red")
 else
  gui.text(265, 230, mbyte(ppStart + 2))
 end
 gui.text(225, 250, "PP: ")
 if mbyte(ppStart + 3) >= 1 and mbyte(ppStart + 3) <= 4 then
  gui.text(265, 250, mbyte(ppStart + 3), "orange")
 elseif mbyte(ppStart + 3) < 1 then
  gui.text(265, 250, mbyte(ppStart + 3), "red")
 else
  gui.text(265, 250, mbyte(ppStart + 3))
 end
end

function showrngInfo()
 gui.text(0, 403, frame)
 gui.text(0, 423, "Initial Seed: "..string.format("%04X", initSeed))
 gui.text(0, 443, "Current Seed: "..string.format("%08X", currSeed))
end

function showtrainerInfo()
 gui.text(618, 443, string.format("TID: %d", tid))
 gui.text(618, 463, string.format("SID: %d", sid))
end

function setinitseed()
 frame = userdata.get("frame")
 tempCurr = userdata.get("temp")
 tempInit = mword(0x02020000)
end

event.onloadstate(setinitseed)

while true do
 currSeed = mdword(0x03004748 + monInfo)
 screenCheck = mdword(0x02020004)
 statsScreen = screenCheck == 0x80784030 or screenCheck == 0x80574020

 key = input.get()
 if key["Number1"] and not prevKey["Number1"] then
  index = index - 1
  if index < 1 then
   index = 5
  end
 elseif key["Number2"] and not prevKey["Number2"] then
  index = index + 1
  if index > 5 then
   index = 1
  end
 end

 prevKey = key

 if (currSeed <= 0xFFFF and frame < 8) or currSeed == 0 then  -- start counting the Frame
  initSeed = currSeed										  -- when Initial Seed is generated
  tempCurr = initSeed
  frame = 0
 end

 tempCurr = next(tempCurr)
 frame = frame + calcFrameJump()

 if mode[index] == "Capture" then
  start = 0x030044F0 + monInfo
 elseif mode[index] == "Breeding" then
  partyCounter = mbyte(0x03004280 + monInfo) - 1
  eggpartypidStart = partyStart + partyCounter * 0x64
  start = eggpartypidStart
 elseif mode[index] == "Pokemon Info" then
  partyCounter = mbyte(0x03004280 + monInfo) - 1
  partyScreen = screenCheck == 0x80080015 - partyscreenOff or screenCheck == 0x80080018 - partyscreenOff or screenCheck == 0x80080019 - partyscreenOff
  partyCursor = mbyte(0x020200BA + (0x88 * partyCounter))
  boxNum = mbyte(0x0202FDBC + startboxInfo)
  boxStart = 0x0202FDBC + startboxInfo + 4
  boxPosition = mbyte(0x02038201 + startboxInfo)
  boxpidStart = boxStart + (0x1E * boxNum * 0x50) + (boxPosition * 0x50)
  boxCheck = mdword(currentboxpidSelected) == mdword(boxpidStart) and (mword(0x02020008) == 0x6680 or mword(0x02020008) == 0x6690)

  if boxCheck and not partyScreen then
   start = boxpidStart
  elseif partyScreen then
   if partyCursor ~= 0x7 then
    start = partyStart + partyCursor * 0x64
   end
  elseif statsScreen then
   start = 0x02018010
  end
 end

 personality = mdword(start)
 trainerid = mdword(start + 4)
 isEgg = mword(start + 0x12) == 0x0601
 magicword = bxor(personality, trainerid)

 if mode[index] == "Pokemon Info" then
  tid = trainerid % 0x10000
  sid = floor(trainerid / 65536)
 else
  ids = mdword(0x02024C0E + pointers)
  tid = ids % 0x10000
  sid = floor(ids / 65536)
 end

 highPid = math.floor(personality / 65536)
 lowPid = personality % 0x10000
 shinyCheck = bxor(bxor(sid, tid), bxor(lowPid, highPid))

 i = personality % 24

 if i >= 18 then
  miscoffset = 0
 elseif i % 6 >= 4 then
  miscoffset = 12
 elseif i % 2 == 1 then
  miscoffset = 24
 else
  miscoffset = 36
 end

 ivs = bxor(mdword(start + 32 + miscoffset + 4), magicword)

 hpiv = band(ivs, 0x1F)
 atkiv = band(ivs, 0x1F * 0x20) / 0x20
 defiv = band(ivs, 0x1F * 0x400) / 0x400
 spdiv = band(ivs, 0x1F * 0x8000) / 0x8000
 spatkiv = band(ivs, 0x1F * 0x100000) / 0x100000
 spdefiv = band(ivs, 0x1F * 0x2000000) / 0x2000000

 nature = personality % 25
 natinc = floor(nature / 5)
 natdec = nature % 5

 hidpowtype=floor(((hpiv%2 + 2*(atkiv%2) + 4*(defiv%2) + 8*(spdiv%2) + 16*(spatkiv%2) + 32*(spdefiv%2))*15)/63)
 hidpowbase=floor(((band(hpiv,2)/2 + band(atkiv,2) + 2*band(defiv,2) + 4*band(spdiv,2) + 8*band(spatkiv,2) + 16*band(spdefiv,2))*40)/63 + 30)

 gui.text(2, 1, "Mode: "..mode[index])

 if mode[index] == "Capture" then
  battleScreen = mdword(0x0600D000) ~= 0 and mdword(0x0600CFFC) == 0
  roamerCheck = mdword(0x020285DC + pointers)

  if battleScreen and not statsScreen then
   showStats()
   showhiddenInfo()
   showMoves()
   showPP()
  end

  if roamerCheck == 0 then 
   gui.text(566, 120, string.format("Roamer? No"))
  else
   gui.text(566, 120, string.format("Roamer? Yes"))
   gui.text(566, 140, string.format("PID: %08X", roamerCheck))
   gui.text(566, 160, "Nature: "..naturename[(roamerCheck % 25) + 1])
  end

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Breeding" then
  eggstepCounter = mbyte(0x02028544 + pointers)
  eggReady = mbyte(0x020266C4 + pointers) == 0xCC or mbyte(0x020266C4 + pointers) == 0xFE
  gui.text(2, 190, "Step Counter: "..eggstepCounter)

  if eggReady then
   egglowPid = mword(0x02028548 + pointers)
   gui.text(2, 210, "Egg generated, go get it!")
   gui.text(2, 230, string.format("Egg lower PID: %04X", egglowPid))
  elseif eggstepCounter == 254 then
   gui.text(2, 210, "Next step might generate an egg!")
  elseif eggstepCounter == 255 then
   gui.text(2, 210, "255th step taken")
  else
   gui.text(2, 210, "Keep on steppin'")
  end

  if not eggReady then
   gui.text(2, 230, "No Egg")
  end

  if isEgg then
   showStats()
   showhiddenInfo()
  end

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pandora" then
  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pokemon Info" then
  if (partyScreen and partyCursor ~= 0x7) or statsScreen or boxCheck then
   if not boxCheck then
    showStats()
   end
   showhiddenInfo()
   showtrainerInfo()
  end
 end

 emu.frameadvance()
end
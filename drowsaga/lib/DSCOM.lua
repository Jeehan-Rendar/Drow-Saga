
drowSagaTextDefault = {
	drow = [[Drow]],
	elf_or_drow = [[Elfe ou Drow]],
	elf = [[Elfe]],
	subrace_title = [[SOUS-RACE]],
	subraces_title = [[SOUS-RACES]],
	choose_subrace = [[CHOISIR UNE SOUS-RACE]],
	drow_button = [[DROW]],
	drow_desc = [[DROWS : Les drows, ou elfes noirs, sont une branche du peuple elfique adaptée depuis des générations à la vie dans l'Ombre-Terre. Leur peau sombre, leurs cheveux généralement blancs et leur forte affinité avec la magie les distinguent nettement de leurs cousins de la surface.

Leur société est violente, profondément hiérarchisée et dominée par de puissantes maisons matriarcales. Les prêtresses de Lolth, la Reine-Araignée, y occupent une place centrale, tandis qu'intrigues, rivalités et luttes de pouvoir rythment la vie des cités drows. La faiblesse y est rarement pardonnée, et la soumission à cet ordre est souvent une question de survie.

Quelques renégats, fugitifs et parias refusent pourtant cette existence et cherchent à fuir l'emprise de Lolth pour gagner la surface. Mais ils y trouvent rarement une liberté totale : pour beaucoup d'habitants de la surface, un drow reste un être dangereux et malveillant, condamné à vivre en marge des deux mondes.

Les drows disposent des traits suivants :
- +2 en Dextérité ; -1 en Constitution ; +1 en Intelligence.
- 50 % de résistance à la magie.
- +1 au TAC0 avec les arcs, les épées longues et les épées courtes.
- Infravision.
- Ne reçoivent que 90 % de l'expérience normalement acquise.
- Réputation initiale réduite de 2.
- Sensibilité à la lumière : en extérieur et de jour, +1 au TAC0 et +1 à tous les jets de sauvegarde.
- Au niveau 9, l'acclimatation à la surface supprime définitivement ces pénalités.]],
}
if not drowSagaTextLoaded then
	drowSagaTextLoaded = true
	if Infinity_DoFile then pcall(function() Infinity_DoFile("DSTXT") end) end
end
function drowSagaT(key)
	local v = drowSagaText and drowSagaText[key]
	if type(v) == "string" and v ~= "" then return v end
	return drowSagaTextDefault[key] or key
end

function drowSagaSavePathBasename(path)
	if type(path) ~= "string" or path == "" then return nil end
	local normalized = string.gsub(path, "\\", "/")
	return string.match(normalized, "([^/]+)$")
end

function drowSagaApplyDefaultAppearanceIfNeeded()
	if e:GetActiveEngine() ~= createCharScreen then
		return
	end
	if not drowSagaIsChargenDrow() or drowSagaDefaultAppearanceApplied then
		return
	end

	SLIDER_color_hair = 0
	SLIDER_color_skin = 43
	Infinity_SetHairColor(SLIDER_color_hair)
	Infinity_SetSkinColor(SLIDER_color_skin)
	drowSagaDefaultAppearanceApplied = true
end

function drowSagaSetCanonicalIdentityOnPlayer1()
	C:SetGlobal("DS_DROW_FRESH_BOOTSTRAP","GLOBAL",1)
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW","LOCALS",1))')
	C:Eval('ApplySpellRES("DSDROWID",Player1)')
	C:SetGlobal("DS_UI_DROW","GLOBAL",1)
	C:SetGlobal("DS_DROW_PENDING","GLOBAL",0)
end

function drowSagaPendingVar()
	local k = tonumber(drowSagaPartySlot) or 1
	if k >= 2 and k <= 6 then return "DS_DROW_PENDING_" .. k end
	return "DS_DROW_PENDING"
end

function drowSagaSelectPartySlot(slot)
	local k = tonumber(slot)
	if k and k >= 1 and k <= 6 then drowSagaPartySlot = k end
end

function drowSagaUiMirrorOfSlot(k)
	local v
	if k == 1 then v = Infinity_GetScriptVarInt("DS_UI_DROW")
	else v = Infinity_GetScriptVarInt("DS_UI_DROW_" .. k) end
	return (tonumber(v) == 1) and 1 or 0
end

function drowSagaPortraitName(i)
	local ok, tip = pcall(Infinity_GetPortraitTooltip, i)
	if not ok or type(tip) ~= "string" then return nil end
	return tip:match("[^\r\n]+")
end

function drowSagaUiViconiaOfCharacter(char)
	if not char or not char.name then return false end
	local n = tonumber(Infinity_GetNumCharacters and Infinity_GetNumCharacters() or 0) or 0
	local any = false
	for i = 0, math.min(n, 6) - 1 do
		if drowSagaPortraitName(i) == char.name then
			if tonumber(Infinity_GetScriptVarInt("DS_UI_VIC_" .. (i + 1))) ~= 1 then return false end
			any = true
		end
	end
	return any
end

local function drowSagaProfIndex(id)
	if type(chargen) ~= "table" or type(chargen.proficiency) ~= "table" then return nil end
	for i, p in ipairs(chargen.proficiency) do
		if type(p) == "table" and tonumber(p.id) == id then return i, p end
	end
	return nil
end

function drowSagaApplyHeritageMark()
	if type(chargen) ~= "table" or chargen.levelingUp then return false end
	local okStep, step = pcall(function() return createCharScreen:GetCurrentStep() end)
	if okStep and const and step == const.STEP_DUALCLASS_PROFICIENCIES then return false end
	local want = drowSagaIsChargenDrow() and drowSagaMarkProf or drowSagaReserveProf
	local other = (want == drowSagaMarkProf) and drowSagaReserveProf or drowSagaMarkProf
	local _, po = drowSagaProfIndex(other)
	if po and (tonumber(po.value) or 0) > 0 then
		createCharScreen:OnProficiencyPlusMinusButtonClick(other, false)
	end
	local _, pw = drowSagaProfIndex(want)
	if pw and (tonumber(pw.value) or 0) == 0 and (tonumber(chargen.extraProficiencySlots) or 0) > 0 then
		createCharScreen:OnProficiencyPlusMinusButtonClick(want, true)
	end
	return true
end

function drowSagaBuildProfTable()
	local t = {}
	local list = (type(chargen) == "table" and type(chargen.proficiency) == "table") and chargen.proficiency or {}
	local n = #list
	local hidden = 0
	for i = n, 1, -1 do
		local id = type(list[i]) == "table" and tonumber(list[i].id) or nil
		if id == drowSagaMarkProf or id == drowSagaReserveProf then hidden = hidden + 1 else break end
	end
	for i = 1, n - hidden do t[i] = list[i] end
	drowSagaProfTable = t
	return t
end

function drowSagaBioRaceOn()
	local o = drowSagaText and drowSagaText.bio_old
	local n = drowSagaText and drowSagaText.bio_new
	return type(o) == "string" and o ~= "" and type(n) == "string" and n ~= ""
end

function drowSagaBioRaceText(text, toDrow)
	if type(text) ~= "string" or not drowSagaBioRaceOn() then return text end
	local from = toDrow and drowSagaText.bio_old or drowSagaText.bio_new
	local to = toDrow and drowSagaText.bio_new or drowSagaText.bio_old
	local i, j = string.find(text, from, 1, true)
	if not i then return text end
	if toDrow then drowSagaBioDrowApplied = true end
	return string.sub(text, 1, i - 1) .. to .. string.sub(text, j + 1)
end

function drowSagaChargenBioRaceSync()
	createBioEdit = drowSagaBioRaceText(createBioEdit or "", drowSagaIsChargenDrow())
end

function drowSagaChargenBioRaceCommit()
	if not drowSagaBioRaceOn() then return end
	if createCharScreen:GetImportState() ~= 0 then return end
	local d = drowSagaIsChargenDrow()
	if not d and not drowSagaBioDrowApplied then return end
	createCharScreen:OnBiographyButtonClick()
	createBioEdit = drowSagaBioRaceText(createBioEdit or "", d)
	createCharScreen:OnDoneButtonClick()
	drowSagaBioDrowApplied = false
end

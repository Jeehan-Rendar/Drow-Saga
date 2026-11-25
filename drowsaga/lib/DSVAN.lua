if Infinity_DoFile then Infinity_DoFile("DSCOM") end

drowSagaSubraces = {
	{name = drowSagaT("elf"), id = 1},
	{name = drowSagaT("drow"), id = 2,
	 desc = drowSagaT("drow_desc")}
}

drowSagaSubraceSelected = drowSagaSubraceSelected or 1
drowSagaSubracePending = drowSagaSubraceSelected
drowSagaChargenIsDrow = drowSagaChargenIsDrow or false
drowSagaDefaultAppearanceApplied = drowSagaDefaultAppearanceApplied or false
drowSagaImportRecapMode = drowSagaImportRecapMode or false
drowSagaSavedImportRecapDrow = drowSagaSavedImportRecapDrow or false
drowSagaSodFixedSaveResolved = drowSagaSodFixedSaveResolved or false
drowSagaSodFixedSaveDrow = drowSagaSodFixedSaveDrow or false
drowSagaSodFixedSaveNeedsEarlyRepair = drowSagaSodFixedSaveNeedsEarlyRepair or false
drowSagaFixedSaveIdentity = drowSagaFixedSaveIdentity or {}
drowSagaFixedSaveNeedsEarlyRepair = drowSagaFixedSaveNeedsEarlyRepair or {}

if not drowSagaSaveIndexLoaded then
	drowSagaSaveIndexLoaded = true
	if Infinity_DoFile then pcall(function() Infinity_DoFile("DSIDX") end) end
end





drowSagaFreshNativeChargen = drowSagaFreshNativeChargen or false

function drowSagaRecordFreshEarlySlotIdentity()
	if drowSagaFreshNativeChargen ~= true then return false end
	drowSagaFreshNativeChargen = false
	local state = (Infinity_GetScriptVarInt("DS_UI_DROW") == 1) and 1 or 2
	pcall(drowSagaRegFreshWorld, state)
	return true
end


drowSagaSaveImportTxnSection = "Drow Saga Save Import Transaction v1"

function drowSagaWriteSaveImportTxn(identity, needsEarlyRepair, protagonistHash)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "ACTIVE", 1)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "DROW", tonumber(identity) or 3)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "EARLY", needsEarlyRepair and 1 or 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "PNH", tonumber(protagonistHash) or 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "ID", tonumber(identity) or 3)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "E0", needsEarlyRepair and 1 or 0)
end

function drowSagaClearSaveImportTxn()
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "ACTIVE", 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "DROW", 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "EARLY", 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "PNH", 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "ID", 0)
	Infinity_SetINIValue(drowSagaSaveImportTxnSection, "E0", 0)
end

function drowSagaRestoreSaveImportTxn()
	if tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "ACTIVE", 0)) ~= 1 then return false end
	local state = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "DROW", 0)) or 0
	if state ~= 1 and state ~= 2 and state ~= 3 then return false end
	local early = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "EARLY", 0)) == 1
	local isDrow = (state == 1)
	drowSagaSaveRecapActive = true
	drowSagaSaveRecapDrow = isDrow
	drowSagaSaveRecapUnknown = (state == 3)
	drowSagaSaveRecapNeedsEarlyRepair = (isDrow and early)
	drowSagaSodFixedSaveResolved = true
	drowSagaSodFixedSaveDrow = isDrow
	drowSagaSodFixedSaveNeedsEarlyRepair = (isDrow and early)
	drowSagaSavedImportRecapDrow = isDrow
	drowSagaImportRecapMode = true
	return true
end

function drowSagaCaptureFixedSaveIdentityCore()
	drowSagaChrRecapActive = false
	drowSagaChrSelectionCommitted = false
	drowSagaChargenIsDrow = false
	drowSagaSubraceSelected = 1
	drowSagaSubracePending = 1
	drowSagaSavedImportRecapDrow = false
	drowSagaSodFixedSaveResolved = false
	drowSagaSodFixedSaveDrow = false
	drowSagaSodFixedSaveNeedsEarlyRepair = false
	drowSagaSaveRecapActive = false
	drowSagaSaveRecapDrow = false
	drowSagaSaveRecapUnknown = false
	drowSagaSaveRecapNeedsEarlyRepair = false
	local v = nil
	if currentSave and gameSaves and gameSaves.files then v = gameSaves.files[currentSave] end
	if not v or type(v.fileName) ~= "string" then return false end
	local wanted = drowSagaSavePathBasename(v.fileName)
	if not wanted then return false end
	wanted = string.upper(wanted)

	pcall(drowSagaRegReconcile)
	local id, early = nil, false
	local okR, rid, rearly = pcall(drowSagaRegResolve, v)
	if okR and rid then id, early = rid, (rearly == true) end
	if id == nil then
		local state = drowSagaFixedSaveIdentity[wanted]
		if state ~= nil then
			id = (state == true) and 1 or 2
			early = (state == true and drowSagaFixedSaveNeedsEarlyRepair[wanted] == true)
		end
	end
	if id == nil then id = 3 end
	local isDrow = (id == 1)
	drowSagaSodFixedSaveResolved = true
	drowSagaSodFixedSaveDrow = isDrow
	drowSagaSodFixedSaveNeedsEarlyRepair = (isDrow and early)
	drowSagaSaveRecapActive = true
	drowSagaSaveRecapDrow = isDrow
	drowSagaSaveRecapUnknown = (id == 3)
	drowSagaSaveRecapNeedsEarlyRepair = (isDrow and early)
	if gameSaves and gameSaves.isImporting == 1 then
		drowSagaWriteSaveImportTxn(id, isDrow and early, drowSagaNameKey(v.sName))
	end
	return true
end

drowSagaEarlySodRepairPending = drowSagaEarlySodRepairPending or false
drowSagaChrRecapActive = drowSagaChrRecapActive or false
drowSagaChrSelectionCommitted = drowSagaChrSelectionCommitted or false
drowSagaSaveRecapActive = drowSagaSaveRecapActive or false
drowSagaSaveRecapDrow = drowSagaSaveRecapDrow or false
drowSagaSaveRecapNeedsEarlyRepair = drowSagaSaveRecapNeedsEarlyRepair or false

function drowSagaBeginCharacterFileImport()
	drowSagaChrRecapActive = true
	drowSagaChrSelectionCommitted = false
	drowSagaClearSaveImportTxn()
	drowSagaChrImportSelectedIndex = nil
	drowSagaChrImportIndexResolved = false
	drowSagaChrImportExactDrow = false
end

function drowSagaCommitCharacterFileSelection()
	drowSagaClearSaveImportTxn()
	drowSagaChrSelectionCommitted = true
	drowSagaChargenIsDrow = false
	drowSagaSubraceSelected = 1
	drowSagaSubracePending = 1
	drowSagaSodFixedSaveResolved = false
	drowSagaSodFixedSaveDrow = false
	drowSagaSodFixedSaveNeedsEarlyRepair = false
	drowSagaSaveRecapActive = false
	drowSagaSaveRecapDrow = false
	drowSagaSaveRecapUnknown = false
	drowSagaSaveRecapNeedsEarlyRepair = false
	drowSagaSavedImportRecapDrow = false
	drowSagaEarlySodRepairPending = false
	drowSagaImportRecapMode = true
end

function drowSagaArmSodSaveImportContext()
	drowSagaRestoreSaveImportTxn()
	local isSaveImport = (drowSagaImportRecapMode == true and drowSagaSodFixedSaveResolved == true)
	drowSagaEarlySodRepairPending = (isSaveImport and drowSagaSodFixedSaveDrow == true and drowSagaSodFixedSaveNeedsEarlyRepair == true)

	if isSaveImport and drowSagaSodFixedSaveDrow == true and drowSagaSodFixedSaveNeedsEarlyRepair ~= true then
		C:SetGlobal("DS_SOD_SAVE_IMPORT_CONTEXT","GLOBAL",1)
	else
		C:SetGlobal("DS_SOD_SAVE_IMPORT_CONTEXT","GLOBAL",0)
	end
end

function drowSagaConsumeEarlySodRepairPending()
	if drowSagaEarlySodRepairPending ~= true then return end
	drowSagaEarlySodRepairPending = false

	C:Eval('ApplySpellRES("DSDROWID",Player1)')
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW","LOCALS",1))')
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW_STATS_APPLIED","LOCALS",0))')
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW_MR_APPLIED","LOCALS",0))')
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW_XP_APPLIED","LOCALS",0))')
	C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW_THIEF_OFFSETS_APPLIED","LOCALS",0))')
	C:SetGlobal("DS_UI_DROW","GLOBAL",1)
	C:SetGlobal("DS_DROW_EARLY_REPAIR","GLOBAL",1)
end

function drowSagaCommitSubraceChoice()
	drowSagaSubraceSelected = drowSagaSubracePending or 1
	drowSagaChargenIsDrow = (drowSagaSubraceSelected == 2)

	if drowSagaChargenIsDrow then
		drowSagaSetPending(1)
	else
		drowSagaSetPending(0)
	end
end

function drowSagaPrepareRaceDone()
	local race = currentChargenRace and chargen.races[currentChargenRace] or nil
	if not race or race.id ~= 2 then
		drowSagaSubraceSelected = 1
		drowSagaSubracePending = 1
		drowSagaChargenIsDrow = false
		drowSagaSetPending(0)
	end
end

function drowSagaWorldBootstrapDrow()
	if Infinity_GetScriptVarInt("DS_DROW_PENDING") == 1 then
		drowSagaSetCanonicalIdentityOnPlayer1()
	end
	pcall(function()
		for k = 2, 6 do
			if Infinity_GetScriptVarInt("DS_DROW_PENDING_" .. k) == 1 then
				C:SetGlobal("DS_DROW_FRESH_" .. k, "GLOBAL", 1)
				C:Eval('ActionOverride(Player' .. k .. ',SetGlobal("DS_DROW","LOCALS",1))')
				C:Eval('ApplySpellRES("DSDROWID",Player' .. k .. ')')
			end
		end
	end)

	if drowSagaFreshChrImportRepRearm == true then
		C:Eval('ActionOverride(Player1,SetGlobal("DS_DROW_REP_APPLIED","LOCALS",0))')
		drowSagaFreshChrImportRepRearm = false
	end
end

drowSagaChrFilePassportSection = "Drow Saga CHR File Passport v1"
drowSagaChrIndexCacheSection = "Drow Saga CHR Index Cache v1"
drowSagaChrImportSelectedIndex = drowSagaChrImportSelectedIndex or nil
drowSagaChrImportIndexResolved = drowSagaChrImportIndexResolved or false
drowSagaChrImportExactDrow = drowSagaChrImportExactDrow or false

function drowSagaChrFileKey(filename)
	if type(filename) ~= "string" or filename == "" then return nil end
	filename = string.gsub(filename, "\\", "/")
	filename = string.match(filename, "([^/]+)$") or filename
	filename = string.gsub(filename, "%.[Cc][Hh][Rr]$", "")
	filename = string.upper(filename)
	if filename == "" then return nil end
	local h = ""
	for i = 1, #filename do
		h = h .. string.format("%02X", string.byte(filename, i))
	end
	return "F" .. h
end

function drowSagaChrPassportState(filename)
	local key = drowSagaChrFileKey(filename)
	if not key then return nil end
	local state = tonumber(Infinity_GetINIValue(drowSagaChrFilePassportSection, key, -1))
	if state == 0 or state == 1 then return state end
	return nil
end

function drowSagaRefreshVanillaChrIndexCache()
	local list = list_GUICG_20_2
	if type(list) ~= "table" then return false end
	for i, filename in ipairs(list) do
		local state = drowSagaChrPassportState(filename)
		Infinity_SetINIValue(drowSagaChrIndexCacheSection, "I" .. tostring(i), state == nil and -1 or state)
	end
	Infinity_SetINIValue(drowSagaChrIndexCacheSection, "COUNT", #list)
	return true
end

function drowSagaSelectVanillaChrImportIndex(index, shownCount)
	drowSagaChrImportSelectedIndex = tonumber(index)
	drowSagaChrImportIndexResolved = false
	drowSagaChrImportExactDrow = false
	if not drowSagaChrImportSelectedIndex or drowSagaChrImportSelectedIndex < 1 then return false end
	shownCount = tonumber(shownCount)
	local list = (type(list_GUICG_20_2) == "table") and list_GUICG_20_2 or nil
	if shownCount and list and #list ~= shownCount then list = nil end

	local filename = nil
	if list then
		filename = list[drowSagaChrImportSelectedIndex]
	end
	local state = drowSagaChrPassportState(filename)

	if state == nil then
		local count = tonumber(Infinity_GetINIValue(drowSagaChrIndexCacheSection, "COUNT", -1))
		if not shownCount or count == shownCount then
			state = tonumber(Infinity_GetINIValue(drowSagaChrIndexCacheSection, "I" .. tostring(drowSagaChrImportSelectedIndex), -1))
		end
	end
	if state == 0 or state == 1 then
		drowSagaChrImportExactDrow = (state == 1)
		drowSagaChrImportIndexResolved = true
		return true
	end
	return false
end

function drowSagaRegisterVanillaChrExport(filename, explicitDrow)
	if type(filename) ~= "string" or filename == "" then return false end
	local key = drowSagaChrFileKey(filename)
	if not key then return false end
	local isDrow = explicitDrow
	if isDrow == nil then
		if CurrentlyInGame and CurrentlyInGame() then
			isDrow = tonumber(Infinity_GetScriptVarInt("DS_UI_DROW") or 0) == 1
		else
			isDrow = drowSagaIsChargenDrow()
		end
	end
	Infinity_SetINIValue(drowSagaChrFilePassportSection, key, isDrow and 1 or 0)
	drowSagaRefreshVanillaChrIndexCache()
	return true
end

function drowSagaApplyExactChrImportPresentation()
	if drowSagaChrImportIndexResolved ~= true then return false end
	drowSagaSavedImportRecapDrow = false
	drowSagaChargenIsDrow = (drowSagaChrImportExactDrow == true)
	drowSagaSubraceSelected = drowSagaChargenIsDrow and 2 or 1
	drowSagaSubracePending = drowSagaSubraceSelected
	drowSagaImportRecapMode = true
	return true
end





function drowSagaFinishImportedCharacterUiBridge()
	if drowSagaChrRecapActive == true then
		drowSagaSavedImportRecapDrow = false
		if drowSagaApplyExactChrImportPresentation() then return end
		drowSagaStartImportedBiographyProbe()
		return
	end

	drowSagaSavedImportRecapDrow = false
	drowSagaChargenIsDrow = false
	drowSagaSubraceSelected = 1
	drowSagaSubracePending = 1
end

drowSagaBioMarker = "[[DROW_SAGA:UI_DROW=1]]"
drowSagaBioProbeMode = false
drowSagaBioWriteMode = false
drowSagaBioProbeClosePending = false
drowSagaBioProbeUIHidden = false

function drowSagaBioHasMarker(text)
	return type(text) == "string" and string.find(text, drowSagaBioMarker, 1, true) ~= nil
end

function drowSagaBioStripMarker(text)
	if type(text) ~= "string" then return "" end
	return string.gsub(text, "%[%[DROW_SAGA:UI_DROW=1%]%]", "")
end

function drowSagaBioEnsureMarker(text)
	text = drowSagaBioStripMarker(text or "")
	if text ~= "" and string.sub(text, -1) ~= "\n" then
		text = text .. "\n"
	end
	return text .. drowSagaBioMarker
end

function drowSagaVisibleBiography(text)
	return drowSagaBioStripMarker(text)
end

function drowSagaChargenBiographyOpen()
	if drowSagaBioProbeMode then
		local raw = createBioEdit or ""
		local isDrow = drowSagaBioHasMarker(raw)

		drowSagaChargenIsDrow = isDrow
		if isDrow then
			drowSagaSubraceSelected = 2
			drowSagaSubracePending = 2
		else
			drowSagaSubraceSelected = 1
			drowSagaSubracePending = 1
		end

		drowSagaBioProbeMode = false
		drowSagaBioProbeClosePending = true
		drowSagaBioProbeUIHidden = true
	else
		createBioEdit = drowSagaBioStripMarker(createBioEdit or "")
		if drowSagaBioRaceText and createCharScreen:GetImportState() == 0 then
			createBioEdit = drowSagaBioRaceText(createBioEdit, drowSagaIsChargenDrow())
		end
		if not drowSagaBioWriteMode then
			drowSagaBioProbeUIHidden = false
		end
	end
end

function drowSagaChargenBiographyDone()
	if drowSagaIsChargenDrow() then
		createBioEdit = drowSagaBioEnsureMarker(createBioEdit or "")
	else
		createBioEdit = drowSagaBioStripMarker(createBioEdit or "")
	end
	createCharScreen:OnDoneButtonClick()
end

function drowSagaStartImportedBiographyProbe()
	drowSagaSavedImportRecapDrow = false
	drowSagaChargenIsDrow = false
	drowSagaBioProbeMode = true
	drowSagaBioProbeClosePending = false
	drowSagaBioProbeUIHidden = true

	createBioEdit = ""
	createCharScreen:OnBiographyButtonClick()
end

function drowSagaBioProbeAutoClose()
	if drowSagaBioProbeClosePending then
		drowSagaBioProbeClosePending = false
		createCharScreen:OnCancelButtonClick()
		drowSagaBioProbeUIHidden = false
	end
	return false
end

function drowSagaAcceptCharacterWithBiographyPassport()
	local isDrow = drowSagaIsChargenDrow()
	local isCharacterFileImport = (createCharScreen:GetImportState() == 1)

	if isDrow then
		drowSagaBioProbeMode = false
		drowSagaBioWriteMode = true
		drowSagaBioProbeUIHidden = true
		createCharScreen:OnBiographyButtonClick()
		if drowSagaBioRaceText and not isCharacterFileImport then
			createBioEdit = drowSagaBioRaceText(createBioEdit or "", true)
		end
		createBioEdit = drowSagaBioEnsureMarker(createBioEdit or "")
		createCharScreen:OnDoneButtonClick()
		drowSagaBioWriteMode = false
		drowSagaBioProbeUIHidden = false
	elseif drowSagaBioDrowApplied and not isCharacterFileImport and drowSagaBioRaceOn and drowSagaBioRaceOn() then
		drowSagaBioWriteMode = true
		drowSagaBioProbeUIHidden = true
		createCharScreen:OnBiographyButtonClick()
		createBioEdit = drowSagaBioRaceText(drowSagaBioStripMarker(createBioEdit or ""), false)
		createCharScreen:OnDoneButtonClick()
		drowSagaBioWriteMode = false
		drowSagaBioProbeUIHidden = false
		drowSagaBioDrowApplied = false
	end

	drowSagaFreshChrImportRepRearm = (isDrow and isCharacterFileImport)

	createCharScreen:AcceptCharacter(-1)
end

function drowSagaRecordBiographyOpen()
	drowSagaBioHadMarker = drowSagaBioHasMarker(recBioEdit or "")
	recBioEdit = drowSagaBioStripMarker(recBioEdit or "")
	recBioEditBackup = recBioEdit
end

function drowSagaRecordBiographyDone()
	local dsOk, dsD = pcall(drowSagaUiDrowOfCharacter, characters and characters[currentID])
	if not dsOk then dsD = (Infinity_GetScriptVarInt("DS_UI_DROW") == 1) and 1 or 0 end
	if dsD == nil then dsD = (drowSagaBioHadMarker == true) and 1 or 0 end
	if dsD == 1 then
		recBioEdit = drowSagaBioEnsureMarker(recBioEdit or "")
	else
		recBioEdit = drowSagaBioStripMarker(recBioEdit or "")
	end
	characterScreen:OnDoneButtonClick()
	Infinity_PopMenu()
	currentPanelID = 17
end

function drowSagaIsChargenDrow()
	return drowSagaChargenIsDrow == true
end

function drowSagaAbilityDisplayRoll(row)
	local ability = chargen.ability and chargen.ability[row] or nil
	if not ability then
		return ""
	end

	local value = tonumber(ability.roll)
	if not value then
		return ability.roll
	end

	if drowSagaIsChargenDrow() and not drowSagaImportRecapMode and (row == 2 or row == 4) then
		value = value + 1
	end

	return value
end

local function drowSagaReplaceAbilityValue(info, row, delta)
	local ability = chargen.ability and chargen.ability[row] or nil
	if not ability then
		return info
	end

	local label = getUiString(ability.name)
	if not label or label == "" then
		return info
	end

	local labelStart, labelEnd = string.find(info, label, 1, true)
	if not labelStart then
		return info
	end

	local numberSearchStart = labelEnd + 1
	local windowEnd = math.min(#info, numberSearchStart + 48)
	local window = string.sub(info, numberSearchStart, windowEnd)
	local nStart, nEnd = string.find(window, "%d+")

	if not nStart then
		return info
	end

	local raw = tonumber(string.sub(window, nStart, nEnd))
	if not raw then
		return info
	end

	local absoluteStart = numberSearchStart + nStart - 1
	local absoluteEnd = numberSearchStart + nEnd - 1
	local adjusted = tostring(raw + delta)

	return string.sub(info, 1, absoluteStart - 1)
		.. adjusted
		.. string.sub(info, absoluteEnd + 1)
end

local drowSagaThiefFrLabels = { "Vol à la tire", "Crochetage des serrures", "Détection de pièges",
	"Déplacement silencieux", "Se cacher dans l'ombre", "Détection des illusions", "Pose de piège" }

local function drowSagaThiefLabel(info, row)
	local ok, name = pcall(function()
		local sk = chargen and chargen.thief_skill and chargen.thief_skill[row]
		return sk and sk.name and Infinity_FetchString(sk.name) or nil
	end)
	if ok and type(name) == "string" and name ~= "" and string.find(info, name, 1, true) then return name end
	return drowSagaThiefFrLabels[row]
end

local function drowSagaDexLabel(info)
	local ok, name = pcall(function()
		local ab = chargen and chargen.ability and chargen.ability[2]
		return ab and ab.name and getUiString(ab.name) or nil
	end)
	if ok and type(name) == "string" and name ~= "" and string.find(info, name, 1, true) then return name end
	return "Dextérité"
end

local function drowSagaReplaceLabeledNumber(info, label, delta)
	if not label or label == "" or not delta or delta == 0 then return info end
	local labelStart, labelEnd = string.find(info, label, 1, true)
	if not labelStart then return info end
	local numberSearchStart = labelEnd + 1
	local windowEnd = math.min(#info, numberSearchStart + 72)
	local window = string.sub(info, numberSearchStart, windowEnd)
	local nStart, nEnd = string.find(window, "%d+")
	if not nStart then return info end
	local raw = tonumber(string.sub(window, nStart, nEnd))
	if not raw then return info end
	local absoluteStart = numberSearchStart + nStart - 1
	local absoluteEnd = numberSearchStart + nEnd - 1
	return string.sub(info, 1, absoluteStart - 1) .. tostring(raw + delta) .. string.sub(info, absoluteEnd + 1)
end

local function drowSagaFixEarlySodThiefRecap(info)
	if not (drowSagaSodFixedSaveResolved == true and drowSagaSodFixedSaveDrow == true and drowSagaSodFixedSaveNeedsEarlyRepair == true) then
		return info
	end
	local engineDex = nil
	do
		local labelStart, labelEnd = string.find(info, drowSagaDexLabel(info), 1, true)
		if labelStart then
			local numberSearchStart = labelEnd + 1
			local window = string.sub(info, numberSearchStart, math.min(#info, numberSearchStart + 32))
			local nStart, nEnd = string.find(window, "%d+")
			if nStart then engineDex = tonumber(string.sub(window, nStart, nEnd)) end
		end
	end
	if not engineDex and chargen.ability and chargen.ability[2] then
		engineDex = tonumber(chargen.ability[2].roll)
	end
	if not engineDex then return info end

	local skillDex = {
		[9]  = {-15,-10,-10,-20,-10,0,-10}, [10] = {-10,-5,-10,-15,-5,0,-10},
		[11] = {-5,0,-5,-10,0,0,-5}, [12] = {0,0,0,-5,0,0,0},
		[13] = {0,0,0,0,0,0,0}, [14] = {0,0,0,0,0,0,0}, [15] = {0,0,0,0,0,0,0},
		[16] = {0,5,0,0,0,0,0}, [17] = {5,10,0,5,5,0,0},
		[18] = {10,15,5,10,10,0,5}, [19] = {15,20,10,15,15,0,10},
		[20] = {20,25,15,18,18,0,15}
	}
	if not (skillDex[engineDex] and skillDex[engineDex + 1]) then return info end

	local raceDelta = {-5, 5, 0, -5, -10, 0, 0}
	local deltas = {}
	for row = 1, 7 do
		deltas[row] = raceDelta[row] + skillDex[engineDex + 1][row] - skillDex[engineDex][row]
	end

	local labels = {
		{"Vol à la tire", 1},
		{"Crochetage des serrures", 2},
		{"Détection de pièges", 3},
		{"Déplacement silencieux", 4},
		{"Se cacher dans l'ombre", 5},
		{"Détection des illusions", 6},
		{"Pose de piège", 7},
	}
	for row = 1, 7 do
		info = drowSagaReplaceLabeledNumber(info, drowSagaThiefLabel(info, row), deltas[row])
	end
	return info
end

local function drowSagaFixNativeDrowThiefRecap(info)
	if drowSagaImportRecapMode == true or drowSagaChargenIsDrow ~= true then return info end
	local engineDex = nil
	do
		local labelStart, labelEnd = string.find(info, drowSagaDexLabel(info), 1, true)
		if labelStart then
			local numberSearchStart = labelEnd + 1
			local window = string.sub(info, numberSearchStart, math.min(#info, numberSearchStart + 32))
			local nStart, nEnd = string.find(window, "%d+")
			if nStart then engineDex = tonumber(string.sub(window, nStart, nEnd)) end
		end
	end
	if not engineDex and chargen.ability and chargen.ability[2] then engineDex = tonumber(chargen.ability[2].roll) end
	if not engineDex then return info end

	local skillDex = {
		[9]  = {-15,-10,-10,-20,-10,0,-10}, [10] = {-10,-5,-10,-15,-5,0,-10},
		[11] = {-5,0,-5,-10,0,0,-5}, [12] = {0,0,0,-5,0,0,0},
		[13] = {0,0,0,0,0,0,0}, [14] = {0,0,0,0,0,0,0}, [15] = {0,0,0,0,0,0,0},
		[16] = {0,5,0,0,0,0,0}, [17] = {5,10,0,5,5,0,0},
		[18] = {10,15,5,10,10,0,5}, [19] = {15,20,10,15,15,0,10},
		[20] = {20,25,15,18,18,0,15}
	}
	if not (skillDex[engineDex] and skillDex[engineDex + 1]) then return info end
	local raceDelta = {-5, 5, 0, -5, -10, 0, 0}
	local deltas = {}
	for row = 1, 7 do deltas[row] = raceDelta[row] + skillDex[engineDex + 1][row] - skillDex[engineDex][row] end
	local labels = {
		{"Vol à la tire", 1}, {"Crochetage des serrures", 2}, {"Détection de pièges", 3},
		{"Déplacement silencieux", 4}, {"Se cacher dans l'ombre", 5},
		{"Détection des illusions", 6}, {"Pose de piège", 7},
	}
	for row = 1, 7 do info = drowSagaReplaceLabeledNumber(info, drowSagaThiefLabel(info, row), deltas[row]) end
	return info
end

function drowSagaNeutralRaceInfo(info)
	local names = {}
	for _, race in ipairs(chargen.races or {}) do
		if race.id == 2 then table.insert(names, Infinity_FetchString(race.name)) break end
	end
	for _, l in ipairs({ "Elfe", "ELFE", "Elf", "ELF" }) do table.insert(names, l) end
	for _, l in ipairs(names) do
		if l and l ~= "" and string.find(info, l, 1, true) then
			local i, j = string.find(info, l, 1, true)
			return string.sub(info, 1, i - 1) .. drowSagaT("elf_or_drow") .. string.sub(info, j + 1)
		end
	end
	return info
end

function drowSagaChargenInformationCore()
	local info = chargen.information or ""

	if drowSagaImportRecapMode == true then drowSagaRestoreSaveImportTxn() end

	if drowSagaImportRecapMode == true then
		if drowSagaSaveRecapActive == true then
			drowSagaSavedImportRecapDrow = (drowSagaSaveRecapDrow == true)
		elseif drowSagaChrRecapActive == true and drowSagaChrSelectionCommitted == true then
			drowSagaSavedImportRecapDrow = false
		elseif drowSagaChrRecapActive ~= true then
			drowSagaSavedImportRecapDrow = false
		end
	end

	if drowSagaSaveRecapActive == true and drowSagaImportRecapMode == true then
		local okC, isOther = pcall(drowSagaImportedIsOtherMember)
		if okC and isOther ~= nil then pcall(drowSagaApplyMemberIdentity, isOther) end
	end

	if drowSagaSaveRecapActive == true and drowSagaSaveRecapUnknown == true then
		return drowSagaNeutralRaceInfo(info)
	end

	local showDrowRace = nil
	if drowSagaSaveRecapActive == true then
		showDrowRace = (drowSagaSaveRecapDrow == true)
	else
		showDrowRace = drowSagaIsChargenDrow() or (drowSagaSavedImportRecapDrow == true)
	end
	if not showDrowRace then
		return info
	end

	local elfName = nil
	for _, race in ipairs(chargen.races or {}) do
		if race.id == 2 then
			elfName = Infinity_FetchString(race.name)
			break
		end
	end

	local raceReplaced = false
	if elfName and elfName ~= "" then
		local replaced, n = string.gsub(info, elfName, (string.gsub(drowSagaT("drow"), "%%", "%%%%")), 1)
		if n > 0 then
			info = replaced
			raceReplaced = true
		end
	end

	if not raceReplaced then
		local variants = { "Elfe", "ELFE", "Elf", "ELF" }
		for _, label in ipairs(variants) do
			local replaced, n = string.gsub(info, label, (string.gsub(drowSagaT("drow"), "%%", "%%%%")), 1)
			if n > 0 then
				info = replaced
				break
			end
		end
	end

	if drowSagaSaveRecapActive == true and drowSagaSaveRecapDrow == true and drowSagaSaveRecapNeedsEarlyRepair == true then
		info = drowSagaFixEarlySodThiefRecap(info)
		info = drowSagaReplaceAbilityValue(info, 2, 1)
		info = drowSagaReplaceAbilityValue(info, 4, 1)
	elseif not drowSagaImportRecapMode then
		info = drowSagaFixNativeDrowThiefRecap(info)
		info = drowSagaReplaceAbilityValue(info, 2, 1)
		info = drowSagaReplaceAbilityValue(info, 4, 1)
	end

	return info
end


drowSagaPartySlot = drowSagaPartySlot or 1

function drowSagaSetPending(v)
	C:SetGlobal(drowSagaPendingVar(), "GLOBAL", v)
	drowSagaPartyButtonDrow = drowSagaPartyButtonDrow or {}
	drowSagaPartyButtonDrow[tonumber(drowSagaPartySlot) or 1] = (tonumber(v) == 1) and 1 or 0
end

function drowSagaResetPartySlots()
	drowSagaPartySlot = 1
	drowSagaPartyButtonDrow = {}
	C:SetGlobal("DS_DROW_PENDING", "GLOBAL", 0)
	for k = 2, 6 do C:SetGlobal("DS_DROW_PENDING_" .. k, "GLOBAL", 0) end
	C:SetGlobal("DS_DROW_PARTY_PENDING_ARMED", "GLOBAL", 0)
end

function drowSagaPartyRemapOnPlay()
	drowSagaPartyButtonDrow = drowSagaPartyButtonDrow or {}
	local values, rank = {}, 0
	for k = 1, 6 do
		local c = partyImport and partyImport.character and partyImport.character[k]
		if c and c.name ~= nil and c.name ~= "" then
			rank = rank + 1
			values[rank] = drowSagaPartyButtonDrow[k] or 0
		end
	end
	if rank == 0 then return false end
	for r = 1, 6 do
		local name = (r == 1) and "DS_DROW_PENDING" or ("DS_DROW_PENDING_" .. r)
		C:SetGlobal(name, "GLOBAL", values[r] or 0)
	end
	return true
end

function drowSagaPartyScreenDrowOf(char)
	local inGame = false
	pcall(function() inGame = (CurrentlyInGame() == true) end)
	if inGame then return false end
	if not (partyImport and partyImport.character and char and char.name) then return false end
	local found, v = 0, nil
	drowSagaPartyButtonDrow = drowSagaPartyButtonDrow or {}
	for k = 1, 6 do
		local c = partyImport.character[k]
		if c and c.name == char.name then
			found = found + 1
			local b = drowSagaPartyButtonDrow[k]
			if found == 1 then v = b elseif b ~= v then return nil end
		end
	end
	if found == 0 then return false end
	if v == 1 then return 1 elseif v == 0 then return 0 end
	return nil
end

function drowSagaPartyCreateDelete(k)
	drowSagaSelectPartySlot(k)
	local label = partyImport and partyImport.character and partyImport.character[k] and partyImport.character[k].createdelete
	local create = string.lower(tostring(getUiString and getUiString('CREATE_BUTTON') or ""))
	if label ~= nil and create ~= "" and string.lower(tostring(label)) ~= create then
		drowSagaSetPending(0)
	end
end

function drowSagaUiDrowOfCharacter(char)
	local n = tonumber(Infinity_GetNumCharacters and Infinity_GetNumCharacters() or 1) or 1
	if n <= 1 then
		return (Infinity_GetScriptVarInt("DS_UI_DROW") == 1) and 1 or 0
	end
	if not char or not char.name then return nil end
	local found = {}
	for i = 0, math.min(n, 6) - 1 do
		if drowSagaPortraitName(i) == char.name then table.insert(found, i + 1) end
	end
	if #found == 0 then return nil end
	local v = drowSagaUiMirrorOfSlot(found[1])
	for _, k in ipairs(found) do
		if drowSagaUiMirrorOfSlot(k) ~= v then return nil end
	end
	return v
end


drowSagaRegSection = "Drow Saga Registry v2"

local function RG(k, d) return tonumber(Infinity_GetINIValue(drowSagaRegSection, k, d or 0)) or (d or 0) end
local function RS(k, v) Infinity_SetINIValue(drowSagaRegSection, k, tonumber(v) or 0) end

function drowSagaSaveHash(text, multiplier)
	if type(text) ~= "string" then text = tostring(text or "") end
	local h, m = 0, tonumber(multiplier) or 131
	for i = 1, #text do h = ((h * m) + string.byte(text, i)) % 2147483647 end
	return h
end

function drowSagaNameKey(text)
	return drowSagaSaveHash(tostring(text or ""), 131) % 999983
end

function drowSagaSaveFolderNumber(base)
	if type(base) ~= "string" then return nil end
	return tonumber(string.match(base, "^(%d+)%-") or "")
end


function drowSagaRegKey(entry)
	if type(entry) ~= "table" or type(entry.fileName) ~= "string" then return nil end
	local base = drowSagaSavePathBasename(entry.fileName)
	local n = drowSagaSaveFolderNumber(base)
	if not n then return nil end
	local d = "C" .. drowSagaListCampaign()
	if n == 1 then
		local q = tonumber(string.match(base, "%-(%d+)$") or "")
		if not (q and q >= 2 and q <= 9) then q = 1 end
		return d .. "Q" .. q, n, d
	end
	return d .. "N" .. n, n, d
end


local function drowSagaRegIdentityOfWorld()
	return (tonumber(Infinity_GetScriptVarInt("DS_UI_DROW") or 0) == 1) and 1 or 2
end

function drowSagaCurrentCampaignTag()
	local ok, sod = pcall(function()
		return startEngine:GetCampaign() == const.START_CAMPAIGN_SOD
	end)
	return (ok and sod == true) and "S" or "B"
end

function drowSagaRegFreshWorldCore(identity)
	if identity ~= 1 and identity ~= 2 then return end
	local c = drowSagaCurrentCampaignTag()
	RS("LATEST" .. c, identity)
	RS("FRESH" .. c, 1)
end

function drowSagaRegWriteCore(name, overwriteEntry)
	drowSagaRegReconcileCore()
	local identity = drowSagaRegIdentityOfWorld()
	local key = overwriteEntry and drowSagaRegKey(overwriteEntry) or nil
	if key then RS("I" .. key, identity) end
	local k = RG("PN", 0) + 1
	RS("PN", k)
	RS("PI" .. k, identity)
	RS("PH" .. k, drowSagaNameKey(name))
	return true
end

function drowSagaRegReconcileCore()
	local list = gameSaves and gameSaves.files
	if type(list) ~= "table" then return false end
	local pend, pn, pendUsed = {}, RG("PN", 0), {}
	for k = 1, pn do
		local h, id = RG("PH" .. k, 0), RG("PI" .. k, 0)
		if pend[h] == nil then pend[h] = id elseif pend[h] ~= id then pend[h] = 3 end
	end
	local present, byKey, dirs, manualSeen, changedK, quickChanged, quickPresent = {}, {}, {}, {}, {}, {}, {}
	for _, v in ipairs(list) do
		local key, n, d = drowSagaRegKey(v)
		local init = key and RG("INIT" .. d, 0) == 1
		if key then
			present[key] = true; byKey[key] = v
			dirs[d] = math.max(dirs[d] or 0, n)
			local isManual = (n ~= 0 and n ~= 1 and n ~= 7)
			if isManual then manualSeen[d] = true end
			if n == 1 then
				quickPresent[d] = quickPresent[d] or {}
				table.insert(quickPresent[d], key)
			end
			local fp = drowSagaRegPrint(v)
			local oldfp = RG("Z" .. key, 0)
			local isNew = (RG("P" .. key, 0) ~= 1) or (oldfp ~= fp)
			local ft = tonumber(v.fileTime)
			if ft and ft > 0 then
				ft = (ft % 999983) + 1
				local oldft = RG("T" .. key, 0)
				if oldft > 0 and oldft ~= ft then isNew = true end
				RS("T" .. key, ft)
			end
			if isNew and RG("P" .. key, 0) == 1 then init = true end
			RS("Z" .. key, fp)
			if isNew then changedK[key] = true end
			if isNew then
				RS("P" .. key, 1)
				if isManual then
					local h = drowSagaNameKey(v.slotName)
					local id = pend[h]
					if id == 1 or id == 2 or id == 3 then RS("I" .. key, id); pendUsed[h] = true
					elseif init then RS("I" .. key, 3) end
				elseif n == 1 then
					quickChanged[d] = quickChanged[d] or {}
					table.insert(quickChanged[d], key)
				end
			end
		end
	end
	local camp = drowSagaListCampaign()
	local latest, fresh = RG("LATEST" .. camp, 0), RG("FRESH" .. camp, 0)
	for d, maxn in pairs(dirs) do
		local k7, k0 = d .. "N7", d .. "N0"
		local freshNow = false
		if byKey[k7] and fresh == 1 and (latest == 1 or latest == 2) then
			RS("I" .. k7, latest); RS("FRESH" .. camp, 0); fresh = 0; freshNow = true
		elseif changedK[k7] and RG("INIT" .. d, 0) == 1 then
			RS("I" .. k7, 3)
		end
		if byKey[k0] and (changedK[k0] or freshNow or RG("AN" .. camp, 0) > 0) then
			local p, a = byKey[k7], byKey[k0]
			local same = p and tostring(a.time or "") ~= "" and tostring(a.time) == tostring(p.time)
			local i7 = RG("I" .. k7, 0)
			local aid = RG("AI" .. camp, 0)
			if RG("AN" .. camp, 0) > 0 then
				RS("I" .. k0, (aid == 1 or aid == 2) and aid or 3); RS("E" .. k0, 0)
			elseif same and (i7 == 1 or i7 == 2 or i7 == 3) then
				RS("I" .. k0, i7); RS("E" .. k0, 1)
			else
				RS("I" .. k0, 3); RS("E" .. k0, 0)
			end
			RS("AN" .. camp, 0); RS("AI" .. camp, 0)
		end
		local qc = quickChanged[d]
		local qn, qid = RG("QN" .. camp, 0), RG("QI" .. camp, 0)
		if qc then
			for _, key in ipairs(qc) do
				if qn > 0 and (qid == 1 or qid == 2) and #qc <= qn then RS("I" .. key, qid)
				elseif qn > 0 or RG("INIT" .. d, 0) == 1 then RS("I" .. key, 3) end
			end
		end
		local qp = quickPresent[d]
		if qn > 0 and qp and qn > #(qc or {}) then
			local cand = {}
			for _, key in ipairs(qp) do
				if not (qc and changedK[key]) then table.insert(cand, key) end
			end
			if not qc and #cand == 1 and (qid == 1 or qid == 2) then
				RS("I" .. cand[1], qid)
			else
				for _, key in ipairs(cand) do
					if not (qid == 1 or qid == 2) or RG("I" .. key, 0) ~= qid then RS("I" .. key, 3) end
				end
			end
		end
		if qn > 0 and (qc or qp) then RS("QN" .. camp, 0); RS("QI" .. camp, 0) end
		local oldmax = RG("MX" .. d, 0)
		if maxn > oldmax then RS("MX" .. d, math.min(maxn, 5000)) end
		if manualSeen[d] then
			for n = 2, math.min(math.max(maxn, oldmax), 5000) do
				local key = d .. "N" .. n
				if n ~= 7 and not present[key] and RG("P" .. key, 0) == 1 then
					RS("P" .. key, 0); RS("I" .. key, 0)
				end
			end
		end
		RS("INIT" .. d, 1)
	end
	local keep = {}
	for k = 1, pn do
		local h, id, age = RG("PH" .. k, 0), RG("PI" .. k, 0), RG("PA" .. k, 0)
		if not pendUsed[h] and age < 10 then table.insert(keep, { h, id, age + 1 }) end
		RS("PH" .. k, 0); RS("PI" .. k, 0); RS("PA" .. k, 0)
	end
	for k, p in ipairs(keep) do RS("PH" .. k, p[1]); RS("PI" .. k, p[2]); RS("PA" .. k, p[3]) end
	RS("PN", #keep)
	return true
end



function drowSagaListCampaign()
	if gameSaves and tonumber(gameSaves.isImporting) == 1 then return "B" end
	return drowSagaCurrentCampaignTag()
end

local function drowSagaRegPendAdd(prefix, camp, id)
	local nk, ik = prefix .. "N" .. camp, prefix .. "I" .. camp
	local n, cur = RG(nk, 0), RG(ik, 0)
	if n == 0 then RS(ik, id) elseif cur ~= id then RS(ik, 3) end
	RS(nk, n + 1)
end

function drowSagaRegWorldIdentity()
	return (tonumber(Infinity_GetScriptVarInt("DS_UI_DROW") or 0) == 1) and 1 or 2
end

function drowSagaRegQuickSeen()
	drowSagaRegPendAdd("Q", drowSagaCurrentCampaignTag(), drowSagaRegWorldIdentity())
end

function drowSagaRegJourneySeen()
	drowSagaRegPendAdd("A", drowSagaCurrentCampaignTag(), drowSagaRegWorldIdentity())
end

function drowSagaRegWorldEntry()
	local camp, id = drowSagaCurrentCampaignTag(), drowSagaRegWorldIdentity()
	for _, p in ipairs({ "Q", "A" }) do
		if RG(p .. "N" .. camp, 0) > 0 and RG(p .. "I" .. camp, 0) ~= id then RS(p .. "I" .. camp, 3) end
	end
end

drowSagaLogSig = drowSagaLogSig or {}
local function drowSagaLogSignature(strref, cutToken)
	if drowSagaLogSig[strref] ~= nil then return drowSagaLogSig[strref] end
	local s = Infinity_FetchString(strref)
	if cutToken and type(s) == "string" then
		local cut = string.find(s, "<", 1, true)
		local dig = string.find(s, "%d")
		if dig and (not cut or dig < cut) then cut = dig end
		if cut then s = string.sub(s, 1, cut - 1) end
		s = string.gsub(s, "%s+$", "")
	end
	drowSagaLogSig[strref] = (type(s) == "string" and string.len(s) >= 4) and s or false
	return drowSagaLogSig[strref]
end

drowSagaLogLen, drowSagaLogFirst, drowSagaLogLast, drowSagaLogPrev = nil, nil, nil, nil
function drowSagaLogWatchCore()
	if type(combatLog) ~= "table" then return end
	local n = #combatLog
	local first, last = combatLog[1], combatLog[n]
	if drowSagaLogLen == nil then
		drowSagaLogLen, drowSagaLogFirst, drowSagaLogLast = n, first, last
		drowSagaLogPrev = {}
		for i = 1, n do drowSagaLogPrev[i] = combatLog[i] end
		return
	end
	if n == drowSagaLogLen and first == drowSagaLogFirst and last == drowSagaLogLast then return end
	local from = 1
	if n > drowSagaLogLen then
		from = drowSagaLogLen + 1
	elseif n == drowSagaLogLen then
		local prev, shift = drowSagaLogPrev or {}, n
		for t = 1, n - 1 do
			local same = true
			for i = 1, n - t do
				if combatLog[i] ~= prev[i + t] then same = false; break end
			end
			if same then shift = t; break end
		end
		from = n - shift + 1
	end
	local qs, js = drowSagaLogSignature(10237, false), drowSagaLogSignature(10689, true)
	for i = from, n do
		local e = combatLog[i]
		if type(e) == "string" then
			if qs and string.find(e, qs, 1, true) then pcall(drowSagaRegQuickSeen) end
			if js and string.find(e, js, 1, true) then pcall(drowSagaRegJourneySeen) end
		end
	end
	drowSagaLogLen, drowSagaLogFirst, drowSagaLogLast = n, first, last
	drowSagaLogPrev = {}
	for i = 1, n do drowSagaLogPrev[i] = combatLog[i] end
end

function drowSagaLogWatch()
	pcall(drowSagaLogWatchCore)
	return false
end

function drowSagaRegPrint(v)
	local fp = drowSagaNameKey(tostring(v.slotName or "") .. "|" .. tostring(v.sName or "") .. "|" .. tostring(v.time or ""))
	if fp == 0 then fp = 1 end
	return fp
end


function drowSagaRegFreshWorld(identity)
	local ok, e = pcall(drowSagaRegFreshWorldCore, identity)
	return ok
end

function drowSagaRegWrite(name, overwriteEntry)
	local ok, e = pcall(drowSagaRegWriteCore, name, overwriteEntry)
	return ok
end

function drowSagaRegReconcile()
	local ok, e = pcall(drowSagaRegReconcileCore)
	return ok
end


function drowSagaRegResolve(entry)
	local key, n = drowSagaRegKey(entry)
	if not key then return nil end
	local id = RG("I" .. key, 0)
	if id ~= 1 and id ~= 2 and id ~= 3 then return nil end
	local early = (id == 1) and (n == 7 or (n == 0 and RG("E" .. key, 0) == 1))
	return id, early
end

function drowSagaCaptureFixedSaveIdentity()
	return drowSagaCaptureFixedSaveIdentityCore()
end

function drowSagaImportedIsOtherMember()
	if tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "ACTIVE", 0)) ~= 1 then return false end
	local want = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "PNH", 0)) or 0
	local name = chargen and chargen.name or nil
	if want == 0 or type(name) ~= "string" or name == "" then return nil end
	return drowSagaNameKey(name) ~= want
end

function drowSagaApplyMemberIdentity(isOther)
	local id0 = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "ID", 0)) or 0
	if id0 ~= 1 and id0 ~= 2 and id0 ~= 3 then return false end
	local e0 = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "E0", 0)) or 0
	local want = (isOther == true) and 3 or id0
	local wantE = (isOther == true) and 0 or e0
	if tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "DROW", 0)) ~= want
	   or tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "EARLY", 0)) ~= wantE then
		Infinity_SetINIValue(drowSagaSaveImportTxnSection, "DROW", want)
		Infinity_SetINIValue(drowSagaSaveImportTxnSection, "EARLY", wantE)
	end
	drowSagaRestoreSaveImportTxn()
	return true
end
function drowSagaSaveMemberChosen(name)
	if tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "ACTIVE", 0)) ~= 1 then return false end
	local want = tonumber(Infinity_GetINIValue(drowSagaSaveImportTxnSection, "PNH", 0)) or 0
	local got = drowSagaNameKey(name)
	drowSagaApplyMemberIdentity(want ~= 0 and name ~= nil and got ~= want)
	return true
end





function drowSagaChargenInformation()
	return drowSagaChargenInformationCore()
end

function drowSagaSubraceHelp()
	local subrace = drowSagaSubraces[drowSagaSubracePending]
	if not subrace then
		return ""
	end

	if subrace.id == 1 then
		local race = chargen.races[currentChargenRace]
		if race then
			return Infinity_FetchString(race.desc)
		end
		return ""
	end

	return subrace.desc or ""
end


drowSagaMarkProf = 134
drowSagaReserveProf = 125

drowSagaProfTable = drowSagaProfTable or {}

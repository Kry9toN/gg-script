ui = false

function moveHook(num, beku)
    gg.clearResults()
    gg.clearList()
    gg.searchNumber("45,616,000~45,616,999", gg.TYPE_DWORD)
    resultcount = gg.getResultCount()
    
    if resultcount > 0 then
        gg.alert("OKE BOSS")
        hasil = gg.getResults(resultcount)
        for i, vv in ipairs(hasil) do
            addressOffset = vv.address + 0x24
            if beku then
                gg.addListItems({{ address = addressOffset, flags = gg.TYPE_DWORD, freeze = beku, value = num }})
            else
                gg.addListItems({{ address = addressOffset, flags = gg.TYPE_DWORD, value = num }})
            end
        end
    end
end

function exitt()
--    gg.clearResults()
--    gg.clearList()
    gg.setVisible(true)
    os.exit()
end

local function generateIdentifier(...)
  local concatenatedString = table.concat({ ... })

  local hash = 0
  for i = 1, #concatenatedString do
    hash = (hash + string.byte(concatenatedString, i)) % 4294967296
  end

  local uniqueIdentifier = string.format("%08x", hash)

  return uniqueIdentifier
end

function genKey()
    local target = gg.getTargetInfo()
    
    if not target then
      print('Target not found')
      return
    end
    
    local uuid = generateIdentifier(
      target.uid,
      target.nativeLibraryDir,
      target.packageName,
      gg.PACKAGE
    )
    
    return uuid
end

function dialogPrepare()
    prom = gg.prompt({"SET BERAPA"}, {10}, {"number"})
    if prom then
        moveHook(prom[1], true)
    end
end

function main() --Menu(UI Button false)
  menu = gg.choice({
    "1. MOVE CHEAT",
    "2. LEPAS BEKU MOVE",
    "KELUAR",
    "HIDE MENU"
  }, nil, "CREDIT ___")
  if not menu
    then
  elseif menu == 1
    then
      dialogPrepare()
  elseif menu == 2
    then
      moveHook(10, false)
  elseif menu == 3
    then
      exitt()
  elseif menu == 4
    then
      gg.setVisible(false)
    end
end

function menuLoop()
    while true --When script is Executed the Script will follow this Loop, depending on how the ui variable is set
      do
        while gg.isVisible(true) --loop to detect if GG icon is Pressed
          do
            gg.setVisible(ui) --checks the ui Variable if it should return true or false
            if ui == false --if ui variable false action
              then
                gg.hideUiButton() --removes the UI icon when it was activated before
                main()
              elseif ui == true -- if ui variable true
               then
                 gg.showUiButton()
            end
          end
      end
end

-- VERIFY STEP
if true then
    menuLoop()
end
    gg.copyText(genKey())

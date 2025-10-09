--[[

    ███████╗ ██╗    ██╗  ██████╗  ██████╗  ██████╗   
    ██╔════╝ ██║    ██║ ██╔═══██╗ ██╔══██╗ ██╔══██╗   
    ███████╗ ██║ █╗ ██║ ██║   ██║ ██████╔╝ ██║  ██║  
    ╚════██║ ██║███╗██║ ██║   ██║ ██╔══██╗ ██║  ██║   
    ███████║ ╚███╔███╔╝ ╚██████╔╝ ██║  ██║ ██████╔╝   
    ╚══════╝  ╚══╝╚══╝   ╚═════╝  ╚═╝  ╚═╝ ╚═════╝     
                                                                                        
    ██████╗  ██╗   ██╗ ███████╗ ███████╗ ████████╗
    ██╔════╝  ██║   ██║ ██╔════╝ ██╔════╝ ╚══██╔══╝
    ██║  ███╗ ██║   ██║ █████╗   ███████╗    ██║   
    ██║   ██║ ██║   ██║ ██╔══╝   ╚════██║    ██║   
    ╚██████╔╝ ╚██████╔╝ ███████╗ ███████║    ██║   
    ╚═════╝   ╚═════╝  ╚══════╝ ╚══════╝    ╚═╝   
]]
    
function executeBasedOnDetection(executionCode)

    local cleanCode = string.gsub(executionCode, "%s+", " ")
    
    local isDirectExecution = cleanCode == 'loadstring(game:HttpGet("https://jianke.lol/init.lua"))()'
    
    local keyValue = string.match(cleanCode, 'getfenv%(%)%.ADittoKey%s*=%s*"([^"]*)"')
    local hasInitCall = string.find(cleanCode, 'loadstring%(%s*game:HttpGet%("https://jianke.lol/init.lua"%)%s*%)%s*%(%)')
    
    if isDirectExecution then

        print("执行免费版本...")
        loadstring(request({Url = "https://github.com/Zer0neK/Sword_Guest/releases/download/SG/FREE.lua"}).Body)()
        
    elseif keyValue and hasInitCall then

        print("执行授权版本，卡密: " .. keyValue)
        

        local Key = keyValue

        getfenv().ADittoKey = Key
        
        loadstring(request({Url = "https://github.com/Zer0neK/Sword_Guest/releases/download/SG/Loader.lua"}).Body)()
        
    else

    end
end




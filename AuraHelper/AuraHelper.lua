--
--	AuraHelper
--	by Dancher
--

function AuraHelper_OnLoad(self)
	ShowGreetingsMessage();
end

function AuraHelper_OnEvent(self, event, ...)
end

function AuraHelper_Log(message)
	DEFAULT_CHAT_FRAME:AddMessage(message);
end

function ShowGreetingsMessage()
	local version = GetAddOnMetadata("AuraHelper", "Version");
	local greetings_message = "AuraHelper %s loaded! Get the latest version here: |cff0076ffhttps://github.com/dancher743/aura-helper|r"
	AuraHelper_Log((greetings_message):format(version));	
end

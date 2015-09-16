if SERVER then
        AddCSLuaFile()
	timer.Create("HostNameUpdate",0.5,0,function()
		SetGlobalString("HostName",GetHostName())
	end)
else
	function GetHostName()
		return GetGlobalString("HostName","")
	end
end
function userdatalist()
	
	function timeToStr( time )
		local tmp = time
		local s = tmp % 60
		tmp = math.floor( tmp / 60 )
		local m = tmp % 60
		tmp = math.floor( tmp / 60 )
		local h = tmp % 24
		tmp = math.floor( tmp / 60 )
		local d = tmp % 7
		
		return string.format ( "%i days | %02i h, %02i m, %02i s", d, h, m, s )
	end
	
	local DarkRPVars = DarkRPVars or {}
	local all = player.GetAll()

	local base = vgui.Create("DFrame")
	base:SetSize(700,800)
	base:SetPos(0, 0)
	base:MakePopup()
	base:Center()
	base:SetTitle("Server Data List")
	base:ShowCloseButton(true)
	base:SetDraggable(true)
	
	local ptList = vgui.Create( "DListView", base )
	ptList:SetSize(650,750)
	ptList:SetPos(25,30)
	ptList:SetMultiSelect( false )
	ptList:AddColumn( "Player" )
	ptList:AddColumn( "Usergroup" )
	ptList:AddColumn( "Money" )
	ptList:AddColumn( "Time Played" )

	for pname,gall in next,(all) do
		ptList:AddLine( gall:Nick(), gall:GetUserGroup(), tostring("$"..gall.DarkRPVars.money), timeToStr(gall:GetNWInt("time_played")))
	end
end

concommand.Add("udatalist", userdatalist)
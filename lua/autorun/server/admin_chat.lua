local groups = {
	"add groups here"
}

hook.Add( "PlayerSay", "AdminChat", function(ply, text, isTeam)
	if (#text > 1 and text[1] == "@") then
		local msg = string.gsub(text, "@", "")
		ply:PlayerMsg(Color(255,255,255),"Staff Message Sent.")
            for k,v in next, player.GetAll() do
		      	if v:IsAdmin() or table.HasValue(groups, v:GetUserGroup()) then
                        v:PlayerMsg(team.GetColor(ply:Team()),ply:Nick(), Color(255, 255, 255), " to staff:",Color(0,255,0), msg)
                    end
                end
    	return ""
    end
end )
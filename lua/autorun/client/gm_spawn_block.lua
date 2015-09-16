hook.Add( "PlayerBindPress", "BlockGMSpawnBinds", function( ply, bind, bool )

    if ( not bool ) then return end
    
    local tbl = string.Explode( " ", bind:lower(), false )

    if ( tbl[1] and tbl[1] == "gm_spawn" ) then 
        	chat.AddText(Color(255,255,255), "Sorry, ", Color(100, 255, 100) ,"gm_spawn", Color(255,255,255), " binds are blocked to prevent prop abuse." )
        return true
    end

end )
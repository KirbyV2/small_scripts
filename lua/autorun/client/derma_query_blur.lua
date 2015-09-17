surface.CreateFont( "TitleFont", {
	font = "Lato Light",
	size = 25,
 	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount) --Panel blur function
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

local function drawRectOutline( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( x, y, w, h )
end

function Derma_Query( strText, strTitle, ... )

	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( "" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( false )
		Window:SetBackgroundBlur( false )
		Window:SetDrawOnTop( true )
		Window.Paint = function( self, w, h )
			DrawBlur(Window, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )
			draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0, 85) )
			drawRectOutline( 2, 2, w - 4, h / 3.9, Color( 0, 0, 0, 85 ) )
			draw.RoundedBox( 0, 2, 2, w - 4, h / 4, Color(0,0,0,105) )
			draw.SimpleText( strTitle, "TitleFont", w / 2, 12, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
	local InnerPanel = vgui.Create( "DPanel", Window )
		InnerPanel:SetDrawBackground( false )
	
	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )

	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		ButtonPanel:SetDrawBackground( false )

	-- Loop through all the options and create buttons for them.
	local NumOptions = 0
	local x = 5

	for k=1, 8, 2 do
		
		local Text = select( k, ... )
		if Text == nil then break end
		
		local Func = select( k+1, ... ) or function() end
	
		local Button = vgui.Create( "DButton", ButtonPanel )
			Button:SetText( Text )
			Button:SizeToContents()
			Button:SetTall( 20 )
			Button:SetTextColor(Color(255,255,255))
			Button:SetWide( Button:GetWide() + 25 )
			Button.DoClick = function() Window:Close(); Func() end
			Button:SetPos( x, 5 )
			Button.Paint = function( self, w, h )
				DrawBlur(Button, 2)
				drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )
				draw.RoundedBox(0, 0, 0, w, h, self.Hovered and Color( 0, 0, 0, 85 ) or Color( 0, 0, 0, 65 ) )
			end
		x = x + Button:GetWide() + 5
			
		ButtonPanel:SetWide( x ) 
		NumOptions = NumOptions + 1
	
	end

	
	local w, h = Text:GetSize()
	
	w = math.max( w, ButtonPanel:GetWide() )
	
	Window:SetSize( w + 50, h + 25 + 45 + 10 )
	Window:Center()
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 5 )	
	
	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	Window:MakePopup()
	Window:DoModal()
	
	if ( NumOptions == 0 ) then
	
		Window:Close()
		Error( "Derma_Query: Created Query with no Options!?" )
		return nil
	
	end
	
	return Window

end
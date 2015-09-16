local hname = {
"add names here"
}

timer.Create("HostNames",5,0,function()
  local nm = hname[math.random(1,#hname)]
  game.ConsoleCommand("hostname add prefix here - ".. nm .."\n")
end)


math.randomseed(os.time())
return {
  "astroui",
  opts = {
    colorscheme = (tonumber(os.date "%H") >= 18 or tonumber(os.date "%H") < 06)
        and ((math.random(2) == 2) and "astromars" or "astrodark")
      or ((math.random(2) == 2) and "astrojupiter" or "astrolight"), -- change colorscheme
  },
}

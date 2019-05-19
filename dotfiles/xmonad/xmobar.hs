Config {
    font = "xft:Monospace:pixelsize=11",
    bgColor = "#002b36",
    fgColor = "#839496",
    commands = [
        -- Addison, TX
        -- Run Weather "KADS" ["-t"," <tempF>F","-L","64","-H","77","--normal","green","--high","red","--low","lightblue"] 36000,
        Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10,
        Run Memory ["-t","Mem: <usedratio>%"] 10,
        Run Date "%a %b %_d %l:%M" "date" 10,
        Run Network "wlp2s0" [] 10,
        Run StdinReader
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%StdinReader% }{ %ra0% | %cpu% | %memory% | <fc=#ee9a00>%date%</fc> "
}

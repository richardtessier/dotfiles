function lth --wraps='ls -lth &| head -n 11' --description 'alias lth ls -lth &| head -n 11'
    ls --color -lth $argv &| head -n 11
end

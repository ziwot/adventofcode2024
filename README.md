adventofcode2024

Install

```sh
luarocks install --lua-version=5.4 --tree=lua_modules inspect
```

Dev (using [fd](https://github.com/sharkdp/fd) & [entr](https://github.com/eradman/entr))

```sh
fd -e lua | entr lua -l setup day01.lua data/day01.txt
```

- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua#answer-46297236
- https://martin-fieber.de/series/lua/
- https://www.youtube.com/watch?v=CuWfgiwI73Q
- https://pdfhost.io/v/YkVYUK8Om_Lua_patterns_cheatsheet

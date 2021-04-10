# todo
## online portal
### main image
main image is too big on ipad. formula: (1366/1.5)/2
  
### loading gives undefined
on initial load, returns undefined. it reloads itself, but that does not solve the problem on ipad.
  #### fixes
  1. must manually stop automatic reload to work.
  1. increase time in setTimeout in `body.js`. 

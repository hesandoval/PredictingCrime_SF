#functins

latLong <- function(s,mach,i){
  start <- mach[[1]][i]
  stop <- start + attr(mach[[1]], "match.length")[i]-1
  return(as.numeric(substr(s,start, stop)))
}
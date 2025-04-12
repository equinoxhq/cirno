import ./[fetcher, types]
import pkg/pretty

proc main =
  let fflags = fetchFFlagList()
  print fflags

when isMainModule:
  main()

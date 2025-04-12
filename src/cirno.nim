import std/[options]
import ./[fetcher, types, store]
import pkg/pretty

proc main =
  let fflags = fetchFFlagList()
  let oldList = readList(List.A)

  if isNone(oldList):
    # First run
    discard

when isMainModule:
  main()

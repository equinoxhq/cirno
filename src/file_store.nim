## file backed store
import std/[os, options]

type
  List* {.pure, size: sizeof(uint8).} = enum
    A = 0x0  ## Old list.
    B = 0x1  ## New list.

proc writeList*(list: List, src: string) =
  writeFile("list_" & $list & ".json", src)

proc readList*(list: List): Option[string] =
  let path = "list_" & $list & ".json"
  if not fileExists(path):
    return

  some(readFile(path))

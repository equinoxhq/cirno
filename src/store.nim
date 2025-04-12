import std/[osproc, base64]
import pkg/[chronicles]

logScope:
  topics = "storage service"

type
  StoreFailed* = object of CatchableError

  List* {.pure, size: sizeof(uint8).} = enum
    A = 0x0 ## Old list.
    B = 0x1 ## New list. Unused.

proc writeList*(list: List, src: string) =
  info "Writing to list", list = list

  if execCmd("python3".findExe() & " store.py " & $list & ' ' & encode(src)) != 0:
    raise newException(StoreFailed, "Storage script returned non-zero exit code")

proc readList*(list: List): Option[string] =
  info "Reading from list", list = list

  let cmd = execCmd("python3".findExe & " read.py " & $list)
  if cmd.output.len < 1:
    warn "List is empty", list = list
    return

  some(cmd.output)

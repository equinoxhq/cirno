## Shared types
import std/[tables, json]
import pkg/[jsony, chronicles, results]

logScope:
  topics = "shared types"

type
  FFlagList* = Table[string, JsonNode]

proc parseFFlagList*(src: string): Result[FFlagList, string] =
  try:
    return ok(fromJson(src, FFlagList))
  except jsony.JsonError as exc:
    error "Failed to parse FFlag list",
      msg = exc.msg
    return err(exc.msg)

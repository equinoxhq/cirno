## Code to fetch Android FFlags from MaximumADHD's repository
import std/[options]
import pkg/[curly, chronicles]

logScope:
  topics = "fflag list fetcher"

var curl {.global.} = newCurly()

proc fetchFflagList*(): Option[string] =
  try:
    let request = curl.get("https://github.com/MaximumADHD/Roblox-FFlag-Tracker/raw/refs/heads/main/AndroidApp.json")
    if request.code != 200:
      warn "Request to Github returned non-200 status code",
        code = request.code, body = request.body
      return
    
    info "Fetched FFlag list successfully.",
      size = request.body.len
    return some(request.body)
  except CatchableError as exc:
    error "Failed to send request to Github",
      err = exc.msg

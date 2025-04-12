import std/[asyncdispatch, os, options, json, tables]
import ./[fetcher, types, file_store]
import pkg/[dimscord, pretty, results, chronicles]

logScope:
  topics = "bot"

let discord = newDiscordClient(getEnv("CIRNO_TOKEN"))
const ChannelId* {.strdefine: "CirnoChannelId".} = "1360607944038678616"

proc loop() {.async.} =
  info "Checking for new FFlags"
  let fflags = fetchFFlagList()
  let oldList = readList(List.A)

  template lengthCheck(content, flag: string) =
    if content.len > 1999:
      discard await discord.api.sendMessage(
        ChannelId,
        content = ":warning: **FFlag is too large to express!**: `" & flag & '`',
      )
      continue

  writeList(List.A, fflags.get())

  if isNone(oldList):
    # first run (very big and spammy list, probs)
    for flag, value in fflags.get().parseFFlagList().get():
      echo flag & ": " & $value
      let content = "```diff\n+ " & flag & ": " & $value & "```"
      lengthCheck(content, flag)

      discard await discord.api.sendMessage(ChannelId, content = content)
      sleep(50)

    writeList(List.A, fflags.get())
  else:
    # diff viewer
    let old = oldList.get().parseFFlagList().get()

    for newFlag, newVal in fflags.get().parseFFlagList().get():
      if newFlag notin old:
        let content = "```diff\n+ " & newFlag & ": " & $newVal & "```"
        lengthCheck(content, newFlag)

        discard await discord.api.sendMessage(ChannelId, content = content)
      else:
        if newVal == old[newFlag]:
          continue

        discard await discord.api.sendMessage(
          ChannelId,
          content =
            "```diff\n- " & newFlag & ": " & $old[newFlag] & '\n' & "+ " & newFlag & ": " &
            $newVal & "\n```",
        )

# Handle event for on_ready.
proc onReady(s: Shard, r: Ready) {.event(discord).} =
  echo "Ready as " & $r.user

  await s.updateStatus(
    activity = some ActivityStatus(name: "Skibidi Toilet Simulator", kind: atPlaying),
    status = "online",
  )

  while true:
    await loop()
    await sleepAsync(18000000) # Professionally sleep for 5 hours

# Connect to Discord and run the bot.
waitFor discord.startSession()

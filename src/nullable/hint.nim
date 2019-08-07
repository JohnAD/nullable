import
  logging,
  strutils

import
  core

proc hasInfo*[T](n: N[T]): bool =
  ## Returns true if there are any hints with the ``jdgInfo`` judgement
  result = false
  for hint in n.hints:
    if hint.judgement == jdgInfo:
      result = true
      break


proc hasSuccess*[T](n: N[T]): bool =
  ## Returns true if there are any hints with the ``jdgSuccess`` judgement
  result = false
  for hint in n.hints:
    if hint.judgement == jdgSuccess:
      result = true
      break


proc hasWarning*[T](n: N[T]): bool =
  ## Returns true if there are any hints with the ``jdgWarning`` judgement
  result = false
  for hint in n.hints:
    if hint.judgement == jdgWarning:
      result = true
      break


proc hasDanger*[T](n: N[T]): bool =
  ## Returns true if there are any hints with the ``jdgDanger`` judgement
  result = false
  for hint in n.hints:
    if hint.judgement == jdgDanger:
      result = true
      break


proc infoMsgs*[T](n: N[T]): seq[string] = 
  ## Returns a sequence of messsages marked with a judgement of ``jdgInfo``
  result = @[]
  for hint in n.hints:
    if hint.judgement == jdgInfo:
      result.add(hint.msg)


proc successMsgs*[T](n: N[T]): seq[string] = 
  ## Returns a sequence of messsages marked with a judgement of ``jdgSuccess``
  result = @[]
  for hint in n.hints:
    if hint.judgement == jdgSuccess:
      result.add(hint.msg)


proc warningMsgs*[T](n: N[T]): seq[string] = 
  ## Returns a sequence of messsages marked with a judgement of ``jdgWarning``
  result = @[]
  for hint in n.hints:
    if hint.judgement == jdgWarning:
      result.add(hint.msg)


proc dangerMsgs*[T](n: N[T]): seq[string] = 
  ## Returns a sequence of messsages marked with a judgement of ``jdgDanger``
  result = @[]
  for hint in n.hints:
    if hint.judgement == jdgDanger:
      result.add(hint.msg)


proc allMsgs*[T](n: N[T]): seq[string] = 
  ## Returns all the messsages
  result = @[]
  for hint in n.hints:
    result.add(hint.msg)


proc showHints*[T](n: N[T]): string =
  ## Creates a readable string of the hints in the UR. This function is meant for simple debugging.
  result = "hints:\n"
  for hint in n.hints:
    result.add("  (judgement: $1, msg: $2)\n".format($hint.judgement, hint.msg))


# ######################################
#
#  COMMON RESPONSES
#
# ######################################


proc addSuccess*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgSuccess, audience=audUser): void =
  #@ Common Responses
  ## Declares a successful hint of note. See defaults.
  ## Set the .value after declaring this.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)


proc addExpectedSuccess*[T](n: var N[T], msg: string, level=lvlDebug, judgement=jdgSuccess, audience=audUser): void =
  #@ Common Responses
  ## Declares a successful but typical hint. See defaults.
  ## Set the .value after declaring this.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)


proc addFailure*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgDanger, audience=audUser): void =
  #@ Common Responses
  ## Declares a unexpected failure. But not a bug. See defaults.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)


proc addExpectedFailure*[T](n: var N[T], msg: string, level=lvlDebug, judgement=jdgDanger, audience=audUser): void =
  #@ Common Responses
  ## Declares an expected run-of-the-mill failure. Not worth logging. See defaults.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)


proc addInternalBug*[T](n: var N[T], msg: string, level=lvlError, judgement=jdgDanger, audience=audOps): void =
  #@ Common Responses
  ## Declares a failure that should not have happened; aka "a bug". Should be logged for a developer to fix.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)


proc addCriticalInternalBug*[T](n: var N[T], msg: string, level=lvlFatal, judgement=jdgDanger, audience=audOps): void =
  #@ Common Responses
  ## Declares a failure that not only should not have happened but implies a severe problem, such as a security breach. Should be
  ## logged for top-priority analysis.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addNoteToPublic*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgInfo, audience=audPublic): void =
  #@ Common Responses
  ## Declares public information that would be of interest to the entire world
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addNoteToUser*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgInfo, audience=audUser): void =
  #@ Common Responses
  ## Declares information that would be of interest to a user or member
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addNoteToAdmin*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgInfo, audience=audAdmin): void =
  #@ Common Responses
  ## Declares information that would be of interest to a user or member with audAdmin rights
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addNoteToOps*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgInfo, audience=audOps): void =
  #@ Common Responses
  ## Declares information that would be of interest to IT or developers
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addWarning*[T](n: var N[T], msg: string, level=lvlNotice, judgement=jdgWarning, audience=audUser): void =
  #@ Common Responses
  ## Declares full success, but something seems odd; warrenting a warning.
  ## Recommend setting audience level to something appropriate.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

proc addDebug*[T](n: var N[T], msg: string, level=lvlDebug, judgement=jdgInfo, audience=audOps): void =
  #@ Common Responses
  ## Declares information only useful when debugging. Only seen by IT or developers.
  var hint = Hint()
  hint.msg = msg
  hint.level = level
  hint.judgement = judgement
  hint.audience = audience
  n.hints.add(hint)

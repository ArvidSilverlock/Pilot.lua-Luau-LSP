---
sidebar_position: 1
---

# Globals

This 'types' section is incomplete, I have not written a generalised system for generating type documentation, and only have the bare bones version used in the 'objects' section.

Please note you can find the raw documentation [here](https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP/blob/master/.lune/generate/documentation.json), I know it is hard to read, but you should be able to find any information you need in there.

This page is manually transcribed from the data and is not automatically generated.

- **GetPartFromPort**(_Port | number_ port, _string?_ className) → _PilotObject_
  - Gets a part of the specified type from any port of the specified ID.
- **GetPartsFromPort**(_Port | number_ port, _string?_ className) → _\{ PilotObject }_
  - Gets all the parts of the specified type from any port of the specified ID.
- **GetPart**(_number?_ id) → _PilotObject_
  - Gets a part of the specified type from any connected ports.
- **GetParts**(_number?_ id) → _\{ PilotObject }_
  - Gets all the parts of the specified type from any connected ports.
- **GetPort**(_number?_ id) → _Port_
  - Gets the connected port of the specified ID.
- **GetPorts**(_number?_ id) → _\{ Port }_
  - Gets all the connected ports of the specified ID. If no ID is specified it will get all connected ports.
- **TriggerPort**(_Port | number_ port)
  - Triggers the specified port.
- **JSONDecode**(_string_ data) → _JSON_
  - Encodes JSON. Proxy for `HttpService:JSONDecode`
- **JSONEncode**(_JSON_ data) → _string_
  - Encodes JSON. Proxy for `HttpService:JSONEncode`
- **Beep**(_number?_ frequency)
  - Produces a beep sound using a triangle wave.
- **GetCPUTime**() → _number_
  - Returns the current elapsed CPU time.
- **logError**(_string_ message, _number?_ level)
  - Logs an error in the output without yielding execution.
- **pilot**
  - Provides functions for accessing/manipulating information about threads such as permissions, ownership, and interrupts.
  - **claimThread**() → _boolean_
    - Sets the thread's parent to the running thread. The target thread must be part of the sandbox and may not exist on a lower ring otherwise nothing will happen.
  - **getCPUTime**() → _number_
    - Returns the current elapsed CPU time.
  - **getRing**() → _number_
    - Gets the ring of the target (or running) thread.
  - **getThreadParent**() → _thread?_
    - Gets the parent of the target (or running) thread. The parent thread must be part of the sandbox and may not exist on a lower ring otherwise nil will be returned.
  - **getTimeout**() → _number_
    - Gets the current CPU timeout, or the CPU timeout that the given thread will obey.
  - **hasRing**() → _boolean_
    - Checks if the target (or running) thread has the specified ring privilege or lower.
  - **saveRing**() → _() → ()_
    - Creates a function which elevates the caller to the specified (or current) ring regardless of its privilege. You can use this to de-escalate, spawn a new thread, and then re-escalate your thread after. Requires ring 0 or lower.
  - **setInterrupt**() → _() → ()_
    - Will repeatedly call the interrupt every period CPU time on a valid resumption time (ignores yields/waits). Returns a function which deletes the interrupt.
  - **setRing**()
    - Sets the ring of the target (or running) thread. You can use .saveRing to store the current ring so you can escalate again later.
  - **setTimeout**()
    - Sets the CPU timeout of the given thread. Requires ring -1 or lower. This will not let you exceed the game's timeout, but will let you set lower timeouts. This has to do with whatever thread happens to be actively running. Currently there is not a way for you to recover from a timeout, so you should use .setInterrupt to handle your own custom timeouts.

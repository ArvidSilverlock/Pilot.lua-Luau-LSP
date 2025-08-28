---
sidebar_position: 1
---

# Globals

Please note you can find the raw documentation [here](/raw-documentation), I know it is hard to read, but you should be able to find any information you need in there.

This page is manually transcribed from the data and is not automatically generated.

To retrieve with physical parts, use the [<code>Network</code>](/types/Network) library (it is accessed through the <code>Network</code> global).

Here are a list of global functions:

- **JSONDecode**(_string_ data) → _JSON_
  - Decodes JSON. Proxy for `HttpService:JSONDecode`
- **JSONEncode**(_JSON_ data) → _string_
  - Encodes JSON. Proxy for `HttpService:JSONEncode`
- **GetCPUTime**() → _number_
  - Returns the current elapsed CPU time.
- **logError**(_string_ message, _number?_ level)
  - Logs an error in the output without yielding execution.

These functions will be removed in future:

- **TriggerPort**(_Port | number_ port)
  - Triggers the specified port.
- **Beep**(_number?_ frequency)
  - Produces a beep sound using a triangle wave.

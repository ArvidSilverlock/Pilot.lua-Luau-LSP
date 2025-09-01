---
sidebar_position: 2
---

# Networks

# Microcontroller Networks & Subnets

It seems like microcontroller networks intimidate some people. But contrary to popular belief, they're actually not an advanced way of interacting with parts, they're an easier way, and they solve a lot of problems that you've probably had with microcontrollers.

## What are networks?

Networks are just a way of accessing parts and ports. The [<code>Network</code>](/types/Network) global for example is a network that begins at the microcontroller itself. You already use it to interact with parts, so you actually already know exactly how it works.

All other networks work in the exact same way, but instead of being from the 'perspective' of your microcontroller, they're from the 'perspective' of one or more port parts.

## How do networks work?

When you call <code>network:GetSubnet(specificPortObject)</code> you're getting a network that can access parts from that port (and only that port), as long as it was accessible on <code>Network</code>. This means that that port will act just like a microcontroller would, except it won't backtrack. When you try to get parts from this network, you'll get parts from the port, instead of from the microcontroller like you get with <code>Network</code>.

Similarly, when you call <code>network:GetSubnet(1)</code> (with a port number instead of a port object) you get a new network that can access parts from all port 1s simultaneously, as if they're all one port. And this lets you do some pretty cool stuff too.

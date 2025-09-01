# Reactor Controller Subnetting Guide

To help demonstrate why networks are so useful & why they make things easier, let's use reactor controllers as an example. It's super common in a lot of old and even _new_ reactor controllers to see people looping over all of the reactors in the entire network and trying to identify polysilicons and whatever other stuff should go with each reactor. Instead, let's use subnets.

## Building

First, start by building one reactor module with MBTools. This will be the reactor itself, the polysilicons, the dispenser for fuel, etc. Add one port for each polysilicon, and one port for the dispenser. Make sure that each has a unique ID. Next, join the ports up to eachother with ethernet, but now add one more port and give it an ID of 1. This port will be an 'entry point' for the reactor module, and it's what should connect up to the microcontroller.

## Using it in code

Next, let's look at some boilerplate controller code.

```lua
-- This function will take a subnet for a specific reactor module, and it'll do all of the logic that you want
local function handleReactorModule(subnet)
    local raiseRodsPoly = subnet:GetPartFromPort(1, "Polysilicon")
    local lowerRodsPoly = subnet:GetPartFromPort(2, "Polysilicon")
    local scramPoly = subnet:GetPartFromPort(3, "Polysilicon")

    -- Do your reactor logic here

    -- When you want to raise the rods
    raiseRodsPoly:Trigger()

    -- When you want to lower the rods
    lowerRodsPoly:Trigger()

    -- And when you want to eject the fuel
    scramPoly:Trigger()
end

-- This function will take a subnet for a bunch of reactor modules, each on port 1, and it'll run all of the reactor code for them all
local function runReactors(subnet)
    -- Get all of the ports with ID 1 so that we can loop over them all, these are all of our reactor modules
    for _, port in subnet:GetPorts(1) do
        -- Get a subnet for this specific port
        local subnet = subnet:GetPort(port)

        -- Run the reactor code on that subnet
        handleReactorModule(subnet)
    end
end

-- Finally, we can run all of our reactors:
runReactors(Network)
```

But let's say that we also want to run some other systems in this microcrontroller. Or maybe you want multiple sets of reactors to run together. Well, in that case, all you have to do is move your reactors to a new port, for example port 1. Then you can run your systems separately:

```lua
runReactors(Network:GetSubnet(1)) -- You can have multiple port 1s which are each a row of reactor modules

runOtherSystem(Network:GetSubnet(2)) -- You can also have multiple port 2s, which run some other system, for example ship thrusters
```

This allows you to expand and duplicate reactor modules or even rows of reactor modules without ever changing a line of code, and it allows you to easily expand when you want to add new systems.

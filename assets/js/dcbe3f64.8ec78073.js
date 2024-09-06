"use strict";(self.webpackChunkwos_wiki=self.webpackChunkwos_wiki||[]).push([[5726],{8139:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>h,contentTitle:()=>t,default:()=>a,frontMatter:()=>l,metadata:()=>o,toc:()=>c});var r=s(4848),i=s(8453);const l={tags:["Propulsion"]},t=void 0,o={id:"Programmable Objects/HyperDrive",title:"HyperDrive",description:"A device used to travel at faster than light speeds to other regions of the universe.",source:"@site/docs/Programmable Objects/HyperDrive.md",sourceDirName:"Programmable Objects",slug:"/Programmable Objects/HyperDrive",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/HyperDrive",draft:!1,unlisted:!1,tags:[{inline:!0,label:"Propulsion",permalink:"/Pilot.lua-Luau-LSP/docs/tags/propulsion"}],version:"current",frontMatter:{tags:["Propulsion"]},sidebar:"documentationSidebar",previous:{title:"Gyro",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Gyro"},next:{title:"Instrument",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Instrument"}},h={},c=[{value:"Methods",id:"methods",level:2},{value:"Configurables",id:"configurables",level:2},{value:"Properties",id:"properties",level:2},{value:"Events",id:"events",level:2}];function d(e){const n={a:"a",em:"em",h2:"h2",li:"li",p:"p",ul:"ul",...(0,i.R)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.p,{children:"A device used to travel at faster than light speeds to other regions of the universe.\nSimply input the coordinates to your destination and have a sufficient amount of fuel, and you'll be on your way to your destination.\nTo initiate warping, power the hyperdrive and trigger it. When warping, the hyperdrive will be anchored to prevent any movement."}),"\n",(0,r.jsx)(n.p,{children:"The power required for warping will be dependent on the distance travelled, as well as the size of the object being transported.\nThe amount of power required will be displayed in the hyper drive, shown in the red text."}),"\n",(0,r.jsx)(n.p,{children:"All of the parts connected to the hyperdrive and every player sitting will be teleported, however any free floating parts or standing up players will be sucked into the vaccum of space, so be careful."}),"\n",(0,r.jsx)(n.p,{children:"The red text at the bottom of the hyperdrive indicates how much power is needed to perform the jump."}),"\n",(0,r.jsx)(n.p,{children:"Make sure the numbers on the hyperdrive is facing up to ensure correct stud alignment."}),"\n",(0,r.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["GetRequiredPower()","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns the amount of power required for the warp."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["IsDestroyed() \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetConfigurables() \u2192 ",(0,r.jsx)(n.em,{children:"{ [string]: ConfigurableData }"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Returns info about all the configurables that that ",(0,r.jsx)(n.em,{children:"kind"})," of part has. Doesn't tell you what the actual values are, which is why it is public."]}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName)"]}),"\n",(0,r.jsxs)(n.li,{children:["HasPermission(",(0,r.jsx)(n.em,{children:"Permission"})," permission) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),",","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["CanUninstallComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["HasComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["GetMethods() \u2192 ",(0,r.jsx)(n.em,{children:"{ [string]: MethodData }"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets information about the methods of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["CanInstallComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["GetEvents() \u2192 ",(0,r.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,r.jsxs)(n.li,{children:["GetShape() \u2192 ",(0,r.jsx)(n.em,{children:"string?"})]}),"\n",(0,r.jsxs)(n.li,{children:["ListComponents() \u2192 ",(0,r.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,r.jsxs)(n.li,{children:["IsGrounded() \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Tells you if the part is grounded, meaning it does it have physics. If it is attached to terrain or an anchor for example, it will be grounded."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetOwnerId() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"undocumented"})," Click"]}),"\n"]}),(0,r.jsxs)(s,{children:[(0,r.jsx)("summary",{children:"Deprecated"}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["GetColor() \u2192 ",(0,r.jsx)(n.em,{children:"Color3"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the color of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetNameOfOwnerAsync() \u2192 ",(0,r.jsx)(n.em,{children:"string"})]}),"\n",(0,r.jsxs)(n.li,{children:["GetSize() \u2192 ",(0,r.jsx)(n.em,{children:"Vector3"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the size of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetDurability() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the current durability of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetTemperature() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the temperature of the object."}),"\n"]}),"\n"]}),"\n"]})]})]}),"\n",(0,r.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Coordinate"})," Coordinates","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The coordinates to warp to."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,r.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"string"})," GUID","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The unique GUID of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"CFrame"})," CFrame","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current CFrame of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Mass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current mass of the individual object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," AssemblyMass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," AssemblyLinearVelocity","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The velocity of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Health","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current health of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"string"})," ClassName","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The class name of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Orientation","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current orientation of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," AssemblyCenterOfMass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The center of mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," CreatedBy","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The user ID of the player who created the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Heat","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current heat of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Enum.Material"})," Material","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The material of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number?"})," PartLocked","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The user ID of the player who locked the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Size","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current size of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"boolean"})," Anchored","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Whether or not the object is anchored."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Color3"})," Color","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current color of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Temperature","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current heat/temperature of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Durability","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The maximum health of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Position","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current position of the object."}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,r.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Triggered(",(0,r.jsx)(n.em,{children:"PilotObject"})," otherPart)","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Fires when the object is triggered."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["Configured(",(0,r.jsx)(n.em,{children:"number"})," configurerId)","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Fires when the object is configured."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Destroying()","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Fires when the object is destroyed."}),"\n"]}),"\n"]}),"\n"]})]})]})}function a(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>t,x:()=>o});var r=s(6540);const i={},l=r.createContext(i);function t(e){const n=r.useContext(l);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function o(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:t(e.components),r.createElement(l.Provider,{value:n},e.children)}}}]);
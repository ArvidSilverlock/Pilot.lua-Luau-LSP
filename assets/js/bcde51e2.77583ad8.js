"use strict";(self.webpackChunkwos_wiki=self.webpackChunkwos_wiki||[]).push([[8608],{3819:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>h,contentTitle:()=>t,default:()=>a,frontMatter:()=>i,metadata:()=>c,toc:()=>o});var l=s(4848),r=s(8453);const i={},t=void 0,c={id:"Programmable Objects/Scanner",title:"Scanner",description:"Methods",source:"@site/docs/Programmable Objects/Scanner.md",sourceDirName:"Programmable Objects",slug:"/Programmable Objects/Scanner",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Scanner",draft:!1,unlisted:!1,tags:[],version:"current",frontMatter:{},sidebar:"documentationSidebar",previous:{title:"Reactor",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Reactor"},next:{title:"Screen",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Screen"}},h={},o=[{value:"Methods",id:"methods",level:2},{value:"Configurables",id:"configurables",level:2},{value:"Properties",id:"properties",level:2},{value:"Events",id:"events",level:2}];function d(e){const n={a:"a",em:"em",h2:"h2",li:"li",ul:"ul",...(0,r.R)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,l.jsxs)(l.Fragment,{children:[(0,l.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["Locate(",(0,l.jsx)(n.em,{children:"PilotObject"})," part, ",(0,l.jsx)(n.em,{children:"{Scanner}"})," scanners) \u2192 ",(0,l.jsx)(n.em,{children:"Vector3"}),",","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["Uses GPS to locate a part (uses ",":GetDistance","() internally). The scanners you provide should be on different axes and stuff. You need at least 3 to correctly identify a position."]}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetDistance(",(0,l.jsx)(n.em,{children:"PilotObject"})," part) \u2192 ",(0,l.jsx)(n.em,{children:"number"}),",","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets the approximate distance to the part. Accuracy falls off exponentially."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetPartsInRange(",(0,l.jsx)(n.em,{children:"number?"})," range, ",(0,l.jsx)(n.em,{children:"string?"})," className) \u2192 ",(0,l.jsx)(n.em,{children:"{PilotObject}"}),",","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Does a (power hungry) query for all parts in the configured (or specified) range up to 1024 studs. Can optionally filter for a class name, but many use cases will prefer to store part objects in a set."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["CalculateCost(",(0,l.jsx)(n.em,{children:"number?"})," range) \u2192 ",(0,l.jsx)(n.em,{children:"number"}),",","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Calculates the cost of performing a scan with the given range."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(s,{children:[(0,l.jsxs)("summary",{children:["Inherited from ",(0,l.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["IsDestroyed() \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetConfigurables() \u2192 ",(0,l.jsx)(n.em,{children:"{ [string]: ConfigurableData }"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["Returns info about all the configurables that that ",(0,l.jsx)(n.em,{children:"kind"})," of part has. Doesn't tell you what the actual values are, which is why it is public."]}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetComponent(",(0,l.jsx)(n.em,{children:"string"})," componentName)"]}),"\n",(0,l.jsxs)(n.li,{children:["HasPermission(",(0,l.jsx)(n.em,{children:"Permission"})," permission) \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),",","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["CanUninstallComponent(",(0,l.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,l.jsxs)(n.li,{children:["HasComponent(",(0,l.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,l.jsxs)(n.li,{children:["GetEvents() \u2192 ",(0,l.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,l.jsxs)(n.li,{children:["CanInstallComponent(",(0,l.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,l.jsxs)(n.li,{children:["GetShape() \u2192 ",(0,l.jsx)(n.em,{children:"string?"})]}),"\n",(0,l.jsxs)(n.li,{children:["ListComponents() \u2192 ",(0,l.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,l.jsxs)(n.li,{children:["IsGrounded() \u2192 ",(0,l.jsx)(n.em,{children:"boolean"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Tells you if the part is grounded, meaning it does it have physics. If it is attached to terrain or an anchor for example, it will be grounded."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetMethods() \u2192 ",(0,l.jsx)(n.em,{children:"{ [string]: MethodData }"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets information about the methods of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetOwnerId() \u2192 ",(0,l.jsx)(n.em,{children:"number"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"undocumented"})," Click"]}),"\n"]}),(0,l.jsxs)(s,{children:[(0,l.jsx)("summary",{children:"Deprecated"}),(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["GetColor() \u2192 ",(0,l.jsx)(n.em,{children:"Color3"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets the color of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetNameOfOwnerAsync() \u2192 ",(0,l.jsx)(n.em,{children:"string"})]}),"\n",(0,l.jsxs)(n.li,{children:["GetDurability() \u2192 ",(0,l.jsx)(n.em,{children:"number"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets the current durability of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetSize() \u2192 ",(0,l.jsx)(n.em,{children:"Vector3"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets the size of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:["GetTemperature() \u2192 ",(0,l.jsx)(n.em,{children:"number"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Gets the temperature of the object."}),"\n"]}),"\n"]}),"\n"]})]})]}),"\n",(0,l.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Range","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The default range to scan for parts within."}),"\n",(0,l.jsx)(n.li,{children:"Range: 0 to 1024"}),"\n",(0,l.jsx)(n.li,{children:"Default: 64"}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,l.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,l.jsxs)(s,{children:[(0,l.jsxs)("summary",{children:["Inherited from ",(0,l.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"string"})," GUID","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The unique GUID of the object"}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"CFrame"})," CFrame","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current CFrame of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Mass","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current mass of the individual object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," AssemblyMass","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Vector3"})," AssemblyLinearVelocity","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The velocity of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Health","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current health of the object"}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"string"})," ClassName","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"A string representing the type of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Vector3"})," Orientation","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current orientation of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Vector3"})," AssemblyCenterOfMass","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The center of mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," CreatedBy","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The user ID of the player who created the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Heat","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current heat of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Enum.Material"})," Material","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The material of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number?"})," PartLocked","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The user ID of the player who locked the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Vector3"})," Size","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current size of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"boolean"})," Anchored","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Whether or not the object is anchored."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Color3"})," Color","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current color of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Temperature","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current heat/temperature of the object."}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"number"})," Durability","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The maximum health of the object"}),"\n"]}),"\n"]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.em,{children:"Vector3"})," Position","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"The current position of the object."}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,l.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,l.jsxs)(s,{children:[(0,l.jsxs)("summary",{children:["Inherited from ",(0,l.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:["Destroying()","\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"Fires when the object is destroyed."}),"\n"]}),"\n"]}),"\n"]})]})]})}function a(e={}){const{wrapper:n}={...(0,r.R)(),...e.components};return n?(0,l.jsx)(n,{...e,children:(0,l.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>t,x:()=>c});var l=s(6540);const r={},i=l.createContext(r);function t(e){const n=l.useContext(i);return l.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function c(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:t(e.components),l.createElement(i.Provider,{value:n},e.children)}}}]);
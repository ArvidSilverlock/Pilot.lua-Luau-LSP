"use strict";(self.webpackChunkwos_wiki=self.webpackChunkwos_wiki||[]).push([[4324],{9593:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>h,contentTitle:()=>t,default:()=>a,frontMatter:()=>l,metadata:()=>c,toc:()=>o});var r=s(4848),i=s(8453);const l={tags:["Propulsion","Electrical"]},t=void 0,c={id:"Objects/Thruster",title:"Thruster",description:"A device that creates forward propulsion depending on its size when powered.",source:"@site/docs/Objects/Thruster.md",sourceDirName:"Objects",slug:"/Objects/Thruster",permalink:"/Pilot.lua-Luau-LSP/docs/Objects/Thruster",draft:!1,unlisted:!1,tags:[{inline:!0,label:"Propulsion",permalink:"/Pilot.lua-Luau-LSP/docs/tags/propulsion"},{inline:!0,label:"Electrical",permalink:"/Pilot.lua-Luau-LSP/docs/tags/electrical"}],version:"current",frontMatter:{tags:["Propulsion","Electrical"]},sidebar:"documentationSidebar",previous:{title:"Tetrahedron",permalink:"/Pilot.lua-Luau-LSP/docs/Objects/Tetrahedron"},next:{title:"Tile",permalink:"/Pilot.lua-Luau-LSP/docs/Objects/Tile"}},h={},o=[{value:"Methods",id:"methods",level:2},{value:"Configurables",id:"configurables",level:2},{value:"Properties",id:"properties",level:2},{value:"Events",id:"events",level:2}];function d(e){const n={a:"a",em:"em",h2:"h2",li:"li",p:"p",ul:"ul",...(0,i.R)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.p,{children:"A device that creates forward propulsion depending on its size when powered.\nThe size of the thruster will determine the max thrust speed it can have, with a larger thruster being capable of higher speeds."}),"\n",(0,r.jsx)(n.p,{children:"The speed setting of the thruster can also be configured from -100 (full backward) to 100 (full forward)."}),"\n",(0,r.jsx)(n.p,{children:"The maximum speed of a thruster is dependent on its volume.\nThrusters will generate more heat the larger and more powerful the thruster is. A 10x10x10 thruster, for example, would need about 8 coolers to operate.\nThe power required by a thruster is proportional to its actual speed output."}),"\n",(0,r.jsx)(n.p,{children:"Thrusters can be heated to a temperature of around <200 degrees before overheating and combusting."}),"\n",(0,r.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["IsDestroyed() \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetConfigurables() \u2192 ",(0,r.jsx)(n.em,{children:"{ [string]: ConfigurableData }"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Returns info about all the configurables that that ",(0,r.jsx)(n.em,{children:"kind"})," of part has. Doesn't tell you what the actual values are, which is why it is public."]}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName)"]}),"\n",(0,r.jsxs)(n.li,{children:["HasPermission(",(0,r.jsx)(n.em,{children:"Permission"})," permission) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),",","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["CanUninstallComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["HasComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["GetMethods() \u2192 ",(0,r.jsx)(n.em,{children:"{ [string]: MethodData }"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets information about the methods of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["CanInstallComponent(",(0,r.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,r.jsxs)(n.li,{children:["GetEvents() \u2192 ",(0,r.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,r.jsxs)(n.li,{children:["GetShape() \u2192 ",(0,r.jsx)(n.em,{children:"string?"})]}),"\n",(0,r.jsxs)(n.li,{children:["ListComponents() \u2192 ",(0,r.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,r.jsxs)(n.li,{children:["IsGrounded() \u2192 ",(0,r.jsx)(n.em,{children:"boolean"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Tells you if the part is grounded, meaning it does it have physics. If it is attached to terrain or an anchor for example, it will be grounded."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetOwnerId() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"undocumented"})," Click"]}),"\n"]}),(0,r.jsxs)(s,{children:[(0,r.jsx)("summary",{children:"Deprecated"}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["GetColor() \u2192 ",(0,r.jsx)(n.em,{children:"Color3"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the color of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetNameOfOwnerAsync() \u2192 ",(0,r.jsx)(n.em,{children:"string"})]}),"\n",(0,r.jsxs)(n.li,{children:["GetSize() \u2192 ",(0,r.jsx)(n.em,{children:"Vector3"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the size of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetDurability() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the current durability of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:["GetTemperature() \u2192 ",(0,r.jsx)(n.em,{children:"number"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Gets the temperature of the object."}),"\n"]}),"\n"]}),"\n"]})]})]}),"\n",(0,r.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Propulsion","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Determines the percentage of thrust (speed). Affects fuel consumption."}),"\n",(0,r.jsx)(n.li,{children:"Range: 0 to 100"}),"\n",(0,r.jsx)(n.li,{children:"Default: 50"}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,r.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"string"})," GUID","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The unique GUID of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"CFrame"})," CFrame","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current CFrame of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Mass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current mass of the individual object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," AssemblyMass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," AssemblyLinearVelocity","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The velocity of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Health","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current health of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"string"})," ClassName","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"A string representing the type of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Orientation","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current orientation of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," AssemblyCenterOfMass","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The center of mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," CreatedBy","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The user ID of the player who created the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Heat","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current heat of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Enum.Material"})," Material","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The material of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number?"})," PartLocked","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The user ID of the player who locked the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Size","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current size of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"boolean"})," Anchored","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Whether or not the object is anchored."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Color3"})," Color","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current color of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Temperature","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current heat/temperature of the object."}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"number"})," Durability","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The maximum health of the object"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.em,{children:"Vector3"})," Position","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"The current position of the object."}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,r.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Configured(",(0,r.jsx)(n.em,{children:"number"})," configurerId)","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Fires when the object is configured."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(s,{children:[(0,r.jsxs)("summary",{children:["Inherited from ",(0,r.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:["Destroying()","\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsx)(n.li,{children:"Fires when the object is destroyed."}),"\n"]}),"\n"]}),"\n"]})]})]})}function a(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>t,x:()=>c});var r=s(6540);const i={},l=r.createContext(i);function t(e){const n=r.useContext(l);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function c(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:t(e.components),r.createElement(l.Provider,{value:n},e.children)}}}]);
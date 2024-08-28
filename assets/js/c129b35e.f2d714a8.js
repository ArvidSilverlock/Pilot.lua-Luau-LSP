"use strict";(self.webpackChunkwos_wiki=self.webpackChunkwos_wiki||[]).push([[5707],{3608:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>c,contentTitle:()=>t,default:()=>a,frontMatter:()=>r,metadata:()=>h,toc:()=>o});var i=s(4848),l=s(8453);const r={tags:["Electrical"]},t=void 0,h={id:"Programmable Objects/EnergyShield",title:"EnergyShield",description:"Creates a bubble made of energy that protects it from energy based weapons such as Lasers and Plasma Cannons.",source:"@site/docs/Programmable Objects/EnergyShield.md",sourceDirName:"Programmable Objects",slug:"/Programmable Objects/EnergyShield",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/EnergyShield",draft:!1,unlisted:!1,tags:[{inline:!0,label:"Electrical",permalink:"/Pilot.lua-Luau-LSP/docs/tags/electrical"}],version:"current",frontMatter:{tags:["Electrical"]},sidebar:"documentationSidebar",previous:{title:"Dispenser",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Dispenser"},next:{title:"Faucet",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Faucet"}},c={},o=[{value:"Methods",id:"methods",level:2},{value:"Configurables",id:"configurables",level:2},{value:"Properties",id:"properties",level:2},{value:"Events",id:"events",level:2}];function d(e){const n={a:"a",em:"em",h2:"h2",li:"li",p:"p",ul:"ul",...(0,l.R)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:"Creates a bubble made of energy that protects it from energy based weapons such as Lasers and Plasma Cannons."}),"\n",(0,i.jsx)(n.p,{children:"An EnergyShield has a few sets of properties that you can fine tune to create a balanced shield.\nShieldRadius - The size of the entire shield. This will exponentially consume more power the higher the radius is.\nRegenerationSpeed - On a scale from 1 to 10 on how fast the shield will regenerate.\nShieldStrength - Scale from 1 to 10 on how much the shield can endure."}),"\n",(0,i.jsx)(n.p,{children:"RegenerationSpeed and ShieldStrength both combined can't be over 11.\nFor example, a regeneration speed of 6 and a shield strength of 5 is possible.\nHowever, a regeneration speed of 10 and a shield strength of 10 isn't, as 10 + 10 > 11\nA regeneration speed of 1 and a shield strength of 10 however is possible, since 11 = 11."}),"\n",(0,i.jsx)(n.p,{children:"Another benefit for energy shields is that it blocks all warhead explosions, whether inside the shield or outside."}),"\n",(0,i.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["GetShieldHealth() \u2192 ",(0,i.jsx)(n.em,{children:"number"})]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"undocumented"})," CalculateCost"]}),"\n"]}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["IsDestroyed() \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetConfigurables() \u2192 ",(0,i.jsx)(n.em,{children:"{ [string]: ConfigurableData }"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets information about the configurable properties of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName)"]}),"\n",(0,i.jsxs)(n.li,{children:["ListComponents() \u2192 ",(0,i.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,i.jsxs)(n.li,{children:["HasPermission(",(0,i.jsx)(n.em,{children:"Permission"})," permission) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),",","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["CanUninstallComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["HasComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["GetOwnerId() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["CanInstallComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["GetShape() \u2192 ",(0,i.jsx)(n.em,{children:"string?"})]}),"\n",(0,i.jsxs)(n.li,{children:["GetMethods() \u2192 ",(0,i.jsx)(n.em,{children:"{ [string]: MethodData }"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets information about the methods of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["IsGrounded() \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is grounded."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetEvents() \u2192 ",(0,i.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"undocumented"})," Click"]}),"\n"]}),(0,i.jsxs)(s,{children:[(0,i.jsx)("summary",{children:"Deprecated"}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["GetColor() \u2192 ",(0,i.jsx)(n.em,{children:"Color3"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the color of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetNameOfOwnerAsync() \u2192 ",(0,i.jsx)(n.em,{children:"string"})]}),"\n",(0,i.jsxs)(n.li,{children:["GetDurability() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the current durability of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetSize() \u2192 ",(0,i.jsx)(n.em,{children:"Vector3"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the size of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetTemperature() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the temperature of the object."}),"\n"]}),"\n"]}),"\n"]})]})]}),"\n",(0,i.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," RegenerationSpeed","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Determines how fast the shield regenerates after being hit."}),"\n",(0,i.jsx)(n.li,{children:"Range: 1 to 10"}),"\n",(0,i.jsx)(n.li,{children:"Default: 5"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," ShieldStrength","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Determines the shield's resistance to damage."}),"\n",(0,i.jsx)(n.li,{children:"Range: 1 to 10"}),"\n",(0,i.jsx)(n.li,{children:"Default: 5"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," ShieldRadius","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The size of the entire shield. The shield exponentially consumes more power the higher this is."}),"\n",(0,i.jsx)(n.li,{children:"Range: 50 to 1000"}),"\n",(0,i.jsx)(n.li,{children:"Default: 100"}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,i.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"string"})," GUID","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The unique GUID of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"CFrame"})," CFrame","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current CFrame of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Mass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current mass of the individual object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," AssemblyMass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," AssemblyLinearVelocity","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The velocity of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Health","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current health of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"string"})," ClassName","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The class name of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Orientation","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current orientation of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," AssemblyCenterOfMass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The center of mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," CreatedBy","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The user ID of the player who created the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Heat","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current heat of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"boolean"})," Anchored","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Whether or not the object is anchored."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Enum.Material"})," Material","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The material of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number?"})," PartLocked","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The user ID of the player who locked the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Size","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current size of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Color3"})," Color","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current color of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Temperature","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current heat/temperature of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Durability","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The maximum health of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Position","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current position of the object."}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,i.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["Loop(",(0,i.jsx)(n.em,{children:"number"})," deltaTime)","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Fires when the object is updated by the game loop."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["Configured(",(0,i.jsx)(n.em,{children:"number"})," configurerId)","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Fires when the object is configured."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["Destroyed()","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Fires when the object is destroyed."}),"\n"]}),"\n"]}),"\n"]})]})]})}function a(e={}){const{wrapper:n}={...(0,l.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>t,x:()=>h});var i=s(6540);const l={},r=i.createContext(l);function t(e){const n=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function h(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(l):e.components||l:t(e.components),i.createElement(r.Provider,{value:n},e.children)}}}]);
"use strict";(self.webpackChunkwos_wiki=self.webpackChunkwos_wiki||[]).push([[9772],{6311:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>h,contentTitle:()=>t,default:()=>j,frontMatter:()=>l,metadata:()=>c,toc:()=>o});var i=s(4848),r=s(8453);const l={},t=void 0,c={id:"Programmable Objects/Bin",title:"Bin",description:"Stores solid items such as Aluminum, Iron, Faucets, etc.",source:"@site/docs/Programmable Objects/Bin.md",sourceDirName:"Programmable Objects",slug:"/Programmable Objects/Bin",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Bin",draft:!1,unlisted:!1,tags:[],version:"current",frontMatter:{},sidebar:"documentationSidebar",previous:{title:"Battery",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/Battery"},next:{title:"BlackBox",permalink:"/Pilot.lua-Luau-LSP/docs/Programmable Objects/BlackBox"}},h={},o=[{value:"Methods",id:"methods",level:2},{value:"Configurables",id:"configurables",level:2},{value:"Properties",id:"properties",level:2},{value:"Events",id:"events",level:2}];function d(e){const n={a:"a",code:"code",em:"em",h2:"h2",li:"li",p:"p",ul:"ul",...(0,r.R)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:"Stores solid items such as Aluminum, Iron, Faucets, etc.\nCan store up to 1000 items. When destroyed, every item inside will also be destroyed.\nThe value increases as more items are added to it."}),"\n",(0,i.jsx)(n.p,{children:"Bins can also be used as crafting recipes, with the resources inside being used.\nYou can also configure a bin to prevent items from being crafted from it, allowing for bins to be strictly for machine storage."}),"\n",(0,i.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/ContainerObject",children:"ContainerObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["GetResourceAmount() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gives you the total amount of stuff in the container."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetResource() \u2192 ",(0,i.jsx)(n.em,{children:'string | "nil"'}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:'Gives you the name of the resource it contains, or the string "nil" if none (although this is likely a bug and should return actual nil, it just calls tostring on the resource kind)'}),"\n"]}),"\n"]}),"\n"]}),(0,i.jsxs)(s,{children:[(0,i.jsx)("summary",{children:"Deprecated"}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["GetAmount() \u2192 ",(0,i.jsx)(n.em,{children:"number"})]}),"\n"]})]})]}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["IsDestroyed() \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetConfigurables() \u2192 ",(0,i.jsx)(n.em,{children:"{ [string]: ConfigurableData }"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["Returns info about all the configurables that that ",(0,i.jsx)(n.em,{children:"kind"})," of part has. Doesn't tell you what the actual values are, which is why it is public."]}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName)"]}),"\n",(0,i.jsxs)(n.li,{children:["HasPermission(",(0,i.jsx)(n.em,{children:"Permission"})," permission) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),",","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["CanUninstallComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["HasComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["CanInstallComponent(",(0,i.jsx)(n.em,{children:"string"})," componentName) \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),","]}),"\n",(0,i.jsxs)(n.li,{children:["GetEvents() \u2192 ",(0,i.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,i.jsxs)(n.li,{children:["GetShape() \u2192 ",(0,i.jsx)(n.em,{children:"string?"})]}),"\n",(0,i.jsxs)(n.li,{children:["ListComponents() \u2192 ",(0,i.jsx)(n.em,{children:"{ string }"})]}),"\n",(0,i.jsxs)(n.li,{children:["IsGrounded() \u2192 ",(0,i.jsx)(n.em,{children:"boolean"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Tells you if the part is grounded, meaning it does it have physics. If it is attached to terrain or an anchor for example, it will be grounded."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetMethods() \u2192 ",(0,i.jsx)(n.em,{children:"{ [string]: MethodData }"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets information about the methods of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetOwnerId() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"undocumented"})," Click"]}),"\n"]}),(0,i.jsxs)(s,{children:[(0,i.jsx)("summary",{children:"Deprecated"}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["GetColor() \u2192 ",(0,i.jsx)(n.em,{children:"Color3"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the color of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetNameOfOwnerAsync() \u2192 ",(0,i.jsx)(n.em,{children:"string"})]}),"\n",(0,i.jsxs)(n.li,{children:["GetSize() \u2192 ",(0,i.jsx)(n.em,{children:"Vector3"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the size of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetDurability() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the current durability of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["GetTemperature() \u2192 ",(0,i.jsx)(n.em,{children:"number"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Gets the temperature of the object."}),"\n"]}),"\n"]}),"\n"]})]})]}),"\n",(0,i.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"boolean"})," CanBeCraftedFrom","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Determines whether this bin can be used by nearby players to craft objects."}),"\n",(0,i.jsx)(n.li,{children:"Default: true"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"string"})," Resource","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The kind of resource the bin can hold. You can set this to Any to allow the bin to accept anything."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,i.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"string"})," GUID","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The unique GUID of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"CFrame"})," CFrame","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current CFrame of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Mass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current mass of the individual object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," AssemblyMass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," AssemblyLinearVelocity","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The velocity of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Health","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current health of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"string"})," ClassName","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"A string representing the type of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Orientation","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current orientation of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," AssemblyCenterOfMass","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The center of mass of the object's assembly."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," CreatedBy","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The user ID of the player who created the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Heat","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current heat of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Enum.Material"})," Material","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The material of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number?"})," PartLocked","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The user ID of the player who locked the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Size","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current size of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"boolean"})," Anchored","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Whether or not the object is anchored."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Color3"})," Color","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current color of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Temperature","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current heat/temperature of the object."}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"number"})," Durability","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The maximum health of the object"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:[(0,i.jsx)(n.em,{children:"Vector3"})," Position","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"The current position of the object."}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,i.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["OnClick(",(0,i.jsx)(n.em,{children:"number"})," clickerId)","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Fires when the object is clicked."}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/ContainerObject",children:"ContainerObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["ContainerChanged(",(0,i.jsx)(n.em,{children:'"Solid" | "Fluid" | "Power"'})," resourceType, ",(0,i.jsx)(n.em,{children:"number"})," resourceAmount)","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["Fires when the amount of the item in the container changes. Note that ",(0,i.jsx)(n.code,{children:"resourceType"}),' describes the "state" (i.e., ',(0,i.jsx)(n.code,{children:"Power"})," for powercell, ",(0,i.jsx)(n.code,{children:"Solid"})," for bin, ",(0,i.jsx)(n.code,{children:"Fluid"})," for tank) of the resource rather than the contents"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,i.jsxs)(s,{children:[(0,i.jsxs)("summary",{children:["Inherited from ",(0,i.jsx)(n.a,{href:"/Pilot.lua-Luau-LSP/docs/Classes/PilotObject",children:"PilotObject"})]}),(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["Destroying()","\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"Fires when the object is destroyed."}),"\n"]}),"\n"]}),"\n"]})]})]})}function j(e={}){const{wrapper:n}={...(0,r.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>t,x:()=>c});var i=s(6540);const r={},l=i.createContext(r);function t(e){const n=i.useContext(l);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function c(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:t(e.components),i.createElement(l.Provider,{value:n},e.children)}}}]);
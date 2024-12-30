"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[6669],{1999:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>s,contentTitle:()=>a,default:()=>h,frontMatter:()=>l,metadata:()=>n,toc:()=>c});const n=JSON.parse('{"id":"objects/Teleporter","title":"Teleporter","description":"A device used to transport players across regions.","source":"@site/docs/objects/Teleporter.md","sourceDirName":"objects","slug":"/objects/Teleporter","permalink":"/Pilot.lua-Luau-LSP/objects/Teleporter","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Spawnable","Craftable","Non-Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Tank","permalink":"/Pilot.lua-Luau-LSP/objects/Tank"},"next":{"title":"Telescope","permalink":"/Pilot.lua-Luau-LSP/objects/Telescope"}}');var o=r(4848),i=r(8453);const l={tags:["Spawnable","Craftable","Non-Programmable","Configurable"]},a=void 0,s={},c=[{value:"Configurables",id:"configurables",level:2},{value:"Coordinates",id:"coordinates",level:3},{value:"ForceLocalTeleport",id:"forcelocalteleport",level:3},{value:"TeleporterID",id:"teleporterid",level:3},{value:"Events",id:"events",level:2},{value:"Triggered(otherPart)",id:"triggeredotherpart",level:3}];function d(e){const t={h2:"h2",h3:"h3",hr:"hr",p:"p",...(0,i.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(t.p,{children:"A device used to transport players across regions.\nWhen powered and triggered, it will teleport all players in the beam to the given coordinates and teleporter id.\nIt will warp the player to a teleporter in the region with the given teleporter id."}),"\n",(0,o.jsx)(t.p,{children:"When warping to a teleporter inside of a planet, set the last value to true. For example,\n50, -50, 85, -75, true"}),"\n",(0,o.jsx)(t.p,{children:"Make sure you set the correct coordinates OR YOU WILL BE STRANDED!"}),"\n",(0,o.jsx)(t.p,{children:"Costs 1000 energy per teleport. Teleporter uses Energy regardless if a player is on the Teleporter at the moment it gets triggered."}),"\n",(0,o.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,o.jsx)(t.p,{children:"It cannot be resized."}),"\n",(0,o.jsx)(t.p,{children:"At its default size (8x2x8) it has a durability of 1."}),"\n",(0,o.jsxs)(t.p,{children:["By default, its colour is ",(0,o.jsx)("span",{style:{color:"#F8F8F8"},children:"#f8f8f8"}),"."]}),"\n",(0,o.jsxs)(t.p,{children:["It requires 1 ",(0,o.jsx)("code",{children:"HyperDrive"}),", 50 ",(0,o.jsx)("code",{children:"Quartz"}),", 1 ",(0,o.jsx)("code",{children:"Transporter"}),", and 30 ",(0,o.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,o.jsx)(t.h2,{id:"configurables",children:"Configurables"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"coordinates",children:"Coordinates"}),"\n",(0,o.jsxs)(t.p,{children:["The coordinates to your Destination. It is a ",(0,o.jsx)("code",{children:"Coordinates"}),"."]}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"forcelocalteleport",children:"ForceLocalTeleport"}),"\n",(0,o.jsxs)(t.p,{children:['Whether to only attempt to teleport to teleporters within the same region, ignoring the "Coordinates" configuration. It is a ',(0,o.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"teleporterid",children:"TeleporterID"}),"\n",(0,o.jsxs)(t.p,{children:["The ID of the teleporter at the goal coordinates to teleport directly to. It is a ",(0,o.jsx)("code",{children:"number"}),".\nIt ranges between 1 and 999. It increments by 1."]}),"\n",(0,o.jsx)(t.h2,{id:"events",children:"Events"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"triggeredotherpart",children:"Triggered(otherPart)"}),"\n",(0,o.jsx)(t.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,o.jsxs)(t.p,{children:["If a ",(0,o.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,o.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,o.jsx)("code",{children:":Trigger"}),", but not ",(0,o.jsx)("code",{children:"TriggerPort"}),"), it ",(0,o.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,o.jsxs)(t.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,o.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,o.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,o.jsx)("code",{children:"PilotObject"}),"."]})]})}function h(e={}){const{wrapper:t}={...(0,i.R)(),...e.components};return t?(0,o.jsx)(t,{...e,children:(0,o.jsx)(d,{...e})}):d(e)}},8453:(e,t,r)=>{r.d(t,{R:()=>l,x:()=>a});var n=r(6540);const o={},i=n.createContext(o);function l(e){const t=n.useContext(i);return n.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function a(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:l(e.components),n.createElement(i.Provider,{value:t},e.children)}}}]);
"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[664],{9113:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>o,contentTitle:()=>l,default:()=>h,frontMatter:()=>s,metadata:()=>i,toc:()=>c});const i=JSON.parse('{"id":"objects/Transformer","title":"Transformer","description":"Sends a constant trigger signal when powered. By default, it will send a trigger signal every tick, but can be configured up to every 360 seconds. If the transformer\'s loop time matches the game\'s internal tick rate (the default,  1/s), it will synchronize with the game loop.","source":"@site/docs/objects/Transformer.md","sourceDirName":"objects","slug":"/objects/Transformer","permalink":"/Pilot.lua-Luau-LSP/objects/Transformer","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Logic","Spawnable","Craftable","Non-Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"TractorBeam","permalink":"/Pilot.lua-Luau-LSP/objects/TractorBeam"},"next":{"title":"Transistor","permalink":"/Pilot.lua-Luau-LSP/objects/Transistor"}}');var n=r(4848),a=r(8453);const s={tags:["Logic","Spawnable","Craftable","Non-Programmable","Configurable"]},l=void 0,o={},c=[{value:"Configurables",id:"configurables",level:2},{value:"LoopTime",id:"looptime",level:3},{value:"Events",id:"events",level:2},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3},{value:"Triggered(otherPart)",id:"triggeredotherpart",level:3}];function d(e){const t={h2:"h2",h3:"h3",hr:"hr",p:"p",...(0,a.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(t.p,{children:"Sends a constant trigger signal when powered. By default, it will send a trigger signal every tick, but can be configured up to every 360 seconds. If the transformer's loop time matches the game's internal tick rate (the default,  1/s), it will synchronize with the game loop."}),"\n",(0,n.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,n.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (64) that have integer components: 1x64x1, 1x32x2, 1x16x4, 1x8x8, 2x16x2, 2x8x4, 4x4x4, 8x4x2"}),"\n",(0,n.jsx)(t.p,{children:"At its default size (2x3x2) it has a durability of 1, at its maximum size it has a durability of 2."}),"\n",(0,n.jsxs)(t.p,{children:["By default, its colour is ",(0,n.jsx)("span",{style:{color:"#DFDFDE"},children:"#dfdfde"}),"."]}),"\n",(0,n.jsxs)(t.p,{children:["It requires 5 ",(0,n.jsx)("code",{children:"Copper"}),", 1 ",(0,n.jsx)("code",{children:"Iron"}),", and 3 ",(0,n.jsx)("code",{children:"Quartz"})," to be crafted."]}),"\n",(0,n.jsx)(t.h2,{id:"configurables",children:"Configurables"}),"\n",(0,n.jsx)(t.hr,{}),"\n",(0,n.jsx)(t.h3,{id:"looptime",children:"LoopTime"}),"\n",(0,n.jsxs)(t.p,{children:["The time in seconds between triggers. It is a ",(0,n.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 360."]}),"\n",(0,n.jsx)(t.h2,{id:"events",children:"Events"}),"\n",(0,n.jsx)(t.hr,{}),"\n",(0,n.jsx)(t.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,n.jsx)(t.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,n.jsxs)(t.p,{children:["The ",(0,n.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,n.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,n.jsx)("code",{children:"1"}),"). It is a ",(0,n.jsx)("code",{children:"number"}),"."]}),"\n",(0,n.jsx)(t.hr,{}),"\n",(0,n.jsx)(t.h3,{id:"triggeredotherpart",children:"Triggered(otherPart)"}),"\n",(0,n.jsx)(t.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,n.jsxs)(t.p,{children:["If a ",(0,n.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,n.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,n.jsx)("code",{children:":Trigger"}),", but not ",(0,n.jsx)("code",{children:"TriggerPort"}),"), it ",(0,n.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,n.jsxs)(t.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,n.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,n.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,n.jsxs)(t.p,{children:["The ",(0,n.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,n.jsx)("code",{children:"PilotObject"}),"."]})]})}function h(e={}){const{wrapper:t}={...(0,a.R)(),...e.components};return t?(0,n.jsx)(t,{...e,children:(0,n.jsx)(d,{...e})}):d(e)}},8453:(e,t,r)=>{r.d(t,{R:()=>s,x:()=>l});var i=r(6540);const n={},a=i.createContext(n);function s(e){const t=i.useContext(a);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function l(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(n):e.components||n:s(e.components),i.createElement(a.Provider,{value:t},e.children)}}}]);
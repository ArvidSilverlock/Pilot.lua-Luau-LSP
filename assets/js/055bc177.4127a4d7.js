"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[7985],{648:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>o,default:()=>h,frontMatter:()=>l,metadata:()=>i,toc:()=>c});const i=JSON.parse('{"id":"objects/Igniter","title":"Igniter","description":"Sets alight unlocked parts within the immediate vicinity when triggered. Range depends on the size.","source":"@site/docs/objects/Igniter.md","sourceDirName":"objects","slug":"/objects/Igniter","permalink":"/Pilot.lua-Luau-LSP/objects/Igniter","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Logic","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Ice","permalink":"/Pilot.lua-Luau-LSP/objects/Ice"},"next":{"title":"ImpactPlate","permalink":"/Pilot.lua-Luau-LSP/objects/ImpactPlate"}}');var r=n(4848),a=n(8453);const l={tags:["Logic","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},o=void 0,s={},c=[{value:"Events",id:"events",level:2},{value:"Triggered(otherPart)",id:"triggeredotherpart",level:3}];function d(e){const t={h2:"h2",h3:"h3",hr:"hr",p:"p",...(0,a.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(t.p,{children:"Sets alight unlocked parts within the immediate vicinity when triggered. Range depends on the size."}),"\n",(0,r.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (8) that have integer components: 1x8x1, 1x4x2, 2x2x2"}),"\n",(0,r.jsx)(t.p,{children:"At its default size (2x2x2) it has a durability of 1, at its maximum size it has a durability of 2."}),"\n",(0,r.jsxs)(t.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#FF0000"},children:"#ff0000"}),"."]}),"\n",(0,r.jsxs)(t.p,{children:["It requires 10 ",(0,r.jsx)("code",{children:"Iron"}),", 5 ",(0,r.jsx)("code",{children:"Plastic"}),", and 2 ",(0,r.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,r.jsx)(t.h2,{id:"events",children:"Events"}),"\n",(0,r.jsx)(t.hr,{}),"\n",(0,r.jsx)(t.h3,{id:"triggeredotherpart",children:"Triggered(otherPart)"}),"\n",(0,r.jsx)(t.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,r.jsxs)(t.p,{children:["If a ",(0,r.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,r.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,r.jsx)("code",{children:":Trigger"}),", but not ",(0,r.jsx)("code",{children:"TriggerPort"}),"), it ",(0,r.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,r.jsxs)(t.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,r.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,r.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,r.jsxs)(t.p,{children:["The ",(0,r.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,r.jsx)("code",{children:"PilotObject"}),"."]})]})}function h(e={}){const{wrapper:t}={...(0,a.R)(),...e.components};return t?(0,r.jsx)(t,{...e,children:(0,r.jsx)(d,{...e})}):d(e)}},8453:(e,t,n)=>{n.d(t,{R:()=>l,x:()=>o});var i=n(6540);const r={},a=i.createContext(r);function l(e){const t=i.useContext(a);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function o(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:l(e.components),i.createElement(a.Provider,{value:t},e.children)}}}]);
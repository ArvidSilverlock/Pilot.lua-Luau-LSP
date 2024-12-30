"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[9202],{8172:(e,a,t)=>{t.r(a),t.d(a,{assets:()=>o,contentTitle:()=>s,default:()=>h,frontMatter:()=>l,metadata:()=>i,toc:()=>c});const i=JSON.parse('{"id":"objects/Railgun","title":"Railgun","description":"Fires a piercing Rail at high speeds. A long range weapon. Requires Rails and electricity for ammo. The damage increases for every 10 studs of length.","source":"@site/docs/objects/Railgun.md","sourceDirName":"objects","slug":"/objects/Railgun","permalink":"/Pilot.lua-Luau-LSP/objects/Railgun","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Weapons","permalink":"/Pilot.lua-Luau-LSP/tags/weapons"},{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Weapons","Electrical","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Rail","permalink":"/Pilot.lua-Luau-LSP/objects/Rail"},"next":{"title":"Reactor","permalink":"/Pilot.lua-Luau-LSP/objects/Reactor"}}');var r=t(4848),n=t(8453);const l={tags:["Weapons","Electrical","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},s=void 0,o={},c=[{value:"Events",id:"events",level:2},{value:"Damaged(damage, damageType, damageSource)",id:"damageddamage-damagetype-damagesource",level:3},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3},{value:"Triggered(otherPart)",id:"triggeredotherpart",level:3}];function d(e){const a={h2:"h2",h3:"h3",hr:"hr",li:"li",p:"p",ul:"ul",...(0,n.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsxs)(a.p,{children:["Fires a piercing ",(0,r.jsx)("code",{children:"Rail"})," at high speeds. A long range weapon. Requires ",(0,r.jsx)("code",{children:"Rail"}),"s and electricity for ammo. The damage increases for every 10 studs of length.\nIt will pierce if the hit part is destroyed. Must be at least have a width and height of 6 and at least a length of 30 to function.\nWhile the ",(0,r.jsx)("code",{children:"Railgun"})," is similar to the ",(0,r.jsx)("code",{children:"Artillery"}),", the ",(0,r.jsx)("code",{children:"Railgun"})," is nearly instant while ",(0,r.jsx)("code",{children:"Artillery"})," is a projectile weapon."]}),"\n",(0,r.jsxs)(a.p,{children:["Requires to charge for one minute before it can fire. While charging and when charged, it creates large amount of heat. The charging status resets when this part is damaged.\nWhen it is finished charging, it will stop creating a sound. At that point, it must be triggered and supplied by a ",(0,r.jsx)("code",{children:"Rail"})," bin in order to fire."]}),"\n",(0,r.jsx)(a.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(a.p,{children:"It has a malleability of 2560."}),"\n",(0,r.jsx)(a.p,{children:"At its default size (6x30x6) it has a durability of 8, at its maximum size it has a durability of 11."}),"\n",(0,r.jsxs)(a.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#A3A2A5"},children:"#a3a2a5"}),"."]}),"\n",(0,r.jsxs)(a.p,{children:["It requires 5 ",(0,r.jsx)("code",{children:"AlienCore"}),", 30 ",(0,r.jsx)("code",{children:"Diamond"}),", 50 ",(0,r.jsx)("code",{children:"Gun"}),", 1 ",(0,r.jsx)("code",{children:"Rail"}),", 300 ",(0,r.jsx)("code",{children:"Titanium"}),", and 60 ",(0,r.jsx)("code",{children:"Transformer"})," to be crafted."]}),"\n",(0,r.jsx)(a.h2,{id:"events",children:"Events"}),"\n",(0,r.jsx)(a.hr,{}),"\n",(0,r.jsx)(a.h3,{id:"damageddamage-damagetype-damagesource",children:"Damaged(damage, damageType, damageSource)"}),"\n",(0,r.jsx)(a.p,{children:"Fires when the object is damaged."}),"\n",(0,r.jsxs)(a.p,{children:["The parameters for ",(0,r.jsx)("code",{children:"Damaged"})," are as follows:"]}),"\n",(0,r.jsxs)(a.ul,{children:["\n",(0,r.jsxs)(a.li,{children:["The ",(0,r.jsx)("b",{children:"damage"})," parameter is the numerical damage dealt. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsxs)(a.li,{children:["The ",(0,r.jsx)("b",{children:"damageType"})," parameter is the type of damage dealt. It is a string that can be ",(0,r.jsx)("code",{children:"Kinetic"})," or ",(0,r.jsx)("code",{children:"Energy"})]}),"\n",(0,r.jsxs)(a.li,{children:["The ",(0,r.jsx)("b",{children:"damageSource"})," parameter is will return a reference to the attacking object, seems to provide references to ",(0,r.jsx)("code",{children:"EnergyGun"}),"s, ",(0,r.jsx)("code",{children:"Laser"}),"s and ",(0,r.jsx)("code",{children:"Gun"}),"s, but not ",(0,r.jsx)("code",{children:"Blade"}),"s or ",(0,r.jsx)("code",{children:"PlasmaCannon"}),"s, there are other members of these lists that are untested. It is a ",(0,r.jsx)("code",{children:"PilotObject"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n"]}),"\n",(0,r.jsx)(a.hr,{}),"\n",(0,r.jsx)(a.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,r.jsx)(a.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,r.jsxs)(a.p,{children:["The ",(0,r.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,r.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,r.jsx)("code",{children:"1"}),"). It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(a.hr,{}),"\n",(0,r.jsx)(a.h3,{id:"triggeredotherpart",children:"Triggered(otherPart)"}),"\n",(0,r.jsx)(a.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,r.jsxs)(a.p,{children:["If a ",(0,r.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,r.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,r.jsx)("code",{children:":Trigger"}),", but not ",(0,r.jsx)("code",{children:"TriggerPort"}),"), it ",(0,r.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,r.jsxs)(a.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,r.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,r.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,r.jsxs)(a.p,{children:["The ",(0,r.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,r.jsx)("code",{children:"PilotObject"}),"."]})]})}function h(e={}){const{wrapper:a}={...(0,n.R)(),...e.components};return a?(0,r.jsx)(a,{...e,children:(0,r.jsx)(d,{...e})}):d(e)}},8453:(e,a,t)=>{t.d(a,{R:()=>l,x:()=>s});var i=t(6540);const r={},n=i.createContext(r);function l(e){const a=i.useContext(n);return i.useMemo((function(){return"function"==typeof e?e(a):{...a,...e}}),[a,e])}function s(e){let a;return a=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:l(e.components),i.createElement(n.Provider,{value:a},e.children)}}}]);
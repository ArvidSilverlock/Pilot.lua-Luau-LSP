"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[8509],{2037:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>c,contentTitle:()=>s,default:()=>d,frontMatter:()=>o,metadata:()=>n,toc:()=>l});const n=JSON.parse('{"id":"objects/SteamTurbine","title":"SteamTurbine","description":"Produces power from steam at a base rate of 100 power each. Improves up to 250 per steam if consecutively ran at max speed. All bonuses are capped to the real consumption rate, so more steam equals better efficiency, but faster consumption rates. It may consume +0.5/s^2 steam, up to a maximum rate of 10 steam per second (for a total of 2500 power per second). Has a 10% chance to recover water for every steam consumed, improving up to 20%. Maximum efficiency can be reached in no less than 18 seconds if fed an optimal amount of steam.","source":"@site/docs/objects/SteamTurbine.md","sourceDirName":"objects","slug":"/objects/SteamTurbine","permalink":"/Pilot.lua-Luau-LSP/objects/SteamTurbine","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"SteamEngine","permalink":"/Pilot.lua-Luau-LSP/objects/SteamEngine"},"next":{"title":"Stick","permalink":"/Pilot.lua-Luau-LSP/objects/Stick"}}');var i=a(4848),r=a(8453);const o={tags:["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},s=void 0,c={},l=[{value:"Methods",id:"methods",level:2},{value:"GetEfficiency() \u2192 efficiency",id:"getefficiency--efficiency",level:3},{value:"GetProductionRate() \u2192 productionRate",id:"getproductionrate--productionrate",level:3},{value:"Events",id:"events",level:2},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3}];function u(e){const t={h2:"h2",h3:"h3",hr:"hr",p:"p",...(0,r.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.p,{children:"Produces power from steam at a base rate of 100 power each. Improves up to 250 per steam if consecutively ran at max speed. All bonuses are capped to the real consumption rate, so more steam equals better efficiency, but faster consumption rates. It may consume +0.5/s^2 steam, up to a maximum rate of 10 steam per second (for a total of 2500 power per second). Has a 10% chance to recover water for every steam consumed, improving up to 20%. Maximum efficiency can be reached in no less than 18 seconds if fed an optimal amount of steam."}),"\n",(0,i.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,i.jsx)(t.p,{children:"It cannot be resized."}),"\n",(0,i.jsx)(t.p,{children:"At its default size (28x14x14) it has a durability of 1."}),"\n",(0,i.jsxs)(t.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#635F62"},children:"#635f62"}),"."]}),"\n",(0,i.jsxs)(t.p,{children:["It requires 3 ",(0,i.jsx)("code",{children:"Engine"}),", 5 ",(0,i.jsx)("code",{children:"Gear"}),", 20 ",(0,i.jsx)("code",{children:"Iron"}),", 25 ",(0,i.jsx)("code",{children:"Pipe"}),", and 10 ",(0,i.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,i.jsx)(t.h2,{id:"methods",children:"Methods"}),"\n",(0,i.jsx)(t.hr,{}),"\n",(0,i.jsx)(t.h3,{id:"getefficiency--efficiency",children:"GetEfficiency() \u2192 efficiency"}),"\n",(0,i.jsxs)(t.p,{children:["The ",(0,i.jsx)("b",{children:"efficiency"})," return is a ",(0,i.jsx)("code",{children:"number"}),"."]}),"\n",(0,i.jsx)(t.hr,{}),"\n",(0,i.jsx)(t.h3,{id:"getproductionrate--productionrate",children:"GetProductionRate() \u2192 productionRate"}),"\n",(0,i.jsx)(t.p,{children:"The multiplier for the amount of steam consumption each tick, ranges between 1 and 10."}),"\n",(0,i.jsxs)(t.p,{children:["The ",(0,i.jsx)("b",{children:"productionRate"})," return is a ",(0,i.jsx)("code",{children:"number"}),"."]}),"\n",(0,i.jsx)(t.h2,{id:"events",children:"Events"}),"\n",(0,i.jsx)(t.hr,{}),"\n",(0,i.jsx)(t.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,i.jsx)(t.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,i.jsxs)(t.p,{children:["The ",(0,i.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,i.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,i.jsx)("code",{children:"1"}),"). It is a ",(0,i.jsx)("code",{children:"number"}),"."]})]})}function d(e={}){const{wrapper:t}={...(0,r.R)(),...e.components};return t?(0,i.jsx)(t,{...e,children:(0,i.jsx)(u,{...e})}):u(e)}},8453:(e,t,a)=>{a.d(t,{R:()=>o,x:()=>s});var n=a(6540);const i={},r=n.createContext(i);function o(e){const t=n.useContext(r);return n.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function s(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:o(e.components),n.createElement(r.Provider,{value:t},e.children)}}}]);
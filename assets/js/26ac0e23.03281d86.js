"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[9227],{7228:(e,n,o)=>{o.r(n),o.d(n,{assets:()=>a,contentTitle:()=>s,default:()=>h,frontMatter:()=>r,metadata:()=>t,toc:()=>c});const t=JSON.parse('{"id":"objects/Microcontroller","title":"Microcontroller","description":"Runs limited Roblox luau code in an environment called \\"pilot.lua\\".","source":"@site/docs/objects/Microcontroller.md","sourceDirName":"objects","slug":"/objects/Microcontroller","permalink":"/Pilot.lua-Luau-LSP/objects/Microcontroller","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Logic","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Melter","permalink":"/Pilot.lua-Luau-LSP/objects/Melter"},"next":{"title":"Microphone","permalink":"/Pilot.lua-Luau-LSP/objects/Microphone"}}');var i=o(4848),l=o(8453);const r={tags:["Logic","Spawnable","Craftable","Programmable","Configurable"]},s=void 0,a={},c=[{value:"Methods",id:"methods",level:2},{value:"Receive() \u2192 (sender, ...)",id:"receive--sender-",level:3},{value:"Send(...)",id:"send",level:3},{value:"Shutdown()",id:"shutdown",level:3},{value:"Configurables",id:"configurables",level:2},{value:"Code",id:"code",level:3},{value:"StartOnSpawn",id:"startonspawn",level:3},{value:"Events",id:"events",level:2},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3},{value:"OnClick(clickerId)",id:"onclickclickerid",level:3}];function d(e){const n={h2:"h2",h3:"h3",hr:"hr",li:"li",p:"p",ul:"ul",...(0,l.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:'Runs limited Roblox luau code in an environment called "pilot.lua".\nTriggering it with a polysillicon will either start, stop, or restart (FlipFlop mode) your code.\nYou can also click it to turn it on/off.'}),"\n",(0,i.jsx)(n.p,{children:"Microcontrollers consume power depending on the amount of CPU time you use, which is the number of milliseconds your code spends doing stuff.\nPauses and waits don't count towards your CPU time since they allow the game to continue on to go do other work.\nOne CPU unit costs 1 units of power.\nIf you don't have enough power your Microcontroller will pause."}),"\n",(0,i.jsx)(n.p,{children:"Your code has a CPU limit, it can only spend up to 100 milliseconds every game tick. If you go over this limit it will pause until the next game tick."}),"\n",(0,i.jsx)(n.p,{children:"You can press F9 to view WoS's client-side output. Any logs or errors from your Microcontrollers will appear there."}),"\n",(0,i.jsx)(n.p,{children:"If you want to know about various globals you can use from Roblox's engine, you can take a look at Roblox's Developer Documentation and search for Roblox Globals and Lua Globals.\nFor more info, check the game's wiki, or look at one of the game's social platforms if it's linked at the bottom of the game page."}),"\n",(0,i.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,i.jsx)(n.p,{children:"Here is a list of possible sizes that reach the maximum malleability (100) that have integer components: 1x100x1, 1x50x2, 1x25x4, 1x20x5, 1x10x10, 2x25x2, 2x10x5, 4x5x5, 10x5x2"}),"\n",(0,i.jsx)(n.p,{children:"At its default size (3x0.50x2) it has a durability of 1, at its maximum size it has a durability of 4."}),"\n",(0,i.jsxs)(n.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#2C651D"},children:"#2c651d"}),"."]}),"\n",(0,i.jsxs)(n.p,{children:["It requires 5 ",(0,i.jsx)("code",{children:"Copper"}),", 5 ",(0,i.jsx)("code",{children:"Iron"}),", 5 ",(0,i.jsx)("code",{children:"Quartz"}),", and 5 ",(0,i.jsx)("code",{children:"Silicon"})," to be crafted."]}),"\n",(0,i.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"receive--sender-",children:"Receive() \u2192 (sender, ...)"}),"\n",(0,i.jsx)(n.p,{children:"Waits for data to be received."}),"\n",(0,i.jsxs)(n.p,{children:["The returns for ",(0,i.jsx)("code",{children:"Receive"})," are as follows:"]}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"sender"})," return is the microcontroller sending the data. It is a ",(0,i.jsx)("code",{children:"Microcontroller"}),"."]}),"\n",(0,i.jsx)(n.li,{children:"The variadic return is the parameters sent through by the other microcontroller. It can be anything."}),"\n"]}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"send",children:"Send(...)"}),"\n",(0,i.jsx)(n.p,{children:"Sends the data you provide to a remote microcontroller. Parts you pass will be based on your microcontroller's context."}),"\n",(0,i.jsx)(n.p,{children:"The variadic parameter is the parameters to send to the other microcontroller. It can be anything."}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"shutdown",children:"Shutdown()"}),"\n",(0,i.jsx)(n.p,{children:"Kills the microcontroller."}),"\n",(0,i.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"code",children:"Code"}),"\n",(0,i.jsxs)(n.p,{children:["The code to be executed on this microcontroller. It is a ",(0,i.jsx)("code",{children:"string"}),"."]}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"startonspawn",children:"StartOnSpawn"}),"\n",(0,i.jsxs)(n.p,{children:["Whether or not to start the Microcontroller when it spawns. It is a ",(0,i.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,i.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,i.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,i.jsx)("code",{children:"1"}),"). It is a ",(0,i.jsx)("code",{children:"number"}),"."]}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"onclickclickerid",children:"OnClick(clickerId)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is clicked."}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"clickerId"})," parameter is the ",(0,i.jsx)("code",{children:"UserId"})," of the player who clicked the object. It is a ",(0,i.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,l.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(d,{...e})}):d(e)}},8453:(e,n,o)=>{o.d(n,{R:()=>r,x:()=>s});var t=o(6540);const i={},l=t.createContext(i);function r(e){const n=t.useContext(l);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function s(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:r(e.components),t.createElement(l.Provider,{value:n},e.children)}}}]);
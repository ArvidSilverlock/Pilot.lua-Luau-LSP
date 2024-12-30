"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[5919],{5831:(e,i,n)=>{n.r(i),n.d(i,{assets:()=>c,contentTitle:()=>a,default:()=>h,frontMatter:()=>l,metadata:()=>t,toc:()=>d});const t=JSON.parse('{"id":"objects/Assembler","title":"Assembler","description":"Assembles items as configured when the structure is supplied with the required power and resources.","source":"@site/docs/objects/Assembler.md","sourceDirName":"objects","slug":"/objects/Assembler","permalink":"/Pilot.lua-Luau-LSP/objects/Assembler","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Starter","permalink":"/Pilot.lua-Luau-LSP/tags/starter"},{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Starter","Electrical","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Asphalt","permalink":"/Pilot.lua-Luau-LSP/objects/Asphalt"},"next":{"title":"AutomaticLaser","permalink":"/Pilot.lua-Luau-LSP/objects/AutomaticLaser"}}');var r=n(4848),s=n(8453);const l={tags:["Starter","Electrical","Spawnable","Craftable","Programmable","Configurable"]},a=void 0,c={},d=[{value:"Methods",id:"methods",level:2},{value:"CalculateCraftingRecipe(items) \u2192 recipe",id:"calculatecraftingrecipeitems--recipe",level:3},{value:"CraftItems(items)",id:"craftitemsitems",level:3},{value:"GetCraftCooldown() \u2192 craftCooldown",id:"getcraftcooldown--craftcooldown",level:3},{value:"GetRecipe(itemName) \u2192 recipe",id:"getrecipeitemname--recipe",level:3},{value:"<del><i>Craft(itemName) \u2192 success</i></del>",id:"craftitemname--success",level:3},{value:"<del><i>GetInventory() \u2192 inventory</i></del>",id:"getinventory--inventory",level:3},{value:"Configurables",id:"configurables",level:2},{value:"Assemble",id:"assemble",level:3},{value:"Events",id:"events",level:2},{value:"Configured(configurerId)",id:"configuredconfigurerid",level:3},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3}];function o(e){const i={admonition:"admonition",h2:"h2",h3:"h3",hr:"hr",li:"li",p:"p",ul:"ul",...(0,s.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(i.p,{children:"Assembles items as configured when the structure is supplied with the required power and resources."}),"\n",(0,r.jsx)(i.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(i.p,{children:"It cannot be resized."}),"\n",(0,r.jsx)(i.p,{children:"At its default size (8x8x8) it has a durability of 1."}),"\n",(0,r.jsxs)(i.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#5A4C42"},children:"#5a4c42"}),"."]}),"\n",(0,r.jsxs)(i.p,{children:["It requires 3 ",(0,r.jsx)("code",{children:"Gear"}),", 2 ",(0,r.jsx)("code",{children:"Iron"}),", and 2 ",(0,r.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,r.jsx)(i.h2,{id:"methods",children:"Methods"}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"calculatecraftingrecipeitems--recipe",children:"CalculateCraftingRecipe(items) \u2192 recipe"}),"\n",(0,r.jsxs)(i.p,{children:["Returns the ingredients (including ",(0,r.jsx)("code",{children:"Power"}),"), products, and time cost of a specified crafting operation."]}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"items"})," parameter is a list of parts ",(0,r.jsx)("em",{children:"or"})," a dictionary of each part with how many of said part to craft. It can be any of the following types:"]}),"\n",(0,r.jsxs)(i.ul,{children:["\n",(0,r.jsxs)(i.li,{children:["\n",(0,r.jsx)("code",{children:"{ string }"}),"\n"]}),"\n",(0,r.jsxs)(i.li,{children:["\n",(0,r.jsx)("code",{children:"{ [string]: number }"}),"\n"]}),"\n"]}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"recipe"})," return is information relating to the crafting recipe. It is a dictionary with keys that are ",(0,r.jsx)("code",{children:"string"}),"s and values that are ",(0,r.jsx)("code",{children:"number"}),"s."]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"craftitemsitems",children:"CraftItems(items)"}),"\n",(0,r.jsx)(i.p,{children:"Will craft the specified set of items."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"items"})," parameter can be any of the following types:"]}),"\n",(0,r.jsxs)(i.ul,{children:["\n",(0,r.jsxs)(i.li,{children:["\n",(0,r.jsx)("code",{children:"{ string }"}),"\n"]}),"\n",(0,r.jsxs)(i.li,{children:["\n",(0,r.jsx)("code",{children:"{ [string]: number }"}),"\n"]}),"\n"]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"getcraftcooldown--craftcooldown",children:"GetCraftCooldown() \u2192 craftCooldown"}),"\n",(0,r.jsx)(i.p,{children:"How long until the assembler can craft again."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"craftCooldown"})," return is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"getrecipeitemname--recipe",children:"GetRecipe(itemName) \u2192 recipe"}),"\n",(0,r.jsx)(i.p,{children:"Returns the resource(s) required to craft the given item, or nil if the item doesn't have a recipe/doesn't exist."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"itemName"})," parameter is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"recipe"})," return is a dictionary with keys that are ",(0,r.jsx)("code",{children:"string"}),"s and values that are ",(0,r.jsx)("code",{children:"number"}),"s."]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"craftitemname--success",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"Craft(itemName) \u2192 success"})})}),"\n",(0,r.jsx)(i.admonition,{type:"warning",children:(0,r.jsx)(i.p,{children:"This method is deprecated."})}),"\n",(0,r.jsx)(i.p,{children:"Will pause and craft the desired item at the next available point, returning a boolean representing whether or not the item was successfully crafted."}),"\n",(0,r.jsx)(i.p,{children:"This uses a queue under the hood, the first thing to call it gets to craft first, and then finally the assembler performs its configured craft if nothing else is queued."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"itemName"})," parameter is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"success"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"getinventory--inventory",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetInventory() \u2192 inventory"})})}),"\n",(0,r.jsx)(i.admonition,{type:"warning",children:(0,r.jsx)(i.p,{children:"This method is deprecated. Returns an empty, frozen table."})}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"inventory"})," return is a dictionary with keys that are ",(0,r.jsx)("code",{children:"string"}),"s and values that are ",(0,r.jsx)("code",{children:"number"}),"s."]}),"\n",(0,r.jsx)(i.h2,{id:"configurables",children:"Configurables"}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"assemble",children:"Assemble"}),"\n",(0,r.jsxs)(i.p,{children:["The name of the object to be assembled. It is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsx)(i.h2,{id:"events",children:"Events"}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"configuredconfigurerid",children:"Configured(configurerId)"}),"\n",(0,r.jsx)(i.p,{children:"Fires when the object is configured."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"configurerId"})," parameter is the ",(0,r.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(i.hr,{}),"\n",(0,r.jsx)(i.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,r.jsx)(i.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,r.jsxs)(i.p,{children:["The ",(0,r.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,r.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,r.jsx)("code",{children:"1"}),"). It is a ",(0,r.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:i}={...(0,s.R)(),...e.components};return i?(0,r.jsx)(i,{...e,children:(0,r.jsx)(o,{...e})}):o(e)}},8453:(e,i,n)=>{n.d(i,{R:()=>l,x:()=>a});var t=n(6540);const r={},s=t.createContext(r);function l(e){const i=t.useContext(s);return t.useMemo((function(){return"function"==typeof e?e(i):{...i,...e}}),[i,e])}function a(e){let i;return i=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:l(e.components),t.createElement(s.Provider,{value:i},e.children)}}}]);
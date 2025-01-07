"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[6210],{2990:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>c,contentTitle:()=>l,default:()=>u,frontMatter:()=>o,metadata:()=>i,toc:()=>a});const i=JSON.parse('{"id":"objects/DevSink","title":"DevSink","description":"A debug item meant for developers.","source":"@site/docs/objects/DevSink.md","sourceDirName":"objects","slug":"/objects/DevSink","permalink":"/Pilot.lua-Luau-LSP/objects/DevSink","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Unused","permalink":"/Pilot.lua-Luau-LSP/tags/unused"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Unused","Spawnable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"DevHeatStorage","permalink":"/Pilot.lua-Luau-LSP/objects/DevHeatStorage"},"next":{"title":"DevSource","permalink":"/Pilot.lua-Luau-LSP/objects/DevSource"}}');var s=r(4848),t=r(8453);const o={tags:["Unused","Spawnable","Programmable","Configurable"]},l=void 0,c={},a=[{value:"Methods",id:"methods",level:2},{value:"GetAmountConsumed(...) \u2192 ...",id:"getamountconsumed--",level:3},{value:"GetResource() \u2192 resource",id:"getresource--resource",level:3},{value:"GetResourceAmount() \u2192 amount",id:"getresourceamount--amount",level:3},{value:"<del><i>GetAmount() \u2192 amount</i></del>",id:"getamount--amount",level:3},{value:"Configurables",id:"configurables",level:2},{value:"Resource",id:"resource",level:3},{value:"Events",id:"events",level:2},{value:"Configured(configurerId)",id:"configuredconfigurerid",level:3},{value:"ContainerChanged(resourceType, resourceAmount)",id:"containerchangedresourcetype-resourceamount",level:3},{value:"OnClick(clickerId)",id:"onclickclickerid",level:3}];function d(e){const n={admonition:"admonition",h2:"h2",h3:"h3",hr:"hr",li:"li",p:"p",ul:"ul",...(0,t.R)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(n.p,{children:"A debug item meant for developers."}),"\n",(0,s.jsx)(n.p,{children:"It is a spawnable non-flammable solid."}),"\n",(0,s.jsx)(n.p,{children:"It has a malleability of 1000000."}),"\n",(0,s.jsx)(n.p,{children:"At its default size (2x2x2) it has a durability of 100000000, at its maximum size it has a durability of 5000000000."}),"\n",(0,s.jsxs)(n.p,{children:["By default, its colour is ",(0,s.jsx)("span",{style:{color:"#A3A3A3"},children:"#a3a3a3"}),"."]}),"\n",(0,s.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"getamountconsumed--",children:"GetAmountConsumed(...) \u2192 ..."}),"\n",(0,s.jsx)(n.p,{children:"The variadic parameter is unknown. It can be anything."}),"\n",(0,s.jsx)(n.p,{children:"The variadic return is unknown. It can be anything."}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"getresource--resource",children:"GetResource() \u2192 resource"}),"\n",(0,s.jsxs)(n.p,{children:["Gets the name of the resource contained, will return the ",(0,s.jsx)("i",{children:"string"})," ",(0,s.jsx)("code",{children:'"nil"'})," if nothing is stored, rather than ",(0,s.jsx)("i",{children:"actually"})," returning ",(0,s.jsx)("code",{children:"nil"}),"."]}),"\n",(0,s.jsxs)(n.p,{children:["The ",(0,s.jsx)("b",{children:"resource"})," return can be any of the following types:"]}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)("code",{children:"string"}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)("code",{children:'"nil"'}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"getresourceamount--amount",children:"GetResourceAmount() \u2192 amount"}),"\n",(0,s.jsx)(n.p,{children:"Gives you the total amount of objects in the container."}),"\n",(0,s.jsxs)(n.p,{children:["The ",(0,s.jsx)("b",{children:"amount"})," return is a ",(0,s.jsx)("code",{children:"number"}),"."]}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"getamount--amount",children:(0,s.jsx)("del",{children:(0,s.jsx)("i",{children:"GetAmount() \u2192 amount"})})}),"\n",(0,s.jsx)(n.admonition,{type:"warning",children:(0,s.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,s.jsxs)("code",{children:[":GetResourceAmount","()"]})," instead."]})}),"\n",(0,s.jsx)(n.p,{children:"Gives you the total amount of objects in the container."}),"\n",(0,s.jsxs)(n.p,{children:["The ",(0,s.jsx)("b",{children:"amount"})," return is a ",(0,s.jsx)("code",{children:"number"}),"."]}),"\n",(0,s.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"resource",children:"Resource"}),"\n",(0,s.jsxs)(n.p,{children:["The name of the object to produce a sink for. It is a ",(0,s.jsx)("code",{children:"ResourceString"}),"."]}),"\n",(0,s.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"configuredconfigurerid",children:"Configured(configurerId)"}),"\n",(0,s.jsx)(n.p,{children:"Fires when the object is configured."}),"\n",(0,s.jsxs)(n.p,{children:["The ",(0,s.jsx)("b",{children:"configurerId"})," parameter is the ",(0,s.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,s.jsx)("code",{children:"number"}),"."]}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"containerchangedresourcetype-resourceamount",children:"ContainerChanged(resourceType, resourceAmount)"}),"\n",(0,s.jsx)(n.p,{children:"Fires when the amount of the resource in the container changes."}),"\n",(0,s.jsxs)(n.p,{children:["The parameters for ",(0,s.jsx)("code",{children:"ContainerChanged"})," are as follows:"]}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["The ",(0,s.jsx)("b",{children:"resourceType"})," parameter is a string that can be ",(0,s.jsx)("code",{children:"Power"}),", ",(0,s.jsx)("code",{children:"Solid"}),",  or ",(0,s.jsx)("code",{children:"Fluid"})]}),"\n",(0,s.jsxs)(n.li,{children:["The ",(0,s.jsx)("b",{children:"resourceAmount"})," parameter is a ",(0,s.jsx)("code",{children:"number"}),"."]}),"\n"]}),"\n",(0,s.jsx)(n.hr,{}),"\n",(0,s.jsx)(n.h3,{id:"onclickclickerid",children:"OnClick(clickerId)"}),"\n",(0,s.jsx)(n.p,{children:"Fires when the object is clicked."}),"\n",(0,s.jsxs)(n.p,{children:["The ",(0,s.jsx)("b",{children:"clickerId"})," parameter is the ",(0,s.jsx)("code",{children:"UserId"})," of the player who clicked the object. It is a ",(0,s.jsx)("code",{children:"number"}),"."]})]})}function u(e={}){const{wrapper:n}={...(0,t.R)(),...e.components};return n?(0,s.jsx)(n,{...e,children:(0,s.jsx)(d,{...e})}):d(e)}},8453:(e,n,r)=>{r.d(n,{R:()=>o,x:()=>l});var i=r(6540);const s={},t=i.createContext(s);function o(e){const n=i.useContext(t);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:o(e.components),i.createElement(t.Provider,{value:n},e.children)}}}]);
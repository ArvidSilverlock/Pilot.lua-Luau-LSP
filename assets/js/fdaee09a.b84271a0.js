"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[170],{28453:(e,t,n)=>{n.d(t,{R:()=>i,x:()=>s});var a=n(96540);const o={},r=a.createContext(o);function i(e){const t=a.useContext(r);return a.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function s(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:i(e.components),a.createElement(r.Provider,{value:t},e.children)}},56046:(e,t,n)=>{n.d(t,{A:()=>w});var a=n(96540),o=n(34164),r=n(21312),i=n(6342),s=(n(38193),n(89532)),c=n(89466),l=n(74848);const d=a.createContext(void 0),u="theme";(0,c.Wf)(u);function h(){const e=(0,a.useContext)(d);if(null==e)throw new s.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var m=n(28774),p=n(63427),f=n(92303);function b(e){let{children:t,fallback:n}=e;return(0,f.A)()?(0,l.jsx)(l.Fragment,{children:t?.()}):n??null}var x=n(61409),j=n(81113);function v(e){return(0,l.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,l.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const g={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var k=n(56347);function w(e){let{id:t,group:n,...a}=e;const s=(0,p.A)(),{navbar:{hideOnScroll:c}}=(0,i.p)();s.collectAnchor(t);const d="group"===n?"h2":"h3",u=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:t}),f=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:t}),w=(0,k.zy)().pathname;return(0,l.jsxs)(d,{...a,className:(0,o.A)("anchor",c?g.anchorWithHideOnScrollNavbar:g.anchorWithStickyNavbar,a.className),id:t,children:[a.children,(0,l.jsx)(m.A,{className:"icon-link",to:`#${t}`,"aria-label":u,title:u,children:(0,l.jsx)(v,{width:"0.75em",height:"0.75em"})}),(0,l.jsx)(b,{children:()=>{const e=location.pathname.split("/").filter(Boolean),a=e[e.length-1],o=`[${"group"==n?`\`${a}\`'s ${t.toLowerCase()}`:"method"==n?`\`${a}:${t}()\``:`\`${a}.${t}\``}](<${`${window.location.origin}${w}#${t}`}>)`;return(0,l.jsx)("a",{className:"icon-link","aria-label":f,title:f,onClick:()=>{x.oR.dark((0,l.jsxs)("a",{children:["Copied the ",(0,l.jsx)("code",{children:t})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:h().colorMode,transition:x.GP}),navigator.clipboard.writeText(o)},children:(0,l.jsx)(j.A,{width:"0.75em",height:"0.75em"})})}})]})}},65973:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>l,contentTitle:()=>c,default:()=>h,frontMatter:()=>s,metadata:()=>a,toc:()=>d});const a=JSON.parse('{"id":"objects/SteamTurbine","title":"SteamTurbine","description":"Produces power from steam at a base rate of 100 power each. Improves up to 250 per steam if consecutively ran at max speed. All bonuses are capped to the real consumption rate, so more steam equals better efficiency, but faster consumption rates. It may consume +0.5/s^2 steam, up to a maximum rate of 10 steam per second (for a total of 2500 power per second). Has a 10% chance to recover water for every steam consumed, improving up to 20%. Maximum efficiency can be reached in no less than 18 seconds if fed an optimal amount of steam.","source":"@site/docs/objects/SteamTurbine.mdx","sourceDirName":"objects","slug":"/objects/SteamTurbine","permalink":"/Pilot.lua-Luau-LSP/objects/SteamTurbine","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"SteamEngine","permalink":"/Pilot.lua-Luau-LSP/objects/SteamEngine"},"next":{"title":"Stick","permalink":"/Pilot.lua-Luau-LSP/objects/Stick"}}');var o=n(74848),r=n(28453),i=n(56046);const s={tags:["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},c=void 0,l={},d=[{value:"Methods",id:"Methods",level:2},{value:"GetEfficiency()",id:"GetEfficiency",level:3},{value:"GetProductionRate()",id:"GetProductionRate",level:3},{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3}];function u(e){const t={hr:"hr",p:"p",...(0,r.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(t.p,{children:"Produces power from steam at a base rate of 100 power each. Improves up to 250 per steam if consecutively ran at max speed. All bonuses are capped to the real consumption rate, so more steam equals better efficiency, but faster consumption rates. It may consume +0.5/s^2 steam, up to a maximum rate of 10 steam per second (for a total of 2500 power per second). Has a 10% chance to recover water for every steam consumed, improving up to 20%. Maximum efficiency can be reached in no less than 18 seconds if fed an optimal amount of steam."}),"\n",(0,o.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,o.jsx)(t.p,{children:"It cannot be resized."}),"\n",(0,o.jsx)(t.p,{children:"At its default size (28x14x14) it has a durability of 1."}),"\n",(0,o.jsxs)(t.p,{children:["By default, its colour is ",(0,o.jsx)("span",{style:{color:"#635F62"},children:"#635f62"}),"."]}),"\n",(0,o.jsxs)(t.p,{children:["It requires 3 ",(0,o.jsx)("code",{children:"Engine"}),", 5 ",(0,o.jsx)("code",{children:"Gear"}),", 20 ",(0,o.jsx)("code",{children:"Iron"}),", 25 ",(0,o.jsx)("code",{children:"Pipe"}),", and 10 ",(0,o.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,o.jsx)(i.A,{id:"Methods",group:"group",children:"Methods"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(i.A,{id:"GetEfficiency",group:"method",children:"GetEfficiency() \u2192 efficiency"}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"efficiency"})," return is a ",(0,o.jsx)("code",{children:"number"}),"."]}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(i.A,{id:"GetProductionRate",group:"method",children:"GetProductionRate() \u2192 productionRate"}),"\n",(0,o.jsx)(t.p,{children:"The multiplier for the amount of steam consumption each tick, ranges between 1 and 10."}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"productionRate"})," return is a ",(0,o.jsx)("code",{children:"number"}),"."]}),"\n",(0,o.jsx)(i.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(i.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,o.jsx)(t.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,o.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,o.jsx)("code",{children:"1"}),"). It is a ",(0,o.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:t}={...(0,r.R)(),...e.components};return t?(0,o.jsx)(t,{...e,children:(0,o.jsx)(u,{...e})}):u(e)}},81113:(e,t,n)=>{n.d(t,{A:()=>o});n(96540);var a=n(74848);function o(e){return(0,a.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,a.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[2202],{8818:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>d,contentTitle:()=>l,default:()=>u,frontMatter:()=>s,metadata:()=>n,toc:()=>c});const n=JSON.parse('{"id":"objects/Treads","title":"Treads","description":"Moves against surfaces it contacts. In order for the treads to function, you need to use a Motor, Engine, or DriveBox to spin up a part which will act as the driver part. The driver part should be connected to the treads via a rod, and should spin with the same orientation as a wheel would to achieve maximum speed.","source":"@site/docs/objects/Treads.mdx","sourceDirName":"objects","slug":"/objects/Treads","permalink":"/Pilot.lua-Luau-LSP/objects/Treads","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Propulsion","permalink":"/Pilot.lua-Luau-LSP/tags/propulsion"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Propulsion","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Transporter","permalink":"/Pilot.lua-Luau-LSP/objects/Transporter"},"next":{"title":"TriggerRelay","permalink":"/Pilot.lua-Luau-LSP/objects/TriggerRelay"}}');var r=a(4848),i=a(8453),o=a(9907);const s={tags:["Propulsion","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},l=void 0,d={},c=[{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3}];function h(e){const t={hr:"hr",p:"p",...(0,i.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(t.p,{children:"Moves against surfaces it contacts. In order for the treads to function, you need to use a Motor, Engine, or DriveBox to spin up a part which will act as the driver part. The driver part should be connected to the treads via a rod, and should spin with the same orientation as a wheel would to achieve maximum speed."}),"\n",(0,r.jsx)(t.p,{children:"Multiple driver parts can be attached to the treads at once, and their speeds will be added together. The treads will move depending on the direction & speed that the driver part spins."}),"\n",(0,r.jsx)(t.p,{children:"The speed the treads move depends entirely on the speed of rotation on the axis perpendicular to the treads, so rotating the driver part off-axis will reduce (or invert) the speed. For example, 45 degrees off-axis = 50% speed, 90 degrees off-axis = 0% speed, 135 degrees off-axis = -50% speed, and 180 degrees off-axis = -100% speed."}),"\n",(0,r.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (80) that have integer components: 1x80x1, 1x40x2, 1x20x4, 1x16x5, 1x10x8, 2x20x2, 2x10x4, 2x8x5, 4x5x4, 5x4x4, 8x5x2"}),"\n",(0,r.jsx)(t.p,{children:"At its default size (2x2x6) it has a durability of 1, at its maximum size it has a durability of 2."}),"\n",(0,r.jsxs)(t.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#635F62"},children:"#635f62"}),"."]}),"\n",(0,r.jsxs)(t.p,{children:["It requires 2 ",(0,r.jsx)("code",{children:"Engine"}),", 16 ",(0,r.jsx)("code",{children:"Gear"}),", and 2 ",(0,r.jsx)("code",{children:"Rubber"})," to be crafted."]}),"\n",(0,r.jsx)(o.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,r.jsx)(t.hr,{}),"\n",(0,r.jsx)(o.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,r.jsx)(t.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,r.jsxs)(t.p,{children:["The ",(0,r.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,r.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,r.jsx)("code",{children:"1"}),"). It is a ",(0,r.jsx)("code",{children:"number"}),"."]})]})}function u(e={}){const{wrapper:t}={...(0,i.R)(),...e.components};return t?(0,r.jsx)(t,{...e,children:(0,r.jsx)(h,{...e})}):h(e)}},1113:(e,t,a)=>{a.d(t,{A:()=>r});a(6540);var n=a(4848);function r(e){return(0,n.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,n.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}},9907:(e,t,a)=>{a.d(t,{A:()=>f});a(6540);var n=a(4164),r=a(1312),i=a(6342),o=a(5293),s=a(8774),l=a(3427),d=a(2303),c=a(4848);function h(e){let{children:t,fallback:a}=e;return(0,d.A)()?(0,c.jsx)(c.Fragment,{children:t?.()}):a??null}var u=a(1409),p=a(1113);function x(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const m={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var b=a(6347);function f(e){let{id:t,group:a,...d}=e;const f=(0,l.A)(),{navbar:{hideOnScroll:g}}=(0,i.p)();f.collectAnchor(t);const v="group"===a?"h2":"h3",j=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:t}),w=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:t}),k=(0,o.G)().colorMode,P=(0,b.zy)().pathname;return(0,c.jsxs)(v,{...d,className:(0,n.A)("anchor",g?m.anchorWithHideOnScrollNavbar:m.anchorWithStickyNavbar,d.className),id:t,children:[d.children,(0,c.jsx)(s.A,{className:"icon-link",to:`#${t}`,"aria-label":j,title:j,children:(0,c.jsx)(x,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(h,{children:()=>{const e=location.pathname.split("/").filter(Boolean),n=e[e.length-1],r=`[${"group"==a?`\`${n}\`'s ${t.toLowerCase()}`:"method"==a?`\`${n}:${t}()\``:`\`${n}.${t}\``}](<${`${window.location.origin}${P}#${t}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":w,title:w,onClick:()=>{u.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:t})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:k,transition:u.GP}),navigator.clipboard.writeText(r)},children:(0,c.jsx)(p.A,{width:"0.75em",height:"0.75em"})})}})]})}},8453:(e,t,a)=>{a.d(t,{R:()=>o,x:()=>s});var n=a(6540);const r={},i=n.createContext(r);function o(e){const t=n.useContext(i);return n.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function s(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:o(e.components),n.createElement(i.Provider,{value:t},e.children)}}}]);
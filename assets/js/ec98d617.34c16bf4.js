"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[2850],{28453:(e,n,t)=>{t.d(n,{R:()=>a,x:()=>l});var i=t(96540);const o={},r=i.createContext(o);function a(e){const n=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:a(e.components),i.createElement(r.Provider,{value:n},e.children)}},56046:(e,n,t)=>{t.d(n,{A:()=>C});var i=t(96540),o=t(34164),r=t(21312),a=t(6342),l=(t(38193),t(89532)),s=t(89466),c=t(74848);const d=i.createContext(void 0),u="theme";(0,s.Wf)(u);function h(){const e=(0,i.useContext)(d);if(null==e)throw new l.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var p=t(28774),m=t(63427),b=t(92303);function f(e){let{children:n,fallback:t}=e;return(0,b.A)()?(0,c.jsx)(c.Fragment,{children:n?.()}):t??null}var g=t(61409),x=t(81113);function j(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const v={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var k=t(56347);function C(e){let{id:n,group:t,...i}=e;const l=(0,m.A)(),{navbar:{hideOnScroll:s}}=(0,a.p)();l.collectAnchor(n);const d="group"===t?"h2":"h3",u=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),b=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),C=(0,k.zy)().pathname;return(0,c.jsxs)(d,{...i,className:(0,o.A)("anchor",s?v.anchorWithHideOnScrollNavbar:v.anchorWithStickyNavbar,i.className),id:n,children:[i.children,(0,c.jsx)(p.A,{className:"icon-link",to:`#${n}`,"aria-label":u,title:u,children:(0,c.jsx)(j,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(f,{children:()=>{const e=location.pathname.split("/").filter(Boolean),i=e[e.length-1],o=`[${"group"==t?`\`${i}\`'s ${n.toLowerCase()}`:"method"==t?`\`${i}:${n}()\``:`\`${i}.${n}\``}](<${`${window.location.origin}${C}#${n}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":b,title:b,onClick:()=>{g.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:h().colorMode,transition:g.GP}),navigator.clipboard.writeText(o)},children:(0,c.jsx)(x.A,{width:"0.75em",height:"0.75em"})})}})]})}},71944:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>h,frontMatter:()=>l,metadata:()=>i,toc:()=>d});const i=JSON.parse('{"id":"objects/CombustionTurbine","title":"CombustionTurbine","description":"Creates electricity when fueled by gasoline.","source":"@site/docs/objects/CombustionTurbine.mdx","sourceDirName":"objects","slug":"/objects/CombustionTurbine","permalink":"/Pilot.lua-Luau-LSP/objects/CombustionTurbine","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Coal","permalink":"/Pilot.lua-Luau-LSP/objects/Coal"},"next":{"title":"Component","permalink":"/Pilot.lua-Luau-LSP/objects/Component"}}');var o=t(74848),r=t(28453),a=t(56046);const l={tags:["Electrical","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},s=void 0,c={},d=[{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3}];function u(e){const n={hr:"hr",p:"p",...(0,r.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(n.p,{children:"Creates electricity when fueled by gasoline."}),"\n",(0,o.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,o.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,o.jsx)(n.p,{children:"At its default size (14x7x7) it has a durability of 1."}),"\n",(0,o.jsxs)(n.p,{children:["By default, its colour is ",(0,o.jsx)("span",{style:{color:"#CDCDCD"},children:"#cdcdcd"}),"."]}),"\n",(0,o.jsxs)(n.p,{children:["It requires 3 ",(0,o.jsx)("code",{children:"Engine"}),", 5 ",(0,o.jsx)("code",{children:"Gear"}),", 20 ",(0,o.jsx)("code",{children:"Iron"}),", 25 ",(0,o.jsx)("code",{children:"Pipe"}),", and 10 ",(0,o.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,o.jsx)(a.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,o.jsx)(n.hr,{}),"\n",(0,o.jsx)(a.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,o.jsx)(n.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,o.jsxs)(n.p,{children:["The ",(0,o.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,o.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,o.jsx)("code",{children:"1"}),"). It is a ",(0,o.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,r.R)(),...e.components};return n?(0,o.jsx)(n,{...e,children:(0,o.jsx)(u,{...e})}):u(e)}},81113:(e,n,t)=>{t.d(n,{A:()=>o});t(96540);var i=t(74848);function o(e){return(0,i.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,i.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
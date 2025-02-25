"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[1539],{28453:(e,n,t)=>{t.d(n,{R:()=>i,x:()=>l});var r=t(96540);const a={},o=r.createContext(a);function i(e){const n=r.useContext(o);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:i(e.components),r.createElement(o.Provider,{value:n},e.children)}},56046:(e,n,t)=>{t.d(n,{A:()=>w});var r=t(96540),a=t(34164),o=t(21312),i=t(6342),l=(t(38193),t(89532)),s=t(89466),c=t(74848);const d=r.createContext(void 0),u="theme";(0,s.Wf)(u);function h(){const e=(0,r.useContext)(d);if(null==e)throw new l.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var p=t(28774),m=t(63427),b=t(92303);function x(e){let{children:n,fallback:t}=e;return(0,b.A)()?(0,c.jsx)(c.Fragment,{children:n?.()}):t??null}var g=t(61409),f=t(81113);function j(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const v={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var k=t(56347);function w(e){let{id:n,group:t,...r}=e;const l=(0,m.A)(),{navbar:{hideOnScroll:s}}=(0,i.p)();l.collectAnchor(n);const d="group"===t?"h2":"h3",u=(0,o.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),b=(0,o.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),w=(0,k.zy)().pathname;return(0,c.jsxs)(d,{...r,className:(0,a.A)("anchor",s?v.anchorWithHideOnScrollNavbar:v.anchorWithStickyNavbar,r.className),id:n,children:[r.children,(0,c.jsx)(p.A,{className:"icon-link",to:`#${n}`,"aria-label":u,title:u,children:(0,c.jsx)(j,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(x,{children:()=>{const e=location.pathname.split("/").filter(Boolean),r=e[e.length-1],a=`[${"group"==t?`\`${r}\`'s ${n.toLowerCase()}`:"method"==t?`\`${r}:${n}()\``:`\`${r}.${n}\``}](<${`${window.location.origin}${w}#${n}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":b,title:b,onClick:()=>{g.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:h().colorMode,transition:g.GP}),navigator.clipboard.writeText(a)},children:(0,c.jsx)(f.A,{width:"0.75em",height:"0.75em"})})}})]})}},81113:(e,n,t)=>{t.d(n,{A:()=>a});t(96540);var r=t(74848);function a(e){return(0,r.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,r.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}},96199:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>h,frontMatter:()=>l,metadata:()=>r,toc:()=>d});const r=JSON.parse('{"id":"objects/Furnace","title":"Furnace","description":"Burns resources at 16x speed to produce Heat energy directly. Has a low thermal conductivity.","source":"@site/docs/objects/Furnace.mdx","sourceDirName":"objects","slug":"/objects/Furnace","permalink":"/Pilot.lua-Luau-LSP/objects/Furnace","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Freezer","permalink":"/Pilot.lua-Luau-LSP/objects/Freezer"},"next":{"title":"Gasoline","permalink":"/Pilot.lua-Luau-LSP/objects/Gasoline"}}');var a=t(74848),o=t(28453),i=t(56046);const l={tags:["Spawnable","Craftable","Non-Programmable","Non-Configurable"]},s=void 0,c={},d=[{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3}];function u(e){const n={hr:"hr",p:"p",...(0,o.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(n.p,{children:"Burns resources at 16x speed to produce Heat energy directly. Has a low thermal conductivity."}),"\n",(0,a.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,a.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,a.jsx)(n.p,{children:"At its default size (5x5x5) it has a durability of 1."}),"\n",(0,a.jsxs)(n.p,{children:["By default, its colour is ",(0,a.jsx)("span",{style:{color:"#111111"},children:"#111111"}),"."]}),"\n",(0,a.jsxs)(n.p,{children:["It requires 2 ",(0,a.jsx)("code",{children:"Copper"}),", 4 ",(0,a.jsx)("code",{children:"HeatPipe"}),", 2 ",(0,a.jsx)("code",{children:"HeatPump"}),", 1 ",(0,a.jsx)("code",{children:"Igniter"}),", and 4 ",(0,a.jsx)("code",{children:"Insulation"})," to be crafted."]}),"\n",(0,a.jsx)(i.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,a.jsx)(n.hr,{}),"\n",(0,a.jsx)(i.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,a.jsx)(n.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,a.jsxs)(n.p,{children:["The ",(0,a.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,a.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,a.jsx)("code",{children:"1"}),"). It is a ",(0,a.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,o.R)(),...e.components};return n?(0,a.jsx)(n,{...e,children:(0,a.jsx)(u,{...e})}):u(e)}}}]);
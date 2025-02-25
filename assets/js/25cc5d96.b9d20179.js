"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[8660],{28453:(e,n,t)=>{t.d(n,{R:()=>o,x:()=>l});var a=t(96540);const i={},r=a.createContext(i);function o(e){const n=a.useContext(r);return a.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:o(e.components),a.createElement(r.Provider,{value:n},e.children)}},56046:(e,n,t)=>{t.d(n,{A:()=>k});var a=t(96540),i=t(34164),r=t(21312),o=t(6342),l=(t(38193),t(89532)),s=t(89466),c=t(74848);const d=a.createContext(void 0),u="theme";(0,s.Wf)(u);function h(){const e=(0,a.useContext)(d);if(null==e)throw new l.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var p=t(28774),m=t(63427),f=t(92303);function b(e){let{children:n,fallback:t}=e;return(0,f.A)()?(0,c.jsx)(c.Fragment,{children:n?.()}):t??null}var g=t(61409),v=t(81113);function x(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const j={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var w=t(56347);function k(e){let{id:n,group:t,...a}=e;const l=(0,m.A)(),{navbar:{hideOnScroll:s}}=(0,o.p)();l.collectAnchor(n);const d="group"===t?"h2":"h3",u=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),f=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),k=(0,w.zy)().pathname;return(0,c.jsxs)(d,{...a,className:(0,i.A)("anchor",s?j.anchorWithHideOnScrollNavbar:j.anchorWithStickyNavbar,a.className),id:n,children:[a.children,(0,c.jsx)(p.A,{className:"icon-link",to:`#${n}`,"aria-label":u,title:u,children:(0,c.jsx)(x,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(b,{children:()=>{const e=location.pathname.split("/").filter(Boolean),a=e[e.length-1],i=`[${"group"==t?`\`${a}\`'s ${n.toLowerCase()}`:"method"==t?`\`${a}:${n}()\``:`\`${a}.${n}\``}](<${`${window.location.origin}${k}#${n}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":f,title:f,onClick:()=>{g.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:h().colorMode,transition:g.GP}),navigator.clipboard.writeText(i)},children:(0,c.jsx)(v.A,{width:"0.75em",height:"0.75em"})})}})]})}},78293:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>h,frontMatter:()=>l,metadata:()=>a,toc:()=>d});const a=JSON.parse('{"id":"objects/GravityGenerator","title":"GravityGenerator","description":"Generates an artificial gravity field when powered on. The gravity field only affects players, not individual parts. The amount of gravity can also be configureed, but the more gravity the higher amount of power needed. Only works in space, not inside planets.","source":"@site/docs/objects/GravityGenerator.mdx","sourceDirName":"objects","slug":"/objects/GravityGenerator","permalink":"/Pilot.lua-Luau-LSP/objects/GravityGenerator","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Non-Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Grass","permalink":"/Pilot.lua-Luau-LSP/objects/Grass"},"next":{"title":"Gun","permalink":"/Pilot.lua-Luau-LSP/objects/Gun"}}');var i=t(74848),r=t(28453),o=t(56046);const l={tags:["Electrical","Spawnable","Craftable","Non-Programmable","Configurable"]},s=void 0,c={},d=[{value:"Configurables",id:"Configurables",level:2},{value:"Gravity",id:"Gravity",level:3},{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3}];function u(e){const n={hr:"hr",p:"p",...(0,r.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:"Generates an artificial gravity field when powered on. The gravity field only affects players, not individual parts. The amount of gravity can also be configureed, but the more gravity the higher amount of power needed. Only works in space, not inside planets."}),"\n",(0,i.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,i.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,i.jsx)(n.p,{children:"At its default size (4x3x4) it has a durability of 1."}),"\n",(0,i.jsxs)(n.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#5B5D69"},children:"#5b5d69"}),"."]}),"\n",(0,i.jsxs)(n.p,{children:["It requires 30 ",(0,i.jsx)("code",{children:"Engine"}),", 20 ",(0,i.jsx)("code",{children:"Pipe"}),", 40 ",(0,i.jsx)("code",{children:"Quartz"}),", and 150 ",(0,i.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,i.jsx)(o.A,{id:"Configurables",group:"group",children:"Configurables"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(o.A,{id:"Gravity",group:"configurable",children:"Gravity"}),"\n",(0,i.jsxs)(n.p,{children:["The amount of gravity within the influence of the GravityGenerator, measured in Gs. It is a ",(0,i.jsx)("code",{children:"number"}),".\nIt ranges between 0.15 and 1.5."]}),"\n",(0,i.jsx)(o.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(o.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,i.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,i.jsx)("code",{children:"1"}),"). It is a ",(0,i.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,r.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(u,{...e})}):u(e)}},81113:(e,n,t)=>{t.d(n,{A:()=>i});t(96540);var a=t(74848);function i(e){return(0,a.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,a.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
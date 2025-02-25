"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[4232],{28453:(e,n,r)=>{r.d(n,{R:()=>a,x:()=>l});var o=r(96540);const t={},i=o.createContext(t);function a(e){const n=o.useContext(i);return o.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(t):e.components||t:a(e.components),o.createElement(i.Provider,{value:n},e.children)}},56046:(e,n,r)=>{r.d(n,{A:()=>P});var o=r(96540),t=r(34164),i=r(21312),a=r(6342),l=(r(38193),r(89532)),s=r(89466),c=r(74848);const u=o.createContext(void 0),d="theme";(0,s.Wf)(d);function h(){const e=(0,o.useContext)(u);if(null==e)throw new l.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var p=r(28774),m=r(63427),f=r(92303);function b(e){let{children:n,fallback:r}=e;return(0,f.A)()?(0,c.jsx)(c.Fragment,{children:n?.()}):r??null}var g=r(61409),x=r(81113);function v(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const j={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var k=r(56347);function P(e){let{id:n,group:r,...o}=e;const l=(0,m.A)(),{navbar:{hideOnScroll:s}}=(0,a.p)();l.collectAnchor(n);const u="group"===r?"h2":"h3",d=(0,i.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),f=(0,i.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),P=(0,k.zy)().pathname;return(0,c.jsxs)(u,{...o,className:(0,t.A)("anchor",s?j.anchorWithHideOnScrollNavbar:j.anchorWithStickyNavbar,o.className),id:n,children:[o.children,(0,c.jsx)(p.A,{className:"icon-link",to:`#${n}`,"aria-label":d,title:d,children:(0,c.jsx)(v,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(b,{children:()=>{const e=location.pathname.split("/").filter(Boolean),o=e[e.length-1],t=`[${"group"==r?`\`${o}\`'s ${n.toLowerCase()}`:"method"==r?`\`${o}:${n}()\``:`\`${o}.${n}\``}](<${`${window.location.origin}${P}#${n}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":f,title:f,onClick:()=>{g.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:h().colorMode,transition:g.GP}),navigator.clipboard.writeText(t)},children:(0,c.jsx)(x.A,{width:"0.75em",height:"0.75em"})})}})]})}},68464:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>h,frontMatter:()=>l,metadata:()=>o,toc:()=>u});const o=JSON.parse('{"id":"objects/IonRocket","title":"IonRocket","description":"A simple, fast propulsion device which consumes power to produce thrust. Moves in the direction of the arrow.","source":"@site/docs/objects/IonRocket.mdx","sourceDirName":"objects","slug":"/objects/IonRocket","permalink":"/Pilot.lua-Luau-LSP/objects/IonRocket","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Starter","permalink":"/Pilot.lua-Luau-LSP/tags/starter"},{"inline":true,"label":"Propulsion","permalink":"/Pilot.lua-Luau-LSP/tags/propulsion"},{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Starter","Propulsion","Electrical","Spawnable","Craftable","Non-Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Insulation","permalink":"/Pilot.lua-Luau-LSP/objects/Insulation"},"next":{"title":"Iron","permalink":"/Pilot.lua-Luau-LSP/objects/Iron"}}');var t=r(74848),i=r(28453),a=r(56046);const l={tags:["Starter","Propulsion","Electrical","Spawnable","Craftable","Non-Programmable","Configurable"]},s=void 0,c={},u=[{value:"Configurables",id:"Configurables",level:2},{value:"Propulsion",id:"Propulsion",level:3},{value:"Events",id:"Events",level:2},{value:"Configured",id:"Configured",level:3}];function d(e){const n={hr:"hr",p:"p",...(0,i.R)(),...e.components};return(0,t.jsxs)(t.Fragment,{children:[(0,t.jsx)(n.p,{children:"A simple, fast propulsion device which consumes power to produce thrust. Moves in the direction of the arrow.\nCan travel up to 100s/s at maximum propulsion."}),"\n",(0,t.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,t.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,t.jsx)(n.p,{children:"At its default size (2x6x2) it has a durability of 1."}),"\n",(0,t.jsxs)(n.p,{children:["By default, its colour is ",(0,t.jsx)("span",{style:{color:"#DFDFDE"},children:"#dfdfde"}),"."]}),"\n",(0,t.jsxs)(n.p,{children:["It requires 10 ",(0,t.jsx)("code",{children:"Engine"}),", 25 ",(0,t.jsx)("code",{children:"Pipe"}),", 5 ",(0,t.jsx)("code",{children:"PowerCell"}),", and 15 ",(0,t.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,t.jsx)(a.A,{id:"Configurables",group:"group",children:"Configurables"}),"\n",(0,t.jsx)(n.hr,{}),"\n",(0,t.jsx)(a.A,{id:"Propulsion",group:"configurable",children:"Propulsion"}),"\n",(0,t.jsxs)(n.p,{children:["Determines the speed traveled at, 0 being standstill. Affects fuel consumption. It is a ",(0,t.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 100."]}),"\n",(0,t.jsx)(a.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,t.jsx)(n.hr,{}),"\n",(0,t.jsx)(a.A,{id:"Configured",group:"event",children:"Configured(configurerId)"}),"\n",(0,t.jsx)(n.p,{children:"Fires when the object is configured."}),"\n",(0,t.jsxs)(n.p,{children:["The ",(0,t.jsx)("b",{children:"configurerId"})," parameter is the ",(0,t.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,t.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,t.jsx)(n,{...e,children:(0,t.jsx)(d,{...e})}):d(e)}},81113:(e,n,r)=>{r.d(n,{A:()=>t});r(96540);var o=r(74848);function t(e){return(0,o.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,o.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
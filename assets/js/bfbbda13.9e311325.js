"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[3082],{28453:(e,t,n)=>{n.d(t,{R:()=>o,x:()=>s});var i=n(96540);const a={},r=i.createContext(a);function o(e){const t=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function s(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:o(e.components),i.createElement(r.Provider,{value:t},e.children)}},56046:(e,t,n)=>{n.d(t,{A:()=>k});var i=n(96540),a=n(34164),r=n(21312),o=n(6342),s=(n(38193),n(89532)),l=n(89466),c=n(74848);const d=i.createContext(void 0),h="theme";(0,l.Wf)(h);function u(){const e=(0,i.useContext)(d);if(null==e)throw new s.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var x=n(28774),p=n(63427),m=n(92303);function b(e){let{children:t,fallback:n}=e;return(0,m.A)()?(0,c.jsx)(c.Fragment,{children:t?.()}):n??null}var j=n(61409),g=n(81113);function f(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const v={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var w=n(56347);function k(e){let{id:t,group:n,...i}=e;const s=(0,p.A)(),{navbar:{hideOnScroll:l}}=(0,o.p)();s.collectAnchor(t);const d="group"===n?"h2":"h3",h=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:t}),m=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:t}),k=(0,w.zy)().pathname;return(0,c.jsxs)(d,{...i,className:(0,a.A)("anchor",l?v.anchorWithHideOnScrollNavbar:v.anchorWithStickyNavbar,i.className),id:t,children:[i.children,(0,c.jsx)(x.A,{className:"icon-link",to:`#${t}`,"aria-label":h,title:h,children:(0,c.jsx)(f,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(b,{children:()=>{const e=location.pathname.split("/").filter(Boolean),i=e[e.length-1],a=`[${"group"==n?`\`${i}\`'s ${t.toLowerCase()}`:"method"==n?`\`${i}:${t}()\``:`\`${i}.${t}\``}](<${`${window.location.origin}${k}#${t}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":m,title:m,onClick:()=>{j.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:t})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:u().colorMode,transition:j.GP}),navigator.clipboard.writeText(a)},children:(0,c.jsx)(g.A,{width:"0.75em",height:"0.75em"})})}})]})}},58456:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>l,default:()=>u,frontMatter:()=>s,metadata:()=>i,toc:()=>d});const i=JSON.parse('{"id":"objects/StarMap","title":"StarMap","description":"Shows your current location in the universe and other nearby stars and celestial bodies.","source":"@site/docs/objects/StarMap.mdx","sourceDirName":"objects","slug":"/objects/StarMap","permalink":"/Pilot.lua-Luau-LSP/objects/StarMap","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Stanlium","permalink":"/Pilot.lua-Luau-LSP/objects/Stanlium"},"next":{"title":"StasisField","permalink":"/Pilot.lua-Luau-LSP/objects/StasisField"}}');var a=n(74848),r=n(28453),o=n(56046);const s={tags:["Electrical","Spawnable","Craftable","Programmable","Non-Configurable"]},l=void 0,c={},d=[{value:"Methods",id:"Methods",level:2},{value:"GetBodies()",id:"GetBodies",level:3},{value:"GetSystems()",id:"GetSystems",level:3}];function h(e){const t={hr:"hr",li:"li",p:"p",ul:"ul",...(0,r.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsxs)(t.p,{children:["Shows your current location in the universe and other nearby stars and celestial bodies.\nIt also has unique icons for every celestial body type. Clicking on a icon will set a all connected ",(0,a.jsx)("code",{children:"HyperDrive"}),"s/",(0,a.jsx)("code",{children:"Telescope"}),"s to those coordinates.\nRequires power in order to function."]}),"\n",(0,a.jsx)(t.p,{children:"It has 2 modes, universe and solar."}),"\n",(0,a.jsxs)(t.ul,{children:["\n",(0,a.jsx)(t.li,{children:"Universe mode shows your location in the universe."}),"\n",(0,a.jsx)(t.li,{children:"Solar mode shows your location in the solar system if you are in one."}),"\n"]}),"\n",(0,a.jsx)(t.p,{children:"It can be triggered with polysilicon:"}),"\n",(0,a.jsxs)(t.ul,{children:["\n",(0,a.jsxs)(t.li,{children:[(0,a.jsx)("code",{children:"Activate"})," will set it to universe mode."]}),"\n",(0,a.jsxs)(t.li,{children:[(0,a.jsx)("code",{children:"Deactivate"})," will set it to solar mode."]}),"\n",(0,a.jsxs)(t.li,{children:[(0,a.jsx)("code",{children:"FlipFlop"})," will toggle between the two modes."]}),"\n"]}),"\n",(0,a.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,a.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (12500) that have integer components: 1x1250x10, 1x625x20, 1x500x25, 1x250x50, 1x125x100, 2x1250x5, 2x625x10, 2x250x25, 2x125x50, 4x625x5, 4x125x25, 5x500x5, 5x250x10, 5x125x20, 5x100x25, 5x50x50, 10x125x10, 10x50x25, 20x25x25, 50x25x10, 100x25x5"}),"\n",(0,a.jsx)(t.p,{children:"At its default size (20x3x20) it has a durability of 1, at its maximum size it has a durability of 3."}),"\n",(0,a.jsxs)(t.p,{children:["By default, its colour is ",(0,a.jsx)("span",{style:{color:"#1B2A35"},children:"#1b2a35"}),"."]}),"\n",(0,a.jsxs)(t.p,{children:["It requires 25 ",(0,a.jsx)("code",{children:"Quartz"}),", 2 ",(0,a.jsx)("code",{children:"Radar"}),", and 20 ",(0,a.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,a.jsx)(o.A,{id:"Methods",group:"group",children:"Methods"}),"\n",(0,a.jsx)(t.hr,{}),"\n",(0,a.jsx)(o.A,{id:"GetBodies",group:"method",children:"GetBodies() \u2192 bodies"}),"\n",(0,a.jsxs)(t.p,{children:["The ",(0,a.jsx)("b",{children:"bodies"})," return is a dictionary with keys that are ",(0,a.jsx)("code",{children:"string"}),"s and values that are ",(0,a.jsx)("code",{children:"{ PlanetType: PlanetType }"}),"s."]}),"\n",(0,a.jsx)(t.hr,{}),"\n",(0,a.jsx)(o.A,{id:"GetSystems",group:"method",children:"GetSystems() \u2192 systems"}),"\n",(0,a.jsxs)(t.p,{children:["The ",(0,a.jsx)("b",{children:"systems"})," return is an array of a ",(0,a.jsx)("code",{children:"string"}),"s."]})]})}function u(e={}){const{wrapper:t}={...(0,r.R)(),...e.components};return t?(0,a.jsx)(t,{...e,children:(0,a.jsx)(h,{...e})}):h(e)}},81113:(e,t,n)=>{n.d(t,{A:()=>a});n(96540);var i=n(74848);function a(e){return(0,i.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,i.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[342],{14074:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>c,contentTitle:()=>l,default:()=>u,frontMatter:()=>s,metadata:()=>t,toc:()=>d});const t=JSON.parse('{"id":"objects/Relay","title":"Relay","description":"A powerful transmitter capable of transmitting trigger signals and resources/power between different regions.","source":"@site/docs/objects/Relay.mdx","sourceDirName":"objects","slug":"/objects/Relay","permalink":"/Pilot.lua-Luau-LSP/objects/Relay","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Unused","permalink":"/Pilot.lua-Luau-LSP/tags/unused"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Unused","Spawnable","Non-Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"ReinforcedGlass","permalink":"/Pilot.lua-Luau-LSP/objects/ReinforcedGlass"},"next":{"title":"RemoteControl","permalink":"/Pilot.lua-Luau-LSP/objects/RemoteControl"}}');var o=r(74848),a=r(28453),i=r(56046);const s={tags:["Unused","Spawnable","Non-Programmable","Configurable"]},l=void 0,c={},d=[{value:"Configurables",id:"Configurables",level:2},{value:"LinkerID",id:"LinkerID",level:3},{value:"Mode",id:"Mode",level:3}];function h(e){const n={hr:"hr",p:"p",...(0,a.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(n.p,{children:"A powerful transmitter capable of transmitting trigger signals and resources/power between different regions.\nIt is a more powerful version of the antenna and transporter."}),"\n",(0,o.jsx)(n.p,{children:"Unlike the antenna, the relay has 2 modes, mode 0 and mode 1.\nMode 0 sends resources/power and trigger signals, while mode 1 receives it."}),"\n",(0,o.jsx)(n.p,{children:"Unlike the antenna, it can also transfer power in inactive regions or regions without players in them.\nThis means that you can connect a relay to your main base, warp away without anyone in the base, and still have the relay get the sufficient amount of power."}),"\n",(0,o.jsx)(n.p,{children:"However, you should have only one sending relay per coordinate, as conflicts can occur if there are 2 or more relays in the region/coordinates sending power or signals with the same ID.\nOn the other hand, there can be an infinite number of receivers but the power/resources will be distributed evenly among them."}),"\n",(0,o.jsx)(n.p,{children:"For example, let's say a relay network has a total output of 500 power and 25 iron. If there are 5 active receivers, each of them will get 100 power and 5 iron."}),"\n",(0,o.jsx)(n.p,{children:"When the relay is red, it means it not functioning. When it turns green, it is properly linked up to another relay or is sending signals."}),"\n",(0,o.jsx)(n.p,{children:"It is a spawnable non-flammable solid."}),"\n",(0,o.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,o.jsx)(n.p,{children:"At its default size (3x6x3) it has a durability of 1."}),"\n",(0,o.jsxs)(n.p,{children:["By default, its colour is ",(0,o.jsx)("span",{style:{color:"#C4281C"},children:"#c4281c"}),"."]}),"\n",(0,o.jsxs)(n.p,{children:["It requires 5 ",(0,o.jsx)("code",{children:"Antenna"}),", 100 ",(0,o.jsx)("code",{children:"Quartz"}),", and 5 ",(0,o.jsx)("code",{children:"Transporter"})," to be crafted."]}),"\n",(0,o.jsx)(i.A,{id:"Configurables",group:"group",children:"Configurables"}),"\n",(0,o.jsx)(n.hr,{}),"\n",(0,o.jsx)(i.A,{id:"LinkerID",group:"configurable",children:"LinkerID"}),"\n",(0,o.jsxs)(n.p,{children:["The ID of the relay, to send or take materials to or from other relays with the same ID. It is a ",(0,o.jsx)("code",{children:"number"}),".\nIt ranges between 1 and 10000000000. It increments by 1."]}),"\n",(0,o.jsx)(n.hr,{}),"\n",(0,o.jsx)(i.A,{id:"Mode",group:"configurable",children:"Mode"}),"\n",(0,o.jsxs)(n.p,{children:["The mode of the relay. Send outputs materials to other receiving relays; Receive receives materials from sending relays. It is a ",(0,o.jsx)("code",{children:"RelayMode"}),"."]})]})}function u(e={}){const{wrapper:n}={...(0,a.R)(),...e.components};return n?(0,o.jsx)(n,{...e,children:(0,o.jsx)(h,{...e})}):h(e)}},28453:(e,n,r)=>{r.d(n,{R:()=>i,x:()=>s});var t=r(96540);const o={},a=t.createContext(o);function i(e){const n=t.useContext(a);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function s(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:i(e.components),t.createElement(a.Provider,{value:n},e.children)}},56046:(e,n,r)=>{r.d(n,{A:()=>k});var t=r(96540),o=r(34164),a=r(21312),i=r(6342),s=(r(38193),r(89532)),l=r(89466),c=r(74848);const d=t.createContext(void 0),h="theme";(0,l.Wf)(h);function u(){const e=(0,t.useContext)(d);if(null==e)throw new s.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var p=r(28774),m=r(63427),g=r(92303);function f(e){let{children:n,fallback:r}=e;return(0,g.A)()?(0,c.jsx)(c.Fragment,{children:n?.()}):r??null}var b=r(61409),x=r(81113);function v(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const w={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var j=r(56347);function k(e){let{id:n,group:r,...t}=e;const s=(0,m.A)(),{navbar:{hideOnScroll:l}}=(0,i.p)();s.collectAnchor(n);const d="group"===r?"h2":"h3",h=(0,a.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),g=(0,a.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),k=(0,j.zy)().pathname;return(0,c.jsxs)(d,{...t,className:(0,o.A)("anchor",l?w.anchorWithHideOnScrollNavbar:w.anchorWithStickyNavbar,t.className),id:n,children:[t.children,(0,c.jsx)(p.A,{className:"icon-link",to:`#${n}`,"aria-label":h,title:h,children:(0,c.jsx)(v,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(f,{children:()=>{const e=location.pathname.split("/").filter(Boolean),t=e[e.length-1],o=`[${"group"==r?`\`${t}\`'s ${n.toLowerCase()}`:"method"==r?`\`${t}:${n}()\``:`\`${t}.${n}\``}](<${`${window.location.origin}${k}#${n}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":g,title:g,onClick:()=>{b.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:u().colorMode,transition:b.GP}),navigator.clipboard.writeText(o)},children:(0,c.jsx)(x.A,{width:"0.75em",height:"0.75em"})})}})]})}},81113:(e,n,r)=>{r.d(n,{A:()=>o});r(96540);var t=r(74848);function o(e){return(0,t.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,t.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
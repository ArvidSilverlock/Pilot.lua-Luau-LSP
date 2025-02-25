"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[7815],{28453:(e,t,n)=>{n.d(t,{R:()=>l,x:()=>a});var r=n(96540);const i={},o=r.createContext(i);function l(e){const t=r.useContext(o);return r.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function a(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:l(e.components),r.createElement(o.Provider,{value:t},e.children)}},44672:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>s,default:()=>u,frontMatter:()=>a,metadata:()=>r,toc:()=>d});const r=JSON.parse('{"id":"objects/Controller","title":"Controller","description":"Alters the speed of attached controllable objects which include:","source":"@site/docs/objects/Controller.mdx","sourceDirName":"objects","slug":"/objects/Controller","permalink":"/Pilot.lua-Luau-LSP/objects/Controller","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Logic","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Constructor","permalink":"/Pilot.lua-Luau-LSP/objects/Constructor"},"next":{"title":"ConveyorBelt","permalink":"/Pilot.lua-Luau-LSP/objects/ConveyorBelt"}}');var i=n(74848),o=n(28453),l=n(56046);const a={tags:["Logic","Spawnable","Craftable","Non-Programmable","Non-Configurable"]},s=void 0,c={},d=[{value:"Events",id:"Events",level:2},{value:"Loop",id:"Loop",level:3},{value:"Triggered",id:"Triggered",level:3}];function h(e){const t={hr:"hr",li:"li",p:"p",ul:"ul",...(0,o.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.p,{children:"Alters the speed of attached controllable objects which include:"}),"\n",(0,i.jsxs)(t.ul,{children:["\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"Engine"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"Motor"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"BallastTank"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"IonDrive"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"IonRocket"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"Thruster"}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsx)("code",{children:"Rocket"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(t.p,{children:["You must use a polysilicon between this controller and an object that emits a trigger signal (such as a button) to use the same events as clicking the interface.\nFor example, ",(0,i.jsx)("code",{children:"FlipFlop"})," will set the speed of the controllable objects to 0, ",(0,i.jsx)("code",{children:"Deactivate"})," will subtract 5 from the current speed, etc."]}),"\n",(0,i.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,i.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (169) that have integer components: 1x169x1, 1x13x13"}),"\n",(0,i.jsx)(t.p,{children:"At its default size (4x4x1) it has a durability of 6, at its maximum size it has a durability of 14."}),"\n",(0,i.jsxs)(t.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#868587"},children:"#868587"}),"."]}),"\n",(0,i.jsxs)(t.p,{children:["It requires 2 ",(0,i.jsx)("code",{children:"Iron"})," and 4 ",(0,i.jsx)("code",{children:"TriggerWire"})," to be crafted."]}),"\n",(0,i.jsx)(l.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,i.jsx)(t.hr,{}),"\n",(0,i.jsx)(l.A,{id:"Loop",group:"event",children:"Loop(deltaTime)"}),"\n",(0,i.jsx)(t.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,i.jsxs)(t.p,{children:["The ",(0,i.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,i.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,i.jsx)("code",{children:"1"}),"). It is a ",(0,i.jsx)("code",{children:"number"}),"."]}),"\n",(0,i.jsx)(t.hr,{}),"\n",(0,i.jsx)(l.A,{id:"Triggered",group:"event",children:"Triggered(otherPart)"}),"\n",(0,i.jsx)(t.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,i.jsxs)(t.p,{children:["If a ",(0,i.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,i.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,i.jsx)("code",{children:":Trigger"}),", but not ",(0,i.jsx)("code",{children:"TriggerPort"}),"), it ",(0,i.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,i.jsxs)(t.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,i.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,i.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,i.jsxs)(t.p,{children:["The ",(0,i.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,i.jsx)("code",{children:"PilotObject"}),"."]})]})}function u(e={}){const{wrapper:t}={...(0,o.R)(),...e.components};return t?(0,i.jsx)(t,{...e,children:(0,i.jsx)(h,{...e})}):h(e)}},56046:(e,t,n)=>{n.d(t,{A:()=>w});var r=n(96540),i=n(34164),o=n(21312),l=n(6342),a=(n(38193),n(89532)),s=n(89466),c=n(74848);const d=r.createContext(void 0),h="theme";(0,s.Wf)(h);function u(){const e=(0,r.useContext)(d);if(null==e)throw new a.dV("ColorModeProvider","Please see https://docusaurus.io/docs/api/themes/configuration#use-color-mode.");return e}var g=n(28774),p=n(63427),x=n(92303);function j(e){let{children:t,fallback:n}=e;return(0,x.A)()?(0,c.jsx)(c.Fragment,{children:t?.()}):n??null}var m=n(61409),b=n(81113);function f(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const v={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var k=n(56347);function w(e){let{id:t,group:n,...r}=e;const a=(0,p.A)(),{navbar:{hideOnScroll:s}}=(0,l.p)();a.collectAnchor(t);const d="group"===n?"h2":"h3",h=(0,o.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:t}),x=(0,o.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:t}),w=(0,k.zy)().pathname;return(0,c.jsxs)(d,{...r,className:(0,i.A)("anchor",s?v.anchorWithHideOnScrollNavbar:v.anchorWithStickyNavbar,r.className),id:t,children:[r.children,(0,c.jsx)(g.A,{className:"icon-link",to:`#${t}`,"aria-label":h,title:h,children:(0,c.jsx)(f,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(j,{children:()=>{const e=location.pathname.split("/").filter(Boolean),r=e[e.length-1],i=`[${"group"==n?`\`${r}\`'s ${t.toLowerCase()}`:"method"==n?`\`${r}:${t}()\``:`\`${r}.${t}\``}](<${`${window.location.origin}${w}#${t}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":x,title:x,onClick:()=>{m.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:t})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:u().colorMode,transition:m.GP}),navigator.clipboard.writeText(i)},children:(0,c.jsx)(b.A,{width:"0.75em",height:"0.75em"})})}})]})}},81113:(e,t,n)=>{n.d(t,{A:()=>i});n(96540);var r=n(74848);function i(e){return(0,r.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,r.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}}}]);
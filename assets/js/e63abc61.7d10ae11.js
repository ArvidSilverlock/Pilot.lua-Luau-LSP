"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[8464],{2824:(e,n,i)=>{i.r(n),i.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>u,frontMatter:()=>o,metadata:()=>t,toc:()=>d});const t=JSON.parse('{"id":"objects/Servo","title":"Servo","description":"Spins objects attached to the hinge at the front when powered, to set angles.","source":"@site/docs/objects/Servo.mdx","sourceDirName":"objects","slug":"/objects/Servo","permalink":"/Pilot.lua-Luau-LSP/objects/Servo","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Seat","permalink":"/Pilot.lua-Luau-LSP/objects/Seat"},"next":{"title":"Shotgun","permalink":"/Pilot.lua-Luau-LSP/objects/Shotgun"}}');var r=i(4848),l=i(8453),a=i(9907);const o={tags:["Electrical","Spawnable","Craftable","Programmable","Configurable"]},s=void 0,c={},d=[{value:"Methods",id:"Methods",level:2},{value:"SetAngle()",id:"SetAngle",level:3},{value:"Configurables",id:"Configurables",level:2},{value:"AngleStep",id:"AngleStep",level:3},{value:"Responsiveness",id:"Responsiveness",level:3},{value:"ServoSpeed",id:"ServoSpeed",level:3},{value:"Events",id:"Events",level:2},{value:"Configured",id:"Configured",level:3}];function h(e){const n={hr:"hr",li:"li",p:"p",ul:"ul",...(0,l.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.p,{children:"Spins objects attached to the hinge at the front when powered, to set angles."}),"\n",(0,r.jsxs)(n.p,{children:[(0,r.jsx)("code",{children:"Polysilicon"})," can be used to control its angle."]}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)("code",{children:"Activate"})," will increment the goal angle by the configured angle step (clockwise looking at its face)."]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)("code",{children:"Deactivate"})," will decrement the goal angle (counter-clockwise)."]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)("code",{children:"FlipFlop"})," will reset the angle to 0."]}),"\n"]}),"\n",(0,r.jsxs)(n.p,{children:[(0,r.jsx)("code",{children:"Microcontroller"}),"s can also set a servo's angle with ",(0,r.jsxs)("code",{children:[":SetAngle","(targetAngle)"]})]}),"\n",(0,r.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(n.p,{children:"Here is a list of possible sizes that reach the maximum malleability (144) that have integer components: 1x144x1, 1x72x2, 1x48x3, 1x36x4, 1x24x6, 1x18x8, 1x16x9, 1x12x12, 2x36x2, 2x24x3, 2x18x4, 2x12x6, 2x9x8, 3x16x3, 3x12x4, 3x8x6, 4x9x4, 4x6x6, 8x6x3, 9x8x2, 9x4x4, 12x6x2, 12x4x3"}),"\n",(0,r.jsx)(n.p,{children:"At its default size (2x2x2) it has a durability of 10, at its maximum size it has a durability of 27."}),"\n",(0,r.jsxs)(n.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#A3A2A5"},children:"#a3a2a5"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["It requires 1 ",(0,r.jsx)("code",{children:"Motor"})," and 2 ",(0,r.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,r.jsx)(a.A,{id:"Methods",group:"group",children:"Methods"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(a.A,{id:"SetAngle",group:"method",children:"SetAngle(angle)"}),"\n",(0,r.jsx)(n.p,{children:"Sets the target angle of a servo just as would if you were configuring it."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"angle"})," parameter is the angle of the servo in angular degrees. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(a.A,{id:"Configurables",group:"group",children:"Configurables"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(a.A,{id:"AngleStep",group:"configurable",children:"AngleStep"}),"\n",(0,r.jsxs)(n.p,{children:["Determines the change in angle when a pulse is received by Polysilicon. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between -180 and 180."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(a.A,{id:"Responsiveness",group:"configurable",children:"Responsiveness"}),"\n",(0,r.jsxs)(n.p,{children:["Determines how fast the servo attempts to correct its angle. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 90."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(a.A,{id:"ServoSpeed",group:"configurable",children:"ServoSpeed"}),"\n",(0,r.jsxs)(n.p,{children:["Determines the speed at which the servo is driven. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 20."]}),"\n",(0,r.jsx)(a.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(a.A,{id:"Configured",group:"event",children:"Configured(configurerId)"}),"\n",(0,r.jsx)(n.p,{children:"Fires when the object is configured."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"configurerId"})," parameter is the ",(0,r.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,r.jsx)("code",{children:"number"}),"."]})]})}function u(e={}){const{wrapper:n}={...(0,l.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(h,{...e})}):h(e)}},1113:(e,n,i)=>{i.d(n,{A:()=>r});i(6540);var t=i(4848);function r(e){return(0,t.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,t.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}},9907:(e,n,i)=>{i.d(n,{A:()=>j});i(6540);var t=i(4164),r=i(1312),l=i(6342),a=i(5293),o=i(8774),s=i(3427),c=i(2303),d=i(4848);function h(e){let{children:n,fallback:i}=e;return(0,c.A)()?(0,d.jsx)(d.Fragment,{children:n?.()}):i??null}var u=i(1409),x=i(1113);function g(e){return(0,d.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,d.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const p={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var b=i(6347);function j(e){let{id:n,group:i,...c}=e;const j=(0,s.A)(),{navbar:{hideOnScroll:m}}=(0,l.p)();j.collectAnchor(n);const v="group"===i?"h2":"h3",f=(0,r.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),S=(0,r.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),w=(0,a.G)().colorMode,k=(0,b.zy)().pathname;return(0,d.jsxs)(v,{...c,className:(0,t.A)("anchor",m?p.anchorWithHideOnScrollNavbar:p.anchorWithStickyNavbar,c.className),id:n,children:[c.children,(0,d.jsx)(o.A,{className:"icon-link",to:`#${n}`,"aria-label":f,title:f,children:(0,d.jsx)(g,{width:"0.75em",height:"0.75em"})}),(0,d.jsx)(h,{children:()=>{const e=location.pathname.split("/").filter(Boolean),t=e[e.length-1],r=`[${"group"==i?`\`${t}\`'s ${n.toLowerCase()}`:"method"==i?`\`${t}:${n}()\``:`\`${t}.${n}\``}](<${`${window.location.origin}${k}#${n}`}>)`;return(0,d.jsx)("a",{className:"icon-link","aria-label":S,title:S,onClick:()=>{u.oR.dark((0,d.jsxs)("a",{children:["Copied the ",(0,d.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:w,transition:u.GP}),navigator.clipboard.writeText(r)},children:(0,d.jsx)(x.A,{width:"0.75em",height:"0.75em"})})}})]})}},8453:(e,n,i)=>{i.d(n,{R:()=>a,x:()=>o});var t=i(6540);const r={},l=t.createContext(r);function a(e){const n=t.useContext(l);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function o(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:a(e.components),t.createElement(l.Provider,{value:n},e.children)}}}]);
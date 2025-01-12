"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[3866],{947:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>u,frontMatter:()=>l,metadata:()=>t,toc:()=>d});const t=JSON.parse('{"id":"objects/FourthOfJuly","title":"FourthOfJuly","description":"Causes an explosion when triggered along with a Fourth Of July message. You can use a delay wire to make it explode after a few seconds and not immediately.","source":"@site/docs/objects/FourthOfJuly.mdx","sourceDirName":"objects","slug":"/objects/FourthOfJuly","permalink":"/Pilot.lua-Luau-LSP/objects/FourthOfJuly","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Unused","permalink":"/Pilot.lua-Luau-LSP/tags/unused"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Non-Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/non-programmable"},{"inline":true,"label":"Non-Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/non-configurable"}],"version":"current","frontMatter":{"tags":["Unused","Spawnable","Non-Programmable","Non-Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Food","permalink":"/Pilot.lua-Luau-LSP/objects/Food"},"next":{"title":"Framewire","permalink":"/Pilot.lua-Luau-LSP/objects/Framewire"}}');var i=r(4848),a=r(8453),o=r(9907);const l={tags:["Unused","Spawnable","Non-Programmable","Non-Configurable"]},s=void 0,c={},d=[{value:"Events",id:"Events",level:2},{value:"Damaged",id:"Damaged",level:3},{value:"Triggered",id:"Triggered",level:3}];function h(e){const n={hr:"hr",li:"li",p:"p",ul:"ul",...(0,a.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:"Causes an explosion when triggered along with a Fourth Of July message. You can use a delay wire to make it explode after a few seconds and not immediately."}),"\n",(0,i.jsx)(n.p,{children:"It is a spawnable flammable solid."}),"\n",(0,i.jsx)(n.p,{children:"Here is a list of possible sizes that reach the maximum malleability (8) that have integer components: 1x8x1, 1x4x2, 2x2x2"}),"\n",(0,i.jsx)(n.p,{children:"At its default size (2x2x2) it has a durability of 2, at its maximum size it has a durability of 3."}),"\n",(0,i.jsxs)(n.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#1B2A35"},children:"#1b2a35"}),"."]}),"\n",(0,i.jsxs)(n.p,{children:["It requires 10 ",(0,i.jsx)("code",{children:"Cloth"})," and 20 ",(0,i.jsx)("code",{children:"Sulfur"})," to be crafted."]}),"\n",(0,i.jsx)(o.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(o.A,{id:"Damaged",group:"event",children:"Damaged(damage, damageType, damageSource)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is damaged."}),"\n",(0,i.jsxs)(n.p,{children:["The parameters for ",(0,i.jsx)("code",{children:"Damaged"})," are as follows:"]}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"damage"})," parameter is the numerical damage dealt. It is a ",(0,i.jsx)("code",{children:"number"}),"."]}),"\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"damageType"})," parameter is the type of damage dealt. It is a string that can be ",(0,i.jsx)("code",{children:"Kinetic"})," or ",(0,i.jsx)("code",{children:"Energy"})]}),"\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"damageSource"})," parameter is will return a reference to the attacking object, seems to provide references to ",(0,i.jsx)("code",{children:"EnergyGun"}),"s, ",(0,i.jsx)("code",{children:"Laser"}),"s and ",(0,i.jsx)("code",{children:"Gun"}),"s, but not ",(0,i.jsx)("code",{children:"Blade"}),"s or ",(0,i.jsx)("code",{children:"PlasmaCannon"}),"s, there are other members of these lists that are untested. It is a ",(0,i.jsx)("code",{children:"PilotObject"}),". It can also be ",(0,i.jsx)("code",{children:"nil"}),"."]}),"\n"]}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(o.A,{id:"Triggered",group:"event",children:"Triggered(otherPart)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is triggered and provides a reference to the part that triggered it."}),"\n",(0,i.jsxs)(n.p,{children:["If a ",(0,i.jsx)("code",{children:"Microcontroller"})," indirectly initiated the triggering of an object, it will return the object rather than the ",(0,i.jsx)("code",{children:"Microcontroller"}),", whereas in the case of directly triggering the object (i.e., calling ",(0,i.jsx)("code",{children:":Trigger"}),", but not ",(0,i.jsx)("code",{children:"TriggerPort"}),"), it ",(0,i.jsx)("em",{children:"will"})," return the microcontroller."]}),"\n",(0,i.jsxs)(n.p,{children:["The trigger source remains unchanged if the trigger is sent through something such as an ",(0,i.jsx)("code",{children:"Antenna"}),", but will be set to a ",(0,i.jsx)("code",{children:"RemoteControl"})," if one is present along the trigger line."]}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"otherPart"})," parameter is the source of the trigger signal. It is a ",(0,i.jsx)("code",{children:"PilotObject"}),"."]})]})}function u(e={}){const{wrapper:n}={...(0,a.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(h,{...e})}):h(e)}},1113:(e,n,r)=>{r.d(n,{A:()=>i});r(6540);var t=r(4848);function i(e){return(0,t.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,t.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}},9907:(e,n,r)=>{r.d(n,{A:()=>j});r(6540);var t=r(4164),i=r(1312),a=r(6342),o=r(5293),l=r(8774),s=r(3427),c=r(2303),d=r(4848);function h(e){let{children:n,fallback:r}=e;return(0,c.A)()?(0,d.jsx)(d.Fragment,{children:n?.()}):r??null}var u=r(1409),g=r(1113);function m(e){return(0,d.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,d.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const p={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var x=r(6347);function j(e){let{id:n,group:r,...c}=e;const j=(0,s.A)(),{navbar:{hideOnScroll:b}}=(0,a.p)();j.collectAnchor(n);const f="group"===r?"h2":"h3",v=(0,i.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:n}),w=(0,i.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:n}),k=(0,o.G)().colorMode,y=(0,x.zy)().pathname;return(0,d.jsxs)(f,{...c,className:(0,t.A)("anchor",b?p.anchorWithHideOnScrollNavbar:p.anchorWithStickyNavbar,c.className),id:n,children:[c.children,(0,d.jsx)(l.A,{className:"icon-link",to:`#${n}`,"aria-label":v,title:v,children:(0,d.jsx)(m,{width:"0.75em",height:"0.75em"})}),(0,d.jsx)(h,{children:()=>{const e=location.pathname.split("/").filter(Boolean),t=e[e.length-1],i=`[${"group"==r?`\`${t}\`'s ${n.toLowerCase()}`:"method"==r?`\`${t}:${n}()\``:`\`${t}.${n}\``}](<${`${window.location.origin}${y}#${n}`}>)`;return(0,d.jsx)("a",{className:"icon-link","aria-label":w,title:w,onClick:()=>{u.oR.dark((0,d.jsxs)("a",{children:["Copied the ",(0,d.jsx)("code",{children:n})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:k,transition:u.GP}),navigator.clipboard.writeText(i)},children:(0,d.jsx)(g.A,{width:"0.75em",height:"0.75em"})})}})]})}},8453:(e,n,r)=>{r.d(n,{R:()=>o,x:()=>l});var t=r(6540);const i={},a=t.createContext(i);function o(e){const n=t.useContext(a);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:o(e.components),t.createElement(a.Provider,{value:n},e.children)}}}]);
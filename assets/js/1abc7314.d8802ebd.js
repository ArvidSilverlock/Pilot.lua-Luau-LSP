"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[961],{1912:(e,i,t)=>{t.r(i),t.d(i,{assets:()=>d,contentTitle:()=>s,default:()=>u,frontMatter:()=>l,metadata:()=>r,toc:()=>c});const r=JSON.parse('{"id":"objects/ProximityButton","title":"ProximityButton","description":"Sends trigger signals when interacted via its ProximityPrompt.","source":"@site/docs/objects/ProximityButton.mdx","sourceDirName":"objects","slug":"/objects/ProximityButton","permalink":"/Pilot.lua-Luau-LSP/objects/ProximityButton","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Logic","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Prosthetic","permalink":"/Pilot.lua-Luau-LSP/objects/Prosthetic"},"next":{"title":"Pulverizer","permalink":"/Pilot.lua-Luau-LSP/objects/Pulverizer"}}');var n=t(4848),o=t(8453),a=t(9907);const l={tags:["Logic","Spawnable","Craftable","Programmable","Configurable"]},s=void 0,d={},c=[{value:"Configurables",id:"Configurables",level:2},{value:"GamepadKeyCode",id:"GamepadKeyCode",level:3},{value:"HoldDuration",id:"HoldDuration",level:3},{value:"KeyboardKeyCode",id:"KeyboardKeyCode",level:3},{value:"MaxActivationDistance",id:"MaxActivationDistance",level:3},{value:"ObjectText",id:"ObjectText",level:3},{value:"RequiresLineOfSight",id:"RequiresLineOfSight",level:3},{value:"Events",id:"Events",level:2},{value:"Configured",id:"Configured",level:3},{value:"PromptButtonHoldBegan",id:"PromptButtonHoldBegan",level:3},{value:"PromptButtonHoldEnded",id:"PromptButtonHoldEnded",level:3},{value:"PromptTriggerEnded",id:"PromptTriggerEnded",level:3},{value:"PromptTriggered",id:"PromptTriggered",level:3}];function h(e){const i={hr:"hr",p:"p",...(0,o.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(i.p,{children:"Sends trigger signals when interacted via its ProximityPrompt."}),"\n",(0,n.jsx)(i.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,n.jsx)(i.p,{children:"Here is a list of possible sizes that reach the maximum malleability (75) that have integer components: 1x75x1, 1x25x3, 1x15x5, 3x5x5"}),"\n",(0,n.jsx)(i.p,{children:"At its default size (1x1x1) it has a durability of 1, at its maximum size it has a durability of 5."}),"\n",(0,n.jsxs)(i.p,{children:["By default, its colour is ",(0,n.jsx)("span",{style:{color:"#1B2A35"},children:"#1b2a35"}),"."]}),"\n",(0,n.jsxs)(i.p,{children:["It requires 5 ",(0,n.jsx)("code",{children:"Copper"}),", 5 ",(0,n.jsx)("code",{children:"Iron"}),", 15 ",(0,n.jsx)("code",{children:"Quartz"}),", and 10 ",(0,n.jsx)("code",{children:"Silicon"})," to be crafted."]}),"\n",(0,n.jsx)(a.A,{id:"Configurables",group:"group",children:"Configurables"}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"GamepadKeyCode",group:"configurable",children:"GamepadKeyCode"}),"\n",(0,n.jsxs)(i.p,{children:["The name of the key that will trigger the proximity prompt on a gamepad. It is a ",(0,n.jsx)("code",{children:"string"}),"."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"HoldDuration",group:"configurable",children:"HoldDuration"}),"\n",(0,n.jsxs)(i.p,{children:["The length of time that the proximity prompt has to be held down for. It is a ",(0,n.jsx)("code",{children:"number"}),"."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"KeyboardKeyCode",group:"configurable",children:"KeyboardKeyCode"}),"\n",(0,n.jsxs)(i.p,{children:["The name of the key that will trigger the proximity prompt on a keyboard. It is a ",(0,n.jsx)("code",{children:"string"}),"."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"MaxActivationDistance",group:"configurable",children:"MaxActivationDistance"}),"\n",(0,n.jsxs)(i.p,{children:["The range of the prompt, from 0 - 50. It is a ",(0,n.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 50."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"ObjectText",group:"configurable",children:"ObjectText"}),"\n",(0,n.jsxs)(i.p,{children:["The text of the proximity prompt. It is a ",(0,n.jsx)("code",{children:"string"}),"."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"RequiresLineOfSight",group:"configurable",children:"RequiresLineOfSight"}),"\n",(0,n.jsxs)(i.p,{children:["Whether a line of sight to the center of the part is required for the prompt to become visible. It is a ",(0,n.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,n.jsx)(a.A,{id:"Events",group:"group",children:"Events"}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"Configured",group:"event",children:"Configured(configurerId)"}),"\n",(0,n.jsx)(i.p,{children:"Fires when the object is configured."}),"\n",(0,n.jsxs)(i.p,{children:["The ",(0,n.jsx)("b",{children:"configurerId"})," parameter is the ",(0,n.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,n.jsx)("code",{children:"number"}),"."]}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"PromptButtonHoldBegan",group:"event",children:"PromptButtonHoldBegan"}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"PromptButtonHoldEnded",group:"event",children:"PromptButtonHoldEnded"}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"PromptTriggerEnded",group:"event",children:"PromptTriggerEnded"}),"\n",(0,n.jsx)(i.hr,{}),"\n",(0,n.jsx)(a.A,{id:"PromptTriggered",group:"event",children:"PromptTriggered"})]})}function u(e={}){const{wrapper:i}={...(0,o.R)(),...e.components};return i?(0,n.jsx)(i,{...e,children:(0,n.jsx)(h,{...e})}):h(e)}},1113:(e,i,t)=>{t.d(i,{A:()=>n});t(6540);var r=t(4848);function n(e){return(0,r.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,r.jsx)("path",{fill:"currentColor",d:"M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"})})}},9907:(e,i,t)=>{t.d(i,{A:()=>b});t(6540);var r=t(4164),n=t(1312),o=t(6342),a=t(5293),l=t(8774),s=t(3427),d=t(2303),c=t(4848);function h(e){let{children:i,fallback:t}=e;return(0,d.A)()?(0,c.jsx)(c.Fragment,{children:i?.()}):t??null}var u=t(1409),p=t(1113);function g(e){return(0,c.jsx)("svg",{viewBox:"0 0 24 24",...e,children:(0,c.jsx)("path",{fill:"currentColor",d:"M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z"})})}const m={anchorWithStickyNavbar:"anchorWithStickyNavbar_wkc4",anchorWithHideOnScrollNavbar:"anchorWithHideOnScrollNavbar_m_Ui"};var x=t(6347);function b(e){let{id:i,group:t,...d}=e;const b=(0,s.A)(),{navbar:{hideOnScroll:j}}=(0,o.p)();b.collectAnchor(i);const f="group"===t?"h2":"h3",v=(0,n.T)({id:"theme.common.headingLinkTitle",message:"Direct link to {heading}",description:"Title for link to heading"},{heading:i}),P=(0,n.T)({id:"theme.common.markdownLinkTitle",message:"Copy markdown link to {heading}",description:"Markdown for link to heading"},{heading:i}),y=(0,a.G)().colorMode,k=(0,x.zy)().pathname;return(0,c.jsxs)(f,{...d,className:(0,r.A)("anchor",j?m.anchorWithHideOnScrollNavbar:m.anchorWithStickyNavbar,d.className),id:i,children:[d.children,(0,c.jsx)(l.A,{className:"icon-link",to:`#${i}`,"aria-label":v,title:v,children:(0,c.jsx)(g,{width:"0.75em",height:"0.75em"})}),(0,c.jsx)(h,{children:()=>{const e=location.pathname.split("/").filter(Boolean),r=e[e.length-1],n=`[${"group"==t?`\`${r}\`'s ${i.toLowerCase()}`:"method"==t?`\`${r}:${i}()\``:`\`${r}.${i}\``}](<${`${window.location.origin}${k}#${i}`}>)`;return(0,c.jsx)("a",{className:"icon-link","aria-label":P,title:P,onClick:()=>{u.oR.dark((0,c.jsxs)("a",{children:["Copied the ",(0,c.jsx)("code",{children:i})," link to clipboard."]}),{position:"top-center",autoClose:1e3,hideProgressBar:!0,closeOnClick:!0,pauseOnHover:!0,draggable:!1,progress:void 0,theme:y,transition:u.GP}),navigator.clipboard.writeText(n)},children:(0,c.jsx)(p.A,{width:"0.75em",height:"0.75em"})})}})]})}},8453:(e,i,t)=>{t.d(i,{R:()=>a,x:()=>l});var r=t(6540);const n={},o=r.createContext(n);function a(e){const i=r.useContext(o);return r.useMemo((function(){return"function"==typeof e?e(i):{...i,...e}}),[i,e])}function l(e){let i;return i=e.disableParentContext?"function"==typeof e.components?e.components(n):e.components||n:a(e.components),r.createElement(o.Provider,{value:i},e.children)}}}]);
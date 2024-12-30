"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[2443],{3141:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>l,default:()=>d,frontMatter:()=>a,metadata:()=>i,toc:()=>c});const i=JSON.parse('{"id":"objects/Light","title":"Light","description":"Emits light when powered with electricity. Can be colored in different ways, changing the light color.","source":"@site/docs/objects/Light.md","sourceDirName":"objects","slug":"/objects/Light","permalink":"/Pilot.lua-Luau-LSP/objects/Light","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Electrical","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"LifeSensor","permalink":"/Pilot.lua-Luau-LSP/objects/LifeSensor"},"next":{"title":"LightBridge","permalink":"/Pilot.lua-Luau-LSP/objects/LightBridge"}}');var o=n(4848),r=n(8453);const a={tags:["Electrical","Spawnable","Craftable","Programmable","Configurable"]},l=void 0,s={},c=[{value:"Methods",id:"methods",level:2},{value:"SetColor(color)",id:"setcolorcolor",level:3},{value:"Configurables",id:"configurables",level:2},{value:"Brightness",id:"brightness",level:3},{value:"LightRange",id:"lightrange",level:3},{value:"Shadows",id:"shadows",level:3},{value:"Events",id:"events",level:2},{value:"Configured(configurerId)",id:"configuredconfigurerid",level:3}];function h(e){const t={code:"code",h2:"h2",h3:"h3",hr:"hr",p:"p",pre:"pre",...(0,r.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(t.p,{children:"Emits light when powered with electricity. Can be colored in different ways, changing the light color."}),"\n",(0,o.jsx)(t.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,o.jsx)(t.p,{children:"Here is a list of possible sizes that reach the maximum malleability (64) that have integer components: 1x64x1, 1x32x2, 1x16x4, 1x8x8, 2x16x2, 2x8x4, 4x4x4, 8x4x2"}),"\n",(0,o.jsx)(t.p,{children:"At its default size (2x2x2) it has a durability of 1, at its maximum size it has a durability of 3."}),"\n",(0,o.jsxs)(t.p,{children:["By default, its colour is ",(0,o.jsx)("span",{style:{color:"#FFFFFF"},children:"#ffffff"}),"."]}),"\n",(0,o.jsxs)(t.p,{children:["It requires 2 ",(0,o.jsx)("code",{children:"Silicon"})," and 2 ",(0,o.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,o.jsx)(t.h2,{id:"methods",children:"Methods"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"setcolorcolor",children:"SetColor(color)"}),"\n",(0,o.jsx)(t.p,{children:"Sets the color of the object."}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"color"})," parameter is the ",(0,o.jsx)("code",{children:"Color3"})," of the color you want to set the object to. It is a ",(0,o.jsx)("code",{children:"Color3"}),"."]}),"\n",(0,o.jsx)(t.pre,{children:(0,o.jsx)(t.code,{className:"language-lua",children:"local sift = require(\"sift\") -- Grab this fancy library for manipulating tables provided by wos.\n\n-- Get all of the types of objects with a `:SetColor` method and merge them into one big table.\nlocal objects = sift.Array.merge(\n    GetParts(\"Light\"),\n    GetParts(\"LightTube\"),\n    GetParts(\"SpotLight\"),\n    GetParts(\"EnergyShield\")\n)\n\n-- We want this to run infinitely, but we want to run it every frame, rather than every game\n-- tick, so we won't use the `Microcontroller.Loop` event.\nwhile true do\n    -- First we want to get the current time, the function `os.clock` gives us a very precise\n    -- measurement of the current time (if you want to know, it basically uses the internal\n    -- clock of the computer running the code).\n    local currentTime = os.clock()\n\n    -- We then use the 'modulo' operator, what this does is it gives you the 'remainder'\n    -- from the division. So if you do something like `5.25 % 1` you get out the `0.25`,\n    -- or if you do, say, `31 % 2`, since 31 isn't divisble by 2 you get a remainder of `1`.\n\n    -- We do this so we just get the fractional aspect of the time (which would be the\n    -- milliseconds), giving us a number between 0 and 1.\n    local hue = currentTime % 1\n\n    -- We then construct a `Color3` passing in the value we just calculated, which, since\n    -- we used the modulo operator is always going to be between 0 and 1, the exact range\n    -- needed for the 'hue' of the `fromHSV`. We just set the 'saturation' and 'brightness'\n    -- to 1 to keep the colour nice and bright.\n\n    -- A helpful feature of the HSV colour space is that a hue of both `0` and `1` are red!\n    local color = Color3.fromHSV(hue, 1, 1)\n\n    -- Now we have our colour, we just want to apply it to all of our objects, so we'll use\n    -- a simple for loop. The 'index' or 'key' value is named '_' since we don't need it,\n    -- and naming it '_' is a good way to say it's an unused variable.\n    for _, object in objects do\n        -- Simply call the `SetColor` method (since it's a method, we use a `:` when\n        -- calling the function, rather than a `.`) passing in the `Color3`!\n        object:SetColor(color)\n    end\n\n      -- Wait a little bit before updating the colour again!\n    task.wait()\nend\n"})}),"\n",(0,o.jsx)(t.h2,{id:"configurables",children:"Configurables"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"brightness",children:"Brightness"}),"\n",(0,o.jsxs)(t.p,{children:["The brightness of the light. It is a ",(0,o.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 2."]}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"lightrange",children:"LightRange"}),"\n",(0,o.jsxs)(t.p,{children:["The range of the light. It is a ",(0,o.jsx)("code",{children:"number"}),".\nIt ranges between 1 and 60."]}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"shadows",children:"Shadows"}),"\n",(0,o.jsxs)(t.p,{children:["Whether or not the light will cast shadows. It is a ",(0,o.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,o.jsx)(t.h2,{id:"events",children:"Events"}),"\n",(0,o.jsx)(t.hr,{}),"\n",(0,o.jsx)(t.h3,{id:"configuredconfigurerid",children:"Configured(configurerId)"}),"\n",(0,o.jsx)(t.p,{children:"Fires when the object is configured."}),"\n",(0,o.jsxs)(t.p,{children:["The ",(0,o.jsx)("b",{children:"configurerId"})," parameter is the ",(0,o.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,o.jsx)("code",{children:"number"}),"."]})]})}function d(e={}){const{wrapper:t}={...(0,r.R)(),...e.components};return t?(0,o.jsx)(t,{...e,children:(0,o.jsx)(h,{...e})}):h(e)}},8453:(e,t,n)=>{n.d(t,{R:()=>a,x:()=>l});var i=n(6540);const o={},r=i.createContext(o);function a(e){const t=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function l(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:a(e.components),i.createElement(r.Provider,{value:t},e.children)}}}]);
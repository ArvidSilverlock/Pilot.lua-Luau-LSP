"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[5067],{4418:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>a,contentTitle:()=>l,default:()=>c,frontMatter:()=>s,metadata:()=>i,toc:()=>d});const i=JSON.parse('{"id":"objects/EnergyShield","title":"EnergyShield","description":"Generates a forcefield protecting its interior from energy-based weapons such as Lasers and PlasmaCannons, and offers full protection from Warhead explosions.","source":"@site/docs/objects/EnergyShield.md","sourceDirName":"objects","slug":"/objects/EnergyShield","permalink":"/Pilot.lua-Luau-LSP/objects/EnergyShield","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"EnergyGun","permalink":"/Pilot.lua-Luau-LSP/objects/EnergyGun"},"next":{"title":"EnergySword","permalink":"/Pilot.lua-Luau-LSP/objects/EnergySword"}}');var r=t(4848),o=t(8453);const s={tags:["Spawnable","Craftable","Programmable","Configurable"]},l=void 0,a={},d=[{value:"Methods",id:"methods",level:2},{value:"CalculateCost(radius) \u2192 cost",id:"calculatecostradius--cost",level:3},{value:"GetShieldHealth() \u2192 health",id:"getshieldhealth--health",level:3},{value:"SetColor(color)",id:"setcolorcolor",level:3},{value:"Configurables",id:"configurables",level:2},{value:"RegenerationSpeed",id:"regenerationspeed",level:3},{value:"ShieldRadius",id:"shieldradius",level:3},{value:"ShieldStrength",id:"shieldstrength",level:3},{value:"Events",id:"events",level:2},{value:"Configured(configurerId)",id:"configuredconfigurerid",level:3},{value:"Loop(deltaTime)",id:"loopdeltatime",level:3}];function h(e){const n={code:"code",h2:"h2",h3:"h3",hr:"hr",p:"p",pre:"pre",...(0,o.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsxs)(n.p,{children:["Generates a forcefield protecting its interior from energy-based weapons such as ",(0,r.jsx)("code",{children:"Lasers"})," and ",(0,r.jsx)("code",{children:"PlasmaCannons"}),", and offers full protection from Warhead explosions.\nAn EnergyShield has a few sets of properties that you can fine tune to create a balanced shield."]}),"\n",(0,r.jsxs)(n.p,{children:[(0,r.jsx)("code",{children:"ShieldRadius"})," - The size of the entire shield. This will exponentially consume more power the higher the radius is.\n",(0,r.jsx)("code",{children:"RegenerationSpeed"})," - Scale from 1 to 10 on how fast the shield will regenerate. The shield will not regenerate while unpowered.\n",(0,r.jsx)("code",{children:"ShieldStrength"})," - Scale from 1 to 10 on how much the shield can endure."]}),"\n",(0,r.jsxs)(n.p,{children:[(0,r.jsx)("code",{children:"RegenerationSpeed"})," and ",(0,r.jsx)("code",{children:"ShieldStrength"})," combined must not exceed 11."]}),"\n",(0,r.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,r.jsx)(n.p,{children:"It cannot be resized."}),"\n",(0,r.jsx)(n.p,{children:"At its default size (5x5x7) it has a durability of 8."}),"\n",(0,r.jsxs)(n.p,{children:["By default, its colour is ",(0,r.jsx)("span",{style:{color:"#7FB2FF"},children:"#7fb2ff"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["It requires 50 ",(0,r.jsx)("code",{children:"Aluminum"}),", 200 ",(0,r.jsx)("code",{children:"Iron"}),", 75 ",(0,r.jsx)("code",{children:"Quartz"}),", and 90 ",(0,r.jsx)("code",{children:"Silicon"})," to be crafted."]}),"\n",(0,r.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"calculatecostradius--cost",children:"CalculateCost(radius) \u2192 cost"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"radius"})," parameter is if ",(0,r.jsx)("code",{children:"nil"}),", will default to the ",(0,r.jsx)("code",{children:"EnergyShield.Radius"})," configuration. The parameter is not bound by the constrains of ",(0,r.jsx)("code",{children:"EnergyShield.Radius"})," and will accept any input. It is a ",(0,r.jsx)("code",{children:"number"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"cost"})," return is the ",(0,r.jsx)("code",{children:"Power"})," cost per game tick to keep the ",(0,r.jsx)("code",{children:"EnergyShield"})," running. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getshieldhealth--health",children:"GetShieldHealth() \u2192 health"}),"\n",(0,r.jsxs)(n.p,{children:["Gets the current health of the shield as a percentage between ",(0,r.jsx)("code",{children:"0"})," and ",(0,r.jsx)("code",{children:"1"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"health"})," return is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"setcolorcolor",children:"SetColor(color)"}),"\n",(0,r.jsx)(n.p,{children:"Sets the color of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"color"})," parameter is the ",(0,r.jsx)("code",{children:"Color3"})," of the color you want to set the object to. It is a ",(0,r.jsx)("code",{children:"Color3"}),"."]}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-lua",children:"local sift = require(\"sift\") -- Grab this fancy library for manipulating tables provided by wos.\n\n-- Get all of the types of objects with a `:SetColor` method and merge them into one big table.\nlocal objects = sift.Array.merge(\n    GetParts(\"Light\"),\n    GetParts(\"LightTube\"),\n    GetParts(\"SpotLight\"),\n    GetParts(\"EnergyShield\")\n)\n\n-- We want this to run infinitely, but we want to run it every frame, rather than every game\n-- tick, so we won't use the `Microcontroller.Loop` event.\nwhile true do\n    -- First we want to get the current time, the function `os.clock` gives us a very precise\n    -- measurement of the current time (if you want to know, it basically uses the internal\n    -- clock of the computer running the code).\n    local currentTime = os.clock()\n\n    -- We then use the 'modulo' operator, what this does is it gives you the 'remainder'\n    -- from the division. So if you do something like `5.25 % 1` you get out the `0.25`,\n    -- or if you do, say, `31 % 2`, since 31 isn't divisble by 2 you get a remainder of `1`.\n\n    -- We do this so we just get the fractional aspect of the time (which would be the\n    -- milliseconds), giving us a number between 0 and 1.\n    local hue = currentTime % 1\n\n    -- We then construct a `Color3` passing in the value we just calculated, which, since\n    -- we used the modulo operator is always going to be between 0 and 1, the exact range\n    -- needed for the 'hue' of the `fromHSV`. We just set the 'saturation' and 'brightness'\n    -- to 1 to keep the colour nice and bright.\n\n    -- A helpful feature of the HSV colour space is that a hue of both `0` and `1` are red!\n    local color = Color3.fromHSV(hue, 1, 1)\n\n    -- Now we have our colour, we just want to apply it to all of our objects, so we'll use\n    -- a simple for loop. The 'index' or 'key' value is named '_' since we don't need it,\n    -- and naming it '_' is a good way to say it's an unused variable.\n    for _, object in objects do\n        -- Simply call the `SetColor` method (since it's a method, we use a `:` when\n        -- calling the function, rather than a `.`) passing in the `Color3`!\n        object:SetColor(color)\n    end\n\n      -- Wait a little bit before updating the colour again!\n    task.wait()\nend\n"})}),"\n",(0,r.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"regenerationspeed",children:"RegenerationSpeed"}),"\n",(0,r.jsxs)(n.p,{children:["Determines how fast the shield regenerates after being hit. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 1 and 10."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"shieldradius",children:"ShieldRadius"}),"\n",(0,r.jsxs)(n.p,{children:["The size of the entire shield. The shield exponentially consumes more power the higher this is. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 50 and 1000."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"shieldstrength",children:"ShieldStrength"}),"\n",(0,r.jsxs)(n.p,{children:["Determines the shield's resistance to damage. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 1 and 10."]}),"\n",(0,r.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"configuredconfigurerid",children:"Configured(configurerId)"}),"\n",(0,r.jsx)(n.p,{children:"Fires when the object is configured."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"configurerId"})," parameter is the ",(0,r.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"loopdeltatime",children:"Loop(deltaTime)"}),"\n",(0,r.jsx)(n.p,{children:"Fires when the object is updated by the game loop."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"deltaTime"})," parameter is the 'time' since the last tick, it does not represent the ",(0,r.jsx)("i",{children:"actual"})," time since the last tick was occurred, rather just how often a game tick should be fired (it will always be precisely ",(0,r.jsx)("code",{children:"1"}),"). It is a ",(0,r.jsx)("code",{children:"number"}),"."]})]})}function c(e={}){const{wrapper:n}={...(0,o.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(h,{...e})}):h(e)}},8453:(e,n,t)=>{t.d(n,{R:()=>s,x:()=>l});var i=t(6540);const r={},o=i.createContext(r);function s(e){const n=i.useContext(o);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:s(e.components),i.createElement(o.Provider,{value:n},e.children)}}}]);
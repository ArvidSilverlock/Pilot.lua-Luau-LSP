"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[5151],{220:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>o,contentTitle:()=>l,default:()=>h,frontMatter:()=>a,metadata:()=>r,toc:()=>c});const r=JSON.parse('{"id":"objects/Screen","title":"Screen","description":"Allows for the programmatic creation of GUI elements.","source":"@site/docs/objects/Screen.md","sourceDirName":"objects","slug":"/objects/Screen","permalink":"/Pilot.lua-Luau-LSP/objects/Screen","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Logic","permalink":"/Pilot.lua-Luau-LSP/tags/logic"},{"inline":true,"label":"Electrical","permalink":"/Pilot.lua-Luau-LSP/tags/electrical"},{"inline":true,"label":"Spawnable","permalink":"/Pilot.lua-Luau-LSP/tags/spawnable"},{"inline":true,"label":"Craftable","permalink":"/Pilot.lua-Luau-LSP/tags/craftable"},{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","frontMatter":{"tags":["Logic","Electrical","Spawnable","Craftable","Programmable","Configurable"]},"sidebar":"objectsSidebar","previous":{"title":"Scrapper","permalink":"/Pilot.lua-Luau-LSP/objects/Scrapper"},"next":{"title":"ScubaMask","permalink":"/Pilot.lua-Luau-LSP/objects/ScubaMask"}}');var i=t(4848),s=t(8453);const a={tags:["Logic","Electrical","Spawnable","Craftable","Programmable","Configurable"]},l=void 0,o={},c=[{value:"Methods",id:"methods",level:2},{value:"ClearElements()",id:"clearelements",level:3},{value:"CreateElement(className, properties) \u2192 element",id:"createelementclassname-properties--element",level:3},{value:"GetCanvas() \u2192 canvas",id:"getcanvas--canvas",level:3},{value:"GetDimensions() \u2192 dimensions",id:"getdimensions--dimensions",level:3},{value:"Configurables",id:"configurables",level:2},{value:"VideoID",id:"videoid",level:3},{value:"Events",id:"events",level:2},{value:"Configured(configurerId)",id:"configuredconfigurerid",level:3}];function d(e){const n={a:"a",code:"code",h2:"h2",h3:"h3",hr:"hr",li:"li",p:"p",pre:"pre",ul:"ul",...(0,s.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.p,{children:"Allows for the programmatic creation of GUI elements."}),"\n",(0,i.jsxs)(n.p,{children:["Internally, it utilises a ",(0,i.jsx)(n.a,{href:"https://create.roblox.com/docs/reference/engine/classes/SurfaceGui",children:(0,i.jsx)("code",{children:"SurfaceGUI"})}),", and is therefore no different from normal roblox GUIs."]}),"\n",(0,i.jsxs)(n.p,{children:["There are some limitations with ",(0,i.jsx)("code",{children:"Screen"}),"s in Waste of Space, such as an inability to use ",(0,i.jsx)("code",{children:(0,i.jsx)(n.a,{href:"https://create.roblox.com/docs/reference/engine/classes/SurfaceGui",children:"ViewportFrame"})}),"s"]}),"\n",(0,i.jsx)(n.pre,{children:(0,i.jsx)(n.code,{className:"language-lua",children:'-- Try and get the screen part, throw an error if we don\'t find it using `assert`.\nlocal screen = assert(GetPart("Screen"), "no screen connected")\n\n-- Create a text label with the text \'Hello, world!\' which takes up the entire screen.\nlocal textLabel = Instance.new("TextLabel")\ntextLabel.Text = "Hello, world!"\ntextLabel.Size = UDim2.fromScale(1, 1)\ntextLabel.BorderSizePixel = 0\ntextLabel.BackgroundColor = Color3.fromRGB(255, 255, 255)\n\n-- Parent it to the \'canvas\' of the screen.\ntextLabel.Parent = screen:GetCanvas()\n\n-- Keep the microcontroller on by permanently \'yielding\' the code (making it wait).\ncoroutine.yield()\n'})}),"\n",(0,i.jsx)(n.p,{children:"It is a craftable and spawnable non-flammable solid."}),"\n",(0,i.jsx)(n.p,{children:"Here is a list of possible sizes that reach the maximum malleability (400) that have integer components: 1x400x1, 1x200x2, 1x100x4, 1x80x5, 1x50x8, 1x40x10, 1x25x16, 1x20x20, 2x100x2, 2x50x4, 2x40x5, 2x25x8, 2x20x10, 4x25x4, 4x20x5, 4x10x10, 5x16x5, 5x10x8, 10x8x5, 16x5x5, 20x10x2, 20x5x4"}),"\n",(0,i.jsx)(n.p,{children:"At its default size (8x1x8) it has a durability of 1, at its maximum size it has a durability of 2."}),"\n",(0,i.jsxs)(n.p,{children:["By default, its colour is ",(0,i.jsx)("span",{style:{color:"#111111"},children:"#111111"}),"."]}),"\n",(0,i.jsxs)(n.p,{children:["It requires 5 ",(0,i.jsx)("code",{children:"Glass"}),", 3 ",(0,i.jsx)("code",{children:"Iron"}),", 3 ",(0,i.jsx)("code",{children:"Light"}),", 3 ",(0,i.jsx)("code",{children:"Silicon"}),", and 3 ",(0,i.jsx)("code",{children:"Wire"})," to be crafted."]}),"\n",(0,i.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"clearelements",children:"ClearElements()"}),"\n",(0,i.jsx)(n.p,{children:"Clears all objects that are descendants of the screen."}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"createelementclassname-properties--element",children:"CreateElement(className, properties) \u2192 element"}),"\n",(0,i.jsx)(n.p,{children:"Creates an element of the specified class name with the specified properties."}),"\n",(0,i.jsxs)(n.p,{children:["The parameters for ",(0,i.jsx)("code",{children:"CreateElement"})," are as follows:"]}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"className"})," parameter is a ",(0,i.jsx)("code",{children:"string"}),"."]}),"\n",(0,i.jsxs)(n.li,{children:["The ",(0,i.jsx)("b",{children:"properties"})," parameter is a dictionary with keys that are ",(0,i.jsx)("code",{children:"string"}),"s and values that are ",(0,i.jsx)("code",{children:"any"}),"s."]}),"\n"]}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"element"})," return is an ",(0,i.jsx)("code",{children:"Instance"}),"."]}),"\n",(0,i.jsx)(n.pre,{children:(0,i.jsx)(n.code,{className:"language-lua",children:'-- Try and get the screen part, throw an error if we don\'t find it using `assert`.\nlocal screen = assert(GetPart("Screen"), "no screen connected")\n\n-- Clear the left over screen elements from the last time GUIs were loaded onto it.\n-- Note: If you utilise the `Instance.new` API instead, you do not need to do this,\n--       as objects created through said API are *automatically* deleted when the\n--       microcontroller stops running.\nscreen:ClearElements()\n\n-- Call the `CreateElement` method with the `ClassName` of the object you want to create,\n-- and a dictionary of the properties to apply (you cannot specify the `Parent` property).\nlocal textLabel = screen:CreateElement("TextLabel", {\n    Text = "Hello, world!",\n    Size = UDim2.fromScale(1, 1),\n    BorderSizePixel = 0,\n    BackgroundColor = Color3.fromRGB(255, 255, 255),\n})\n\n-- Keep the microcontroller on by permanently \'yielding\' the code (making it wait).\ncoroutine.yield()\n'})}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"getcanvas--canvas",children:"GetCanvas() \u2192 canvas"}),"\n",(0,i.jsx)(n.p,{children:"Returns the parent container of all the screen's content."}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"canvas"})," return is a ",(0,i.jsx)("code",{children:"Frame"}),"."]}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"getdimensions--dimensions",children:"GetDimensions() \u2192 dimensions"}),"\n",(0,i.jsxs)(n.p,{children:["Gets the size of the screen in pixels in the form of a ",(0,i.jsx)("code",{children:"Vector2"}),"."]}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"dimensions"})," return is the size of the screen in pixels. It is a ",(0,i.jsx)("code",{children:"Vector2"}),"."]}),"\n",(0,i.jsx)(n.pre,{children:(0,i.jsx)(n.code,{className:"language-lua",children:'-- Try and get the screen part, throw an error if we don\'t find it using `assert`.\nlocal screen = assert(GetPart("Screen"), "no screen connected")\n\n-- Store the current screen size.\nlocal previousScreenSize = screen:GetDimensions()\n\n-- Connect to the `Loop` event of the `Microcontroller` that is running the code,\n-- this will make the code within run precisely every game tick.\nMicrocontroller.Loop:Connect(function()\n    -- Get the new current screen dimensions.\n    local screenSize = screen:GetDimensions()\n\n    -- Compare these new dimensions with the previously recorded dimensions, if\n    -- they are equal, cancel this running code with \'return\'.\n    if screenSize == previousScreenSize then return end\n\n    -- Do something with the information about the screen dimensions changing,\n    -- in this case, it triggers a print statement.\n    print(`The screen size changed! It used to be {previousScreenSize}, but is now {screenSize}!`)\n\n    -- Update the stored current dimensions as to make them accurately reflect reality.\n    previousScreenSize = screenSize\nend)\n'})}),"\n",(0,i.jsx)(n.h2,{id:"configurables",children:"Configurables"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"videoid",children:"VideoID"}),"\n",(0,i.jsxs)(n.p,{children:["The ID of the camera feed being to be viewed, or 0 for none. It is a ",(0,i.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 10000000000. It increments by 1."]}),"\n",(0,i.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,i.jsx)(n.hr,{}),"\n",(0,i.jsx)(n.h3,{id:"configuredconfigurerid",children:"Configured(configurerId)"}),"\n",(0,i.jsx)(n.p,{children:"Fires when the object is configured."}),"\n",(0,i.jsxs)(n.p,{children:["The ",(0,i.jsx)("b",{children:"configurerId"})," parameter is the ",(0,i.jsx)("code",{children:"UserId"})," of the player who configured the object. It is a ",(0,i.jsx)("code",{children:"number"}),"."]})]})}function h(e={}){const{wrapper:n}={...(0,s.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(d,{...e})}):d(e)}},8453:(e,n,t)=>{t.d(n,{R:()=>a,x:()=>l});var r=t(6540);const i={},s=r.createContext(i);function a(e){const n=r.useContext(s);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:a(e.components),r.createElement(s.Provider,{value:n},e.children)}}}]);
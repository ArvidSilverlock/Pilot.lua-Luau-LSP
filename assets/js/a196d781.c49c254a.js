"use strict";(self.webpackChunkwaste_of_space_wiki=self.webpackChunkwaste_of_space_wiki||[]).push([[6694],{4361:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>a,contentTitle:()=>o,default:()=>h,frontMatter:()=>l,metadata:()=>i,toc:()=>d});const i=JSON.parse('{"id":"objects/PilotObject","title":"PilotObject","description":"The base object that all other objects inherit from.","source":"@site/docs/objects/PilotObject.md","sourceDirName":"objects","slug":"/objects/PilotObject","permalink":"/Pilot.lua-Luau-LSP/objects/PilotObject","draft":false,"unlisted":false,"tags":[{"inline":true,"label":"Programmable","permalink":"/Pilot.lua-Luau-LSP/tags/programmable"},{"inline":true,"label":"Configurable","permalink":"/Pilot.lua-Luau-LSP/tags/configurable"}],"version":"current","sidebarPosition":1,"frontMatter":{"sidebar_position":1,"tags":["Programmable","Configurable"]},"sidebar":"objectsSidebar","next":{"title":"100k","permalink":"/Pilot.lua-Luau-LSP/objects/100k"}}');var r=s(4848),t=s(8453);const l={sidebar_position:1,tags:["Programmable","Configurable"]},o=void 0,a={},d=[{value:"Methods",id:"methods",level:2},{value:"CanInstallComponent(componentName) \u2192 canInstall",id:"caninstallcomponentcomponentname--caninstall",level:3},{value:"CanUninstallComponent(componentName) \u2192 canUninstall",id:"canuninstallcomponentcomponentname--canuninstall",level:3},{value:"Click()",id:"click",level:3},{value:"GetComponent(componentName) \u2192 component",id:"getcomponentcomponentname--component",level:3},{value:"GetConfigurables() \u2192 configurables",id:"getconfigurables--configurables",level:3},{value:"GetEvents() \u2192 events",id:"getevents--events",level:3},{value:"GetMethods() \u2192 methods",id:"getmethods--methods",level:3},{value:"GetOwnerId() \u2192 ownerId",id:"getownerid--ownerid",level:3},{value:"GetShape() \u2192 shape",id:"getshape--shape",level:3},{value:"HasComponent() \u2192 hasComponent",id:"hascomponent--hascomponent",level:3},{value:"HasPermission(permission) \u2192 hasPermission",id:"haspermissionpermission--haspermission",level:3},{value:"IsDestroyed() \u2192 isDestroyed",id:"isdestroyed--isdestroyed",level:3},{value:"IsGrounded() \u2192 isGrounded",id:"isgrounded--isgrounded",level:3},{value:"ListComponents() \u2192 components",id:"listcomponents--components",level:3},{value:"Trigger()",id:"trigger",level:3},{value:"<del><i>GetColor() \u2192 color</i></del>",id:"getcolor--color",level:3},{value:"<del><i>GetDurability() \u2192 durability</i></del>",id:"getdurability--durability",level:3},{value:"<del><i>GetNameOfOwnerAsync() \u2192 ownerUsername</i></del>",id:"getnameofownerasync--ownerusername",level:3},{value:"<del><i>GetSize() \u2192 size</i></del>",id:"getsize--size",level:3},{value:"<del><i>GetTemperature() \u2192 temperature</i></del>",id:"gettemperature--temperature",level:3},{value:"Properties",id:"properties",level:2},{value:"Anchored",id:"anchored",level:3},{value:"AssemblyCenterOfMass",id:"assemblycenterofmass",level:3},{value:"AssemblyLinearVelocity",id:"assemblylinearvelocity",level:3},{value:"AssemblyMass",id:"assemblymass",level:3},{value:"CFrame",id:"cframe",level:3},{value:"ClassName",id:"classname",level:3},{value:"Color",id:"color",level:3},{value:"CreatedBy",id:"createdby",level:3},{value:"Durability",id:"durability",level:3},{value:"GUID",id:"guid",level:3},{value:"Health",id:"health",level:3},{value:"Heat",id:"heat",level:3},{value:"Mass",id:"mass",level:3},{value:"Material",id:"material",level:3},{value:"Orientation",id:"orientation",level:3},{value:"PartLocked",id:"partlocked",level:3},{value:"Position",id:"position",level:3},{value:"Size",id:"size",level:3},{value:"Temperature",id:"temperature",level:3},{value:"Events",id:"events",level:2},{value:"Destroying",id:"destroying",level:3}];function c(e){const n={a:"a",admonition:"admonition",code:"code",h2:"h2",h3:"h3",hr:"hr",p:"p",pre:"pre",...(0,t.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.p,{children:"The base object that all other objects inherit from."}),"\n",(0,r.jsx)(n.h2,{id:"methods",children:"Methods"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"caninstallcomponentcomponentname--caninstall",children:"CanInstallComponent(componentName) \u2192 canInstall"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"componentName"})," parameter is a ",(0,r.jsx)("code",{children:"ComponentName"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"canInstall"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"canuninstallcomponentcomponentname--canuninstall",children:"CanUninstallComponent(componentName) \u2192 canUninstall"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"componentName"})," parameter is a ",(0,r.jsx)("code",{children:"ComponentName"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"canUninstall"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"click",children:"Click()"}),"\n",(0,r.jsxs)(n.p,{children:["Emulates a user clicking on the object, seems dysfunctional in some cases, (i.e., ",(0,r.jsx)("code",{children:"ClickButton"})," components do not get triggered)."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getcomponentcomponentname--component",children:"GetComponent(componentName) \u2192 component"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"componentName"})," parameter is a ",(0,r.jsx)("code",{children:"ComponentName"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"component"})," return is a ",(0,r.jsx)("code",{children:"Component"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getconfigurables--configurables",children:"GetConfigurables() \u2192 configurables"}),"\n",(0,r.jsx)(n.p,{children:"Gets information about the configurables of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"configurables"})," return is a dictionary with keys that are ",(0,r.jsx)("code",{children:"string"}),"s and values that are ",(0,r.jsx)("code",{children:"ConfigurableData"}),"s."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getevents--events",children:"GetEvents() \u2192 events"}),"\n",(0,r.jsx)(n.p,{children:"Gets information about the events of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"events"})," return is an array of event names. It is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getmethods--methods",children:"GetMethods() \u2192 methods"}),"\n",(0,r.jsx)(n.p,{children:"Gets information about the methods of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"methods"})," return is a dictionary with keys that are ",(0,r.jsx)("code",{children:"string"}),"s and values that are ",(0,r.jsx)("code",{children:"MethodData"}),"s."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getownerid--ownerid",children:"GetOwnerId() \u2192 ownerId"}),"\n",(0,r.jsx)(n.p,{children:"Returns who locked the part if the part is locked, otherwise returns who created the part."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"ownerId"})," return is a ",(0,r.jsx)("code",{children:"number"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getshape--shape",children:"GetShape() \u2192 shape"}),"\n",(0,r.jsxs)(n.p,{children:["Gets the shape of the part, if the part is a block, it will return ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"shape"})," return is a ",(0,r.jsx)("code",{children:"string"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"hascomponent--hascomponent",children:"HasComponent() \u2192 hasComponent"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"hasComponent"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"haspermissionpermission--haspermission",children:"HasPermission(permission) \u2192 hasPermission"}),"\n",(0,r.jsx)(n.p,{children:"Returns a boolean as to whether or not the microcontroller has permission to do the specified action."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"permission"})," parameter is a ",(0,r.jsx)("code",{children:"Permission"}),"."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"hasPermission"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"isdestroyed--isdestroyed",children:"IsDestroyed() \u2192 isDestroyed"}),"\n",(0,r.jsx)(n.p,{children:"Returns a boolean as to whether or not the object is destroyed."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"isDestroyed"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"isgrounded--isgrounded",children:"IsGrounded() \u2192 isGrounded"}),"\n",(0,r.jsx)(n.p,{children:"Tells you if the part is grounded, meaning it does it have physics. If it is attached to terrain or an anchor for example, it will be grounded."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"isGrounded"})," return is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"listcomponents--components",children:"ListComponents() \u2192 components"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"components"})," return is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"trigger",children:"Trigger()"}),"\n",(0,r.jsx)(n.p,{children:"Triggers the object."}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getcolor--color",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetColor() \u2192 color"})})}),"\n",(0,r.jsx)(n.admonition,{type:"warning",children:(0,r.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,r.jsx)("code",{children:"PilotObject.Color"})," instead."]})}),"\n",(0,r.jsx)(n.p,{children:"Gets the color of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"color"})," return is a ",(0,r.jsx)("code",{children:"Color3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getdurability--durability",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetDurability() \u2192 durability"})})}),"\n",(0,r.jsx)(n.admonition,{type:"warning",children:(0,r.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,r.jsx)("code",{children:"PilotObject.Durability"})," instead."]})}),"\n",(0,r.jsxs)(n.p,{children:["Gets the ",(0,r.jsx)("i",{children:"maximum"})," (not current) durability of the object."]}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"durability"})," return is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getnameofownerasync--ownerusername",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetNameOfOwnerAsync() \u2192 ownerUsername"})})}),"\n",(0,r.jsx)(n.admonition,{type:"warning",children:(0,r.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,r.jsxs)("code",{children:['require("player")',":GetNameFromUserIdAsync"]})," instead."]})}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"ownerUsername"})," return is a ",(0,r.jsx)("code",{children:"string"}),". It can also be ",(0,r.jsx)("code",{children:"nil"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"getsize--size",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetSize() \u2192 size"})})}),"\n",(0,r.jsx)(n.admonition,{type:"warning",children:(0,r.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,r.jsx)("code",{children:"PilotObject.Size"})," instead."]})}),"\n",(0,r.jsx)(n.p,{children:"Gets the size of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"size"})," return is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"gettemperature--temperature",children:(0,r.jsx)("del",{children:(0,r.jsx)("i",{children:"GetTemperature() \u2192 temperature"})})}),"\n",(0,r.jsx)(n.admonition,{type:"warning",children:(0,r.jsxs)(n.p,{children:["This method is deprecated. Use ",(0,r.jsx)("code",{children:"PilotObject.Temperature"})," instead."]})}),"\n",(0,r.jsx)(n.p,{children:"Gets the temperature of the object."}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("b",{children:"temperature"})," return is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.h2,{id:"properties",children:"Properties"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"anchored",children:"Anchored"}),"\n",(0,r.jsxs)(n.p,{children:["Whether or not the object is anchored. It is a ",(0,r.jsx)("code",{children:"boolean"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"assemblycenterofmass",children:"AssemblyCenterOfMass"}),"\n",(0,r.jsxs)(n.p,{children:["The center of mass of the object's assembly. It is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"assemblylinearvelocity",children:"AssemblyLinearVelocity"}),"\n",(0,r.jsxs)(n.p,{children:["The velocity of the object's assembly. It is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"assemblymass",children:"AssemblyMass"}),"\n",(0,r.jsxs)(n.p,{children:["The total mass of the object's assembly. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"cframe",children:"CFrame"}),"\n",(0,r.jsxs)(n.p,{children:["The current ",(0,r.jsx)("code",{children:"CFrame"})," of the object. It is a ",(0,r.jsx)("code",{children:"CFrame"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"classname",children:"ClassName"}),"\n",(0,r.jsxs)(n.p,{children:["A string representing the type of the object. It is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"color",children:"Color"}),"\n",(0,r.jsxs)(n.p,{children:["The current color of the object. It is a ",(0,r.jsx)("code",{children:"Color3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"createdby",children:"CreatedBy"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("code",{children:"UserId"})," of the user who ",(0,r.jsx)("i",{children:"created"})," the part. Will be ",(0,r.jsx)("code",{children:"nil"})," if the part was created by a constructor. It is a ",(0,r.jsx)("code",{children:"number?"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"durability",children:"Durability"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("i",{children:"total"})," durability of the object. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-lua",children:'-- It can alternatively be calculated like so:\nlocal partdata = require("partdata")\nlocal partInfo = assert(partdata.Parts[part.ClassName], "unknown part")\n\nlocal baseVolume = partInfo.BaseSize[1] * partInfo.BaseSize[2] * partInfo.BaseSize[3]\nlocal volume = part.Size.X * part.Size.Y * part.Size.Z\n\nlocal durability = ( volume / baseVolume ) ^ ( 1 / 3 ) * partInfo.BaseDurability\n'})}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"guid",children:"GUID"}),"\n",(0,r.jsxs)(n.p,{children:["It is a ",(0,r.jsx)("code",{children:"string"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"health",children:"Health"}),"\n",(0,r.jsxs)(n.p,{children:["The health of the object as a ",(0,r.jsx)("i",{children:"percentage"})," (between 0 and 1) of the total durability. It is a ",(0,r.jsx)("code",{children:"number"}),".\nIt ranges between 0 and 1."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"heat",children:"Heat"}),"\n",(0,r.jsxs)(n.p,{children:["The current ",(0,r.jsx)(n.a,{href:"https://en.wikipedia.org/wiki/Heat",children:(0,r.jsx)("i",{children:"heat"})})," of the object, this is different from the ",(0,r.jsx)("i",{children:"temperature"}),". It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"mass",children:"Mass"}),"\n",(0,r.jsxs)(n.p,{children:["The mass of the object. It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"material",children:"Material"}),"\n",(0,r.jsxs)(n.p,{children:["The current material of the object as an ",(0,r.jsx)(n.a,{href:"https://create.roblox.com/docs/reference/engine/enums/Material",children:(0,r.jsx)("code",{children:"Enum.Material"})}),". It is an ",(0,r.jsx)("code",{children:"Enum.Material"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"orientation",children:"Orientation"}),"\n",(0,r.jsxs)(n.p,{children:["The current orientation of the object. It is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"partlocked",children:"PartLocked"}),"\n",(0,r.jsxs)(n.p,{children:["The ",(0,r.jsx)("code",{children:"UserId"})," of the user who ",(0,r.jsx)("i",{children:"locked"})," the part. Will be ",(0,r.jsx)("code",{children:"nil"})," if the part is unlocked. It is a ",(0,r.jsx)("code",{children:"number?"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"position",children:"Position"}),"\n",(0,r.jsxs)(n.p,{children:["The current position of the object. It is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"size",children:"Size"}),"\n",(0,r.jsxs)(n.p,{children:["The current size of the object. It is a ",(0,r.jsx)("code",{children:"Vector3"}),"."]}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"temperature",children:"Temperature"}),"\n",(0,r.jsxs)(n.p,{children:["The current ",(0,r.jsx)(n.a,{href:"https://en.wikipedia.org/wiki/Temperature",children:(0,r.jsx)("i",{children:"temperature"})})," of the object, this is different from the ",(0,r.jsx)("i",{children:"heat"}),". It is a ",(0,r.jsx)("code",{children:"number"}),"."]}),"\n",(0,r.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,r.jsx)(n.hr,{}),"\n",(0,r.jsx)(n.h3,{id:"destroying",children:"Destroying"}),"\n",(0,r.jsx)(n.p,{children:"Fires when the object is destroyed."})]})}function h(e={}){const{wrapper:n}={...(0,t.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(c,{...e})}):c(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>l,x:()=>o});var i=s(6540);const r={},t=i.createContext(r);function l(e){const n=i.useContext(t);return i.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function o(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:l(e.components),i.createElement(t.Provider,{value:n},e.children)}}}]);
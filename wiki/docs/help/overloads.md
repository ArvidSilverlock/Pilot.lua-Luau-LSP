# Overloads

You might see the word "overload" in relation to functions, this is [function overloading](https://en.wikipedia.org/wiki/Function_overloading). It basically means depending on the parameters you pass, the function may do different things (i.e., returning a different type, interpreting the parameters differently).

In the case of [<code>ARController:GetCanvas()</code>](/objects/ARController#GetCanvas), it is used to outline the fact <code>ARController:GetCanvas("3D")</code> returns a <code>WorldModel</code>, whereas <code>ARController:GetCanvas("2D")</code> returns a <code>Folder</code>.

HarmonyCodea
=============

HarmonyCodea is a lua porting for [Codea](http://twolivesleft.com/Codea/) of the [Harmony Procedural Drawing Tool](http://mrdoob.com/projects/harmony/)
written in html5 and developed by mrdoob.

The toolbox interface takes inspiration from the one developed by Grant (grant@enabled.com.au) in his [Brush](http://twolivesleft.com/Codea/Talk/discussion/comment/5649#Comment_5649) 
Codea project

There're two different projects:

- Harmony.codea is the original project that render using codea rendering functions like line, stroke, strokeWidth,
ellipse, ecc. It can be run with two different rendering modes explained later.

-HarmonyMesh.codea is a modified version (on suggestion of [Andrew Stacey](http://www.math.ntnu.no/~stacey/) who has done something similar
starting from Harmony.codea), where lines are remapped on codea mesh drawing, using the MeshCanvas class utility.
The pros are fast draw with the possibility to hide / shows interfaces over the drawing (the actual UI implementation is 
very poor considering the possibilities), while the cons are the loss of brushes like Discs or Circles that rely
on ellipse rendering


Harmony.codea Rendering Modes
-----------------------------

It's possible to run the app in 2 different rendering modes:

- direct on screen rendering with retained backingmode: this is more performant (on iPad2 ~56 fps average) but it's not possible to hide the palette UI
- canvas redirected draw: that mode allows to show/hide interface and would allows to implement load/save functionalities, but is far slower (on iPad2 
is around 24 fps)

Default mode is the first one. To change it uncomment the "useCanvas = true" line at the begin of Main.lua

Missing features
----------------

- It's not possible at now to save the drawings once made

Known Issues
------------

- If "resetBrushStartStroke" is set to 0, after some times a delay will 
be noticed while drawing because of the large number of calcs and draw 
commands that has to be done each frame.

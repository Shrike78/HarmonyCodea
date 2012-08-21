HarmonyCodea
=============

HarmonyCodea is a lua porting for [Codea](http://twolivesleft.com/Codea/) of the [Harmony Procedural Drawing Tool](http://mrdoob.com/projects/harmony/)
written in html5 and developed by [mrdoob](http://mrdoob.com/). 
 
Chrome, fur, longfur, sketchy, shaded and web brushes are all variation of the [neighbour points connection concept](http://www.zefrank.com/scribbler/about.html).

The toolbox interface takes inspiration from the one developed by Grant (grant@enabled.com.au) in his [Brush](http://twolivesleft.com/Codea/Talk/discussion/comment/5649#Comment_5649) 
Codea project

There're two different projects:

- Harmony.codea is the original project that render using codea rendering functions like line, stroke, strokeWidth,
ellipse, ecc. It can be run with two different rendering modes explained later.

- HarmonyMesh.codea is an extended version where lines are drawn using meshes, thanks the MeshCanvas class utility. 
That would allow to create a complete hidable UI and also to add save/restore functionalities.

After some days of work to make the mesh version more suitable, with nice smooth rendering and a fast enough 
circles/discs brushes implementation, the original Harmony.codea version has been abandoned in favor of this more 
flexible version.

The HarmonyMesh.codea development was started by a [discussion](http://twolivesleft.com/Codea/Talk/discussion/1530/harmony.codea-a-procedural-drawing-tool/p1) 
with [Andrew Stacey](http://www.math.ntnu.no/~stacey/) after the release of the original Harmony.codea project.

He has also implemented a very nice smooth line implementation that can be used instead of mine, and has his own 
Harmony Mesh version with a more advanced UI. [Here](http://www.math.ntnu.no/~stacey/code/) is possible to find 
his version of the project.

Missing features
----------------

- It's not possible to load a previously made drawing.

- There's no 'save drawing' function, but it's possible to use the Codea built-in screenshot functionality

Known Issues
------------

- Using brushes that implements the neighbour points connection concept with "resetBrushStartStroke" set to 0 
can lead, after a lot of strokes, to a loss of performances due to the very large number of calcs and draw 
commands that can be required.

- The program allows to use transparent colors (so with alpha < 255). That can be usefull in some situation but
can easily create artefacts on the surface of the lines. Greater the thickness value, greater the problem.

Harmony.codea Rendering Modes
-----------------------------

It's possible to run the old Harmony.codea version in 2 different rendering modes:

- direct on screen rendering with retained backingmode: this is more performant (on iPad2 ~56 fps average) but it's not possible to hide the palette UI

- canvas redirected draw: that mode allows to show/hide interface and would allows to implement load/save functionalities, but is far slower (on iPad2 
is around 24 fps)

Default mode is the first one. To change it uncomment the "useCanvas = true" line at the begin of Main.lua

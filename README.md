HarmonyCodea
=============

HarmonyCodea is a lua porting for [Codea](http://twolivesleft.com/Codea/) of the [Harmony Procedural Drawing Tool](http://mrdoob.com/projects/harmony/)
written in html5 and developed by mrdoob.

The toolbox interface takes inspiration from the one developed by Grant (grant@enabled.com.au) in his [Brush](http://twolivesleft.com/Codea/Talk/discussion/comment/5649#Comment_5649) 
Codea project

Missing features
----------------

- It's not possible at now to save the drawings once made

Known Issues
------------

- If "resetBrushStartStroke" is set to 0, after some times a delay will 
be noticed while drawing because of the large number of calcs and draw 
commands that has to be done each frame.

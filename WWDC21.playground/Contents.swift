/*:
 ![Logo](Images/Playground/QuantumControl-Logo.png width="500")

 ## A puzzle game against the Quantum universe.

 ---

 # Game Elements

 A puzzle contains a variety of different game elements. Here is a short overview over what they do:

 ### Mirror
 ![Mirror](Images/Nodes/Mirror-Both-Sides.png width="100")

 ### Emitter
 ![Emitter](Images/Nodes/Emitter-Body.png width="100")

 ### Transmitter
 ![Transmitter](Images/Nodes/Emitter-Body.png width="100")

 ### Receiver
 ![Receiver](Images/Nodes/Receiver-Body.png width="100")

 ### Wall
 ![Wall](Images/Nodes/Wall.png width="100")

 ---

 # Controls

 There are 2 gestures to navigate a level:

 ### Scaling
 You can pinch the view while holding `option`-key and dragging within the live view, just as you would when using an iOS device.
 This allows you to zoom into and out of the scene to get a better overview of the level.

 ### Translation
 Simply drag the view as you whish while holding dow `shift-option`. The level will translate so you can explore it more easily. Keep in mind that you can only drag if you zoomed in enough.

 */

import PlaygroundSupport

// Let's Play
PlaygroundPage.current.setLiveView(QuantumControlGame())

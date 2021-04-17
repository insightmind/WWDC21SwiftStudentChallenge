/*:
 ![Logo](Images/Playground/QuantumControl-Logo.png width="500")

 ## A puzzle game against the Quantum universe.

 ---

 # Game Elements

 This game contains a variety of different elements. Here is a short overview over what they do:

 ### Emitter
 ![Emitter](Images/PLayground/Emitter.png width="100")

 ### Transmitter
 ![Transmitter](Images/Playground/Transmitter.png width="100")

 ### Receiver
 ![Receiver Enabled](Images/Playground/Receiver-Enabled.png width="100")
 ![Receiver Disabled](Images/Playground/Receiver-Disabled.png width="100")

 ### Wall
 ![Wall](Images/Nodes/Wall.png width="100")

 ### Colored Wall
 ![Colored Wall Enabled](Images/Playground/ColoredWall-Enabled.png width="100")
 ![Colored Wall Disabled](Images/Playground/ColoredWall-Disabled.png width="100")

 Colored walls have two states. The first image shows the state of a wall that is activated. An activated wall will only allow light from the same color to pass through it. All other colors will eb absorbed. The second image shows the state of an inactvie colro wall. Here any light can pass through it. To deactive a wall simply deflect the light to any receiver that accepts the same color.

 ### Mirror
 ![Mirror](Images/Nodes/Mirror-Both-Sides.png width="100")
 Now you come to play. You can rotate a mirror by tapping or clicking it. Rotating a mirror will cause colliding light to be deflected to another direction..

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
let game = QuantumControlGame()
PlaygroundPage.current.setLiveView(game)

/*:
 # Background Music:

 Indigo Heart by Daniel Birch is licensed under a Attribution-NonCommercial 4.0 International License.
 The material has not been altered or remixed. https://freemusicarchive.org/music/Daniel_Birch/indigo/daniel-birch-indigo-heart

 */

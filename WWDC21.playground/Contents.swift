/*:
 ![Logo](Images/Playground/QuantumControl-Logo.png width="500")

 ## A puzzle game against the Quantum universe.

 ---

 # The Game

 Quantum Control is a simple but mind-boggling game. You have to solve each level by deflecting lights from the light source to the light receivers. However light receivers only accept a specific light color, so you have to make sure only the correct light reaches it. You solve a level if at least one receiver of each color receives the correct light.

 __Can you solve all 7 levels?__

 # Game Elements

 This game contains a variety of different elements. Here is a short overview over what they do:

 ### Emitter
 ![Emitter](Images/PLayground/Emitter.png width="100")
 Emitters are the starting points of every level. Emitters emit light into one direction. In the image above the emitter emits light to the top.

 ### Transmitter
 ![Transmitter](Images/Playground/Transmitter.png width="100")
 A transmitter allows you to transform any given light to the light color indicated on the transmitter. In this case the transmitter accepts any light and emits red colored light. Additionally transmitters can deflect  light into another direction. In this example the transmitter receives light from the right and deflects it to the top. A transmitter may also allow receiving light and deflecting light in more than one direction.

 ### Receiver
 ![Receiver Enabled](Images/Playground/Receiver-Enabled.png width="100")
 ![Receiver Disabled](Images/Playground/Receiver-Disabled.png width="100")
 Receivers are the goals for any level. To complete a level you have to activate at least one receiver of each color. To activate a receiver simply deflect the light from the light source to the respective receiver. The receiver will light up, as shown in the first image. The second image shows the receiver in its deactivated state.

 ### Colored Wall
 ![Colored Wall Enabled](Images/Playground/ColoredWall-Enabled.png width="100")
 ![Colored Wall Disabled](Images/Playground/ColoredWall-Disabled.png width="100")

 Colored walls have two states. The first image shows the state of a wall that is activated. An activated wall will only allow light from the same color to pass through it. All other colors will be absorbed by it. The second image shows the state of an inactive color wall. Here any light can pass through it. To deactivate a wall simply deflect the light to at least one receiver that accepts the same color.

 ### Wall
 ![Wall](Images/Nodes/Wall.png width="100")
 A wall blocks all light from passing through it. It will absorb any light that touches it.

 ---

 # Level Controls

 ## Moving elements
 To complete a level you can move some of the elements around. These elements are indicated by a line behind them. By simply dragging the element you can move them along this line.

 ## Moving the view
 There are 2 gestures to navigate with the view:

 ### Scaling
 You can pinch the view while holding `option`-key and dragging within the live view, just as you would when using an iOS device.
 This allows you to zoom into and out of the scene to get a better overview of the level.

 ### Translation
 Simply drag the view as you whish while holding dow `shift-option`. The level will translate so you can explore it more easily. Keep in mind that you can only drag if you zoomed in enough.

 ---

 # Recommended Way to Play:
 - Use headphones to immerse yourself in to the game. You can also always deactive the sound.
 - Make sure the live preview is fully visible.

 ---

 # Notes
 It may take a few seconds to build the playground.
 Make sure to restart the playground manually if it shows a blank screen and that the LivePreview is activated on the right.
 */

import PlaygroundSupport

// Let's Play
let game = QuantumControlGame()
PlaygroundPage.current.setLiveView(game)

/*:
 # Background Music:

 Indigo Heart by Daniel Birch is licensed under a Attribution-NonCommercial 4.0 International License.
 The material has not been modified or remixed. https://freemusicarchive.org/music/Daniel_Birch/indigo/daniel-birch-indigo-heart

 # Assets:
 Some assets such as the WallSprite and the sound of emitters are used from https://kenney.nl and licensed under CC0 1.0 Universal.
 They offer a great set of refined assets and sprites especially for game development.
 */

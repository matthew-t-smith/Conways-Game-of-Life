# Conway's Game of Life

iOS Application in Swift presenting Conway's Game of Life

This project was built cumulatively throughout a semester for my master's program. After each portion of the project was submitted, an updated repo with similar but assured workable logic was provided up through the next-to-last iteration. From there, it was up to each student to finish the final features off. 

The code here is thus technically a combination of mine and the professor, but all the code was expected and written throughout the course by me as well.

## Logic

The game is built on the MVC architecture where the game logic was held in a model. An engine was created to take the instance of the board in controllers and update information to the views as needed. The additional functionality for each part of the app is noted below.

#### Fetcher

The project initially had an available preset configuration JSON object that you could "fetch" and load into a ListView. The link to the data has expired, so I have nulled out this particular feature, but the UI is still available in the `Instrumentation` tab.

#### Grid

Definitions of the `Grid` structure, which includes supplementary position information and `CellState`. This logic allowed the board to know how and what to draw when initialized. An `Engine` class is also defined to relay the information of the Grid instance where needed.

#### GridEditorTableViewController

Since the JSON object was expired, this TableView is not reached via the app anymore. However, it allowed the user to edit a configuration of the game.

#### GridEditorViewController

Here is where the user could save the edited grid.

#### GridView

This is the drawing logic for the grid itself in the game, including what to do with user draw input.

#### Instrumentation-, Simulation- and Statistics- ViewControllers

Each of these housed the logic for the features outlined in the **UI** portion below.

## UI

The app is a simple, three-tabbed layout. The constraints for elements take into account rotation as well as device size.

#### Instrumentation
At one time, the first `Instrumentation` tab would fetch a pre-populated list of configurations for the game, loading them into a ListView that could be selected from. You could also add and remove those from the list, as well as select a configuration to edit and save. Finally, you're able to select a board size for the simulation tab, adjust the auto-refresh rate, and turn the refresh on/off. The link to the data has expired and so I have nulled out this particular feature, but the UI is still available.

#### Simulation
This is the game board that allows user touch input to place living cells. You can step through the board (if refresh is turned off), save or reset. Different colors are used for cells that are alive or dead and also born (this generation) or died (in the previous generation).

#### Statistics
A simple interface to see statistics on the totals of each type of cell since the board was last reset. You are able to reset the statistics here, or if you reset in the `Simulation` tab, the statistics will reset as well.

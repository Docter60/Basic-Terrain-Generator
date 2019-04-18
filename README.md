# Basic-Terrain-Generator
**Procedural generation of 2D terrain.**

## Overview
<p>&nbsp;&nbsp;&nbsp;&nbsp;
I started this project with pulling inspiration from a couple of modern 
games.  Minecraft, with its extremely fine-tuned and robust terrain 
generation in 3-dimensional space, is usually regarded as the project that 
sparked the sandbox indie genre.  Using a program called Amidst, the terrain 
can be seen on a larger scale showing just how amazing this process can be; 
just from one single seed.  The other game is Factorio, a game focusing on 
crafting and supply-demand factory development.  The in-game world generator 
takes a single seed as well, turning a blank slate into a unique world with 
scattered ore deposits, lakes, and forests (not to mention enemies).  Most if 
not all games today feature some amount random number generation, whether it 
be implemented in terrain, item properties, or even the splash screen.  The 
inclusion of such features gives the user a sense that the world is more 
natural and dynamic making the experience personal and enriched.
</p>

<p>&nbsp;&nbsp;&nbsp;&nbsp;
For this project, we’re going to be looking solely at generating tile-based 
terrain and experimenting with trying to make the terrain look a bit more 
like a finished product.  I decided to use GameMaker: Studio 1.4 as my tool 
of choice.  GameMaker will take care of the many back-end tasks so I can 
focus on the concept.  The downside to using GameMaker’s language (GML) is 
that speed and optimization can’t be improved significantly because of how 
strict GML’s data handling rules are.  For the sake of simplicity of the 
project, this is simply a proof of concept project.  Moving further along, 
ideally I would build this in a language like C++ along with SFML.
</p>

<p>&nbsp;&nbsp;&nbsp;&nbsp;
  Terrain generation at the basic level will consist of biome creation and data 
representation.  Biomes will be given a certain distinct color and placement 
will be determined by an algorithm.  The structuring of data will be set up 
so editing of tiles is relatively simple.  This means terrain should also be 
easily loaded and saved from storage.
</p>

---
## Data Structure

  The first problem is building the foundation for all the data that will be
generated.  This data structure has three layers utilizing two custom
'classes'(I say classes, but in GameMaker they're simply ds_grids). Each
layer can be represented on a 2D grid/plane and use a coordinate system.
Each layer 'space'(in the mathematical sense) has similar properties and rules.

	#!gml
	var size = 16;
	ds_grid_create(size, size);


### Tile Space

  The lowest level of the data structure is the tiles.  Each tile is
represented as a 32 pixel by 32 pixel square on the screen at 1x scale/zoom.
A tile has an ID, an integer, which corresponds to a texture in some tile set.

![Tile Set](./screenshots/tile.png)

*Tile Set with nine unique tiles*

### Subregion Space

![Subregion Diagram](./screenshots/subregion.png)

### Region Space

![Region Diagram](./screenshots/region.png)

### Loading and Saving Formats

---
##Terrain/Biome Rules

### Algorithm

### Implementation

---
## Perlin Noise

### Algorithm

### Implementation

![Terrain 1](./screenshots/terrain_1.png){width=100%}

![Terrain 2](./screenshots/terrain_2.png){width=100%}

---
## Fractal Noise

### Algorithm

### Implementation

![Terrain 3](./screenshots/terrain_3.png){width=100%}

![Terrain 4](./screenshots/terrain_4.png){width=100%}

![Terrain 5](./screenshots/terrain_5.png){width=100%}

---
## Conclusion

### Final Product

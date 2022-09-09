# Weighted Activation Maps (WAMs)
This code accompanies the paper Data-driven Tactile Reconstruction in Soft Skins using Electrical Impedance Tomography and Weighted Activation Maps.

This repository contains both the data presented and the code used for WAM, neural network, and backprojection reconstructions. Backprojection makes use of pyEIT, which is included here.

Written using MATLAB 2021b (Deep Learning Toolbox) & Python 3.

The parent repository can be found [here](https://github.com/DSHardman/HydrogelEIT).

## Data Availability
The 15,000 responses and random press locations/depths used in Figures 3 - 8a are stored in _Extracted/RandomSkin15k.mat_. Trained neural networks are stored in _TrainedNetworks/_, with each filename indicating the size of the dataset used for training.

Figure 8b's damage response is stored in _DamageTests/Damage.mat_. The construction data on which these maps are built is stored in _DamageTests/ConstructionData.mat_.

Figure 8c's multi-touch responses are stored in _MultiTouch/_, with A corresponding to the 108 mm probe separation, B the 75 mm separation, and C the 20 mm separation. _MultiTouch/ConstructionData.mat_ stores the construction data on which the maps are built.

## Functions
**superposeMaps.m** implements (and optionally plots) the weighted activation maps, using these to predict a press location. Commented lines are available for damage detection and environmental monitoring. Each channel's own activation map can be calculated and plotted using the **plotMaps.m** script. This script uses data from _lookup192.mat_ to plot the active electrode positions.

**sensorTrain.m** trains a feedforward neural network and provides feedback about its performance by calling the **calculateErrors.m** function.

**calcEIT.m** calls OpenEIT/reconstruction/pyeit/**calcEIT.py** and plots its output, using one of three available reconstruction algorithms. The brightest pixel is taken to be the localization prediction and, if the _position_ argument is provided, this is compared to the known location.


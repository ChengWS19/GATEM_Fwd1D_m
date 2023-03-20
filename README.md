# 1D Electromagnetic Forward Modeling

This repository contains a MATLAB script for performing 1D electromagnetic forward modeling using the Finite Difference Time Domain (FDTD) method. The script calculates the electromagnetic field response for a given subsurface model and a set of transmitter and receiver locations.

## Getting Started

### Prerequisites

- MATLAB (tested with version R2019a)

### Installation

1. Clone the repository or download the ZIP file and extract it to a directory of your choice.
2. Open MATLAB and navigate to the directory containing the script.

## Usage

1. Open the `forward_modeling_1D.m` script in MATLAB.
2. Modify the input parameters in the "Setting Forward Model" and "Setting Source, Current, Sampling Time, and Receiver Points" sections to match your specific subsurface model and survey geometry.
3. Run the script in MATLAB. The script will calculate the electromagnetic field response and output the run time.
4. The output data will be saved to a file, and the specified component(s) will be plotted and saved as a figure.

### Input Parameters

- `cmd.model`: Forward model name.
- `cmd.nlayer`: Number of layers in the model.
- `cmd.res`: Resistivities of the layers (array).
- `cmd.thickness`: Thicknesses of the layers (array).
- `cmd.I0`: Current strength.
- `cmd.t`: Sampling times (array).
- `cmd.nsource`: Number of transmitter locations.
- `cmd.src`: Transmitter coordinates (matrix).
- `cmd.ndipole`: Number of dipoles.
- `cmd.drec`: Receiver point spacing.
- `cmd.rec`: Receiver coordinates (matrix).
- `cmd.nrec`: Number of receiver points.

### Output Data

- `times`: Time values.
- `Bt`: Magnetic field values.
- `Et`: Electric field values.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

- The development of this script was supported by the research team at XYZ University.

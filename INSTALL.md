# Installation Guide

## Prerequisites

To run the MATLAB script for the Knapsack problem, ensure you have the following:

- **MATLAB** (R2021a or later recommended)
- **Global Optimization Toolbox**
- **MATLAB Support Package for Quantum Computing**

## Installation Steps

1. **Install MATLAB**
   - Download MATLAB from [MathWorks](https://www.mathworks.com/).
   - Follow the installation instructions provided by MathWorks.

2. **Check for Required Add-ons**
   - Open MATLAB and check the installed Add-ons
     - You can use the Add-ons manager
     - Or run the command ```matlab.addons.installedAddons``` to list all installed addons as a table 
   - Install the required Toolbox and Support Package if not listed
     - You can use the following commands
     - ```matlab
        matlab.addons.install('Global Optimization Toolbox')
        matlab.addons.install('MATLAB Support Package for Quantum Computing')
        ```
  
3. **Download the Script**
   - Place `knapsack_live_script.mlx` in a working MATLAB directory.

4. **Run the Script**
   - Open MATLAB.
   - Navigate to the script directory.
   - Run:
     ```matlab
     open('knapsack_live_script.mlx');
     ```
   - Click "Run" to execute the script.

## Troubleshooting
- If you encounter missing dependencies, use:
  ```matlab
  matlab.addons.install('Global Optimization Toolbox')
  matlab.addons.install('MATLAB Support Package for Quantum Computing')
  ```
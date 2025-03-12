# Knapsack Problem Solver

## Overview
This MATLAB Live Script provides an implementation of the Knapsack problem, formulated using multiple mathematical representations:
- Standard Knapsack formulation
- Quadratic Unconstrained Binary Optimization (QUBO) form
- Ising Model representation
- Quantum Ansatz circuit and optimization

The script utilizes MATLAB's Support Package for Quantum Computing to create and simulate the Ansatz circuit and MATLAB’s Global Optimization Toolbox to find the optimal parameters of the Ansatz circuit.

## Features
- Defines the knapsack problem with item values and weights
- Implements an objective function with penalty for constraint handling
- Converts the problem into a QUBO form
- Reformulates into the Ising Model for quantum computing applications
- Implements an Ansatz circuit for quantum optimization
- Uses MATLAB’s optimization toolbox for classical and quantum-based solutions

## Dependencies
- MATLAB (R2021a or later recommended)
- Global Optimization Toolbox
- MATLAB Support Package for Quantum Computing

## Usage
1. Open `knapsack_live_script.mlx` in MATLAB.
2. Run the script to define the problem and solve it using QUBO or the QAOA method implemented using the Ansatz circuit.
3. Review the results and visualizations provided in the output.

For setup instructions, see `INSTALL.md`.
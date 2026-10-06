# pk-one-compartment-simulation-r
One-compartment PK model simulation comparing IV Bolus and Oral dosing using mrgsolve and ggplot2 in R.
# One-Compartment PK Model Simulation in R

This project implements an Ordinary Differential Equation (ODE) based **one-compartment pharmacokinetic model** comparing Single IV Bolus and Oral administration routes.

## 🔬 Mathematical Formulation
The rate of change of drug amounts in the absorption (Gut) and central compartments are modeled as:

* **Absorption Compartment:**
  $$\frac{d(\text{GUT})}{dt} = -K_a \cdot \text{GUT}$$
* **Central Compartment:**
  $$\frac{d(\text{CENT})}{dt} = K_a \cdot \text{GUT} - \left(\frac{CL}{V}\right) \cdot \text{CENT}$$

Where:
* $CL = 1.5 \text{ L/h}$ (Clearance)
* $V = 30.0 \text{ L}$ (Volume of Distribution)
* $K_a = 0.8 \text{ h}^{-1}$ (Absorption Rate Constant)

## 🛠️ Tools & Packages
* **R (v4.x)**
* **`mrgsolve`**: C++-based ODE solver for dynamic biological systems
* **`tidyverse` & `ggplot2`**: Data processing and statistical visualization

## 👤 Author
**Michela Pellizzer, M.Sc.**  
Biomedical Engineer | Clinical Data Analysis & Quantitative Modeling  
[LinkedIn Profile](https://www.linkedin.com/in/michela-pellizzer-b1b536234)

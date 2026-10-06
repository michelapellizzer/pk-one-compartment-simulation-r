# ==============================================================================
# Title: One-Compartment Pharmacokinetic Model Simulation
# Author: Michela Pellizzer, M.Sc. Biomedical Engineering
# Description: ODE-based PK simulation comparing IV Bolus and Oral Administration
#              using mrgsolve and ggplot2 in R.
# ==============================================================================

# 1. Load Libraries
library(mrgsolve)
library(tidyverse)

# 2. Define PK Model in C++ Syntax inside mrgsolve
code <- '
$PARAM 
CL = 1.5,   // Clearance (L/h)
V  = 30.0,  // Volume of distribution (L)
KA = 0.8    // Absorption rate constant (1/h)

$CMT 
GUT CENT

$ODE
dxdt_GUT  = -KA * GUT;
dxdt_CENT =  KA * GUT - (CL / V) * CENT;

$TABLE
double CP = CENT / V; // Plasma Concentration (mg/L)

$CAPTURE CP
'

# 3. Compile the Model
mod <- mcode("one_comp_pk", code)

# 4. Define Dosing Events
dose_iv   <- ev(amt = 100, cmt = "CENT") # 100 mg IV direct to Central
dose_oral <- ev(amt = 100, cmt = "GUT")  # 100 mg Oral to Gut

# 5. Run Simulations (24-hour timeframe)
sim_iv   <- mod %>% ev(dose_iv)   %>% mrgsim(end = 24, delta = 0.1) %>% as_tibble() %>% mutate(Route = "IV Bolus")
sim_oral <- mod %>% ev(dose_oral) %>% mrgsim(end = 24, delta = 0.1) %>% as_tibble() %>% mutate(Route = "Oral")

# Combine Dataset
sim_data <- bind_rows(sim_iv, sim_oral)

# 6. Plot Concentration-Time Profiles
pk_plot <- ggplot(sim_data, aes(x = time, y = CP, color = Route)) +
  geom_line(size = 1.2) +
  scale_color_manual(values = c("IV Bolus" = "#1f77b4", "Oral" = "#ff7f0e")) +
  labs(
    title = "One-Compartment Pharmacokinetic Profile",
    subtitle = "Simulation of Plasma Concentration (Dose = 100 mg)",
    x = "Time (hours)",
    y = "Plasma Concentration (mg/L)",
    color = "Administration Route"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold")
  )

# Output Plot
print(pk_plot)

# Save High-Res Image
ggsave("pk_one_compartment_plot.png", plot = pk_plot, width = 8, height = 5, dpi = 300)

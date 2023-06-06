# F1-Race-Simulation
I this project, I wrote a simple Monte Carlo simulation, to simulate the last 20 laps of a the 2022 Hungaroring grand prix to analyse whether Charles Leclerc could have won with a different strategies, assuming a pit stop remained to be made.

The ingredients of the simulation are pretty simple:
- Gaussian distribution of lap times, using Charles Leclerc and Fernando Alonso as an example, with different tyre compounds
- Tyre degradation (I used a parabolic function for the interpolation of degradation)
- Probability of overtaking when the gap fell below 1 second
This algorithm is obviously far removed from complex race situations, where there is the possibility of a safety car, raining, colliding, etc.

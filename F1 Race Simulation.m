% Monte Carlo Simulation for Grand Prix Race
clear all;
clc;

% Set parameters
num_laps = 20;
num_races = 10000;
overtake_prob = 0.8; % Overtaking probability at the circuit

% Gaussian parameters for lap times (mean and std deviation)
lap_time_params = [75, 0.5; % Leclerc
                   76, 0.5]; % Alonso/Ocon

% Tyre degradation parameters (for Soft, Medium, Hard respectively)
tyre_degradation_params = [0.15, 0.1, 0.05];

% Tyre selection for each driver
tyre_selection = [1, 3;  % Leclerc (Soft for first 10 laps, Hard for last 10 laps)
                  3, 3]; % Alonso/Ocon (Hard for all laps)

% Initialize containers for winning probabilities
win_prob_pre_pit = zeros(1, num_races);
win_prob_post_pit = zeros(1, num_races);

% Perform Monte Carlo simulation
for i = 1:num_races
    % Generate random lap times for drivers
    lap_times = lap_time_params(:,1) + lap_time_params(:,2).*randn(2, num_laps);

    % Apply tyre degradation
    for j = 1:num_laps
        tyre_compound = tyre_selection(:,ceil(j/10));
        lap_times(:,j) = lap_times(:,j) + tyre_degradation_params(tyre_compound)' * j^2;
    end

    % Calculate average lap time differences and convert to winning probabilities
    avg_diff_pre_pit = mean(lap_times(1,1:10) - lap_times(2,1:10));
    avg_diff_post_pit = mean(lap_times(1,11:20) - lap_times(2,11:20));

    % Logistic function to convert time differences to winning probabilities
    win_prob_pre_pit(i) = 1 / (1 + exp(-avg_diff_pre_pit));
    win_prob_post_pit(i) = overtake_prob / (1 + exp(-avg_diff_post_pit));
end

% Plot results
figure;
hold on;
histogram(win_prob_pre_pit, 'Normalization', 'pdf', 'FaceColor', 'g');
histogram(win_prob_post_pit, 'Normalization', 'pdf', 'FaceColor', 'r');
legend('Before 2nd pit-stop', 'After 2nd pit-stop');
xlabel('Probability of Winning');
ylabel('Probability Density');
title('Probability Distribution of Winning');
hold off;


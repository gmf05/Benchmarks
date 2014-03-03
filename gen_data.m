%% Problem 1: create lists of strings to compare string operations
clear all;


%% Problem 2: create matrices of various sizes to compare matrix operations
clear all;
N_orders = 10;
N_trials = 30;
trials = cell(N_orders, N_trials);
a = -1000; b = 1000;

for ord = 1:N_orders
  ord
  for i = 1:N_trials
    % uniform [0,1]
    A = rand(ord*100);
    % uniform [a,b]
    A = (b-a)*A + a;    
    trials{ord,i} = A;
  end
end
save rand_matrix

%% Problem 3: create oscillatory signals to compare FFT
clear all;
N_orders = 10;
N_trials = 30;
trials = cell(N_orders, N_trials);

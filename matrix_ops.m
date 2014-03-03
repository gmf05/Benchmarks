start0 = tic();
load ../data/rand_matrix.mat
load_time = toc(start0);
times = zeros(N_orders,N_trials);
op = 'det';

for order = 1:N_orders
  for i = 1:N_trials
    start0 = tic();
    D = det(trials{order,i}); % matrix operation of interest
    times(order,i) = toc(start0);
  end
end

save(['matlab_matrix_result_' op],'times','load_time');
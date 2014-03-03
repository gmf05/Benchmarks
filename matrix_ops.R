library(R.matlab)
start0 = proc.time()
matfile = readMat("../data/rand_matrix.mat") # provided by R.matlab
load_time = proc.time() - start0
load_time = load_time[3] # just want elapsed time

N_orders = matfile$N_orders
N_trials = matfile$N_trials
times = matrix(0,N_orders,N_trials)

for (order in 1:N_orders) {
  for (i in 1:N_trials) {
    start0 = proc.time()
    D = 0
    temp = proc.time() - start0
    times[order,i] = temp[3] # again, just elapsed time
  }
}

# save results
writeMat("R_matrix_result_det.mat",load_time=load_time,times=times)


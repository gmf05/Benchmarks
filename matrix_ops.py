#!/usr/bin/python
import math
import numpy
import numpy.linalg as LA
import time
import scipy.io

def main():
  start0 = time.time();
  matfile = scipy.io.loadmat('../data/rand_matrix.mat');
  load_time = time.time() - start0;

  N_orders = matfile['N_orders'][0][0];
  N_trials = matfile['N_trials'][0][0];
  trials = matfile['trials'];
  times = numpy.zeros([N_orders,N_trials]);

  for order in range(N_orders):
    for i in range(N_trials):
      start0 = time.time();
      D = LA.det(trials[order][i]); # matrix operation of interest
      times[order,i] = time.time() - start0;

  # create dictionary to save results as mat file
  mydict = {'times': times, 'load_time': load_time};
  scipy.io.savemat('python_matrix_result',mydict);

# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
      main()

#!/usr/bin/python
import math
import numpy
# import matplotlib.pyplot as plt

def HHneuron(I0,T0):
  dt = 0.01;
  T = int(math.ceil(T0/dt));
  gNa = 120; ENa = 60;
  gK = 36; EK = -77;
  gL = 0.3; ERest = -54.4;

  t = [dt*i for i in range(T)];
  V = numpy.zeros([T,1]); 
  m = numpy.zeros([T,1]); 
  h = numpy.zeros([T,1]); 
  n = numpy.zeros([T,1]); 

  # initial conditions
  V[0] = -70;
  m[0] = 0.05;
  h[0] = 0.54;
  n[0] = 0.34;

  # integration by Euler's method
  for i in range(T-1):
    V[i+1] = V[i] + dt*(gNa*math.pow(m[i],3)*h[i]*(ENa-V[i]) + gK*math.pow(n[i],4)*(EK-V[i]) + gL*(ERest-V[i]) + I0);
    m[i+1] = m[i] + dt*(alphaM(V[i])*(1-m[i]) - betaM(V[i])*m[i]);
    h[i+1] = h[i] + dt*(alphaH(V[i])*(1-h[i]) - betaH(V[i])*h[i]);
    n[i+1] = n[i] + dt*(alphaN(V[i])*(1-n[i]) - betaN(V[i])*n[i]);

  return V,m,h,n,t

def alphaM(V):
  return (2.5-0.1*(V+65)) / (math.exp(2.5-0.1*(V+65))-1);

def betaM(V):
  return 4*math.exp(-(V+65)/18);

def alphaH(V):
  return 0.07*math.exp(-(V+65)/20);

def betaH(V):
  return 1/(math.exp(3-0.1*(V+65))+1);

def alphaN(V):
  return (0.1-0.01*(V+65))/(math.exp(1-0.1*(V+65))-1);

def betaN(V):
  return 0.125*math.exp(-(V+65)/80);

def main():
  I0 = 10;
  T0 = 100;
  (V,m,h,n,t) = HHneuron(I0,T0);
  print V

# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()

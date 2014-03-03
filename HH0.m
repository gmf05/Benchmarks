%Implement the Hodgkin-Huxley equations.
%NOTE:  Hodgkin and Huxley set the resting voltage of the neuron to 0 mV
%and we've set it here to -65 mV (the value accepted today).

%INPUTS
%    I0 = input current.
%    T0 = total time to simulate (in [ms]).
%
%OUTPUTS
%    V = the voltage of the neuron.
%    m = activation variable for Na-current.
%    h = inactivation variable for Na-current.
%    n = activation variable for K-current.
%    t = the time axis of the simulation (useful for plotting).

function [V,m,h,n,t] = HH0(I0,T0)

  dt = 0.01;
  T  = ceil(T0/dt);
  gNa = 120;  ENa=60;
  gK = 36;  EK=-77;
  gL=0.3;  ERest=-54.4;

  t = (1:T)*dt;
  V = zeros(T,1);
  m = zeros(T,1);
  h = zeros(T,1);
  n = zeros(T,1);
  
  V(1)=-70.0;
  m(1)=0.05;
  h(1)=0.54;
  n(1)=0.34;
  for i=1:T-1 
      V(i+1) = V(i) + dt*(gNa*m(i)^3*h(i)*(ENa-V(i)) + gK*n(i)^4*(EK-V(i)) + gL*(ERest-V(i)) + I0);
      m(i+1) = m(i) + dt*(alphaM(V(i))*(1-m(i)) - betaM(V(i))*m(i));
      h(i+1) = h(i) + dt*(alphaH(V(i))*(1-h(i)) - betaH(V(i))*h(i));
      n(i+1) = n(i) + dt*(alphaN(V(i))*(1-n(i)) - betaN(V(i))*n(i));
  end
  
end

%Below, define the AUXILIARY FUNCTIONS alpha & beta for each gating variable.

function aM = alphaM(V)
aM = (2.5-0.1*(V+65)) ./ (exp(2.5-0.1*(V+65)) -1);
end

function bM = betaM(V)
bM = 4*exp(-(V+65)/18);
end

function aH = alphaH(V)
aH = 0.07*exp(-(V+65)/20);
end

function bH = betaH(V)
bH = 1./(exp(3.0-0.1*(V+65))+1);
end

function aN = alphaN(V)
aN = (0.1-0.01*(V+65)) ./ (exp(1-0.1*(V+65)) -1);
end

function bN = betaN(V)
bN = 0.125*exp(-(V+65)/80);
end

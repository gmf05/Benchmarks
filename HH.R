HH0 <- function(I0,T0) {
  dt = 0.01;
  T = ceiling(T0/dt);
  gNa = 120; ENa = 60;
  gK = 36; EK = -77;
  gL = 0.3; ERest = -54.4;

  t = (1:T)*dt;
  V <- array(0,T)
  m <- array(0,T)
  n <- array(0,T)
  h <- array(0,T)

  V[1] = -70;
  m[1] = 0.05;
  h[1] = 0.54;
  n[1] = 0.34;
  
  for (i in 2:T-1) {
    V[i+1] = V[i] + dt*(gNa*m[i]^3*h[i]*(ENa-V[i]) + gK*n[i]^4*(EK-V[i]) + gL*(ERest-V[i]) + I0);
    m[i+1] = m[i] + dt*(alphaM(V[i])*(1-m[i]) - betaM(V[i])*m[i]);
    h[i+1] = h[i] + dt*(alphaH(V[i])*(1-h[i]) - betaH(V[i])*h[i]);
    n[i+1] = n[i] + dt*(alphaN(V[i])*(1-n[i]) - betaN(V[i])*n[i]);
  }

  out = list(V=V,m=m,h=h,n=n,t=t)
  return(out)
}

# auxillary functions
alphaM <- function(V) {return((2.5-0.1*(V+65))/(exp(2.5-0.1*(V+65))-1))}
betaM <- function(V) {return(4*exp(-(V+65)/18))}
alphaH <- function(V) {return(0.07*exp(-(V+65)/20))}
betaH <- function(V) {return(1./(exp(3.0-0.1*(V+65))+1))}
alphaN <- function(V) {return((0.1-0.01*(V+65))/(exp(1-0.1*(V+65))-1))}
betaN <- function(V) {return(0.125*exp(-(V+65)/80))}

I0 <- 10
T0 <- 100
out <- HH0(I0,T0)

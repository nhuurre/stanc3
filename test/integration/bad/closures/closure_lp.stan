parameters {
  real y;
}
model {
  functions
  real foo_lp(real x) {
      return x + 1;
  }
  y ~ normal(0,1);
}
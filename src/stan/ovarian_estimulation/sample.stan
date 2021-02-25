data {
  int<lower=1> n; //number of patients
  
  real treatment_concentration; // The larger, the more sharply peaked the treatment is
  real average_quality; // The average quality of the estimulated patient
  real quality_concentration; // The larger, the more concentrated patients are around its average quality
  
}

parameters {
}

generated quantities {
  real x[n];
  real t[n];
  real y[n];
  real quality_alpha = ((quality_concentration-2)*average_quality+1)/(1-average_quality);
  for (i in 1:n) {
    x[i] = beta_rng(quality_alpha, quality_concentration);
    real average_treatment = 1-x[i]; // Highest quality patients receive less treatment
    
    real treatment_alpha = ((treatment_concentration-2)*average_treatment+1)/(1-average_treatment);
    // print("alpha",alpha);
    t[i] = beta_rng(treatment_alpha, treatment_concentration);
    y[i] = -1;
    real max_oocytes = 1 + 3*log( 1 + 10000*t[i]);
    while (y[i] < 0) {
      real mu = max_oocytes*x[i];
      //y[i] = normal_rng(mu, 0.3*mu); // Use next line to get integer results
      y[i] = floor(normal_rng(mu, 0.3*mu)); 
      // y[i] = floor(normal_rng(50*(x[i])*(x[i])*t[i], 5));
      //y[i] = normal_rng(50*(x[i])*(x[i])*t[i], 5);
      }
  }
}

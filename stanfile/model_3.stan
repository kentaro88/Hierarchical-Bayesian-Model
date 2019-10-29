data {
    int N;
    int N_age;
    int HR[N];
    int AB[N];
    int age[N];
}

parameters {
    real beta;
    real<lower=0> s_age;
    vector[N_age] r_age;
}

transformed parameters {
    vector[N] p;

    for (i in 1:N)
        p[i] = inv_logit(beta + r_age[age[i]]);
}

model {
    r_age[1] ~ normal(-sum(r_age[2:N_age]), 0.001);
    r_age[2:N_age] ~ normal(r_age[1:(N_age-1)], s_age);
    HR ~ binomial(AB, p);
}

generated quantities {
    real p_age[N_age];
    for (i in 1:N_age)
        p_age[i] = inv_logit(beta + r_age[i]);
}


functions {
    real foo_lpdf(real y1, real y2, vector vy1, vector vy2, matrix my1, matrix my2, real[] ay1) {
        real r;
        r += beta_lupdf(y1| y2, y2);
        r += beta_proportion_lupdf(y1| y2, y2);
        r += cauchy_lupdf(y1| y2, y2);
        r += chi_square_lupdf(y1| y2);
        r += dirichlet_lupdf(vy1| vy2);
        r += double_exponential_lupdf(y1| y2, y2);
        r += exp_mod_normal_lupdf(y1| y2, y2, y2);
        r += exponential_lupdf(y1| y2);
        r += frechet_lupdf(y1| y2, y2);
        r += gamma_lupdf(y1| y2, y2);
        r += gaussian_dlm_obs_lupdf(my1| my2, my2, vy2, my2, vy2, my2);
        r += gumbel_lupdf(y1| y2, y2);
        r += inv_chi_square_lupdf(y1| y2);
        r += inv_gamma_lupdf(y1| y2, y2);
        r += inv_wishart_lupdf(my1| y2, my2);
        r += lkj_corr_cholesky_lupdf(my1| y2);
        r += lkj_corr_lupdf(my1| y2);
        r += logistic_lupdf(y1| y2, y2);
        r += lognormal_lupdf(y1| y2, y2);
        r += multi_gp_cholesky_lupdf(my1| my2, vy2);
        r += multi_gp_lupdf(my1| my2, vy2);
        r += multi_normal_cholesky_lupdf(vy1| vy2, my2);
        r += multi_normal_lupdf(vy1| vy2, my2);
        r += multi_normal_prec_lupdf(vy1| vy2, my2);
        r += multi_student_t_lupdf(vy1| y2, vy2, my2);
        r += normal_id_glm_lupdf(y1| my2, y2, vy2, vy2);
        r += normal_lupdf(y1| y2, y2);
        r += normal_lupdf(ay1| y2, y2);
        r += pareto_lupdf(y1| y2, y2);
        r += pareto_type_2_lupdf(y1| y2, y2, y2);
        r += rayleigh_lupdf(y1| y2);
        r += scaled_inv_chi_square_lupdf(y1| y2, y2);
        r += skew_normal_lupdf(y1| y2, y2, y2);
        r += std_normal_lupdf(y1|);
        r += student_t_lupdf(y1| y2, y2, y2);
        r += uniform_lupdf(y1| y2, y2);
        r += von_mises_lupdf(y1| y2, y2);
        r += weibull_lupdf(y1| y2, y2);
        r += wiener_lupdf(y1| y2, y2, y2, y2);
        r += wishart_lupdf(my1| y2, my2);
        return r;
    }
    void goo_lp(real y1, real y2, vector vy1, vector vy2, matrix my1, matrix my2, real[] ay1) {
        target += beta_lupdf(y1| y2, y2);
        target += beta_proportion_lupdf(y1| y2, y2);
        target += cauchy_lupdf(y1| y2, y2);
        target += chi_square_lupdf(y1| y2);
        target += dirichlet_lupdf(vy1| vy2);
        target += double_exponential_lupdf(y1| y2, y2);
        target += exp_mod_normal_lupdf(y1| y2, y2, y2);
        target += exponential_lupdf(y1| y2);
        target += frechet_lupdf(y1| y2, y2);
        target += gamma_lupdf(y1| y2, y2);
        target += gaussian_dlm_obs_lupdf(my1| my2, my2, vy2, my2, vy2, my2);
        target += gumbel_lupdf(y1| y2, y2);
        target += inv_chi_square_lupdf(y1| y2);
        target += inv_gamma_lupdf(y1| y2, y2);
        target += inv_wishart_lupdf(my1| y2, my2);
        target += lkj_corr_cholesky_lupdf(my1| y2);
        target += lkj_corr_lupdf(my1| y2);
        target += logistic_lupdf(y1| y2, y2);
        target += lognormal_lupdf(y1| y2, y2);
        target += multi_gp_cholesky_lupdf(my1| my2, vy2);
        target += multi_gp_lupdf(my1| my2, vy2);
        target += multi_normal_cholesky_lupdf(vy1| vy2, my2);
        target += multi_normal_lupdf(vy1| vy2, my2);
        target += multi_normal_prec_lupdf(vy1| vy2, my2);
        target += multi_student_t_lupdf(vy1| y2, vy2, my2);
        target += normal_id_glm_lupdf(y1| my2, y2, vy2, vy2);
        target += normal_lupdf(y1| y2, y2);
        target += normal_lupdf(ay1| y2, y2);
        target += pareto_lupdf(y1| y2, y2);
        target += pareto_type_2_lupdf(y1| y2, y2, y2);
        target += rayleigh_lupdf(y1| y2);
        target += scaled_inv_chi_square_lupdf(y1| y2, y2);
        target += skew_normal_lupdf(y1| y2, y2, y2);
        target += std_normal_lupdf(y1|);
        target += student_t_lupdf(y1| y2, y2, y2);
        target += uniform_lupdf(y1| y2, y2);
        target += von_mises_lupdf(y1| y2, y2);
        target += weibull_lupdf(y1| y2, y2);
        target += wiener_lupdf(y1| y2, y2, y2, y2);
        target += wishart_lupdf(my1| y2, my2);
    }
}
parameters {
    real y1;
    real y2;
    real ay1[5];
    vector[5] vy1;
    vector[5] vy2;
    matrix[5, 5] my1;
    matrix[5, 5] my2;
}
model {
    real r;
    r += beta_lupdf(y1| y2, y2);
    r += beta_proportion_lupdf(y1| y2, y2);
    r += cauchy_lupdf(y1| y2, y2);
    r += chi_square_lupdf(y1| y2);
    r += dirichlet_lupdf(vy1| vy2);
    r += double_exponential_lupdf(y1| y2, y2);
    r += exp_mod_normal_lupdf(y1| y2, y2, y2);
    r += exponential_lupdf(y1| y2);
    r += frechet_lupdf(y1| y2, y2);
    r += gamma_lupdf(y1| y2, y2);
    r += gaussian_dlm_obs_lupdf(my1| my2, my2, vy2, my2, vy2, my2);
    r += gumbel_lupdf(y1| y2, y2);
    r += inv_chi_square_lupdf(y1| y2);
    r += inv_gamma_lupdf(y1| y2, y2);
    r += inv_wishart_lupdf(my1| y2, my2);
    r += lkj_corr_cholesky_lupdf(my1| y2);
    r += lkj_corr_lupdf(my1| y2);
    r += logistic_lupdf(y1| y2, y2);
    r += lognormal_lupdf(y1| y2, y2);
    r += multi_gp_cholesky_lupdf(my1| my2, vy2);
    r += multi_gp_lupdf(my1| my2, vy2);
    r += multi_normal_cholesky_lupdf(vy1| vy2, my2);
    r += multi_normal_lupdf(vy1| vy2, my2);
    r += multi_normal_prec_lupdf(vy1| vy2, my2);
    r += multi_student_t_lupdf(vy1| y2, vy2, my2);
    r += normal_id_glm_lupdf(y1| my2, y2, vy2, vy2);
    r += normal_lupdf(y1| y2, y2);
    r += normal_lupdf(ay1| y2, y2);
    r += pareto_lupdf(y1| y2, y2);
    r += pareto_type_2_lupdf(y1| y2, y2, y2);
    r += rayleigh_lupdf(y1| y2);
    r += scaled_inv_chi_square_lupdf(y1| y2, y2);
    r += skew_normal_lupdf(y1| y2, y2, y2);
    r += std_normal_lupdf(y1|);
    r += student_t_lupdf(y1| y2, y2, y2);
    r += uniform_lupdf(y1| y2, y2);
    r += von_mises_lupdf(y1| y2, y2);
    r += weibull_lupdf(y1| y2, y2);
    r += wiener_lupdf(y1| y2, y2, y2, y2);
    r += wishart_lupdf(my1| y2, my2);
    r += foo_lupdf(y1| y2, vy1, vy2, my1, my2, ay1);
    goo_lp(y1, y2, vy1, vy2, my1, my2, ay1);
}
function [h, q] = get_perf_curve(omega)

   q_provided = [1760,
                 2200,
                 2640,
                 3080,
                 3520,
                 3960,
                 4400,
                 4840];  % cfm

   rpm_05 = [2119,
             2562,
             3016,
             3477,
             3943,
             4411,
             4882,
             5354];

   rpm_1 = [2301,
            2715,
            3147,
            3592,
            4044,
            4502,
            4964,
            5430];

   rpm_2 = [2615,
            2994,
            3394,
            3809,
            4239,
            4678,
            5125,
            5577];

   rpm_3 = [2880,
            3240,
            3619,
            4015,
            4425,
            4847,
            5279,
            5719];

   rpm_4 = [3112,
            3461,
            3826,
            4207,
            4603,
            5011,
            5430,
            5858];

   rpm_5 = [3323,
            3660,
            4017,
            4387,
            4771,
            5169,
            5576,
            5994];

   rpm_6 = [3514,
            3845,
            4194,
            4556,
            4931,
            5320,
            5719,
            6127];

   rpm_7 = [3700,
            4021,
            4360,
            4717,
            5084,
            5464,
            5856,
            6257];

   rpm_8 = [3891,
            4183,
            4517,
            4869,
            5231,
            5604,
            5989,
            6384];

   sp = [0.5, 1, 2, 3, 4, 5, 6, 7, 8]'; % in H2O
   rpm_vects = [rpm_05, rpm_1, rpm_2, rpm_3, rpm_4, rpm_5, rpm_6, rpm_7, rpm_8]';
   q = zeros(length(sp), 1);


   conversion_omega = 0.01667;  % rps / rpm
   conversion_q = 0.000472;  % m^3/s / cfm
   conversion_A = 0.0929;  % m^3 / ft^3
   conversion_rho = 16.018;  % kg/m^3 / lbm/ft^3
   conversion_sp = 0.00024836;  % Pa / in H2O
   g_metric = 9.81;  % m / s^2
   in_per_m = 39.37;  % in / m
   K_L = 0.2;

   for i = 1:length(sp)
      cur_rpm_vect = rpm_vects(i, :)';
      [min_value, closest_index] = min(abs(omega - cur_rpm_vect));
      closest_omega = cur_rpm_vect(closest_index);

      % Get closest Q
      closest_q_cfm = q_provided(closest_index);  % cfm

      % Use affinity laws to get Q at actual omega
      new_q = (omega / closest_omega) * closest_q_cfm;  % cfm
      q(i) = new_q;

      % Get closest actual head rise
      A_fan_ft2 = 8.90;  % ft^2
      A_fan_metric = A_fan_ft2 * conversion_A;  % m^2
      closest_q_metric = closest_q_cfm * conversion_q;  % m^3 / s
      vbar_fan_metric = closest_q_metric / A_fan_metric;  % m / s
      rho_air_std = 0.075;  % lbm / ft^3
      rho_H2O_std = 62.4;  % lbm / ft^3
      rho_air_metric = rho_air_std * conversion_rho;  % kg / m^3
      sp_inH2O = sp[closest_index];  % in H2O
      sp_metric = sp_inH2O * conversion_sp;  % Pa
      h_a_m_air = sp_Pa / (rho_air_metric * g_metric) + (1 + K_L) * ( (vbar_fan_metric)^2 / (2 * g_metric) );  % m air
      h_a_in_air = h_a_m_air * in_per_m;  % in air
      closest_h_a_in_H2O = h_a_in_air * (rho_air_std / rho_H2O_std);



   end

end

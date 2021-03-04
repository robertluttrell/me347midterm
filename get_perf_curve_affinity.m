function [h, q] = get_perf_curve(omega)

   q_provided = [1760,
                 2200,
                 2640,
                 3080,
                 3520,
                 3960,
                 4400,
                 4840];

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

   sp = [0.5, 1, 2, 3, 4, 5, 6, 7, 8]';
   rpm_vects = [rpm_05, rpm_1, rpm_2, rpm_3, rpm_4, rpm_5, rpm_6, rpm_7, rpm_8]';
   q = zeros(length(sp), 1);


   conversion_sp = 0.24836;  % kPa / in
   conversion_omega = 0.01667;  % rps / rpm
   conversion_q = 0.000472;  % m^3/s / cfm

   for i = 1:length(sp)
      cur_rpm_vect = rpm_vects(i, :)';
      [min_value, closest_index] = min(abs(omega - cur_rpm_vect));
      closest_omega = cur_rpm_vect(closest_index);
      closest_q = q_provided(closest_index);

      new_q = (omega / closest_omega) * closest_q;
      q(i) = new_q;
   end

end

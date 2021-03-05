function [h, q] = get_perf_curve(omega)

   q_provided = [8900,
                 13350,
                 17800,
                 22250,
                 26700,
                 31150,
                 35600,
                 40050,
                 44500,
                 48950,
                 53400];  % updated
                 

   rpm_05 = [371,
             484,
             606,
             733,
             863,
             995,
             1128,
             1262,
             1396,
             1531,
             1667];  % updated

   rpm_1 = [449,
            543,
            655,
            775,
            900,
            1027,
            1157,
            1288,
            1420,
            1553,
            1687];  % updated


   rpm_2 = [NaN,
            649,
            743,
            851,
            967,
            1088,
            1212,
            1338,
            1466,
            1595,
            1726];  % updated

   rpm_3 = [NaN,
            747,
            823,
            920,
            1029,
            1143,
            1263,
            1385,
            1509,
            1636,
            1763];  % updated



   rpm_4 = [NaN,
            NaN,
            898,
            986,
            1087,
            1196,
            1310,
            1429,
            1551,
            1674,
            1800];  % updated

   rpm_5 = [NaN,
            NaN,
            972,
            1048,
            1142,
            1246,
            1356,
            1472,
            1590,
            1712,
            1835];  % updated

   rpm_6 = [NaN,
            NaN,
            1044,
            1108,
            1195,
            1294,
            1401,
            1513,
            1629,
            1748,
            1869];  % updated

   rpm_7 = [NaN,
            NaN,
            NaN,
            1167,
            1247,
            1341,
            1444,
            1553,
            1666,
            1783,
            1902];  % updated

   rpm_8 = [NaN,
            NaN,
            NaN,
            1226,
            1297,
            1387,
            1486,
            1592,
            1702,
            1817,
            1934];  % updated

   sp = [0.5, 1, 2, 3, 4, 5, 6, 7, 8]'; % in H2O
   rpm_vects = [rpm_05, rpm_1, rpm_2, rpm_3, rpm_4, rpm_5, rpm_6, rpm_7, rpm_8]';
   q = zeros(length(sp), 1);
   h = zeros(length(sp), 1);


   conversion_omega = 0.01667;  % rps / rpm
   conversion_q = 0.000472;  % m^3/s / cfm
   conversion_A = 0.0929;  % m^3 / ft^3
   conversion_rho = 16.018;  % kg/m^3 / lbm/ft^3
   conversion_sp = 248.36;  % Pa / in H2O
   g_metric = 9.81;  % m / s^2
   in_per_m = 39.37;  % in / m
   K_L = 0.2;

   for i = 1:length(sp)
      cur_rpm_vect = rpm_vects(i, :)';
      [min_value, closest_index] = min(abs(omega - cur_rpm_vect));
      closest_omega = cur_rpm_vect(closest_index);

      % Get closest Q
      closest_q_cfm = q_provided(closest_index);  % cfm
      closest_q_metric = closest_q_cfm * conversion_q;  % m^3 / s

      % Use affinity laws to get Q at actual omega
      new_q = (omega / closest_omega) * closest_q_cfm;  % cfm
      q(i) = new_q;

      % Get closest actual head rise
      A_fan_ft2 = 8.90;  % ft^2
      A_fan_metric = A_fan_ft2 * conversion_A;  % m^2
      vbar_fan_metric = closest_q_metric / A_fan_metric;  % m / s
      rho_air_std = 0.075;  % lbm / ft^3
      rho_H2O_std = 62.4;  % lbm / ft^3
      rho_air_metric = rho_air_std * conversion_rho;  % kg / m^3
      sp_inH2O = sp(i);  % in H2O
      sp_metric = sp_inH2O * conversion_sp;  % Pa
      h_a_m_air = sp_metric / (rho_air_metric * g_metric) + (1 + K_L) * ( (vbar_fan_metric)^2 / (2 * g_metric) );  % m air
      h_a_in_air = h_a_m_air * in_per_m;  % in air
      closest_h_a_in_H2O = h_a_in_air * (rho_air_std / rho_H2O_std);

      % Use affinity laws to get H at actual omega
      new_h_a = (omega / closest_omega) ^ 2 * closest_h_a_in_H2O;  % in H2O
      h(i) = new_h_a;  % in H2O

   end

end

figure();

omega_arr = [linspace(230, 1600, 10)];
[h, q] = get_perf_curve_affinity(1200);

hold on;

for idx = 1:length(omega_arr)
   omega = omega_arr(idx);
   [h, q] = get_perf_curve_affinity(omega);
   plot(q, h, "LineWidth", 2);
end

q_sys = linspace(0, 60000, 100);
h_sys = 1*10^(-9) * q_sys .^ 2 + q_sys * .0001;
plot(q_sys, h_sys);
plot(h_sys, q_sys);

hold off;

legendCell = cellstr(num2str(omega_arr', 'omega=%-d'));
legend(legendCell, "Location", "Northwest");
xlabel("Q [cfm]");
ylabel("H [in]");
xlim([0, 60000]);
ylim([0, 10]);

saveas(gcf, "fan_curves.png");

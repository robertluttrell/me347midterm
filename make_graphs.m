figure();

omega_arr = [linspace(230, 1600, 5)];
[h, q] = get_perf_curve_affinity(1200);

hold on;

for idx = 1:length(omega_arr)
   omega = omega_arr(idx);
   [h, q] = get_perf_curve_affinity(omega);
   plot(q, h, "LineWidth", 2);
end

hold off;

legendCell = cellstr(num2str(omega_arr', 'omega=%-d'));
legend(legendCell, "Location", "Northwest");
xlabel("Q [cfm]");
ylabel("H [in]");

saveas(gcf, "fan_curves.png");

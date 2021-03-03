figure();
hold on;

omega_arr = [3000:1000:6000];

for idx = 1:length(omega_arr)
   omega = omega_arr(idx);
   [h, q] = get_perf_curve(omega);
   plot(q, h, "LineWidth", 2);
end

xlim([0, 5500]);
ylim([0, 10]);

legendCell = cellstr(num2str(omega_arr', 'omega=%-d'));
legend(legendCell, "Location", "Northwest");
xlabel("Q [cfm]");
ylabel("H [in]");

% legend("3000 rpm", "4000 rpm", "5000 rpm", "6000 rpm");

saveas(gcf, "fan_curves.png");

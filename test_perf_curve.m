figure();
hold on;

omega_arr = [1200];

for idx = 1:length(omega_arr)
   omega = omega_arr(idx);
   [h, q] = get_perf_curve_affinity(omega);
   display(h);
   display(q);
   plot(q, h, "LineWidth", 2);
end

hold off;

xlim([0, 5500]);
ylim([0, 10]);

legendCell = cellstr(num2str(omega_arr', 'omega=%-d'));
legend(legendCell, "Location", "Northwest");
xlabel("Q [cfm]");
ylabel("H [in]");

% legend("3000 rpm", "4000 rpm", "5000 rpm", "6000 rpm");

input("asdf");
saveas(gcf, "fan_curves.png");

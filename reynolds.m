function [Re] = reynolds(v)
   % Re = v * D / nu
   % v in ft / s
   D = 2;  % ft
   nu = 1.632 * 10^(-4);
   
   Re = v * D / nu;
end

function [f] = friction(v, epsilon, D)
   Re = reynolds(v);
   if Re < 2300
      f = 64 / Re;
   else
      f = colebrook(Re, epsilon, D);
   end
end

function [f] = friction(Re, epsilon, D)
   if Re < 2300
      f = 64 / Re;
   else
      f = colebrook(Re, epsilon, D);
   end
end

function [f] = colebrook(Re, epsilon, D)
   tol = 0.001;
   f0 = 0.08;
   delta = 100;
   
   f = f0
   while delta > 0
      lhs = 1 / sqrt(f);
      rhs = -2 * log10((epsilon / (3.7 * D)) + 2.51 / (Re * sqrt(f)));
      f = f - tol;
      delta = rhs - lhs;
   end

end

function [f] = colebrook(Re, epsilon, D)
   tol = 0.0001;
   f0 = 0.08;
   delta = 100;
   
   f = f0;
   while delta > 0
      f = f - tol;
      lhs = 1 / sqrt(f);
      rhs = -2 * log10((epsilon / (3.7 * D)) + 2.51 / (Re * sqrt(f)));
      delta = rhs - lhs;
   end

end

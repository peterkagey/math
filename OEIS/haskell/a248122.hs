import Data.Ratio
a 0 = 0; a 1 = 0;
a n = 3 * a(n - 1) + 3^ceiling(n % 2) - a(ceiling(n % 2))

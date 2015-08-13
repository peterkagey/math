import Data.Ratio
a 0 = 0; a 1 = 0;
a n = 4 * a(n - 1) + 4^ceiling(n % 2) - a(ceiling(n % 2))

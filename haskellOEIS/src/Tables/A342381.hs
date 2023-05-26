module Tables.A342381 (a342381, a342381T) where
import Helpers.Table (triangleByRows)
import Helpers.Factorials (binomial)
import HelperSequences.A000354 (a000354)

-- Number of derangements of Z_2 \wr S_n with m fixed points.
a342381T n k = binomial n k * a000354 (n - k)

a342381 = uncurry a342381T . triangleByRows

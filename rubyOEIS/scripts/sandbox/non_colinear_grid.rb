# Find notes at
# Sloanes/lib/notes/Noncollinear_grid.html

# Given (6, 5) and (4, 4) find all points on the same line such that
# the sum of the coordinants is less than 5 + 5.
# (2, 3), (0, 2) -- (-2, 1) does not work because the first coordinate is less than 1.

# A cool way to implement this (in Haskell) would be for every grid point to
# start with a list of all numbers. Then when a line is formed, *all* resulting
# values would be crossed off from the lists of all gridpoints on that line.


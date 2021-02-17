# e.g. [1,2,3,4,5,6] ->
# [
#   [6,5],
#   [6,4,2]
# ]
def all_subsequences(seq)
  list = []
  (2..Float::INFINITY).each do |i|
    list << subsequence(seq, i) rescue break
  end
  list
end

def subsequence(seq, subsequence_length)
  throw "sequence length must be greater than one" unless subsequence_length > 1
  subseq = seq
    .reverse
    .each_slice(subsequence_length - 1)
    .take(subsequence_length)
    .map(&:first)
    .reverse
  throw "subsequence_length is too great" unless subseq.length == subsequence_length
  subseq
end

def is_valid_extension?(known_seq, candidate)
  all_subsequences(known_seq + [candidate])
    # .all? { |s| s.uniq.length == s.length } # (?) Why doesn't this work?
    # .all? { |s| s.uniq.length > 1 }
    # .all? { |s| s.reverse != s }
end

known_seq = []
10.times do |_|
  known_seq << (1..Float::INFINITY).find { |i| is_valid_extension?(known_seq, i) }
end
known_seq

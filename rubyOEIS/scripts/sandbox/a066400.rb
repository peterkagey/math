require '/Users/pkagey/personal/math/Sloanes/lib/scripts/helpers/is_square.rb'
require 'prime'
class A066400Calculator

  A006255_SEQ = File
    .read("/Users/pkagey/personal/math/Sloanes/lib/b-files/b006255.txt")
    .split("\n")[1..-1]
    .map { |s| s.split.map(&:to_i)[1] }

  def a006255(n)
    raise "Outside of domain for A006255" unless (1..10000).include?(n)
    A006255_SEQ[n - 1]
  end

  def a066400(n); a066400_sequences(n).first.length end

  def a066400_sequences(n)
    candidates = (n + 1...a006255(n)).to_a
    candidates = candidates.reject { |i| Prime.prime?(i) || i.is_square? } if n > 3

    if candidates == []
      p [[n]]
      return [[n]]
    end

    (0..candidates.length).each do |i|
      matches = candidates
        .combination(i)
        .map { |ary| [n] + ary + [a006255(n)] }
        .select { |ary| ary.reduce(1, :*).is_square? }

      if !matches.empty?
        p matches
        return matches
      end
    end
  end

end

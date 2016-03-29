require_relative 'a000005'
class OEIS

  def self.a007955(n)
    (n**(a000005(n)/2.0)).round
  end
end

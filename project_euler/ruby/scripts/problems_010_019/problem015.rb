require_relative '../../helpers/factorial'

class ProjectEuler

  def self.n_choose_k(n,k)
    factorial(n)/factorial(k)/factorial(n-k)
  end

  def self.problem015
    n_choose_k(40,20)
  end

end

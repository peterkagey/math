class BFile

  def initialize(id_number)
    @id_number = "#{id_number}".rjust(6, '0')
  end

  def to_hash
    pairs = rows.map { |str| str.split.map(&:to_i) }
    Hash[pairs]
  end

  def to_ary
    rows.map { |str| str.split.last.to_i }
  end

  private

  def raw_file
    return @raw_file if @raw_file
    b_file = File.dirname(__FILE__) + "/../../../b-files/b#{@id_number}.txt"
    @raw_file = File.read(b_file)
  end

  def rows
    @rows ||= raw_file.split("\n")
  end

end

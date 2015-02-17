def b_file_hash(id_number)
  id_number = "#{id_number}".rjust(6, '0')
  b_file = File.dirname(File.dirname(__FILE__)) + "/b-files/b#{id_number}.txt"
  b_file = File.read(b_file)
  b_file = b_file.split("\n")
  b_file.map! { |str| str.split(' ').map(&:to_i) }
  Hash[b_file]
end

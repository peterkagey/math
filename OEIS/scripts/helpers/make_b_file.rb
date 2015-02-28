project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/*.rb').each do |file|
  require file unless file =~ /#{__FILE__}/
end


Dir.glob(project_root + '/*.rb').each do |file|
  p sequence = file[-10...-3]
  next unless sequence =~ /a[0-9]{6}/
  start = 1
  ending = 10

  (start..ending).each do |n|
    a_n = eval("OEIS.#{sequence}(n)")
    puts "#{n} #{a_n}"
  end
end

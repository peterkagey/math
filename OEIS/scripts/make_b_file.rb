project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/*.rb').each { |file| require file }

# start = 1
# ending = 10

# (start..ending).each { |n| puts "#{n} #{OEIS.a000188(n)}"}
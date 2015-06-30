require_relative "download_hash"

project_root = File.dirname(__FILE__)
Dir.glob(project_root + '/../*.rb').each do |file|
  next unless name = file[/a\d{6}/]
  file_name = project_root + "/../../specs/#{name}_spec.rb"
  next if File.exist?(file_name)
  hash = text_to_hash(name[1..-1])
  min = hash.keys.min
  r = (min..min+4).to_a

  str = %(require_relative '../scripts/#{name}'

describe OEIS do

  def a(n)
    OEIS.#{name}(n)
  end

  it "should know first five values" do
    expect(a(#{r[0]})).to eq #{hash[r[0]]}
    expect(a(#{r[1]})).to eq #{hash[r[1]]}
    expect(a(#{r[2]})).to eq #{hash[r[2]]}
    expect(a(#{r[3]})).to eq #{hash[r[3]]}
    expect(a(#{r[4]})).to eq #{hash[r[4]]}
  end

end
)

  File.write(file_name, str)
end



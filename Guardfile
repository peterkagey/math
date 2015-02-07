guard :rspec do
  watch(%r{^OEIS/specs/(.+)_spec\.rb$}) do |m|
    p "OEIS/specs/#{m[1]}_spec.rb"
    "OEIS/specs/#{m[1]}_spec.rb"
  end

  watch(%r{^OEIS/scripts/(.+)\.rb$}) do |m|
    p "OEIS/specs/#{m[1]}_spec.rb"
    "OEIS/specs/#{m[1]}_spec.rb"
  end
  watch('spec/spec_helper.rb')  { "spec" }
end
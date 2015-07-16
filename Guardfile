SETTINGS = {
  cmd: 'bundle exec rspec',
  notification: false,
  spec_paths: ['OEIS/ruby/specs']
}

guard :rspec, SETTINGS do
  watch(%r{^OEIS/ruby/specs/(.+)_spec\.rb$}) { |m| "OEIS/ruby/specs/#{m[1]}_spec.rb" }
  watch(%r{^OEIS/ruby/scripts/(.+)\.rb$}) { |m| "OEIS/ruby/specs/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

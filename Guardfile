SETTINGS = {
  cmd: 'bundle exec rspec',
  notification: false,
  spec_paths: ['OEIS/specs']
}

guard :rspec, SETTINGS do
  watch(%r{^OEIS/specs/(.+)_spec\.rb$}) { |m| "OEIS/specs/#{m[1]}_spec.rb" }
  watch(%r{^OEIS/scripts/(.+)\.rb$}) { |m| "OEIS/specs/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

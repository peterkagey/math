SETTINGS = {
  cmd: 'bundle exec rspec',
  notification: false,
  spec_paths: ['OEIS/ruby/specs', 'OEIS/ruby/tools/tool_specs', 'OEIS']
}

guard :rspec, SETTINGS do
  # Scripts
  watch(%r{^OEIS/ruby/specs/(.+)_spec\.rb$}) do |m|
    "OEIS/ruby/specs/#{m[1]}_spec.rb"
  end

  watch(%r{^OEIS/ruby/scripts/(.+)\.rb$}) do |m|
    "OEIS/ruby/specs/#{m[1]}_spec.rb"
  end


  # Tooling
  watch(%r{^OEIS/ruby/tools/(.+)\.rb$}) do |m|
    "OEIS/ruby/tools/tool_specs/#{m[1]}_spec.rb"
  end

  watch(%r{^OEIS.+/tool_specs/(.+)_spec\.rb$}) do |m|
    "OEIS/ruby/tools/tool_specs/#{m[1]}_spec.rb"
  end

  # Sandbox
  watch("OEIS/sandbox.rb") do |m|
    "OEIS/sandbox_spec.rb"
  end

end

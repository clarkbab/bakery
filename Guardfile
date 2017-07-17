# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  # Watch for any changes to spec files and run them again.
  watch(%r{^spec/.+_spec\.rb$})

  # Watch for changes to library files and run associated spec.
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }

  # Watch for changes to the spec config and run all specs.
  watch('spec/config') { 'spec' }
  watch('spec/factories') { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
end

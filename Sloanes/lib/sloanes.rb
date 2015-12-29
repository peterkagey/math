ROOT = File.expand_path File.dirname(__FILE__)
Dir["#{ROOT}/scripts/**/*.rb"].each { |f| require f }

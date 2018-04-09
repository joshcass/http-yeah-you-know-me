# load application files
Dir[File.join(__dir__, '..', 'application', '**', '*.rb')].sort.each { |f| require f }
require 'json'

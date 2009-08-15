$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rack/probe'
require 'rack/test'
require 'spec'
require 'spec/autorun'

# Be sure to run tests with sudo/as root, as it makes use of Dtrace
# consumers.

Spec::Runner.configure do |config|
  
end

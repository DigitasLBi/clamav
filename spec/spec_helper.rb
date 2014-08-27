require 'chefspec'
require 'timecop'

ChefSpec::Coverage.start!

RSpec.configure do |config|
  # Specify the path for Chef Solo to find cookbooks
  config.cookbook_path = [ 'site-cookbooks', 'cookbooks' ]

  # Specify the path for Chef Solo to find roles
  config.role_path = 'roles'

  # Specify the Chef log_level (default: :warn)
  config.log_level = :warn

  # Specify the path to a local JSON file with Ohai data
  #config.path = 'ohai.json'

  # Specify the operating platform to mock Ohai data from
  config.platform = 'centos'

  # Specify the operating version to mock Ohai data from
  #config.version = '6.5'

   # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end


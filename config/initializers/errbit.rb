Airbrake.configure do |config|
  config.api_key = 'd373d76149ba7e96e162266eed35b08e'
  config.host    = 'errbit.genesys-solutions.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end

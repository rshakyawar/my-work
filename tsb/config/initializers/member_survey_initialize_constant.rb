require 'erb'
require 'hashie'
APPLICATION_CONFIG = %w(member_survey icontact).inject(Hashie::Mash.new) do |result, file|
  raw_config = ERB.new(File.read(File.expand_path("#{RAILS_ROOT}/config/#{file}.yml", __FILE__))).result
  result[file.to_sym]= Hashie::Mash.new(YAML.load(raw_config)[RAILS_ENV])
  result
end unless defined? APPLICATION_CONFIG

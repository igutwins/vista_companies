require_relative "./vista_companies/version"
require_relative "./vista_companies/cli.rb"
require_relative "./vista_companies/portco.rb"
require_relative "./vista_companies/scraper.rb"
require 'pry'
require 'openssl'
require 'nokogiri'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

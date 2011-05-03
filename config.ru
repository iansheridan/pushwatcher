$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'sinatra'

# sinatra rb config =================================================
set :run, false
set :environment, :development
set :raise_errors, true
set :root, File.dirname(__FILE__)
set :app_file, 'app.rb'

require './app.rb'
run Sinatra::Application

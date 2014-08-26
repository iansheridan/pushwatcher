# app.rb app file ===================================================
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'grit'
require 'hashie'
require 'json'
require 'logger'
require 'net/http' # is not a gem

# put the LIB directory on the load path
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')

Update = Hashie::Mash.new
Update.root = File.dirname(__FILE__)
logfile = File.open("#{Update.root}/updates.log", 'a+')
Update.log = Logger.new("#{Update.root}/updates.log")
Update.log.level = Logger::DEBUG

# load application parts ============================================
load 'routes.rb'

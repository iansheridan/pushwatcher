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

Wikiupdate = Hashie::Mash.new
Wikiupdate.root = File.dirname(__FILE__)
logfile = File.open("#{Wikiupdate.root}/updates.log", 'a+')
Wikiupdate.log = Logger.new("#{Wikiupdate.root}/updates.log")
Wikiupdate.log.level = Logger::DEBUG

# load application parts ============================================
load 'routes.rb'

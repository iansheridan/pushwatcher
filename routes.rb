# routes file =======================================================

get '/wiki-update/' do
  @log = File.read(File.join(settings.root,"updates.log")).split("\n").reverse[1..10]
  erb :index
end

get '/wiki-update/updates.json' do
  File.read(File.join(settings.root,"updates.log")).split("\n").reverse[1..10].to_json
end

post '/wiki-update/' do
  payload = params[:payload]
  redirect "/empty" if payload.nil?
  payload_parse = JSON.parse(payload)
  push = Hashie::Mash.new(payload_parse)
  Wikiupdate.log.info "#{push.commits.last.author.name} submitted an update with message: \"#{push.commits.last.message}\" SHA: #{push.commits.last.id}"
  # pull down the new code to the GIT repository
  `cd /var/apps/wiki/current && git pull origin master`
  # restart the Unicorn server
  `kill -s HUP \`cat /var/apps/wiki/current/tmp/pids/unicorn-master.pid\``
  "#{push.inspect}"
end

get '/empty' do
  Wikiupdate.log.error "payload was empty."
  "HEY! You gave me nothing!"
end

get '/wiki/images/:image' do
  send_file File.join( Wiki.root, "public", "images", params[:image] )
end
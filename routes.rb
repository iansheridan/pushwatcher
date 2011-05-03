# routes file =======================================================

post '/wiki-update/' do
  payload = params[:payload]
  redirect "/empty" if payload.nil?
  payload_parse = JSON.parse(payload)
  push = Hashie::Mash.new(payload_parse)
  Wikiupdate.log.info "#{push.commits.last.author.name} submitted an update with message: \"#{push.commits.last.message}\" SHA: #{push.commits.last.id}"
  `cd /var/apps/wiki/current && git pull origin master`
  `kill -s HUP \`cat /var/apps/wiki/current/tmp/pids/unicorn-master.pid\``
  "#{push.inspect}"
end

get '/empty' do
  Wikiupdate.log.error "payload was empty."
  "HEY! You gave me nothing!"
end

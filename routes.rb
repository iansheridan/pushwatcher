# routes file =======================================================

get '/update/' do
  @log = File.read(File.join(settings.root,"updates.log")).split("\n").reverse[1..10]
  erb :index
end

get '/update/updates.json' do
  File.read(File.join(settings.root,"updates.log")).split("\n").reverse[1..10].to_json
end

post '/update/' do
  payload = params[:payload]
  redirect "/empty" if payload.nil?
  payload_parse = JSON.parse(payload)
  push = Hashie::Mash.new(payload_parse)
  Update.log.info "#{push[push.keys[0]]} << was the first entry of the payload."
  "#{push.inspect}"
end

get '/empty' do
  Update.log.error "payload was empty."
  "HEY! You gave me nothing!"
end

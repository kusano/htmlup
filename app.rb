#!/usr/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require 'active_record'
require 'securerandom'
require 'pg'

use Rack::Protection

set :bind, '0.0.0.0'

set :haml,
  :escape_html=>true,
  :format=>:html5

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3:database.db')

class Html < ActiveRecord::Base
end

enable :sessions

get '/' do
  haml :index
end

post '/' do
  id = SecureRandom.hex(16)
  html = request['html']
  Html.create({
    id: id,
    html: html
  })
  redirect to '/'+id
end

get /\A\/([0-9a-f]{32,32})\z/ do |id|
  html = Html.find_by(id: id)
  if html
    haml :view, :locals=>{:html=>html.html}, :layout=>false
  else
    ':-('
  end
end

after do
  ActiveRecord::Base.connection.close
end

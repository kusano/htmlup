require 'sinatra/activerecord/rake'
require 'pg'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3:database.db')

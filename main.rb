require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pg'

require_relative 'controllers/bookmarks_controller'

require_relative 'models/bookmark'

get '/' do
  erb :home
end
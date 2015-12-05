require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pg'

get '/bookmarks' do
  #get all bookmarks from DB
  sql = "SELECT * FROM bookmarks"
  @bookmarks = run_sql(sql)

  erb :index
end

get '/bookmarks/new' do
  # Render a form
  erb :new
end

post '/bookmarks' do
  #Persist new bookmark to DB
  url = params[:url]
  genre = params[:genre]
  info = params[:info]
  sql = "INSERT INTO bookmarks (url, genre, info) VALUES ('#{url}', '#{genre}', '#{info}')"
  run_sql(sql)
  redirect to('/bookmarks')
end

get '/bookmarks/:id' do
  # Grab bookmark from DB where id = :id
  sql = "SELECT * FROM bookmarks WHERE id = #{params[:id]}"
  @bookmark = run_sql(sql).first
  erb :show
end

get '/bookmarks/:id/edit' do
  sql = "SELECT * FROM bookmarks WHERE id = #{params[:id]}"
  @bookmark = run_sql(sql).first
  erb :edit
  #Grab bookmark from DB and render form
end

post '/bookmarks/:id' do
  url = params[:url]
  genre = params[:genre]
  info = params[:info]
  sql = "UPDATE bookmarks SET url = '#{url}', genre = '#{genre}', info = '#{info}' WHERE id = #{params[:id]}"
  run_sql(sql)
  redirect to("/bookmarks/#{params[:id]}")
  # Grab params and update in DB
end

post '/bookmarks/:id/delete' do
  sql = "DELETE FROM bookmarks WHERE id = #{params[:id]}"
  run_sql(sql)
  redirect to('/bookmarks')
  # Destroy in DB
end

def run_sql(sql)
  conn = PG.connect(dbname: 'bookmarks', host: 'localhost')

  result = conn.exec(sql)
  conn.close
  result
end
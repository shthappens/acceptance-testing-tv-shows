require 'sinatra'
require 'csv'
require 'pry'
require 'sinatra/flash'
require_relative "app/models/television_show"
enable 'sessions'

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

get "/" do
  redirect "television_shows"
end

get "/television_shows" do
  @shows = TelevisionShow.all
  erb :index
end

get "/television_shows/new" do
  @genres = TelevisionShow::GENRES
  erb :new
end

post "/television_shows/new" do
  @genres = TelevisionShow::GENRES
  @new_show = TelevisionShow.new(params[:title], params[:network], params[:starting_year], params[:synopsis], params[:genre])

  if @new_show.errors
    @error_message = "This show is already listed. Please submit a different show."
    erb :new
  elsif @new_show.valid?
    @missing_entry = "Please fill in all required fields"
    erb :new
  else
    CSV.open("television-shows.csv", "a+") do |csv|
      csv << @new_show.save
    end
    redirect "/television_shows"
  end
end

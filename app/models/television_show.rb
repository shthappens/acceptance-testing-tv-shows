require 'pry'

class TelevisionShow

  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  attr_reader :title, :network, :starting_year, :synopsis, :genre

  def initialize(title, network, starting_year, synopsis, genre)
    @title = title
    @network = network
    @starting_year = starting_year
    @synopsis = synopsis
    @genre = genre
  end

  def self.all
    show_array = []
    CSV.foreach('television-shows.csv', headers: true) do |row|
      show_array << TelevisionShow.new(row['title'], row['network'], row['starting_year'],row['synopsis'], row['genre'])
    end
    show_array
  end

  def valid?
    [@title, @network, @starting_year, @synopsis, @genre].any? { |user_input| user_input.empty? }
  end

  def errors
    saved_shows = CSV.readlines('television-shows.csv', headers: true)
    saved_shows.any? { |show| show[0] == @title }
  end

  def save
    [@title, @network, @starting_year, @synopsis, @genre]
  end

end

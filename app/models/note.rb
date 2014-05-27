class Note < ActiveRecord::Base
  before_save :remove_empty

  # All the metadata keys in the hstore column

  # For type: Question
  store_accessor :metadata, :question
  store_accessor :metadata, :answered

  # For type: Quote
  store_accessor :metadata, :quote
  store_accessor :metadata, :quote_source

  # For type: Place
  store_accessor :metadata, :place
  store_accessor :metadata, :place_latitude
  store_accessor :metadata, :place_longitude

  # For type: URL
  store_accessor :metadata, :url
  store_accessor :metadata, :url_tags

  # For type: File
  store_accessor :metadata, :file
  store_accessor :metadata, :file_type

  # For type: Book
  store_accessor :metadata, :book_title
  store_accessor :metadata, :book_author
  store_accessor :metadata, :book_pubdate

  # For type: Movie
  store_accessor :metadata, :movie_title
  store_accessor :metadata, :movie_director
  store_accessor :metadata, :movie_releasedate

  # For type: TV Show
  store_accessor :metadata, :tvshow_title
  store_accessor :metadata, :tvshow_creator
  store_accessor :metadata, :tvshow_startdate
  store_accessor :metadata, :tvshow_season
  store_accessor :metadata, :tvshow_episode

  # For type: Music
  store_accessor :metadata, :music_artist
  store_accessor :metadata, :music_album
  store_accessor :metadata, :music_track
  store_accessor :metadata, :music_releasedate

  # For type: Recipe
  store_accessor :metadata, :recipe
  store_accessor :metadata, :recipe_ingredients
  store_accessor :metadata, :recipe_steps
  store_accessor :metadata, :recipe_source

  # For type: Image Note
  store_accessor :metadata, :imagenote
  store_accessor :metadata, :imagenote_x
  store_accessor :metadata, :imagenote_y

  private

  def remove_empty
    self.metadata = self.metadata.reject{ |k,v| v.blank? }
  end
end

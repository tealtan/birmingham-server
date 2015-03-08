require "open-uri"

class Note < ActiveRecord::Base
  has_and_belongs_to_many :notebooks

  before_save :remove_empty
  after_save :update_file_metadata

  # File attachments
  has_attached_file :attachment,
    :path => "public/attachment/:id/:filename",
    :url => "/attachment/:id/:basename.:extension"
  do_not_validate_attachment_file_type :attachment

  # Get file from URL
  def attachment_from_url(url)
    self.attachment = open(url)
  end

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
  store_accessor :metadata, :file_url
  store_accessor :metadata, :file_name
  store_accessor :metadata, :file_type
  store_accessor :metadata, :file_size

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

  include ActionView::Helpers::NumberHelper
  def update_file_metadata
    # This puts attachment data into the metadata fields.
    # Only update if user is adding or changing an attachment.
    unless (self.attachment.original_filename.nil? || (self.file_url == self.attachment.url))
      self.file_url = self.attachment.url
      self.file_name = self.attachment.original_filename
      self.file_type = MIME::Types[self.attachment.content_type].first.extensions.first
      self.file_size = number_to_human_size(self.attachment.size).downcase
      self.save
    end
  end
end

module ApplicationHelper
  def markdown(text)
    require 'kramdown'
    return Kramdown::Document.new(text).to_html
  end
end

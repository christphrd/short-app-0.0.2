require 'open-uri'

class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    @short_url = ShortUrl.find(short_url_id)
    title = ''
    URI.open(@short_url.full_url) do |f|
      str = f.read
      title = str.scan(/<title>(.*?)<\/title>/)[0][0]
    end
    @short_url.update(title: title)
  end
end

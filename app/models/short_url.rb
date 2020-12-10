require 'uri'
require 'open-uri'

class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  BASE = CHARACTERS.length

  validates :full_url, presence: true
  validate :validate_full_url

  def self.find_by_short_code(short_code)
    short_code_length = short_code.length
    decoded_id = 0

    index = 0
    short_code.each_char do |char|
      power = (short_code_length - (index + 1))
      decoded_id += CHARACTERS.index(char) * (BASE ** power)
      index += 1
    end
    return ShortUrl.find(decoded_id)
  end

  def short_code
    if id == nil
      return nil
    end

    short_code = ""
    base10_number = id
    while base10_number > 0
      short_code = CHARACTERS[base10_number % BASE] + short_code
      base10_number = base10_number / BASE
    end
    return short_code
  end

  def update_title!
    title_line = ''
    URI.open(full_url) do |f|
      str = f.read
      title_line = str.scan(/<title>(.*?)<\/title>/)[0][0]
    end
    self.update(title: title_line)
  end

  def public_attributes
    self.to_json(only: [:full_url, :title, :click_count])
  end

  private

  def validate_full_url
    begin
      uri = URI.parse(full_url)
      if !uri.is_a?(URI::HTTP) || uri.host.nil?
        errors.add(:full_url, "is not a valid url")
      end
    rescue URI::InvalidURIError
      errors.add(:full_url, "is not a valid url")
    end
  end

end

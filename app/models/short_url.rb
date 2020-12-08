require 'uri'

class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url

  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
    begin
      uri = URI.parse(full_url)
      if !uri.is_a?(URI::HTTP) || uri.host.nil?
        errors.add(:full_url, "Full url is not a valid url")
      end
    rescue URI::InvalidURIError
      errors.add(:full_url, "Full url is not a valid url")
    end
  end

end

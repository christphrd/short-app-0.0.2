class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    #TODO: Check if this works as expected
    render json: {"top 100 most frequently accessed shortcodes": ShortUrl.order(click_count: :desc).limit(100)}
  end

  def create
    @short_url = ShortUrl.new(full_url: params["full_url"])
  end

  def show
  end

end

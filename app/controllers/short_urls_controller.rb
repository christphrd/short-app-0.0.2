class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    #TODO: Check if this works as expected
    render json: {"top 100 most frequently accessed shortcodes": ShortUrl.order(click_count: :desc).limit(100)}
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.save
      render json: @short_url.as_json(methods: :short_code)
    else
      render json: {errors: @short_url.errors.full_messages }
    end
  end

  def show
    @short_url = ShortUrl.find_by_short_code(params["id"])
    @short_url.increment!(:click_count)
    redirect_to @short_url.full_url
  end

  private
  def short_url_params
    params.permit(:full_url)
  end

end

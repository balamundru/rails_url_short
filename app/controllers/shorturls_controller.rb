class ShorturlsController < ApplicationController
  # before_action :set_shorturl, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:short_url_generate]

  def short_url_generate
    unless session_rate_limit >= 10
      @url = Shorturl.check_and_create_shorturl(shorturl_params[:original_url])
      SessionTracker.create(session_id: request.session.id, ip_address: request.remote_ip) if @url.present?
      @display_url = get_display_url(@url) if @url.present?
    else
     @message = "Limit has reached for the day"
    end
    respond_to do |format|
      format.js { render :short_url_generate }
    end
  end

  def render_form
  end

  def show_short_url
    shorturl = Shorturl.find_by(short_url: params[:shortened_url])
    if shorturl.present?
      shorturl.update(visits: shorturl.visits+1 )
      UrlAnalytic.create_analytic(shorturl)
    end
    redirect_to shorturl.sanitize_url
  end


  def analytics
    @short_urls = Shorturl.all
    @today_analytics = UrlAnalytic.where(shorturl_id: @short_urls.pluck(:id), visited_time: (Date.today.beginning_of_day..Date.today.end_of_day))
  end

  # PATCH/PUT /shorturls/1
  # PATCH/PUT /shorturls/1.json
  # def update
  #   respond_to do |format|
  #     if @shorturl.update(shorturl_params)
  #       format.html { redirect_to @shorturl, notice: 'Shorturl was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @shorturl }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @shorturl.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def session_rate_limit
      SessionTracker.where(session_id: request.session.id, created_at:(Date.today.beginning_of_day..Date.today.end_of_day)).count
    end

    def get_display_url(url)
      if request.host == 'localhost'
        return "#{request.host}:#{request.port}" + "/"+ url.short_url
      else
        return request.host + "/" + url.short_url
      end
    end

    def set_shorturl
      @shorturl = Shorturl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shorturl_params
      params.fetch(:shorturl).permit(:original_url)
    end
end

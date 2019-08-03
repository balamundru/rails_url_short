class UrlAnalytic < ApplicationRecord
  def self.create_analytic(shorturl)
    analytic = self.new(shorturl_id: shorturl.id)
    analytic.short_url =  shorturl.short_url
    analytic.original_url = shorturl.original_url
    analytic.visited_time = Time.now
    analytic.save
  end
end

class Shorturl < ApplicationRecord
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url, with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create :generate_short_url
  before_create :sanitize
  has_many :url_analytics
  
  def generate_short_url
    url = ([*('a'..'z'),*('0'..'9'),*('A'..'Z')]).sample(6).join
    old_url = Shorturl.where(short_url: url).last
    if old_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end

  def sanitize
    self.original_url.strip!
    self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    self.sanitize_url.slice!(-1) if self.sanitize_url[-1] == "/"
    self.sanitize_url = "http://#{self.sanitize_url}"
  end

  def self.check_and_create_shorturl(original_url)
    self.transaction do
      begin
        url = Shorturl.new(original_url: original_url)
        url.sanitize
        existed_url = Shorturl.find_by(sanitize_url: url.sanitize_url)
        unless existed_url.present?
          url.save
        else 
          url = existed_url
        end
        return url
      rescue => e
        print e
      end
    end
  end
end

class CreateUrlAnalytics < ActiveRecord::Migration[5.2]
  def change
    create_table :url_analytics do |t|
      t.text :short_url
      t.text :original_url
      t.datetime :visited_time
      t.integer :shorturl_id
      t.timestamps
    end
  end
end

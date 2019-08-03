class CreateShorturls < ActiveRecord::Migration[5.2]
  def change
    create_table :shorturls do |t|
      t.text :original_url
      t.string :short_url
      t.text :sanitize_url
      t.timestamps
    end
  end
end

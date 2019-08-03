class CreateSessionTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :session_trackers do |t|
      t.text :session_id
      t.string :ip_address
      t.timestamps
    end
  end
end

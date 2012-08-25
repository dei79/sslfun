class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :app_cert_id
      t.integer :app_key_id

      t.timestamps
    end
  end
end

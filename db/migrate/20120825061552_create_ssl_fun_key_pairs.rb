class CreateSslFunKeyPairs < ActiveRecord::Migration
  def change
    create_table :ssl_fun_key_pairs do |t|
      t.text :data

      t.timestamps
    end
  end
end

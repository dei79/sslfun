class CreateSslFunCertificates < ActiveRecord::Migration
  def change
    create_table :ssl_fun_certificates do |t|
      t.text :data
      t.integer :key_pair_id

      t.timestamps
    end
  end
end

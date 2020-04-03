class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :header
      t.string :content
      t.string :email
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end

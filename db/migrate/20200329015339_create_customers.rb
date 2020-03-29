class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end

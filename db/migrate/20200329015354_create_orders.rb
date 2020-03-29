class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.decimal :amount
      t.string :shipping_address
      t.string :status
      t.string :email
      t.decimal :hst
      t.decimal :gst
      t.decimal :pst
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

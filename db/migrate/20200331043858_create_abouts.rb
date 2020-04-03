class CreateAbouts < ActiveRecord::Migration[6.0]
  def change
    create_table :abouts do |t|
      t.string :header
      t.string :content

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.integer :recurs_on, default: 0
      t.references :user, index: true

      t.timestamps null: false
    end
  end

end

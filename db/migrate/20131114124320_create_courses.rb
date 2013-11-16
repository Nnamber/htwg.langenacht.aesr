class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :topic
      t.string :description

      t.timestamps
    end
  end
end

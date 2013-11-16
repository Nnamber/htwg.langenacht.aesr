class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :topic
      t.string :description

      t.timestamps
    end
  end

  def self.up
    add_attachment :courses, :xmlfile
  end

  def self.down
    remove_attachment :courses, :xmlfile
  end
end

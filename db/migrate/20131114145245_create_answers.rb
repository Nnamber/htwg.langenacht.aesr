class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :notice
      t.string :body
      t.boolean :correct
      t.string :pattern
      t.integer :question_id

      t.timestamps
    end
  end
end

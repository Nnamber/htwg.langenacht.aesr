class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :questiontype
      t.string :name
      t.string :body
      t.string :noticewrong
      t.string :noticeright
      t.string :notice
      t.integer :topic_id

      t.timestamps
    end
  end
end

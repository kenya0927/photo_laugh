class CreateTopicComments < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end

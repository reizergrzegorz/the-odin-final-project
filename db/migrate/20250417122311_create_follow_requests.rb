class CreateFollowRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :follow_requests do |t|
      t.references :requester, null: false, foreign_key: true
      t.references :receiver, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

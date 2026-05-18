class AddUniqueIndexToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_index :notifications,
              [ :recipient_id, :actor_id, :notifiable_type, :notifiable_id ],
              unique: true, name: "index_notifications_uniqueness"
  end
end

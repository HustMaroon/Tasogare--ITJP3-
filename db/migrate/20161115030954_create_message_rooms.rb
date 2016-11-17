class CreateMessageRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :message_rooms do |t|

      t.timestamps
    end
  end
end

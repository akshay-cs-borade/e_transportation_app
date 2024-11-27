class CreateETransportations < ActiveRecord::Migration[7.1]
  def change
    create_table :e_transportations do |t|
      t.string :e_transportation_type
      t.string :sensor_type
      t.integer :owner_id
      t.boolean :in_zone
      t.boolean :lost_sensor

      t.timestamps
    end
  end
end

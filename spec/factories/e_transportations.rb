FactoryBot.define do
  factory :e_transportation do
    e_transportation_type { "MyString" }
    sensor_type { "MyString" }
    owner_id { 1 }
    in_zone { false }
    lost_sensor { false }
  end
end

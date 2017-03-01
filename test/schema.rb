ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :business_hours, force: true do |t|
    t.integer :opening
    t.integer :closing
  end
end

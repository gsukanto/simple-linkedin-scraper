class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      # Will use redis because its impossible to reconstruct / reverse engineer this table
    end
  end
end

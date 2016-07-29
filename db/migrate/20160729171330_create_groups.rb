class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      # Will use redis because its impossible to reconstruct / reverse engineer this table
    end
  end
end

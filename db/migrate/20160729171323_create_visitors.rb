class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      # Will use redis because its impossible to reconstruct / reverse engineer this table
    end
  end
end

class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      # Will use redis because its impossible to reconstruct / reverse engineer this table
    end
  end
end

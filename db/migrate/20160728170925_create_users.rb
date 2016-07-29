class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :linkedin_url
      t.string      :first_name
      t.string      :last_name
      t.string      :title
      t.text        :summary
      t.string      :location
      t.string      :country
      t.string      :industry
      t.string      :picture
      t.timestamp   :created_at
      t.timestamp   :updated_at
    end
  end
end

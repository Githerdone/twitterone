class CreateTable < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
		end
		create_table :tweets do |t|
			t.string :tweet
			t.date :created
			t.belongs_to :user
			t.timestamps
		end
	end
end

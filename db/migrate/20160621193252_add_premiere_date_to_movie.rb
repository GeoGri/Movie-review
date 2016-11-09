class AddPremiereDateToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :premiere_date, :date
  end
end

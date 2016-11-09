class AddScenarioToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :scenario, :string
  end
end

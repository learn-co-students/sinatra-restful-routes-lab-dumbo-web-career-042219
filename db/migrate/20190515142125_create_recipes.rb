class CreateRecipes < ActiveRecord::Migration
  
  def change
  create_table(:recipes) do |t|
  t.column :name, :string
  t.column :ingredients, :string
  t.column :cook_time, :integer
  end
end

end
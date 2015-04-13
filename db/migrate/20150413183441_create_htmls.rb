class CreateHtmls < ActiveRecord::Migration
  def change
    create_table :htmls, {:id=>false, :primary_key=>'id'} do |t|
      t.string :id
      t.string :html
      t.timestamps null: false
    end
  end
end

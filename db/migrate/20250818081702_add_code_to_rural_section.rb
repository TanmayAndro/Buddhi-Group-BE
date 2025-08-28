class AddCodeToRuralSection < ActiveRecord::Migration[7.1]
  def change
    add_column :rural_sections, :rural_section_code, :integer
  end
end

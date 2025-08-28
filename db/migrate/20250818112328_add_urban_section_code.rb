class AddUrbanSectionCode < ActiveRecord::Migration[7.1]
  def change
    add_column :urban_sections, :urban_section_code, :integer
  end
end

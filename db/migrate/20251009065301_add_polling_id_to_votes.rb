class AddPollingIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :polling_id, :string
  end
end

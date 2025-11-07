class AddUpdatedCandidateListToVote < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :updated_candidate_list, :string
  end
end

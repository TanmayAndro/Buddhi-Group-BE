# spec/models/fundamental_indicator_spec.rb
require "rails_helper"

RSpec.describe FundamentalIndicator, type: :model do
  it "checks total_person equals sum of ethnic_group_population" do
    total   = 0
    matched = 0
    mismatched = []

    FundamentalIndicator.find_each do |indicator|
      next if indicator.total_person.nil?

      total += 1
      ethnic_data = indicator.ethnic_group_population || {}
      if indicator.total_person == ethnic_data.values.sum
        matched += 1
      else
        mismatched << indicator.id
      end
    end

    puts "\nChecked: #{total}, Matched: #{matched}, Mismatched: #{mismatched.count}"
    puts "Mismatched IDs: #{mismatched.join(', ')}" if mismatched.any?

    expect(mismatched).to be_empty
  end
end


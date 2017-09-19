# == Schema Information
#
# Table name: studies
#
#  id          :integer          not null, primary key
#  title       :string
#  startdate   :date
#  enddate     :date
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :study do
    title "MyString"
    startdate "2017-03-22"
    enddate "2017-03-22"
    description "MyText"
  end
end

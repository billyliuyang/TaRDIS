FactoryGirl.define do
  factory :task do
    title "MyString"
    startdate "2017-03-28"
    enddate "2017-03-28"
    lead_dm_time 1
    dm_time 1
    support_dm_time 1
    study nil
  end
end

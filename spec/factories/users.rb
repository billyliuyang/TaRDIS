FactoryGirl.define do

  factory :user do

    factory :admin do
      role :admin
      givenname :Givenname
      sn :Surname		
    end

    factory :manager do
      role :manager
      givenname :Givenname
      sn :Surname
    end

  end
end

require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name { 'firstname' }
    last_name { 'lastname' }
    username { 'username' }
    role { 'role' }
    password { 'password' }
    password_confirmation { 'password' }
  end

end

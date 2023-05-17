FactoryBot.define do
  factory :user do
    nickname { 'test' }
    last_name { '山田' }
    first_name { '陸太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'リクタロウ' }
    birth_date { '1930-01-01' }
    email                 { Faker::Internet.free_email }
    password              { 'abc123' }
    password_confirmation { password }
  end
end

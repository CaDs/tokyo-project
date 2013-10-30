FactoryGirl.define do

  factory :account do
    name "Admin"
    surname "nimdA"
    email "test#{Time.now.to_i}@example.com"
    crypted_password "a12345"
    role "admin"
  end

  factory :area do
    name "test_area"
    description "just a test area"
    ward
  end

  factory :picture do
    vision
    account
    flickr_id　1234
    description_en "test"
    description_es "prueba"
    description_jp "テスト"
    is_published false
    longitude "0"
    latitude "1"
  end

  factory :post do
    title "test post"
    body "this is a post"
    account
    is_published false
  end

  factory :vision do
    title "test vision"
    short_description "this is a short description"
    body "nantoka"
    account
    wiki_url "localhost/test"
  end

  factory :ward do
    name "test ward"
    description "just a test ward"
  end

  factory :user do
    first_name "John"
    last_name  "Doe"
    admin false
  end

end
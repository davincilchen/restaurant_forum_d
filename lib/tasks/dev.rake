namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|

        image_path = Rails.root.join("seed_img/#{rand(1..10)}.jpg")
        image_file = nil

        if File.file?image_path
          image_file = File.open(image_path)
        end

        Restaurant.create!(name: "#{(i+1).to_s}."+FFaker::Name.first_name,
          opening_hours: FFaker::Time.datetime,
          tel: FFaker::PhoneNumber.short_phone_number,
          address: FFaker::Address.street_address,
          description: FFaker::Lorem.paragraph,
          category: Category.all.sample,
          image: image_file,

        )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user_clear: :environment do
    User.destroy_all
    puts "delete all users"
  end

  task fake_user: :environment do
    20.times do |i|
    User.create!(email: FFaker::Name.first_name+"@gmail.com",
      password: "123456"
    )
    end
    puts "have create fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_comment_clear: :environment do
    Comment.destroy_all
  end

  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(content: FFaker::Lorem.sentence, user: User.all.sample)
      end
    end
    puts "have create fake comments"
  end
end

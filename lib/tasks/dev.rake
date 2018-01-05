namespace :dev do
  task fake: :environment   do
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
end

3.times do |layout|
  Layout.create!(name: "layout#{layout + 1}",
              image: "layout#{layout + 1}.png")
end
puts "created 3 layouts"

3.times do |combo|
  ColorCombo.create!(name: "Combo#{combo + 1}")
end
puts "created 3 combos"

@user = User.create(email: "sam@sam2.com",
                    password: "foobar",
                    password_confirmation: "foobar")

puts "created 1 user"

@website = @user.websites.create(
            name: "My first website",
            description: "Hello",
            color_combo_id: ColorCombo.first.id
            )

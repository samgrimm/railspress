3.times do |layout|
  Layout.create!(name: "Layout #{layout + 1}",
              image: "layout#{layout + 1}.png")
end
puts "created 3 layouts"

@user = User.create(email: "sam@sam2.com",
                    password: "foobar",
                    password_confirmation: "foobar")

puts "created 1 user"

@website = @user.websites.create(
            name: "My first website",
            description: "Hello"
            )

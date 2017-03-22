3.times do |layout|
  Layout.create!(name: "layout#{layout + 1}",
                 image: "layout#{layout + 1}.png")
end
puts 'created 3 layouts'

3.times do |combo|
  ColorCombo.create!(name: "Combo#{combo + 1}")
end
puts 'created 3 combos'

@user = User.create(email: 'sam@sam2.com',
                    password: 'foobar',
                    password_confirmation: 'foobar')

puts 'created 1 user'

@website = @user.websites.create(
  name: 'My first website',
  description: 'Hello',
  color_combo_id: ColorCombo.first.id
)

4.times do |page|
  Page.create!(
    title: "Page #{page + 1}",
    content: Faker::Lorem.paragraph(2),
    website_id: @website.id
  )
end

@pages = Page.all

@pages.each do |page|
  3.times do
    col_span = rand(1..12).to_s
    page.widgets.create!(
      type: 'Text',
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph(2),
      col_span: "col-md-#{col_span}"
    )
  end
end

@pages.each do |page|
  3.times do
    col_span = rand(1..12).to_s
    page.widgets.create!(
      type: 'Image',
      title: Faker::Lorem.sentence,
      image: Faker::LoremPixel.image,
      col_span: "col-md-#{col_span}"
    )
  end
end

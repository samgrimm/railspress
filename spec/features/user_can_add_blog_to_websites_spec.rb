require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe 'adding a blog to the website' do
  let(:user) { FactoryGirl.create(:user) }
  let(:color_combo1) { FactoryGirl.create(:color_combo, name: 'Combo1') }
  let(:website) { FactoryGirl.create(:website, user_id: user.id, color_combo_id: color_combo1.id) }
  let(:navbar) { FactoryGirl.create(:navbar, website: website) }
  let(:footer) { FactoryGirl.create(:navbar, website: website, position: 'footer') }
  before do
    login_as(user, scope: :user)
  end
  describe 'adding a blog' do
    it 'user has links to add blog' do
      visit website_path(website, locale: 'en')
      click_on('Blog')
      expect(page).to have_content('Your website does not have a blog yet')
    end
    it 'adding a blog happens with one click' do
      visit website_path(website, locale: 'en')
      click_on('Blog')
      click_on('Add Blog')
      expect(page).to have_content('Now you can start writing your blog')
      expect(page).to have_link('addPost')
    end
    it 'allows user to add only one blog' do
      @blog = FactoryGirl.create(:blog, website: website)
      website.reload
      visit new_website_blog_path(website, locale: 'en')
      expect(page).to have_content('Now you can start writing your blog')
      expect(page).not_to have_content('Your website does not have a blog yet')
      expect(page).not_to have_content('Add Blog')
    end
    xit 'allows user to add the blog link to the navbar' do
      visit website_path(website, locale: 'en')
      click_on('Blog')
      click_on('Add Blog')
      expect(page).to have_content('Blog on Navbar?')
      click_on('Blog on Navbar?')
      expect(page).to have_content('My Blog')
    end
  end
  describe 'Blog Posts:' do
    it 'allows user to add blog posts (new)' do
      @blog = FactoryGirl.create(:blog, website: website)
      website.reload
      visit website_blog_posts_path(website, @blog, locale: 'en')
      click_on('addPost')
      fill_in 'Title', with: 'New Post title'
      fill_in 'Content', with: 'Some amazing content'
      click_on(I18n.t('posts.new.create'))
      expect(Post.last.title).to eq('New Post title')
    end
    it 'allows user to see all blog posts (index)' do
      @blog = FactoryGirl.create(:blog, website: website)
      3.times do |post|
        post = @blog.posts.build(title: "Post #{post}", content: " Some amazing #{post}nth content")
      end
      @blog.save
      @blog.reload
      visit website_blog_posts_path(website, @blog, locale: 'en')
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 0')
    end
    it 'allows user to see edit blog posts (edit)' do
      @blog = FactoryGirl.create(:blog, website: website)

      @post = @blog.posts.build(title: 'Post 1', content: ' Some amazing 1st content')

      @blog.save
      @blog.reload
      visit edit_website_blog_post_path(website, @blog, @post, locale: 'en')
      fill_in 'Title', with: 'Changed title'
      fill_in 'Content', with: 'Some amazing content'
      click_on(I18n.t('posts.edit.update'))
      expect(Post.last.title).to eq('Changed title')
    end
    it 'allows user to delete blog posts (destroy)' do
      @blog = FactoryGirl.create(:blog, website: website)
      3.times do |post|
        post = @blog.posts.build(title: "Post #{post}", content: " Some amazing #{post}nth content")
      end
      @blog.save
      @blog.reload
      visit website_blog_posts_path(website, @blog, locale: 'en')
      click_on("delete_post_#{Post.first.id}")
      expect(page).not_to have_content('Post 0')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 1')
    end
    it 'allows user to publish a blog post' do
      @blog = FactoryGirl.create(:blog, website: website)
      3.times do |post|
        post = @blog.posts.build(title: "Post #{post}", content: " Some amazing #{post}nth content", status: 'draft')
      end
      @blog.save
      @blog.reload
      visit website_blog_posts_path(website, @blog, locale: 'en')
      click_on("toggle_status_#{Post.first.id}")
      expect(Post.first.status).to eq('published')
    end
    it 'allows user save a post to draft' do
      @blog = FactoryGirl.create(:blog, website: website)
      3.times do |post|
        post = @blog.posts.build(title: "Post #{post}", content: " Some amazing #{post}nth content", status: 'published')
      end
      @blog.save
      @blog.reload
      visit website_blog_posts_path(website, @blog, locale: 'en')
      click_on("toggle_status_#{Post.first.id}")
      expect(Post.first.status).to eq('draft')
    end
  end
end

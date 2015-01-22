require 'test_helper'

class CreateTest < ActionDispatch::IntegrationTest
  setup do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

  test "no JS" do
    visit posts_path
    click_link "New Post"
    assert current_path == new_post_path

    post_title = 'My first test post'
    post_body = 'This is my first post. It is very tasty.'

    fill_in 'Title', with: post_title
    fill_in 'Body', with: post_body

    click_button 'Create Post'

    p = Post.last

    assert p.title == post_title
    assert p.body == post_body

    assert current_path == post_path(p.id)

    # puts "No JS: #{p.inspect}"

  end

  test "with JS" do
    # don't actually need this yet because we aren't using any
    # javascript functionality
    Capybara.current_driver = :selenium

    visit posts_path
    click_link "New Post"
    assert current_path == new_post_path

    post_title = 'My first test post'
    post_body = 'This is my first post. It is very tasty.'

    click_link 'Random Title'

    fill_in 'Body', with: post_body

    click_button 'Create Post'

    p = Post.last

    assert (p.title != ""), "did not fill in random title"
    assert p.body == post_body

    assert current_path == post_path(p.id)

    # puts "with JS: #{p.inspect}"
  end

end

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  self.use_transactional_fixtures = false

  test "after_commit is triggered" do
    post = Post.create!

    assert_equal [:saved, :committed], post.history
  end

  test "after_commit does not swallow a raised error" do
    post = Post.new(:trigger_error => true)
    assert_equal true, post.trigger_error

    assert_raise StandardError do
      post.save!
    end

    assert_equal [:saved], post.history
  end

end

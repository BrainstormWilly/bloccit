module UsersHelper

  def has_posts_or_comments?
    !@user.posts.empty? || !@user.comments.empty?
  end

end

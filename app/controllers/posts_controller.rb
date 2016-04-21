class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each.with_index do |p,i|
      if i==0 || i % 5 == 0
        p.title = 'SPAM'
        p.save
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end

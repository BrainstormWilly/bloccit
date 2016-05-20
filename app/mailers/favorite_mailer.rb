class FavoriteMailer < ApplicationMailer
  default from: 'brainstormwilly@gmail.com'

  def new_comment(user, post, comment)
     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @user = user
     @post = post
     @comment = comment

     mail(to: user.email, subject: "New comment on #{post.title}", cc: "linojon@gmail.com")
   end
end

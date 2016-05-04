class User < ActiveRecord::Base

  before_save :do_before_save

  private
  def do_before_save
    self.email = email.downcase
    self.name = name.split(" ").collect{ |word| word.capitalize }.join(" ") if self.name
  end
  #
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 254 }
  #
  has_secure_password
end

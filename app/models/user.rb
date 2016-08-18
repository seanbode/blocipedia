class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborations
  has_many :wiki_collaboration, through: :collaborations, source: :wikis

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:standard, :premium, :admin]

#  def avatar_url(size)
#    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
#    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
#  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 before_create :user_status
 after_create :correct_user

def user_status
  if role == 'customer'
    self.status = 'approve'
  else
    self.status = 'pending'
  end
end

def correct_user
  if role == 'owner'
     owner = Owner.new
     owner.user_id = self.id
     owner.save
  end
end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates_confirmation_of :password


  enum role: { admin:'admin', customer:'customer', owner:'owner' }

  enum status: { approve:'approve', pending:'pending', suspend:'suspend' }

  has_many :reservations, :dependent => :destroy

end

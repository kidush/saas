class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  validate :email_is_unique, on: :create
  after_create :create_account

  private

  # controllo se l'email è unica nell'ACCOUNT model
  def email_is_unique
    # non effettuo la validazione se è gia presente un errore relativo alla mail
    return false unless self.errors[:email].empty?
    # controllo se è gia presente la mail se si aggiungo l'errore di mail presente
    unless Account.find_by_email(email).nil?
      errors.add(:email, "la mail è già stata utilizzata")
    end
  end

  # dopo la creazione dell'user di devise aggiungo un account
  def create_account
    account = Account.new(:email => email)
    account.save!
  end

end

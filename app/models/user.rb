class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :async

  validate :email_is_unique, on: :create
  validate :subdomain_is_unique, on: :create
  after_validation :create_tenant

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

  def subdomain_is_unique
    if subdomain.present?
      unless Account.find_by_subdomain(subdomain).nil?
        errors.add(:subdomain, "Sottodominio già utilizzato")
      end

      if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
        errors.add(:subdomain, "Sottodominio non utilizzabile")
      end
    end
  end

  # dopo la creazione dell'user di devise aggiungo un account
  def create_account
    account = Account.new(:email => email, :subdomain => subdomain)
    account.save!
  end

  def create_tenant
    return false unless self.errors.empty?
    # controllo se il tenant è gia presente nel caso di aggiornamento password
    if self.new_record?
      Apartment::Tenant.create(subdomain)
    end
    Apartment::Tenant.switch!(subdomain)
  end

end

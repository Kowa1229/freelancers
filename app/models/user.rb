class User < ApplicationRecord
  # has_many :user_category, dependent: :destroy
  belongs_to :city
  has_many :appointments
  has_and_belongs_to_many :categories

  has_many :appointment_applicant, class_name: "AppointmentApplication",
           foreign_key: "user_id"

  has_many :application, through: :appointment_applicant, source: :user

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  # mount_uploader :profile_picture, UserUploader
  mount_uploader :profile_picture, UserUploader

  has_secure_password

  VALID_EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :fullname, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20 },
            uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  # validates :profile_picture, presence: true
  # city_id
  # employer 1 = employer, 0 = freelancers
  validate :picture_size




  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end


  def opportunities(category_ids, city_id)
    Appointment.where("category_id IN (?) AND city_id = ? AND status = ? ", category_ids, city_id, 0)
  end

  def progress_appointment(current_user)
    application_ids = current_user.appointment_applicant_ids
    # appointment_ids =
    Appointment.where("id IN (?) AND status = ? ", get_appointment_ids(application_ids), 1)
  end

  def completed_appointment(current_user)
    application_ids = current_user.appointment_applicant_ids
    # appointment_ids =
    Appointment.where("id IN (?) AND status = ? ", get_appointment_ids(application_ids), 2)
  end

  def is_employer?
    employer == true ? true : false
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  

  private
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def get_appointment_ids(applicant_ids)
    appointment_ids = AppointmentApplication.find(applicant_ids)
    ids_array = []

    appointment_ids.each do |app|
      ids_array << app.appointment_id
    end

    return ids_array
  end

  # Validates the size of an uploaded picture.
  def picture_size
    if profile_picture.size > 5.megabytes
      errors.add(:profile_picture, "should be less than 5MB")
    end
  end

end

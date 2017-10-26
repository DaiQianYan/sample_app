class User < ApplicationRecord
    # 13.11 A user has_many microposts.
    # has_many :microposts
    # 13.19 Ensuring that a user's microposts are destroyed along with the user.
    has_many :microposts, dependent: :destroy
    # attr_accessor :remember_token
    # Adding account activation code to the User model.
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email
    before_create :name, presence: true, length: { maximum: 50 }

    # 邮箱入库前规范格式，小写处理
    # before_save {self.email = email.downcase}   
    # before_save {email.downcase!}
    
    # 设置用户名非空验证，长度限制
    # validates(:name, presence: true)
    validates :name, presence: true, length: {maximum: 50}

    # 设置邮箱格式验证，长度验证，非空验证，唯一性验证
    # 设置验证邮箱格式的正则表达式
    # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, 
                      length: {maximum: 255},
                      format: {with: VALID_EMAIL_REGEX}, # format: {with: /Regex/}如果with: 后面跟的是变量就不能加双斜线//
                      # uniqueness: true
                      uniqueness: { case_sensitive: false }
    
    # 设置用户密码密码
    has_secure_password
    # Allowing empty passwords on update.
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a ranfom token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    # def authenticated?(remember_token)
    #     return false if remember_digest.nil?
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    # A generalized authenticated? method.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end 

    # 删除session则忘记用户
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Adding user activation methods to the User model.
    # Activates an account.
    def activate 
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    private
        # Converts email to all lower-case.
        def downcase_email
            self.email = email.downcase
        end 
         
        # Creates and assigns the the activation token and digest.
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end

end

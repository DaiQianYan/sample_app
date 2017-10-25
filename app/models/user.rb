class User < ApplicationRecord
    attr_accessor :remember_token

    # 邮箱入库前规范格式，小写处理
    # before_save {self.email = email.downcase}   
    before_save {email.downcase!}
    
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
    validates :password, presence: true, length: { minimum: 6 }

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
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # 删除session则忘记用户
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

end

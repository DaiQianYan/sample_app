class User < ApplicationRecord
    
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

end

##############################################################################
# == Schema Information
#
# Table name: users
# id                      :integer            not null, primary key
# name                    :string
# nickname                :string
# link                    :string
# image                   :string
# uid                     :string             null: false
# provider                :string             null: false
# email                   :string             null: false, default: ""
# encrypted_password      :string             null: false, default: ""
# reset_password_token    :string
# reset_password_sent_at  :datetime
# remember_created_at     :datetime
# sign_in_count           :integer            null: false, default: 0
# current_sign_in_at      :datetime
# last_sign_in_at         :datetime
# current_sign_in_ip      :inet
# last_sign_in_ip         :inet
# created_at              :datetime           null: false
# updated_at              :datetime           null: false
##############################################################################
class User < ActiveRecord::Base
  has_many :messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:twitter, :google, :facebook, :vkontakte]

  class << self
    def from_omniauth(auth)
      # Prevents NoMethodError (auth == nil):
      # in case if user revoces access when redirected to omniauth provider
      return unless auth

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.nickname = auth.info.nickname
        user.link = link_for(auth)
        user.email = email_for(auth)
        user.image = auth.info.image
      end
    end

    private

    def link_for(auth)
      if auth.info.urls
        auth.info.urls[auth.provider.capitalize]
      else
        "https://www.#{auth.provider}.com/#{auth.uid}"
      end
    end

    def email_for(auth)
      "#{auth.uid}@#{auth.provider}.com"
    end
  end
end

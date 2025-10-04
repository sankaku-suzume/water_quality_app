# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :name, format: { with: /\A[ぁ-んァ-ヶ一-龠々ーa-zA-Z0-9\p{blank}]+\z/, message: "は日本語または英数字で入力してください" }
  validates :email, presence: true
  validates :email, format: { with: /\A[a-zA-Z0-9._+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}\z/, message: "の形式が正しくありません" }
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, length: { maximum: 20}
  validates :password, format: { with: /\A[a-zA-Z0-9.\?\-]+\z/, message: "は英数字と . ? - のみ使用できます" }
end

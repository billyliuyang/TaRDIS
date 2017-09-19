# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  username           :string
#  uid                :string
#  mail               :string
#  ou                 :string
#  dn                 :string
#  sn                 :string
#  givenname          :string
#  role               :integer
#  grade              :integer
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#

class User < ApplicationRecord
  include EpiCas::DeviseHelper
  validate :name
  validates :username, presence: true
  
  enum role: [ :manager, :admin ]

  def generate_attributes_from_ldap_info
    if self.dn.downcase =~ /admin/
      self.role ||= :admin
    elsif self.dn.downcase =~ /manager/
      self.role ||= :manager
    end
    super
  end

  def name
    if User.exists?(username: self.username) && self.role.nil?
      errors.add(:error, ": User already exists")
    end
  end

  # def empty_value
  #   if self.grade.nil?
  #     errors.add(:grade, "balabala")
  #   end 
  # end
  
end

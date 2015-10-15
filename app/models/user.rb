class User < ActiveRecord::Base
  include Clearance::User

  ROLES = %w(lawyer admin)

  validates :name, presence: true

  ROLES.each do |role|
    define_method "#{role}?" do
      type == role.capitalize
    end
  end
end

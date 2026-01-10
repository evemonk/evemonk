# frozen_string_literal: true

class MigrateEmailsFromDevise < ActiveRecord::Migration[8.1]
  class User < ActiveRecord::Base
    has_secure_password
  end

  def up
    User.find_each do |user|
      user.email_address = user.devise_email
      user.password = SecureRandom.uuid
      user.save(validate: false)
    end
  end

  def down
    # no-op
  end
end

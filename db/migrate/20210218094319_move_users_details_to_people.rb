class MoveUsersDetailsToPeople < ActiveRecord::Migration[6.0]
  def change
    User.all.each do |user|
      Person.create(
        birthdate: user.birthdate,
        birth_city: user.birth_city,
        phone: user.phone,
        user: user
        )
    end
  end
end

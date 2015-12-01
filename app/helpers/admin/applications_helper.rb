module Admin::ApplicationsHelper
  def group_by_city_select(users)
    users.group_by(&:city).each do |_city, user|
      user.map! { |u| [u.label, u.id] }
    end
  end
end

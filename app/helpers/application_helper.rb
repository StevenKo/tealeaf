module ApplicationHelper
  def display_datetime(dt)
    if current_user
      dt.in_time_zone(current_user.time_zone).strftime("%B %d,%Y %l:%M%P %Z")
    else
      dt.strftime("%B %d,%Y %l:%M%P %Z")
    end
  end
end

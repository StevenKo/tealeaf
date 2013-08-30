module ApplicationHelper
  def display_datetime(dt)
    dt.strftime("%B %d,%Y %l:%M%P %Z")
  end
end

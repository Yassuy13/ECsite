module ApplicationHelper
  def full_title(page_title)
    page_title.blank? ? "BIGBAG" : "#{page_title} - BIGBAG"
  end
end

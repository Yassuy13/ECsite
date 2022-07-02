module ApplicationHelper
  def full_title(page_title)
    page_title.blank? ? 'BIGBAG Store' : "#{page_title} - BIGBAG Store"
  end
end

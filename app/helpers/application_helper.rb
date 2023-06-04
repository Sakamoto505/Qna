# frozen_string_literal: true

module ApplicationHelper
  def highlight(text, query)
    text.gsub(/#{Regexp.escape(query)}/i, '<mark>\0</mark>').html_safe
  end
end

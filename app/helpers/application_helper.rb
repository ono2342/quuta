# frozen_string_literal: true

module ApplicationHelper
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: 'example.com')
    processor.call(markdown)[:output].to_s.html_safe
  end

  def sidebar_activelink(action)
    return 'active' if params[:action] == action
  end
end

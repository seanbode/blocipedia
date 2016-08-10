module WikisHelper
  def markdown_to_html(mdown)
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, footnote: true, quote: true, autolink: true, tables: true)
    @renderer.render(mdown).html_safe
  end
end

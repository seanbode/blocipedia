module WikisHelper
  def markdown(markdown)
    renderer = Redcarpet::Markdown.new(footnote: true, quote: true, autolink: true, tables: true)
    renderer.render(markdown)
  end
end

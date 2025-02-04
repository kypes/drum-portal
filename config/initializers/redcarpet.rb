require "redcarpet"
require "redcarpet/render_strip"

module ActionView
  module Template::Handlers
    class Markdown
      class_attribute :default_format
      self.default_format = Mime[:html]

      def call(template, source)
        @markdown ||= Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(
            filter_html: true,
            hard_wrap: true,
            link_attributes: { rel: "nofollow", target: "_blank" }
          ),
          autolink: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          lax_spacing: true,
          strikethrough: true,
          superscript: true,
          tables: true
        )
        "#{@markdown.render(source).inspect}.html_safe"
      end
    end
  end
end

ActionView::Template.register_template_handler :md, ActionView::Template::Handlers::Markdown.new

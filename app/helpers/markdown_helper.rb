require "rouge"
require "rouge/plugins/redcarpet"

module MarkdownHelper
  def markdown(text)
    return "" if text.blank?

    options = {
      filter_html: false,
      hard_wrap: true,
      link_attributes: { rel: "nofollow", target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true,
      tables: true
    }

    renderer = RougeHTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    sanitize(markdown.render(text), Sanitize::Config::RELAXED.merge(
      elements: Sanitize::Config::RELAXED[:elements] + [ "iframe" ],
      attributes: {
        "iframe" => [ "src", "width", "height", "frameborder", "allowfullscreen", "allow" ],
        "div" => [ "class" ]
      }.merge(Sanitize::Config::RELAXED[:attributes]),
      css: Sanitize::Config::RELAXED[:css],
      protocols: {
        "iframe" => { "src" => [ "http", "https" ] }
      }.merge(Sanitize::Config::RELAXED[:protocols])
    ))
  end

  class RougeHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_code(code, language)
      language ||= "text"
      formatter = Rouge::Formatters::HTMLLegacy.new(
        inline_theme: "github-dark"
      )
      lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText.new
      formatter.format(lexer.lex(code))
    end

    def paragraph(text)
      if youtube_url?(text)
        youtube_iframe(text)
      else
        "<p>#{text}</p>"
      end
    end

    private

    def youtube_url?(text)
      text.strip =~ %r{^https?://(?:www\.)?youtube\.com/watch\?v=([a-zA-Z0-9_-]+)(?:&\S*)?$} ||
      text.strip =~ %r{^https?://(?:www\.)?youtu\.be/([a-zA-Z0-9_-]+)(?:\?\S*)?$}
    end

    def youtube_iframe(text)
      uri = URI.parse(text.strip)
      video_id = if uri.host == "youtube.com"
                   text.match(/v=([a-zA-Z0-9_-]+)/)[1]
      elsif uri.host == "youtu.be"
                   text.match(/youtu\.be\/([a-zA-Z0-9_-]+)/)[1]
      else
                   nil
      end

      <<-HTML
        <div class="video-container my-4">
          <iframe
            src="https://www.youtube.com/embed/#{video_id}"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
          </iframe>
        </div>
      HTML
    end
  end
end

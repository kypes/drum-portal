module Api
  class MarkdownController < ApplicationController
    include MarkdownHelper


    def preview
      content = params[:content]
      rendered_html = markdown(content)
      render html: rendered_html.html_safe
    end
  end
end

module Api
  class MarkdownController < ApplicationController
    include MarkdownHelper
    skip_before_action :verify_authenticity_token, only: [ :preview ]

    def preview
      content = params[:content]
      rendered_html = markdown(content)
      render html: rendered_html.html_safe
    end
  end
end

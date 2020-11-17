# frozen_string_literal: true

class Bs5::InstallGenerator < Rails::Generators::Base
  def add_bootstrap
    run 'yarn add bootstrap@next popper.js'

    create_file 'app/javascript/packs/styles.scss', <<~HEREDOC
      @import "~bootstrap/scss/bootstrap";
    HEREDOC

    inject_into_file 'app/views/layouts/application.html.erb', before: '</head>' do
      <<~HEREDOC
        <%= stylesheet_pack_tag 'styles', media: 'all', 'data-turbolinks-track': 'reload' %>
      HEREDOC
    end

    inject_into_file 'app/controllers/application_controller.rb', after: "ActionController::Base\n" do
      <<~HEREDOC
        helper Bs5::Engine.helpers
      HEREDOC
    end

    append_file 'app/javascript/packs/application.js', <<~HEREDOC
      import "bootstrap";
    HEREDOC

    gsub_file 'config/webpacker.yml', 'extract_css: false', 'extract_css: true'
  end
end

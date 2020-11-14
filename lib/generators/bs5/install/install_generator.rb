# frozen_string_literal: true

class Bs5::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def install_stimulus
    rails_command 'webpacker:install:stimulus'
  end

  def add_bootstrap
    run 'yarn add bootstrap@next popper.js'
  end

  def update_and_configure_css
    create_file 'app/javascript/packs/styles.scss', <<~EOF
      @import "~bootstrap/scss/bootstrap";
    EOF

    inject_into_file 'app/views/layouts/application.html.erb', before: '</head>' do
      <<~ERB
        <%= stylesheet_pack_tag 'styles', media: 'all', 'data-turbolinks-track': 'reload' %>
      ERB
    end

    gsub_file 'config/webpacker.yml', 'extract_css: false', 'extract_css: true'
  end

  def stimulus_controller
    create_file 'app/javascript/controllers/alert_controller.js', <<~EOF
      import { Controller } from "stimulus";
      import Alert from "bootstrap/js/dist/alert";

      export default class extends Controller {
        connect() {
          new Alert(this.element);
        }
      }
    EOF
  end

  def add_snippet
    inject_into_file 'app/views/layouts/application.html.erb', before: '</body>' do
      <<~ERB
        <div
          class="alert alert-warning alert-dismissible fade show"
          role="alert"
          data-controller='alert'
          >
          <strong>Holy guacamole!</strong> You should check in on some of those fields below.
          <button type="button" class="btn-close" data-dismiss="alert" aria-label="Close"></button>
        </div>
      ERB
    end
  end
end

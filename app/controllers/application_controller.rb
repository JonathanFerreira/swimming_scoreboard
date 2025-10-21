class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  layout :layout_by_resource


  def layout_by_resource
    if devise_controller?
      "admin"
    else
      "application"
    end
  end
end

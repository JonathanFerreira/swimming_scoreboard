class Admin::SwimmerImportsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  def new
  end

  def create
    if params[:file].present? && params[:competition_id].present?
      Admin::SwimmerImportService.new(params[:file], params[:competition_id]).call
      redirect_to admin_swimmers_path, notice: 'Nadadores importados com sucesso!'
    else
      redirect_to new_admin_swimmer_import_path, alert: 'Por favor, selecione um arquivo e uma competição.'
    end
  end
end

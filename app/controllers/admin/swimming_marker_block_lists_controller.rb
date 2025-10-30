class Admin::SwimmingMarkerBlockListsController < ApplicationController
  layout 'admin'

  def index
    @swimming_marker_blocks = SwimmingMarkerBlock
      .joins(:swimming_marker_group, :proof, :competition, :category)
      .order("competitions.id ASC, proofs.id ASC, categories.id ASC, swimming_marker_blocks.position ASC")

    # Aplicar filtros
    if params[:competition_id].present?
      @swimming_marker_blocks = @swimming_marker_blocks.where(competitions: { id: params[:competition_id] })
    end

  end

  def show
    @swimming_marker_block = SwimmingMarkerBlock.find(params[:id])
  end

  def update_time
    @lane = SwimmingMarkerLane.find(params[:lane_id])

    if params[:recorded_time].present?
      begin
        # Usar o método helper do modelo
        @lane.recorded_time = @lane.recorded_time_from_string(params[:recorded_time])

        if @lane.save
          render json: {
            success: true,
            recorded_time: @lane.recorded_time_formatted,
            recorded_date: "Registrado hoje"
          }
        else
          render json: { success: false, errors: @lane.errors.full_messages }
        end
      rescue => e
        render json: { success: false, errors: ["Formato de tempo inválido"] }
      end
    else
      # Limpar o tempo se enviado vazio
      @lane.update(recorded_time: nil)
      render json: { success: true, recorded_time: nil }
    end
  end
end

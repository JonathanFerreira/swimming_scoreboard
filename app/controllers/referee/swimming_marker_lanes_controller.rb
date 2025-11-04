class Referee::SwimmingMarkerLanesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  def index
    # Converter lane para integer se necessário
    lane_number = current_user.lane.to_i

    swimming_marker_lanes = SwimmingMarkerLane
      .where(lane: lane_number)
      .includes(:swimmer, swimming_marker_block: { swimming_marker_group: [:proof, :category, { proof: :competition }] })
      .joins(swimming_marker_block: { swimming_marker_group: { proof: :competition } })
      .joins(swimming_marker_block: { swimming_marker_group: :category })
      .order("competitions.id ASC, proofs.id ASC, categories.id ASC, swimming_marker_blocks.position ASC")

    # Aplicar filtros
    if params[:proof_id].present?
      swimming_marker_lanes = swimming_marker_lanes.where(proofs: { id: params[:proof_id] })
    end

    if params[:category_id].present?
      swimming_marker_lanes = swimming_marker_lanes.where(categories: { id: params[:category_id] })
    end

    # Agrupar por prova e categoria
    @grouped_lanes = swimming_marker_lanes.group_by do |lane|
      {
        proof_id: lane.proof.id,
        proof_name: lane.proof_name_and_gender,
        category_id: lane.category.id,
        category_name: lane.category_name,
        competition_name: lane.competition_name
      }
    end
  end

  def update_time
    @lane = SwimmingMarkerLane.find(params[:id])

    # Verificar se o usuário tem permissão para editar esta lane
    unless @lane.lane.to_s == current_user.lane.to_s
      render json: { success: false, errors: ["Você não tem permissão para editar esta raia"] }, status: :forbidden
      return
    end

    if params[:recorded_time].present?
      begin
        # Usar o método helper do modelo
        @lane.recorded_time = @lane.recorded_time_from_string(params[:recorded_time])

        if @lane.save
          render json: {
            success: true,
            recorded_time: @lane.recorded_time_formatted
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

  def categories_by_proof
    proof = Proof.find(params[:proof_id])
    categories = proof.categories
    respond_to do |format|
      format.json { render json: categories.map { |category| { id: category.id, name: category.name } } }
    end
  end
end

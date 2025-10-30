class ResultsController < ApplicationController
  def index
    @competitions = Competition.includes(:proofs).all
  end

  def show
    @competition = Competition.find(params[:id])
    @proofs = @competition.proofs.includes(:categories, :swimming_marker_groups)

    # Agrupar resultados por prova e categoria
    @results_by_proof_category = {}

    @proofs.each do |proof|
      proof.swimming_marker_groups.includes(:category, swimming_marker_blocks: { swimming_marker_lanes: :swimmer }).each do |group|
        key = "#{proof.id}_#{group.category.id}"
        @results_by_proof_category[key] = {
          proof: proof,
          category: group.category,
          results: []
        }

        # Coletar todos os nadadores para esta prova/categoria (com e sem tempo)
        group.swimming_marker_blocks.each do |block|
          block.swimming_marker_lanes.each do |lane|
            @results_by_proof_category[key][:results] << {
              swimmer: lane.swimmer,
              time: lane.recorded_time,
              lane: lane.lane,
              position: nil # será calculado após ordenação
            }
          end
        end

        # Separar nadadores com tempo dos sem tempo
        results_with_time = @results_by_proof_category[key][:results].select { |result| result[:time].present? }
        results_without_time = @results_by_proof_category[key][:results].select { |result| result[:time].nil? }

        # Ordenar nadadores com tempo por tempo crescente
        results_with_time.sort_by! { |result| result[:time] }

        # Combinar: primeiro os com tempo (ordenados), depois os sem tempo
        @results_by_proof_category[key][:results] = results_with_time + results_without_time

        # Atribuir posições
        @results_by_proof_category[key][:results].each_with_index do |result, index|
          result[:position] = index + 1
        end
      end
    end
  end
end

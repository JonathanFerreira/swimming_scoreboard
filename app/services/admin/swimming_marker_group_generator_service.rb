class Admin::SwimmingMarkerGroupGeneratorService
  def initialize(competition_id)
    @competition_id = competition_id
  end

  def call
    competition = Competition.find(@competition_id)
    competition.proofs.each do |proof|
      proof.categories.each do |category|

        swimmers = proof
          .proof_category_swimmers
          .joins(:swimmer)
          .where(category: category, swimmers: { gender: proof.gender })
          .map(&:swimmer)


        log_empty_group(proof, category) and next if swimmers.empty?

        # puts "Criando grupo de balizamento para a prova #{proof.display_name} e categoria #{category.name}"
        swimming_marker_group = SwimmingMarkerGroup.create!(proof: proof, category: category)
        max_swimmers_per_group = proof.lane_quantity

        block_position = 1
        swimmers.each_slice(max_swimmers_per_group) do |group|
          # puts "Criando bloco #{block_position} para a prova #{proof.display_name} e categoria #{category.name}"
          swimming_marker_block = swimming_marker_group.swimming_marker_blocks.create!(position: block_position)
          lane_position = 1
          group.each do |swimmer|
            # puts "Criando raia #{lane_position  } para o bloco #{block_position} para o nadador #{swimmer.name}"
            swimming_marker_block.swimming_marker_lanes.create!(swimmer: swimmer, lane: lane_position)
            lane_position += 1
          end
          block_position += 1
        end
      end
    end
  end

  private

  def log_empty_group(proof, category)
    Rails.logger.info("Não há nadadores para a prova #{proof.display_name} e categoria #{category.name}")
  end
end

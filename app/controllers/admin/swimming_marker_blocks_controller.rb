class Admin::SwimmingMarkerBlocksController < ApplicationController
  layout 'admin'
  before_action :set_swimming_marker_block, only: %i[ edit update destroy ]
  before_action :set_swimming_marker_group

  # GET /swimming_marker_blocks/new
  def new
    @swimming_marker_block = @swimming_marker_group.swimming_marker_blocks.new
  end

  # GET /swimming_marker_blocks/1/edit
  def edit
  end

  # POST /swimming_marker_blocks or /swimming_marker_blocks.json
  def create
    @swimming_marker_block = @swimming_marker_group.swimming_marker_blocks.new(swimming_marker_block_params)

    respond_to do |format|
      if @swimming_marker_block.save
        format.html { redirect_to admin_swimming_marker_group_path(@swimming_marker_group), notice: "Swimming marker block was successfully created." }
        format.json { render :show, status: :created, location: @swimming_marker_block }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @swimming_marker_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swimming_marker_blocks/1 or /swimming_marker_blocks/1.json
  def update
    respond_to do |format|
      if @swimming_marker_block.update(swimming_marker_block_params)
        format.html { redirect_to admin_swimming_marker_group_path(@swimming_marker_group), notice: "Swimming marker block was successfully updated." }
        format.json { render :show, status: :ok, location: @swimming_marker_block }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @swimming_marker_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swimming_marker_blocks/1 or /swimming_marker_blocks/1.json
  def destroy
    @swimming_marker_block.destroy!

    respond_to do |format|
      format.html { redirect_to admin_swimming_marker_group_path(@swimming_marker_group), status: :see_other, notice: "Swimming marker block was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_swimming_marker_block
    @swimming_marker_block = SwimmingMarkerBlock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def swimming_marker_block_params
    params.require(:swimming_marker_block).permit(:swimming_marker_group_id, :position, swimming_marker_lanes_attributes: [:id, :swimmer_id, :lane, :_destroy])
  end

  def set_swimming_marker_group
    @swimming_marker_group = SwimmingMarkerGroup.find(params[:swimming_marker_group_id])
  end
end

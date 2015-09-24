class TagsController < ApplicationController
  before_action :set_tag, only: [:entry, :edit, :update, :destroy]

  def instances

    if defined? tag_params[:name]
      target_tag = Tag.find(:first, :conditions => ["name = ?", tag_params[:name]])

      unless defined? target_tag.id
        redirect_to pictures_path, flash: { notice: "Tag is Not Found." }
        return
      end

      redirect_to grouped_by_tag_pictures_path(target_tag.id)
      return
    end

    @tags = Tag.all
  end

  def entry
  end

  def new
    @tag = Tag.new
  end

#  # GET /tags/1/edit
#  def edit
#  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end

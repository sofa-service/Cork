class PicturesController < ApplicationController

  def instances
    @pictures = Picture.order("id DESC")
  end

  def entry
    @picture = Picture.find(params[:id])

    # add tag_names on picture object
    tag_ids = PictureTag.where([
      "picture_id = ?", @picture.id
    ]).pluck(:tag_id)
    @tags = Tag.find(tag_ids)

    # for new tag
    @tag = Tag.new

  end

  def grouped_by_tag
    @tag = Tag.find(params[:id])

    picture_ids = PictureTag.where([
      "tag_id = ?", @tag.id
    ]).pluck(:picture_id)

    @grouped_pictures = Picture.where(["id IN (?)", picture_ids]).order("id DESC")
  end

  def new
    @picture = Picture.new
  end

  def add_tag
    @picture = Picture.new({:url => picture_params[:url]})

    if @picture.valid?
    else
      render :add_tag, flash: { notice: @picture.errors.full_messages }
      return
    end
  end

  def create
    create_params = picture_params
    target_tag = Tag.find(:first, :conditions => ["name = ?", create_params[:tag_name]])

    unless defined? target_tag.id
      @tag = Tag.new({:name => picture_params[:tag_name]})
      @tag.save
      target_tag = @tag
    end

    @picture = Picture.new({
      :url       => picture_params[:url],
      :dangerous => picture_params[:dangerous]
    })

    if @picture.save
      target_tag.pictures << @picture
      redirect_to picture_path(@picture.id)
      return
    else
      target_picture = Picture.find(:first, :conditions => ["url = ?", @picture.url])
      if defined? target_picture.id
        redirect_to picture_path(target_picture.id), flash: { notice: 'same pic is already sticked!!' }
        return
      else
        redirect_to :back, flash: { error: @picture.errors.full_messages }
        return
      end
    end
  end

  private
    def picture_params
      params[:picture].permit(:url, :tag_name, :dangerous)
    end

end

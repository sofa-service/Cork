class PicturesController < ApplicationController

  def instances
    @pictures = Picture.all

    # add tag_name on picture object
    @pictures.each {|picture| picture.tag = Tag.find(picture.tag_id)}
  end

  def entry
    @picture = Picture.find(params[:id])
  end

  def grouped_by_tag
    @tag = Tag.find(params[:id])

    @grouped_pictures = Picture.find(:all, :conditions => { :tag_id => params[:id] })
  end

  def new
    @picture = Picture.new
  end

  def add_tag
    @picture = Picture.new({:url => picture_params[:url]})
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
      :tag_id    => target_tag.id,
      :dangerous => picture_params[:dangerous]
    })
    @picture.save
    redirect_to picture_path(@picture.id)
  end

  def picture_params
    params[:picture].permit(:url, :tag_name, :dangerous)
  end

end

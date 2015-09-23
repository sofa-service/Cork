class PicturesController < ApplicationController

  def instances
    @pictures = Picture.all

    # add tag_name on picture object
    @pictures.each {|picture| picture.tag = Tag.find(picture.tag_id)}
  end

  def entry
    @picture = Picture.find(params[:id])
  end

  def group_by_tag
    @tag = Tag.find(params[:id])

    @grouped_pictures = Picture.find(:all, :conditions => { :tag_id => params[:id] })
  end

end

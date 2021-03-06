class PhotosController < ApplicationController
  def create 
    @room = Room.find(params[:room_id])

    if params[:images]
      params[:images].each do |img|
        @room.photos.create(image: img)
      end

      @photos = @room.photos
      redirect_to :back, notice: 'Saved...'
    end
  end

  def destroy 
    @photo = Photo.find(params[:id])
    @room = @photo.room

    @photo.destroy
    @photos = Photo.where(room_id: @room)

    respond_to :js
  end
end
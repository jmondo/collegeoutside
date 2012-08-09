class RedactorRails::PicturesController < ApplicationController
  before_filter :authorize_writer!
  def index
    @pictures = RedactorRails.picture_model.find_all({writer_id: current_user.id})
    render json: @pictures.to_json
  end

  def create
    @picture = RedactorRails::Picture.new

    file = params[:file]
    @picture.data = RedactorRails::Http.normalize_param(file, request)
    @picture.writer_id = current_user.id

    if @picture.save
      render text: { filelink: @picture.url }.to_json
    else
      render nothing: true
    end
  end

  protected

  def authorize_writer!
    authorize! :show, :writer_dashboard
  end
end

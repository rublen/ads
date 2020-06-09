class AdsController < ApplicationController
  get '/' do
    ads = ::Ad.order(updated_at: :desc)
    serializer = AdSerializer.new(ads)

    json serializer, json_encoder: :serialized_json
  end

  post '/ads' do
    result = CreateService.call(
      ad: ad_params,
      user_id: params[:user_id]
    )

    if result.success?
      status 201
      serializer = AdSerializer.new(result.ad)
      json serializer, json_encoder: :serialized_json
    else
      error_response(result.ad, :unprocessable_entity)
    end
  end

  private

  def ad_params
    params[:ad]&.slice(:title, :description, :city)
  end
end

class AdsController < ApplicationController
  get '/ads' do
    'Ads List'
    ads = ::Ad.order(updated_at: :desc)
    serializer = AdSerializer.new(ads)

    json serializer.serialized_json
  end

  post '/ads' do
    result = CreateService.call(
      ad: ad_params,
      user_id: params[:user_id]
    )

    if result.success?
      serializer = AdSerializer.new(result.ad)
      json serializer.serialized_json, status: :created
    else
      error_response(result.ad, :unprocessable_entity)
    end
  end

  private

  def ad_params
    params[:ad].slice(:title, :description, :city)
  end
end


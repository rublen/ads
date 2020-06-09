require 'spec_helper'

RSpec.describe 'Ads API', type: :request do
  let(:app) { AdsController.new }
  let(:user_id) { 12 }

  describe 'GET /' do
    let(:response) { get '/' }

    before { create_list(:ad, 3, user_id: user_id) }

    it 'runs successfully' do
      expect(response.status).to eq 200
    end

    it 'returns a collection of ads' do
      expect(JSON.parse(response.body)['data'].size).to eq(3)
    end
  end

  describe 'POST /ads (valid auth token)' do
    let(:response) { post '/ads', { ad: ad_params, user_id: user_id } }
    let(:ad_params) { {} }

    context 'missing parameters' do
      it 'returns an error' do
        expect(response.status).to eq 422
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to include(
          {
            'detail' => "can't be blank",
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/ads', { ad: ad_params, user_id: user_id } }
          .to change { Ad.count }.from(0).to(1)

        expect(response.status).to eq 201
      end

      it 'returns an ad' do
        post '/ads', { ad: ad_params, user_id: user_id }

        expect(JSON.parse(response.body)['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do

  describe 'バリデーション' do
    context '#index' do
      it 'valid' do
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end
end

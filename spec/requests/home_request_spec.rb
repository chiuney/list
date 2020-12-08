require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "#index" do

    it "正常にレスポンスを返す" do
      get "/"
      expect(response).to have_http_status(200)
    end

  end
end

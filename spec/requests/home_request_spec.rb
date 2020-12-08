require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "#index" do

    it "200レスポンスを返す" do
      get root_path
      expect(response).to have_http_status(200)
    end

  end
end

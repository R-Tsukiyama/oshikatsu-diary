require 'rails_helper'

RSpec.describe "PostCreation", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end
  
  it "ユーザーは新しい投稿を作成できること" do
 
  end
end

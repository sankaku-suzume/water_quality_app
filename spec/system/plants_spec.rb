require 'rails_helper'

RSpec.describe 'Plants', type: :system do
  let!(:user) { create(:user, admin: true) }
  let!(:plants) { create_list(:plant, 3) }
  let!(:plant) { create(:plant, :with_sample) }

  before do
    sign_in user
  end

  it '事業場一覧が表示される' do
    visit plants_path
    plants.each do |plant|
      expect(page).to have_css('.plants-table_name', text: plant.name)
    end
  end

  it '事業場詳細が表示される' do
    visit plants_path

    click_on plant.name

    expect(page).to have_css('.plant-info_name', text: plant.name)
    expect(page).to have_content(plant.samples.first.sampling_date.strftime('%Y/%m/%d'))
  end
end

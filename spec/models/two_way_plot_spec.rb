require 'rails_helper'

RSpec.describe TwoWayPlot, :type => :model do
  describe 'model validations' do
    describe 'title' do
      it 'requires a title' do
        expect(FactoryGirl.build(:two_way_plot, title: nil)).not_to be_valid
      end
    end

    describe 'independent_name' do
      it 'requires an independent_name' do
        expect(
          FactoryGirl.build(:two_way_plot, independent_name: nil)
        ).not_to be_valid
      end
    end

    describe 'moderator_name' do
      it 'requires a moderator_name' do
        expect(
          FactoryGirl.build(:two_way_plot, moderator_name: nil)
        ).not_to be_valid
      end
    end

    describe 'order and project_id uniqueness' do
      let(:two_way_plot) { FactoryGirl.create(:two_way_plot) }

      it 'will be valid if an order is used more than once' do
        expect(
          FactoryGirl.build(:two_way_plot, order: two_way_plot.order)
        ).to be_valid
      end

      it 'will be valid if a project_id is used more than once' do
        expect(
          FactoryGirl.build(:two_way_plot, project_id: two_way_plot.project_id)
        ).to be_valid
      end

      it 'requires the combination of order and project_id to be unique' do
        expect(
          FactoryGirl.build(
            :two_way_plot,
            order: two_way_plot.order,
            project_id: two_way_plot.project_id
          )
        ).not_to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to a project' do
      expect(
        TwoWayPlot.reflect_on_association(:project).macro
      ).to eq :belongs_to
    end
  end
end

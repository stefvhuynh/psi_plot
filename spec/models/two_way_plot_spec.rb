require 'rails_helper'

RSpec.describe TwoWayPlot, :type => :model do
  describe 'model validations' do
    describe 'title' do
      it 'requires a title' do
        expect(FactoryGirl.build(:two_way_plot, title: nil)).not_to be_valid
      end
    end

    describe 'independent_variable' do
      it 'requires an independent_variable' do
        expect(
          FactoryGirl.build(:two_way_plot, independent_variable: nil)
        ).not_to be_valid
      end
    end

    describe 'moderator_variable' do
      it 'requires a moderator_variable' do
        expect(
          FactoryGirl.build(:two_way_plot, moderator_variable: nil)
        ).not_to be_valid
      end
    end

    describe 'dependent_variable' do
      it 'requires a dependent_variable' do
        expect(
          FactoryGirl.build(:two_way_plot, dependent_variable: nil)
        ).not_to be_valid
      end
    end

    describe 'independent_coefficient' do
      it 'requires a independent_coefficient' do
        expect(
          FactoryGirl.build(:two_way_plot, independent_coefficient: nil)
        ).not_to be_valid
      end
    end

    describe 'moderator_coefficient' do
      it 'requires a moderator_coefficient' do
        expect(
          FactoryGirl.build(:two_way_plot, moderator_coefficient: nil)
        ).not_to be_valid
      end
    end

    describe 'interaction_coefficient' do
      it 'requires a interaction_coefficient' do
        expect(
          FactoryGirl.build(:two_way_plot, interaction_coefficient: nil)
        ).not_to be_valid
      end
    end

    describe 'intercept' do
      it 'requires a intercept' do
        expect(
          FactoryGirl.build(:two_way_plot, intercept: nil)
        ).not_to be_valid
      end
    end

    describe 'independent_mean' do
      it 'requires a independent_mean' do
        expect(
          FactoryGirl.build(:two_way_plot, independent_mean: nil)
        ).not_to be_valid
      end
    end

    describe 'independent_sd' do
      it 'requires a independent_sd' do
        expect(
          FactoryGirl.build(:two_way_plot, independent_sd: nil)
        ).not_to be_valid
      end
    end

    describe 'moderator_mean' do
      it 'requires a moderator_mean' do
        expect(
          FactoryGirl.build(:two_way_plot, moderator_mean: nil)
        ).not_to be_valid
      end
    end

    describe 'moderator_sd' do
      it 'requires a moderator_sd' do
        expect(
          FactoryGirl.build(:two_way_plot, moderator_sd: nil)
        ).not_to be_valid
      end
    end

    describe 'order' do
      it 'requires a order' do
        expect(
          FactoryGirl.build(:two_way_plot, order: nil)
        ).not_to be_valid
      end
    end

    describe 'project_id' do
      it 'requires a project_id' do
        expect(
          FactoryGirl.build(:two_way_plot, project_id: nil)
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

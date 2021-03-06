require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe 'model validations' do
    describe 'name' do
      it 'requires a name' do
        expect(FactoryGirl.build(:project, name: nil)).not_to be_valid
      end
    end

    describe 'order' do
      it 'requires an order' do
        expect(FactoryGirl.build(:project, order: nil)).not_to be_valid
      end

      it 'requires the orders to be unique for each set of user projects' do
        user = FactoryGirl.create(:user)
        project1 = FactoryGirl.create(:project, user: user)
        project2 = FactoryGirl.build(
          :project,
          user: user,
          order: project1.order
        )
        expect(project2).not_to be_valid

        project2.order = project1.order + 1
        expect(project2).to be_valid
      end

      it 'does not enforce the uniquness requirement across users' do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        project1 = FactoryGirl.create(:project, user: user)
        project2 = FactoryGirl.build(
          :project,
          user: user2,
          order: project1.order
        )

        expect(project2).to be_valid
      end
    end

    describe 'description' do
      it 'has a maximum length of 150 characters' do
        long_description = 'x' * 151
        just_right_description = 'x' * 150

        expect(
          FactoryGirl.build(:project, description: long_description)
        ).not_to be_valid

        expect(
          FactoryGirl.build(:project, description: just_right_description)
        ).to be_valid
      end
    end

    describe 'user_id' do
      it 'requires a user_id' do
        expect(FactoryGirl.build(:project, user_id: nil)).not_to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(Project.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'has many project_shares' do
      expect(
        Project.reflect_on_association(:project_shares).macro
      ).to eq :has_many
    end

    it 'has many shared_users' do
      expect(
        Project.reflect_on_association(:shared_users).macro
      ).to eq :has_many
    end

    it 'has many two_way_plots' do
      expect(
        Project.reflect_on_association(:two_way_plots).macro
      ).to eq :has_many
    end

    describe '#all_plots' do
      it 'fetches all plots in the correct order' do
        project = FactoryGirl.create(:project)
        two_way_plot1 = FactoryGirl.create(
          :two_way_plot,
          project_id: project.id,
          order: 2
        )
        two_way_plot2 = FactoryGirl.create(
          :two_way_plot,
          project_id: project.id,
          order: 1
        )

        expect(
          project.all_plots
        ).to eq [two_way_plot2, two_way_plot1]
      end
    end
  end
end

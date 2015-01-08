require 'rails_helper'

RSpec.describe ProjectShare, :type => :model do
  describe 'model validations' do
    describe 'project_id' do
      it 'requires a project_id' do
        expect(
          FactoryGirl.build(:project_share, project_id: nil)
        ).not_to be_valid
      end
    end

    describe 'user_id' do
      it 'requires a user_id' do
        expect(
          FactoryGirl.build(:project_share, user_id: nil)
        ).not_to be_valid
      end
    end

    describe 'project_id and user_id uniqueness' do
      let(:project_share) { FactoryGirl.create(:project_share) }

      it 'will be valid if a project_id is used more than once' do
        expect(
          FactoryGirl.build(:project_share, project_id: project_share.project_id)
        ).to be_valid
      end

      it 'will be valid if a user_id is used more than once' do
        expect(
          FactoryGirl.build(:project_share, user_id: project_share.user_id)
        ).to be_valid
      end

      it 'requires the combination of project_id and user_id to be unique' do
        expect(
          FactoryGirl.build(
            :project_share,
            project_id: project_share.project_id,
            user_id: project_share.user_id
          )
        ).not_to be_valid
      end
    end

    describe 'association validations' do
      it 'requires the existence of the project' do
        project = FactoryGirl.create(:project)
        expect(
          FactoryGirl.build(:project_share, project_id: project.id + 1)
        ).not_to be_valid
      end

      it 'requires the existence of the user' do
        user = FactoryGirl.create(:user)
        expect(
          FactoryGirl.build(:project_share, user_id: user.id + 2)
        ).not_to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to a project' do
      expect(
        ProjectShare.reflect_on_association(:project).macro
      ).to eq :belongs_to
    end

    it 'belongs to a user' do
      expect(ProjectShare.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end

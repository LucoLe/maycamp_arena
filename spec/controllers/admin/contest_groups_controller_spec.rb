describe Admin::ContestGroupsController do
  context "without a logged-in user" do
    describe "#index" do
      before do
        get :index
      end

      it { is_expected.to redirect_to(new_session_path) }
    end
  end

  shared_examples "accessed by authorized user" do
    describe "#index" do
      before { get :index }

      it { is_expected.to respond_with(:success) }
    end

    describe "#new" do
      before { get :new }

      it { is_expected.to respond_with(:success) }
    end

    describe "#show" do
      let(:contest_group) { create(:contest_group) }
      before { get :show, id: contest_group.id }

      it { is_expected.to respond_with(:success) }
    end

    describe "#create" do
      let(:contest_group_params) { attributes_for(:contest_group) }
      before { post :create, contest_group: contest_group_params }

      it { is_expected.to redirect_to(admin_contest_groups_path) }
    end

    describe "#edit" do
      let(:contest_group) { create(:contest_group) }
      before { get :edit, id: contest_group.id }

      it { is_expected.to respond_with(:success) }
    end

    describe "#update" do
      let(:contest_group) { create(:contest_group) }
      let(:new_name) { "test test test" }
      before { put :update, id: contest_group.id, contest_group: { name: new_name } }

      it { is_expected.to redirect_to(admin_contest_groups_path) }

      it "changes the name of the contest group" do
        expect(contest_group.reload.name).to eq(new_name)
      end
    end

    describe "#destroy" do
      let(:contest_group) { create(:contest_group) }
      before { delete :destroy, id: contest_group.id }

      it { is_expected.to redirect_to(admin_contest_groups_path) }

      it "deletes the contest group" do
        expect(ContestGroup.find_by_id(contest_group.id)).to be_nil
      end
    end
  end

  context "with an admin user" do
    before { sign_in(user) }

    let(:user) { create(:user, role: User::ADMIN) }

    it_behaves_like "accessed by authorized user"

  end


  context "with a coach user" do
    before { sign_in(user) }

    let(:user) { create(:user, role: User::COACH) }

    it_behaves_like "accessed by authorized user"

  end
end

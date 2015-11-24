describe ContestGroupPolicy do
  let(:contest_group) { create(:contest_group) }
  let(:admin) { create(:user, role: User::ADMIN) }
  let(:coach) { create(:user, role: User::COACH) }
  let(:contester) { create(:user, role: User::CONTESTER) }

  [
    :index?, :new?, :create?, :edit?, :update?,
    :destroy?, :show?
  ].each do |action|
    permissions action do
      it "denies access to anonymous users" do
        expect(ContestGroupPolicy).not_to permit(nil, contest_group)
      end

      it "denies access to contesters" do
        expect(ContestGroupPolicy).not_to permit(contester, contest_group)
      end

      it "allows access to admins" do
        expect(ContestGroupPolicy).to permit(admin, contest_group)
      end

      it "allows access to coaches" do
        expect(ContestGroupPolicy).to permit(coach, contest_group)
      end
    end
  end

end

class AddContestGroupToContests < ActiveRecord::Migration
  def change
    add_reference :contests, :contest_group, index: true
    add_foreign_key :contests, :contest_groups
  end
end

class AddContestGroupIdToContests < ActiveRecord::Migration
  def up

    ContestGroup.create(name: "Други")
    ContestGroup.create(name: "Арена")
    ContestGroup.create(name: "Сезонни турнири")
    ContestGroup.create(name: "НОИ")

    Contest.all.each do |contest|
      case contest.name
      when /Арена/
        contest.contest_group_id = ContestGroup.find_by(name: "Арена")
      when /(Пролетен)|(Летен)|(Есенен)|(Зимен)/
        contest.contest_group_id = ContestGroup.find_by(name: "Сезонни турнири")
      when /НОИ/
        contest.contest_group_id = ContestGroup.find_by(name: "НОИ")
      else
        contest.contest_group_id = ContestGroup.find_by(name: "Други")
      end
    end

    change_column :contests, :contest_group_id, false

  end

  def down
    remove_column :contests, :contest_group_id
    ContestGroup.find_by(name: "Други").destroy
    ContestGroup.find_by(name: "Арена").destroy
    ContestGroup.find_by(name: "Сезонни турнири").destroy
    ContestGroup.find_by(name: "НОИ").destroy
  end
end

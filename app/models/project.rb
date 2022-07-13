class Project < ApplicationRecord
  has_many :tasks , :dependent => :destroy
  belongs_to :user , :optional => true

    def status
      return "not-started" if tasks.none?

      if tasks.all? { |task| task.complete? }
        "complete"
      elsif tasks.any? { |task| task.in_progress? || task.complete? }
        "in-progress"
      else
        "not-started"
      end
    end

  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    when 'complete'
      'success'
    end
  end

  def percent_complete
    return  if tasks.none?

    ((total_complete.to_f/tasks.count)*100).round
  end

  def total_complete
    tasks.select { |task| task.complete? }.count
  end

  def total_tasks
    tasks.count
  end


end

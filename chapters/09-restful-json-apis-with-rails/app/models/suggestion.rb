class Suggestion < ActiveRecord::Base
  attr_accessible :subject, :message

  def as_json(options={})
    super({only: [:id, :subject, :message]}.merge(options))
  end
end

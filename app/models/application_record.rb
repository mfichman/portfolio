class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def humanize
    to_param
  end
end

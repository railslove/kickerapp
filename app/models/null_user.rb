# frozen_string_literal: true

class NullUser
  def update_attribute(*_args)
    true
  end
end
